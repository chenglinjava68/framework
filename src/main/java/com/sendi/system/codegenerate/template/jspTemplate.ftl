<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=(String) application.getAttribute("sendi_system_title")%>
</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		var url = fullpath + '/${entityName?uncap_first}Controller.do?doAdd';
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			url = fullpath + '/${entityName?uncap_first}Controller.do?doUpdate';
		}
		
		$('#fm').form('submit', {
			url : url,
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
		$('#fm').form('load', fullpath + '/${entityName?uncap_first}Controller.do?loadById&id='+$(':input[name="id"]').val());
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
			<legend>数据源信息</legend>
			<table class="table" style="width: 100%;">
				<input id="id" name="id"  type="hidden" value="<%=id%>" />
				<!----------------------------------组装表单字段开始---------------------------------------->   
		           <#if (originalColumns?size>0)>
					<#list originalColumns  as x>
						<#if x_index%2 == 0 && x['fieldName'] != 'id'>
						<tr>
						</#if>
							<th>${x.fieldComment}<#if x['nullable']=='Y'><font color="red">*</font></#if></th>
							
							<#if x['fieldType']=="java.util.Date"><!--时间-->
							<td><input name="${x.fieldName}" class="easyui-datetimebox" <#if x['nullable']=='Y'>data-options="required:true"</#if> /></td>
							<#elseif x['fieldType'] == "java.lang.Integer"><!--数字-->
							<td><input name="${x.fieldName}" class="easyui-numberbox" <#if x['nullable']=='Y'>data-options="required:true"</#if> /></td>
							<#else><!--默认文本框-->
							<td><input name="${x.fieldName}" class="easyui-validatebox" <#if x['nullable']=='Y'>data-options="required:true"</#if> /></td>
							</#if>							
						<#if x_index%2 != 0>
						</tr>
						</#if>
					</#list>
					<#if (originalColumns?size % 2 != 0)><!--如果是奇数个字段，则最后一行加入空白-->
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