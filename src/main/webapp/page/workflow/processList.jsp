<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="t" uri="/easyui-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=(String) application.getAttribute("sendi_system_title")%>
</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
$(function() {
});
</script>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'west',border:false,split:true,title:'功能列表'" style="width: 150px;">
		<ul class="easyui-tree" data-options="checkbox:true,url:'tree_data.json'"></ul>
	</div>
	<div data-options="region:'center',border:false" style="overflow: hidden;">
		<table id="dg" class="easyui-datagrid" data-options="title:'ab',fit:true,border:false" />
			<thead>
				<tr>
					<th data-options="field:'code'">编码</th>
					<th data-options="field:'name'">名称</th>
					<th data-options="field:'price'">价格</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>001</td>
					<td>name1</td>
					<td>2323</td>
				</tr>
				<tr>
					<td>002</td>
					<td>name2</td>
					<td>4612</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>