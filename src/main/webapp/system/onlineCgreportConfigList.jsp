<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>动态报表配置列表</title>
<%@include file="/page/common/common.jsp"%>
<style type="text/css">
.configurl-div{
	width : 100%;
	height : 100%;
    margin:0px;
    padding:0px;
    background-color:#E7EAEB;
    font-family:"微软雅黑","黑体","宋体";
    font-size:15px;
}
.export-relativefile-link:VISITED,.export-relativefile-link:LINK{
	padding : 3px;
	color : #FFFFFF;
	font : font: normal small-caps normal 12pt 楷体,宋体,Serif;
	text-decoration: none;
	background-color: #28af64;
}
.export-relativefile-link:HOVER{
	background-color: #2882b9;
}
.delete-reportconfig-link:VISITED,.delete-reportconfig-link:LINK{
	padding : 3px;
	color : #FFFFFF;
	font : font: normal small-caps normal 12pt 楷体,宋体,Serif;
	text-decoration: none;
	background-color: #b67d23;
	padding: 6px;
}
.delete-reportconfig-link:HOVER{
	background-color: #2882b9;
}
.copy-reportconfig-link:VISITED,.copy-reportconfig-link:LINK{
	padding : 3px;
	color : #FFFFFF;
	font : font: normal small-caps normal 15pt 楷体,宋体,Serif;
	text-decoration: none;
	background-color: #9b5ab9;
	padding: 6px;
}
.copy-reportconfig-link:HOVER{
	background-color: #2882b9;
}
</style>
</head>
<script type="text/javascript">
	var grid;
	var pageUrl = fullpath + '/system/onlineCgReportConfig.jsp';//增加与修改共用的jsp页面
	
	//新增
	var addFun = function() {
		var dialog = parent.sy.modalDialog({
			width : 1200,
			title : '添加动态报表配置',
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
			}]
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
			width : 900,
			title : '编辑动态报表配置',
			url : pageUrl+'?id=' + row[0].id,
			buttons : [ {
				text : '保存',
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
				$.post(fullpath + '/onlineCgReportConfigController.do?deleteJformHead', {
					ids : ids
				}, function(data) {
					$.messager.show({title : '消息窗口', msg : data.msg });
					$('#dg').datagrid('reload');
				}, 'json');
			}
		});
	};
	
	var configReportUrl = function(configId){
		var dialog = parent.sy.modalDialog({
			width : 800,
			height : 150,
			title : '配置地址',
			url : fullpath + '/system/onlineCgReportConfigUrl.jsp?configId='+configId,
			buttons : [ {
				text : '复制',
				iconCls : "icon-ok",
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid,parent.$);
				}
			},{
				text : '关闭',
				iconCls : "ext-icon-cross",
				handler : function() {
					dialog.dialog('close');
				}
			}]
		});
	}
	
	//查询按钮
	function queryAll(){
		$('#dg').datagrid('load', {    
			coding: $('#search_coding').val(),
			name: $('#search_name').val()
		});
	}
	
	$(function() {
		grid = $('#dg').datagrid({
			title : '动态报表配置列表',
			pagination : true,
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			idField : 'id',
			fit : true,
			border : false,
			url : fullpath + '/onlineCgReportConfigController.do?queryConfigedReport',
			columns:[[    
		          {field:'id',title:'id',width:30,checkbox:true},    
		          {field:'coding',title:'编码',width:40},    
		          {field:'name',title:'名称',width:50},
		          {field:'sql',title:'查询数据SQL',width:50},
		          {field:'description',title:'描述',width:50},
		          {field:'ischart',title:'是否生成图表',width:50,formatter:function(value, row){
						return value=="Y"?"是":"否";
					}
		          },
		          {field :'action',title :'操作',width:200,formatter:function(value, row){
						return '[<a href="#" onclick="delFun()" class="delete-reportconfig-link">删除</a>]&nbsp;&nbsp;&nbsp;'+
						       '[<a href="#" class="copy-reportconfig-link" onclick="configReportUrl(\''+row.coding+'\')">配置地址</a>]';
					}
	          	  }
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
			<label>编码：</label><input id="search_coding" name="search_coding" class="easyui-validatebox">
			<label>名称：</label><input id="search_name" name="search_name" class="easyui-validatebox">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryAll()">查询</a>
		</div>
	</div>
</body>
</html>