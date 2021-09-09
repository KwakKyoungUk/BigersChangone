<template>
     <!--팝업창 시작-->
     <div class="popup-bg">
         <div class="popup-box-order">
             <div class="popup-box-order-tit">
                 주문취소
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
                         <div class="order-popup-list">
                             <table>
                                 <tr v-for="(bd, index) in list.slice(showList.from, showList.to+1)">
                                     <th class="list-num">{{bd.seqNo}}</th>
                                     <th class="list-menu">{{bd.item.itemName}}</th>
                                     <th class="list-count">{{bd.qty}}개</th>
                                     <th class="list-price">{{numberWithCommas(bd.amount)}}</th>
                                 </tr>
                             </table>
                         </div>
                         <div class="order-popup-list-btn">
                             <table>
                                 <tr>
                                     <th class="list-num-up"><button @click="prevPage">▲ page up</button></th>
                                 </tr>
                                 <tr>
                                     <th class="list-num-up"><button @click="nextPage">▼ page down</button></th>
                                 </tr>
                             </table>
                         </div>
                     </div>
                     <div class="order-list-popup-sum">
                         <h1><span class="grey font-40">{{list.length}}</span>개</h1>
                         <h1><span class="red font-40">{{numberWithCommas(totalAmt)}}</span>원</h1>
                     </div>
                 </div>
             </div>
             <div class="popup-btn">
                 <button class="red" @click="cancel">주문취소</button>
                 <button @click="close">닫 기</button>
             </div>
         </div>
     </div><!--팝업창 끝-->
</template>
<script>
module.exports = {
		name: "cancel",
		data: function(){
			return {
				list: [],
				showList: {
					from: 0,
					to: 7,
					page: 1,
					pageLimit: 8,
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
		        	   _this.showList.to = 7
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
			cancel: function(){

				store.commit("loading", true)

				var _this = this
				var customerNo = this.stmt.customerNo
				var partCode = this.stmt.partCode
				var billNo = this.stmt.billNo

				$.ajax({
			        type:"DELETE",
			        url:`/api/v1/BSPK1000/saleStmt?customerNo=${customerNo}&partCode=${partCode}&billNo=${billNo}`,
			        cache:false,
					timeout : 30000,
			        dataType:"JSON",
			        success : function(data) {
			        	if(data.status == 0){
				        	_this.close()
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
			}
		}
	}
</script>