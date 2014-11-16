package com.sendi.system.constants;

import com.sendi.system.util.ResourceUtils;

/**
 * 系统中全局常量名称
 * @author liujinghua
 * @DATE 2014-05-15 早上11:30
 */
public class Globals {
	
	/****系统模块使用的全局变量开始************************************/
	public static final String Syssendi_system_title="sendi_system_title";
	public static final String Syssendi_sys_config_para="sendi_sys_config_para";
	public static final String Syssendi_sys_proload_info="sendi_sys_proload_info";
	public static final String Syssendi_sys_host_address_ip="sendi_sys_host_address_ip";
	public static final String Syssendi_sys_host_name_hostname="sendi_sys_host_name_hostname";
	public static final String Scheduler = "scheduler";
	public static final String UserButtonOperations = "userButtonOperations";//用户功能权限信息
	public static final String EhCacheName = "dictcache";//缓存的名称
	public static final String Port = ResourceUtils.getConfigByName("tomcat_port");//全局应用端口变量
	public static final String DICDATA_CACHE = "dictcache";//数据字典表的缓存变量名称
	//保存session中
	public static final String Sesusername="username";
	public static final String Sesuserid="userid";
	/****系统模块使用的全局变量开始************************************/
	

	/****业务模块使用的全局变量开始************************************/
	public static final String UPLOAD = "/upload";//文件上传的目录
	
	/****业务模块使用的全局变量结束************************************/
}
