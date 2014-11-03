<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String contextPath = request.getContextPath();
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
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		var nodes = $('#tree').tree('getChecked', [ 'checked', 'indeterminate' ]);
		var ids = [];
		for (var i = 0; i < nodes.length; i++) {
			ids.push(nodes[i].id);
		}
		$.post(fullpath + '/syresourceController.do?grant', {
			roleid : $(':input[name="id"]').val(),
			resourceids : ids.join(',')
		}, function(data) {
			if (data.success) {
				$dialog.dialog('close');
			} 
			$pjq.messager.show({title : '消息窗口', msg : data.msg });
		}, 'json');
	};

	$(function() {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$('#tree').tree({
			url : fullpath + '/syresourceController.do?queryAll',
			parentField : 'pid',
			checkbox : true,
			lines : true,
			onLoadSuccess : function(node, data) {
				$.post(fullpath + '/syresourceController.do?queryByRoleId', {
					roleid : $(':input[name="id"]').val()
				}, function(result) {
					if (result) {
						for (var i = 0; i < result.length; i++) {
							var node = $('#tree').tree('find', result[i].SYRESOURCE_ID);
							if (node) {
								var isLeaf = $('#tree').tree('isLeaf', node.target);
								if (isLeaf) {
									$('#tree').tree('check', node.target);
								}
							}
						}
					}
					parent.$.messager.progress('close');
				}, 'json');
			}
		});
	});
</script>
</head>
<body class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',fit:true,border:false">
		<div id="treeDiv">
			<input name="id" value="<%=id%>" readonly="readonly" type="hidden" />
			<fieldset>
				<legend>角色授权</legend>
				<ul id="tree"></ul>
			</fieldset>
		</div>
	</div>
</body>
</html>