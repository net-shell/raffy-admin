<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use App\Log;
use App\Reader;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;

class TagRequested implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $tagId;
    public $reader;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($tagId, Reader $reader)
    {
        $this->tagId = $tagId;
        $this->reader = $reader;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        return new PrivateChannel('App.Tag');
    }
}
