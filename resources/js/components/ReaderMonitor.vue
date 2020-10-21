<template>
  <div class="row">
    <div class="col-sm-12">
      <h3>Четци</h3>
    </div>
    <div class="col-sm-6" v-for="reader in readers" :key="reader.id">
      <div class="panel panel-bordered">
        <div class="panel-body">
          <h4>{{ reader.name }}</h4>
          <stats-chart :stats="reader.stats" :updated="reader.updated_at"></stats-chart>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  mounted() {},
  created() {
    this.$root.$on("reader-started", this.onReaderStarted);
    this.getReaders();
    setInterval(this.getReaders, 60000);
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
