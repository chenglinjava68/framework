<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>平台软件升级信息</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var grid;
	var pageUrl = fullpath + '/system/onlineHeadEnhanceJs.jsp';//增加与修改共用的jsp页面
	
	//新增
	var addFun = function() {
		var dialog = parent.sy.modalDialog({
			height : 500,
			width : 900,
			title : '添加单表配置增强JS信息',
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
			height : 500,
			width : 900,
			title : '编辑单表配置增强JS信息',
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
				$.post(fullpath + '/onlineHeadEnhanceJsController.do?doDelete', {
					ids : ids
				}, function(data) {
					$.messager.show({title : '消息窗口', msg : data.msg });
					$('#dg').datagrid('reload');
				}, 'json');
			}
		});
	};
	//查看
	var viewFun = function() {
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
				msg : '查看操作只能选择一行'
			});
			return ;
		}
		var dialog = parent.sy.modalDialog({
			height : 500,
			width : 900,
			title : '查看单表配置增强JS信息',
			url : pageUrl+'?id=' + row[0].id +'&load=view',
			buttons : [ {
				text : '取消',
				iconCls : "ext-icon-cross",
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		});
	};
	//查询按钮
	function queryUserFun(){
		$('#dg').datagrid('load', {    
			headid : $('#search_headid').combobox('getValue'),
			js_location: $('#search_js_location').combobox('getValue'),
		});
	}
	
	$(function() {
		grid = $('#dg').datagrid({
			title : '单表配偶增强JS信息列表',
			pagination : true,
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			fit : true,
			border : false,
			url : fullpath + '/onlineHeadEnhanceJsController.do?doQuery',
			columns:[[    
		          {field:'id',title:'id',width:30,checkbox:true},  
		          {field:'headid',title:'单表配置项',width:40},
		          {field:'js_location',title:'js位置',width:40}    
		          //{field:'jscontent',title:'js内容',width:40,hidden:true}
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
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editFun()">修改</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delFun()">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="viewFun()">查看</a>
			<label>单表配置项：</label><t:dictSelect name="search_headid" id="search_headid" dictTable="online_head" dictField="id" dictText="title" style="width:160px;"></t:dictSelect>
			<label>js位置：</label><t:dictSelect name="search_js_location" id="search_js_location" dic_code="tyzlk.common.jslocation" style="width:160px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryUserFun()">查询</a>
		</div>
	</div>
</body>
</html>