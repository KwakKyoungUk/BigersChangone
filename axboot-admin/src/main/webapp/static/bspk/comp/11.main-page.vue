<template>
 <div class="container-1920" >
     <!--테스트 배경 이미지-->

     <div class="header">
         <div class="header-L">
             <a class="" href="#">
                 <img src="../static/images/home_icon.png" style="vertical-align: bottom;">
             </a>
             {{partName}}
         </div>
         <div class="header-R">
             <a class="" href="#" @dblclick="clearLocaldata">
                 <img src="../static/images/time_icon.png" style="vertical-align: bottom;">
             </a>
             {{time}}
         </div>
     </div> <!--header end-->


     <div class="body-gr">

         <!--빈소주문시스템 주문현황 콘텐츠 시작-->
         <div class="mid-wrap">
             <div class="mid-info-box-2">
                 <div class="order-list-view">
                     <div class="order-list-view-tit">
                         <span class="tit">주문전표목록</span>
                     </div>
                     <div class="stmt">
                     	<stmt-list></stmt-list>
                     </div>
                 </div>

                 <div class="order-list-view-2">
                     <div class="order-list-view-tit">
                         <span class="tit">주문내역({{selectedStmt.partName}})</span>
                         <span class="sta-view">{{selectedStmt.bspkStatusName}}</span>
                     </div>
                     <div class="order-list-view-check">
                     	<div class="stmtbd">
	                     	<stmtbd-list :stmt="selectedStmt"></stmtbd-list>
                     	</div>

                         <div class="btn">
                             <button :class="btnPrint.cls" :disabled="btnPrint.disabled" @click="print()">인쇄</button>
                             <!--<button class="disabled">확인완료</button>-->
                             <button v-if="onlyAlarm == 'N'" :class="btnBSPK000030.cls" :disabled="btnBSPK000030.disabled" @click="changeStatus('BSPK000030', '준비중')">준비중</button>
                         </div>

                     </div>
                 </div>

             </div>
         </div> <!--빈소주문시스템 주문현황 콘텐츠 끝-->
     </div>  <!--body end-->

	<transition name="bounce">
		<change-status v-if="popup.changeStatus" @close="closeChangeStatus" :callback="changeStatus" :stmt="selectedStmt" :change-status-data="popup.changeStatusData"></change-status>
		<notice v-if="popup.notice && observeNotice" @close="closeNotice"></notice>
	</transition>

 </div>
</template>
<style>
.container {
	overflow: auto;
}
.fixed-header {
	position: sticky;
	top: 0;
}
.stmt {
	width:735px;
	height: 722px;
	border: solid 1px #cccccc;
	margin-top: 5px;
	overflow-y: scroll;
	overflow-x: hidden;
}
.stmtbd {
	width:917px;
	height: 625px;
	border: solid 1px #cccccc;
	margin-top: 5px;
	overflow-y: scroll;
	overflow-x: hidden;
}
.bounce-enter-active {
  animation: bounce-in .5s;
}
.bounce-leave-active {
  animation: bounce-in .5s reverse;
}
@keyframes bounce-in {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
  }
}
</style>
<script>

var StmtList = httpVueLoader("../comp/11-1.stmt-list.vue?v="+new Date().getTime())
var StmtbdList = httpVueLoader("../comp/11-2.stmtbd-list.vue?v="+new Date().getTime())
var ChangeStatus = httpVueLoader("../comp/12.change-status.vue?v="+new Date().getTime())
var Notice = httpVueLoader("../comp/13.notice.vue?v="+new Date().getTime())
var BspkList = httpVueLoader("../comp/BspkList.vue?v="+new Date().getTime())

module.exports = {
	name: "MainPage",
	components: {
		StmtList, StmtbdList, ChangeStatus, Notice, BspkList
	},
	data: function() {
		return {
			popup: {
				changeStatus: false,
				changeStatusData: {
					status: "",
					statusName: ""
				},
				notice: false
			},
			showNotice: {}
		}
	},
	computed: {
		loading: function(){
			return store.getters.isLoading
		},
		message: function(){
			return store.getters.isMessage
		},
		partName: function(){
			if(this.data.part){
				return this.data.part.partName
			}else{
				return ""
			}
		},
		time: function(){
			return store.getters.getTime
		},
		selectedStmt: function(){
			return store.getters.getSelectedStmt || {}
		},
		data: function(){
			return store.getters.getData
		},
		btnPrint: function(){
			return {
				cls: 'btn-checked ' + (this.selectedStmt.customerNo ? '' : 'disabled'),
				disabled: !this.selectedStmt.customerNo
			}
		},
		btnBSPK000030: function(){
			return {
				cls: 'btn-ready ' + ((!this.selectedStmt.bspkStatus || this.selectedStmt.bspkStatus == 'BSPK000030' || this.selectedStmt.bspkStatus == 'BSPK000040') ? 'disabled' : ''),
				disabled: !this.selectedStmt.bspkStatus || this.selectedStmt.bspkStatus == 'BSPK000030' || this.selectedStmt.bspkStatus == 'BSPK000040'
			}
		},
		observeNotice: function(){
			return store.getters.getCurrNotice
		},
		onlyAlarm: function(){
			return store.getters.onlyAlarm
		}
	},
	watch: {
		// store의 현재 알림 stmt 감시 변화가 생길경우에 this.showNotice에 반영
		observeNotice: function(){
			var _this = this

			if(this.showNotice
					&& this.observeNotice
					&& this.observeNotice.customerNo == this.showNotice.customerNo
					&& this.observeNotice.partCode == this.showNotice.partCode
					&& this.observeNotice.billNo == this.showNotice.billNo
					&& this.observeNotice.regtime == this.showNotice.regtime
				){

			}else{
				if(this.observeNotice){
					this.showNotice = this.observeNotice
					_this.$nextTick(function(){
						_this.showNotice = _this.observeNotice
					})
				}
			}

			return this.observeNotice
		},
		// 변화가 생기면 알림 팝업 띄움
		showNotice: function(){

			var _this = this
			this.$nextTick(function(){
				_this.popup.notice = false
				_this.$nextTick(function(){
					_this.popup.notice = true
				})
			})
			return this.showNotice
		}
	},
	mounted: function(){
		var _this = this
		$.ajax({
			type:"GET",
			url:`http://localhost:8888/qlight?light=off&sound=0`,
			dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
			success : function(data) {

			},
			complete : function(data) {
			},
			error : function(xhr, status, error) {
			}
		});
	},
	methods: {
		closeChangeStatus: function(){
			this.popup.changeStatus = false
		},
		changeStatus: function(status, statusName){
			this.popup.changeStatus = true
			this.popup.changeStatusData.status = status
			this.popup.changeStatusData.statusName = statusName
		},
		closeNotice: function(printObj){
			this.popup.notice = false
			if(printObj && printObj.printYn == 'Y'){
				fnObj.printQueue.push(`http://${location.host}/api/v1/public/report?reportUnit=/reports/changwon/bspk/BSPK2021&output=pdf&customerNo=${printObj.stmt.customerNo}&partCode=${printObj.stmt.partCode}&billNo=${printObj.stmt.billNo}`)
			}
		},
		clearLocaldata: function(){
			window.localStorage.clear(); location.reload();
		},
		print: function(){
			fnObj.printQueue.push(`http://${location.host}/api/v1/public/report?reportUnit=/reports/changwon/bspk/BSPK2021&output=pdf&customerNo=${this.selectedStmt.customerNo}&partCode=${this.selectedStmt.partCode}&billNo=${this.selectedStmt.billNo}`)
		}
	}
}
</script>