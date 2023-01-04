<?php

namespace App\Exports;

use Carbon\Carbon;

class LogsBase
{
    public function __construct(protected $filter)
    {
    }

    protected function getDuration()
    {
        $tsFrom = new Carbon($this->filter['from']);
        $tsTo = new Carbon($this->filter['to']);
        return $tsFrom->diffInDays($tsTo) + 1;
    }
}
