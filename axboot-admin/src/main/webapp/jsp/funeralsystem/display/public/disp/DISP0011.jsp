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
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/disp/css/style3.css">
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
			wc: new WC("ws://"+location.host+"/wst/DISP0011", function(){
				if(board.getDocuments().DISP0011){
					board.showDoc("DISP0011");
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
				board.addPage('DISP0011', '/static/disp/01_1024.html', 0);	// 페이지추가
				board.setTarget('#main');	// 표출 요소
				board.loadDocument();	// 추가한 페이지 로드
				board.getDocuments().after = fnObj.aop.postShow;
				board.getDocuments().DISP0011.before = fnObj.aop.before.DISP0011;	// 추가된 페이지가 그려지기전 호출할 함수
				board.getDocuments().DISP0011.after = fnObj.aop.after.DISP0011;	// 추가된 페이지가 그려지기후 호출할 함수
//	 			board.show();	// 페이지 출력  --> ajax polling
				board.showDoc("DISP0011");
			}
			, bindEvent: function(){

			}
			, controllers: {
				board: function(data){
					board.showDoc("DISP0011", data);
				}
			}
			/*
				페이지가 그려지기 직전 html 수정
			*/
			, aop: {
				postShow: function(){
				}
				, before: {
					DISP0011: function(doc, data){
						fnObj.eventFunc.bindBoardData(doc, data);
					}
				}
				, after: {
					DISP0011: function(doc, data){
					}
				}
			}
			, eventFunc: {
				main: function(){
					board.showDoc("DISP0011");  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
				}
				, bindBoardData: function(doc, data){

					$(".clock_S span", doc).html(data.now);

					if(!data.content){
						return;
					}
					var contents = data.content;

					$.each(contents, function(i, o){
						var rowClass = ["block_bl_S", "block_re_S", "block_gr_S"];
						$(".block_wood_S:eq("+i+") .room_fl_S h4", doc).html(o.binso.binsoFloor);
						$(".block_wood_S:eq("+i+") .room_na_S div", doc).html(o.binso.displayBinso);
						if(o.photo && o.photo.photoImage){
							$(".block_wood_S:eq("+i+") .photo_S .img_S img", doc).attr("src", o.photo.photoImage);
						}

						$(".block_wood_S:eq("+i+") .deceased_name_S", doc).html(o.thedead.deadName);
						$(".block_wood_S:eq("+i+") .deceased_nick_S", doc).html(o.thedead.deadFaithNm);
						$(".block_wood_S:eq("+i+") .deceased_carry_S", doc).html(
								$.format.date(o.balinDate+":00.000", "발인 : MM월 dd일 HH시")
								+ "<br/>"
								+ "장지 : " + o.jangji
								);
// 						$(".block_wood_S:eq("+i+") .deceased_burial_S", doc).html();

						if(!o.liveName02){
							return;
						}
						// 상주:홍길워:길달:달길:::::::,손녀:홍귀녀:강녀:소녀:::::::
						var html = ["<ul><li>"];

						$.each(o.liveName02.split(","), function(i, o2){
							html.push("<div style='float: left; width: 100px;'>"+o2+"</div>")
						});

						html.push("</li></ul>");

// 						var row = o.liveName01.split(",");
// 						$.each(row, function(i, o2){
// 							var col = o2.split(":");
// 							var temp = ['<li>('+col[0]+')  <span class="gap10"></span> '+col[1]];
							// <li>(손주)  <span class="gap10"></span> 준영<span class="gap20"></span> 민영<span class="gap20"></span> 수영<span class="gap20"></span> 창민<span class="gap20"></span> 연수<span class="gap20"></span> 철수<span class="gap20"></span> 민수</li>
// 							for(var i=2; i<col.length; i++){
// 								var tem = col[i];
// 								if(tem != ''){
// 									temp.push('<span class="gap20"></span> '+col[i]);
// 								}
// 							}
// 							temp.push("</li>");
// 							html.push(temp.join(""));
// 						});

						$(".block_wood_S:eq("+i+") .deceased_family_S", doc).html(html.join(""));
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

