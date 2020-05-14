<template>
    <div class="row">
        <div class="col-md-7">
            <h1>Монитор на записите в реално време</h1>
            <div v-for="log in logs" :key="log.id">
                <log-entry :log="log"></log-entry>
            </div>
        </div>
        <div class="live-clock big-clock col-md-5 text-center">
            <h1>{{ liveTime }}</h1>
            <h4>{{ liveDate }}</h4>
            <clock size="300px"></clock>
        </div>
    </div>
</template>

<script>
    import Clock from 'vue-clock2';
    export default {
        props: ['lastLogs'],
        components: { Clock },
        mounted() {
            setInterval(this.updateTimestamp, 1000);
            this.updateTimestamp();
        },
        created() {
            this.$root.$on('tag-logged', this.onEntryLogged);
        },
        data() {
            return {
                newLogs: [],
                timestamp: null,
            }
        },
        computed: {
            logs() {
                let last = JSON.parse(this.lastLogs);
                if(!last || !last.length) {
                    return this.newLogs;
                }
                return this.newLogs.concat(last);
            },
            liveTime() {
                if(!this.timestamp) return;
                return this.timestamp.format('HH:mm:ss');
            },
            liveDate() {
                if(!this.timestamp) return;
                return this.timestamp.format('dddd L');
            },
        },
        methods: {
            updateTimestamp() {
                this.timestamp = window.moment();
            },
            onEntryLogged(log) {
                this.newLogs.unshift(log);
            }
        }
    }
</script>

<style scoped>
.big-clock h1 {
    color: #000;
    font-size: 8em;
    margin: 0;
    overflow: hidden;
}
</style>