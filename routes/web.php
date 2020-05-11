<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Log;
use App\Tag;
use App\Reader;

Voyager::routes();

Route::post('rfid-endpoint', function(Request $request) {
    $tagId = base64_decode($request->input('id'));
    $readerId = base64_decode($request->input('reader'));

    $tag = Tag::whereTag($tagId)->first();
    if(!$tag) abort(404);

    $reader = Reader::whereMac($readerId)->first();
    if(!$reader) abort(404);

    $log = Log::create([
        'user_id' => $tag->user_id,
        'reader_id' => $reader->id,
        'tag_id' => $tag->id,
    ]);

    var_dump($log->toArray());
});