<template>
  <div class="row">
    <div class="col-sm-12">
      <p v-if="lastUpdated">
        <span class="icon voyager-alarm-clock"></span>
        Последна активност:
        <b>{{ lastUpdated }}</b>
      </p>
      <p v-if="stats">
        <span class="icon voyager-laptop"></span>
        {{ stats.platform }}
      </p>
    </div>
    <div class="col-sm-4" v-if="stats && stats.cpu">
      <pie-chart :percent="+stats.cpu" class="pie" label-small="процесор" :color="getColor(stats.cpu)"></pie-chart>
    </div>
    <div class="col-sm-4" v-if="stats && stats.ram">
      <pie-chart :percent="+stats.ram" class="pie" label-small="RAM" :color="getColor(stats.ram)"></pie-chart>
    </div>
    <div class="col-sm-4" v-if="stats && stats.hdd_used">
      <pie-chart
        :percent="diskPercent"
        class="pie"
        :label="diskLabel"
        label-small="диск"
        :color="getColor(diskPercent)"
      ></pie-chart>
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
    },
    diskLabel() {
      return this.stats.hdd_used + ' от ' + this.stats.hdd_total + ' GB';
    }
  },
  methods: {
    getColor(p) {
      if (p < 25) return "green";
      else if (p < 50) return "yellow";
      else if (p < 75) return "orange";
      return "red";
    }
  }
};
</script>

<style>
.pie {
  transition: stroke 1s ease-in-out;
}
</style>