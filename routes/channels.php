<?php

use Illuminate\Support\Facades\Broadcast;

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/

Broadcast::channel('App.User.{id}', function ($user, $id) {
    return (int) $user->id === (int) $id;
});

Broadcast::channel('App.Log', function ($user) {
    return true;
    return $user->role_id == 1;
});

Broadcast::channel('App.Tag', function ($user) {
    return true;
});

Broadcast::channel('App.Reader', function ($user) {
    return true;
});

Broadcast::channel('Chat.Global', function ($user) {
    return [
        'id' => $user->id,
        'name' => $user->name,
        'section' => $user->section->name,
        'avatar' => $user->avatar,
    ];
});
