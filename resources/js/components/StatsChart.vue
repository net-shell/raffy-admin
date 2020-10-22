<template>
  <div class="panel panel-bordered">
    <div class="panel-heading">
      <p class="lead reader-name">
        <a
          role="button"
          data-toggle="collapse"
          :href="'#reader-' + reader.id"
          data-parent="#reader-monitor"
        >
          <p>
            <span class="icon voyager-location"></span>
            {{ reader.name }}
          </p>
          <p class="activity" v-if="lastUpdated">
            <span class="icon voyager-alarm-clock"></span>
            Последна активност:
            <b>{{ lastUpdated }}</b>
          </p>
        </a>
      </p>
    </div>
    <div
      :id="'reader-' + reader.id"
      class="panel-collapse collapse"
      :class="reader.stats ? 'in' : ''"
    >
      <div class="panel-body">
        <div class="row">
          <div class="col-sm-12">
            <p v-if="stats">
              <span class="icon voyager-laptop"></span>
              {{ stats.platform }}
            </p>
          </div>
          <div class="col-sm-4" v-if="stats && stats.cpu">
            <pie-chart
              :percent="+stats.cpu"
              class="pie"
              label-small="процесор"
              :color="getColor(stats.cpu)"
            ></pie-chart>
          </div>
          <div class="col-sm-4" v-if="stats && stats.ram">
            <pie-chart
              :percent="+stats.ram"
              class="pie"
              label-small="RAM"
              :color="getColor(stats.ram)"
            ></pie-chart>
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
      </div>
    </div>
  </div>
</template>

<script>
import PieChart from "vue-pie-chart/src/PieChart.vue";

export default {
  props: ["reader"],
  components: {
    "pie-chart": PieChart
  },
  computed: {
    stats() {
      return this.reader.stats;
    },
    lastUpdated() {
      let moment = window.moment(this.reader.updated_at);
      return moment.fromNow() + ' - ' + moment.format('lll');
    },
    diskPercent() {
      return (this.stats.hdd_used / this.stats.hdd_total) * 100;
    },
    diskLabel() {
      return this.stats.hdd_used + " от " + this.stats.hdd_total + " GB";
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

.reader-name {
  margin: 0;
  padding: .5em;
}

.reader-name a {
  display: block;
}

.activity {
  font-size: .5em;
  line-height: 1;
  margin: 0;
}
</style>