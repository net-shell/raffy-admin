<?php

use Illuminate\Support\Facades\Route;

Voyager::routes();

Route::get('monitor', 'MonitorController@index')->middleware('admin.user');

Route::post('rfid-endpoint', 'ReaderController@rfidEndpoint');