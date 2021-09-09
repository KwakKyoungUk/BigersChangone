<%@page import="java.text.DecimalFormat"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@page import="net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmt"%>
<%@page import="com.axisj.axboot.core.util.WebUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String theme = WebUtils.getTheme(request);

SaleStmt saleStmt = (SaleStmt) request.getAttribute("stmt");

String etDate = DateUtils.formatToDateString(saleStmt.getEtDate(), "yyyy-MM-dd");
String etTime = DateUtils.formatToDateString(saleStmt.getRegtime(), "HH:mm:ss");

DecimalFormat df = new DecimalFormat("###,###,###");

request.setAttribute("df", df);
request.setAttribute("etDate", etDate);
request.setAttribute("etTime", etTime);

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
		<tr><td>
			<table>
				<tr>
					<td>일자 : ${etDate }
					</td>
					<td>시간 : ${etTime }
					</td>
				</tr>
			</table>
		</td></tr>
			<td>사원 : ${user.userNm }
			</td>
		<tr><td>
		</td></tr>
		<tr><td align="center">===========================</td></tr>
		<tr><td>
			<table>
				<tr>
					<th>No</th>
					<th>구입상품</th>
					<th>수량</th>
					<th>단가</th>
					<th>금액</th>
				</tr>
				<c:forEach items="${stmt.saleStmtBd}" var="bd" varStatus="status">
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
		<tr><td align="center">--------------------------------------------------</td></tr>
		<tr><td>상품명 앞에 * 표시는 면세품 표시입니다.</td></tr>
		<tr><td>
			<table>
				<tr>
					<td>면세물품
					</td>
					<td align="right">${df.format(taxFreeAmt) } 원
					</td>
				</tr>
				<tr>
					<td>과세물품
					</td>
					<td align="right">${df.format(taxAmt) } 원
					</td>
				</tr>
				<tr>
					<td>부과세
					</td>
					<td align="right">${df.format(stmt.vatAmt) } 원
					</td>
				</tr>
			</table>
		</td></tr>
		<tr><td align="center">===========================</td></tr>
		<tr><td align="center"><b>결&nbsp;&nbsp;제&nbsp;&nbsp;정&nbsp;&nbsp;보</b></td></tr>
		<tr><td align="center">===========================</td></tr>

	<c:if test="${stmt.jungsanKind.startsWith('D') }">
		<tr><td>결제방법 : 카드결제취소</td></tr>
		<tr><td>카드번호 : ${stmt.cardNo }</td></tr>
		<tr><td>카 드 명 : ${stmt.cardName }</td></tr>
		<tr><td>할부개월 : ${stmt.saleStmtBdCard.halbu }</td></tr>
		<tr><td>승인번호 : ${stmt.appNo }</td></tr>
		<tr><td>취소일자 : ${stmt.saleStmtBdCard.appDate }</td></tr>
		<tr><td class="receipt-amt">결제금액 : ${df.format(stmt.amount) } 원</td></tr>
	</c:if>
	<c:if test="${stmt.jungsanKind.startsWith('B') }">
		<tr><td>결제방법 : 현금결제취소</td></tr>
		<tr><td>카드번호 : ${stmt.cardNo }</td></tr>
		<tr><td>카 드 명 : ${stmt.cardName }</td></tr>
		<tr><td>승인번호 : ${stmt.appNo }</td></tr>
		<tr><td>취소일자 : ${stmt.etDate }</td></tr>
		<tr><td class="receipt-amt">결제금액 : ${df.format(stmt.amount) } 원</td></tr>
	</c:if>

		<tr><td align="center">===========================</td></tr>
		<tr><td align="right" class="line-height">서명 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
		<tr><td align="center" class="line-height">반품 및 교환시 본 영수증이 있어야됩니다.</td></tr>
		<tr><td align="center" class="line-height">항상 친절하게 모시겠습니다.</td></tr>
		<tr><td align="center" class="line-height">항상 창원시립상복공원을 이용해주셔서 감사합니다.</td></tr>

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
		<tr><td>
			<table>
				<tr>
					<td>일자 : ${etDate }
					</td>
					<td>시간 : ${etTime }
					</td>
				</tr>
			</table>
		</td></tr>
			<td>사원 : ${user.userNm }
			</td>
		<tr><td>
		</td></tr>
		<tr><td align="center">===========================</td></tr>
		<tr><td>
			<table>
				<tr>
					<th>No</th>
					<th>구입상품</th>
					<th>수량</th>
					<th>단가</th>
					<th>금액</th>
				</tr>
				<c:forEach items="${stmt.saleStmtBd}" var="bd" varStatus="status">
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
		<tr><td align="center">--------------------------------------------------</td></tr>
		<tr><td>상품명 앞에 * 표시는 면세품 표시입니다.</td></tr>
		<tr><td>
			<table>
				<tr>
					<td>면세물품
					</td>
					<td align="right">${df.format(taxFreeAmt) } 원
					</td>
				</tr>
				<tr>
					<td>과세물품
					</td>
					<td align="right">${df.format(taxAmt) } 원
					</td>
				</tr>
				<tr>
					<td>부과세
					</td>
					<td align="right">${df.format(stmt.vatAmt) } 원
					</td>
				</tr>
			</table>
		</td></tr>
		<tr><td align="center">===========================</td></tr>
		<tr><td align="center"><b>결&nbsp;&nbsp;제&nbsp;&nbsp;정&nbsp;&nbsp;보</b></td></tr>
		<tr><td align="center">===========================</td></tr>

	<c:if test="${stmt.jungsanKind.startsWith('D') }">
		<tr><td>결제방법 : 카드결제취소</td></tr>
		<tr><td>카드번호 : ${stmt.cardNo }</td></tr>
		<tr><td>카 드 명 : ${stmt.cardName }</td></tr>
		<tr><td>할부개월 : ${stmt.saleStmtBdCard.halbu }</td></tr>
		<tr><td>승인번호 : ${stmt.appNo }</td></tr>
		<tr><td>취소일자 : ${stmt.saleStmtBdCard.appDate }</td></tr>
		<tr><td class="receipt-amt">결제금액 : ${df.format(stmt.amount) } 원</td></tr>
	</c:if>
	<c:if test="${stmt.jungsanKind.startsWith('B') }">
		<tr><td>결제방법 : 현금결제취소</td></tr>
		<tr><td>카드번호 : ${stmt.cardNo }</td></tr>
		<tr><td>카 드 명 : ${stmt.cardName }</td></tr>
		<tr><td>승인번호 : ${stmt.appNo }</td></tr>
		<tr><td>취소일자 : ${stmt.etDate }</td></tr>
		<tr><td class="receipt-amt">결제금액 : ${df.format(stmt.amount) } 원</td></tr>
	</c:if>

		<tr><td align="center">===========================</td></tr>
		<tr><td align="right" class="line-height">서명 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
		<tr><td align="center" class="line-height">반품 및 교환시 본 영수증이 있어야됩니다.</td></tr>
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