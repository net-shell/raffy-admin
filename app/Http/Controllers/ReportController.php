<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Exports\LogsExport;
use Excel;

class ReportController extends BaseController
{
    public $filter;

    public function __construct(Request $request)
    {
        $this->filter = json_decode($request->getContent(), true);
    }

    public function index(Request $request) {
        return view('reports');
    }

    public function reportJson(Request $request) {
        $stats = (new LogsExport($this->filter))->collection();
        return $stats->toArray();
    }
    
    public function reportExcel(Request $request) {
        return Excel::download(new LogsExport($this->filter), 'report.xls', \Maatwebsite\Excel\Excel::XLS);
    }

    public function reportCsv(Request $request) {
        return Excel::download(new LogsExport($this->filter), 'report.csv');
    }

    public function reportPdf(Request $request) {
        return Excel::download(new LogsExport($this->filter), 'report.pdf', \Maatwebsite\Excel\Excel::DOMPDF);
    }
}
