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
		var url = fullpath + '/sysDataSourceController.do?add';
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			url = fullpath + '/sysDataSourceController.do?update';
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
		$('#fm').form('load', fullpath + '/sysDataSourceController.do?loadSysDataSourceById&id='+$(':input[name="id"]').val());
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
				<tr>
				    <input id="ida" name="id"  type="hidden" value="<%=id%>" /> 
					<th>数据源KEY<font color="red">*</font></th>
					<td><input name="ds_key" class="easyui-validatebox" data-options="required:true" /></td>
					<th>数据源名称<font color="red">*</font></th>
					<td><input name="ds_name" class="easyui-validatebox" data-options="required:true" /></td>
					
				</tr> 
				<tr>
					<th>驱动类<font color="red">*</font></th>
					<td><input  name="driverClassName" class="easyui-validatebox" data-options="required:true"/></td>
					<th>URL<font color="red">*</font></th>
					<td><input  name="url" class="easyui-validatebox" data-options="required:true"/></td>
					
				</tr>
				<tr>
					<th>账号<font color="red">*</font></th>
					<td><input name="username" class="easyui-validatebox" data-options="required:true"/></td>
					<th>密码<font color="red">*</font></th>
					<td><input name="password" class="easyui-validatebox" type="password" data-options="required:true"/></td>
					
				</tr>
				<tr>
					<th>连接测试语句<font color="red">*</font></th>
					<td><input name="validationQuery" class="easyui-validatebox" data-options="required:true" /></td>
					<th/><td/>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>