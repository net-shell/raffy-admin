<template>
    <div class="panel panel-bordered">
        <div class="panel-heading">
            <btn block>
                <img class="img-responsive avatar pull-left" :src="'/storage/' + user.avatar">
                <h4 class="text-left">
                    {{ user.name }}
                </h4>
            </btn>
        </div>
    </div>
</template>

<script>
    export default {
        props: ["user"],
        data() {
            return {
            };
        },
    }
</script>

<style scoped>
    .voyager .panel {
        margin: 0;
    }

    .panel-heading .btn {
        text-align: left;
    }

    .user .row > div {
        padding: 0 0 0 .5em;
        margin: 0;
    }
    .user .avatar {
        max-width: 50px;
        margin-right: .5em;
    }
</style>
