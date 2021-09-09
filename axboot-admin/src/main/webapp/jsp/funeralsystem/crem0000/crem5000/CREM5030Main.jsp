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
		, pageStart : function(){
			fnObj.wc = new WC("ws://localhost:8080/wst/crem5030");
			fnObj.wc.init();
			fnObj.wc.controllers.display = function(data){
				board.showDoc("crem5030", data);  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
			};
			board.setTime(8);
			board.addPage('crem5030', 'CREM5030.jsp', 0);	// 페이지추가
			board.setTarget('#main');
			board.loadDocument();
			board.getDocuments().crem5030.before = fnObj.crem5030WithWebSocket;
// 			board.show();
		}
		, burnNo : '${param.burnNo}'
		, crem5030WithWebSocket : function(doc, data){

        	 if(!data.burnLineInfo){
        		 return;
        	 }

			$('#deadName', doc).html(data.burnLineInfo.deadName + "<sub>님</sub>");
			$('#burnStatus', doc).html(data.burnLineInfo.burnStatusNm);
			$('#burnStatus', doc).assClass('status_color_'+data.burnLineInfo.burnStatus);

		}

}

$(document).ready(fnObj.pageStart);

</script>
<title>화로</title>
</head>
<body>

<div id="main" style="height: 100%;">
</div>
</body>
</html>