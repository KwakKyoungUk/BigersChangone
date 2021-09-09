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
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/dispnew/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/dispnew/css/style4.css">
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
<title>현황판</title>
<script type="text/javascript">
	var fnObj = {
			// orderNo 1번 : 앞 4명 2번: 뒤 4명
			wc: new WC("ws://"+location.host+"/wst/DISP0014/${param.orderNo}", function(){
				if(board.getDocuments().DISP0014){
					board.showDoc("DISP0014");
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
				board.addPage('DISP0014', '/static/dispnew/01_1920_3.html', 0);	// 페이지추가
				board.setTarget('#main');	// 표출 요소
				board.loadDocument();	// 추가한 페이지 로드
				board.getDocuments().after = fnObj.aop.postShow;
				board.getDocuments().DISP0014.before = fnObj.aop.before.DISP0014;	// 추가된 페이지가 그려지기전 호출할 함수
				board.getDocuments().DISP0014.after = fnObj.aop.after.DISP0014;	// 추가된 페이지가 그려지기후 호출할 함수
//	 			board.show();	// 페이지 출력  --> ajax polling
				board.showDoc("DISP0014");
			}
			, bindEvent: function(){

			}
			, controllers: {
				board: function(data){
					board.showDoc("DISP0014", data);
				}
			}
			/*
				페이지가 그려지기 직전 html 수정
			*/
			, aop: {
				postShow: function(){
				}
				, before: {
					DISP0014: function(doc, data){
						$(".container table tbody tr td img").unbind("error");
						fnObj.eventFunc.bindBoardData(doc, data);
					}
				}
				, after: {
					DISP0014: function(doc, data){
						$(".container table tbody tr td img").bind("error", function(){
							$(this).attr("src", "/static/images/flower.jpg");
						})
					}
				}
			}
			, eventFunc: {
				main: function(){
					board.showDoc("DISP0014");  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
				}
				, bindBoardData: function(doc, data){

					if(!data){
						return;
					}

					$(".clock_S span", doc).html(data.now);

					if(!data.content){
						return;
					}

					var contents = data.content;

					var convertLiveName = function(liveName){
						var liveNames = liveName.split(",");
						var html = []
						if(liveNames.length>20){
							html.push("<marquee direction='up' scrolldelay=200 style='height: 202px;'>");
// 							html.push("<marquee direction='up' scrolldelay=200 style='height: 320px; margin-top: -160;'>");
							$.each(liveNames, function(i, o){
								html.push("<div style='width: 180; display: inline-block;'>"+o+"</div>")
							});
							html.push("<br>");
							html.push("<br>");
							html.push("<br>");
							$.each(liveNames, function(i, o){
								html.push("<div style='width: 180; display: inline-block;'>"+o+"</div>")
							});
							html.push("<br>");
							html.push("<br>");
							html.push("<br>");
							$.each(liveNames, function(i, o){
								html.push("<div style='width: 180; display: inline-block;'>"+o+"</div>")
							});
							html.push("</marquee>");
						}else{
							$.each(liveNames, function(i, o){
								html.push("<div style='width: 180; float: left;'>"+o+"</div>")
							});
						}
						return html.join("");
					}

					$.each(contents, function(i, o){
 						var tr = $(".container table tbody tr:eq("+i+")", doc);
 						tr.find("td:eq(0)").html(o.binso.binsoFloor+"<br>"+"<b>"+o.binso.displayBinso+"</b>");
 						tr.find("td:eq(1)").html("<b>"+o.thedead.deadName+"</b>");
 						if(o.photo){
	 						tr.find("td:eq(2) img").attr("src", o.photo.photoImage);
 						}
 						tr.find("td:eq(3)").html(convertLiveName(o.liveName02));
 						tr.find("td:eq(4)").html(o.balinDate.replace(" ", "<br>")+"<br>"+o.jangji);
					});
				}
			}
	}

	$(document).ready(fnObj.pageStart);
</script>

</head>
<body><div id="main"></div>

</body>
</html>
