require('./bootstrap');

import Echo from "laravel-echo"

window.io = require('socket.io-client');
var moment = require('moment');
moment.locale('bg');

window.Echo = new Echo({
    broadcaster: 'socket.io',
    host: window.location.hostname + ':6001'
});

window.Echo.private(`App.Log`)
    .listen('TagLogged', (e) => {
        let el = document.getElementById('monitor-app');
        if (!el) return;
        let log = e.log;
        let newClass = 'attention-please well';
        let newChild = document.createElement('div');
        let timestamp = moment(log.created_at).format('X');
        newChild.innerHTML = '<div class="log-entry row ' + newClass + '"><div class=col-sm-3><img class=img-responsive src="/storage/' + log.user.avatar + '"></div><div class="details col-sm-9"><div class="reader pull-right badge">' + log.reader.name + '</div><h3 class="name">' + log.user.name + '</h3><div class="live-clock" data-timestamp="' + timestamp + '"><h4 class="live-diff"></h4><h3 class="live-time"></h3><h4 class="live-date"></h4></div></div></div> ';
        el.insertBefore(newChild, el.firstChild);
        moment().format();
    });

function updateClocks(selRoot) {
    // Live diff
    let els = document.querySelectorAll(selRoot + ' .live-diff');
    if (!els) return;
    for(var elDiff of els) {
        let now = getParentClock(elDiff);
        elDiff.innerHTML = moment(now).fromNow();
    }
    
    // Live time
    els = document.querySelectorAll(selRoot + ' .live-time');
    if (!els) return;
    for (var elTime of els) {
        let now = getParentClock(elTime);
        elTime.innerHTML = moment(now).format('HH:mm:ss');
    }
    
    // Live date
    els = document.querySelectorAll(selRoot + ' .live-date');
    if (!els) return;
    for(var elDate of els) {
        let now = getParentClock(elDate);
        elDate.innerHTML = moment(now).format('dddd L');
    }
}

function getParentClock(el) {
    let root = el.parentNode;
    
    let now = new Date();
    if (root && root.dataset.timestamp && root.dataset.timestamp.length > 0) {
        now = new Date(root.dataset.timestamp * 1000);
    }
    console.log(root, root.dataset.timestamp, now.toUTCString())

    return now;
}

function initClocks() {
    updateClocks('.live-clock');
}

setInterval(initClocks, 1000);

// Init
initClocks();
moment().format();