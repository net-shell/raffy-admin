@extends('voyager::master')

@section('content')
<div id="app" class="container-fluid">
    <log-reports filename="{{ $filename }}"></log-reports>
</div>
@stop
