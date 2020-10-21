<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Log extends Model
{
    protected $fillable = ['user_id', 'reader_id', 'tag_id'];

    public $timestamps = false;

    
    public static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->created_at = $model->freshTimestamp();
        });
    }


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
