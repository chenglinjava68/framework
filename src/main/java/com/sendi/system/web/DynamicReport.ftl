<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${headers.NAME}</title>
<#include "/com/sendi/system/template/online/common.ftl" />
</head>
<script type="text/javascript">
	function getInfoFormLocationUrl(paraName){
	    var oldurl = location.href;
		var index = oldurl.indexOf(paraName);
		var index2 = oldurl.indexOf('&', index);
		var userid = '';
		if (index != -1 && index2 != -1) {
			userid = oldurl.substring(index + paraName.length, index2);
		} else if (index != -1) {
			userid = oldurl.substring(index + paraName.length);
		}
		return userid;
	}
	
	//获取页面配置id
	var configId=getInfoFormLocationUrl("configId=");
	
	//查询按钮
	function queryInterfaceFun(){
		$('#dg').datagrid('load', {
		<!----------------------------------组装查询条件开始---------------------------------------->
		<#if (config_fieldList?size>0)>
			  <#list config_fieldList  as x> 
			     <#if x['s_flag']=="Y">
				  	<#if x['field_type']=="DateTime"><!--时间-->
						${x['field_name']}: $('#search_${x['field_name']}').datetimebox('getValue'),
						<#elseif x['field_type']=="Date"><!--日期-->
						${x['field_name']}: $('#search_${x['field_name']}').datebox('getValue'),
						<#elseif x['field_type']=="ComboBox"><!--下拉选择框-->
						${x['field_name']}: $('#search_${x['field_name']}').combobox('getValue'),
						<#else><!--默认文本-->
						${x['field_name']}: $('#search_${x['field_name']}').val(),
					</#if>
				 </#if>
			 </#list>
		</#if>
		<!----------------------------------组装查询条件结束---------------------------------------->
	});
	}
		
	$(function() {
		grid = $('#dg').datagrid({
			title : '${headers.NAME}列表',
			pagination : true,
			fitColumns : true,
			rownumbers : true,
			singleSelect : false,
			idField : 'id',
			fit : true,
			border : false,
			url : fullpath + '/onlineCgReportController.do?dataQry&configId='+configId,
			columns : [[
				<!----------------------------------组装列表字段开始---------------------------------------->   
				<#if (config_fieldList?size>0)>
			    <#list config_fieldList  as x>  
				 	<#if x_has_next>
					{field:'${x['field_name']}',title: "${x['field_txt']}", width:'${x['field_width']}'  <#if x['is_show']=='N'>,hidden:true</#if>} ,
					<#else>
					{field:'${x['field_name']}',title: "${x['field_txt']}", width:'${x['field_width']}'  <#if x['is_show']=='N'>,hidden:true</#if>}
				  	</#if>
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
</script>

<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',fit:true,border:false">
		<table id="dg"/>
		<div id="toolbar">
			<!----------------------------------组装查询条件开始---------------------------------------->
			<#if (config_fieldList?size>0)>
			<#list config_fieldList  as x> 
				<#if x['field_type']=="DateTime"><!--时间-->
				<label>${x['field_txt']}：</label><input id="search_${x['field_name']}" value="${x['default_value']}" name="search_${x['field_name']}" class="easyui-datetimebox">
				<#elseif x['field_txt']=="Date"><!--日期-->
				<label>${x['field_txt']}：</label><input id="search_${x['field_name']}" value="${x['default_value']}" name="search_${x['field_name']}" class="easyui-datebox">
				<#elseif x['field_type']=="ComboBox"><!--下拉选择框-->
				<label>${x['field_txt']}：</label><input id="search_${x['field_name']}" value="${x['default_value']}" class="easyui-combobox" name="search_${x['field_name']}" data-options="valueField:'dic_key',textField:'dic_value',url:'${fullpath}/onlineTableController.do?queryDic&dic_code=${x.dict_code}'" />
				<#else><!--默认文本-->
				<label>${x['field_txt']}：</label><input id="search_${x['field_name']}" value="${x['default_value']}" name="search_${x['field_name']}" class="easyui-validatebox">
				</#if>
			</#list>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryInterfaceFun()">查询</a>
			</#if>
			<!----------------------------------组装查询条件结束---------------------------------------->
		</div>
	</div>
</body>
</html>