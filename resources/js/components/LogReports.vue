<template>
    <div>
        <h1 class="page-title">
            <i class="voyager-logbook"></i> Отчети
        </h1>
        <div class="page-content">
            <div class="row">
                <div class="col-sm-4">
                    <div class="panel panel-bordered">
                        <div class="panel-body filters">
                            <div class="row">
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
                                <div class="col-sm-12">
                                    <label class="control-label">Отдел:</label>
                                    <multiselect
                                        v-model="filter.section"
                                        placeholder="Търсене и избор на отдел..."
                                        track-by="id"
                                        label="text"
                                        :options="sections"
                                    ></multiselect>
                                </div>
                                <div class="col-sm-12">
                                    <label class="control-label">Служител:</label>
                                    <multiselect
                                        v-model="filter.users"
                                        placeholder="Търсене и избор на служител..."
                                        track-by="id"
                                        label="name"
                                        :options="users"
                                        :multiple="true"
                                    ></multiselect>
                                </div>
                                <div class="col-sm-12">
                                    <label class="control-label">Четец:</label>
                                    <multiselect
                                        v-model="filter.reader"
                                        placeholder="Избор на четец..."
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
                    <div class="panel panel-bordered" v-if="loading">
                        <div class="panel-body text-center">
                            <p class="lead">Зареждане...</p>
                        </div>
                    </div>
                    <div v-if="!loading && results.length">
                        <button type="button" class="btn btn-success" @click="getResultsCsv()">
                            <i class="icon voyager-file-text"></i>
                            Свали като CSV
                        </button>
                        <button type="button" class="btn btn-warning" @click="getResultsExcel()">
                            <i class="icon voyager-file-text"></i>
                            Свали като Excel
                        </button>
                        <button type="button" class="btn btn-warning" @click="getResultsPdf()">
                            <i class="icon voyager-file-text"></i>
                            Свали като PDF
                        </button>
                    </div>
                    <div class="panel panel-bordered" v-if="!loading">
                        <div class="panel-body" v-if="!results.length">
                            <p class="lead">Няма открити резултати.</p>
                        </div>
                        <div class="panel-body report-table" v-if="results.length">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th v-for="title in headings">{{ title }}</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="result in results" :key="result[0]">
                                    <td v-for="seconds, s in result">
                                        <div v-if="seconds === 0">
                                            {{ seconds }}
                                        </div>
                                        <div v-if="seconds !== 0">
                                            <span class="badge" v-if="s == 0">
                                                {{ seconds }}
                                            </span>
                                            <span class="badge" v-if="s > 0">
                                                {{ getHoursFromS(seconds) }}
                                            </span>
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

    export default {
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
            getHoursFromS(seconds) {
                if (seconds == 0) return 0;
                let h = Math.floor(seconds / 3600);
                let m = Math.floor(seconds % 3600 / 60);
                return h + ":" + m;
            },
        }
    };
</script>

<style scoped>
    .filters {
        padding: 20px;
        overflow: visible;
    }

    .filters .row > div {
        margin: 0;
    }

    .report-table {
        overflow-x: scroll;
        padding: .5em;
    }

    .report-table .badge {
        font-weight: bold;
        font-size: 1em;
        background-color: #fffddd;
        color: #000;
    }
</style>
