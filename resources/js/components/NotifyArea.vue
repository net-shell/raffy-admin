<template>
    <div>
        <notifications group="sink" position="bottom right"/>
        <notifications group="app" classes="vue-notification app-group" position="center" width="90%"/>
    </div>
</template>

<style scoped>
    /deep/ .vue-notification-wrapper {
        opacity: .9;
    }
    /deep/ .vue-notification.app-group {
        font-size: 4em;
        text-align: center;
    }
</style>
