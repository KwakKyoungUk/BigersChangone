<%@page import="java.net.InetAddress"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
InetAddress inet = InetAddress.getLocalHost();
String host = inet.getHostAddress();

request.setAttribute("HOST", host);
%>
<%-- <jsp:forward page="/jsp/login.jsp" /> --%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>통합장사시스템</title>
    <link rel="stylesheet" href="/static/css/common/style_ch.css">
</head>
<body>
 <div class="container_1920 main_bg">
     <div class="header">
         창원시설관리공단 장사관리 시스템
     </div>

     <div class="body">
         <div class="btn_01">
             <a class="btn" href="http://${HOST }:8080/jsp/main.jsp">
                 <div class="bt_img">
                     <img src="/static/images/bt_img_01.png">
                 </div>
                 <div class="bt_text">
                     상복공원
                 </div>
             </a>
         </div>
         <div class="btn_02">
             <a class="btn" href="http://${HOST }:7080/jsp/main.jsp">
                 <div class="bt_img">
                     <img src="/static/images/bt_img_02.png">
                 </div>
                 <div class="bt_text">
                     마산 장사시설
                 </div>
             </a>
         </div>
		 <div class="btn_03">
             <a class="btn" href="http://${HOST }:6080/jsp/main.jsp">
                 <div class="bt_img">
                     <img src="/static/images/bt_img_03.png">
                 </div>
                 <div class="bt_text">
                     진해 장사시설
                 </div>
             </a>
         </div>

     </div>

     <div class="foot">
         COPYRIGHT(C) AXISJ/AX-boot   Optimized for IE9+, Chrome, FireFox, Safari
     </div>



 </div>
</body>
</html>