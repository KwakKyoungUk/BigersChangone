<template>

	 <!--팝업창 시작-->
	 <div class="popup-bg">
		 <div class="popup-box-order">
			 <div class="popup-box-order-tit">
				 주문알림<span class="blue">__#{{notice ? notice.billNo : ''}}</span>
			 </div>
			 <div class="popup-box-close">
				 <button class="btn-close" @click="close">X</button>
			 </div>
			 <div class="order-list-popup">
				 <div class="order-list-popup-tit">
					 주문품목
				 </div>
				 <div class="">
					 <div style="width: 100%; height: 350px; overflow: scroll;border: solid 1px #cccccc">
					 	<sub-stmtbd-list v-if="notice" :stmtbd="notice.saleStmtBdList"></sub-stmtbd-list>
					 </div>
				 </div>
				 <div class="order-list-popup-text blinking">
					 <h1><div style="background-color: #fff7d5; display: inline-block;">
					 	<span class="blue">{{notice ? notice.binsoName : ''}}</span>
					 	<span class="grey">에서 주문이 들어 왔습니다.</span>
					 </div></h1>
				 </div>
			 </div>
			 <div class="popup-btn">
				 <button v-if="onlyAlarm == 'N'" class="blue" @click="checked">준비중</button>
				 <button v-if="onlyAlarm == 'Y'" class="btn-checked" @click="print">인쇄</button>
				 <button @click="close">닫 기</button>
			 </div>
		 </div>
	 </div><!--팝업창 끝-->
</template>
<style>
	.blinking{
	  -webkit-animation:blink 0.5s ease-in-out infinite alternate;
	  -moz-animation:blink 0.5s ease-in-out infinite alternate;
	  animation:blink 0.5s ease-in-out infinite alternate;
	}
	@-webkit-keyframes blink{
	  0% {opacity:1; background-color: #fff7d5;}
	  100% {opacity:1; background-color: red;}
	}
	@-moz-keyframes blink{
	  0% {opacity:1; background-color: #fff7d5;}
	  100% {opacity:1; background-color: red;}
	}
	@keyframes blink{
	  0% {opacity:1; background-color: #fff7d5;}
	  100% {opacity:1; background-color: red;}
	}
</style>
<script>
var SubStmtbdList = httpVueLoader("../comp/12-1.stmtbd-list.vue?v="+new Date().getTime())

module.exports = {
	name: "Notice",
	components: {
		SubStmtbdList
	},
	data: function() {
		return {
		}
	},
	computed: {
		notice: function(){
			return store.getters.getCurrNotice
		},
		onlyAlarm: function(){
			return store.getters.onlyAlarm
		},
	},
	mounted: function(){
		var _this = this
		var audio = new Audio('/static/bspk/static/sound/ddingdong.mp3');
		audio.play();

		this.qlight("red", 1)
	},
	updated: function(){
		this.$nextTick(function(){
			store.commit("selectStmt", store.getters.getCurrNotice);
		})
	},
	destroyed: function(){
		this.qlight("off", 0)
	},
	methods: {
		close: function(){
			this.$emit("close")
			store.commit("shiftNotice")
			this.qlight("off", 0)
		},
		numberWithCommas: function (x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		},
		checked: function(){

			store.commit("loading", true)

			var _this = this
			var bd = this.notice
			var stmt = store.getters.getCurrNotice;

			$.ajax({
				type:"POST",
				url:`/api/v1/BSPK2000/saleStmt/status?customerNo=${bd.customerNo}&partCode=${bd.partCode}&billNo=${bd.billNo}&status=BSPK000030`,
				dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
				success : function(data) {
					if(data.status == 0){
						_this.$emit("close", {printYn: 'Y', stmt: stmt})
						store.commit("shiftNotice")
						_this.qlight("off", 0)
					}else{
						store.commit("message", {show: true, text: data.error.message})
					}
				},
				complete : function(data) {
					store.commit("loading", false)
				},
				error : function(xhr, status, error) {
					store.commit("message", {show: true, text: "에러발생, 계속 문제가 발생하면 관리자에게 문의하세요."})
				}
			});

		},
		print: function(){
			var stmt = store.getters.getCurrNotice;
			this.$emit("close", {printYn: 'Y', stmt: stmt})
			store.commit("shiftNotice")
			this.qlight("off", 0)
		},
		qlight: function(onoff, sound){
			$.ajax({
				type:"GET",
				url:`http://localhost:8888/qlight?light=${onoff}&sound=${sound}`,
				dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
				success : function(data) {

				},
				complete : function(data) {
				},
				error : function(xhr, status, error) {
				}
			});
		}
	}
}
</script>
