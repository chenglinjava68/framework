<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的信息</title>
<%@include file="/page/common/common.jsp"%>
</head>
	<script type="text/javascript">
		$(function(){
			$.getJSON( fullpath + "/userController.do?queryUserByUserId&userid=${sessionScope.userid}", function(data) {
	        	var item=data;
	        	var isactive="不可用";
	        	if(item.isactive=="on"){
	    			isactive="可用";
	    		}
	        	var info="<table><tr><td class='bg_cell'>用户ID:</td><td>"+item.userId+"</td>"+
					"<td class='bg_cell'>登录名:</td><td>"+item.userName+"</td></td></tr>"+
  						"<tr><td class='bg_cell'>用户建立时间:</td><td>"+item.createdate+"</td>"+
						"<td class='bg_cell'>账号是否可用:</td><td>"+isactive+"</td></tr></table>";
			 	$(info).appendTo("#userInfo");
		    });
		     
  			$.ajax({
  				type: "POST",
				url: fullpath + "/syroleController.do?queryRoleByUserId",
				data: {"userId":"${sessionScope.userid}"},
				dataType: "json",
				success: function(data){
					var myroles="";
					for(var i=0;i<data.length;i++){
						myroles+="<div>"+data[i].rolename+"("+data[i].roledesc+")</div>";
					}
					$(myroles).appendTo("#left_roles");
				}
  			});
  			
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			
			$('#tree').tree({
				url : fullpath + '/syresourceController.do?queryResourceByRoleId',
				parentField : 'pid',
				checkbox : false,
				lines : true,
				onLoadSuccess : function() {
					parent.$.messager.progress('close');
				}
 			});
		});
	</script>
	
	<style type="text/css">
		body,table{
			font-family: verdana, helvetica, arial, sans-serif;
			font-size:14px;
		}
		table{
			width:100%;
			border:1px solid black;
			border-collapse:collapse;
		}
		table td{
			width:25%;
			padding:5px;
			border:1px solid black;
		}
		.bg_cell{
			background-color:#F4F4F4;
		}
		#userInfo,#left_roles{
			margin-top:5px;
			margin-left:15px;
			margin-right:15px;
			margin-bottom:10px;
		}
	</style>
  </head>
  
  <body>
  	<div>基本信息:</div>
  	<div id="userInfo"></div>
  	<div>用户角色:</div>
  	<div id="left_roles"></div>
  	<div id="right_permissions">
		<fieldset>
			<legend>具体功能权限如下:</legend>
			<ul id="tree"></ul>
		</fieldset>
  	</div>
  </body>
</html>
