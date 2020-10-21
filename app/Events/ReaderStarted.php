<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use App\Reader;
use ArgumentCountError;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;

class ReaderStarted implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $reader;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct(Reader $reader)
    {
        if(!$reader) throw new ArgumentCountError();
        $this->reader = $reader;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        return new PrivateChannel('App.Reader');
    }
}
