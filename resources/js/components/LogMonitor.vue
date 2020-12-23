<template>
    <div class="row">
        <div class="col-md-10">
            <div class="panel panel-bordered">
                <div class="panel-body">
                    <div class="branding">
                        <img class="logo" :src="logo"/>
                        Система за контрол на достъпа
                    </div>
                </div>
            </div>
            <div class="page-content containter-fluid">
                <div v-for="request in newRequests" :key="request.id">
                    <tag-request :request="request"></tag-request>
                </div>
                <div class="log-items">
                    <div class="log-item" v-for="(log, l) in logs" :key="log.id">
                        <p class="day-name lead text-center" v-if="isDayHeader(l)" :class="isToday(log) ? 'text-success' : ''">
                            <span class="badge badge-success text-uppercase" v-if="isToday(log)">Днес</span>
                            <span class="icon voyager-calendar"></span>
                            {{ getDayName(log) }}
                        </p>
                        <log-entry ref="logs" :log="log"></log-entry>
                    </div>
                </div>
                <div class="load-more">
                    <div class="btn-group btn-group-lg btn-group-justified">
                        <a class="btn btn-info" @click="scrollTop()" :disabled="!logs.length">
                            <span class="icon voyager-double-up"></span>
                            Върни се към най-новите
                        </a>
                        <a class="btn btn-success" ref="loadmore" @click="loadMore()" :disabled="loadingLogs">
                            <span class="icon voyager-refresh"></span>
                            Зареди по-стари записи
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="live-clock big-clock col-md-2 text-center">
            <div class="panel panel-bordered">
                <div class="panel-body">
                    <h2>{{ liveTime }}</h2>
                    <h3>{{ liveDate }}</h3>

                    <clock size="50"></clock>

                    <div class="checkbox">
                        <label>
                            <input type="checkbox" v-model="showExited">
                            Покажи излезлите служители
                        </label>
                    </div>
                </div>
            </div>
            <div class="panel panel-bordered">
                <div class="panel-body">
                    <notify-area></notify-area>
                    <reader-monitor></reader-monitor>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Clock from "vue-clock2";

    export default {
        props: ["logo", "color", "brand"],
        components: {Clock},
        mounted() {
            this.$nextTick(function () {
                setInterval(this.updateTimestamp, 1000);
                this.updateTimestamp();
                this.loadMore();
            });
        },
        created() {
            this.$root.$on("tag-logged", this.onEntryLogged);
            this.$root.$on("tag-requested", this.onTagRequested);
            this.$on("log-added", this.playLogAudio);
            this.$on("log-updated", this.playLogAudio);
        },
        data() {
            return {
                newLogs: [],
                newRequests: [],
                timestamp: null,
                readers: [],
                selectedReader: null,
                loadingLogs: false,
                showExited: true,
            };
        },
        computed: {
            logs() {
                let logs = this.newLogs;
                if (!this.showExited) {
                    logs = logs.filter((l) => !l.exited_at);
                }
                if (this.selectedReader) {
                    logs = logs.filter((l) => l.reader_id == this.selectedReader.id);
                }
                return logs;
            },
            liveTime() {
                if (!this.timestamp) return;
                return this.timestamp.format("HH:mm:ss");
            },
            liveDate() {
                if (!this.timestamp) return;
                return this.timestamp.format("dddd L");
            },
        },
        methods: {
            scrollTop() {
                window.scrollTo(0, 0);
            },
            getDayName(log) {
                return this.getLogTime(log).format('dddd, DD MMMM');
            },
            isToday(log) {
                return this.getLogTime(log).isSame(new Date(), 'day');
            },
            isDayHeader(i) {
                return i == 0 || this.getDayName(this.logs[i - 1]) != this.getDayName(this.logs[i])
            },
            getLogTime(log) {
                return window.moment(log.exited_at || log.created_at);
            },
            updateTimestamp() {
                this.timestamp = window.moment();
            },
            onEntryLogged(log) {
                if (this.logs.filter((l) => l.id == log.id).length > 0) {
                    // Update existing log
                    if (this.newLogs.filter((l) => l.id == log.id).length > 0) {
                        let i = this.newLogs.findIndex((l) => l.id == log.id);
                        this.newLogs.splice(i, 1, log);
                    }
                    this.$emit('log-updated', log);
                } else {
                    // Add to new logs
                    this.newLogs.unshift(log);
                    this.$emit('log-added', log);
                }
            },
            onTagRequested(tagId, reader) {
                this.newRequests = this.newRequests.filter((r) => r.tagId != tagId);
                this.newRequests.unshift({
                    id: window.moment().format("X"),
                    tagId: tagId,
                    reader: reader,
                    creation_time: window.moment().format("HH:mm:ss"),
                    creation_date: window.moment().format("dddd L"),
                });
            },
            playLogAudio(log) {
                let sound = log.exited_at ? 'close_sound' : 'open_sound';
                this.playAudio(sound);
            },
            playAudio(name) {
                let el = document.getElementById('audio_' + name);
                if (!el) return;
                el.currentTime = 0;
                el.play();
            },
            async loadMore() {
                this.loadingLogs = true;
                const url = "/api/logs?skip=" + this.newLogs.length;
                const res = await fetch(url);
                const response = await res.json();
                const logs = response.data;
                this.newLogs = this.newLogs.concat(logs);
                this.loadingLogs = false;
            },
        },
    };
</script>

<style scoped>
    .big-clock h1 {
        font-size: 8em;
        margin: 0;
        overflow: hidden;
    }

    .branding {
        font-size: 2em;
        text-transform: uppercase;
        font-weight: normal;
        line-height: 1;
    }

    .branding .logo {
        width: auto;
        height: 2em;
    }

    .load-more,
    .log-item .day-name {
        padding: 2em 0 0 0;
    }

    .log-item:first-child .day-name {
        padding: 0;
    }
</style>
