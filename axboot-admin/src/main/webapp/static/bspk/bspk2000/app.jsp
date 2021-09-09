<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>주문알림시스템</title>
	<link rel="stylesheet" href="../static/css/style_binso.css">
	<style >
		.section, .section *{
			visibility: hidden;
		}
		.section table{
			width: 100%;
		}
		.section table td {
			border: 1px solid black;
		}
		.section .binsoName {
			color: white;
			background-color: black;
			font-weight: bolder;
		}
		@media print {
			html, body {
				width: 100vw;
				height: auto;
				margin: 0 !important;
				padding: 0 !important;
				overflow: hidden;
			}
			body * {
				visibility: hidden;
			}
			.container-1920 {
				width: 0px;
				height: 0px;
			}
			.section, .section *{
				visibility: visible;
			}
			.section {
				position: absolute;
				padding-top: 5px;
				left: 0;
				top: 0;
				width: 	100vw;
				font-size: 2vw;
			}
			.section:last-child {
				 page-break-after: auto;
			}
		}
	</style>
</head>
<body>

	<div id="app">
		<main></main>
	</div>

	<script type="text/javascript" src="/static/plugins/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="/static/js/common/common.js"></script>
	<script type="text/javascript" src="../static/js/jquery.min.js"></script>
	<script type="text/javascript" src="../static/js/websocket-controller.js"></script>
	<script type="text/javascript" src="../static/js/vue.js"></script>
	<script type="text/javascript" src="../static/js/vuex.js"></script>
	<script type="text/javascript" src="../static/js/vuex-persistedstate.umd.js"></script>
	<script type="text/javascript" src="../static/js/httpVueLoader.js"></script>
	<script type="text/javascript" >

	var fnObj = {
		printQueue: []
	}

	Vue.use(Vuex)

	const store = new Vuex.Store({
// 		plugins: [createPersistedState()],
		state: {
			partCode: "${param.partCode}",
			onlyAlarm: "${param.onlyAlarm}" == "" ? "N" : "${param.onlyAlarm}",
			notice: {
				list: [],
				checked: []
			},
			selectedStmt: null,
			data: {
				stmt: []
			},
			time: "",
			loading: false,
			message: {
				show: false,
				text: ""
			}
		},
		mutations: {
			time: function (state, payload) {
				state.time = payload
			},
			loading: function(state, payload){
				state.loading = payload
			},
			message: function(state, payload){
				state.message.show = payload.show
				state.message.text = payload.text
			},
			mainData: function(state, data){
				state.data = data

				if(data.stmt && data.stmt.length == 0){
					return
				}

				var noticeList = data.stmt.filter(function(o, i){
					return o.bspkStatus == "BSPK000010"
				})

				if(!state.notice.checked || state.notice.checked.length == 0){
					state.notice.list = noticeList
					return
				}

				state.notice.checked = state.notice.checked.filter(function(o, i){

					var checkedNotice = noticeList.filter(function(o2, i2){
						if(o.customerNo == o2.customerNo
							&& o.partCode == o2.partCode
							&& o.billNo == o2.billNo
							&& o.regtime == o2.regtime
							){
							return true
						}
					})
					return checkedNotice.length > 0
				})

				state.notice.list = noticeList.filter(function(o, i){

					var checkedNotice = state.notice.checked.filter(function(o2, i2){
						if(o.customerNo == o2.customerNo
							&& o.partCode == o2.partCode
							&& o.billNo == o2.billNo
							&& o.regtime == o2.regtime
							){
							return true
						}
					})

					return checkedNotice.length == 0
				})
			},
			addNotice: function(state, stmt){
				state.notice.list.push(stmt)
			},
			shiftNotice: function(state, payload){
				var notice = state.notice.list.shift()
				if(notice){
					state.notice.checked.push(notice)
				}
			},
			selectStmt: function(state, payload){
				state.selectedStmt = payload
			}
		},
		getters: {
			getPartCode: function(state){
				return state.partCode
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
	        },
	        getCurrNotice: function(state){
	        	return state.notice.list[0]
	        },
	        getSelectedStmt: function(state){
	        	return state.selectedStmt
	        },
	        onlyAlarm: function(state){
	        	return state.onlyAlarm
	        }
	    }
	})

	var partCode = store.getters.getPartCode
	var host = location.host

	var wc = new WC(`ws://\${host}/wst/bspk2000/\${partCode}`)
	wc.init()
	wc.controllers.defaultData = function(data){
		store.commit("time", data.date_aKKmm)
	};
	wc.controllers.mainData = function(data){
		store.commit("mainData", data)
	};
	wc.controllers.addNotice = function(data){
		store.commit("addNotice", data)
	};

	var App = httpVueLoader("../comp/BSPK2000.vue")

	new Vue({
		render: function(h){
			return h(App)
		}
	}).$mount('#app');

	</script>
</body>
</html>