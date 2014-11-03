package com.sendi.system.util.common;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.sendi.system.bean.ApplicationContextHelper;
import com.sendi.system.bean.SysLogHelper;

/**
 * 全局拦截器，目前用于，用户操作记录sys_action_log
 * @author liujinghua
 * 日期: 2014-05-18 晚上 19:21
 *
 */
public class ActionLogInterceptor implements HandlerInterceptor{
	
	@Autowired
	private ApplicationContextHelper applicationContextHelper;
	
	@Autowired
	private SysLogHelper sysLogHelper;
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		return true;
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler, ModelAndView modelAndView) throws Exception {
	}
	
	/**
	 * 在sys_actionlog_conf表中如果配置了操作的跟踪，加入日志内容
	 */
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//注解掉了，现在啥 也不做
	}
	
	private String getRequestParameters(HttpServletRequest request) 
    {
    	String str="";
        Enumeration<String> e = request.getParameterNames();
        String parameterName, parameterValue;
        while(e.hasMoreElements())
        {
            parameterName = e.nextElement();
            parameterValue = request.getParameter(parameterName);
            str=str+(parameterName + ":" + parameterValue + " | ");            
        }
        
        int maxSize = 200; //最大支持200个字符串
        if(str.length()>maxSize) str = StringUtils.substring(str, 0, maxSize);
        return str;
    }
}
