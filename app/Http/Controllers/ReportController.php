<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Exports\LogsExport;
use App\Exports\LogsWorkExport;
use App\Exports\LogsAbsentExport;
use Maatwebsite\Excel\Excel;
use Maatwebsite\Excel\Facades\Excel as ExcelFacade;

class ReportController extends BaseController
{
    private $filter;
    private $export;
    private $type;
    private $filename = 'otchet_';
    private $typeMap = [
        'sumTime' => LogsExport::class,
        'workTime' => LogsWorkExport::class,
        'absent' => LogsAbsentExport::class,
    ];
    
    public function __construct(Request $request)
    {
        $this->type = $request->input('type', 'sumTime');
        $this->filter = json_decode($request->input('filter'), true);
        $this->export = new $this->typeMap[$this->type]($this->filter);
        $this->filename .= $this->type . '_' . date('Y-d-m_H-i');
    }
    
    public function index(Request $request) {
        return view('reports');
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
