<template>
     <!--팝업창 시작-->
     <div class="popup-bg">
         <div class="popup-box-order">
             <div class="popup-box-order-tit">
                 주문음식
             </div>
             <div class="popup-box-close">
                 <button class="btn-close" @click="close">X</button>
             </div>
             <div class="order-time-info">
             	<table>
                     <tr>
                         <td><h3 style="padding-top: 10px; color: #ff5656">※메뉴별 주문 가능시간</h3></td>
                         <td><h3>수육류<br>07시-20시</h3></td>
                         <td><h3>떡<br>08시-19시</h3></td>
                     </tr>
                 </table>
             </div>

             <div class="order-res-menu">
                 <div class="order-res-menu-btn-box">
                     <div class="order-res-menu-type-btn-prev" @click="prevTab"></div>
                     <div class="order-res-menu-type-btn" v-for="(item, index) in itemGroups.slice(showTab.from, showTab.to+1)">
                     	<button :class="selectedGroup == item ? 'btn-menu-on':''" @click="selectTab(showTab.from+index)">{{item.groupName}}</button>
					 </div>
                     <div class="order-res-menu-type-btn-next" @click="nextTab"></div>
                 </div>
                 <div class="order-res-menu-img-box">
                     <div class="order-res-menu-type-img-prev" @click="prevPage"></div>
                     <div class="res-menu-img-box">
                         <ul class="menu-img-box" v-for="(item, index) in items.slice(showItem.from, showItem.to+1)" @click="addBspkItem(item)">
                             <li class="menu-img-box-name">{{item.itemName}}</li>
                             <li class="menu-img-box-price">{{numberWithCommas(item.salePrice)}}원</li>
                             <li class="menu-img-box-img"><h5><img :src="item.imgPath" onerror="delete this.src" style="max-width: 225px; max-height: 133px;"></h5> </li>
                         </ul>
                     </div>
                     <div class="order-res-menu-type-img-next" @click="nextPage"></div>
                     <div class="res-menu-img-box-page-num">
                         <p class="page-num-box">{{showItem.page}}/{{showItem.totalPage}}</p>
                     </div>
                 </div>
             </div>

             <div class="order-list-box">
                 <div class="order-list-box-tit"><p>총 주문내역</p></div>
                 <div class="order-list-box-list" style="height: 400px;">
                     <table v-for="(item, index) in bspkItems.slice(showBspkItem.from, showBspkItem.to+1)">
                         <tr>
                             <td rowspan="2" class="order-list-box-list-num">{{showBspkItem.from+index+1}}</td>
                             <td colspan="2" class="order-list-box-list-menu">{{item.itemName}}</td>
                             <td colspan="2" class="order-list-box-list-price">{{numberWithCommas(item.salePrice*item.qty)}} 원 <span style="font-size: 70%; color: gray;">({{numberWithCommas(item.salePrice)}} 원)</span></td>
                         </tr>
                         <tr>
                             <td>판매단위수량 : {{bspkItems[showBspkItem.from+index].saleQty}}</td>
                             <td colspan="2" class="order-list-box-list-btn-count">
                                 <button class="btn-count-min" @click="minusSaleQty(showBspkItem.from+index)"><span>-</span></button>
                                 <input type="text" v-model="bspkItems[showBspkItem.from+index].qty">
                                 <button class="btn-count-max" @click="plusSaleQty(showBspkItem.from+index)"><span>+</span></button>
                             </td>
                             <td class="order-list-box-list-btn-del">
                                 <button class="btn-count-del" @click="deleteBspkItem(showBspkItem.from+index)">삭제</button>
                             </td>
                         </tr>
                     </table>
                 </div>
                 <div class="order-list-box-page-btn-box">
                     <div class="btn-page-up"><button @click="prevBspkItem" style="font-size: 30px;">▲ page up</button></div>
                     <div class="btn-page-down"><button @click="nextBspkItem" style="font-size: 30px;">▼ page down</button></div>
                 </div>
                 <div class="order-list-box-order-sum">
                     <div class="order-sum-count">총 <span>{{totalCnt}}</span> 개</div>
                     <div class="order-sum-price"> <span>{{numberWithCommas(totalAmt)}}</span> 원</div>
                 </div>
                 <div class="order-list-box-btn-final">
                     <button class="btn-final-cancel" @click="close">취소하기</button>
                     <button class="btn-final-order" @click="openConfirm">주문하기</button>
                 </div>
             </div>

         </div>
         <transition name="bounce">
         	<confirm v-if="confirm.show" @close="closeConfirm" :question="confirm.message" @callback="save"></confirm>
         </transition>
     </div><!--팝업창 끝-->
</template>

<script>
var Confirm = httpVueLoader("../comp/Confirm.vue?d="+ new Date().getTime())

module.exports = {
		name: "OutOrder",
		components: {
			Confirm
		},
		mounted: function(){
			this.getItemGroup()
		},
		data: function(){
			return {
				itemGroups: [],
				selectedGroup: null,
				showTab: {
					from: 0,
					to: 3,
					tabLimit: 4
				},
				items: [],
				showItem: {
					from: 0,
					to: 3,
					page: 1,
					pageLimit: 4,
					totalPage: 1
				},
				bspkItems: [],
				showBspkItem: {
					from: 0,
					to: 4,
					page: 1,
					pageLimit: 5,
					totalPage: 1
				},
				confirm: {
					show: false,
					message: `
						준비중/인수완료 의 경우<br>
						취소가 불가능 합니다.<br>
						주문하시겠습니까?
					`
				},
				closeTime: {
					all: {
						start: 700,
						end: 2030,
						message: "육류/떡 제외한 주문시간은 08시에서 20시 30분까지 입니다."
					},
					// 떡
					"01": {
						start: 800,
						end: 1900,
						message: "떡 주문시간은 08시에서 19시까지 입니다."
					},
					// 수육
					"02": {
						start: 700,
						end: 2000,
						message: "육류 주문시간은 07시에서 20시까지 입니다."
					}
				}
			}
		},
		watch: {
			selectedGroup: function(){

				store.commit("loading", true)

				var _this = this
				var partCode = this.selectedGroup.partCode
				var groupCode = this.selectedGroup.groupCode

				$.ajax({
		            type:"GET",
		            url:`/api/v1/BSPK1000/item?partCode=${partCode}&groupCode=${groupCode}`,
		            dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
		            success : function(data) {
		        		_this.items = data.list

		    			_this.showItem.from = 0
		    			_this.showItem.to = 3
		        		_this.showItem.page = 1
		        		_this.showItem.totalPage = Math.ceil(data.list.length/_this.showItem.pageLimit)
		            },
		            complete : function(data) {
		            	store.commit("loading", false)
		            },
		            error : function(xhr, status, error) {
			        	store.commit("message", {show: true, text: "에러발생, 계속 문제가 발생하면 관리자에게 문의하세요."})
		            }
				});

				return this.selectedGroup
			}
		},
		computed: {
			totalCnt: function(){
				return this.bspkItems.length
			},
			totalAmt: function(){
				return this.bspkItems.map(function(i){
					return i.salePrice*i.qty
				}).reduce(function(a,b){return a+b}, 0)
			},
		},
		methods: {
			close: function(){
				this.$emit('close')
			},
			getItemGroup: function(){

				store.commit("loading", true)

				var _this = this
				$.ajax({
		           type:"GET",
		           url:`/api/v1/BSPK1000/itemGroup?partCode=22-001`,
		           dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
		           success : function(data) {
		        	   _this.itemGroups = data.map.itemGroups
		        	   _this.selectedGroup = _this.itemGroups[0]
		           },
		           complete : function(data) {
		        	   store.commit("loading", false)
		           },
		           error : function(xhr, status, error) {
			        	store.commit("message", {show: true, text: "에러발생, 계속 문제가 발생하면 관리자에게 문의하세요."})
		           }
				});
			},
			selectTab: function(idx){
				this.selectedGroup = this.itemGroups[idx]
			},
			prevTab: function(){
				var from = this.showTab.from-this.showTab.tabLimit
				var to = this.showTab.to-this.showTab.tabLimit

				if(!this.itemGroups[from]){
					return
				}else{
					this.showTab.from = from
					this.showTab.to = to
					this.selectedGroup = this.itemGroups[from]
				}
			},
			nextTab: function(){
				var from = this.showTab.from+this.showTab.tabLimit
				var to = this.showTab.to+this.showTab.tabLimit

				if(!this.itemGroups[from]){
					return
				}else{
					this.showTab.from = from
					this.showTab.to = to
					this.selectedGroup = this.itemGroups[from]
				}
			},
			numberWithCommas: function (x) {
			    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
			},
			prevPage: function(){
				var from = this.showItem.from-this.showItem.pageLimit
				var to = this.showItem.to-this.showItem.pageLimit

				if(!this.items[from]){
					return
				}else{
					this.showItem.from = from
					this.showItem.to = to
					this.showItem.page--
				}
			},
			nextPage: function(){
				var from = this.showItem.from+this.showItem.pageLimit
				var to = this.showItem.to+this.showItem.pageLimit

				if(!this.items[from]){
					return
				}else{
					this.showItem.from = from
					this.showItem.to = to
					this.showItem.page++
				}
			},
			minusSaleQty: function(idx){
				if(this.bspkItems[idx].qty - this.bspkItems[idx].saleQty > 0){
					this.bspkItems[idx].qty -= this.bspkItems[idx].saleQty
				}
			},
			plusSaleQty: function(idx){
				this.bspkItems[idx].qty += this.bspkItems[idx].saleQty
			},
			deleteBspkItem: function(idx){
				this.bspkItems[idx].qty = this.bspkItems[idx].saleQty
				this.bspkItems.splice(idx, 1)
			},
			prevBspkItem: function(){
				var from = this.showBspkItem.from-this.showBspkItem.pageLimit
				var to = this.showBspkItem.to-this.showBspkItem.pageLimit

				if(!this.bspkItems[from]){
					return
				}else{
					this.showBspkItem.from = from
					this.showBspkItem.to = to
					this.showBspkItem.page--
				}
			},
			nextBspkItem: function(){
				var from = this.showBspkItem.from+this.showBspkItem.pageLimit
				var to = this.showBspkItem.to+this.showBspkItem.pageLimit

				if(!this.bspkItems[from]){
					return
				}else{
					this.showBspkItem.from = from
					this.showBspkItem.to = to
					this.showBspkItem.page++
				}
			},
			isClose: function(groupCode){
				var closeTime = this.closeTime[groupCode]
				if(!closeTime){
					closeTime = this.closeTime.all
				}
				var now = +store.getters.getTime.substr(-5).replace(":", "")
				if(store.getters.getTime.substr(14, 2) == "오후"){
					now += 1200
				}

				return {close: !(now >= closeTime.start && now <= closeTime.end), message: closeTime.message}
			},
			addBspkItem: function(item){

				var closeTime = this.isClose(item.groupCode)
				if(closeTime.close){
					store.commit("message", {show: true, text: closeTime.message})
					return
				}

				var idx = -1
				var eqitem = this.bspkItems.filter(function(o, i){
					if(item.partCode == o.partCode && item.itemCode == o.itemCode){
						idx = i
						return true
					}
					return false
				})

				if(eqitem && eqitem.length > 0){
					this.bspkItems[idx].qty += this.bspkItems[idx].saleQty
				}else{
					item.qty = item.saleQty
					this.bspkItems.unshift(item)
				}
			},
			closeConfirm: function(){
				this.confirm.show = false
			},
			openConfirm: function(){
				this.confirm.show = true
			},
			save: function(){

				store.commit("loading", true)

				var _this = this
				var binsoCode = store.getters.getBinsoCode
				var customerNo = store.getters.getBinso.customerNo

				$.ajax({
			        type:"PUT",
			        url:`/api/v1/BSPK1000/bspk?binsoCode=${binsoCode}&customerNo=${customerNo}`,
			        cache:false,
					timeout : 30000,
					contentType:"application/json; charset=UTF-8",
			        dataType:"JSON",
			        data: JSON.stringify(this.bspkItems),
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