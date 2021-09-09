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
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/disp/css/style.css?V=1">
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
<title>빈소</title>
<script type="text/javascript">
	var fnObj = {
			wc: new WC("ws://"+location.host+"/wst/DISP0030/${param.binsoCode}", function(){
				if(board.getDocuments().DISP0030){
					board.showDoc("DISP0030");
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
				board.addPage('DISP0030', '/static/disp/03.html', 0);	// 페이지추가
				board.setTarget('#main');	// 표출 요소
				board.loadDocument();	// 추가한 페이지 로드
				board.getDocuments().after = fnObj.aop.postShow;
				board.getDocuments().DISP0030.before = fnObj.aop.before.DISP0030;	// 추가된 페이지가 그려지기전 호출할 함수
				board.getDocuments().DISP0030.after = fnObj.aop.after.DISP0030;	// 추가된 페이지가 그려지기후 호출할 함수
//	 			board.show();	// 페이지 출력  --> ajax polling
				board.showDoc("DISP0030");
			}
			, bindEvent: function(){

			}
			, controllers: {
				board: function(data){
					board.showDoc("DISP0030", data);
				}
			}
			/*
				페이지가 그려지기 직전 html 수정
			*/
			, aop: {
				postShow: function(){
				}
				, before: {
					DISP0030: function(doc, data){
						fnObj.eventFunc.bindBoardData(doc, data);
					}
				}
				, after: {
					DISP0030: function(doc, data){
						if(!data.liveName01){
							return;
						}
						// 상주:홍길워:길달:달길:::::::,손녀:홍귀녀:강녀:소녀:::::::
						var html = ["<ul>"];
						var row = data.liveName01.split(",");
						$.each(row, function(i, o){
							var col = o.split(":");
							var length = 0;
							$.each(col, function(i, o){
								length+=o.length;
							});
							if(length == 0){
								return;
							}
							var temp = ['<li>('+col[0]+')  <span class="gap10"></span> '+col[1]];
							// <li>(손주)  <span class="gap10"></span> 준영<span class="gap20"></span> 민영<span class="gap20"></span> 수영<span class="gap20"></span> 창민<span class="gap20"></span> 연수<span class="gap20"></span> 철수<span class="gap20"></span> 민수</li>
							for(var i=2; i<col.length; i++){
								var tem = col[i];
								if(tem != ''){
									temp.push('<span class="gap20"></span> '+col[i]);
								}
							}
							temp.push("</li>");
							html.push(temp.join(""));
						});
						html.push("</ul>")
						$(".deceased_03_family marquee").html(html.join("<br/>"));
					}
				}
			}
			, eventFunc: {
				main: function(){
					board.showDoc("DISP0030");  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
				}
				, bindBoardData: function(doc, data){

					if(!data || !data.thedead){
						return;
					}

					$(".deceased_03_nick", doc).html(data.thedead.deadFaithNm || '');
					$(".deceased_03_name", doc).html(data.thedead.deadName || '');
					$(".deceased_03_casket_date", doc).html($.format.date(data.ibkwanDate+":00.000", "MM월 dd일 HH시 mm분") || '');
					$(".deceased_03_carry_date", doc).html($.format.date(data.balinDate+":00.000", "MM월 dd일 HH시 mm분") || '');
					$(".deceased_03_burial_date", doc).html(data.jangji || '');

					if(data.photo && data.photo.photoImage){
						$("#img-photo", doc).attr("src", data.photo.photoImage);
					}else{
						$("#img-photo", doc).attr("src", "/static/disp/images/photo_sample2_L.png");
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

