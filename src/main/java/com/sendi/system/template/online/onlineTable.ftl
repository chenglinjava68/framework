<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>

<#include "common.ftl" />

</head>
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		var url = fullpath + '/onlineTableController.do?add';
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			url = fullpath + '/onlineTableController.do?update';
		}
		
		$('#fm').form('submit', {
			url : url + '&configId=' + $('#configId').val() ,
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (!result.success) {
					$pjq.messager.show({title : '警告',msg : result.msg});
				} else {
					$pjq.messager.show({title : '消息窗口',msg : result.msg});
					$dialog.dialog('close');
					$grid.datagrid('reload');
				}
			}
		});
	};

	//加载数据，根据id去数据库查询
	function loadRemote() {
		$('#fm').form('load', fullpath + '/onlineTableController.do?loadById&id=' + $(':input[name="id"]').val() + '&configId=' + $('#configId').val() );
	}
	
	$(function() {
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			loadRemote();
		}
	});
</script>
<body>
	<form method="post" id="fm">
		<fieldset>
			<legend>${online_head.title}信息</legend>
			<table class="table" style="width: 100%;">
				<input id="id" name="id"  type="hidden" value="${id}" />
				<input id="configId" name="configId"  type="hidden" value="${configId}" /><!--单表配置的ID-->
				
				<!----------------------------------组装表单字段开始---------------------------------------->   
		           <#if (online_item?size>0)>
					<#list online_item  as x>
						<#if x_index%2 == 0>
						<tr>
						</#if>
							<th>${x.fieldtitle}</th>
							<#if x['fieldtype']=="datetime"><!--时间-->
							<td><input name="${x.fieldname}" class="easyui-datetimebox"	data-options="${x.data_options}" /></td>
							<#elseif x['fieldtype']=="date"><!--日期-->
							<td><input name="${x.fieldname}" class="easyui-datebox"	data-options="${x.data_options}" /></td>
							<#elseif x['fieldtype']=="combobox"><!--下拉选择框-->
							<td><input id="${x.fieldname}" class="easyui-combobox" name="${x.fieldname}" data-options="valueField:'dic_key',textField:'dic_value',url:'${fullpath}/onlineTableController.do?queryDic&dic_code=${x.dic_code}',${x.data_options}" /></td>
							<#else><!--默认文本框-->
							<td><input name="${x.fieldname}" class="easyui-validatebox"	data-options="${x.data_options}" /></td>
							</#if>
						<#if x_index%2 != 0>
						</tr>
						</#if>
					</#list>
					<#if (online_item?size % 2 != 0)><!--如果是奇数个字段，则最后一行加入空白-->
						<th></th>
						<td></td>
						</tr>
					</#if>
				   </#if>
		   		<!----------------------------------组装表单字段结束---------------------------------------->
			</table>
		</fieldset>
	</form>
</body>
</html>