<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/page/common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Portal - jQuery EasyUI</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/easyui1.3.6/jquery-easyui-portal/portal.css">
	<style type="text/css">
		.title{
			font-size:16px;
			font-weight:bold;
			padding:20px 10px;
			background:#eee;
			overflow:hidden;
			border-bottom:1px solid #ccc;
		}
		.t-list{
			padding:5px;
		}
	</style>
	<script type="text/javascript" src="${ctx}/easyui1.3.6/jquery-easyui-portal/jquery.portal.js"></script>
	<script>
		$(function(){
			$('#pp').portal({
				border:false,
				fit:true
			});
		});
	</script>
</head>
<body class="easyui-layout">
	<div region="center" border="false">
		<div id="pp" style="position:relative">
			 <div style="width:30%;" >
				<!--<div title="时钟" style="text-align:center;background:#f3eeaf;height:150px;padding:5px;">
					<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="100" height="100">
				      <param name="movie" value="http://www.respectsoft.com/onlineclock/analog.swf">
				      <param name=quality value=high>
				      <param name="wmode" value="transparent">
				      <embed src="http://www.respectsoft.com/onlineclock/analog.swf" width="100" height="100" quality=high pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" wmode="transparent"></embed>
				    </object>
			    </div> -->
			    <div title="公告" collapsible="true" closable="true" style="height:200px;padding:5px;">
			    	<div class="t-list">1、统一资料库页面开发功能基本完成</div>
			    	<div class="t-list">2、下一步需要与业务平台进行数据接口同步,完善数据准确性</div>
			    	<div class="t-list">3、实现了手工录入，导入、查询、导出、数据同步等功能</div>
			    </div>
			</div>
			<div style="width:40%;">
				<div id="pgrid" title="测试页面" closable="true" style="height:360px;" >
					<table class="easyui-datagrid" style="width:650px;height:auto"
							fit="true" border="false"
							singleSelect="true",
							fitColumns="true",
							idField="itemid" url="${ctx}/easyui1.3.6/jquery-easyui-portal/datagrid_data.json">
						<thead>
							<tr>
								<th field="itemid" width="60">Item ID</th>
								<th field="productid" width="60">Product ID</th>
								<th field="listprice" width="80" align="right">List Price</th>
								<th field="unitcost" width="80" align="right">Unit Cost</th>
								<th field="attr1" width="120">Attribute</th>
								<th field="status" width="50" align="center">Status</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div style="width:30%;">
				<div title="日历" closable="true" style="padding:1px;">
					<div class="easyui-calendar" data-options="fit:true" style="height:274px;" closable="true"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>