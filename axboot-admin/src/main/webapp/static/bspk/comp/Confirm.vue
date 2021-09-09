<template>

    <!--비밀번호 입력 팝업창 시작-->
    <div class="popup-bg">
        <div class="pw-popup-box-mss bor">

            <div class="pw-popup-box-close-mss">
                <button class="btn-close" @click="close">X</button>
            </div>
            <div class="pw-text-mss">
                <h5 v-html="question"></h5>
            </div>
            <div class="pw-popup-box-wrap">
                <div class="pw-keypad">
                    <div class="pw-pw-input">
                        <input type="password" v-model="password">
                    </div>
                    <div class="pw-pw-key">
                        <table>
                            <tr>
                                <td><a @click="inputNum(1)">1</a></td>
                                <td><a @click="inputNum(2)">2</a></td>
                                <td><a @click="inputNum(3)">3</a></td>
                            </tr>
                            <tr>
                                <td><a @click="inputNum(4)">4</a></td>
                                <td><a @click="inputNum(5)">5</a></td>
                                <td><a @click="inputNum(6)">6</a></td>
                            </tr>
                            <tr>
                                <td><a @click="inputNum(7)">7</a></td>
                                <td><a @click="inputNum(8)">8</a></td>
                                <td><a @click="inputNum(9)">9</a></td>
                            </tr>
                            <tr>
                                <td><a @click="backSpace">←</a></td>
                                <td><a @click="inputNum(0)">0</a></td>
                                <td><a @click="callback">확인</a></td>
                            </tr>
                        </table>
                    </div>
                </div> <!--keypad end-->

            </div>
        </div>
    </div><!--비밀번호 입력 팝업창 끝-->

</template>
<script>
module.exports = {
	name: "Confirm",
	mounted: function(){
	},
	props: ["question"],
	data: function(){
		return {
			password: ""
		}
	},
	watch: {
	},
	computed: {
	},
	methods: {
		close: function(){
			this.$emit('close')
		},
		callback: function(){
			// 비밀번호 체크
			store.commit("loading", true)

			var _this = this
			var binsoCode = store.getters.getBinsoCode
			var binsoPass = this.password

			$.ajax({
		           type:"POST",
		           url:`/api/v1/BSPK1000/password?binsoCode=${binsoCode}&binsoPassword=${binsoPass}`,
		           dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
		           success : function(data) {
		        	   if(data.status == 0){
		        		   _this.$emit('callback')
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


		},
		inputNum: function(num){
			if(this.password.length < 4){
				this.password = this.password+(num+"")
			}
		},
		backSpace: function(){
			this.password = this.password.slice(0, this.password.length-1)
		},
	}
}
</script>