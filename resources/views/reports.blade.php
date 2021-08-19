@extends('voyager::master')

@section('content')
<div class="container-fluid">
    @include('shared.sounds')
    <log-reports filename="{{ $filename }}"></log-reports>
</div>
@stop
