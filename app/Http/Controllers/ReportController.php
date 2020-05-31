<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;
use App\Log;
use App\Tag;
use App\Reader;
use App\User;
use Carbon\Carbon;

class ReportController extends BaseController
{
    public function index(Request $request) {
        return view('reports');
    }

    public function reportJson(Request $request) {
        $filter = json_decode($request->getContent(), true);
        $tsFrom = new Carbon($filter['from']);
        $tsTo = new Carbon($filter['to']);
        $stats = Log::selectRaw('user_id, SUM(TIMESTAMPDIFF(SECOND, created_at, exited_at)) as seconds')->whereNotNull('exited_at');
        if($filter['from']) {
            $stats->where('created_at', '>=', $tsFrom->format('Y-m-d 00:00:00'));
        }
        if($filter['to']) {
            $stats->where('created_at', '<=', $tsTo->format('Y-m-d 23:59:59'));
        }
        if($filter['user']) {
            $stats->where('user_id', $filter['user']);
        }
        $stats = $stats->groupBy('user_id')->get();
        foreach($stats as &$stat) {
            $stat->user = User::find($stat->user_id);
            if(!$filter['from']) continue;
            $stat->from = $tsFrom->format('d/m/Y');
            if(!$filter['to']) continue;
            $stat->to = $tsTo->format('d/m/Y');
        }
        return $stats->toArray();
    }
}
