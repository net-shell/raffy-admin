<?php

namespace App\Http\Controllers;

use Illuminate\Routing\Controller as BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use App\Log;
use App\Tag;
use App\Reader;
use App\Error;
use App\Events\TagLogged;
use App\Events\TagRequested;
use App\Events\ReaderStarted;
use App\Events\ReaderRequested;

class ReaderController extends BaseController
{
    public function emitLast()
    {
        $log = Log::latest('created_at')->first();
        broadcast(new TagLogged($log));
        return($log->toArray());
    }

    public function startReader(Request $request)
    {
        $readerId = base64_decode($request->input('reader'));
        $reader = Reader::whereMac($readerId)->first();
        if (!$reader) {
            broadcast(new ReaderRequested($readerId));
            return response()->json(['status' => 'error', 'message' => 'Reader not registered.'], 404);
        }
        
        $reader->stats = $request->all();
        $reader->touch();
        $reader->save();

        broadcast(new ReaderStarted($reader));
        return $reader->toJson();
    }

    public function logTag(Request $request)
    {
        $readerId = base64_decode($request->input('reader'));
        $reader = Reader::whereMac($readerId)->first();
        if (!$reader) {
            broadcast(new ReaderRequested($readerId));
            return response()->json(['status' => 'error', 'message' => 'Reader not registered.'], 404);
        }

        $tagId = base64_decode($request->input('id'));
        $tag = Tag::whereTag($tagId)->first();
        if (!$tag) {
            // Broadcast event
            broadcast(new TagRequested($tagId, $reader));
            return response()->json(['status' => 'requested'], 404);
        }

        $overwrite = setting('site.overwrite_time');

        $logQuery = Log::where('user_id', $tag->user_id)
            ->where('reader_id', $reader->id)
            ->where('tag_id', $tag->id)
            ->whereRaw('DATE(created_at) <= CURDATE()')
            ->orderBy('created_at', 'desc')
            ->limit(1);

        $log = $logQuery->first();
        $lastAttemptTime = Carbon::now()->subMinutes($overwrite);
        $lastAttempt = $logQuery->where(function($q) use ($lastAttemptTime) {
            $q->where('created_at', '>=', $lastAttemptTime)
                ->orWhere('exited_at', '>=', $lastAttemptTime);
        })->first();

        if($lastAttempt && $overwrite > 0) {
            $log = $lastAttempt;
            $log->created_at = Carbon::now();
            $log->save();
        } else {
            if($log && !$log->exited_at) {
                $log->exited_at = Carbon::now();
                $log->save();
            } else {
                $log = Log::create([
                    'user_id' => $tag->user_id,
                    'reader_id' => $reader->id,
                    'tag_id' => $tag->id,
                ]);
            }
        }

        $log->load(['user', 'reader', 'tag']);

        if ($log) {
            broadcast(new TagLogged($log));
            return [
                'status' => 'success',
                'log' => $log,
                'action' => [
                    'type' => 'OPEN',
                    'is_exit' => $log->exited_at ? 1 : 0,
                    'time' => setting('site.open_time')
                ]
            ];
        }

        // Store error
        $error = new Error();
        $error->type = 'Сканиране';
        $error->message = 'Грешка при сканиране на карта "' . $tagId . '" от четец "' . $readerId . '".';
        $error->save();
        return 'Error while logging.';
    }
}
