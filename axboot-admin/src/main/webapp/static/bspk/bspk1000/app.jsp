<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
		<meta charset="UTF-8">
		<title>빈소주문시스템</title>
		<link rel="stylesheet" href="../static/css/style_binso.css?v=1">
</head>
<body>

	<div id="app"></div>

	<script type="text/javascript" src="../static/js/jquery.min.js"></script>
	<script type="text/javascript" src="../static/js/websocket-controller.js"></script>
	<script type="text/javascript" src="../static/js/vue.js"></script>
	<script type="text/javascript" src="../static/js/vuex.js"></script>
	<script type="text/javascript" src="../static/js/vue-router.js"></script>
	<script type="text/javascript" src="../static/js/httpVueLoader.js"></script>
	<script type="text/javascript" >

	Vue.use(Vuex)

	const store = new Vuex.Store({
		state: {
			data: {},
			time: "",
			loginSuccess: false,
			binsoCode: "${param.binsoCode}",
			binsoPassword: "",
			binso: {},
			loading: false,
			message: {
				show: false,
				text: ""
			}
		},
		mutations: {
			loginSuccess: function (state, payload) {
				state.loginSuccess =  true
				state.binsoPassword = payload.binsoPassword
			},
			loginFail: function (state, payload) {
				state.loginSuccess = false
				state.binsoPassword = ""
			},
			logout: function (state, payload) {
				state.loginSuccess = false
				state.binsoPassword = ""
			},
			binso: function (state, payload) {
				if(payload){
					state.binso = payload
				}
			},
			time: function (state, payload) {
				state.time = payload
			},
			mainData: function (state, payload) {
				if(payload){
					state.data = payload
				}
			},
			loading: function(state, payload){
				state.loading = payload
			},
			message: function(state, payload){
				state.message.show = payload.show
				state.message.text = payload.text
			}
		},
		getters: {
	        isLoggedIn: function(state){
	        	return state.loginSuccess
	        },
	        getBinsoCode: function(state){
	        	return state.binsoCode
	        },
	        getBinsoPassword: function(state){
	        	return state.binsoPassword
	        },
	        getBinso: function(state){
	        	return state.binso
	        },
	        getTime: function(state){
	        	return state.time
	        },
	        getData: function(state){
	        	return state.data
	        },
	        isLoading: function(state){
	        	return state.loading
	        },
	        isMessage: function(state){
	        	return state.message.show
	        },
	        getMessage: function(state){
	        	return state.message.text
	        }
	    }
	})

	var binsoCode = store.getters.getBinsoCode
	var host = location.host

	var wc = new WC(`ws://\${host}/wst/bspk1000/\${binsoCode}`)
	wc.init()
	wc.controllers.defaultData = function(data){
		store.commit("time", data.date_aKKmm)
	};
	wc.controllers.mainData = function(data){
		store.commit("mainData", data)
	};
	wc.controllers.refresh = function(data){
		window.location.reload()
	};

	var Login = httpVueLoader("../comp/01.login.vue?t=" + new Date().getTime())
	var Main = httpVueLoader("../comp/02.main.vue?t=" + new Date().getTime())
	var App = httpVueLoader("../comp/BSPK1000.vue?t=" + new Date().getTime())

	const routes = [
		{ path: '/', component: Login },
		{ path: '/main', component: Main }
	]
	const router = new VueRouter({
		routes: routes
	});

	new Vue({
		render: function(h){
			return h(App)
		},
		router: router
	}).$mount('#app');

	</script>
</body>
</html>