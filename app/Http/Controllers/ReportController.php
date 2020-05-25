<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;
use App\Log;
use App\Tag;
use App\Reader;
use App\User;

class ReportController extends BaseController
{
    public function index(Request $request) {
        return view('reports');
    }
}
