<template>
    <div class="log-entry attention-zoom" v-if="log">
        <div class="panel panel-bordered">
            <div class="panel-body" :class="showDetails ? 'active' : ''" @click="showDetails = !showDetails">
                    <div class="row">
                        <div class="col-sm-4 no-padding no-margin details">
                            <div class="avatar pull-left"
                                 v-if="log.user">
                                <img class="img-responsive img-circle"
                                     :src="getImageSource(log.user)"
                                     :id="'avatar-' + log.id"
                                />
                                <popover :title="log.user.name" :target="'#avatar-' + log.id" trigger="hover"
                                         placement="right">
                                    <template slot="popover">
                                        <img class="img-responsive" :src="getImageSource(log.user)"/>
                                    </template>
                                </popover>
                            </div>
                            <h3 class="name" v-if="log.user">{{ log.user.name }}</h3>
                            <div class="text-uppercase" v-if="showDetails && log.user && log.user.section">
                                <div class="text-info">
                                    <span class="icon voyager-company"></span>
                                    отдел
                                    {{ log.user.section.name }}
                                </div>
                                <div>
                                    <span class="icon voyager-location"></span>
                                    {{ log.reader.name }}
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 no-padding no-margin details">
                            <div class="row condensed timestamps" style="margin: 0;">
                                <div class="col-xs-6 time-entry text-danger">
                                    <div class="row condensed" style="margin: 0;">
                                        <div class="col-xs-6 time-entry">
                                            <p class="lead highlighted">ВХОД</p>
                                            <p>{{ entryDiff }}</p>
                                        </div>
                                        <div class="col-xs-6 time-entry">
                                            <p class="lead">{{ entryTime }}</p>
                                            <p>
                                                <span v-show="showDetails">{{ entryDate }}</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6 time-entry text-info">
                                    <div class="row condensed" style="margin: 0;">
                                        <div class="col-xs-6 time-exit attention-zoom" v-if="momentExited">
                                            <p class="lead highlighted">ИЗХОД</p>
                                            <p>{{ exitDiff }}</p>
                                        </div>
                                        <div class="col-xs-3 6 time-exit attention-zoom" v-if="momentExited">
                                            <p class="lead">{{ exitTime }}</p>
                                            <p>
                                                <span v-show="showDetails">{{ exitDate }}</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
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
                showDetails: false,
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
            getImageSource(user) {
                return '/storage/' + user.avatar;
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
    .log-entry .row {
        margin: 0 5px;
    }

    .log-entry > .panel {
        margin-bottom: 1px;
        background-color: rgba(255, 255, 255, .7);
         -webkit-transition: background .3s ease-out;
        -moz-transition: background .3s ease-out;
        -o-transition: background .3s ease-out;
        transition: background .3s ease-out;
    }

    .log-entry > .panel:hover {
        background: #fff;
        color: #000;
    }

    .log-entry .panel-body {
        padding: 0;
    }

    .log-entry .panel-body.active {
        background: #fff;
        color: #000;
    }

    .log-entry .row.condensed {
        margin: 0 15px 0 0;
    }

    .log-entry .panel-body .avatar {
        object-fit: cover;
        object-position: center center;
        height: 50px;
        width: 50px;
        margin-right: 1em;
        margin-left: -1em;
    }

    .log-entry .panel-body.active .avatar {
        height: 110px;
        width: 110px;
    }

    .log-entry .name {
        margin: 0.5em 0;
        color: #000;
    }

    .log-entry .timestamps p {
        margin: 0;
        margin-right: 1em;
    }

    .log-entry .time-entry {
    }

    .log-entry .time-exit {
    }

    .log-entry .time-entry > .lead,
    .log-entry .time-exit > .lead {
        font-weight: bold;
    }
</style>
