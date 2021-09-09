<template>
    <div class="order-popup-list-check">
	    <table class="">
	    	<template v-for="(bd, index) in stmtbd.list">
		        <tr v-if="index%2 == 0">
		            <th class="list-num">{{bd.seqNo}}</th>
		            <th class="list-menu">{{bd.item.itemName}}</th>
		            <th class="list-count">{{bd.qty}}개</th>
		            <th class="list-price">{{numberWithCommas(bd.amount)}}</th>
		            <th class="list-status">{{bd.status == 1 ? '인계완료' : ''}}</th>
		        </tr>
		        <tr v-if="index%2 != 0">
		            <td class="list-num">{{bd.seqNo}}</td>
		            <td class="list-menu">{{bd.item.itemName}}</td>
		            <td class="list-count">{{bd.qty}}개</td>
		            <td class="list-price">{{numberWithCommas(bd.amount)}}</td>
		            <td class="list-status">{{bd.status == 1 ? '인계완료' : ''}}</td>
		        </tr>
	    	</template>
	    </table>
	</div>
</template>
<script>
module.exports = {
	name: "StmtbdList",
	props: ["stmt"],
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
		stmtbd: function(){
			return {
				list: this.stmt.saleStmtBdList
			}
		}
	},
	mounted: function(){
		var _this = this
	},
	methods: {
		numberWithCommas: function (x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		},
	}
}
</script>