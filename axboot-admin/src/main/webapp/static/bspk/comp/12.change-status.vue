<template>

     <!--팝업창 시작-->
     <div class="popup-bg">
         <div class="popup-box-order">
             <div class="popup-box-order-tit">
                 상태변경
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
                 		<sub-stmtbd-list :stmtbd="stmt.saleStmtBdList"></sub-stmtbd-list>
                 	</div>
                 </div>
                 <div class="order-list-popup-text">
                     <h1><span class="red">{{changeStatusData.statusName}}</span>
                     <span class="grey">상태로 변경하시겠습니까?</span>
                     </h1>
                 </div>
             </div>
             <div class="popup-btn">
                 <button class="red" @click="changeStatus">{{changeStatusData.statusName}}</button>
                 <button @click="close">닫 기</button>
             </div>
         </div>
     </div><!--팝업창 끝-->

</template>
<script>

var SubStmtbdList = httpVueLoader("../comp/12-1.stmtbd-list.vue?v="+new Date().getTime())

module.exports = {
	name: "ChangeStatus",
	components: {
		SubStmtbdList
	},
	props: ["callback", "stmt", "changeStatusData"],
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
		close: function(){
			this.$emit("close")
		},
		numberWithCommas: function (x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		},
		changeStatus: function(){
			store.commit("loading", true)

			var _this = this
			var stmt = this.stmt
			var changeStatusData = this.changeStatusData
			$.ajax({
		        type:"POST",
		        url:`/api/v1/BSPK2000/saleStmt/status?customerNo=${stmt.customerNo}&partCode=${stmt.partCode}&billNo=${stmt.billNo}&status=${changeStatusData.status}`,
		        cache:false,
				timeout : 30000,
		        dataType:"JSON",
		        success : function(data) {
		        	if(data.status == 0){
		        		fnObj.printQueue.push(`http://${location.host}/api/v1/public/report?reportUnit=/reports/changwon/bspk/BSPK2021&output=pdf&customerNo=${stmt.customerNo}&partCode=${stmt.partCode}&billNo=${stmt.billNo}`)
						_this.close()
		        	}else{
		        		store.commit("message", {show: true, text: "에러발생, 계속 문제가 발생하면 관리자에게 문의하세요."})
		        	}
		        },
		        complete : function(data) {
		        	store.commit("loading", false)
		        },
		        error : function(xhr, status, error) {
		        	store.commit("message", {show: true, text: "에러발생, 계속 문제가 발생하면 관리자에게 문의하세요."})
		        }
			});
		}
	}
}
</script>