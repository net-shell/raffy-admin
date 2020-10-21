<template>
  <div class="row">
    <div class="col-sm-12">
      <p v-if="lastUpdated">Последна активност: {{ lastUpdated }}</p>
      <p v-if="stats">{{ stats.platform }}</p>
    </div>
    <div class="col-sm-6" v-if="stats && stats.cpu">
      <h3 class="text-center">CPU</h3>
      <pie-chart :percent="+stats.cpu" :label="stats.cpu + '%'"></pie-chart>
    </div>
    <div class="col-sm-6" v-if="stats && stats.ram">
      <h3 class="text-center">RAM</h3>
      <pie-chart :percent="+stats.ram" :label="stats.ram + '%'"></pie-chart>
    </div>
    <div class="col-sm-12" v-if="!stats">
      <i>Няма данни от този четец.</i>
    </div>
  </div>
</template>

<script>
import PieChart from "vue-pie-chart/src/PieChart.vue";

export default {
  props: ["stats", "updated"],
  components: {
    "pie-chart": PieChart
  },
  computed: {
    lastUpdated() {
      return window.moment(this.updated).fromNow();
    }
  },
  mounted() {}
};
</script>

<style>
</style>