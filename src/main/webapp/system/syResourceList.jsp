<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资源管理</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var grid;
	var pageUrl = fullpath + '/system/syResource.jsp';//增加与修改共用的jsp页面
	
	//新增
	var addFun = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加资源信息',
			url : pageUrl,
			buttons : [ {
				text : '添加',
				iconCls : "icon-ok",
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$, parent.mainMenu);
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
	
	var editFun = function(id) {
		var dialog = parent.sy.modalDialog({
			title : '编辑资源信息',
			url : fullpath + '/system/syResource.jsp?id=' + id,
			buttons : [ {
				text : '编辑',
				iconCls : "icon-ok",
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.submitForm(dialog, grid, parent.$, parent.mainMenu);
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

	var removeFun = function(id) {
		parent.$.messager.confirm('询问', '您确定要删除此记录？', function(r) {
			if (r) {
				$.post(fullpath + '/syresourceController.do?del', {
					id : id
				}, function(data) {
					$.messager.show({title : '消息窗口', msg : data.msg });
					grid.treegrid('reload');
					parent.mainMenu.tree('reload');
				}, 'json');
			}
		});
	};

	$(function() {
		grid = $('#dg')
				.treegrid(
						{
							title : '',
							url : fullpath + '/syresourceController.do?querySyresourceTreeGridDatas',
							//url : 'data.jsp',
							idField : 'id',
							treeField : 'name',
							parentField : 'sysresource_id',
							rownumbers : true,
							pagination : false,
							lines : true,
							frozenColumns : [ [ {
								width : '200',
								title : '资源名称',
								field : 'name'
							} ] ],
							columns : [ [
									{
										width : '200',
										title : '图标名称',
										field : 'iconCls'
									},
									{
										width : '200',
										title : '资源路径',
										field : 'url',
										formatter : function(value, row) {
											if (value) {
												return sy
														.formatString(
																'<span title="{0}">{1}</span>',
																value, value);
											}
										}
									},
									{
										width : '60',
										title : '资源类型',
										field : 'sysresourcetype_id',
										formatter : function(value, row) {
											if (value == '0') {
												return '菜单';
											}
											return '功能';
										}
									},
									{
										width : '150',
										title : '创建时间',
										field : 'createdatetime',
										hidden : true
									},
									{
										width : '150',
										title : '修改时间',
										field : 'updatedatetime',
										hidden : true
									},
									{
										width : '200',
										title : '资源描述',
										field : 'description',
										formatter : function(value, row) {
											if (value) {
												return sy
														.formatString(
																'<span title="{0}">{1}</span>',
																value, value);
											}
										}
									},
									{
										width : '80',
										title : '排序',
										field : 'seq',
										hidden : false
									},
									{
										width : '80',
										title : '目标',
										field : 'target',
										hidden : true
									},
									{
										title : '操作',
										field : 'action',
										width : '60',
										formatter : function(value, row) {
											var str = '';
											str += sy
													.formatString(
															'<img class="iconImg ext-icon-note_edit" title="编辑" onclick="editFun(\'{0}\');"/>',
															row.id);
											str += sy
													.formatString(
															'<img class="iconImg ext-icon-note_delete" title="删除" onclick="removeFun(\'{0}\');"/>',
															row.id);
											return str;
										}
									} ] ],
							toolbar : '#toolbar',
							onBeforeLoad : function(row, param) {
								parent.$.messager.progress({text : '数据加载中....'});
							},
							onLoadSuccess : function(row, data) {
								//加载完后折叠所有结点
								//grid.treegrid('collapseAll');
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
		</div>
	</div>
</body>
</html>