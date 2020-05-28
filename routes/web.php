<?php

use Illuminate\Support\Facades\Route;

Voyager::routes();

Route::get('monitor', 'MonitorController@index')->middleware('admin.user');

Route::get('report', 'ReportController@index')->middleware('admin.user');
Route::post('report-json', 'ReportController@reportJson')->middleware('admin.user');

Route::group(['prefix' => '/iot'], function() {
    Route::post('log-tag', 'ReaderController@logTag');
    Route::post('start-reader', 'ReaderController@startReader');
});