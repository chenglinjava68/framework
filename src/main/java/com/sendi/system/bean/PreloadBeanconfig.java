package com.sendi.system.bean;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TimeZone;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.sendi.system.constants.Globals;
import com.sendi.system.entity.SysConfigPara;
import com.sendi.system.entity.SysProloadConf;

/**
 * 类描述：系统启动加载项类
 * 
 * @author liujinghua
 * @date： 日期：2014-05-14 时间：上午10:30:48 系统需要在启动时预加载的数据都尽量在这里配置 push bean 配置 的预加载
 *        系统外部socket 接口的配置 目前对于用户信息，角色信息，模块信息，设备信息都放在这里加载， 对于各模块中可能出现的更新，则重新加载
 *        ，模块信息则非常重新加载，则是更新，通过内存查询进行更新，而不是重做
 *        但如果这种操作太频繁，则会影响系统的性能，因此，想法是开发阶段，进行此类动作，当进行生产阶段时，可以选择通过重启
 *        或者以后开发的系统命令功能，发送相关重载命令即可
 * */
public class PreloadBeanconfig {
	
	@Autowired
	public ApplicationContextHelper applicationContextHelper;
	
	@Autowired
	public SysLogHelper sysLogHelper;
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private HashMap<String, String> sysconfigpara = new HashMap<String, String>();
	private HashMap<String, SysProloadConf> sysPreloadMap = new HashMap<String, SysProloadConf>();

	public void init() {
		try {
			initBeanMap();
			// 运行预加载类
			executePreloadBean();
			// //启动socket服务
			//initSocketServer();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void initBeanMap() throws Exception {

		Session session = sessionFactory.openSession();

		String hql3 = "from SysConfigPara";
		List datas3 = session.createQuery(hql3).list();
		for (Object o3 : datas3) {
			SysConfigPara sib = (SysConfigPara) o3;
			sysconfigpara.put(sib.getParaName(), sib.getParaValue());
			if (sib.getParaName().equals(Globals.Syssendi_system_title)) // 系统标题做为默认值放到servletContext中
			{
				applicationContextHelper.servletContext.setAttribute(Globals.Syssendi_system_title, sib.getParaValue());
			}
		}

		applicationContextHelper.servletContext.setAttribute(Globals.Syssendi_sys_config_para, sysconfigpara);

		//8、/加载预加载类
		loadSysProloadConf(session);
		
		session.close();
		
		///加载服务器地址
		applicationContextHelper.servletContext.setAttribute(Globals.Syssendi_sys_host_address_ip, InetAddress.getLocalHost().getHostAddress());
		applicationContextHelper.servletContext.setAttribute(Globals.Syssendi_sys_host_name_hostname, InetAddress.getLocalHost().getHostName());
		
		// 设置默认的系统时区
		// TimeZone tz=TimeZone.getDefault();
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Shanghai"));

	}
	
	//8、/加载预加载类
	public void loadSysProloadConf(Session session){
		String hql8 = "from SysProloadConf";
		List datas8 = session.createQuery(hql8).list();
		for (Object o8 : datas8) {
			SysProloadConf slb = (SysProloadConf) o8;
			sysPreloadMap.put(slb.getId() + "", slb);
		}
		applicationContextHelper.servletContext.setAttribute(Globals.Syssendi_sys_proload_info, sysPreloadMap);
	}
	
	public void executePreloadBean() {
		//运行所有预加载的类 -- 必须先执行initBeanMap，否则更新初始化无效
		 Iterator<String> it2=sysPreloadMap.keySet().iterator();
		 while(it2.hasNext())
		 {
			 try
			 {
				 String key=it2.next();
				 SysProloadConf o= sysPreloadMap.get(key);
				 PreloadI c=(PreloadI)Class.forName(o.getInterfacecalss()).newInstance();
				 c.setApplicationContextHelper(applicationContextHelper);
				 c.setSysLogHelper(sysLogHelper);
				 c.setSessionFactory(sessionFactory);
				 c.setJdbcTemplate(jdbcTemplate);
				 c.doLoad(); 
			 }
			 catch (Exception e) {
				 e.printStackTrace();
			}
			
	 	 }
		 //运行所有预加载的类
	}

	public void reloadConfig(){
		try{
			initBeanMap();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

	public void setApplicationContextHelper(
			ApplicationContextHelper applicationContextHelper) {
		this.applicationContextHelper = applicationContextHelper;
	}
}
