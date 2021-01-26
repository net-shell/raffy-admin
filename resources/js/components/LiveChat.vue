<template>
    <div class="chat">
        <div class="users-online">
            <div class="user" v-for="user in usersOnline" :key="user.id">
                <chat-box :user="user"></chat-box>
            </div>
        </div>
    </div>
</template>

<script>
    import ChatBox from "./ChatBox";
    export default {
        components: {ChatBox},
        data() {
            return {
                usersOnline: [],
            };
        },
        created() {
            this.$root.$on("chat-joined", this.usersJoined);
            this.$root.$on("chat-left", this.userLeft);
        },
        watch: {
            "usersOnline.length": function () {
                this.$emit('update-count', this.usersOnline.length);
            }
        },
        methods: {
            usersJoined(users) {
                let joinedUsers = users.map(u => u.name).join(', ');
                for(let user of users) {
                    if(!this.usersOnline.find(u => u.id == user.id)) {
                        this.usersOnline.push(user);
                    }
                }
                Vue.notify({
                    group: 'sink',
                    type: 'success',
                    duration: 5000,
                    text: "На линия сега",
                    title: joinedUsers
                });
            },
            userLeft(user) {
                this.usersOnline = this.usersOnline.filter(u => user.id != u.id);
                Vue.notify({
                    group: 'sink',
                    type: 'info',
                    duration: 5000,
                    text: "Вече не е на линия",
                    title: user.name
                });
            },
        },
    }
</script>
