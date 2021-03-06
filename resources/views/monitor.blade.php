@extends('voyager::master')

@section('content')
    <div>
        @foreach(['open_sound', 'close_sound'] as $soundName)
        <?php $sound = json_decode(Voyager::setting('site.' . $soundName)); ?>
        @if($sound && !empty($sound))
                <audio id="audio_{{ $soundName }}">
                    <source src="{{ Storage::disk(config('voyager.storage.disk'))->url($sound[0]->download_link) }}" type="audio/mp3">
                </audio>
            @endif
        @endforeach
        <log-monitor
            color="#F51615"
            brand="{{ Voyager::setting('admin.title', 'RAFFY') }}">
        </log-monitor>
    </div>
@stop
