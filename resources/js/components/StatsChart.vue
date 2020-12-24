<template>
    <div class="panel panel-bordered">
        <div class="panel-heading">
            <a class="btn btn-block" role="button" @click="showDetails = !showDetails" :class="showDetails ? 'btn-primary' : 'btn-default'">
                <div class="reader-title">
                    <span class="icon voyager-location"></span>
                    {{ reader.name }}
                </div>
                <div class="activity" v-if="reader.updated_at">
                    <div class="activity-diff" v-tooltip.bottom="lastUpdatedDate">
                        <span class="icon voyager-power"></span>
                        {{ lastUpdatedDiff }}
                    </div>
                </div>
            </a>
        </div>
        <collapse v-model="showDetails">
            <div class="panel-body">
                <div class="pies">
                    <div v-if="stats && stats.cpu_temp">
                        <pie-chart
                            :percent="+stats.cpu_temp"
                            class="pie"
                            :label="tempPercent"
                            label-small="температура"
                            :color="getTempColor(stats.cpu_temp)"
                            :stroke-width="pieStroke"
                        ></pie-chart>
                    </div>
                    <div v-if="stats && stats.ram">
                        <label class="control-label">
                            {{ stats.ram }}% RAM
                        </label>
                        <progress-bar v-model="+stats.ram" :type="getColor(+stats.ram)" striped active/>
                    </div>
                    <div v-if="stats && stats.cpu">
                        <label class="control-label">
                            {{ stats.cpu }}% процесор
                        </label>
                        <progress-bar v-model="+stats.cpu" :label-text="stats.cpu + '% процесор'"
                                      :type="getColor(+stats.cpu)" striped active/>
                    </div>
                    <div v-if="stats && stats.hdd_used">
                        <label class="control-label">
                            {{ diskLabel }} диск
                        </label>
                        <progress-bar v-model="diskPercent" :label-text="diskLabel" :type="getColor(diskPercent)"
                                      striped active/>
                    </div>
                    <div v-if="!stats">
                        <i>Няма данни от този четец.</i>
                    </div>
                </div>
                <div class="bg-metal" v-if="stats">
                    <div class="platform">
                        <p class="text-muted">
                            <span class="icon voyager-laptop"></span>
                            {{ stats.platform }}
                        </p>
                    </div>
                </div>
                <button type="button" class="btn btn-default btn-xs btn-block" @click="showDetails = false">
                    <i class="icon voyager-double-up"></i>
                    Скрий детайлите
                </button>
            </div>
        </collapse>
    </div>
</template>

<script>
    import PieChart from "vue-pie-chart/src/PieChart.vue";

    export default {
        props: ["reader", "pie-stroke"],
        data() {
            return {
                showDetails: false
            };
        },
        components: {
            "pie-chart": PieChart
        },
        computed: {
            stats() {
                return this.reader.stats;
            },
            lastUpdatedDiff() {
                return window.moment(this.reader.updated_at).fromNow();
            },
            lastUpdatedDate() {
                return window.moment(this.reader.updated_at).format('llll');
            },
            diskPercent() {
                return (this.stats.hdd_used / this.stats.hdd_total) * 100;
            },
            diskLabel() {
                return this.stats.hdd_used + " от " + this.stats.hdd_total + " GB";
            },
            tempPercent() {
                return (+this.stats.cpu_temp).toFixed(1) + '° C';
            },
        },
        methods: {
            getColor(p) {
                if (p < 25) return "success";
                else if (p < 50) return "info";
                else if (p < 75) return "warning";
                return "danger";
            },
            getTempColor(p) {
                if (p < 60) return "green";
                else if (p < 70) return "yellow";
                else if (p < 80) return "orange";
                return "red";
            },
        }
    };
</script>

<style scoped>
    .voyager .panel {
        margin: 0;
    }

    .panel-heading .btn {
        text-align: left;
    }

    .pie {
        transition: stroke 1s ease-in-out;
    }

    .reader-name {
        margin: 0;
        padding: .5em;
    }

    .reader-name a {
        display: block;
        font-weight: bold;
        text-align: left;
    }

    .reader-name .reader-title {
        color: #333;
        padding: 0 .3em;
    }

    .activity,
    .platform {
        font-size: .8em;
        line-height: 2;
        margin: 0;
    }

    .bg-metal {
        background: rgb(238, 238, 238);
        background: linear-gradient(0deg, rgba(238, 238, 238, 1) 0%, rgba(255, 255, 255, 1) 100%);
    }

    .platform p {
        margin: 0;
        line-height: 1;
    }

    .pies > div,
    .reader-monitor > div {
        margin-bottom: 0 !important;
        padding: 0;
    }
</style>
