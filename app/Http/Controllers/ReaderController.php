<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Log;
use App\Tag;
use App\Reader;
use App\User;
use App\Events\TagLogged;

class ReaderController extends BaseController
{
    public function rfidEndpoint(Request $request) {
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
        $log->load('user');
        $log->load('reader');
        $log->load('tag');
    
        if($log) {
            broadcast(new TagLogged($log));
            return $log->toJson();
        }
    
        return 'Error while logging.';
    }
}
