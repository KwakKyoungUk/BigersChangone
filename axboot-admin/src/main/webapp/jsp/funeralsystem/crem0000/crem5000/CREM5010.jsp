<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <TABLE border=0 cellpadding=0 cellspacing=0 style="width: 100%; height: 113.636%;">
	  <tr>
		  <td COLSPAN=6 style="height: 12.963%;">
<!-- 		  <td COLSPAN=6 style="height: 14.731%;"> -->
		  		<table border="0" cellpadding=0 cellspacing=0 style="width: 100%; height: 100%;">
		  			<tr>
			  			<td background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_01.gif" WIDTH=26.198% height="100%" style="background-size: 100% 100%;">
			  			</td>
			  			<td background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_02.gif" WIDTH=33.125% height="100%" style="background-size: 100% 100%;">
			  			</td>
			  			<td background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_03.gif" WIDTH=40.677% height="100%" style="background-size: 100% 100%;" align="center">
			  				<label id="currentTime" size="0.7" style="font-weight: bolder;" class="currentTime"></label>
			  			</td>
		  			</tr>
		  		</table>
		  </td>
	  </tr>
	  <TR>
<!-- 		  <TD COLSPAN=6 height="13.994%"> -->
			<td COLSPAN=6 height="12.315%">
				<table border="0"  cellpadding=0 cellspacing=0 style="width: 100%; height: 100%">
					<tr>
					  <TD background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_04.gif" WIDTH="8.74%" style="background-size: 100% 100%;"></TD>
					  <td background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_05.gif" WIDTH="17.448%"  style="background-size: 100% 100%;"></td>
					  <td background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_06.gif" WIDTH="16.562%"  style="background-size: 100% 100%;"></td>
					  <td background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_07.gif" WIDTH="16.562%"  style="background-size: 100% 100%;"></td>
					  <td background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_08.gif" WIDTH="24.115%"  style="background-size: 100% 100%;"></td>
					  <td background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_09.gif" WIDTH="16.562%"  style="background-size: 100% 100%;"></td>
				  	</tr>
		  		</table>
		  </td>
	  </TR>
	  <TR>
		  <TD height="62.87%" COLSPAN=6>
<!-- 		  <TD height="71.444%" COLSPAN=6> -->
		  <table id="dataTable" border="0"  background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_10.gif" style="background-size: 100% 100%; width: 100%; height: 100%;">
		  	<c:forEach begin="1" end="5">
	            <tr height="20%">
	              <td width="8.74%" align="center"><label class="chasu"></label></td>
	              <td width="17.448%" align="center"><label class="dead_name"></label></td>
	              <td width="16.562%" align="center"><label class="burn_no"></label></td>
	              <td width="16.562%" align="center"><label class="wait_room"></label></td>
	              <td width="24.115%" align="center"><label class="running_time"></label></td>
	              <td width="16.562%" align="center"><label></label></td>
	            </tr>
		  	</c:forEach>
          </table></TD>
    </TR>
	  <TR>
		  <TD COLSPAN=6 height="11.852%" background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_11.gif"  style="background-size:100% 100%;"></TD>
<%-- 		  <TD COLSPAN=6 height="13.468%" background="${pageContext.request.contextPath}/static/display/images/bord/gangneung_01_11.gif"  style="background-size:100% 100%;"></TD> --%>
	  </TR>
  </TABLE>
  <!-- End ImageReady Slices -->
