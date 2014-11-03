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
<title><%=(String) application.getAttribute("sendi_system_title")%>
</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq, $mainMenu) {
		var url = fullpath + '/syresourceController.do?add';
		
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			url = fullpath + '/syresourceController.do?update';
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
					$grid.treegrid('reload');
					$mainMenu.tree('reload');
				}
			}
		});
	};
	
	var showIcons = function() {
		var dialog = parent.sy.modalDialog({
			title : '浏览小图标',
			url : fullpath + '/easyui1.4/style/icons.jsp',
			buttons : [ {
				text : '确定',
				iconCls : "icon-ok",
				handler : function() {
					dialog.find('iframe').get(0).contentWindow.selectIcon(dialog, $('#iconCls'));
				}
			} ]
		});
	};
	
	//加载数据，根据id去数据库查询
	function loadRemote() {
		//$('#fm').form('load', fullpath + '/syresourceController.do?loadSyresourceById&id='+$(':input[name="id"]').val());
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(fullpath + '/syresourceController.do?loadSyresourceById', {
				id : $(':input[name="id"]').val(),
			}, function(result) {
				if (result.id != undefined) {
					$('form').form('load', {
						'id' : result.id,
						'name' : result.name,
						'url' : result.url,
						'sysresourcetype_id' : result.sysresourcetype_id,
						'description' : result.description,
						'sysresource_id' : result.sysresource_id,
						'iconCls' : result.iconCls,
						'seq' : result.seq,
						'target' : result.target
					});
					$('#iconCls').attr('class', result.iconCls);//设置背景图标
				}
				parent.$.messager.progress('close');
			}, 'json');
	}
	
	$(function(){
		if ($(':input[name="id"]').val().length > 0) {//如果ID不为空则表示修改操作，需要加载数据
			loadRemote();
		}
	});
</script>
<body>
	<form method="post" class="form" id="fm">
		<fieldset>
			<legend>资源基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>编号</th>
					<td><input name="id" value="<%=id%>" readonly="readonly" /></td>
					<th>资源名称</th>
					<td><input name="name" class="easyui-validatebox"
						data-options="required:true" /></td>
				</tr>
				<tr>
					<th>资源路径</th>
					<td><input name="url" /></td>
					<th>资源类型</th>
					<td><select id="sysresourcetype_id" class="easyui-combobox"
						name="sysresourcetype_id" style="width: 155px;">
							<option value="0">菜单</option>
							<option value="1">功能</option>
					</select></td>
				</tr>
				<tr>
					<th>上级资源</th>
					<td><select id="syresource_id" name="sysresource_id"
						class="easyui-combotree"
						data-options="editable:false,idField:'id',textField:'text',parentField:'pid',url:'<%=contextPath%>/syresourceController.do?getMainMenu'"
						style="width: 155px;"></select><img class="iconImg ext-icon-cross"
						onclick="$('#syresource_id').combotree('clear');" title="清空" /></td>
					<th>资源图标</th>
					<td><input id="iconCls" name="iconCls" readonly="readonly"
						style="padding-left: 18px; width: 134px;" /><img
						class="iconImg ext-icon-zoom" onclick="showIcons();" title="浏览图标" />&nbsp;<img
						class="iconImg ext-icon-cross"
						onclick="$('#iconCls').val('');$('#iconCls').attr('class','');"
						title="清空" /></td>
					</td>
				</tr>
				<tr>
					<th>顺序</th>
					<td><input name="seq" class="easyui-numberspinner"
						data-options="required:true,min:0,max:100000,editable:false"
						style="width: 155px;" value="100" /></td>
					<th>目标</th>
					<td><input name="target" /></td>
				</tr>
				<tr>
					<th>资源描述</th>
					<td><textarea name="description"></textarea></td>
					<th></th>
					<td></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>