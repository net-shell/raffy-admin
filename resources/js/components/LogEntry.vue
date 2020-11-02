<template>
    <div class="log-entry attention-zoom" v-if="log">
        <div class="panel panel-bordered">
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-2 no-margin text-right">
                        <div class="img-square" v-if="log.user">
                            <img class="img-responsive" :src="'/storage/' + log.user.avatar"/>
                        </div>
                    </div>
                    <div class="col-sm-4 no-padding no-margin details">
                        <h3 class="name" v-if="log.user">{{ log.user.name }}</h3>
                        <div class="text-uppercase" v-if="log.user && log.user.section">
                            <div>
                                <span class="icon voyager-location"></span>
                                {{ log.reader.name }}
                            </div>
                            <div>
                                <span class="icon voyager-company"></span>
                                отдел
                                {{ log.user.section.name }}
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 no-padding no-margin details">
                        <div class="row condensed timestamps">
                            <div class="col-xs-6 time-entry">
                                <p class="lead highlighted">ВХОД</p>
                                <p>{{ entryDiff }}</p>
                                <p class="lead">{{ entryTime }}</p>
                                <p>{{ entryDate }}</p>
                            </div>
                            <div class="col-xs-6 time-exit attention-zoom" v-if="momentExited">
                                <p class="lead highlighted">ИЗХОД</p>
                                <p>{{ exitDiff }}</p>
                                <p class="lead">{{ exitTime }}</p>
                                <p>{{ exitDate }}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props: ["log"],
        data() {
            return {
                momentCreated: null,
                momentExited: null,
            };
        },
        mounted() {
            setInterval(this.updateMoments, 60000);
            this.updateMoments();
        },
        computed: {
            entryDiff() {
                if (!this.momentCreated) return;
                return this.momentCreated.fromNow();
            },
            entryTime() {
                if (!this.momentCreated) return;
                return this.momentCreated.format("HH:mm:ss");
            },
            entryDate() {
                if (!this.momentCreated) return;
                return this.momentCreated.format("dddd L");
            },
            exitDiff() {
                if (!this.momentExited) return;
                return this.momentExited.fromNow();
            },
            exitTime() {
                if (!this.momentExited) return;
                return this.momentExited.format("HH:mm:ss");
            },
            exitDate() {
                if (!this.momentExited) return;
                return this.momentExited.format("dddd L");
            },
            duration() {
                if (!this.momentExited) return;
                let diff = this.momentExited.diff(this.momentCreated);
                let duration = moment.duration(diff);
                return (
                    parseInt(duration.asHours()) +
                    ":" +
                    (parseInt(duration.asMinutes()) % 60)
                );
            },
        },
        methods: {
            updateMoments() {
                this.momentCreated = window.moment(this.log.created_at);
                this.momentExited = this.log.exited_at
                    ? window.moment(this.log.exited_at)
                    : null;
            },
        },
        watch: {
            log: {
                deep: true,
                handler() {
                    this.updateMoments();
                },
            },
        },
    };
</script>

<style scoped>
    .log-entry > .panel {
        margin-bottom: 1em;
    }

    .log-entry > .panel:hover {
        background: linear-gradient(180deg, rgb(255, 255, 255) 0%, rgb(222, 222, 222) 100%);
        color: #000;
    }

    .log-entry .panel-body {
        padding: 0;
    }

    .log-entry .row.condensed {
        margin: 0 15px 0 0;
    }

    .log-entry .img-square {
        object-fit: cover;
        object-position: center;
        width: 100px;
        height: 100px;
    }

    .log-entry .name {
        margin: 0.5em 0;
        color: #000;
    }

    .log-entry .timestamps p {
        margin: 0;
    }

    .log-entry .highlighted {
        border-bottom: 1px solid #fff;
    }

    .log-entry .time-entry {
        color: red;
    }

    .log-entry .time-exit {
        color: #04f;
    }

    .log-entry .time-entry > .lead,
    .log-entry .time-exit > .lead {
        font-weight: bold;
    }
</style>
