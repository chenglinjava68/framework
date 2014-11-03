<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.sendi.system.constants.Globals"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="t" uri="/easyui-tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
		String path = request.getContextPath();
		//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+Globals.Port+path;
	    String  serverip=request.getServerName();
	    HashMap<String,String> sendi_sys_config_para;
        Object o=application.getAttribute("sendi_sys_config_para");
        String sys_config_string="{}";
        if(o!=null)
		{
		  sendi_sys_config_para=(HashMap<String,String>)o;
		  sys_config_string=JSONObject.fromObject(sendi_sys_config_para).toString();
		 
		}
        
        //easyui皮肤设置
        Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
        Cookie[] cookies = request.getCookies();
        if (null != cookies) {
        	for (Cookie cookie : cookies) {
        		cookieMap.put(cookie.getName(), cookie);
        	}
        }
        String easyuiTheme = "default";//指定如果用户未选择样式，那么初始化一个默认样式
        if (cookieMap.containsKey("easyuiTheme")) {
        	Cookie cookie = (Cookie) cookieMap.get("easyuiTheme");
        	easyuiTheme = cookie.getValue();
        }
        String uiVersion = "easyui1.4";//版本目录文件夹
 %>
<link id="easyuiTheme" rel="stylesheet" type="text/css" href="${ctx}/<%=uiVersion%>/themes/<%=easyuiTheme%>/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/<%=uiVersion%>/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${ctx}/<%=uiVersion%>/my.css">
<link rel="stylesheet" type="text/css" href="${ctx}/<%=uiVersion%>/style/syExtIcon.css">
<link rel="stylesheet" type="text/css" href="${ctx}/<%=uiVersion%>/style/syExtCss.css">
<script type="text/javascript" src="${ctx}/<%=uiVersion%>/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/<%=uiVersion%>/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/<%=uiVersion%>/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/<%=uiVersion%>/jslib/syExtEasyUI.js"></script>
<script type="text/javascript" src="${ctx}/<%=uiVersion%>/jslib/syExtJavascript.js"></script>
<script type="text/javascript" src="${ctx}/<%=uiVersion%>/jslib/syExtJquery.js"></script>
<script type="text/javascript">
  //for global use
  var contextRootPath = "${ctx}";
  var userName="<%=session.getAttribute("username")%>";
  var user_id="<%=session.getAttribute("userid")%>";
  var userid_tablekey="<%=session.getAttribute("userid_tablekey")%>";
  var role_id="<%=session.getAttribute("roleid")%>";
  var fullpath="<%=basePath%>";
  var serverip="<%=serverip%>";
  var sendi_sys_config_para=<%=sys_config_string%>;
  var current_session_id="<%=session.getId()%>";
  
  var sy = sy || {};
  sy.pixel_0 = '${ctx}/<%=uiVersion%>/style/images/pixel_0.gif';//0像素的背景，一般用于占位
  
</script>
