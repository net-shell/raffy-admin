<template>
    <div>
        <div v-for="reader in readers" :key="reader.id">
            <!--<button type="button" @click="emitLast">emit last</button>-->
            <stats-chart :reader="reader" :pie-stroke="2"></stats-chart>
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
            setInterval(function () {
                me.getReaders();
            }, 30000);
        },
        data() {
            return {
                readers: []
            };
        },
        methods: {
            async getReaders() {
                let url = "/api/readers";
                const res = await fetch(url);
                const readers = await res.json();
                this.readers = readers.data;
                this.$emit('update-count', this.readers.length);
            },
            async emitLast() {
                let url = "/api/emit-last";
                const res = await fetch(url);
                const log = await res.json();
                console.log('EMITTED', log)
            },
            onReaderStarted(reader) {
                this.getReaders();
            },
        }
    };
</script>
