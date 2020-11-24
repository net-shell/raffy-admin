<template>
    <div class="panel panel-bordered">
        <div class="panel-heading">
            <p class="reader-name">
                <a
                    role="button"
                    data-toggle="collapse"
                    :href="'#reader-' + reader.id"
                    data-parent="#reader-monitor"
                >
                    <div class="reader-title">
                        <span class="icon voyager-location"></span>
                        {{ reader.name }}
                    </div>
                    <div class="activity bg-metal" v-if="reader.updated_at">
                        <div class="activity-diff">
                            <span class="icon voyager-droplet"></span>
                            {{ lastUpdatedDiff }}
                        </div>
                        <div class="activity-date text-muted">
                            <span class="icon voyager-calendar"></span>
                            {{ lastUpdatedDate }}
                        </div>
                    </div>
                </a>
            </p>
        </div>
        <div
            :id="'reader-' + reader.id"
            class="panel-collapse collapse"
        >
            <div class="panel-body">
                <div class="row pies">
                    <div class="col-sm-6" v-if="stats && stats.cpu_temp">
                        <pie-chart
                            :percent="+stats.cpu_temp"
                            class="pie"
                            :label="tempPercent"
                            label-small="температура"
                            :color="getTempColor(stats.cpu_temp)"
                            :stroke-width="pieStroke"
                        ></pie-chart>
                    </div>
                    <div class="col-sm-6" v-if="stats && stats.ram">
                        <pie-chart
                            :percent="+stats.ram"
                            class="pie"
                            label-small="RAM"
                            :color="getColor(stats.ram)"
                            :stroke-width="pieStroke"
                        ></pie-chart>
                    </div>
                    <div class="col-sm-6" v-if="stats && stats.cpu">
                        <pie-chart
                            :percent="+stats.cpu"
                            class="pie"
                            label-small="процесор"
                            :color="getColor(stats.cpu)"
                            :stroke-width="pieStroke"
                        ></pie-chart>
                    </div>
                    <div class="col-sm-6" v-if="stats && stats.hdd_used">
                        <pie-chart
                            :percent="diskPercent"
                            class="pie"
                            :label="diskLabel"
                            label-small="диск"
                            :color="getColor(diskPercent)"
                            :stroke-width="pieStroke"
                        ></pie-chart>
                    </div>
                    <div class="col-sm-12" v-if="!stats">
                        <i>Няма данни от този четец.</i>
                    </div>
                </div>
                <div class="col-sm-12 bg-metal" v-if="stats">
                    <div class="row platform">
                        <div class="col-sm-12">
                            <p class="text-muted">
                                <span class="icon voyager-laptop"></span>
                                {{ stats.platform }}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import PieChart from "vue-pie-chart/src/PieChart.vue";

    export default {
        props: ["reader", "pie-stroke"],
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
                return window.moment(this.reader.updated_at).format('lll');
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
                if (p < 25) return "green";
                else if (p < 50) return "yellow";
                else if (p < 75) return "orange";
                return "red";
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

<style>
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

    .activity {
        padding: 0 .5em;
    }

    .activity,
    .platform {
        font-size: .8em;
        line-height: 2;
        margin: 0;
    }

    .bg-metal {
        background: rgb(238,238,238);
        background: linear-gradient(0deg, rgba(238,238,238,1) 0%, rgba(255,255,255,1) 100%);
    }

    .platform p {
        margin: 0;
    }

    .pies > div,
    .reader-monitor > div {
        margin-bottom: 0 !important;
        padding: 0;
    }
</style>
