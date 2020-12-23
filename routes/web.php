<?php

use Illuminate\Support\Facades\Route;
use App\Reader;
use App\Http\Resources\Reader as ReaderResource;

Voyager::routes();

Route::group(['middleware' => 'admin.user'], function() {
    Route::get('monitor', 'MonitorController@index');

    Route::get('report', 'ReportController@index');
    Route::post('report-json', 'ReportController@reportJson');
    Route::post('report-excel', 'ReportController@reportExcel');
    Route::post('report-csv', 'ReportController@reportCsv');
    Route::post('report-pdf', 'ReportController@reportPdf');

    Route::get('register', 'RegisterController@index');
});

Route::group(['prefix' => '/iot'], function() {
    Route::post('log-tag', 'ReaderController@logTag');
    Route::post('start-reader', 'ReaderController@startReader');
});

Route::group(['prefix' => '/api'], function() {
    Route::get('/readers', function () {
        return new ReaderResource(Reader::orderBy('order')->get());
    });
    Route::get('/logs', 'MonitorController@logs');
    Route::get('/emit-last', 'ReaderController@emitLast');
    Route::get('/workers', function() {
        $results = \App\User::all();
        return compact('results');
    });
});
