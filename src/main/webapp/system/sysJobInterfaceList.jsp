<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>定时任务配置</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var grid;
	var pageUrl = fullpath + '/system/sysJobInterface.jsp';//增加与修改共用的jsp页面
	
	//新增
	var addFun = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加定时任务',
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
			title : '编辑定时任务',
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
		parent.$.messager.confirm('询问', '确定删除吗？', function(r) {
			if (r) {
				$.post(fullpath + '/sysJobInterfaceController.do?del', {
					ids : ids
				}, function(data) {
					$.messager.show({title : '消息窗口', msg : data.msg });
					$('#dg').datagrid('reload');
				}, 'json');
			}
		});
	};
	
	//查询按钮
	function queryInterfaceFun(){
		$('#dg').datagrid('load', {    
			interfaceid: $('#search_interfaceid').val()
		});
	}
	
	$(function() {
		grid = $('#dg').datagrid({
			title : '定时任务列表',
			pagination : true,
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			fit : true,
			border : false,
			url : fullpath + '/sysJobInterfaceController.do?queryAll',
			columns:[[    
		          {field:'id',title:'id',width:30,checkbox:true},    
		          {field:'description',title:'任务描述',width:40},    
		          {field:'interfaceid',title:'任务ID',width:50},
		          {field:'interfacecalss',title:'任务实现类',width:50},
		          {field:'jobtype',title:'任务类型',width:70},
		          {field:'isactive',title:'是否激活',width:40}
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
		<table id="dg"/>
		<div id="toolbar">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addFun()">增加</a>
			<a href="#"	class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editFun()">修改</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delFun()">删除</a>
			<label>任务ID：</label><input id="search_interfaceid" name="search_interfaceid" class="easyui-validatebox">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryInterfaceFun()">查询</a>
		</div>
	</div>
</body>
</html>