<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>角色管理</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var grid;
	var pageUrl = fullpath + '/system/syRole.jsp';//增加与修改共用的jsp页面
	
	//新增
	var addFun = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加角色信息',
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
			title : '编辑角色信息',
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
		parent.$.messager.confirm('询问', '删除角色将删除被关联的用户,确定？', function(r) {
			if (r) {
				$.post(fullpath + '/syroleController.do?del', {
					ids : ids
				}, function(data) {
					$.messager.show({title : '消息窗口', msg : data.msg });
					$('#dg').datagrid('reload');
				}, 'json');
			}
		});
	};
	
	//查询按钮
	function queryUserFun(){
		$('#dg').datagrid('load', {    
			name: $('#search_name').val()
		});
	}
	
	var grantFun = function(id) {
		var dialog = parent.sy.modalDialog({
			title : '角色授权',
			url : fullpath + '/system/syRoleGrant.jsp?id=' + id,
			buttons : [ {
				text : '授权',
				iconCls : "icon-ok",
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$);
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
	
	//查看角色下的所有用户
	var viewUsersFun = function(roleid){
		var dialog = parent.sy.modalDialog({
			title : '角色用户列表',
			url : fullpath + '/system/syRoleUserList.jsp?roleid=' + roleid,
			buttons : [{
				text : '关闭',
				iconCls : "ext-icon-cross",
				handler : function() {
					dialog.dialog('close');
				}
			} ]
		});
	}
	
	$(function() {
		grid = $('#dg').datagrid({
			title : '角色列表',
			pagination : true,
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			fit : true,
			border : false,
			url : fullpath + '/syroleController.do?queryAll',
			columns:[[    
		          {field:'id',title:'id',width:30,checkbox:true},    
		          {field:'name',title:'角色名称',width:40},    
		          {field:'createdatetime',title:'创建时间',width:50},
		          {field:'updatedatetime',title:'修改时间',width:50},
		          {field:'description',title:'资源描述',width:70},
		          {field:'seq',title:'序号',width:40},
		          {field :'action',title :'操作',width:60,formatter:function(value, row){
		        	  		//strs + = sy.formatString('<img class="iconImg ext-icon-note" title="查看用户列表" onclick="viewUsersFun(\'{0}\');"/>', row.id);
		        	  		var str = "";
		        	  		str += '<t:auth resoureUrl="/base/syrole!save">'+sy.formatString('<img class="iconImg ext-icon-key" title="授权" onclick="grantFun(\'{0}\');"/>', row.id)+'</t:auth>';
		        	  		str += '<t:auth resoureUrl="/base/syrole!grant">'+sy.formatString('<img class="iconImg ext-icon-note" title="查看用户列表" onclick="viewUsersFun(\'{0}\');"/>', row.id)+'</t:auth>';
							return str ; 
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
			<t:auth resoureUrl="/base/syrole!save"><a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addFun()">增加</a></t:auth>
			<t:auth resoureUrl="/base/syrole!update"><a href="#"	class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editFun()">修改</a></t:auth>
			<t:auth resoureUrl="/base/syrole!delete"><a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delFun()">删除</a></t:auth>
			<label>角色名称：</label><input id="search_name" name="a" class="easyui-textbox">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryUserFun()">查询</a>
		</div>
	</div>
</body>
</html>