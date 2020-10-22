<template>
  <div class="row">
    <div class="col-sm-12" id="reader-monitor" v-for="reader in readers" :key="reader.id">
      <div class="panel panel-bordered">
        <div class="panel-heading">
          <p class="lead reader-name">
            <a
              role="button"
              data-toggle="collapse"
              :href="'#reader-' + reader.id"
              data-parent="#reader-monitor"
            >
              <span class="icon voyager-location"></span>
              {{ reader.name }}
            </a>
          </p>
        </div>
        <div :id="'reader-' + reader.id" class="panel-collapse collapse" :class="reader.stats ? 'in' : ''">
          <div class="panel-body">
            <stats-chart :stats="reader.stats" :updated="reader.updated_at"></stats-chart>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  mounted() {
    this.$root.$on("reader-started", this.onReaderStarted);
  },
  created() {
    this.getReaders();
    let me = this;
    setInterval(function() {
      console.log("regular update");
      me.getReaders();
    }, 18000);
  },
  data() {
    return {
      readers: []
    };
  },
  methods: {
    async getReaders() {
      let url = "/api/reader";
      const res = await fetch(url);
      const readers = await res.json();
      this.readers = readers.data;
    },
    onReaderStarted(reader) {
      console.log("STARTED", reader);
      this.getReaders();
    }
  }
};
</script>

<style scoped>
.reader-name {
  margin: 0;
  line-height: 2;
}

.reader-name a {
  display: block;
  text-align: left;
}
</style>
