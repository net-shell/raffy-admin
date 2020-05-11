<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

Voyager::routes();

Route::post('rfid-endpoint', function(Request $request) {
    var_dump($request->only('id', 'text'));
    var_dump(base64_decode($request->input('id')));
});