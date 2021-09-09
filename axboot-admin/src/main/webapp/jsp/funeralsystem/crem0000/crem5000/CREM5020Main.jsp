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
			fnObj.wc = new WC("ws://localhost:8080/wst/crem5020");
			fnObj.wc.init();
			fnObj.wc.controllers.display = function(data){
				board.showDoc("crem5020", data);  // 페이지 id 와 데이터를 넘겨주고 화면을 그린다.
			};
			board.setTime(8);
			board.addPage('crem5020', 'CREM5020.jsp', 0);
			board.setTarget('#main');
			board.loadDocument();
			board.getDocuments().crem5020.before = fnObj.crem5020WithWebSocket;
// 			board.show();
		}
		, page : 1
		, waitRoom : '${param.waitRoom}'
		, beforeStatus : 0
		, crem5020WithWebSocket : function(doc, data){

			$('#currentTime', doc).html(data.currentTime);
			if(data.msgset){
				$('marquee').html(data.msgset.msgContent);
			}else{
				$('marquee').html('');
			}
			if(!data.waitRoomInfo){
				return;
			}

			var time = fnObj.getConvertedString(data.waitRoomInfo.burnStrTime, 4, 2, ':', false);

			if(!data.waitRoomInfo.burnEndTime || data.waitRoomInfo.burnEndTime == ''){
				time = time + '~' + fnObj.addDate(data.waitRoomInfo.burnStrTime, 'minutes', (+data.waitRoomInfo.cremTime) + (+data.waitRoomInfo.sugolTime));
			}else{
				time = time + '~' + fnObj.getConvertedString(data.waitRoomInfo.burnEndTime, 4, 2, ':', false)
			}

			$('#waitRoom').html(data.waitRoomInfo.waitRoomNm);
			$('#deadName').html(data.waitRoomInfo.deadName + "<sub>님</sub>");
			$('#burnNo').html(data.waitRoomInfo.burnNo);
			$('#runningTime').html(time);
			$('#burn_status').html(data.waitRoomInfo.burnStatusNm);
			$('#burn_status').addClass('status_color_'+data.waitRoomInfo.burnStatus);

			if(fnObj.beforeStatus != 4 && data.waitRoomInfo.burnStatus == 4){
				fnObj.broadcast.showMsg('화장이 종료되었습니다.', 1000*60);
			}

			fnObj.beforeStatus = data.waitRoomInfo.burnStatus;

		}
		, crem5020 : function(doc){

			 $.ajax({
		         url:'${pageContext.request.contextPath}/display/public/BORD1020/findWaitRoom/'+fnObj.waitRoom,
		         dataType:'json',
		         type:'get',
		         async:false,
		         success:function(data){

						$('#currentTime', doc).html(data.map.currentTime);
						if(data.map.msgset){
							$('marquee').html(data.map.msgset.msgContent);
						}else{
							$('marquee').html('');
						}
						if(!data.map.waitRoomInfo){
							return;
						}

						var time = fnObj.getConvertedString(data.map.waitRoomInfo.burnStrTime, 4, 2, ':', false);

						if(!data.map.waitRoomInfo.burnEndTime || data.map.waitRoomInfo.burnEndTime == ''){
							time = time + '~' + fnObj.addDate(data.map.waitRoomInfo.burnStrTime, 'minutes', (+data.map.waitRoomInfo.cremTime) + (+data.map.waitRoomInfo.sugolTime));
						}else{
							time = time + '~' + fnObj.getConvertedString(data.map.waitRoomInfo.burnEndTime, 4, 2, ':', false)
						}

						$('#waitRoom').html(data.map.waitRoomInfo.waitRoomNm);
						$('#deadName').html(data.map.waitRoomInfo.deadName + "<sub>님</sub>");
						$('#burnNo').html(data.map.waitRoomInfo.burnNo);
						$('#runningTime').html(time);
						$('#burn_status').html(data.map.waitRoomInfo.burnStatusNm);
						$('#burn_status').addClass('status_color_'+data.map.waitRoomInfo.burnStatus);

						if(fnObj.beforeStatus != 4 && data.map.waitRoomInfo.burnStatus == 4){
							fnObj.broadcast.showMsg('화장이 종료되었습니다.', 1000*60);
						}

						fnObj.beforeStatus = data.map.waitRoomInfo.burnStatus;
		         }
		     });

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

			return d.getHours() + ":" + d.getMinutes();
		}

		, broadcast : {
			showMsg : function(msg, time){
				$('#toast #msg').innerHTML = msg;
				$('#toast').css("opacity", 1);
				setTimeout(function(){
					$('#toast').css("opacity", 0);
				}, time);

				var url = '/tts.do?szText=' + msg;

				var aud = new Audio(url);
				aud.play();
			}
		}
}

$(document).ready(fnObj.pageStart);



</script>
<title>유족대기실</title>
</head>
<body>

<div id="main" style="height: 88%;">
</div>
<div id="foot" style="height: 12%;">
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="middle"><marquee></marquee></td>
		</tr>
	</table>
</div>
<table id="toast" style="width: 100%; height: 100%; position: fixed; top: 0; left: 0; opacity: 0;" >
	<tr><td align="center">
	<table style="width: 60%; height: 40%; background-color: black; color: white; font-size: 70px; font-weight: bolder;"><tr><td align="center" id="msg">
	</td></tr></table></td></tr>
</table>

</body>
</html>