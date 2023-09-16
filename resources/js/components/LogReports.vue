<template>
    <div>
        <div class="page-content">
            <notify-area></notify-area>
            <div class="row">
                <div class="col-sm-7">
                    <filter-report @update-filter="handleUpdateFilter"></filter-report>
                </div>
                <div class="col-sm-5">
                    <div class="panel panel-bordered">
                        <div class="panel-body heading-row bg-info">
                            <div class="row">
                                <div class="col-sm-6">
                                    <p class="so-big">
                                        <i class="icon text-success voyager-logbook"></i>
                                        <span>Вид отчет:</span>
                                    </p>
                                    <div class="form form-horizontal">
                                        <multiselect
                                            v-model="type"
                                            :options="types"
                                            :allow-empty="false"
                                            track-by="id"
                                            label="name"
                                        ></multiselect>
                                    </div>
                                </div>
                                <div class="col-sm-6" v-if="!loading">
                                    <p class="text-right so-big">
                                        <button class="btn btn-circle"
                                                :class="!simpleView ? 'btn-success' : 'btn-default'"
                                                v-on:click="toggleSimpleView" type="button">
                                            <i class="icon voyager-search"></i>
                                            <span>Разширена таблица</span>
                                        </button>
                                        <button class="btn btn-circle btn-default" v-on:click="getResults"
                                                type="button">
                                            <i class="icon voyager-refresh"></i>
                                        </button>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-bordered" v-if="!loading && results.length">
                        <div class="panel-body panel-dense">
                            <div class="form form-horizontal">
                                <label class="control-label so-big">
                                    <i class="icon text-success voyager-book-download"></i>
                                    <span>
                                        Запази отчета като:
                                    </span>
                                </label>
                                <button type="button" class="btn btn-default" @click="getResultsExcel()">
                                    <i class="icon voyager-download"></i>
                                    <b>Excel</b>
                                </button>
                                <button type="button" class="btn btn-default" @click="getResultsPdf()">
                                    <i class="icon voyager-download"></i>
                                    <b>PDF</b>
                                </button>
                                <button type="button" class="btn btn-default" @click="getResultsCsv()">
                                    <i class="icon voyager-download"></i>
                                    <b>CSV</b>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12" v-if="loading">
                    <div class="alert alert-default so-big">
                        <div class="text-center">
                            <p class="lead">
                                <i class="icon voyager-refresh"></i>
                                Зареждане... Моля, изчакайте.
                            </p>
                            <div class="progress">
                                <div class="progress-bar progress-bar-striped progress-bar-success" role="progressbar"
                                     style="width: 92%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="panel panel-bordered" v-if="!loading">
                        <div class="panel-body" v-if="!results.length">
                            <p class="lead">Няма открити резултати.</p>
                        </div>
                        <div class="panel-body panel-dense report-table" v-if="results.length">
                            <div class="row">
                                <div class="col-sm-12 no-margin">
                                    <p class="results-count bg-info text-center">
                                        <i class="icon voyager-logbook"></i>
                                        Показване на отчет за
                                        <b>{{ results.length }}</b>
                                        служители
                                    </p>
                                </div>
                            </div>
                            <ag-grid-vue style="height: 500px;"
                                         class="ag-theme-alpine"
                                         :columnDefs="columnDefs"
                                         :rowData="results"
                                         v-if="!simpleView">
                            </ag-grid-vue>
                            <table v-if="simpleView" class="table table-hover">
                                <thead>
                                <tr>
                                    <th v-for="title in headings">{{ title }}</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="result in results" :key="result[0]">
                                    <td v-for="timing in result">
                                        <div v-if="timing === 0">
                                            {{ timing }}
                                        </div>
                                        <div v-if="timing !== 0">
                                            <span class="badge">{{ timing }}</span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import "ag-grid-community/styles/ag-grid.css";
    import "ag-grid-community/styles/ag-theme-alpine.css";
    import {AgGridVue} from "ag-grid-vue";

    export default {
        components: {AgGridVue},
        data() {
            return {
                type: { id: "sumTime", name: "Отчетено време" },
                types: [
                    { id: "sumTime", name: "Отчетено време" },
                    { id: "workTime", name: "Работно време" },
                    { id: "absent", name: "Отсъстващи служители" },
                ],
                filter: {},
                results: [],
                simpleView: true,
                loading: true,
                headings: [],
            };
        },
        computed: {
            columnDefs() {
                let defs = [];
                for (let h in this.headings) {
                    defs.push({
                        headerName: this.headings[h],
                        field: h,
                        sortable: true,
                        filter: true,
                    });
                }
                return defs;
            },
        },
        methods: {
            handleUpdateFilter(filter) {
                this.filter = filter;
                this.getResults();
            },
            getResults() {
                this.loading = true;
                axios.get(this.getReportUrl("/report-json"))
                    .then(
                        response => {
                            this.results = response.data.data;
                            this.headings = response.data.headings;
                        },
                        error => {
                            console.log(error);
                        }
                    )
                    .finally(() => (this.loading = false));
            },
            getResultsExcel() {
                this.downloadReport("/report-excel");
            },
            getResultsCsv() {
                this.downloadReport("/report-csv");
            },
            getResultsPdf() {
                this.downloadReport("/report-pdf");
            },
            downloadReport(url) {
                window.location.assign(this.getReportUrl(url));
            },
            getReportUrl(url) {
                return url + "?t=" + Date.now()
                    + "&filter=" + JSON.stringify(this.filter)
                    + "&type=" + this.type.id;
            },
            toggleSimpleView() {
                this.simpleView = !this.simpleView;
            },
        },
        watch: {
            type() {
                this.getResults();
            },
        },
    };
</script>

<style scoped>
    /deep/ .form-control[readonly] {
        background-color: #fff;
    }

    /deep/ b {
        font-weight: bold;
    }
    .panel-body {
        overflow: visible;
    }

    .filters {
        padding: 20px;
        overflow: visible;
    }

    .filters .row > div {
        margin: 0 0 .5em 0;
    }

    .heading-row > .row > div {
        margin: 0;
    }

    .panel-dense {
        padding: .5em;
    }

    .report-table {
        overflow-x: scroll;
    }

    .report-table .badge {
        font-weight: bold;
        font-size: 1em;
        background-color: #fffddd;
        color: #000;
    }

    .so-big {
        font-size: 1.6em;
        vertical-align: middle;
    }

    .so-big.alert {
        padding: .5em;
        margin-bottom: 1em;
        font-size: 1.2em;
        text-align: center;
        opacity: .8;
    }

    .so-big .icon {
        font-size: 2em;
        vertical-align: middle;
        line-height: 1;
    }

    .results-count {
        margin: 0;
    }
</style>
