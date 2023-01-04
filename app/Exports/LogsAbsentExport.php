<?php

namespace App\Exports;

use App\Log;
use App\User;
use Carbon\Carbon;
use Date;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class LogsAbsentExport extends LogsBase implements FromCollection, WithHeadings
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
        if (!$usersFiltered || empty($usersFiltered)) {
            $usersFiltered = User::query()
                ->select(['id', 'name'])
                ->get()->toArray();
        }
        $report = [];

        // Iterate each day of the period
        for ($d = 0; $d < $this->getDuration(); $d++) {
            $tsCurrent = $tsFrom->copy()->addDays($d);
            
            $dateCurrent = $tsCurrent->format('Y-m-d');
            $present = Log::whereRaw("DATE(created_at) = '$dateCurrent'" )
                ->pluck('user_id')->toArray();
            $absent = User::whereNotIn('id', $present)
                ->pluck('id')->toArray();
                
            foreach ($usersFiltered as $u => $user) {
                if (array_search($user['id'], $absent)) {
                    $report[$u][$d] = $user['name'];
                }
            }
        }
        // Strip off keys and return
        return collect(array_values($report));
    }

    public function headings(): array
    {
        $tsFrom = new Carbon($this->filter['from']);
        $texts = [];
        for ($d = 0; $d < $this->getDuration(); $d++) {
            $tsCurrent = $tsFrom->copy()->addDays($d);
            $texts[] = $tsCurrent->format('d/m/y');
        }
        return $texts;
    }
}
