<%@tag import="net.bigers.funeralsystem.lib.util.SpringUtils"%>
<%@tag import="net.bigers.funeralsystem.lib.util.SpringUtils.ControllerReflect"%>
<%@tag import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@tag import="java.util.Map"%>
<%@tag import="java.util.List"%>
<%@tag import="com.axisj.axboot.admin.controllers.BasicCodeController"%>
<%@tag import="java.util.Objects"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="id" required="true" type="java.lang.String" %>
<%@ attribute name="basicCd" required="false" type="java.lang.String" %>
<%@ attribute name="name" required="false" type="java.lang.String" %>
<%@ attribute name="isspace" required="false" type="java.lang.Boolean" %>
<%@ attribute name="isspaceTitle" required="false" type="java.lang.String" %>
<%@ attribute name="clazz" required="false" type="java.lang.String" %>
<%@ attribute name="url" type="java.lang.String" %>
<%@tag dynamic-attributes="da"%>
<%
Object options = null;
if(Objects.nonNull(basicCd)){
	BasicCodeController bcc = SpringUtils.getBean(BasicCodeController.class);
	options =  bcc.groupOptionList(basicCd);
}else{
	ControllerReflect cr = SpringUtils.getControllerByMapping(url);
	Map<String, String> da = (Map)jspContext.getAttribute("da");
	int size = da.values().size();
	if(size == 0){
		options = cr.invoke(null);
	}else{
		options = cr.invoke(da.values().toArray(new String[size]));
	}
}
String optionsJson = new ObjectMapper().writeValueAsString(options);
request.setAttribute("optionsJson", optionsJson);
%>
<jsp:doBody var="body" scope="request" />
<select id="${id }" name="${name }" class="AXSelect ${clazz}">
<jsp:doBody/>
</select>

<script type="text/javascript">
<c:choose>
	<c:when test="${body ne ''}">
		$(function(){
			$('#${id }').bindSelect();
		});
	</c:when>
	<c:otherwise>
	   	$(function(){
	   		$('#${id }').bindSelect({
				isspace: ${isspace == null ? 'false' : isspace},
				isspaceTitle: "${isspaceTitle == null ? '' : isspaceTitle}",
				direction: "bottom", // selector 박스가 열리는 방향
				options: JSON.parse('${optionsJson}'),
				onchange: function(){
				}
			});
	   	});
	</c:otherwise>
</c:choose>
</script>