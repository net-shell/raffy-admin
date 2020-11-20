<template>
    <div class="new-tag alert alert-danger attention-tada" role="alert">
        <div class="row">
            <div class="col-sm-4">
                <p class="lead">
                    <span class="icon voyager-warning"></span>
                    {{ request.creation_time }}
                </p>
                <p>{{ request.creation_date }}</p>
            </div>
            <div class="col-sm-4">
                <p class="lead">
                    <span class="icon voyager-location"></span>
                    {{ request.reader.name }}
                </p>
                <p>Непозната карта</p>
            </div>
            <div class="col-sm-4">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <p class="lead">
                    <span class="icon voyager-tag"></span>
                    {{ request.tagId }}
                </p>
                <p>Номер на картата</p>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['request']
    }
</script>

<style scoped>
    p,
    .row > div {
        margin: 0;
    }
</style>
