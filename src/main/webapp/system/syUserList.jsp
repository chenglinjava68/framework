<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户管理</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var grid;
	var pageUrl = fullpath + '/system/syUser.jsp';//增加与修改共用的jsp页面
	
	//新增
	var addFun = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加用户信息',
			url : pageUrl,
			buttons : [ {
				text : '添加',
				iconCls : "icon-ok",
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid,parent.$);
				}
			},{
				text : '取消',
				iconCls : "ext-icon-cross",
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		});
	};
	
	//修改
	var editFun = function() {
		var row = $('#dg').datagrid('getSelections');
		if(row.length==0) {
			$.messager.show({
				title : '警告',
				msg : '需要选中一行进行操作'
			});
			return ;
		}
		if(row.length>1) {
			$.messager.show({
				title : '警告',
				msg : '修改操作只能选择一行'
			});
			return ;
		}
		var dialog = parent.sy.modalDialog({
			title : '编辑用户信息',
			url : pageUrl+'?id=' + row[0].id,
			buttons : [ {
				text : '编辑',
				iconCls : "icon-ok",
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid,parent.$);
				}
			},{
				text : '取消',
				iconCls : "ext-icon-cross",
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		});
	};
	
	//删除
	var delFun = function() {
		var row = $('#dg').datagrid('getSelections');
		if(row.length==0) {
			$.messager.show({
				title : '警告',
				msg : '需要至少选中一行进行操作'
			});
			return ;
		}
		
		var ids = "'";//获取所有选中的IDs
		for(var i =0;i<row.length;i++){
			if(i ==row.length-1){
	    		ids += row[i].id+"'";
	    	}else {
	    		ids += row[i].id+"','";
	    	}
		}
		parent.$.messager.confirm('询问', '您确定要删除此记录？', function(r) {
			if (r) {
				$.post(fullpath + '/userController.do?excuteDeleteuser', {
					deleterecord : ids
				}, function(data) {
					$.messager.show({title : '消息窗口', msg : data.msg });
					$('#dg').datagrid('reload');
				}, 'json');
			}
		});
	};
	
	//激活或禁用
	var excuteChangestatusFun = function(activestatus){
		var row = $('#dg').datagrid('getSelections');
		if(row.length==0) {
			$.messager.show({
				title : '警告',
				msg : '需要至少选中一行进行操作'
			});
			return ;
		}
		
		var ids = "'";//获取所有选中的IDs
		for(var i =0;i<row.length;i++){
			if(i ==row.length-1){
	    		ids += row[i].id+"'";
	    	}else {
	    		ids += row[i].id+"','";
	    	}
		}
		
		parent.$.messager.confirm('询问', '您确定要操作？', function(r) {
			if (r) {
				$.post(fullpath + '/userController.do?excuteChangestatus', {
					deleterecord : ids,
					activestatus : activestatus
				}, function(data) {
					$.messager.show({title : '消息窗口', msg : data.msg });
					$('#dg').datagrid('reload');
				}, 'json');
			}
		});
	}
	
	//显示是否激活
	function isactivtFun(value){
		if(value == 'on') return '是';
		return '否';
	}
	
	//显示是否共享
	function isshareFun(value){
		if(value == 'y') return '是';
		return '否';
	}
	
	//查询按钮
	function queryUserFun(){
		$('#dg').datagrid('load', {    
		    userId: $('#search_userId').val(),
		    userName: $('#search_userName').val()
		});
	}
	
	$(function() {
		grid = $('#dg').datagrid({
			title : '用户列表',
			pagination : true,
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			url : fullpath + '/userController.do?queryUser',
			columns:[[    
		          {field:'id',title:'id',width:30,checkbox:true},    
		          {field:'userId',title:'用户账号',width:40},    
		          {field:'userName',title:'用户名',width:40},
		          {field:'pwdvalicity',title:'密码有效期/天',width:50},
		          {field:'createdate',title:'创建日期',width:70},
		          {field:'pwddate',title:'密码修改日期',width:70},
		          {field:'istip',title:'是否提示密码过期',width:70,formatter:isactivtFun},
		          {field:'maxlogincount',title:'最大允许登录次数',width:70},
		          {field:'isactive',title:'是否激活',width:30,formatter:isactivtFun},
		          {field:'is_share',title:'是否共享',width:40,formatter:isshareFun},
		          {field:'ip',title:'源ip',width:60},
		          {field:'max_connect',title:'最大并发数',width:40}
			]], 
			toolbar : '#toolbar',
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
		<div id="toolbar">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addFun()">增加</a> 
			<a href="#"	class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editFun()">修改</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delFun()">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="excuteChangestatusFun('on')">激活</a>
			<a href="#" class="easyui-linkbutton" iconCls="ext-icon-cross" plain="true" onclick="excuteChangestatusFun('off')">禁用</a>
			<label>用户名：</label><input id="search_userId" name="a" class="easyui-textbox">
			<label>账号名：</label><input id="search_userName" name="b" class="easyui-textbox">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryUserFun()">查询</a>
		</div>
	</div>
</body>
</html>