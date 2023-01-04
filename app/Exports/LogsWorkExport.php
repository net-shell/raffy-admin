<?php

namespace App\Exports;

use App\Log;
use App\User;
use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class LogsWorkExport extends LogsBase implements FromCollection, WithHeadings
{
    /**
     * @return \Illuminate\Support\Collection
     */
    public function collection()
    {
        date_default_timezone_set('UTC');
        $tsFrom = new Carbon($this->filter['from']);
        $usersFiltered = $this->filter['users'];
        $section = $this->filter['section'];
        if (!$usersFiltered && $section && $section['id']) {
            $usersFiltered = User::query()
                ->select(['id', 'name'])
                ->whereSectionId($section['id'])
                ->get()->toArray();
        }
        if (!$usersFiltered || count($usersFiltered) == 0) {
            $usersFiltered = User::query()
                ->select(['id', 'name'])
                ->get()->toArray();
        }
        $report = [];
        $totals = [];
        foreach ($usersFiltered as $user) {
            $report[$user['id']] = [$user['name']];
            $totals[$user['id']] = 0;
        }

        // Iterate each day of the period
        for ($d = 0; $d < $this->getDuration(); $d++) {
            $tsCurrent = $tsFrom->copy()->addDays($d);
            // Prepare report query for the current day
            $stats = Log::selectRaw('user_id, DATE(created_at) as log_date, SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, created_at, exited_at))) as timing')
                ->with('user')
                ->whereNotNull('exited_at');
            if ($this->filter['from']) {
                $stats->where('created_at', '>', $tsCurrent->format('Y-m-d 00:00:00'));
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
                    if ($r['user_id'] != $uid) continue;
                    $timing = substr($r['timing'], 0, 5);
                    $report[$uid][$d + 2] = $timing;
                    $numSec = strtotime("1970-01-01 $timing");
                    if (!$numSec) continue;
                    $totals[$uid] += $numSec;
                }
            }
            // Add zeros
            $usersForDay = array_map(function ($r) {
                return $r['user_id'];
            }, $results);
            $allUserIds = array_map(function ($r) {
                return $r['id'];
            }, $usersFiltered);
            $usersAbsent = array_diff($allUserIds, $usersForDay);
            foreach ($usersAbsent as $u) {
                $report[$u][$d + 2] = 0;
            }
        }
        // Add total
        foreach ($totals as $u => $total) {
            $minutes = round($total / 60);
            $hours = floor($minutes / 60);
            if ($minutes > 0) {
                $minutes -= $hours * 60;
                $minutes = str_pad($minutes, 2, '0');
                $report[$u][] = "$hours:$minutes";
            } else {
                $report[$u][] = 0;
            }
        }
        // Strip off keys and return
        $report = array_map(function ($r) {
            return array_values($r);
        }, $report);
        return collect(array_values($report));
    }
    
    public function headings(): array
    {
        $tsFrom = new Carbon($this->filter['from']);
        $texts = ['Служител'];
        for ($d = 0; $d < $this->getDuration(); $d++) {
            $tsCurrent = $tsFrom->copy()->addDays($d);
            $texts[] = $tsCurrent->format('d/m/y');
        }
        $texts[] = 'Общо';
        return $texts;
    }
}
