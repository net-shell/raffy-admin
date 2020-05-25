@extends('voyager::master')

@section('content')
<div id="app" class="container-fluid">
    <log-monitor :last-logs="'{!! htmlspecialchars(json_encode($logs), ENT_QUOTES, 'UTF-8') !!}'"></log-monitor>
</div>
@stop
