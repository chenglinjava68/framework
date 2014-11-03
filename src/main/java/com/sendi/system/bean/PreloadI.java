package com.sendi.system.bean;

import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;

/*
 * 继承该类是为了在系统预加载时使用的，目的是为了减少配置
 * 
 */
public abstract class PreloadI {
	
	  public ApplicationContextHelper applicationContextHelper;
	     /*
	     * 系统日志记录接口
	     */
	    public SysLogHelper sysLogHelper;
	    public SessionFactory sessionFactory;
	    public JdbcTemplate jdbcTemplate;
		
		/*
	     * 实现该方法实现开发过程中自定义的预加载 
	     * 
	     */
	 	public abstract void doLoad();
		public ApplicationContextHelper getApplicationContextHelper() {
			return applicationContextHelper;
		}
		public void setApplicationContextHelper(
				ApplicationContextHelper applicationContextHelper) {
			this.applicationContextHelper = applicationContextHelper;
		}
		public SysLogHelper getSysLogHelper() {
			return sysLogHelper;
		}
		public void setSysLogHelper(SysLogHelper sysLogHelper) {
			this.sysLogHelper = sysLogHelper;
		}

		public SessionFactory getSessionFactory() {
			return sessionFactory;
		}
		public void setSessionFactory(SessionFactory sessionFactory) {
			this.sessionFactory = sessionFactory;
		}
		public JdbcTemplate getJdbcTemplate() {
			return jdbcTemplate;
		}
		public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
			this.jdbcTemplate = jdbcTemplate;
		}
}
