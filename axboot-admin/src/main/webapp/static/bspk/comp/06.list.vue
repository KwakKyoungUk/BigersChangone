<template>

     <!--팝업창 시작-->
     <div class="popup-bg">
         <div class="popup-box-order">
             <div class="popup-box-order-tit">
                 주문내역
             </div>
             <div class="popup-box-close">
                 <button class="btn-close" @click="close">X</button>
             </div>
             <div class="order-list-popup">
                 <div class="order-list-popup-tit">
                     주문내역({{stmt.partName}})
                 </div>
                 <div class="order-list-popup-menu">
                     <div class="order-popup-menu-img-box">
                         <div class="order-popup-img-prev" @click="prevPage"></div>
                         <div>
                             <ul class="popup-menu-img-box" v-for="(bd, index) in list.slice(showList.from, showList.to+1)">
                                 <li class="popup-menu-img-box-name">{{bd.item.itemName}}</li>
                                 <li class="popup-menu-img-box-price">{{bd.price}} 원</li>
                                 <li class="popup-menu-img-box-img"><h5><img :src="bd.item.imgPath" onerror="delete this.src" style="max-width: 225px; max-height: 133px;"></h5> </li>
                                 <li class="popup-menu-table-li">
                                     <table class="popup-menu-table">
                                         <tr>
                                             <td class="popup-menu-table-name">총 수량</td>
                                             <td class="popup-menu-table-count">{{bd.qty}}</td>
                                             <td class="popup-menu-table-text">개</td>
                                         </tr>
                                     </table>
                                 </li>
                                 <li class="popup-menu-table-li">
                                     <table class="popup-menu-table">
                                         <tr>
                                             <td class="popup-menu-table-name">총 합계</td>
                                             <td class="popup-menu-table-count">{{numberWithCommas(bd.amount)}}</td>
                                             <td class="popup-menu-table-text">원</td>
                                         </tr>
                                     </table>
                                 </li>
                             </ul>
                         </div>
                         <div class="order-popup-img-next" @click="nextPage"></div>
                         <div class="popup-menu-page-num">
                             <p class="popup-menu-page-num-box">{{showList.page}}/{{showList.totalPage}}</p>
                         </div>
                     </div>
                     <div class="order-list-popup-sum">
                         <h1><span class="grey font-40">{{list.length}}</span>개</h1>
                         <h1><span class="red font-40">{{numberWithCommas(totalAmt)}}</span>원</h1>
                     </div>
                 </div>
             </div>
             <div class="popup-btn">
                 <button @click="close">닫 기</button>
             </div>
         </div>
     </div><!--팝업창 끝-->

</template>

<script>
module.exports = {
	name: "List",
	data: function(){
		return {
			list: [],
			showList: {
				from: 0,
				to: 3,
				page: 1,
				pageLimit: 4,
				totalPage: 1
			}
		}
	},
	props: ["stmt"],
	computed: {
		totalAmt: function(){
			return this.list.map(function(i){
				return i.amount
			}).reduce(function(a,b){return a+b}, 0)
		}
	},
	created: function(){
	},
	mounted: function(){
		this.getList()
	},
	methods: {
		close: function(){
			this.$emit('close')
		},
		getList: function(){

			store.commit("loading", true)

			var _this = this
			var customerNo = this.stmt.customerNo
			var partCode = this.stmt.partCode
			var billNo = this.stmt.billNo

			$.ajax({
	           type:"GET",
	           url:`/api/v1/BSPK1000/saleStmtBd?customerNo=${customerNo}&partCode=${partCode}&billNo=${billNo}&`,
	           dataType:"JSON",
	           success : function(data) {
	        	   _this.list = data.list
	        	   _this.showList.page = 1
	        	   _this.showList.totalPage = Math.ceil(data.list.length/_this.showList.pageLimit)
	        	   _this.showList.from = 0
	        	   _this.showList.to = 3
	           },
	           complete : function(data) {
	        	   store.commit("loading", false)
	           },
	           error : function(xhr, status, error) {
		        	store.commit("message", {show: true, text: "에러발생, 계속 문제가 발생하면 관리자에게 문의하세요."})
	           }
			});
		},
		numberWithCommas: function (x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		},
		prevPage: function(){
			var from = this.showList.from-this.showList.pageLimit
			var to = this.showList.to-this.showList.pageLimit

			if(!this.list[from]){
				return
			}else{
				this.showList.from = from
				this.showList.to = to
				this.showList.page--
			}
		},
		nextPage: function(){
			var from = this.showList.from+this.showList.pageLimit
			var to = this.showList.to+this.showList.pageLimit

			if(!this.list[from]){
				return
			}else{
				this.showList.from = from
				this.showList.to = to
				this.showList.page++
			}
		},
	}
}
</script>