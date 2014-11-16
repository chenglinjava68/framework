<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=(String) application.getAttribute("sendi_system_title")%>
</title>
<%@include file="/page/common/common.jsp"%>
</head>
<script type="text/javascript">
var mainMenu;
var mainTabs;

$(function() {
	//解锁登录处理函数
	var loginFun = function() {
		if ($('#loginDialog form').form('validate')) {
			$('#loginBtn').linkbutton('disable');
			$.post(fullpath + '/loginController.do?doLoginAgain', $('#loginDialog form').serialize(), function(result) {
				if (result.success) {
					$('#loginDialog').dialog('close');
				} else {
					$.messager.alert('提示', result.msg, 'error', function() {
						$('#loginDialog form :input:eq(1)').focus();
					});
				}
				$('#loginBtn').linkbutton('enable');
			}, 'json');
			
		}
	};
	
	//解锁登录窗口打开后隐藏
	$('#loginDialog').show().dialog({
		modal : true,
		closable : false,
		iconCls : 'ext-icon-lock_open',
		buttons : [ {
			id : 'loginBtn',
			text : '登录',
			iconCls : "icon-ok",
			handler : function() {
				loginFun();
			}
		} ],
		onOpen : function() {
			
		}
	}).dialog('close');
	
	//初始化时修改密码窗口打开后隐藏
	$('#passwordDialog').show().dialog({
		modal : true,
		closable : true,
		iconCls : 'ext-icon-lock_edit',
		buttons : [ {
			text : '修改',
			handler : function() {
				if ($('#passwordDialog form').form('validate')) {
					$.post(fullpath + '/loginController.do?updateCurrentPwd', {
						'oldPwd' : $('#oldPwd').val(),
						'pwd' : $('#pwd').val()
					}, function(result) {
						if (result.success) {
							$.messager.alert('提示', '密码修改成功！', 'info');
							$('#passwordDialog').dialog('close');
						}else{
							$.messager.alert('提示',result.faile, 'info');
						}
					}, 'json');
				}
			}
		} ],
		onOpen : function() {
			$('#passwordDialog form :input').val('');
		}
	}).dialog('close');
	
	mainMenu = $('#mainMenu').tree({
		url : fullpath + '/syresourceController.do?getMainMenu',
		lines : true,
		parentField : 'pid',
		onClick : function(node) {
			if (node.attributes.url) {
				var src = fullpath + node.attributes.url;
				
				if (!sy.startWith(node.attributes.url, '/')) {
					src = node.attributes.url;
				}
				if (node.attributes.target && node.attributes.target.length > 0) {
					window.open(src, node.attributes.target);
				} else {
					var tabs = $('#mainTabs');
					var opts = {
						title : node.text,
						closable : true,
						iconCls : node.iconCls,
						content : sy.formatString('<iframe src="{0}" allowTransparency="true" style="border:0;width:100%;height:99%;" frameBorder="0"></iframe>', src),
						border : false,
						fit : true
					};
					if (tabs.tabs('exists', opts.title)) {
						tabs.tabs('select', opts.title);
					} else {
						tabs.tabs('add', opts);
					}
				}
			}
		},
		onLoadSuccess : function(node,data){
			mainMenu.tree('collapseAll');
		}
	});
	
	mainTabs = $('#mainTabs').tabs({
		fit : true,
		border : false,
		tools : [ {
			iconCls : 'ext-icon-arrow_up',
			handler : function() {
				mainTabs.tabs({
					tabPosition : 'top'
				});
			}
		}, {
			iconCls : 'ext-icon-arrow_left',
			handler : function() {
				mainTabs.tabs({
					tabPosition : 'left'
				});
			}
		}, {
			iconCls : 'ext-icon-arrow_down',
			handler : function() {
				mainTabs.tabs({
					tabPosition : 'bottom'
				});
			}
		}, {
			iconCls : 'ext-icon-arrow_right',
			handler : function() {
				mainTabs.tabs({
					tabPosition : 'right'
				});
			}
		}, {
			text : '刷新',
			iconCls : 'ext-icon-arrow_refresh',
			handler : function() {
				var panel = mainTabs.tabs('getSelected').panel('panel');
				var frame = panel.find('iframe');
				try {
					if (frame.length > 0) {
						for (var i = 0; i < frame.length; i++) {
							frame[i].contentWindow.document.write('');
							frame[i].contentWindow.close();
							frame[i].src = frame[i].src;
						}
						if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
							try {
								CollectGarbage();
							} catch (e) {
							}
						}
					}
				} catch (e) {
				}
			}
		}, {
			text : '关闭',
			iconCls : 'ext-icon-cross',
			handler : function() {
				var index = mainTabs.tabs('getTabIndex', mainTabs.tabs('getSelected'));
				var tab = mainTabs.tabs('getTab', index);
				if (tab.panel('options').closable) {
					mainTabs.tabs('close', index);
 				} else {
					$.messager.alert('提示', '[' + tab.panel('options').title + ']不可以被关闭！', 'error');
				}
			}
		} ]
	});
	
	$("#mainFramePage").attr("src","${ctx}${sendi_sys_config_para.sendi_system_overviewurl}");

});
</script>
<body id="mainLayout" class="easyui-layout">
	<div data-options="region:'north',href:'${ctx}/system/north.jsp'" style="height: 70px; overflow: hidden;" class="logo"></div>
	<div data-options="region:'west',split:true,title:'功能列表'"
		style="width: 200px;">
		<ul id="mainMenu"></ul>
	</div>
	<div data-options="region:'center'" style="overflow: hidden;">
		<div id="mainTabs">
			<div title="主页" data-options="iconCls:'ext-icon-image'">
				<iframe id="mainFramePage" src="" allowTransparency="true" style="border: 0; width: 100%; height: 99%;" frameBorder="0"></iframe>
			</div>
		</div>
	</div>
	<div data-options="region:'south',href:'${ctx}/system/south.jsp',border:false" style="height: 30px; overflow: hidden;"></div>
	
	<div id="loginDialog" title="解锁登录" style="display: none;">
		<form method="post" class="form">
			<table class="table">
				<tr>
					<th width="50">登录名</th>
					<td>${userid}<input name="loginname" readonly="readonly" type="hidden" value="${userid}" /></td>
				</tr>
				<tr>
					<th>密码<font color="red">*</font></th>
					<td><input name="password" type="password" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="passwordDialog" title="修改密码" style="display: none;">
		<form method="post" class="form">
			<table class="table">
				<tr>
					<th>旧密码<font color="red">*</font></th>
					<td><input id="oldPwd" name="oldPwd" type="password" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>新密码<font color="red">*</font></th>
					<td><input id="pwd" name="pwd" type="password" class="easyui-validatebox" data-options="required:true" /></td>
				</tr>
				<tr>
					<th>重复密码<font color="red">*</font></th>
					<td><input type="password" class="easyui-validatebox" data-options="required:true,validType:'eqPwd[\'#pwd\']'" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
