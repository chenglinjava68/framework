<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=(String)application.getAttribute("sendi_system_title")%> -- 系统登录界面</title>
<script language="javascript"> 
function loadimage(){ 
document.getElementById("randImage").src = "system/image.jsp?"+Math.random(); 
} 
</script> 
</head>


<body onload="document.login.login_username.focus();">
		<form  method="post" name="login" action="loginController.do?login" >
			<table width="880" height="441" border="0" align="center">
				<tr>
					<td background="page/image/login_bg.jpg" valign="top">
						<table width="100%" border="0">
							<tr>
								<td height="141" colspan="3" valign="top">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="5%" height="58">
												&nbsp;
											</td>
											<td width="95%" height="58">
												<img src="page/image/logo.jpg" width="300" height="58" />
											</td>
										</tr>
										<tr>
											<td>
												&nbsp;
											</td>
											<td>
												&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td width="60%" height="183">
									&nbsp;
								</td>
								<td width="33%" valign="top">
									<table width="100%" border="0" cellspacing="3" cellpadding="3">
										<tr>
											<td height="15" colspan="2"></td>
										</tr>
										<tr>											
											<td width="32%" align="right" class="login_font">
												用户名：
											</td>
											<td width="71%">
											<input  class="loginput" name=login_username style="width: 120px">
											</td>
										</tr>
										<tr>
											<td width="30%" align="right" class="login_font">
												密&nbsp;&nbsp;&nbsp;&nbsp;码：
											</td>
											<td width="71%">
											<input  class="loginput" type=password  name=login_password  style="width: 120px"> 
											</td>
										</tr>
										<tr>
											<td width="32%" align="right" class="login_font">
											 登录风格：
											</td>
											<td width="71%">
											<select name=login_style  style="width:125px">
											<option value="common">传统风格</option>
											<!-- option value="mixstyle">混合风格</option>
											<option value="destop">桌面风格</option>
											<option value="leftrigth">左右风格</option>-->
											</select>
											 
											</td>
										</tr>
										 <tr> 
										    <td width="30%" align="right" class="login_font">
												验证码：
											</td>
											<td width="71%" align="left"><input class="loginput"  type="text" name="login_rand" style="width: 120px"></td> 
										</tr> 
										<tr> 
												<td width="30%" align="right" class="login_font">
												</td>
												<td width="70%" valign="middle" align="left"><img alt="code..." name="randImage" id="randImage" src="system/image.jsp" width="60" height="20" border="1" align="absmiddle"> &nbsp <a href="javascript:loadimage();"><font class=login_font>看不清楚</font></a></td> 
										
										</tr>
										<tr>
											<td>
												&nbsp;
											</td>
											<td>
												<input type="image" src="page/image/login_bt.jpg">&nbsp;&nbsp;<input type="image" src="page/image/cancer_bt.jpg">
											  
											</td>
										</tr>
									</table>
								</td>
							<td width="7%">
								&nbsp;
							</td>
							</tr>
							<tr>
								<td height="56" colspan="3">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								
								</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
									广州市申迪计算机系统有限公司技术支持
								</td>
							</tr>
							<%
							String loginMSG=(String)request.getAttribute("loginMSG");
							 if(loginMSG!=null&&loginMSG.trim().length()>0)
							 {
							 %>
							 	<tr>
								<td colspan="3" align="center"><font color=red>
								 <%
								  out.write(loginMSG);
								  %>
								  </font>
						        </td>
							</tr>
							 <%
							 }
							  %>
						</table>
					</td>
				</tr>
			</table>
		</form>

	</body>
</html>