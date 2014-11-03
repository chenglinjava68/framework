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
					mainTabs.tabs('destroy', index);
				} else {
					$.messager.alert('提示', '[' + tab.panel('options').title + ']不可以被关闭！', 'error');
				}
			}
		} ]
	});

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
			<div title="主页" data-options="iconCls:'ext-icon-heart'">
				<iframe src="${ctx}/system/syUserList.jsp" allowTransparency="true" style="border: 0; width: 100%; height: 99%;" frameBorder="0"></iframe>
			</div>
		</div>
	</div>
	<div data-options="region:'south',href:'${ctx}/system/south.jsp',border:false" style="height: 30px; overflow: hidden;"></div>
</body>