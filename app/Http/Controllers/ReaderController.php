<?php

namespace App\Http\Controllers;

use App\Events\ReaderStarted;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use App\Log;
use App\Tag;
use App\Reader;
use App\User;
use App\Events\TagLogged;
use App\Events\TagRequested;
use App\Events\ReaderRequested;

class ReaderController extends BaseController
{
    public function startReader(Request $request) {
        $readerId = base64_decode($request->input('reader'));
        $reader = Reader::whereMac($readerId)->first();
        if(!$reader) {
            broadcast(new ReaderRequested($readerId));
            return response()->json([ 'error' => 404, 'message' => 'Reader not registered.' ], 404);
        }

        broadcast(new ReaderStarted($reader));
        return $reader->toJson();
    }

    public function logTag(Request $request) {
        $readerId = base64_decode($request->input('reader'));
        $reader = Reader::whereMac($readerId)->first();
        if(!$reader) {
            return response()->json([ 'error' => 404, 'message' => 'Reader not registered.' ], 404);
        }

        $tagId = base64_decode($request->input('id'));
        $tag = Tag::whereTag($tagId)->first();
        if(!$tag) {
            broadcast(new TagRequested($tagId, $reader));
            return response()->json([ 'status' => 'Requested' ], 404);
        }   
    
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
