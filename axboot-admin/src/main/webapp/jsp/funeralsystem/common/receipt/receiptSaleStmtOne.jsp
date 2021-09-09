<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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

SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시mm분");

request.setAttribute("today", sdf.format(new Date()));

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
			line-height: 30px;
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
		<tr><td>
			<table>
				<tr>
					<td class="receipt-amt">${funeral.binso.binsoName }
					</td>
					<td align="right">${part.partName }
					</td>
				</tr>
			</table>
		</td></tr>
		<tr><td>고 인 명 : ${funeral.thedead.deadName }</td></tr>
		<tr><td>상 주 명 : ${funeral.applicant.applName }</td></tr>
		<tr><td>거래일자 : ${stmt.etDate }</td></tr>
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
		<tr><td>상품명 앞에 * 표시는 면세품 표시입니다.</td></tr>
		<tr><td>
			<table>
				<tr>
					<td class="receipt-amt">금액
					</td>
					<td align="right" class="receipt-amt">${df.format(amt) } 원
					</td>
				</tr>
				<tr><td class="receipt-amt">배 달 자 :</td></tr>
				<tr><td align="center" colspan="2">${today }</td></tr>
			</table>
		</td></tr>

		<tr><td align="center">==================================</td></tr>
		<tr><td align="center" class="line-height">항상 친절하게 모시겠습니다.</td></tr>
		<tr><td align="center" class="line-height">항상 창원시립상복공원을 이용해주셔서<br>감사합니다.</td></tr>

	</table>
</div>
<div class="section">
	<table>
		<tr><td>
			<table>
				<tr>
					<td class="receipt-amt">${funeral.binso.binsoName }
					</td>
					<td align="right">${part.partName }
					</td>
				</tr>
			</table>
		</td></tr>
		<tr><td>고 인 명 : ${funeral.thedead.deadName }</td></tr>
		<tr><td>상 주 명 : ${funeral.applicant.applName }</td></tr>
		<tr><td>거래일자 : ${stmt.etDate }</td></tr>
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
		<tr><td>상품명 앞에 * 표시는 면세품 표시입니다.</td></tr>
		<tr><td>
			<table>
				<tr>
					<td class="receipt-amt">금액
					</td>
					<td align="right" class="receipt-amt">${df.format(amt) } 원
					</td>
				</tr>
				<tr><td class="receipt-amt">상주확인 :</td></tr>
				<tr><td class="receipt-amt">배 달 자 :</td></tr>
				<tr><td align="center" colspan="2">${today }</td></tr>
			</table>
		</td></tr>

		<tr><td align="center">==================================</td></tr>
		<tr><td align="center" class="line-height">항상 친절하게 모시겠습니다.</td></tr>
		<tr><td align="center" class="line-height">항상 창원시립상복공원을 이용해주셔서<br>감사합니다.</td></tr>

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