<template>
 <div class="container-1920 main-bg">

     <div class="header">
         <div class="header-L">
             <a class="" href="#">
                 <img src="../static/images/home_icon.png" style="vertical-align: bottom;">
             </a>
             {{binsoName}}
         </div>
         <div class="header-R">
             <a class="" href="#">
                 <img src="../static/images/time_icon.png" style="vertical-align: bottom;">
             </a>
             {{time}}
         </div>
     </div> <!--header end-->


     <div class="body">

         <!--빈소주문시스템 메인 박스 콘텐츠 시작-->
         <div class="main-mid">

             <div class="mid-tit">
                 <h3>빈소 주문 시스템</h3>
             </div>

             <div class="goin">
                 <div class="g-img">
                     <img :src="photoImage" onerror="this.src = '../static/images/login_sample_img.jpg'"><!--고인사진-->
                 </div>
                 <div class="g-name">
                     <h5 class=>{{deadName}}</h5>
                 </div>
             </div> <!--goin end-->

             <div class="keypad">
                 <div class="pw-input">
                     <input type="password" v-model="password">
                 </div>
                 <div class="pw-key">
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
                             <td><a @click="login">확인</a></td>
                         </tr>
                     </table>
                 </div>
             </div> <!--keypad end-->

             <div class="info-text">
                 <h6>※장례상담시 생성한 비밀번호 4자리를 입력해 주세요.</h6>
             </div>
         </div> <!--빈소주문시스템 메인 박스 콘텐츠 끝-->
     </div>  <!--body end-->
 </div>  <!--container end-->
</template>

<script>

module.exports = {
	name: "Login",
	mounted: function(){
		this.getBinsoData()
	},
	data: function(){
		return {
			binso: {binsoName: ""},
			date: "",
			password: "",
			wc: null
		}
	},
	computed: {
		binsoName: function(){
			if(store.getters.getBinso.binso){
				return store.getters.getBinso.binso.binsoName || ""
			}
		},
		deadName: function(){
			if(store.getters.getBinso && store.getters.getBinso.thedead){
				return store.getters.getBinso.thedead.deadName
			}else{
				return ""
			}
		},
		photoImage: function(){
			if(store.getters.getBinso && store.getters.getBinso.photo){
				return store.getters.getBinso.photo.photoImage
			}else{
				return ""
			}
		},
		time: function(){
			return store.getters.getTime
		}
	},
	methods: {
		inputNum: function(num){
			if(this.password.length < 4){
				this.password = this.password+(num+"")
			}
		},
		backSpace: function(){
			this.password = this.password.slice(0, this.password.length-1)
		},
		login: function(){

			store.commit("loading", true)

			var binsoCode = store.getters.getBinsoCode
			var binsoPass = this.password
			var _this = this

			$.ajax({
		           type:"POST",
		           url:`/api/v1/BSPK1000/login?binsoCode=${binsoCode}&binsoPassword=${binsoPass}`,
		           dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
		           success : function(data) {
		        	   if(data.status == 0){
		        		   store.commit('loginSuccess', {
                               binsoPass: binsoPass
                           });
		        		   _this.$router.push("/main")
		        	   }else{
		        		   store.commit("message", {show: true, text: data.error.message})
		        		   store.commit('loginFail', {
                               binsoPass: binsoPass
                           });
		        	   }
		           },
		           complete : function(data) {
		        	   store.commit("loading", false)
		           },
		           error : function(xhr, status, error) {
		        	   store.commit("message", {show: true, text: "에러발생, 계속 문제가 발생하면 관리자에게 문의하세요."})
		               store.commit('loginFail', {
                           binsoPass: binsoPass
                       });
		           }
		     });
		},
		getBinsoData: function(){

			var _this = this
			var binsoCode = store.getters.getBinsoCode

			var getData = function getData(){

				$.ajax({
			           	type:"GET",
			           	url:`/api/v1/BSPK1000/binsoData?binsoCode=${binsoCode}`,
			           	dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
			           	success : function(data) {
			        	   	store.commit("binso", data.map.binso)
			           	},
			           	complete : function(data) {
			        	   	setTimeout(getData, 5*1000)
			           	},
			           error : function(xhr, status, error) {
			           }
			    });
			}
			getData()
		},
	}
}
</script>