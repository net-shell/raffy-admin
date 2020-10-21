<template>
  <div class="row">
    <div class="col-sm-12">
      <p v-if="lastUpdated">
        Последна активност:
        <b>{{ lastUpdated }}</b>
      </p>
      <p v-if="stats">{{ stats.platform }}</p>
    </div>
    <div class="col-sm-4" v-if="stats && stats.cpu">
      <pie-chart :percent="+stats.cpu" :label="stats.cpu + '%'" label-small="CPU" :color="getColor(stats.cpu)"></pie-chart>
    </div>
    <div class="col-sm-4" v-if="stats && stats.ram">
      <pie-chart :percent="+stats.ram" :label="stats.ram + '%'" label-small="RAM" :color="getColor(stats.ram)"></pie-chart>
    </div>
    <div class="col-sm-4" v-if="stats && stats.hdd_used">
      <pie-chart :percent="diskPercent" :label="stats.hdd_used + '/' + stats.hdd_total + 'GB'" label-small="HDD" :color="getColor(diskPercent)"></pie-chart>
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
    },
    diskPercent() {
      return (this.stats.hdd_used / this.stats.hdd_total) * 100;
    }
  },
  methods: {
    getColor(p) {
      if(p < 25) return 'green';
      else if(p < 50) return 'yellow';
      else if(p < 75) return 'orange';
      return 'red';
    }
  }
};
</script>

<style>
</style>