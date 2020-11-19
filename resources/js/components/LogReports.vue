<template>
    <div>
        <div class="page-content">
            <div class="row">
                <div class="col-sm-4">
                    <div class="panel panel-bordered">
                        <div class="panel-body filters">
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="control-label so-big">
                                        <i class="icon text-info voyager-search"></i>
                                        Филтри
                                    </label>
                                </div>
                            </div>
                            <div class="row bg-info">
                                <div class="col-sm-6">
                                    <label class="control-label">Период от:</label>
                                    <datepicker
                                        v-model="filter.from"
                                        :language="bg"
                                        input-class="form-control"
                                        :monday-first="true"
                                        :format="dateFormat"
                                    ></datepicker>
                                </div>
                                <div class="col-sm-6">
                                    <label class="control-label">до:</label>
                                    <datepicker
                                        v-model="filter.to"
                                        :language="bg"
                                        input-class="form-control"
                                        :monday-first="true"
                                        :format="dateFormat"
                                    ></datepicker>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="control-label">Отдел:</label>
                                    <multiselect
                                        v-model="filter.section"
                                        placeholder="Филтриране по отдел..."
                                        track-by="id"
                                        label="text"
                                        :options="sections"
                                    ></multiselect>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="control-label">Служители:</label>
                                    <multiselect
                                        v-model="filter.users"
                                        placeholder="Филтриране по служители..."
                                        track-by="id"
                                        label="name"
                                        :options="users"
                                        :multiple="true"
                                    ></multiselect>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="control-label">Четец:</label>
                                    <multiselect
                                        v-model="filter.reader"
                                        placeholder="Филтриране по четец..."
                                        track-by="id"
                                        label="text"
                                        :options="readers"
                                    ></multiselect>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="alert alert-info so-big" v-if="loading">
                        <div class="text-center">
                            <p class="lead">
                                <i class="icon voyager-refresh"></i>
                                Зареждане...
                            </p>
                            <div class="progress">
                                <div class="progress-bar progress-bar-striped progress-bar-success" role="progressbar" style="width: 92%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-bordered" v-if="!loading">
                        <div class="panel-body heading-row">
                              <div class="row">
                                  <div class="col-sm-3">
                                      <p class="so-big">
                                          <i class="icon text-success voyager-logbook"></i>
                                          Отчет
                                      </p>
                                  </div>
                                  <div class="col-sm-9">
                                      <p class="text-right so-big">
                                          <i class="icon voyager-info-circled"></i>
                                          <small>
                                              Показване на
                                              <b>{{ results.length }}</b>
                                              служители
                                          </small>
                                          <button class="btn btn-circle" :class="!simpleView ? 'btn-success' : 'btn-default'" v-on:click="toggleSimpleView" type="button">
                                              <i class="icon voyager-search"></i>
                                              <i class="icon voyager-dot-3"></i>
                                          </button>
                                          <button class="btn btn-circle btn-default" v-on:click="getResults" type="button">
                                              <i class="icon voyager-refresh"></i>
                                          </button>
                                      </p>
                                  </div>
                              </div>
                        </div>
                    </div>
                    <div class="panel panel-bordered" v-if="!loading && results.length">
                        <div class="panel-body panel-dense">
                            <div class="form form-horizontal text-center">
                                <label class="control-label so-big">
                                    <i class="icon text-success voyager-book-download"></i>
                                    Запазване като:
                                </label>
                                <button type="button" class="btn btn-success" @click="getResultsCsv()">
                                    <i class="icon voyager-download"></i>
                                    {{ filename }}
                                    <b>.CSV</b>
                                </button>
                                <button type="button" class="btn btn-default" @click="getResultsExcel()">
                                    <i class="icon voyager-download"></i>
                                    {{ filename }}
                                    <b>.XLSX</b>
                                </button>
                                <button type="button" class="btn btn-default" @click="getResultsPdf()">
                                    <i class="icon voyager-download"></i>
                                    {{ filename }}
                                    <b>.PDF</b>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-bordered" v-if="!loading">
                        <div class="panel-body" v-if="!results.length">
                            <p class="lead">Няма открити резултати.</p>
                        </div>
                        <div class="panel-body panel-dense report-table" v-if="results.length">
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
                                    <td v-for="seconds in result">
                                        <div v-if="seconds === 0">
                                            {{ seconds }}
                                        </div>
                                        <div v-if="seconds !== 0">
                                            <span class="badge">{{ seconds }}</span>
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
    import {bg} from "vuejs-datepicker/dist/locale";
    import {AgGridVue} from "ag-grid-vue";

    export default {
        props: ['filename'],
        components: { AgGridVue },
        data() {
            return {
                bg: bg,
                filter: {
                    from: new Date(),
                    to: new Date(),
                    section: null,
                    users: [],
                    reader: null,
                },
                allUsers: [],
                readers: [],
                results: [],
                simpleView: true,
                loading: true,
                headings: [],
                sections: [],
            };
        },
        created() {
            this.getUsers();
            this.getSections();
            this.getReaders();
            this.getResults();
        },
        watch: {
            filter: {
                deep: true,
                handler() {
                    this.getResults();
                }
            },
        },
        computed: {
            users() {
                if (!this.filter.section || !this.filter.section.id)
                    return this.allUsers;
                let sid = this.filter.section.id;
                let users = this.allUsers.filter(u => u.section_id == sid);
                return users || [];
            },
            columnDefs() {
                let defs = [];
                for(let h in this.headings) {
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
            async getUsers() {
                let url = "/api/workers";
                const res = await fetch(url);
                const users = await res.json();
                this.allUsers = users.results;
            },
            async getReaders() {
                let url = "/logs/relation?type=log_belongsto_reader_relationship";
                const res = await fetch(url);
                const readers = await res.json();
                this.readers = readers.results;
            },
            async getSections() {
                let url = '/users/relation?type=user_belongsto_section_relationship';
                const res = await fetch(url);
                const sections = await res.json();
                this.sections = sections.results;
            },
            getResults() {
                this.loading = true;
                let url = "/report-json";
                const res = axios
                    .post(url, this.filter, {
                        headers: {"Content-type": "application/json"}
                    })
                    .then(
                        response => {
                            let results = response.data.data;
                            this.results = results[Object.keys(results)[0]];
                            this.headings = response.data.headings;
                        },
                        error => {
                            console.log(error);
                        }
                    )
                    .finally(() => (this.loading = false));
            },
            getResultsExcel() {
                this.downloadReport("/report-excel", "report.xls");
            },
            getResultsCsv() {
                this.downloadReport("/report-csv", "report.csv");
            },
            getResultsPdf() {
                this.downloadReport("/report-pdf", "report.pdf");
            },
            downloadReport(url, filename) {
                const request = axios
                    .post(url, this.filter, {
                        headers: {"Content-type": "application/json"}
                    })
                    .then(
                        response => {
                            console.log(response, request);
                            fileDownload(response.data, filename);
                        },
                        error => {
                            console.log(error);
                        }
                    );
            },
            dateFormat(date) {
                return moment(date).format("dddd DD MMMM YYYY");
            },
            toggleSimpleView() {
                this.simpleView = !this.simpleView;
            },
        }
    };
</script>

<style scoped>
    /deep/ .form-control[readonly] {
        background-color: #fff;
    }

    /deep/ b {
        font-weight: bold;
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
</style>
