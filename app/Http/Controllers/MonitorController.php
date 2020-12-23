<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Http\Resources\Log as LogResource;
use App\Log;

class MonitorController extends BaseController
{
    public function index(Request $request) {
        return view('monitor');
    }

    public function logs(\Illuminate\Http\Request $request) {
        $skip = (int)$request->input('skip', 0);
        return new LogResource(Log::query()
            ->orderByRaw('CASE WHEN exited_at IS NULL THEN TIMESTAMP(DATE(created_at), "00:00:00") ELSE exited_at END DESC')
            //->orderBy('exited_at')
            ->limit(40)
            ->skip($skip)
            ->get());
    }
}
