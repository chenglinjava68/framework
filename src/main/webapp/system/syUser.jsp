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
		var url = fullpath + '/userController.do?addUser';
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			url = fullpath + '/userController.do?excuteModifyuser';
		}
		
		$('#fm').form('submit', {
			url : url,
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (!result.success) {
					$pjq.messager.show({
						title : '警告',
						msg : result.msg
					});
				} else {
					$dialog.dialog('close');
					$pjq.messager.show({
						title : '消息窗口',
						msg : result.msg,
						timeout : 5000,
						showType : 'slide'
					});
					$grid.datagrid('reload');
				}
			}
		});
	};

	//加载数据，根据id去数据库查询
	function loadRemote() {
		$('#fm').form('load', fullpath + '/userController.do?excutModifyQueryuser&id='+$(':input[name="id"]').val());
	}
	
	$(function() {
		$('#roleid').combobox({   //加载所属角色的列表数据
		    url:fullpath+"/userController.do?findParentidCombox",   
		    valueField:'id', 
		    required:true,
		    textField:'name'   
		});
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			loadRemote();
		}
	});
</script>
<body>
	<form method="post" id="fm">
		<fieldset>
			<legend>用户基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<input id="ida" name="id"  type="hidden" value="<%=id%>" />
					<th>账号名<font color="red">*</font></th>
					<td><input name="userId" class="easyui-validatebox"	data-options="required:true" /></td>
					<th>用户名<font color="red">*</font></th>
					<td><input name="userName" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>密码<font color="red">*</font></th>
					<td><input  name="password" class="easyui-validatebox" style="width:121px;" type="password" data-options="required:true" id="password" /></td>
					<th>确认密码<font color="red">*</font></th>
					<td><input name="passwordc" class="easyui-validatebox" style="width:121px;" type="password" data-options="required:true" validType="eqPwd['#password']"/></td>
				</tr>
				<tr>
					<th>密码有效期(天)</th>
					<td><input name="pwdvalicity" class="easyui-validatebox"/></td>
					<th>是否提示修改密码</th>
					<td>
						<select id="istip" class="easyui-combobox" name="istip" style="width:127px;">   
						    <option value="on">是</option>   
						    <option value="off">否</option>   
						</select>
					</td>
				</tr>
				<tr>
					<th>最大允许登录数</th>
					<td><input name="maxlogincount" class="easyui-textbox" /></td>
					<th>连接ip</th>
					<td><input name="ip" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<th>最大并发连接数</th>
					<td><input name="max_connect" class="easyui-validatebox"/></td>
					<th>所属角色<font color="red">*</font></th>
					<td><input id="roleid" name="roleid" value=""></td>
				</tr>
				<tr>
					<th>是否共享</th>
					<td>
						<select id="is_share" class="easyui-combobox" name="is_share" style="width:127px;">   
						    <option value="y">是</option>   
						    <option value="n">否</option>   
						</select>
					</td>
					<th></th>
					<td></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>