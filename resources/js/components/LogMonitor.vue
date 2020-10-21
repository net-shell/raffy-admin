<template>
  <div class="row">
    <div class="col-md-7">
      <div class="panel panel-bordered">
        <div class="panel-body">
          <div class="branding">
            <img class="logo" :src="logo" />
            Система за контрол на достъпа
          </div>
        </div>
      </div>
      <div class="page-content containter-fluid">
        <div v-for="request in newRequests" :key="request.id">
          <tag-request :request="request"></tag-request>
        </div>
        <div v-for="log in logs" :key="log.id">
          <log-entry ref="logs" :log="log"></log-entry>
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
      <reader-monitor></reader-monitor>
    </div>
  </div>
</template>

<script>
import Clock from "vue-clock2";
export default {
  props: ["lastLogs", "logo", "color", "brand"],
  components: { Clock },
  mounted() {
    setInterval(this.updateTimestamp, 1000);
    this.updateTimestamp();
  },
  created() {
    this.$root.$on("tag-logged", this.onEntryLogged);
    this.$root.$on("tag-requested", this.onTagRequested);
    this.$on("log-added", this.playLogAudio);
    this.$on("log-updated", this.playLogAudio);
    this.lastParsed = JSON.parse(this.lastLogs);
  },
  data() {
    return {
      newLogs: [],
      lastParsed: [],
      newRequests: [],
      timestamp: null,
      readers: [],
      selectedReader: null,
    };
  },
  computed: {
    logs() {
      if (!this.lastParsed || !this.lastParsed.length) {
        return this.newLogs;
      }
      let logs = this.newLogs.concat(this.lastParsed);
      if (this.selectedReader) {
        logs = logs.filter((l) => l.reader_id == this.selectedReader.id);
      }
      return logs;
    },
    liveTime() {
      if (!this.timestamp) return;
      return this.timestamp.format("HH:mm:ss");
    },
    liveDate() {
      if (!this.timestamp) return;
      return this.timestamp.format("dddd L");
    },
  },
  methods: {
    updateTimestamp() {
      this.timestamp = window.moment();
    },
    onEntryLogged(log) {
      if (this.logs.filter((l) => l.id == log.id).length > 0) {
        // Update existing log
        if (this.newLogs.filter((l) => l.id == log.id).length > 0) {
          let i = this.newLogs.findIndex((l) => l.id == log.id);
          this.newLogs.splice(i, 1);
          this.newLogs.unshift(log);
        } else if (this.lastParsed.filter((l) => l.id == log.id).length > 0) {
          let i = this.lastParsed.findIndex((l) => l.id == log.id);
          this.lastParsed.splice(i, 1);
          this.lastParsed.unshift(log);
        }
        this.$emit('log-updated', log);
      } else {
          // Add to new logs
        this.newLogs.unshift(log);
        this.$emit('log-added', log);
      }
    },
    onTagRequested(tagId, reader) {
      this.newRequests = this.newRequests.filter((r) => r.tagId != tagId);
      this.newRequests.unshift({
        id: window.moment().format("X"),
        tagId: tagId,
        reader: reader,
        creation_time: window.moment().format("HH:mm:ss"),
        creation_date: window.moment().format("dddd L"),
      });
    },
    playLogAudio(log) {
        let sound = log.exited_at ? 'close_sound' : 'open_sound';
        this.playAudio(sound);
    },
    playAudio(name) {
        let el = document.getElementById('audio_' + name);
        if(!el) return;
        el.currentTime = 0;
        el.play();
    }
  },
};
</script>

<style scoped>
.big-clock h1 {
  font-size: 8em;
  margin: 0;
  overflow: hidden;
}

.branding {
  font-size: 2em;
  text-transform: uppercase;
  font-weight: normal;
  line-height: 1;
}

.branding .logo {
  width: auto;
  height: 2em;
}
</style>
