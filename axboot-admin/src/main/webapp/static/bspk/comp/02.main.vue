<template>
<div class="container-1920 main-bg">

     <div class="header">
         <div class="header-L">
             <a class="" href="#">
                 <img src="../static/images/home_icon.png" style="vertical-align: bottom;" onclick="window.location.reload()">
             </a>
             {{binsoName}}
         </div>
         <div class="header-R">
             <a class="" href="#" @dblclick="refresh">
                 <img src="../static/images/time_icon.png" style="vertical-align: bottom;">
             </a>
             {{time}}
         </div>
     </div> <!--header end-->

     <div class="header01">
<!--          <div class="h-type">타입 : {{binsoType}}</div> -->
         <div class="h-user">고인 : {{deadName}}</div>
     </div>


     <div class="body-gr">

         <!--빈소주문시스템 주문현황 콘텐츠 시작-->
         <div class="mid-wrap">
            <div class="mid-info-bar">
                <div class="mid-info-bar-count-tit">주문횟수</div>
                <div class="mid-info-bar-count-view"><p class="">{{totalBspkCnt}} 회</p></div>
                <div class="mid-info-bar-sum-tit">총 주문금액</div>
                <div class="mid-info-bar-sum-view"><p class="">{{totalBspkAmt}} 원</p></div>
                <div class="mid-info-bar-sta"><div class="sta-tit color-01">주문신청</div><div class="sta-count">{{status10Cnt}}</div></div>
                <div class="mid-info-bar-sta"><div class="sta-tit color-03">준비중</div><div class="sta-count">{{status30Cnt}}</div></div>
                <div class="mid-info-bar-sta"><div class="sta-tit color-04">인수완료</div><div class="sta-count">{{status40Cnt}}</div></div>
            </div>

             <div class="mid-info-box">
                 <div class="order-res">
                     <div class="order-res-tit">식&nbsp;&nbsp;&nbsp;&nbsp;당</div>
                     <div class="order-res-img">
                         <div class="order-res-text"> 주문가능시간 07시~20시30분</div>
                     </div>
                     <div class="order-res-btn"><a @click="bespeakRestaurant"> 주문하기</a> </div>
                 </div>
                 <div class="order-out">
                     <div class="order-out-tit">떡·수육</div>
                     <div class="order-out-img">
                         <div class="order-out-text"> 주문가능시간 07시~20시</div>
                     </div>
                     <div class="order-out-btn"><a @click="bespeakOutOrder"> 주문하기</a> </div>
                 </div>
                 <div class="order-snac">
                     <div class="order-snac-tit">매&nbsp;&nbsp;&nbsp;&nbsp;점</div>
                     <div class="order-snac-img">
                         <div class="order-snac-text"> 주문가능시간 07시~20시30분</div>
                     </div>
                     <div class="order-snac-btn"><a @click="bespeakStore"> 주문하기</a> </div>
                 </div>
                 <div style="position: absolute; top: 187px; right: 100px;">
                 	※ 제물상 : 712-0937 / 식당 : 712-0924 / 안내실 : 712-0913
                 </div>
                 <div class="order-table container">
                     <table border="1">
                         <thead>
                            <tr>
                                <th class="fixed-header">번호</th>
                                <th class="fixed-header">주문시간</th>
                                <th class="fixed-header">분류</th>
                                <th class="fixed-header">주문금액(원)</th>
                                <th class="fixed-header">진행상태</th>
                                <th class="fixed-header">주문내역보기</th>
                                <th class="fixed-header">인수확인</th>
                                <th class="fixed-header">주문취소</th>
                            </tr>
                         </thead>
                         <tbody>

                         	<template v-for="(ss, idx) in saleStmtList">
								<tr v-if="idx%2 == 0">
								    <td>{{ss.partName}}#{{ss.billNo}}</td>
								    <td>{{ss.regtime}}</td>
								    <td>{{ss.partName}}</td>
								    <td>{{numberWithCommas(ss.amount)}}</td>
								    <td><span :class="'box-full ' + colorMapping[ss.bspkStatus]">{{ss.bspkStatusName}}</span></td>
								    <td><button class="order-btn-view" @click="openList(ss)">주문내역보기</button></td>
								    <td><button class="order-btn-view" @click="openTakingOver(ss)">인수확인</button></td>
								    <td><button class="order-btn-view" @click="openCancel(ss)">주문취소</button></td>
								</tr>
								<tr v-if="idx%2 == 1">
								    <th>{{ss.partName}}#{{ss.billNo}}</th>
								    <th>{{ss.regtime}}</th>
								    <th>{{ss.partName}}</th>
								    <th>{{numberWithCommas(ss.amount)}}</th>
								    <th><span :class="'box-full ' + colorMapping[ss.bspkStatus]">{{ss.bspkStatusName}}</span></th>
								    <th><button class="order-btn-view" @click="openList(ss)">주문내역보기</button></th>
								    <th><button class="order-btn-view" @click="openTakingOver(ss)">인수확인</button></th>
								    <th><button class="order-btn-view" @click="openCancel(ss)">주문취소</button></th>
								</tr>
                         	</template>

                         </tbody>
                     </table>
                 </div>
             </div>

         </div> <!--빈소주문시스템 주문현황 콘텐츠 끝-->
     </div>  <!--body end-->
     <transition name="bounce">
     	<restaurant v-if="popup.restaurant" @close="closeRestaurant"></restaurant>
     	<out-order v-if="popup.outOrder" @close="closeOutOrder"></out-order>
     	<store v-if="popup.store" @close="closeStore"></store>
     	<list v-if="popup.list" @close="closeList" :stmt="popup.selectedStmt"></list>
     	<cancel v-if="popup.cancel" @close="closeCancel" :stmt="popup.selectedStmt"></cancel>
     	<taking-over v-if="popup.takingOver" @close="closeTakingOver" :stmt="popup.selectedStmt"></taking-over>

     </transition>
 </div>  <!--container end-->
</template>

<style>
.container {
	overflow: auto;
}
.fixed-header {
	position: sticky;
	top: 0;
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

var Restaurant = httpVueLoader("../comp/03.restaurant.vue?d="+ new Date().getTime())
var OutOrder = httpVueLoader("../comp/03-1.out-order.vue?d="+ new Date().getTime())
var Store = httpVueLoader("../comp/04.store.vue?d="+ new Date().getTime())
var List = httpVueLoader("../comp/06.list.vue?d="+ new Date().getTime())
var TakingOver = httpVueLoader("../comp/05.taking_over.vue?d="+ new Date().getTime())
var Cancel = httpVueLoader("../comp/07.cancel.vue?d="+ new Date().getTime())

module.exports = {
	name: "Main",
	components: {
		Restaurant, OutOrder, Store, TakingOver, List, Cancel
	},
	data: function(){
		return {
			popup: {
				restaurant: false,
				outOrder: false,
				store: false,
				list: false,
				cancel: false,
				takingOver: false,
				selectedStmt: null,
			},
			colorMapping: {
				"BSPK000010": "color-01",
				"BSPK000020": "color-02",
				"BSPK000030": "color-03",
				"BSPK000040": "color-04"
			}
		}
	},
	computed: {
		binsoName: function(){
			if(store.getters.getBinso.binso){
				return store.getters.getBinso.binso.binsoName || ""
			}
		},
		time: function(){
			return store.getters.getTime
		},
		binsoType: function(){
			if(store.getters.getBinso.binso){
				switch(store.getters.getBinso.binso.binsoType){
				case "1":
					return "특실"
				case "2":
					return "준특실"
				case "3":
					return "일반실"
				default:
					return "";
				}
			}else{
				return ""
			}
		},
		deadName: function(){
			if(store.getters.getBinso.thedead){
				return store.getters.getBinso.thedead.deadName
			}
		},
		applName: function(){
			if(store.getters.getBinso.applicant){
				return store.getters.getBinso.applicant.applName
			}
		},
		saleStmtList: function(){
			var saleStmtList = store.getters.getData.saleStmtList
			if(!saleStmtList){
				return;
			}
			return saleStmtList
		},
		totalBspkCnt: function() {
			var num = store.getters.getData.totalBspkCnt || 0
			return this.numberWithCommas(num)
		},
		totalBspkAmt: function() {
			var num = store.getters.getData.totalBspkAmt || 0
			return this.numberWithCommas(num)
		},
		status10Cnt: function() {
			var num = store.getters.getData.status10Cnt || 0
			return this.numberWithCommas(num)
		},
		status20Cnt: function() {
			var num = store.getters.getData.status20Cnt || 0
			return this.numberWithCommas(num)
		},
		status30Cnt: function() {
			var num = store.getters.getData.status30Cnt || 0
			return this.numberWithCommas(num)
		},
		status40Cnt: function() {
			var num = store.getters.getData.status40Cnt || 0
			return this.numberWithCommas(num)
		},

	},
	created: function(){
	},
	mounted: function(){
		this.isLoggedIn()
	},
	methods: {
		getBinsoData: function(){

			store.commit("loading", true)

			var _this = this
			var binsoCode = store.getters.getBinsoCode

			$.ajax({
		           type:"GET",
		           url:`/api/v1/BSPK1000/binsoData?binsoCode=${binsoCode}`,
		           dataType:"JSON",
		           success : function(data) {
		        	   store.commit("binso", data.map.binso)
		           },
		           complete : function(data) {
		        	   store.commit("loading", false)
		           },
		           error : function(xhr, status, error) {
		        	   store.commit("message", {show: true, text: "에러발생, 계속 문제가 발생하면 관리자에게 문의하세요."})
		           }
		     });

		},
		isLoggedIn: function(){
			var isLoggedIn = store.getters.isLoggedIn
			if(!isLoggedIn){
		  		this.$router.push("/")
			}
		},
		numberWithCommas: function (x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		},
		bespeakRestaurant: function(){
			this.popup.restaurant = true
		},
		closeRestaurant: function(){
			this.popup.restaurant = false
		},
		bespeakOutOrder: function(){
			this.popup.outOrder = true
		},
		closeOutOrder: function(){
			this.popup.outOrder = false
		},
		bespeakStore: function(){
			this.popup.store = true
		},
		closeStore: function(){
			this.popup.store = false
		},
		closeList: function(){
			this.popup.list = false
		},
		closeCancel: function(){
			this.popup.cancel = false
		},
		closeTakingOver: function(){
			this.popup.takingOver = false
		},
		openList: function(ss){
			this.popup.selectedStmt = ss
			this.popup.list = true
		},
		openCancel: function(ss){

			if(ss.bspkStatus == "BSPK000010" || ss.bspkStatus == "BSPK000020"){
				this.popup.selectedStmt = ss
				this.popup.cancel = true
			}else{
				store.commit("message", {show: true, text: "준비중 또는 인계완료된 주문건은 취소가 불가능 합니다."})
			}

		},
		openTakingOver: function(ss){
			if(ss.bspkStatus == "BSPK000010"){
				store.commit("message", {show: true, text: "주문신청중인 자료는 인수확인이 불가능 합니다."})
				return
			}
			this.popup.selectedStmt = ss
			this.popup.takingOver = true
		},
		refresh: function(){
			window.location.reload()
		}
	}
}
</script>
