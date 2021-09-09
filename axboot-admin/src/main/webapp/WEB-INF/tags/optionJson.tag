<%@tag import="net.bigers.funeralsystem.lib.util.SpringUtils"%><%@tag import="net.bigers.funeralsystem.lib.util.SpringUtils.ControllerReflect"%><%@tag import="com.fasterxml.jackson.databind.ObjectMapper"%><%@tag import="java.util.Map"%><%@tag import="java.util.List"%><%@tag import="com.axisj.axboot.admin.controllers.BasicCodeController"%><%@tag import="java.util.Objects"%><%@ tag language="java" pageEncoding="UTF-8"%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ attribute name="basicCd" type="java.lang.String" %><%@ attribute name="url" type="java.lang.String" %><%@tag dynamic-attributes="da"%><%
Object options = null;
if(Objects.nonNull(basicCd)){
	BasicCodeController bcc = SpringUtils.getBean(BasicCodeController.class);
	options =  bcc.groupOptionList(basicCd);
}else{
	ControllerReflect cr = SpringUtils.getControllerByMapping(url);
	Map<String, String> da = (Map)jspContext.getAttribute("da");
	Object o = da.values();
	o.getClass();
	if(da.values().size() == 0){
		options = cr.invoke(null);
	}else{
		options = cr.invoke(da.values().toArray(new String[da.values().size()]));
	}
}
String optionsJson = new ObjectMapper().writeValueAsString(options);
request.setAttribute("optionsJson", optionsJson);
%>${optionsJson}