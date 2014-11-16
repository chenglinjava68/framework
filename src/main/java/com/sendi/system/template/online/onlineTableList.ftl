<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${online_head.title}</title>

<#include "common.ftl" />

</head>
<script type="text/javascript">
	var grid;
	var pageUrl = fullpath + '/onlineTableController.do?goDetailPage&configId=${configId}';//增加与修改共用的jsp页面
	
	//新增
	var addFun = function() {
		var dialog = parent.sy.modalDialog({
			title : '添加',
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
				title : '警告',msg : '需要选中一行进行操作'
			});
			return ;
		}
		if(row.length>1) {
			$.messager.show({
				title : '警告',msg : '修改操作只能选择一行'
			});
			return ;
		}
		
		var dialog = parent.sy.modalDialog({
			title : '编辑',
			url : pageUrl+'&id=' + row[0].id,
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
	
	//查看
	var viewFun = function() {
		var row = $('#dg').datagrid('getSelections');
		if(row.length==0) {
			$.messager.show({
				title : '警告',msg : '需要选中一行进行操作'
			});
			return ;
		}
		if(row.length>1) {
			$.messager.show({
				title : '警告',msg : '查看操作只能选择一行'
			});
			return ;
		}
		
		var dialog = parent.sy.modalDialog({
			title : '查看',
			url : pageUrl+'&id=' + row[0].id+ '&load=view',
			buttons : [{
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
				$.post(fullpath + '/onlineTableController.do?del', {
					ids : ids,
					configId : '${configId}'
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
			<!----------------------------------组装查询条件开始---------------------------------------->
			<#if (searchfield_list?size>0)>
			<#list searchfield_list  as x> 
				<#if x['fieldtype']=="datetime"><!--时间-->
				${x['fieldname']}: $('#search_${x['fieldname']}').datetimebox('getValue'),
				<#elseif x['fieldtype']=="date"><!--日期-->
				${x['fieldname']}: $('#search_${x['fieldname']}').datebox('getValue'),
				<#elseif x['fieldtype']=="combobox"><!--下拉选择框-->
				${x['fieldname']}: $('#search_${x['fieldname']}').combobox('getValue'),
				<#else><!--默认文本-->
				${x['fieldname']}: $('#search_${x['fieldname']}').val(),
				</#if>
			</#list>
			</#if>
			<!----------------------------------组装查询条件结束---------------------------------------->
		});
	}
	
	$(function() {
		grid = $('#dg').datagrid({
			title : '${online_head.title}列表',
			pagination : true,
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			fit : true,
			border : false,
			//idField : 'id',
			url : fullpath + '/onlineTableController.do?queryAll&configId=${configId}',
			columns:[[ 
			<!----------------------------------组装列表字段开始---------------------------------------->   
				   {field:'id',title:'id',width:30,checkbox:true},
		           <#if (online_item?size>0)>
					<#list online_item  as x> 
						{field:'${x['fieldname']}',title:'${x['fieldtitle']}',width:40,<#if x['isshow']=="N">hidden:true</#if>}, <!--N表示不显示在列表中-->
					</#list>
				   </#if>
		    <!----------------------------------组装列表字段结束---------------------------------------->
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
		
	<#list list_enhance_js as jscontent>
		${jscontent}
	</#list>
</script>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',fit:true,border:false">
		<table id="dg"/>
		<div id="toolbar">
			<!--增加按钮权限控制-->
			<#if buttonOperAuth.save=="Y"><a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addFun()">增加</a></#if>
			<#if buttonOperAuth.update=="Y"><a href="#"	class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editFun()">修改</a></#if>
			<#if buttonOperAuth.delete=="Y"><a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delFun()">删除</a></#if>
			<#if buttonOperAuth.view=="Y"><a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="viewFun()">查看</a></#if>
			<!----------------------------------组装查询条件开始---------------------------------------->
			<#if (searchfield_list?size>0)>
			<#list searchfield_list  as x> 
				<#if x['fieldtype']=="datetime"><!--时间-->
				<label>${x['fieldtitle']}：</label><input id="search_${x['fieldname']}" name="search_${x['fieldname']}" class="easyui-datetimebox">
				<#elseif x['fieldtype']=="date"><!--日期-->
				<label>${x['fieldtitle']}：</label><input id="search_${x['fieldname']}" name="search_${x['fieldname']}" class="easyui-datebox">
				<#elseif x['fieldtype']=="combobox"><!--下拉选择框-->
				<label>${x['fieldtitle']}：</label><input id="search_${x['fieldname']}" class="easyui-combobox" name="search_${x['fieldname']}" data-options="valueField:'dic_key',textField:'dic_value',url:'${fullpath}/onlineTableController.do?queryDic&dic_code=${x.dic_code}'" />
				<#else><!--默认文本-->
				<label>${x['fieldtitle']}：</label><input id="search_${x['fieldname']}" name="search_${x['fieldname']}" class="easyui-validatebox">
				</#if>
			</#list>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryInterfaceFun()">查询</a>
			</#if>
			<!----------------------------------组装查询条件结束---------------------------------------->
		</div>
	</div>
</body>
</html>