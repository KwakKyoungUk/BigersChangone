<%@page import="com.axisj.axboot.core.domain.code.BasicCode"%>
<%@page import="net.bigers.funeralsystem.fune0000.domain.payment.Payment"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.axisj.axboot.core.util.WebUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String theme = WebUtils.getTheme(request);

DecimalFormat df = new DecimalFormat("###,###,###");
SimpleDateFormat yyyyMMddHHmm = new SimpleDateFormat("yyyy-MM-dd HH:mm");
SimpleDateFormat yyyyMMdd = new SimpleDateFormat("yyyy-MM-dd");

BasicCode kind = (BasicCode) request.getAttribute("kind");

String method = kind.getCode().charAt(0) + "";

request.setAttribute("method", method);
request.setAttribute("df", df);
request.setAttribute("df", df);
request.setAttribute("yyyyMMddHHmm", yyyyMMddHHmm);
request.setAttribute("yyyyMMdd", yyyyMMdd);
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
		<tr><td align="center"><b>창원시립상복공원 영수증</b></td></tr>
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
		<tr><td>사원 : ${user.userNm }
		</td></tr>
		<tr><td align="center">==================================</td></tr>
		<tr><td align="center"><b>결&nbsp;&nbsp;제&nbsp;&nbsp;정&nbsp;&nbsp;보</b></td></tr>
		<tr><td align="center">==================================</td></tr>
		<tr><td>
			<table>
				<tr>
					<td>판매번호 : </td>
					<td align="right">${payment.deadId }-${payment.tid }-${payment.seq }</td>
				</tr>
			</table>
		</td></tr>

		<c:if test='${method.equals("D")}'>
			<tr><td>결제방법 : ${kind.name } </td></tr>
			<tr><td>카드번호 : ${payment.cardNo } </td></tr>
			<tr><td>카 드 명 : ${payment.cardName } </td></tr>
			<tr><td>할부개월 : ${payment.paymentCard.halbu} </td></tr>
			<tr><td>승인번호 : ${payment.appNo } </td></tr>
			<tr><td>승인일자 : ${yyyyMMdd.format(payment.etDate) } </td></tr>
			<tr><td>거래번호 : ${payment.shopTs} </td></tr>
			<tr><td class="receipt-amt">결제금액 : ${df.format(payment.cardAmt+payment.cashAmt) } 원 </td></tr>
		</c:if>
		<c:if test='${method.equals("B")}'>
			<tr><td>결제방법 : ${kind.name } </td></tr>
			<tr><td>발급용도 : ${payment.cashKind == "1" ? "소득공제":"지출증빙" } </td></tr>
			<tr><td>고유번호 : ${payment.cardNo } </td></tr>
			<tr><td>승인번호 : ${payment.appNo } </td></tr>
			<tr><td>승인일자 : ${yyyyMMdd.format(payment.etDate) } </td></tr>
			<tr><td>거래번호 : ${payment.shopTs} </td></tr>
			<tr><td class="receipt-amt">결제금액 : ${df.format(payment.cardAmt+payment.cashAmt) } 원 </td></tr>
		</c:if>

		<tr><td class="receipt-amt">서명 :</td></tr>

		<tr><td align="center">==================================</td></tr>
		<tr><td align="center" class="line-height">항상 친절하게 모시겠습니다.</td></tr>
		<tr><td align="center" class="line-height">항상 창원시립상복공원을 이용해주셔서<br>감사합니다.</td></tr>

	</table>
</div>
<div class="section">
	<table>
		<tr><td align="center">=====================</td></tr>
		<tr><td align="center"><b>창원시립상복공원 영수증</b></td></tr>
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
		<tr><td>사원 : ${user.userNm }
		</td></tr>
		<tr><td align="center">==================================</td></tr>
		<tr><td align="center"><b>결&nbsp;&nbsp;제&nbsp;&nbsp;정&nbsp;&nbsp;보</b></td></tr>
		<tr><td align="center">==================================</td></tr>
		<tr><td>
			<table>
				<tr>
					<td>판매번호 : </td>
					<td align="right">${payment.deadId }-${payment.tid }-${payment.seq }</td>
				</tr>
			</table>
		</td></tr>

		<c:if test='${method.equals("D")}'>
			<tr><td>결제방법 : ${kind.name } </td></tr>
			<tr><td>카드번호 : ${payment.cardNo } </td></tr>
			<tr><td>카 드 명 : ${payment.cardName } </td></tr>
			<tr><td>할부개월 : ${payment.paymentCard.halbu} </td></tr>
			<tr><td>승인번호 : ${payment.appNo } </td></tr>
			<tr><td>승인일자 : ${yyyyMMdd.format(payment.etDate) } </td></tr>
			<tr><td>거래번호 : ${payment.shopTs} </td></tr>
			<tr><td class="receipt-amt">결제금액 : ${df.format(payment.cardAmt+payment.cashAmt) } 원 </td></tr>
		</c:if>
		<c:if test='${method.equals("B")}'>
			<tr><td>결제방법 : ${kind.name } </td></tr>
			<tr><td>발급용도 : ${payment.cashKind == "1" ? "소득공제":"지출증빙" } </td></tr>
			<tr><td>고유번호 : ${payment.cardNo } </td></tr>
			<tr><td>승인번호 : ${payment.appNo } </td></tr>
			<tr><td>승인일자 : ${yyyyMMdd.format(payment.etDate) } </td></tr>
			<tr><td>거래번호 : ${payment.shopTs} </td></tr>
			<tr><td class="receipt-amt">결제금액 : ${df.format(payment.cardAmt+payment.cashAmt) } 원 </td></tr>
		</c:if>

		<tr><td class="receipt-amt">서명 :</td></tr>

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