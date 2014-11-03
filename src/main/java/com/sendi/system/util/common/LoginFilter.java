package com.sendi.system.util.common;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

 /**
  * @author liujinghua  
  * 日期：2014-05-14 时间：上午09:36:48
  * 查用户是否登录，防止未登录就使用系统资源
  */
public class LoginFilter implements Filter {

	/*
	 * 通过传入默认初始化参数决定拦截与否
	 */
	public boolean islogfilter=false;
	private String isLogBehaviour = "off";
	private ApplicationContext ac = null;
	private ServletContext sc = null;
	//public LoginInfo loginInfo;
	public void destroy() {
	 

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain arg2) throws IOException, ServletException {
		
		 HttpServletRequest req=(HttpServletRequest)request;
		 HttpServletResponse rep=(HttpServletResponse)response;
		 String ctx=req.getContextPath();
		 String uri=req.getRequestURI();
		 String userName = null;
		 if(req.getSession().getAttribute("username") != null)
			 userName = req.getSession().getAttribute("username").toString();
		 
		 
		 if("on".equals(isLogBehaviour)){
			 String ip=(String)sc.getAttribute("sendi_sys_host_address_ip");
		  		System.out.println("push ok............徐磊测试.............."+ip);
		  	// 	if(ip != null
		  	 //			&& (ip.indexOf("127.0.0.1")!=-1)){  //这个地址才做记录,也即46
		  	 		//logBehaviour(userName,uri);
		  	 //	}
		 }
		 if(islogfilter){
		     boolean isdvalidate=false;
		     if(uri.equals(ctx+"/")
		    		 || uri.equals(ctx+"/index.jsp")
		    		 || uri.equals(ctx+"/loginController.do")
		    		 || uri.equals(ctx+"/login.jsp")
		    		 || uri.equals(ctx+"/system/modipwd.jsp")
		    		 || uri.equals(ctx+"/testController.do")){
		    	 isdvalidate=true;
		     }
		     else{
		    	 if(req.getSession().getAttribute("username")!=null
		    			 && req.getSession().getAttribute("username").toString().length()>0){
		    		 isdvalidate=true;
		    	 }
		     }
		     if(uri.indexOf("image.jsp")>0)
		     {
		    	 isdvalidate=true;
		     }
		     if(isdvalidate){
		    	 arg2.doFilter(request, response);
		     }
		     else{
		    	 
		    	 rep.sendRedirect(ctx+"/index.jsp");
		     }
		     
		 }
		 else{
			 arg2.doFilter(request, response);
		 }
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		String logfilter=filterConfig.getInitParameter("logfilter");  //取值为off,on
		if(logfilter!=null&&logfilter.equalsIgnoreCase("on"))
		{
			islogfilter=true;
		}
		try{
			sc = filterConfig.getServletContext();
			ac = WebApplicationContextUtils.getWebApplicationContext(filterConfig.getServletContext());
			//serviceSupportImp = (ServiceSupportImp)ac.getBean("serviceSupportImp");
			
			HashMap<String,String> configs = (HashMap<String,String>)sc.getAttribute("sendi_sys_config_para");
			if(configs != null
					&& configs.get("sys_islogbehaviour") != null){
				isLogBehaviour = configs.get("sys_islogbehaviour");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
/*	private void logBehaviour(String userName,String reqUri){
		try{
//			System.out.println("reqUri:"+reqUri);
			String url = dealWithUrl(reqUri);
			loginInfo=(LoginInfo) ac.getBean("loginInfo");
			BehaviourHelper behaviourHelper =(BehaviourHelper) ac.getBean("behaviourHelper");
			if(userName != null 
					&& loginInfo != null 
					&& url != null
					&& serviceSupportImp != null
					&& behaviourHelper != null){
				System.out.println("...........测试logbehaviour..................");
				behaviourHelper.logBehaviour(url, userName, loginInfo);
			}
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}
*/	
	private String dealWithUrl(String url){
		String u = url;
		if(url != null && url.length() > 0){
			if(url.indexOf("?") > -1){
				u = url.substring(0, url.indexOf("?"));
				System.out.println("reqUri:"+url);
				System.out.println("uri:"+u);
			}
		}
		return u;
	}
}
