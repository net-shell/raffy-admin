<?php

namespace App\Exports;

use App\Log;
use App\User;
use Carbon\Carbon;
use Date;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithHeadings;

class LogsExport implements FromCollection, WithMapping, WithHeadings
{
    public $filter;

    public function __construct($filter)
    {
        $this->filter = $filter;
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        $tsFrom = new Carbon($this->filter['from']);
        $usersFiltered = $this->filter['users'];
        if(!$usersFiltered || count($usersFiltered) == 0) {
            $usersFiltered = User::query()
                ->select(['id', 'name AS text'])
                ->get()->toArray();
        }
        $report = [];
        $totals = [];
        foreach ($usersFiltered as $user) {
            $report[$user['id']] = [$user['text']];
            $totals[$user['id']] = 0;
        }

        // Iterate each day of the period
        for($d=0; $d<$this->getDuration(); $d++) {
            $tsCurrent = $tsFrom->copy()->addDays($d);
            // Prepare report query for the current day
            $stats = Log::selectRaw('user_id, DATE(created_at) as log_date, SUM(TIMESTAMPDIFF(SECOND, created_at, exited_at)) as seconds')
                ->with('user')
                ->whereNotNull('exited_at');
            if ($this->filter['from']) {
                $stats->where('created_at', '>=', $tsCurrent->format('Y-m-d 00:00:00'));
                $stats->where('created_at', '<=', $tsCurrent->format('Y-m-d 23:59:59'));
            }
            if ($this->filter['users'] && count($this->filter['users'])) {
                $stats->whereIn('user_id', $this->filter['users']);
            }
            if ($this->filter['reader']) {
                $stats->where('reader_id', $this->filter['reader']);
            }
            $results = $stats->groupByRaw('user_id, DATE(created_at)')
                ->get()->toArray();
            // Add logs for day
            foreach ($usersFiltered as $user) {
                $uid = $user['id'];
                foreach ($results as $r) {
                    if($r['user_id'] != $uid) continue;
                    $seconds = $r['seconds'];
                    $report[$uid][$d + 2] = $seconds;
                    $totals[$uid] += $seconds;
                }
            }
            // Add zeros
            $usersForDay = array_map(function($r) {
                return $r['user_id'];
            }, $results);
            $allUserIds = array_map(function($r) {
                return $r['id'];
            }, $usersFiltered);
            $usersAbsent = array_diff($allUserIds, $usersForDay);
            foreach($usersAbsent as $u) {
                $report[$u][$d + 2] = 0;
            }
        }
        // Add total
        foreach ($totals as $u => $total) {
            $report[$u][] = $total;
        }
        // Strip off keys and return
        $report = array_map(function($r) {
           return array_values($r);
        }, $report);
        return collect(array_values($report));
    }

    /**
    * @var $item
    */
    public function map($item): array
    {
        $tsFrom = new Carbon($this->filter['from']);
        $vals = [$item[0]];
        for($d=0; $d<=$this->getDuration(); $d++) {;
            $vals[] = round(($item[$d + 1] / 3600), 2);
        }
        return $vals;
    }

    public function headings(): array
    {
        $tsFrom = new Carbon($this->filter['from']);
        $texts = ['Служител'];
        for($d=0; $d<$this->getDuration(); $d++) {
            $tsCurrent = $tsFrom->copy()->addDays($d);
            $texts[] = $tsCurrent->format('d/m/y');
        }
        $texts[] = 'Общо';
        return $texts;
    }

    private function getDuration()
    {
        $tsFrom = new Carbon($this->filter['from']);
        $tsTo = new Carbon($this->filter['to']);
        return $tsFrom->diffInDays($tsTo) + 1;
    }
}
