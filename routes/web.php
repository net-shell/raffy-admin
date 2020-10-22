<?php

use Illuminate\Support\Facades\Route;
use App\Reader;
use App\Http\Resources\Reader as ReaderResource;

Voyager::routes();

Route::get('monitor', 'MonitorController@index')->middleware('admin.user');

Route::get('report', 'ReportController@index')->middleware('admin.user');
Route::post('report-json', 'ReportController@reportJson')->middleware('admin.user');
Route::post('report-excel', 'ReportController@reportExcel')->middleware('admin.user');
Route::post('report-csv', 'ReportController@reportCsv')->middleware('admin.user');
Route::post('report-pdf', 'ReportController@reportPdf')->middleware('admin.user');

Route::group(['prefix' => '/iot'], function() {
    Route::post('log-tag', 'ReaderController@logTag');
    Route::post('start-reader', 'ReaderController@startReader');
});

Route::group(['prefix' => '/api'], function() {
    Route::get('/reader', function () {
        return new ReaderResource(Reader::orderBy('order')->get());
    });
});