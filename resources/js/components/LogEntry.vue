<template>
  <div class="log-entry attention-zoom" v-if="log">
    <div class="well no-margin no-padding">
      <div class="row">
        <div class="col-sm-4 no-margin">
          <img class="img-responsive" :src="'/storage/' + log.user.avatar" />
        </div>
        <div class="col-sm-8 no-padding no-margin details">
          <div>
            <h3 class="name">
              {{ log.user.name }}
            </h3>
            <p v-if="log.user.section">
              <span class="icon voyager-company"></span>
              {{ log.user.section.name }}
            </p>
          </div>
          <div class="row condensed">
            <div class="col-xs-6">
              <p>ВХОД</p>
              <div class="alert alert-success">
                <p>{{ liveDiff }}</p>
                <p class="lead">{{ liveTime }}</p>
                <p>{{ liveDate }}</p>
              </div>
            </div>
            <div class="col-xs-6">
              <p>ИЗХОД</p>
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
      momentCreated: null
    };
  },
  mounted() {
    setInterval(this.createMoment, 60000);
    this.createMoment();
  },
  computed: {
    liveDiff() {
      if (!this.momentCreated) return;
      return this.momentCreated.fromNow();
    },
    liveTime() {
      if (!this.momentCreated) return;
      return this.momentCreated.format("HH:mm:ss");
    },
    liveDate() {
      if (!this.momentCreated) return;
      return this.momentCreated.format("dddd L");
    }
  },
  methods: {
    createMoment() {
      this.momentCreated = window.moment(this.log.created_at);
    }
  }
};
</script>

<style scoped>
.log-entry {
  padding: 0;
  margin: 1em 0;
  border: 1px solid #333;
}

.log-entry .row.condensed {
  margin: 0 15px 0 0;
}

.log-entry .img-responsive {
  max-height: 200px;
}

.log-entry .name {
  margin: 0 0 .5em 0;
}

.log-entry .alert {
  padding: .5em 1.5em;
  margin: 0;
}

.log-entry .alert > h3 {
  margin: .2em 0;
}

.log-entry .alert > h4 {
  margin: 0;
}
</style>