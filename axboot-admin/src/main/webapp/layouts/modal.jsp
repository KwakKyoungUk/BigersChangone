<%@ page import="com.axisj.axboot.core.util.RequestHelper" %>
<%@ page import="com.axisj.axboot.core.util.WebUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
    RequestHelper requestHelper = RequestHelper.of(request);
    String theme = WebUtils.getTheme(request);
%>
<!DOCTYPE html>
<html>
<head>
    <!-- META -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <!-- TITLE -->
    <title>AX-Boot :: ${title}</title>

    <link rel="shortcut icon" href="/static/ui/ax-boot/images/axisj-black.ico" type="image/x-icon" />
    <link rel="icon" href="/static/ui/ax-boot/images/axisj-black.ico" type="image/x-icon" />

    <link rel="stylesheet" type="text/css" href="<c:url value='/static/plugins/axicon/axicon.min.css' />" />
    <link rel="stylesheet" type="text/css" href="/static/plugins/axisj/ui/<%=theme%>/AXJ.min.css" id="axu-theme-axisj"/>
    <link rel="stylesheet" type="text/css" href="/static/ui/<%=theme%>/admin.css" id="axu-theme-admin"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/static/ui/custom.css' />" />
    <!-- @@@@@@@@@@@@@@@@@@@@@@ css begin @@@@@@@@@@@@@@@@@@@@@@ -->
    <ax:write divname="css" />
    <!-- @@@@@@@@@@@@@@@@@@@@@@ css end   @@@@@@@@@@@@@@@@@@@@@@ -->

    <script type="text/javascript" src="<c:url value='/static/plugins/jquery/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/plugins/axisj/dist/AXJ.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/plugins/chartjs/Chart.min.js' />"></script>

    <script type="text/javascript" src="<c:url value='/static/js/common/ax5-polyfill.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/common/modal.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/common/app.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/common/common.js' />"></script>

<!-- @@@@@@@@@@@@@@@@@@@@@@ js begin @@@@@@@@@@@@@@@@@@@@@@ -->
    <ax:write divname="js" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ js end   @@@@@@@@@@@@@@@@@@@@@@ -->

</head>
<body>
<div id="AXPage" class="bodyHeightDiv page-modal">
    <div class="ax-modal-header">
        <div class="ax-col-12">
            <div class="ax-unit">
<!-- @@@@@@@@@@@@@@@@@@@@@@ header begin @@@@@@@@@@@@@@@@@@@@@@ -->
                <ax:write divname="header">
                    <h1>${title}</h1>
                </ax:write>
<!-- @@@@@@@@@@@@@@@@@@@@@@ header end   @@@@@@@@@@@@@@@@@@@@@@ -->
            </div>
        </div>
        <div class="ax-clear"></div>
    </div>
    <div class="ax-modal-body">
        <div class="ax-wrap">
            <div class="ax-layer">
                <div class="ax-col-12">
<!-- @@@@@@@@@@@@@@@@@@@@@@ contents begin @@@@@@@@@@@@@@@@@@@@@@ -->
                    <ax:write divname="contents" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ contents end   @@@@@@@@@@@@@@@@@@@@@@ -->
                </div>
                <div class="ax-clear"></div>
            </div>
        </div>
    </div>
    <div class="ax-modal-footer">
        <div class="ax-wrap">
            <div class="ax-col-12">
                <div class="ax-unit center">
<!-- @@@@@@@@@@@@@@@@@@@@@@ contents begin @@@@@@@@@@@@@@@@@@@@@@ -->
                    <ax:write divname="buttons" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ contents end   @@@@@@@@@@@@@@@@@@@@@@ -->
                </div>
            </div>
            <div class="ax-clear"></div>
        </div>
    </div>
    <div class="icn-stipe"></div>
</div>
<!-- @@@@@@@@@@@@@@@@@@@@@@ scripts begin @@@@@@@@@@@@@@@@@@@@@@ -->
<ax:write divname="scripts" />
<!-- @@@@@@@@@@@@@@@@@@@@@@ scripts end   @@@@@@@@@@@@@@@@@@@@@@ -->
</body>
</html>
