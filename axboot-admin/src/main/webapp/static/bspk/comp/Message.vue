<template>
    <!--팝업창 시작-->
    <div class="popup-bg">
        <div class="popup-box-mss">
            <div class="popup-box-order-tit-mss">
                알림
            </div>
            <div class="popup-box-close-mss">
                <button class="btn-close" @click="close">X</button>
            </div>
            <div class="text-mss">
                <h5>{{message}}</h5>
            </div>
            <div class="btn-mss">
<!--                     <button class="red">취소</button> -->
                    <button @click="close">확인</button>
            </div>
        </div>
    </div><!--팝업창 끝-->
</template>
<script>
module.exports = {
	name: "Message",
	mounted: function(){
	},
	data: function(){
		return {
		}
	},
	watch: {
	},
	computed: {
		message: function(){
			return store.getters.getMessage
		}
	},
	methods: {
		close: function(){
			store.commit("message", {show: false})
		}
	}
}
</script>