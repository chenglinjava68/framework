<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String configId = request.getParameter("configId");
	if (configId == null) {
		configId = "";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	$(function() {
		$("#configIdSpan").html("/dynamicReportController.do?list&configId=<%=configId%>");
	});
</script>
<body class="easyui-layout">
		<span id="configIdSpan"></span>
</body>
</html>