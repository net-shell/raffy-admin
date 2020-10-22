<template>
  <div class="row">
    <div class="col-sm-12" id="reader-monitor" v-for="reader in readers" :key="reader.id">
      <stats-chart :reader="reader"></stats-chart>
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
</style>
