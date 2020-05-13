@extends('voyager::master')

@section('css')
    <style>
        .log-entry {
            padding: 0;
            margin: 1em 0;
            border: 1px solid #333;
        }
        .log-entry.faded {
            opacity: 0.5;
        }
        .log-entry > div {
            padding: 0;
            margin-bottom: 0 !important;
        }
        .log-entry .details {
            padding: 1em;
        }
        .log-entry .img-responsive {
            max-height: 200px;
        }
        .log-entry .reader {
            font-weight: bold;
        }

        .big-clock .live-time {
            color: #000;
            font-size: 8em;
        }
    </style>
@stop

@section('content')
<div class="container">
    <h1>Монитор на записите в реално време</h1>
    <div class="row">
        <div class="col-sm-8">
            <div id="monitor-app">
                @foreach($logs as $log)
                <div class="log-entry well row attention-please">
                    <div class=col-sm-3>
                        <img class=img-responsive src="/storage/{{ $log->user->avatar }}">
                    </div>
                    <div class="details col-sm-9">
                        <div class="reader pull-right badge">{{ $log->reader->name }}</div>
                        <h3 class="name">{{ $log->user->name }}</h3>
                        <div class="live-clock" data-timestamp="{{ $log->created_at->timestamp }}">
                            <h4 class="live-diff"></h4>
                            <h3 class="live-time"></h3>
                            <h4 class="live-date"></h4>
                        </div>
                    </div>
                </div>
                @endforeach
            </div>
        </div>
        <div class="live-clock big-clock col-sm-4 text-center">
            <h1 class="live-time"></h1>
            <h4 class="live-date"></h4>
        </div>
</div>
@stop
