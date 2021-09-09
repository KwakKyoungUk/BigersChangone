<template>
	<div>
		<router-view></router-view>
		<spinner v-if="loading === true"></spinner>
		<message v-if="message === true"></message>
	</div>
</template>

<script>
var Message = httpVueLoader("../comp/Message.vue")
var Spinner = httpVueLoader("../comp/Spinner.vue")

module.exports = {
	name: "App",
	components: {
		Message,
		Spinner
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