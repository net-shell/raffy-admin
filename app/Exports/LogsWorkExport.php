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
            $stats = Log::selectRaw('user_id, created_at, exited_at, DATE(created_at) as log_date, SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, created_at, exited_at))) as timing')
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
            $results = $stats
                ->groupByRaw('user_id, log_date, created_at, exited_at')
                ->orderBy('created_at', 'asc')
                ->get()->toArray();

            // Add logs for day
            foreach ($usersFiltered as $user) {
                $uid = $user['id'];
                foreach ($results as $r) {
                    if ($r['user_id'] != $uid) continue;
                    $timing = substr($r['timing'], 0, 5);
                    $timingSec = strtotime("1970-01-01 $r[timing]");
                    // Calculate next start time diff
                    $startTime = substr($r['created_at'], 11, 5);
                    $endTime = substr($r['exited_at'], 11, 5);
                    $demean = 0;

                    //
                    $startDiff = $this->diffToNextPoint($startTime);
                    if ($startDiff < 0) $demean += $startDiff;  
                    $endDiff = $this->diffToNextPoint($endTime, 1);
                    if ($endDiff < 0) $demean += $endDiff;
                    //dd($demean, $startTime, $startDiff, $endTime, $endDiff);

                    // Add total to column
                    $report[$uid][$d + 2] = date('H:i', $timingSec);
                    // Add time to day total sum
                    $numSec = strtotime("1970-01-01 $timing");
                    if (!$numSec) continue;
                    $totals[$uid] += $numSec + $demean;
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
            if ($total > 0) {
                $report[$u][] = date('H:i', $total);
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

    public function diffToNextPoint($time, $i = 0)
    {
        $workDay = [
            setting('site.workday_start'),
            setting('site.workday_end')
        ];
        $workBreaks = explode('|', setting('site.work_breaks'));
        $workBreaks = array_map(function ($break) {
            return explode('-', $break);
        }, $workBreaks);

        $diff = 0;

        $diffStart = $this->timeDiff($time, $workDay[0]);
        $diffEnd = $this->timeDiff($time, $workDay[1]);
        
        if ($diffStart < 0)
            $diff += $diffStart;
        if ($diffEnd > 0)
            $diff -= $diffEnd;

        foreach ($workBreaks as $break) {
            $diffStart = min($diffStart, $this->timeDiff($time, $break[0]));
            $diffEnd = max($diffEnd, $this->timeDiff($time, $break[1]));
            
            if ($diffStart < 0)
                $diff += $diffStart;
            if ($diffEnd > 0)
                $diff -= $diffEnd;

            var_dump($break, $diff, !$i ? $diffStart : $diffEnd);
        }

        var_dump((bool)$i, $time, $diff, !$i ? $diffStart : $diffEnd);

        return $diff;
    }

    public function timeDiff($a, $b) {
        $secA = strtotime("1970-01-01 $a:00");
        $secB = strtotime("1970-01-01 $b:00");
        return $secB - $secA;
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
}//
