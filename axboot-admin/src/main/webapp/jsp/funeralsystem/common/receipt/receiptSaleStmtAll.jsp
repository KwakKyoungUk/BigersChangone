<%@page import="org.springframework.util.StringUtils"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@page import="net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmt"%>
<%@page import="com.axisj.axboot.core.util.WebUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String theme = WebUtils.getTheme(request);

DecimalFormat df = new DecimalFormat("###,###,###");

request.setAttribute("df", df);

String partName = request.getParameter("partName");

if(!StringUtils.isEmpty(partName)){
	request.setAttribute("partName", "("+partName+")");
}

%>
<html>
<head>
	<title>영수증</title>

	<link rel="shortcut icon" href="/static/ui/ax-boot/images/axisj-black.ico" type="image/x-icon"/>
	<link rel="icon" href="/static/ui/ax-boot/images/axisj-black.ico" type="image/x-icon"/>

	<link rel="stylesheet" type="text/css" href="<c:url value='/static/plugins/axicon/axicon.min.css' />"/>
	<link rel="stylesheet" type="text/css" href="/static/plugins/axisj/ui/<%=theme%>/AXJ.min.css" id="axu-theme-axisj"/>
<!-- 	<link rel="stylesheet" type="text/css" href="http://cdno.axisj.com/axisj/ui/arongi/AXJ.min.css" /> -->
	<link rel="stylesheet" type="text/css" href="/static/ui/<%=theme%>/admin.css" id="axu-theme-admin"/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/static/ui/custom.css' />"/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/static/dispnew/css/font.css' />"/>

	<style>
		@media print {
			.non-print {
				display: none;
			}
		}
		.section{
			width: 8cm;
			padding-bottom: 1cm;
			page-break-before: always;
		}
		.button-group {
			width: 8cm;
		}
		.button-group button{
			float: right;
		}
		table{
			width: 100%;
			font-size: 13px;
		}
		.receipt-amt {
			transform: scale(1, 1.5);
			font-weight: bolder;
		}
		.line-height {
			line-height: 30px;
		}
		* {
			font-family: NS_eb;
		}
	</style>
	<script src="/static/plugins/jquery/jquery.min.js"></script>
</head>
<body>
<div class="button-group non-print">
	<button id="btn-print" class="AXButton">인쇄</button>
</div>
<div class="section">
	<table>
		<tr><td align="center">=====================</td></tr>
		<tr><td align="center"><b>창원시립상복공원 ${partName }</b></td></tr>
		<tr><td align="center">=====================</td></tr>
		<tr><td>창원시립상복공원(609-82-07688)
		</td></tr>
		<tr><td>창원시 성산구 공단로474번길 160(상복동)
		</td></tr>
		<tr><td>
			<table>
				<tr>
					<td>&nbsp;&nbsp; 허환구
					</td>
					<td align="right">전화 : 055-712-0911
					</td>
				</tr>
			</table>
		</td></tr>
		<tr><td>
			<table>
				<tr>
					<td>발인일자 : ${funeral.balinDate }
					</td>
				</tr>
			</table>
		</td></tr>
			<td>사원 : ${user.userNm }
			</td>
		<tr><td>
		</td></tr>
		<tr><td align="center">==================================</td></tr>
		<tr><td>
			<table>
				<tr>
					<th>No</th>
					<th>구입상품</th>
					<th>수량</th>
					<th>단가</th>
					<th>금액</th>
				</tr>
				<c:forEach items="${saleStmtBd}" var="bd" varStatus="status">
					<tr>
						<td align="center">${bd.seqNo }</td>
						<td>${bd.item.taxFreeSale==1 ? '*':'' }${bd.item.itemName }</td>
						<td align="center">${bd.qty.intValue() }</td>
						<td align="right">${df.format(bd.price) }</td>
						<td align="right">${df.format(bd.amount) }</td>
					</tr>
				</c:forEach>
			</table>
		</td></tr>
		<tr><td align="center">------------------------------------------------------------</td></tr>
<!-- 		<tr><td>상품명 앞에 * 표시는 면세품 표시입니다.</td></tr> -->
		<tr><td>
			<table>
				<tr>
					<td class="receipt-amt">금액
					</td>
					<td align="right" class="receipt-amt">${df.format(amt) } 원
					</td>
				</tr>
			</table>
		</td></tr>
		<tr><td align="center">==================================</td></tr>
		<tr><td align="center"><b>빈&nbsp;&nbsp;소&nbsp;&nbsp;정&nbsp;&nbsp;보</b></td></tr>
		<tr><td align="center">==================================</td></tr>

		<tr><td>
			<table>
				<tr>
					<td>빈소
					</td>
					<td align="right">${funeral.binso.binsoName }
					</td>
				</tr>
				<tr>
					<td>접수일자
					</td>
					<td align="right">${funeral.regtime }
					</td>
				</tr>
				<tr>
					<td>고인명
					</td>
					<td align="right">${funeral.thedead.deadName }
					</td>
				</tr>
			</table>
		</td></tr>

		<tr><td align="center">==================================</td></tr>
		<tr><td align="center" class="line-height">항상 친절하게 모시겠습니다.</td></tr>
		<tr><td align="center" class="line-height">항상 창원시립상복공원을 이용해주셔서 감사합니다.</td></tr>

	</table>
</div>

<script>

	$(document).ready(function(){

		$("#btn-print").bind("click", function(){
			window.print()
		})

		if('${param.auto}' == 'Y'){
			window.onafterprint = function(){ window.close()};
			window.print()
		}
	})
</script>

</body>
</html>