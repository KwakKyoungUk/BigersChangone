<%@tag import="java.util.Objects"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" required="true" type="java.lang.String" %>
<%@ attribute name="text" required="true" type="java.lang.String" %>
<button type="button" class="AXButton" id="${id }"><i class="axi axi-plus-circle"></i> ${text }</button>
