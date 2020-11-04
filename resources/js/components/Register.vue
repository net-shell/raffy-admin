<template>
    <div>
        <div class="alert alert-warning">
            {{ newLogs.length }} logs,
            {{ newRequests.length }} tags
        </div>
        <div class="alert alert-info" v-for="tag in newRequests">
            {{ tag }}
        </div>
        <div class="alert alert-success" v-for="log in newLogs">
            {{ log }}
        </div>
    </div>
</template>

<script>
    export default {
        created() {
            this.$root.$on("tag-logged", this.onEntryLogged);
            this.$root.$on("tag-requested", this.onTagRequested);
        },
        data() {
            return {
                timestamp: null,
                newLogs: [],
                newRequests: [],
            };
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
                        this.newLogs.splice(i, 1, log);
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
            async loadMore() {
                this.loadingLogs = true;
                const url = "/api/logs?skip=" + this.newLogs.length;
                const res = await fetch(url);
                const response = await res.json();
                const logs = response.data;
                console.log(logs)
                this.newLogs = this.newLogs.concat(logs);
                this.loadingLogs = false;
            },
        },
    }
</script>
