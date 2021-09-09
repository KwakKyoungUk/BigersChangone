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
			fnObj.wc = new WC("ws://localhost:8080/wst/crem5010");
			fnObj.wc.init();
			fnObj.wc.controllers.display = function(data){
				board.showDoc("crem5010", data);  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
			};
			board.setTime(8);		// 반복 시간
			board.addPage('crem5010', 'CREM5010.jsp', 0);	// 페이지추가
			board.setTarget('#main');	// 표출 요소
			board.loadDocument();	// 추가한 페이지 로드
			board.getDocuments().crem5010.before = fnObj.crem5010WithWebSocket;	// 추가된 페이지가 그려지기전 호출할 함수
// 			board.show();	// 페이지 출력  --> ajax polling
		}
		, crem5010WithWebSocket : function(doc, data){

			/*
			응답 데이타
			currentDate: 현재 시간
			mapResponse.map.hwaBrazierVTO: 화장 정보 목록
			msgset: 하단 메세지 출력 내용
			*/
			doc.querySelector('#currentTime').innerHTML = data.currentDate;

			var trs = doc.querySelector('#dataTable').querySelectorAll('tr');

			var labels;

			for(var i=0; data.hwaBrazierVTO && i<data.hwaBrazierVTO.length; i++){
				labels = trs[i].querySelectorAll('label');
				labels[0].innerHTML = data.burnChasu;
				labels[1].innerHTML = data.deadName + "<sub>님</sub>";
				labels[2].innerHTML = data.burnNo;
				labels[3].innerHTML = data.waitRoomName;

				var strTime = '';
				var endTime = '';

				if(!(data.burn_str_time == null)){
					strTime = fnObj.getConvertedString(data.burnStrTime, 4, 2, ':', false)
				}
				if(data.burn_end_time == null){
					endTime = strTime == '' ? '' : fnObj.addDate(data.burnStrTime,'minutes', (+data.cremTime)+(+data.sugolTime));
				}else{
					endTime = fnObj.getConvertedString(data.burnEndTime, 4, 2, ':', false);
				}
				if(strTime!=''){
					labels[4].innerHTML = strTime	+ '~' + endTime;
				}

				labels[5].innerHTML = data.burnStatusName;
				labels[5].className = 'status_color_' + data.burnStatus;
			}

			/*
				메세지가 존재 할 경우 하단에 출력
			*/
			if(data.msgsetVTO){
				$('marquee').html(data.msgsetVTO.msgContent);
			}

// 			$('#main').html($(doc).html());
		}

		/*
		 * @str : 원본 문자열
		 * @tLength : 최종 문자열 크기
		 * @cutLength : 잘라낼 길이
		 * @addString : 잘라낸 부분에 추가할 문자열
		 * @last : 마지막에 추가할 문자열 붙임 여부
		 */
		, getConvertedString : function(str, tLength, cutLength, addString, last){
			var res = '';
			for(var i=1; i<=tLength; i++){
				res+=str[i-1];
				if(i%cutLength == 0 && i != tLength){
					res+=addString;
				}
				if(last && i == tLength){
					res+=addString;
				}
			}
			return res;
		}

		/**
		 *strDate 는 시분초 6자리로 들어온다고 가정
		 * return 은 hh:mm 로 리턴
		 */
		, addDate : function(strDate, type, value){
			var d = new Date();
			d.setHours(+strDate.substring(0,2));
			d.setMinutes(+strDate.substring(2,4));

			if(type == 'hours'){
				d.setHours(d.getHours() + value);
			}else if(type == 'minutes'){
				d.setMinutes(d.getMinutes() + value);
			}

			return d.getHours() + ":" + (d.getMinutes() < 10 ? '0'+d.getMinutes() : d.getMinutes());
		}
};

$(document).ready(fnObj.pageStart);

</script>
<title>현황판</title>
</head>
<body>
<!-- <div id="loadingDiv">aaa</div> -->
<div id="main" style="height: 88%;">
</div>
<div id="foot" style="height: 12%;">
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="middle">
				<marquee></marquee>
			</td>
		</tr>
	</table>
</div>


</body>
</html>