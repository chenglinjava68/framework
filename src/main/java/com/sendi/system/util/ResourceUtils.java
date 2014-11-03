package com.sendi.system.util;

import java.util.ResourceBundle;

/**
 * @author liujinghua
 * 2014-08-26
 */
public class ResourceUtils {

	private static final ResourceBundle bundle = java.util.ResourceBundle.getBundle("application");
	
	/**
	 * 获取配置文件参数
	 * @param name
	 * @return
	 */
	public static final String getConfigByName(String name) {
		return bundle.getString(name);
	}
	
	public static void main(String[] args) {
		System.out.println(ResourceUtils.getConfigByName("tomcat_port"));
	}

	
}
