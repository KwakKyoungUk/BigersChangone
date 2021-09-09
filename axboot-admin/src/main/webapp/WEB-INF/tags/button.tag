<%@tag import="java.util.Objects"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" required="true" type="java.lang.String" %>
<%@ attribute name="text" required="true" type="java.lang.String" %>
<%@ attribute name="style" type="java.lang.String" %>
<%@ attribute name="disabled" type="java.lang.String" %>
<button ${disabled } type="button" class="AXButton" id="${id }" style="${style}">${text }</button>
