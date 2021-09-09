<%@tag import="java.util.Objects"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" required="true" type="java.lang.String" %>
<%@ attribute name="url" required="true" type="java.lang.String" %>
<%@ attribute name="name" required="false" type="java.lang.String" %>
<%@ attribute name="title" required="false" type="java.lang.String" %>
<%@ attribute name="maxlength" required="false" type="java.lang.Integer" %>
<%@ attribute name="required" required="false" type="java.lang.Boolean" %>
<%@ attribute name="value" required="false" type="java.lang.String" %>
<%@ attribute name="clazz" required="false" type="java.lang.String" %>
<input type="text" id="${id }" name="${name }" title="${title }" maxlength="${maxlength }" class="AXInput ${not empty required && required ? 'av-required' : ''} ${clazz}" value="${value }"/>
<script type="text/javascript">
$(function(){

	app.ajax({
			async: false,
            type: "GET",
            url: "${url}",
            data: ""
        },
        function(res){
        	$('#${id }').bindSelector({
        		appendable:true,
				options: res
				, onChange: function(){

				}
			});
    	}
    );

})

$("#${id}").bind("keydown", function(){

	app.ajax({
			async: false,
            type: "GET",
            url: "${url}",
            data: "keyword="+$("#${id}").val()
        },
        function(res){
        	$('#${id }').bindSelector({
        		appendable:true,
				options: res
				, onChange: function(){
					$("#AXInputSelector").setConfigInput({options:res});
				}
			});
    	}
    );

})
</script>