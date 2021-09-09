<template>
        <div class="order-table-2">
            <table border="1">
                <thead>
	                <tr>
	                    <th class="fixed-header">번호</th>
	                    <th class="fixed-header">주문시간</th>
	                    <th class="fixed-header">호실</th>
	                    <th class="fixed-header">주문금액(원)</th>
	                    <th class="fixed-header">진행상태</th>
	                </tr>
                </thead>
                <tbody>
                	<template v-for="(ss, index) in stmt">
		                <tr v-if="index%2 == 0" @click="selectStmt(ss)">
		                    <td :class="isSelected(ss) ? 'selected-stmt':''">{{ss.partName}}#{{ss.billNo}}</td>
		                    <td :class="isSelected(ss) ? 'selected-stmt':''">{{ss.regtime}}</td>
		                    <td :class="isSelected(ss) ? 'selected-stmt':''">{{ss.binsoName}}</td>
		                    <td :class="isSelected(ss) ? 'selected-stmt':''">{{numberWithCommas(ss.amount)}}</td>
		                    <td><span :class="'box-full ' + colorMapping[ss.bspkStatus]">{{ss.bspkStatusName}}</span></td>
		                </tr>
		                <tr v-if="index%2 != 0" @click="selectStmt(ss)">
		                    <th :class="isSelected(ss) ? 'selected-stmt':''">{{ss.partName}}#{{ss.billNo}}</th>
		                    <th :class="isSelected(ss) ? 'selected-stmt':''">{{ss.regtime}}</th>
		                    <th :class="isSelected(ss) ? 'selected-stmt':''">{{ss.binsoName}}</th>
		                    <th :class="isSelected(ss) ? 'selected-stmt':''">{{numberWithCommas(ss.amount)}}</th>
		                    <th><span :class="'box-full ' + colorMapping[ss.bspkStatus]">{{ss.bspkStatusName}}</span></th>
		                </tr>
                	</template>
                </tbody>
            </table>
        </div>
</template>
<style>
.selected-stmt {
	background-color: gray !important;
}
</style>
<script>
module.exports = {
	name: "StmtList",
	data: function() {
		return {
			colorMapping: {
				"BSPK000010": "color-01",
				"BSPK000020": "color-02",
				"BSPK000030": "color-03",
				"BSPK000040": "color-04"
			},
			selectedStmtKey: {
				customerNo: '',
				partCode: '',
				billNo: -1,
			}
		}
	},
	computed: {
		loading: function(){
			return store.getters.isLoading
		},
		message: function(){
			return store.getters.isMessage
		},
		stmt: function(){
			return store.getters.getData.stmt || []
		},
		selectedStmt: function(){

			for(var i=0; i<this.stmt.length; i++){
				if(this.isSelected(this.stmt[i])){
					return this.stmt[i]
				}
			}

			return {}
		},
	},
	watch: {
		selectedStmt: function(){
			var stmt = this.selectedStmt
			store.commit("selectStmt", stmt);
			return stmt
		}
	},
	mounted: function(){
		var _this = this
	},
	methods: {
		numberWithCommas: function (x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		},
		selectStmt: function(stmt){
			this.selectedStmtKey.customerNo = stmt.customerNo
			this.selectedStmtKey.partCode = stmt.partCode
			this.selectedStmtKey.billNo = stmt.billNo
		},
		isSelected: function(stmt){
			if(
					this.selectedStmtKey.customerNo == stmt.customerNo
					&& this.selectedStmtKey.partCode == stmt.partCode
					&& this.selectedStmtKey.billNo == stmt.billNo
					){
				return true
			}else{
				return false
			}
		}
	}
}
</script>