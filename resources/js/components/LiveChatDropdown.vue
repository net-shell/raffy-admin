<template>
    <li class="dropdown profile">
        <a href="#" class="dropdown-toggle text-right" data-toggle="dropdown" role="button">
            <span class="badge badge-success">{{ usersOnline }}</span>
            На линия сега
            <span class="caret"></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-animated no-padding">
            <live-chat @update-count="updateCount"></live-chat>
        </ul>
    </li>
</template>

<script>
    export default {
        data() {
            return {
                usersOnline: 0,
            };
        },
        methods: {
            updateCount(newCount) {
                this.usersOnline = newCount;
            },
        },
    }
</script>
