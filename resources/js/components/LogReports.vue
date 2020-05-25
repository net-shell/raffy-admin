<template>
  <div>
    <h1 class="page-title">
      <i class="voyager-logbook"></i> Отчети
    </h1>
    <div class="page-content">
      <div class="panel panel-bordered">
        <div class="panel-body filters">
          <div class="form-inline">
            <div class="form-group">
              <label class="control-label">Период от:</label>
              <input class="form-control datepicker" type="date" />
            </div>
            <div class="form-group">
              <label class="control-label">до:</label>
              <input class="form-control datepicker" type="date" data-date-format="dd/mm/yyyy" />
            </div>
            <div class="form-group">
              <label class="control-label">Служител:</label>
            </div>
            <div class="form-group">
              <multiselect
                v-model="filter.user"
                placeholder="Търсене и избор на служител..."
                :options="users"></multiselect>
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
                </tbody>
            </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      filter: {
        from: null,
        to: null,
        user: null
      },
      users: ["Ash", "Rain"]
    };
  },
  created() {
    this.getUsers();
  },
  methods: {
    async getUsers() {
      let url = "/logs/relation?type=log_belongsto_user_relationship";
      const res = await fetch(url);
      const users = await res.json();
      this.users = users.results.map(r => r.text);
    }
  }
};
</script>

<style scoped>
.filters {
    padding: 20px;
    overflow: visible;
}
</style>