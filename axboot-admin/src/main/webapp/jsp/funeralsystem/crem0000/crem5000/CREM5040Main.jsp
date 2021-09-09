<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath }/static/display/css/board.css"/>
<link rel="stylesheet" type="text/css"  href="${pageContext.request.contextPath }/static/display/css/bord.css"/>
<link rel="shortcut icon" href="${pageContext.request.contextPath }/static/display/icon/display.ico">
<script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/display/js/board.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/display/js/html2canvas.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/display/js/websocket-controller.js"></script>
<script type="text/javascript">

var fnObj = {
		wc : null
		,pageStart : function(){
			fnObj.wc = new WC("ws://localhost:8080/wst/crem5040");
			fnObj.wc.init();
			fnObj.wc.controllers.display = function(data){
				board.showDoc("crem5040", data);  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
			};
			board.setTime(8);
			board.addPage('crem5040', 'CREM5040.jsp', 0);	// 페이지추가
			board.setTarget('#main');
			board.loadDocument();
			board.getDocuments().crem5040.before = fnObj.crem5040WithWebSocket;
// 			board.show(); // 페이지 출력  --> ajax polling
		}
		, byeRoom : '${param.byeRoom}'
		, crem5040WithWebSocket : function(doc, data){

        	 if(!data.byeRoomInfo){
        		 return;
        	 }

			$('#deadName', doc).html(data.byeRoomInfo.deadName + "<sub>님</sub>");
		}
};

$(document).ready(fnObj.pageStart);
</script>
<title>고별</title>
</head>
<body>

<div id="main" style="height: 100%;">
</div>
</body>
</html>