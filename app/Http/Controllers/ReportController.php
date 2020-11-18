<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Exports\LogsExport;
use \Maatwebsite\Excel\Excel;

class ReportController extends BaseController
{
    public $filter;

    private $export;
    private $filename = 'otchet';

    public function __construct(Request $request)
    {
        $this->filter = json_decode($request->getContent(), true);
        $this->export = new LogsExport($this->filter);
    }

    public function index(Request $request) {
        return view('reports', ['filename' => $this->filename]);
    }

    public function reportJson(Request $request) {
        return [
            'headings' => $this->export->headings(),
            'data' => (array)$this->export->collection()
        ];
    }

    public function reportExcel(Request $request) {
        return \Excel::download($this->export, $this->filename . '.xlsx', Excel::XLSX);
    }

    public function reportCsv(Request $request) {
        return \Excel::download($this->export, $this->filename . '.csv', Excel::CSV, [
            'Content-Type' => 'text/csv',
        ]);
    }

    public function reportPdf(Request $request) {
        return \Excel::download($this->export, $this->filename . '.pdf', Excel::MPDF);
    }
}
