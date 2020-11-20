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
                <div v-for="log in logs" :key="log.id">
                    <log-entry ref="logs" :log="log"></log-entry>
                </div>
                <div class="text-center">
                    <a class="btn" ref="loadmore" @click="loadMore()" :class="loadingLogs ? 'btn-disabled' : 'btn-success'">
                        <span class="icon voyager-refresh"></span>
                        Показване на по-стари
                    </a>
                </div>
            </div>
        </div>
        <div class="live-clock big-clock col-md-2 text-center">
            <div class="panel panel-bordered">
                <div class="panel-body">
                    <h2>{{ liveTime }}</h2>
                    <h3>{{ liveDate }}</h3>
                    <clock size="50"></clock>
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
            };
        },
        computed: {
            logs() {
                let logs = this.newLogs;
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
</style>
