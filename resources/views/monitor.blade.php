@extends('voyager::master')

@section('css')
    <style>
        .log-entry {
            padding: 2em;
            border: 1px solid #333;
            margin: 1em 0;
        }
        .log-entry .img-responsive {
            max-height: 200px;
        }
        .log-entry .reader {
            font-weight: bold;
        }
        .fadein, .fadeout {
            opacity: 0;
            -moz-transition: opacity 0.4s ease-in-out;
            -o-transition: opacity 0.4s ease-in-out;
            -webkit-transition: opacity 0.4s ease-in-out;
            transition: opacity 0.4s ease-in-out;
        }
        .fadein {
            opacity: 1;
        }
    </style>
@stop

@section('content')
<div class="container">
    <h1>Монитор на записите в реално време</h1>
    <div id="monitor-app">
        @foreach($logs as $log)
        <div class="log-entry well row">
            <div class=col-sm-3>
                <img class=img-responsive src="/storage/{{ $log->user->avatar }}">
            </div>
            <div class="details col-sm-9">
                <h3 class="name">{{ $log->user->name }}</h3>
                <div class="time">{{ $log->created_at }}</div>
                <div class="reader">{{ $log->reader->name }}</div>
            </div>
        </div>';
        @endforeach
    </div>
</div>
@stop
