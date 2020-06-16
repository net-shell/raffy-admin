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
                  ></datepicker>
                </div>
                <div class="col-sm-6">
                  <label class="control-label">до:</label>
                  <datepicker
                    v-model="filter.to"
                    :language="bg"
                    input-class="form-control"
                    :monday-first="true"
                  ></datepicker>
                </div>
                <div class="col-sm-12">
                  <label class="control-label">Служител:</label>
                  <multiselect
                    v-model="filter.user"
                    placeholder="Търсене и избор на служител..."
                    track-by="id"
                    label="text"
                    :options="users"
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
            <div class="panel-body" v-if="results.length">
              <table class="table table-striped table-hover">
                <thead>
                  <tr>
                    <th>Служител</th>
                    <th>От дата</th>
                    <th>До дата</th>
                    <th>Часове</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="result in results" :key="result.user_id">
                    <td>{{ result.user.name }}</td>
                    <td>{{ result.from }}</td>
                    <td>{{ result.to }}</td>
                    <td>{{ (result.seconds / 60 / 60).toFixed(2) }}</td>
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
import { bg } from "vuejs-datepicker/dist/locale";
export default {
  data() {
    return {
      bg: bg,
      filter: {
        from: new Date(),
        to: new Date(),
        user: null,
        reader: null
      },
      users: [],
      readers: [],
      results: [],
      loading: true
    };
  },
  created() {
    this.getUsers();
    this.getReaders();
    this.getResults();
  },
  watch: {
    filter: {
      deep: true,
      handler() {
        this.getResults();
      }
    }
  },
  methods: {
    async getUsers() {
      let url = "/logs/relation?type=log_belongsto_user_relationship";
      const res = await fetch(url);
      const users = await res.json();
      this.users = users.results;
    },
    async getReaders() {
      let url = "/logs/relation?type=log_belongsto_reader_relationship";
      const res = await fetch(url);
      const readers = await res.json();
      this.readers = readers.results;
    },
    getResults() {
      this.loading = true;
      let url = "/report-json";
      const res = axios
        .post(url, this.filter, {
          headers: { "Content-type": "application/json" }
        })
        .then(
          response => {
            this.results = response.data;
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
          headers: { "Content-type": "application/json" }
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
    formatDate(date) {
      return moment(date).format("DD/MM/YYYY");
    }
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
</style>
