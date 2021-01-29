@extends('voyager::master')

@section('content')
<div class="container-fluid">
    <log-reports filename="{{ $filename }}"></log-reports>
</div>
@stop
