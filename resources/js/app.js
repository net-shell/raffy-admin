require('./bootstrap');
import Echo from 'laravel-echo';

if(document.getElementById('app')) {
    window.io = require('socket.io-client');
    window.moment = require('moment');
    window.moment.locale('bg');
    window.Vue = require('vue');

    /**
     * The following block of code may be used to automatically register your
     * Vue components. It will recursively scan this directory for the Vue
     * components and automatically register them with their "basename".
     *
     * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
     */

    const files = require.context('./', true, /\.vue$/i)
    files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

    // Vue
    window.vm = new Vue({
        el: '#app',
    });

    // Echo
    if (typeof io !== 'undefined') {
        window.Echo = new Echo({
            broadcaster: 'socket.io',
            host: window.location.hostname + ':6001',
        });

        window.Echo.private(`App.Log`)
            .listen('TagLogged', (e) => {
                window.vm.$root.$emit('tag-logged', e.log);
            });

        window.Echo.private(`App.Tag`)
            .listen('TagRequested', (e) => {
                window.vm.$root.$emit('tag-requested', e.tagId, e.reader);
            });
    }
}