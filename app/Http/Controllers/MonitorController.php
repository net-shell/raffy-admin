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
            ->limit(30)
            ->skip($skip)
            ->orderBy('exited_at', 'desc')
            ->get());
    }
}
