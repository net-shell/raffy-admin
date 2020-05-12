<?php

use Illuminate\Support\Facades\Route;

Voyager::routes();

Route::get('monitor', 'MonitorController@index');

Route::post('rfid-endpoint', 'ReaderController@rfidEndpoint');