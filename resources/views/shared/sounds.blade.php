@foreach(['enter-1', 'exit-1'] as $soundName)
    <?php $sound = Storage::url("sounds/$soundName.mp3"); ?>
    @if($sound && !empty($sound))
        <audio id="audio-{{ $soundName }}">
            <source src="{{ $sound }}" type="audio/mp3">
        </audio>
    @endif
@endforeach