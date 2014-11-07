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
		var url = fullpath + '/sysJobInterfaceController.do?add';
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			url = fullpath + '/sysJobInterfaceController.do?update';
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
		$('#fm').form('load', fullpath + '/sysJobInterfaceController.do?loadSysJobInterfaceById&id='+$(':input[name="id"]').val());
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
			<legend>定时任务信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<input id="ida" name="id"  type="hidden" value="<%=id%>" />
					<th>任务ID</th>
					<td><input name="interfaceid" class="easyui-validatebox"	data-options="required:true" /></td>
					<th>任务描述</th>
					<td><input name="description" class="easyui-validatebox"  /></td>
				</tr> 
				<tr>
					<th>任务实现类</th>
					<td><input  name="interfacecalss" class="easyui-validatebox" data-options="required:true"/></td>
					<th>任务类型</th>
					<td>
						<select id="jobtype" class="easyui-combobox" name="jobtype" style="width:142px;" data-options="required:true" onSelect="alert()">   
						    <option value="c">复杂任务</option>   
						    <option value="s">简单任务</option>   
						</select>
					</td>
				</tr>
				<tr>
					<th>任务开始时间</th>
					<td><input name="jobstartTime" class="easyui-validatebox"/></td>
					<th>任务间隔时间</th>
					<td><input name="jobRepeatInterval" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>任务重复次数</th>
					<td><input name="jobRepeatcount" class="easyui-validatebox" /></td>
					<th>是否激活</th>
					<td>
						<select id="isactive" class="easyui-combobox" name="isactive" style="width:142px;" data-options="required:true">   
						    <option value="off">off</option>   
						    <option value="on">on</option>   
						</select>
					</td>
				</tr>
				<tr>
					<th>Cron表达式</th>
					<td><input name="cronexpression" class="easyui-validatebox"/></td>
					<th></th>
					<td></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>