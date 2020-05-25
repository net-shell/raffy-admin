<template>
  <div class="row">
    <div class="col-md-7">
      <h1 class="page-title">
        <i class="voyager-eye"></i>
        Монитор на записите в реално време
      </h1>
      <div class="page-content containter-fluid">
        <div v-for="request in newRequests" :key="request.id">
          <tag-request :request="request"></tag-request>
        </div>
        <div v-for="log in logs" :key="log.id">
          <log-entry :log="log"></log-entry>
        </div>
      </div>
    </div>
    <div class="live-clock big-clock col-md-5 text-center">
      <notifications group="reader" />
      <div class="panel panel-bordered">
        <div class="panel-body">
          <h1>{{ liveTime }}</h1>
          <h3>{{ liveDate }}</h3>
          <clock size="300px"></clock>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Clock from "vue-clock2";
export default {
  props: ["lastLogs"],
  components: { Clock },
  mounted() {
    setInterval(this.updateTimestamp, 1000);
    this.updateTimestamp();
  },
  created() {
    this.$root.$on("tag-logged", this.onEntryLogged);
    this.$root.$on("tag-requested", this.onTagRequested);
  },
  data() {
    return {
      newLogs: [],
      newRequests: [],
      timestamp: null
    };
  },
  computed: {
    logs() {
      let last = JSON.parse(this.lastLogs);
      if (!last || !last.length) {
        return this.newLogs;
      }
      return this.newLogs.concat(last);
    },
    liveTime() {
      if (!this.timestamp) return;
      return this.timestamp.format("HH:mm:ss");
    },
    liveDate() {
      if (!this.timestamp) return;
      return this.timestamp.format("dddd L");
    }
  },
  methods: {
    updateTimestamp() {
      this.timestamp = window.moment();
    },
    onEntryLogged(log) {
      this.newLogs.unshift(log);
    },
    onTagRequested(tagId, reader) {
      this.newRequests = this.newRequests.filter(r => r.tagId != tagId);
      this.newRequests.unshift({
        id: window.moment().format("X"),
        tagId: tagId,
        reader: reader,
        creation_time: window.moment().format("HH:mm:ss"),
        creation_date: window.moment().format("dddd L")
      });
    }
  }
};
</script>

<style scoped>
.big-clock h1 {
  font-size: 8em;
  margin: 0;
  overflow: hidden;
}
</style>