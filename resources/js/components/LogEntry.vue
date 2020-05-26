<template>
  <div class="log-entry attention-zoom" v-if="log">
    <div class="panel panel-bordered">
      <div class="panel-body">
        <div class="row">
          <div class="col-sm-3 no-margin">
            <img class="img-responsive" :src="'/storage/' + log.user.avatar" />
          </div>
          <div class="col-sm-9 no-padding no-margin details">
            <div>
              <h3 class="name">{{ log.user.name }}</h3>
              <p class="text-uppercase" v-if="log.user.section">
                <span class="icon voyager-company"></span>
                {{ log.user.section.name }}
              </p>
            </div>
            <div class="row condensed timestamps">
              <div class="col-xs-6 time-entry">
                <p class="lead highlighted">ВХОД</p>
                <p>{{ entryDiff }}</p>
                <p class="lead">{{ entryTime }}</p>
                <p>{{ entryDate }}</p>
              </div>
              <div class="col-xs-6 time-exit">
                <p class="lead highlighted">ИЗХОД</p>
                <p>{{ exitDiff }}</p>
                <p class="lead">{{ exitTime }}</p>
                <p>{{ exitDate }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["log"],
  data() {
    return {
      momentCreated: null,
      momentExited: null
    };
  },
  mounted() {
    setInterval(this.updateMoments, 60000);
    this.updateMoments();
  },
  computed: {
    entryDiff() {
      if (!this.momentCreated) return;
      return this.momentCreated.fromNow();
    },
    entryTime() {
      if (!this.momentCreated) return;
      return this.momentCreated.format("HH:mm:ss");
    },
    entryDate() {
      if (!this.momentCreated) return;
      return this.momentCreated.format("dddd L");
    },
    exitDiff() {
      if (!this.momentExited) return;
      return this.momentExited.fromNow();
    },
    exitTime() {
      if (!this.momentExited) return;
      return this.momentExited.format("HH:mm:ss");
    },
    exitDate() {
      if (!this.momentExited) return;
      return this.momentExited.format("dddd L");
    }
  },
  methods: {
    updateMoments() {
      this.momentCreated = window.moment(this.log.created_at);
      this.momentExited = this.log.exited_at
        ? window.moment(this.log.exited_at)
        : null;
      console.log(this.log);
    }
  },
  watch: {
    log: {
      deep: true,
      handler() {
        this.updateMoments();
      }
    }
  }
};
</script>

<style scoped>
.log-entry .panel-body {
  padding: 0;
}

.log-entry .row.condensed {
  margin: 0 15px 0 0;
}

.log-entry .img-responsive {
  max-height: 200px;
}

.log-entry .name {
  margin: 0.5em 0;
}

.log-entry .timestamps p {
  margin: 0;
}

.log-entry .highlighted {
  border-bottom: 1px solid #666;
}

.log-entry .time-entry {
  color: green;
}

.log-entry .time-exit {
  color: blue;
}
</style>