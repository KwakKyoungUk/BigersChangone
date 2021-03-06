<%@page import="com.axisj.axboot.core.context.AppContextManager"%>
<%@page import="net.bigers.funeralsystem.stan0000.domain.authIp.AuthIpService"%>
<%@page import="com.axisj.axboot.core.util.SpringUtils"%>
<%@ page import="com.axisj.axboot.core.dto.PageContentTO" %>
<%@ page import="com.axisj.axboot.core.util.RequestHelper" %>
<%@ page import="com.axisj.axboot.core.util.WebUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	RequestHelper requestHelper = RequestHelper.of(request);
	PageContentTO pageContent = requestHelper.getPageContent();
	String menuJson = requestHelper.getMenuJson();

	AuthIpService authIpService = SpringUtils.getBean(AuthIpService.class);

	if (!pageContent.isAuthorized()) {
		response.sendRedirect("/jsp/common/not-authorized.jsp");
	}

	String theme = WebUtils.getTheme(request);

	String appName = AppContextManager.getAppContext().getEnvironment().getProperty("spring.application.name");
	request.setAttribute("APP_NAME", appName);
%>
<!DOCTYPE html>
<html>
<head>
	<!-- META -->
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta name="viewport" content="width=1024, user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<!-- TITLE -->
	<title>${title}</title>

	<link rel="shortcut icon" href="/static/ui/ax-boot/images/axisj-black.ico" type="image/x-icon"/>
	<link rel="icon" href="/static/ui/ax-boot/images/axisj-black.ico" type="image/x-icon"/>

	<link rel="stylesheet" type="text/css" href="<c:url value='/static/plugins/axicon/axicon.min.css' />"/>
	<link rel="stylesheet" type="text/css" href="/static/plugins/axisj/ui/<%=theme%>/AXJ.min.css" id="axu-theme-axisj"/>
<!-- 	<link rel="stylesheet" type="text/css" href="http://cdno.axisj.com/axisj/ui/arongi/AXJ.min.css" /> -->
	<link rel="stylesheet" type="text/css" href="/static/ui/<%=theme%>/admin.css" id="axu-theme-admin"/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/static/ui/custom.css' />"/>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
	<ax:write divname="css"/>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->
	<script type="text/javascript" src="<c:url value='/static/plugins/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/static/plugins/axisj/dist/AXJ.min.js?v=0529' />"></script>

	<script type="text/javascript" src="<c:url value='/static/plugins/chartjs/Chart.min.js' />"></script>

	<!-- @@@@@@@@@@@@@@@@@@@@@@ js begin @@@@@@@@@@@@@@@@@@@@@@ -->
	<ax:write divname="js"/>
	<!-- @@@@@@@@@@@@@@@@@@@@@@ js end   @@@@@@@@@@@@@@@@@@@@@@ -->

	<style type="text/css">
		.ax-body * :not(button, i) {
			color: black !important;
			font-weight: bolder;
		}
	</style>

	<script type="text/javascript" src="<c:url value='/static/js/common/common.js' />?v=1"></script>
	<script type="text/javascript" src="<c:url value='/static/js/data/data.js' />"></script>

	<script type="text/javascript">
		var topMenu_data = <%=menuJson%>;
		var pageInfo = {
			id: '${PAGE_ID}',
			searchAuth: '${SEARCH_AUTH}',
			saveAuth: '${SAVE_AUTH}',
			excelAuth: '${EXCEL_AUTH}',
			function1Auth: '${FUNCTION_1_AUTH}',
			function2Auth: '${FUNCTION_2_AUTH}',
			function3Auth: '${FUNCTION_3_AUTH}',
			function4Auth: '${FUNCTION_4_AUTH}',
			function5Auth: '${FUNCTION_5_AUTH}'
		};
		var agent = navigator.userAgent.toLowerCase();

		window.name = '${PAGE_ID}';

		if (agent.indexOf("chrome") != -1) {
			//alert("?????? ?????????????????????.");
		}else if (agent.indexOf("msie") != -1) {

			if (document.location.protocol == 'http:') {
		        //document.location.href = document.location.href.replace('http:', 'https:');
		        //document.location.href = document.location.href.replace('http:', 'https:').replace(":8090",":444");
		    }
		}


	</script>

	<script type="text/javascript" src="<c:url value='/static/js/common/ax5-polyfill.js' />"></script>
	<script type="text/javascript" src="<c:url value='/static/js/common/base.js' />"></script>
	<script type="text/javascript" src="<c:url value='/static/js/common/app.js' />"></script>

</head>
<body>
<div id="AXPage">
	<ax:write divname="ax-header">
		<div class="ax-header">
			<div class="ax-wrap">
				<div class="ax-layer">
					<div class="ax-col-12">
						<div class="ax-unit">
							<div class="ax-logo">
								<h1>
									<a href="/jsp/main.jsp">&nbsp;</a>
								</h1>
							</div>
						</div>
					</div>
				</div>
				<div class="ax-layer">
					<div class="ax-col-4">
						<div class="ax-unit">
							<!-- ?????? top-down-menu ?????? ?????? : s-->
							<div id="ax-top-menu" class="ax-top-menu AXMenuBox"></div>
							<!-- e : ?????? top-down-menu ?????? ?????? -->
							<div class="mx-top-menu"><a id="mx-top-menu-handle" class="mx-menu-button"><i
									class="axi axi-th"></i></a></div>
						</div>
					</div>
					<div class="ax-col-8">
						<div class="ax-unit">
							<ul class="ax-loginfo" id="ax-loginfo">
								<li class="profile">
									<div class="photo"></div>
								</li>
								<li class="account">
									${APP_NAME }
									<a href="#ax" onclick="fcObj.open_user_info();">${LOGIN_USER_NAME}</a>??? ?????????
								</li>
								<li class="btns">
									<a href="#ax" class="AXButton Red W80" onclick="location.href = '/api/logout';"><i
											class="axi axi-power-off"></i> ????????????</a>
								</li>
								<!--
																<li class="lang">
																	<a href="#ax">
																	<i class="axi axi-ion-android-book"></i> ?????????</a>
																</li>
								-->
							</ul>
							<div class="mx-loginfo"><a id="mx-loginfo-handle" class="mx-menu-button"><i
									class="axi axi-bars"></i></a></div>
						</div>
					</div>
					<div class="ax-clear"></div>
				</div>
			</div>
			<div class="icn-stipe"></div>
		</div>
		<div class="H60" style="height:65px;"></div>
	</ax:write>
	<!-- e ax-header -->

	<div class="ax-body">
		<div class="ax-wrap">

			<div class="ax-layer ax-title">
				<div class="ax-col-12 ax-content expand">
					<!-- @@@@@@@@@@@@@@@@@@@@@@ header begin @@@@@@@@@@@@@@@@@@@@@@ -->
					<ax:write divname="header">
						<h1 id="cx-page-title"><i class="axi axi-web"></i> ${title}</h1>

						<p class="desc">${page_desc}</p>
					</ax:write>
					<!-- @@@@@@@@@@@@@@@@@@@@@@ header end   @@@@@@@@@@@@@@@@@@@@@@ -->
				</div>
				<div class="ax-clear"></div>
			</div>

			<div class="ax-layer cx-content-layer">
				<div class="ax-col-12 ax-content expand">
					<!-- s.CXPage -->
					<div id="CXPage">
						<!-- @@@@@@@@@@@@@@@@@@@@@@ contents begin @@@@@@@@@@@@@@@@@@@@@@ -->
						<ax:write divname="contents"/>
						<!-- @@@@@@@@@@@@@@@@@@@@@@ contents end   @@@@@@@@@@@@@@@@@@@@@@ -->
					</div>
					<!-- e.CXPage -->
				</div>
				<div class="ax-clear"></div>
			</div>

		</div>
	</div>
	<!-- e ax-body -->

	<!-- ?????? ??? ?????? : s-->

	<div class="ax-aside" style="display:none;">
		<div class="ax-layer ax-aside-menu-box">
			<a class="ax-aside-menu">
				<i class="axi axi-fast-forward fa-lg"></i><i class="axi axi-rewind fa-lg"></i>
			</a>
		</div>
		<div class="ax-layer ax-aside-box">
			<div class="ax-unit">
				<div class="ax-box">
					<ul class="ax-aside-ul" id="ax-aside-ul"></ul>
				</div>

				<div class="H10"></div>

			</div>
		</div>
	</div>

	<!-- e : ?????? ??? ??????-->

	<!-- ax-footer : include -->
	<div class="ax-footer">
		<div class="ax-wrap">
			<div class="ax-col-6">
				<div class="ax-unit">
					<ul class="ax-version">
						<li>COPYRIGHT(C) AXISJ/AX-boot</li>
						<li>Optimized for IE9+, Chrome, FireFox, Safari</li>
					</ul>
				</div>
			</div>
			<div class="ax-col-6">
				<div class="ax-unit">

				</div>
			</div>
			<div class="ax-clear"></div>
		</div>
	</div>
	<!-- ax-footer : include -->

</div>
<!-- @@@@@@@@@@@@@@@@@@@@@@ scripts begin @@@@@@@@@@@@@@@@@@@@@@ -->
<ax:write divname="scripts"/>
<!-- @@@@@@@@@@@@@@@@@@@@@@ scripts end   @@@@@@@@@@@@@@@@@@@@@@ -->
</body>
</html>
