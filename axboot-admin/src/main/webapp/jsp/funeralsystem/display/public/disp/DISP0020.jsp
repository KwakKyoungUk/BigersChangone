<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.File"%>
<%
/**
요청시 응답 형식은 ajax 사용
요청시 응답이 필요 없을경우는 websocket 사용
  - 예:운영환경 변경시 클라이언트 피씨에서 ajax로 확인하려면 주기적으로 서버에 요청해야만 알수 있으나,
  		websocket 사용시 운영환경이 변경될때 서버에서 각 기기로 websocket으로 신호를 주면 그애 해당하는 일을 처리할 수 있음.
*/
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="No-Cache">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/plugins/axicon/axicon.min.css"/>
<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath }/static/css/common/board.css"/>
<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath }/static/css/common/bord.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/disp/css/style.css">
<%-- style2.css와 style3.css는 areaCd를 조건으로 동적으로 로딩함. --%>
<%-- <link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath }/static/jere/css/style2.css"/> --%>
<%-- <link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath }/static/jere/css/style3.css"/> --%>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/static/display/icon/display.ico">
<script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/jquery/jquery-dateFormat.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/board.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/html2canvas.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/common/websocket-controller.js"></script>
<title>안치실</title>
<script type="text/javascript">
	var fnObj = {
			wc: new WC("ws://"+location.host+"/wst/DISP0020", function(){
				if(board.getDocuments().DISP0020){
					board.showDoc("DISP0020");
				}
			})
			, pageStart: function(){
				fnObj.wc.init();
				for(var key in fnObj.controllers){
					fnObj.wc.controllers[key] = fnObj.controllers[key];
				}

				fnObj.initBoard();
				fnObj.bindEvent();
			}
			, initBoard: function(){
				board.setTime(8);		// 반복 시간(ajax polling 사용시)
				board.addPage('DISP0020', '/static/disp/02.html', 0);	// 페이지추가
				board.setTarget('#main');	// 표출 요소
				board.loadDocument();	// 추가한 페이지 로드
				board.getDocuments().after = fnObj.aop.postShow;
				board.getDocuments().DISP0020.before = fnObj.aop.before.DISP0020;	// 추가된 페이지가 그려지기전 호출할 함수
				board.getDocuments().DISP0020.after = fnObj.aop.after.DISP0020;	// 추가된 페이지가 그려지기후 호출할 함수
//	 			board.show();	// 페이지 출력  --> ajax polling
				board.showDoc("DISP0020");
			}
			, bindEvent: function(){

			}
			, controllers: {
				board: function(data){
					board.showDoc("DISP0020", data);
				}
			}
			/*
				페이지가 그려지기 직전 html 수정
			*/
			, aop: {
				postShow: function(){
				}
				, before: {
					DISP0020: function(doc, data){
						fnObj.eventFunc.bindBoardData(doc, data);
					}
				}
				, after: {
					DISP0020: function(doc, data){
					}
				}
			}
			, eventFunc: {
				main: function(){
					board.showDoc("DISP0020");  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
				}
				, bindBoardData: function(doc, data){

					$(".clock span", doc).html(data.now);

					var getGubun = function(funeral){
						if(funeral.ibkwanDate.startsWith(data.now2)){
							return "bl";
						}else if(funeral.balinDate.startsWith(data.now2)){
							return "gl";
						}else{
							return "";
						}
					};

					var getSex = function(funeral){
						if("TCM0500001"==(funeral.thedead.deadSex)){
							return "남";
						}else if("TCM0500002"==(funeral.thedead.deadSex)){
							return "여";
						}else{
							return "불명";
						}
					}

					var getAge = function(funeral){
// 						return (+data.now.substring(0, 4)) - (+funeral.thedead.deadBirth.substring(0, 4))+1;
					}

					var listBtnWrap = [];

					$.each(data.all, function(i, o){
						var html = '';
						if(o != null){
							html = '<ul class="btn">'
						                 +'<li class="num">'+o.anchiRoom+'</li>'
						                 +'<li class="name">'
						                     +'<ul class="'+getGubun(o)+'">'
						                         +'<li>'+o.thedead.deadName+'</li>'
						                         +'<li>'+getSex(o)+' / '+(o.thedead.deadAge || '')+'</li>'
						                     +'</ul>'
						                 +'</li>'
						             +'</ul>';
						}else{
							html = '<ul class="btn">'
				                 +'<li class="num"></li>'
				                 +'<li class="name">'
				                     +'<ul class="">'
				                         +'<li></li>'
				                         +'<li></li>'
				                     +'</ul>'
				                 +'</li>'
				             +'</ul>';
						}

						listBtnWrap.push(html);
					});

					$(".list_btn_wrap", doc).html(listBtnWrap.join(""));

					var listBody = [];
					$.each(data.list, function(i, o){
			             var html = '<ul>'
							                 +'<li class="w01">'+o.anchiRoom+'</li>'
							                 +'<li class="w02 ">'+o.thedead.deadName+'</li>'
							                 +'<li class="w03">'+getSex(o)+'</li>'
							                 +'<li class="w04">'+(o.thedead.deadAge || '')+'</li>'
							                 +'<li class="w05">'+o.binso.binsoName+'</li>'
							                 +'<li class="w06">'+$.format.date(o.anchiDate+":00.000", "MM월 dd일 HH:mm")+'</li>'
							                 +'<li class="w07">'+$.format.date(o.ibkwanDate+":00.000", "MM월 dd일 HH:mm")+'</li>'
							                 +'<li class="w08">'+$.format.date(o.balinDate+":00.000", "MM월 dd일 HH:mm")+'</li>'
							             +'</ul>';
							             listBody.push(html);
					});
					$(".list_body", doc).html(listBody.join(""));
				}
			}
	}

	$(document).ready(fnObj.pageStart);
</script>

</head>
<body><div id="main"></div>

</body>
</html>

