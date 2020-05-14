<template>
    <div class="log-entry well row attention-please" v-if="log">
        <div class=col-sm-3>
            <img class=img-responsive :src="'/storage/' + log.user.avatar">
        </div>
        <div class="details col-sm-9">
            <div class="reader pull-right badge">{{ log.reader.name }}</div>
            <h3 class="name">{{ log.user.name }}</h3>
            <div class="live-clock">
                <h4>{{ liveDiff }}</h4>
                <h3>{{ liveTime }}</h3>
                <h4>{{ liveDate }}</h4>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: ['log'],
    mounted() {
        setInterval(this.$forceUpdate, 60000);
    },
    computed: {
        momentCreated() {
            return window.moment(this.log.created_at);
        },
        liveDiff() {
            return this.momentCreated.fromNow();
        },
        liveTime() {
            return this.momentCreated.format('HH:mm:ss');
        },
        liveDate() {
            return this.momentCreated.format('dddd L');
        },
    }
}
</script>

<style scoped>
.log-entry {
    padding: 0;
    margin: 1em 0;
    border: 1px solid #333;
}
.log-entry.faded {
    opacity: 0.5;
}
.log-entry > div {
    padding: 0;
    margin-bottom: 0 !important;
}
.log-entry .details {
    padding: 0 1.5em;
}
.log-entry .details .name {
}
.log-entry .img-responsive {
    max-height: 200px;
}
.log-entry .reader {
    font-size: 1em;
    margin-top: 1.7em;
}
</style>