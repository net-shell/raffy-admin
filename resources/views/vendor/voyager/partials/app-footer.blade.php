<footer class="app-footer">
    <div class="site-footer-right">
        &copy; 2020 NetShell ltd.
        @php $version = Voyager::getVersion(); @endphp
        @if (!empty($version))
            {{ $version }}
        @endif
    </div>
</footer>
