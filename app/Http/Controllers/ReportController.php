<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Exports\LogsExport;
use Maatwebsite\Excel\Excel;
use Maatwebsite\Excel\Facades\Excel as ExcelFacade;

class ReportController extends BaseController
{
    public $filter;

    private $export;
    private $filename = 'otchet_';

    public function __construct(Request $request)
    {
        $this->filter = json_decode($request->input('filter'), true);
        $this->export = new LogsExport($this->filter);
        $this->filename .= date('Y-d-m_H-i');
    }

    public function index(Request $request) {
        return view('reports', ['filename' => $this->filename]);
    }

    public function reportJson(Request $request) {
        $report = $this->export->collection();
        return [
            'headings' => $this->export->headings(),
            'data' => $report
        ];
    }

    public function reportExcel(Request $request) {
        return ExcelFacade::download($this->export, $this->filename . '.xlsx');
    }

    public function reportCsv(Request $request) {
        return ExcelFacade::download($this->export, $this->filename . '.csv', Excel::CSV, [
            'Content-Type' => 'text/csv',
        ]);
    }

    public function reportPdf(Request $request) {
        return ExcelFacade::download($this->export, $this->filename . '.pdf');
    }
}
