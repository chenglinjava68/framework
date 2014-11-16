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
<title></title>
<%@include file="/page/common/common.jsp"%>
<style type="text/css">
	.a{
		overflow: visible;
	}
</style>
</head>
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		var url = fullpath + '/onlineHeadEnhanceJsController.do?doAdd';
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			url = fullpath + '/onlineHeadEnhanceJsController.do?doUpdate';
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

	
	$(function() {
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			$('#fm').form('load',fullpath + '/onlineHeadEnhanceJsController.do?doQueryById&id='	+ $(':input[name="id"]').val());
		}
	});
	
</script>
<body>
	<form method="post" id="fm" enctype="multipart/form-data">
		<fieldset>
			<legend>单表配置增强JS基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>单表配置项</th>
					<td>
						<input id="id" name="id"  type="hidden" value="<%=id%>" />
						<t:dictSelect name="headid" id="headid" dictTable="online_head" dictField="id" dictText="title" dataOptions="required:true" style="width:160px;"></t:dictSelect>
					</td>
				</tr>
				<tr>
					<th>JS位置</th>
					<td><t:dictSelect name="js_location" id="js_location" dic_code="tyzlk.common.jslocation" dataOptions="required:true" style="width:160px" /></td>
				</tr>
				<tr>
					<th>JS内容</th>
					<td>
						<div style="width: 660px;height:200px;overflow: scroll;">
							<textarea rows="25" cols="170" id="jscontent" name="jscontent" data-options="required:true"></textarea>
						</div>
					</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>