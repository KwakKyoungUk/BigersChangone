<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setContentType("application/optet-stream");
response.setHeader( "Content-Disposition", "filename=" + request.getAttribute("filename")+".xls");
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<style type="text/css">
		table {
		    border-spacing: 0;
		    border-collapse: collapse;
		}
		thead td {
			background-color: #F2F2F2;
			font-weight: bolder;
		}
		td, th {
			text-align: center;
			border-style: solid;
			border-color: black;
/* 			border-right-width: 1px; */
			border-bottom-width: 1px;
		}
/* 		tr:eq(0) td{ */
/* 			border-top-width: 1px; */
/* 		} */
/* 		td:eq(0) { */
/* 			border-left-width: 1px; */
/* 		} */
	</style>
</head>
<body>
${excelFormat }
</body>
</html>