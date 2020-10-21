<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Reader extends Model
{
    protected $casts = ['stats' => 'array'];
}
