<template>
    <div class="panel panel-bordered">
        <div class="panel-body filters">
            <div class="row">
                <div class="col-sm-12">
                    <label class="control-label so-big">
                        <i class="icon text-info voyager-search"></i>
                        Филтри
                    </label>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="row bg-info" style="margin-top: .7em;">
                        <div class="col-sm-6">
                            <label class="control-label">Период от:</label>
                            <datepicker
                                v-model="filter.from"
                                :language="bg"
                                input-class="form-control"
                                :monday-first="true"
                                :format="dateFormat"
                            ></datepicker>
                        </div>
                        <div class="col-sm-6">
                            <label class="control-label">до:</label>
                            <datepicker
                                v-model="filter.to"
                                :language="bg"
                                input-class="form-control"
                                :monday-first="true"
                                :format="dateFormat"
                            ></datepicker>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <label class="control-label">Четец:</label>
                            <multiselect
                                v-model="filter.reader"
                                placeholder="Филтриране по четец..."
                                track-by="id"
                                label="text"
                                :options="readers"
                            ></multiselect>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="row">
                        <div class="col-sm-12">
                            <label class="control-label">Отдел:</label>
                            <multiselect
                                v-model="filter.section"
                                placeholder="Филтриране по отдел..."
                                track-by="id"
                                label="text"
                                :options="sections"
                            ></multiselect>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <label class="control-label">Служители:</label>
                            <multiselect
                                v-model="filter.users"
                                placeholder="Филтриране по служители..."
                                track-by="id"
                                label="name"
                                :options="users"
                                :multiple="true"
                            ></multiselect>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import {bg} from "vuejs-datepicker/dist/locale";

export default {
    data() {
        return {
            bg: bg,
            filter: {
                from: new Date,
                to: new Date,
                section: null,
                users: [],
                reader: null,
            },
            allUsers: [],
            readers: [],
            sections: [],
        }
    },
    created() {
        this.getUsers();
        this.getSections();
        this.getReaders();
        this.$emit('update-filter', this.filter);
    },
    computed: {
        users() {
            if (!this.filter.section || !this.filter.section.id)
                return this.allUsers;
            const sid = this.filter.section.id;
            const users = this.allUsers.filter(u => u.section_id == sid);
            return users || [];
        },
    },
    methods: {
        async getUsers() {
            let url = "/api/workers";
            const res = await fetch(url);
            const users = await res.json();
            this.allUsers = users.results;
        },
        async getReaders() {
            let url = "/logs/relation?type=log_belongsto_reader_relationship";
            const res = await fetch(url);
            const readers = await res.json();
            this.readers = readers.results;
        },
        async getSections() {
            let url = '/users/relation?type=user_belongsto_section_relationship';
            const res = await fetch(url);
            const sections = await res.json();
            this.sections = sections.results;
        },
        dateFormat(date) {
            return moment(date).format("dddd DD MMMM YYYY");
        },
    },
    watch: {
        filter: {
            deep: true,
            handler() {
                if (moment(this.filter.to).isBefore(this.filter.from)) {
                    this.filter.from = this.filter.to;
                } else if (moment(this.filter.from).isAfter(this.filter.to)) {
                    this.filter.to = this.filter.from;
                } else {
                    this.$emit('update-filter', this.filter);
                }
            }
        },
    },
}
</script>

<style scoped>
.panel-body.filters {
    overflow: visible;
}
</style>
