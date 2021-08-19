@extends('voyager::master')

@section('content')
    <div>
        @include('shared.sounds')
        <log-monitor
            color="#F51615"
            brand="{{ Voyager::setting('admin.title', 'RAFFY') }}">
        </log-monitor>
    </div>
@stop
