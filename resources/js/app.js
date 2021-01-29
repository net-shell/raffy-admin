require('./bootstrap');

import Echo from 'laravel-echo'
import Notifications from 'vue-notification'
import Multiselect from 'vue-multiselect'
import Datepicker from 'vuejs-datepicker';

import * as uiv from 'uiv'

import 'vue-multiselect/dist/vue-multiselect.min.css';

if (document.getElementsByClassName('page-content').length == 0) {
    window.io = require('socket.io-client');
    window.moment = require('moment');
    window.moment.locale('bg');
    window.Vue = require('vue');
    window.Notifications = require('vue-notification');
    window.fileDownload = require('js-file-download');

    Vue.use(uiv)
    Vue.use(Notifications);

    Vue.component('multiselect', Multiselect)
    Vue.component('datepicker', Datepicker)

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
            auth: {
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('meta[name=csrf-token]').getAttribute('content'),
                }
            }
        });

        window.Echo.join(`Chat.Global`)
            .here((users) => {
                window.vm.$root.$emit('chat-joined', users);
            })
            .joining((user) => {
                window.vm.$root.$emit('chat-joined', [user]);
            })
            .leaving((user) => {
                window.vm.$root.$emit('chat-left', user);
            });

        window.Echo.private(`App.Log`)
            .listen('TagLogged', (e) => {
                window.vm.$root.$emit('tag-logged', e.log);
                Vue.notify({
                    group: 'app',
                    type: 'success',
                    duration: 15000,
                    text: "Засечена е карта на: " + e.log.reader.name,
                    title: e.log.user.name
                });
            });

        window.Echo.private(`App.Tag`)
            .listen('TagRequested', (e) => {
                window.vm.$root.$emit('tag-requested', e.tagId, e.reader);
                Vue.notify({
                    group: 'app',
                    type: 'error',
                    duration: 15000,
                    text: "Непозната карта на: " + e.reader.name,
                    title: e.tagId
                });
            });

        window.Echo.private(`App.Reader`)
            .listen('ReaderStarted', (e) => {
                window.vm.$root.$emit('reader-started', e.reader);
                Vue.notify({
                    group: 'sink',
                    type: 'info',
                    duration: 5000,
                    text: "Обновено състояние на четец",
                    title: e.reader.name
                });
            })
            .listen('ReaderRequested', (e) => {
                window.vm.$root.$emit('reader-requested', e.readerId);
                Vue.notify({
                    group: 'sink',
                    type: 'danger',
                    duration: 5000,
                    text: "Нова заявка за четец",
                    title: e.readerId
                });
            });
    }
}
