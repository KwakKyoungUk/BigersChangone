<%@tag import="java.util.Objects"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" required="true" type="java.lang.String" %>
<%@ attribute name="name" required="false" type="java.lang.String" %>
<%@ attribute name="title" required="false" type="java.lang.String" %>
<%@ attribute name="required" required="false" type="java.lang.Boolean" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="clazz" required="false" type="java.lang.String" %>
<input type="text" id="${id }" name="${name }" title="${title }" class="AXInput ${not empty required && required ? 'av-required' : ''} ${clazz}" value="${value }"/>
<script type="text/javascript">
	$(function(){
			$("#${id}").bindDateTime().val('${value}');
	})
</script>