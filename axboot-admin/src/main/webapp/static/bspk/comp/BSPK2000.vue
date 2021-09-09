<template>
	<div>
		<main-page></main-page>
		<spinner v-if="loading === true"></spinner>
		<message v-if="message === true"></message>
	</div>
</template>

<script>
var Message = httpVueLoader("../comp/Message.vue")
var Spinner = httpVueLoader("../comp/Spinner.vue")
var MainPage = httpVueLoader("../comp/11.main-page.vue")
var ChangeStatus = httpVueLoader("../comp/12.change-status.vue")
var StmtbdList2 = httpVueLoader("../comp/12-1.stmtbd-list.vue")
var Notice = httpVueLoader("../comp/13.notice.vue")

module.exports = {
	name: "App",
	components: {
		Message, Spinner, MainPage, ChangeStatus, StmtbdList2, Notice
	},
	data: function() {
		return {
		}
	},
	computed: {
		loading: function(){
			return store.getters.isLoading
		},
		message: function(){
			return store.getters.isMessage
		},
	},
	mounted: function(){
		var _this = this
	},
	methods: {
	}
}
</script>

<style>
</style>