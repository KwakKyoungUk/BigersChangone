﻿<%@ page contentType="text/html; charset=UTF-8" %>
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
<title>발인</title>
<script type="text/javascript">
	var fnObj = {
			wc: new WC("ws://"+location.host+"/wst/DISP0050", function(){
				if(board.getDocuments().DISP0050){
					board.showDoc("DISP0050");
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
				board.addPage('DISP0050', '/static/disp/04.html', 0);	// 페이지추가
				board.setTarget('#main');	// 표출 요소
				board.loadDocument();	// 추가한 페이지 로드
				board.getDocuments().after = fnObj.aop.postShow;
				board.getDocuments().DISP0050.before = fnObj.aop.before.DISP0050;	// 추가된 페이지가 그려지기전 호출할 함수
				board.getDocuments().DISP0050.after = fnObj.aop.after.DISP0050;	// 추가된 페이지가 그려지기후 호출할 함수
//	 			board.show();	// 페이지 출력  --> ajax polling
				board.showDoc("DISP0050");
			}
			, bindEvent: function(){

			}
			, controllers: {
				board: function(data){
					board.showDoc("DISP0050", data);
				}
			}
			/*
				페이지가 그려지기 직전 html 수정
			*/
			, aop: {
				postShow: function(){
				}
				, before: {
					DISP0050: function(doc, data){
						fnObj.eventFunc.bindBoardData(doc, data);
					}
				}
				, after: {
					DISP0050: function(doc, data){
					}
				}
			}
			, eventFunc: {
				main: function(){
					board.showDoc("DISP0050");  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
				}
				, bindBoardData: function(doc, data){
					if(!data){
						return;
					}

					$(".deceased_03_nick", doc).html(data.thedead.deadFaithNm || '');
					$(".deceased_03_name", doc).html(data.thedead.deadName || '');
					$(".deceased_04_chief_name", doc).html(data.applicant.applName || '');
					$(".deceased_04_casket_date", doc).html($.format.date(data.balinDate+":00.000", "MM월 dd일 HH시 mm분") || '');
					$(".deceased_04_burial_date", doc).html(data.jangji || '');

					if(data.photo && data.photo.photoImage){
						$("#img-photo", doc).attr("src", data.photo.photoImage);
					}else{
						$("#img-photo", doc).attr("src", "/static/images/flower.jpg");
					}
					$("Header", doc).addClass(fnObj.binso[data.binsoCode]);
				}
			}, binso: {
				"101": "tit_hd"
					, "102": "tit_jd"
					, "103": "tit_cb"
					, "104": "tit_hs"
					, "105": "tit_mh"
					, "106": "tit_sk"
					, "107": "tit_sl"
					, "108": "tit_ml"
					, "109": "tit_db"
					, "110": "tit_js"
					, "111": "tit_bs"
					, "112": "tit_ks"
					, "113": "tit_jm"
					, "114": "tit_cj"
					, "800": ""
					, "801": ""
					, "802": ""
					, "803": ""
					, "804": ""
					, "900": ""
					, "901": ""
					, "902": ""
					, "999": ""
				}
	}

	$(document).ready(fnObj.pageStart);
</script>

</head>
<body><div id="main"></div>
     <!--상주 및 유족 정보 시작-->
     <div class="deceased_03_family">
     	 <marquee direction="up" style="width: 100%; height: 100%;" scrollamount="2">
         </marquee>
     </div>
     <!--상주 및 유족 정보 끝-->
</body>
</html>

