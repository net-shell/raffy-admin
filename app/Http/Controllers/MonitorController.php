<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;
use App\Log;
use App\Tag;
use App\Reader;
use App\User;

class MonitorController extends BaseController
{
    public function index(Request $request) {
        $logs = Log::with(['user', 'reader', 'tag'])->orderBy('created_at', 'desc')->limit(5)->get();
        return view('monitor', compact('logs'));
    }
}
