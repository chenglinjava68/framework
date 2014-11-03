package com.sendi.system.bean;

import javax.servlet.ServletContext;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

/**
 * @author liujinghua
 */
@Component
public class ApplicationContextHelper implements ApplicationContextAware,ServletContextAware {
  public static ApplicationContext appctx;
  public static ServletContext servletContext;
	public void setApplicationContext(
			org.springframework.context.ApplicationContext arg0)
			throws BeansException {
		this.appctx=arg0;
	 }

	public void setServletContext(ServletContext sc) {
		 this.servletContext=sc;
 	}
	
	

}
