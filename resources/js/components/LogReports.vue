<template>
  <div>
    <h1 class="page-title">
      <i class="voyager-logbook"></i> Отчети
    </h1>
    <div class="page-content">
      <div class="panel panel-bordered">
        <div class="panel-body filters">
          <div class="row">
            <div class="col-sm-3">
              <label class="control-label">Период от:</label>
              <datepicker
                v-model="filter.from"
                :language="bg"
                input-class="form-control"
                :monday-first="true"
              ></datepicker>
            </div>
            <div class="col-sm-3">
              <label class="control-label">до:</label>
              <datepicker
                v-model="filter.to"
                :language="bg"
                input-class="form-control"
                :monday-first="true"
              ></datepicker>
            </div>
            <div class="col-sm-6">
              <label class="control-label">Служител:</label>
              <multiselect
                v-model="filter.user"
                placeholder="Търсене и избор на служител..."
                track-by="id"
                label="text"
                :options="users"
              ></multiselect>
            </div>
          </div>
        </div>
      </div>
      <div class="panel panel-bordered">
        <div class="panel-body">
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
        user: null
      },
      users: [],
      results: []
    };
  },
  created() {
    this.getUsers();
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
    getResults() {
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
        );
    },
    formatDate(date) {
      return moment(date).format('DD/MM/YYYY');
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
</style>