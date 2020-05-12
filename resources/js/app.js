console.log('Loading...');

require('./bootstrap');

import Echo from "laravel-echo"

window.io = require('socket.io-client');

window.Echo = new Echo({
    broadcaster: 'socket.io',
    host: window.location.hostname + ':6001'
});

window.Echo.private(`App.Log`)
    .listen('TagLogged', (e) => {
        let el = document.getElementById('monitor-app');
        if(!el) return;
        let log = e.log;
        let newChild = document.createElement('div');
        newChild.innerHTML = '<div class="log-entry well row fadein"><div class=col-sm-3><img class=img-responsive src="/storage/' + log.user.avatar + '"></div><div class="details col-sm-9"><h3 class="name">' + log.user.name + '</h3><div class="time">' + log.created_at + '</div><div class="reader">' + log.reader.name + '</div></div></div> ';
        el.insertBefore(newChild, el.firstChild);
    });