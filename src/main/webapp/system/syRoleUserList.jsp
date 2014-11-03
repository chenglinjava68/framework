<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String roleid = request.getParameter("roleid");
	if (roleid == null) {
		roleid = "";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>角色用户列表</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var grid;
	var roleid = '<%=roleid%>';//传过来的roleid参数
	
	$(function() {
		grid = $('#dg').datagrid({
			pagination : true,
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			url : fullpath + '/userController.do?queryUserByRoleId',
			queryParams : {
				roleid : roleid
			},
			columns:[[    
		          {field:'id',title:'id',width:30,hidden:true},    
		          {field:'userId',title:'用户账号',width:40},    
		          {field:'userName',title:'用户名',width:40},
		          {field:'createdate',title:'创建日期',width:70},
		          {field:'maxlogincount',title:'最大允许登录次数',width:70},
		          {field:'ip',title:'源ip',width:60},
		          {field:'max_connect',title:'最大并发数',width:40}
			]], 
			onBeforeLoad : function(row, param) {
				parent.$.messager.progress({text : '数据加载中....'});
			},
			onLoadSuccess : function(row, data) {
				$('.iconImg').attr('src', sy.pixel_0);
				parent.$.messager.progress('close');
			}
		});
	});
</script>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',fit:true,border:false">
		<table id="dg" data-options="fit:true,border:false" />
	</div>
</body>
</html>