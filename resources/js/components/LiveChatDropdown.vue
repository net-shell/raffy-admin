<template>
    <li class="dropdown live-chat">
        <a href="#" class="dropdown-toggle text-right" data-toggle="dropdown" role="button">
            <span class="badge badge-success">
                {{ usersOnline }}
                <i class="icon voyager-people"></i>
            </span>
            На линия
            <span class="caret"></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-animated no-padding" @click.capture.stop>
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
        created() {
            $(document).on('click', '.dropdown.live-chat .dropdown-menu', function (e) {
                e.stopPropagation();
            });
        },
        methods: {
            updateCount(newCount) {
                this.usersOnline = newCount;
            },
        },
    }
</script>
