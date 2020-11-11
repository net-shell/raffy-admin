<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Exports\LogsExport;
use Excel;

class ReportController extends BaseController
{
    public $filter;

    private $export;

    public function __construct(Request $request)
    {
        $this->filter = json_decode($request->getContent(), true);
        $this->export = new LogsExport($this->filter);
    }

    public function index(Request $request) {
        return view('reports');
    }

    public function reportJson(Request $request) {
        return [
            'headings' => $this->export->headings(),
            'data' => (array)$this->export->collection()
        ];
    }

    public function reportExcel(Request $request) {
        return Excel::download($this->export, 'report.xls', \Maatwebsite\Excel\Excel::XLS);
    }

    public function reportCsv(Request $request) {
        return Excel::download($this->export, 'report.csv');
    }

    public function reportPdf(Request $request) {
        return Excel::download($this->export, 'report.pdf', \Maatwebsite\Excel\Excel::DOMPDF);
    }
}
