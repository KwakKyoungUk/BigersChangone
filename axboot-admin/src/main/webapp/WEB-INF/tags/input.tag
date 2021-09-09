<%@tag import="java.util.Objects"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" required="true" type="java.lang.String" %>
<%@ attribute name="name" required="false" type="java.lang.String" %>
<%@ attribute name="title" required="false" type="java.lang.String" %>
<%@ attribute name="maxlength" required="false" type="java.lang.Integer" %>
<%@ attribute name="required" required="false" type="java.lang.Boolean" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="clazz" required="false" type="java.lang.String" %>
<%@ attribute name="placeholder" required="false" type="java.lang.String" %>
<%@ attribute name="pattern" required="false" type="java.lang.String" %>
<%@ attribute name="patternString" required="false" type="java.lang.String" %>
<%@ attribute name="readonly" required="false" type="java.lang.String" %>
<%@ attribute name="style" required="false" type="java.lang.String" %>
<input ${readonly } type="text" id="${id }" name="${name }" title="${title }" maxlength="${maxlength }" class="AXInput ${not empty required && required ? 'av-required' : ''} ${clazz}" value="${value }" placeholder="${placeholder }" style="${style}"/>
<%
	String patternStr = "";
	if(Objects.nonNull(pattern)){
		if("custom".equals(pattern)){
			patternStr = ", patternString: '" + patternString + "'";
		}
%>
<script type="text/javascript">
	$("#${id }").bindPattern({pattern: "${pattern}"<%=patternStr%>});
</script>
<%}%>