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
        $tsTo = new Carbon($this->filter['to']);
        $stats = Log::selectRaw('user_id, SUM(TIMESTAMPDIFF(SECOND, created_at, exited_at)) as seconds')->whereNotNull('exited_at');
        if($this->filter['from']) {
            $stats->where('created_at', '>=', $tsFrom->format('Y-m-d 00:00:00'));
        }
        if($this->filter['to']) {
            $stats->where('created_at', '<=', $tsTo->format('Y-m-d 23:59:59'));
        }
        if($this->filter['user']) {
            $stats->where('user_id', $this->filter['user']);
        }
        if($this->filter['reader']) {
            $stats->where('reader_id', $this->filter['reader']);
        }
        $stats = $stats->groupBy('user_id')->get();
        foreach($stats as &$stat) {
            $stat->user = User::find($stat->user_id);
            if(!$this->filter['from']) continue;
            $stat->from = $tsFrom->format('d/m/Y');
            if(!$this->filter['to']) continue;
            $stat->to = $tsTo->format('d/m/Y');
        }
        return $stats;
    }

    /**
    * @var $item
    */
    public function map($item): array
    {
        return [
            $item->user->name,
            $item->from,
            $item->to,
            round(($item->seconds / 3600), 2)
        ];
    }

    public function headings(): array
    {
        return [
            'Служител',
            'От дата',
            'До дата',
            'Часове',
        ];
    }
}
