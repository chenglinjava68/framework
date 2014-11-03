package com.sendi.system.quaztz;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.hibernate.SessionFactory;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobListener;

import com.sendi.system.bean.ApplicationContextHelper;
import com.sendi.system.bean.SysLogHelper;

public class TJobListener implements JobListener {

	public ApplicationContextHelper applicationContextHelper;
	/*
	 * 系统日志记录接口
	 */
	public SysLogHelper sysLogHelper;
	public SessionFactory sessionFactory;

	public SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

	public TJobListener(ApplicationContextHelper applicationContextHelper,
			SysLogHelper sysLogHelper, SessionFactory sessionFactory) {
		super();
		this.applicationContextHelper = applicationContextHelper;
		this.sysLogHelper = sysLogHelper;
		this.sessionFactory = sessionFactory;
	}

	public TJobListener() {
	}

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

	public String getName() {

		return "wanglangjoblistener";
	}

	public void jobExecutionVetoed(JobExecutionContext arg0) {

	}

	public void jobToBeExecuted(JobExecutionContext arg0) {
		arg0.getJobDetail().getJobDataMap()
				.put("job_start_time", sdf.format(new Date()));

	}

	public void jobWasExecuted(JobExecutionContext arg0,
			JobExecutionException arg1) {
		JobDetail jd = arg0.getJobDetail();
		/*this.sysLogHelper.LogJobhistory(jd.getDescription(), jd.getJobDataMap()
				.getString("job_start_time"), sdf.format(new Date()), jd
				.getName(), jd.getGroup());*/

	}

}
