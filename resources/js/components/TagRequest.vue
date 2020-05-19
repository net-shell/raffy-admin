<template>
    <div class="new-tag alert alert-info attention-tada" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <p class="lead">
            Нова карта на
            {{ request.reader.name }}
        </p>
        <div>
                <p class="lead no-margin">{{ request.creation_time }}</p>
                <p>{{ request.creation_date }}</p>
                <button type="button" class="btn btn-lg btn-success">
                    Регистрирай
                </button>
                <p>
                    <span class="icon voyager-tag"></span>
                    {{ request.tagId }}
                </p>
        </div>
    </div>
</template>

<script>
export default {
    props: ['request']
}
</script>