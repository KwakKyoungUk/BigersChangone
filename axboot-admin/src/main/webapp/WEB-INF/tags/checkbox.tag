<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" required="true" type="java.lang.String" %>
<%@ attribute name="name" required="false" type="java.lang.String" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="clazz" required="false" type="java.lang.String" %>
<%@ attribute name="label" required="false" type="java.lang.String" %>
<label><input type="checkbox" id="${id }" name="${name }" class="AXInput ${clazz}" value="${value }" placeholder="${placeholder }"/> ${label }</label>