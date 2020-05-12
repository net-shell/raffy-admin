<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Log extends Model
{
    protected $fillable = ['user_id', 'reader_id', 'tag_id'];

    public function user()
    {
        return $this->belongsTo('App\\User');
    }

    public function reader()
    {
        return $this->belongsTo('App\\Reader');
    }

    public function tag()
    {
        return $this->belongsTo('App\\Tag');
    }
}
