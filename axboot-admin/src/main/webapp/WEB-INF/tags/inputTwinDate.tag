<%@tag import="java.util.Objects"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="fromId" required="true" type="java.lang.String" %>
<%@ attribute name="toId" required="true" type="java.lang.String" %>
<%@ attribute name="fromName" required="false" type="java.lang.String" %>
<%@ attribute name="toName" required="false" type="java.lang.String" %>
<%@ attribute name="fromTitle" required="false" type="java.lang.String" %>
<%@ attribute name="toTitle" required="false" type="java.lang.String" %>
<%@ attribute name="fromRequired" required="false" type="java.lang.Boolean" %>
<%@ attribute name="toRequired" required="false" type="java.lang.Boolean" %>
<%@ attribute name="fromValue" required="false" type="java.lang.String" %>
<%@ attribute name="toValue" required="false" type="java.lang.String" %>
<%@ attribute name="clazz" required="false" type="java.lang.String" %>
<input type="text" id="${fromId }" name="${fromName }" title="${fromTitle }" class="AXInput ${not empty fromRequired && fromRequired ? 'av-required' : ''} ${clazz}" value="${fromValue }"/>
<input type="text" id="${toId }" name="${toName }" title="${toTitle }" class="AXInput ${not empty toRequired && toRequired ? 'av-required' : ''} ${clazz}" value="${toValue }"/>
<script type="text/javascript">
	$("#${toId}").bindTwinDate({
	    startTargetID: "${fromId}",
	    handleLeft: 25,
	    align: "right",
	    valign: "bottom",
	    separator: "-",
	    buttonText: "선택",
	    onChange: function () {
	        //toast.push(Object.toJSON(this));
	    },
	    onBeforeShowDay: function (date) {
// 	        if (date.getDay() == 3) {
// 	            return {isEnable: false, title: "수요일 선택불가", className: "", style: ""};
// 	        }
	    }
	});
</script>