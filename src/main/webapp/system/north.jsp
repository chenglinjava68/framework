<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" charset="utf-8">
	var lockWindowFun = function() {
		$.post(fullpath + '/loginController.do?logout', function(result) {
			$('#loginDialog').dialog('open');
			$(':input[name="password"]').val('').focus();
		}, 'json');
	};
	var logoutFun = function() {
		$.post(fullpath + '/loginController.do?logout', function(result) {
			location.replace(fullpath);
		}, 'json');
	};
	var showMyInfoFun = function() {
		var dialog = parent.sy.modalDialog({
			title : '我的信息',
			url : fullpath + '/system/myInfo.jsp'
		});
	};
</script>
<div id="sessionInfoDiv" style="position: absolute; right: 10px; top: 5px;">
	欢迎您，${username}
</div>
<div style="position: absolute; right: 0px; bottom: 0px;">
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu',iconCls:'ext-icon-rainbow'"><strong>更换皮肤</strong></a> 
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_kzmbMenu',iconCls:'ext-icon-cog'"><strong>控制面板</strong></a>
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_zxMenu',iconCls:'ext-icon-disconnect'"><strong>注销</strong></a>
</div>
<div id="layout_north_pfMenu" style="width: 120px; display: none;">
	<div onclick="sy.changeTheme('default');" title="default">default</div>
	<div onclick="sy.changeTheme('gray');" title="gray">gray</div>
	<div onclick="sy.changeTheme('metro');" title="metro">metro</div>
	<div onclick="sy.changeTheme('bootstrap');" title="bootstrap">bootstrap</div>
	<div onclick="sy.changeTheme('black');" title="black">black</div>
	<div class="menu-sep"></div>
	<div onclick="sy.changeTheme('metro-blue');" title="metro-blue">metro-blue</div>
	<div onclick="sy.changeTheme('metro-gray');" title="metro-gray">metro-gray</div>
	<div onclick="sy.changeTheme('metro-orange');" title="metro-orange">metro-orange</div>
	<div onclick="sy.changeTheme('metro-red');" title="metro-red">metro-red</div>
	<div class="menu-sep"></div>
	<div onclick="sy.changeTheme('ui-cupertino');" title="ui-cupertino">ui-cupertino</div>
	<div onclick="sy.changeTheme('ui-dark-hive');" title="ui-dark-hive">ui-dark-hive</div>
	<div onclick="sy.changeTheme('ui-pepper-grinder');" title="ui-pepper-grinder">ui-pepper-grinder</div>
	<div onclick="sy.changeTheme('ui-sunny');" title="ui-sunny">ui-sunny</div>
</div>
<!-- author:liujinghua 20141110 for:去掉控制面板功能，因为没实现，暂时屏蔽-->
<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-user_edit'" onclick="$('#passwordDialog').dialog('open');">修改密码</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-user'" onclick="showMyInfoFun();">我的信息</div>
</div>

<div id="layout_north_zxMenu" style="width: 100px; display: none;">
	<div data-options="iconCls:'ext-icon-lock'" onclick="lockWindowFun();">锁定窗口</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'ext-icon-door_out'" onclick="logoutFun();">退出系统</div>
</div>