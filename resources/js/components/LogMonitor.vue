<template>
    <div class="row">
        <div class="col-sm-3 col-lg-2 text-center">
            <div class="panel panel-bordered">
                <div class="panel-heading">
                    <h2>{{ liveTime }}</h2>
                </div>
                <div class="panel-body">
                    <notify-area></notify-area>
                    <clock size="50"></clock>
                    <h3>{{ liveDate }}</h3>
                </div>
            </div>

            <div class="panel tools panel-bordered">
                <div class="panel-heading" @click="showSettings = !showSettings">
                    <button type="button" class="btn btn-block">
                        <i class="icon voyager-search"></i>
                        Търсене
                    </button>
                </div>
                <div v-if="showSettings" class="panel-body">
                    <div>
                        <label class="control-label">Започни от дата:</label>
                        <datepicker
                            @selected="startDateSelected"
                            :language="bg"
                            input-class="form-control"
                            :monday-first="true"
                            :format="dateFormat"
                            :placeholder="'днес'"
                        ></datepicker>
                    </div>
                    <div>
                        <button type="button" class="btn btn-success btn-block" @click="reloadData">
                            <i class="icon voyager-refresh"></i>
                            Зареди записите
                        </button>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" v-model="showExited">
                            Покажи излезлите служители
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-9 col-lg-10">
            <div class="page-content containter-fluid">
                <div v-for="request in newRequests" :key="request.id">
                    <tag-request :request="request"></tag-request>
                </div>
                <div class="log-items">
                    <div class="log-item" v-for="(log, l) in logs" :key="log.id">
                        <p class="day-name lead text-center" v-if="isDayHeader(l)"
                           :class="isToday(log) ? 'text-success' : ''">
                           <span class="badge" :class="isToday(log) ? 'badge-primary' : 'badge-default'">
                            <span class="badge badge-success" v-if="isToday(log)">Днес</span>
                            <span class="icon voyager-calendar"></span>
                            {{ getDayName(log) }}
                           </span>
                        </p>
                        <log-entry ref="logs" :log="log"></log-entry>
                    </div>
                </div>
                <div class="load-more" v-if="!loadingLogs">
                    <div class="btn-group btn-group-lg btn-group-justified">
                        <a class="btn btn-info" @click="scrollTop()" :disabled="!logs.length">
                            <span class="icon voyager-double-up"></span>
                            Върни се към най-новите
                        </a>
                        <a class="btn btn-success" @click="loadMore()" :disabled="loadingLogs">
                            <span class="icon voyager-refresh"></span>
                            Зареди по-стари записи
                        </a>
                    </div>
                </div>
                <div v-if="loadingLogs" class="text-center lead text-primary">
                    Зареждане...
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Clock from "vue-clock2";
    import {bg} from "vuejs-datepicker/dist/locale";


    export default {
        props: ["logo", "color", "brand"],
        components: {Clock},
        created() {
            this.$root.$on("tag-logged", this.onEntryLogged);
            this.$root.$on("tag-requested", this.onTagRequested);
            this.$on("log-added", this.playLogAudio);
            this.$on("log-updated", this.playLogAudio);
        },
        mounted() {
            this.$nextTick(function () {
                setInterval(this.updateTimestamp, 1000);
                this.updateTimestamp();
                this.reloadData();
            });

            // Support direct card input
            window.addEventListener('keyup', (e) => {
                if (e.key >= '0' && e.key <= '9') {
                    this.cardKey += '' + e.key;
                } else if (e.key == 'Enter') {
                    this.logTag(this.cardKey);
                    this.cardKey = '';
                }
            });
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
                showSettings: true,
                bg: bg,
                startDate: '',
                cardKey: '',
            };
        },
        watch: {
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
            startDateSelected(date) {
                this.startDate = moment(date).format('YYYY-MM-DD');
                this.newLogs = [];
                this.loadMore();
            },
            updateReadersCount(count) {
                this.readersCount = count;
            },
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
            dateFormat(date) {
                return moment(date).format("dddd DD MMMM YYYY");
            },
            onEntryLogged(log) {
                if (this.logs.filter((l) => l.id == log.id).length > 0) {
                    // Update existing log
                    if (this.newLogs.filter((l) => l.id == log.id).length > 0) {
                        let i = this.newLogs.findIndex((l) => l.id == log.id);
                        this.newLogs.splice(i, 1, log);
                    }
                    this.$emit('log-updated', log);
                    this.reloadData();
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
                let sound = log.exited_at ? 'exit-1' : 'enter-1';
                this.playAudio(sound);
            },
            playAudio(name) {
                let el = document.getElementById('audio-' + name);
                if (!el) return;
                el.currentTime = 0;
                el.play();
            },
            reloadData() {
                this.newRequests = [];
                this.newLogs = [];
                this.loadMore();
            },
            async loadMore() {
                this.loadingLogs = true;
                const url = "/api/logs?start=" + this.startDate + "&skip=" + this.newLogs.length;
                const res = await fetch(url);
                const response = await res.json();
                const logs = response.data;
                this.newLogs = this.newLogs.concat(logs);
                console.log(logs)
                this.loadingLogs = false;
            },
            async logTag(number) {
                const url = "/iot/log-tag?id=" + btoa('' + number);
                const res = await fetch(url, { method: 'POST' });
                const response = await res.json();
            },
        },
    };
</script>

<style scoped>
    .load-more,
    .log-item .day-name {
        padding: 2em 0 0 0;
        color: #000;
    }

    .log-item:first-child .day-name {
        padding: 0;
    }

    .log-item .day-name .label {
        background-color: rgba(255, 255, 255, .5);
        font-weight: bold;
        padding: .5em 2em;
    }

    .panel-body {
        overflow: visible;
    }

    /deep/ .affix {
        width: 250px;
        overflow: visible;
    }
</style>
