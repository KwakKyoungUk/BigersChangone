<template>
    <div class="order-popup-list-check">
    <table class="">
    	<template v-for="(bd,index) in stmtbd">
	        <tr v-if="index%2 == 0">
	            <th class="list-num">{{bd.seqNo}}</th>
	            <th class="list-menu">{{bd.item.itemName}}</th>
	            <th class="list-count">{{bd.qty}}개</th>
	            <th class="list-price">{{numberWithCommas(bd.amount)}}</th>
	        </tr>
	        <tr v-if="index%2 != 0">
	            <td class="list-num">{{bd.seqNo}}</td>
	            <td class="list-menu">{{bd.item.itemName}}</td>
	            <td class="list-count">{{bd.qty}}개</td>
	            <td class="list-price">{{numberWithCommas(bd.amount)}}</td>
	        </tr>
    	</template>
    </table>
</div>
</template>
<script>
module.exports = {
	name: "SubStmtbdList",
	props: ["stmtbd"],
	data: function() {
		return {
		}
	},
	computed: {
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