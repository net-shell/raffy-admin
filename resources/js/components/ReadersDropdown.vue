<template>
    <li class="dropdown readers">
        <a href="#" class="dropdown-toggle text-right" data-toggle="dropdown" role="button">
            <span class="badge badge-dark">
                {{ readersCount }}
            </span>
            Четци
            <span class="caret"></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-animated no-padding">
            <reader-monitor @update-count="updateCount"></reader-monitor>
        </ul>
    </li>
</template>

<script>
    export default {
        name: "ReadersDropdown",
        data() {
            return {
                readersCount: 0,
            };
        },
        created() {
            $(document).on('click', '.dropdown.readers .dropdown-menu', function (e) {
                e.stopPropagation();
            });
        },
        methods: {
            updateCount(newCount) {
                this.readersCount = newCount;
            },
        },
    }
</script>

<style scoped>
</style>
