require('./bootstrap');

import Echo from 'laravel-echo'
import Notifications from 'vue-notification'
import Multiselect from 'vue-multiselect'
import Datepicker from 'vuejs-datepicker';

import 'vue-multiselect/dist/vue-multiselect.min.css';

if (document.getElementById('app')) {
    window.io = require('socket.io-client');
    window.moment = require('moment');
    window.moment.locale('bg');
    window.Vue = require('vue');
    window.Notifications = require('vue-notification');
    window.fileDownload = require('js-file-download');

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
        });

        window.Echo.private(`App.Log`)
            .listen('TagLogged', (e) => {
                window.vm.$root.$emit('tag-logged', e.log);
            });

        window.Echo.private(`App.Tag`)
            .listen('TagRequested', (e) => {
                window.vm.$root.$emit('tag-requested', e.tagId, e.reader);
            });

        window.Echo.private(`App.Reader`)
            .listen('ReaderStarted', (e) => {
                window.vm.$root.$emit('reader-started', e.reader);
                console.log('STARTED', e.reader)
                Vue.notify({
                    group: 'reader',
                    type: 'success',
                    duration: 10000,
                    title: "Стартиран е четец",
                    text: e.reader.name
                });
            })
            .listen('ReaderRequested', (e) => {
                window.vm.$root.$emit('reader-requested', e.readerId);
                console.log('REQUESTED', e.readerId)
                Vue.notify({
                    group: 'reader',
                    type: 'danger',
                    duration: 10000,
                    title: "Нова заявка за четец",
                    text: e.readerId
                });
            });
    }
}