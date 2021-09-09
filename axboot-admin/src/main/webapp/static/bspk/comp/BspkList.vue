<template>

    <div class="section">

		<table>
			<tr>
				<td colspan="2" align="center">
					상주 : {{stmt.applName}}
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					{{stmt.regtime2}}
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					{{stmt.binsoName}}
				</td>
			</tr>
			<tr>
				<td align="center">품명</td>
				<td align="center">수량</td>
			</tr>
			<tr v-for="bd in stmt.saleStmtBdList">
				<td align="center">{{bd.item.itemName}}</td>
				<td align="center">{{bd.qty}}</td>
			</tr>
		</table>

    </div>

</template>
<script>
module.exports = {
	name: "BspkList",
	mounted: function(){
// 		this.print()
	},
	props: ["stmt"],
	data: function(){
		return {
		}
	},
	watch: {
	},
	computed: {
	},
	methods: {
		print: function(){
			window.print()
		},
	}
}
</script>