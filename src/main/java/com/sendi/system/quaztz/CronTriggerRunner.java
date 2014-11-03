 
package com.sendi.system.quaztz;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;
import org.quartz.CronExpression;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.SimpleTrigger;
import org.quartz.impl.StdSchedulerFactory;

import com.sendi.system.bean.PreloadI;
import com.sendi.system.constants.Globals;
import com.sendi.system.entity.SysJobInterface;

public class CronTriggerRunner extends PreloadI {
 
	private static Log logger=LogFactory.getLog(CronTriggerRunner.class);
	@Override
	public void doLoad() {
		 try
		 {
			 HashMap<String,String> sysconfigpara=( HashMap<String,String>)this.applicationContextHelper.servletContext.getAttribute("sendi_sys_config_para");
			 if(sysconfigpara==null)return;
			 
			  String sendi_system_scheduler_host=sysconfigpara.get("sendi_system_scheduler_host");
			  String localaddr=(String)this.applicationContextHelper.servletContext.getAttribute("sendi_sys_host_address_ip");
			  logger.info("----crontab localaddress:"+localaddr+" | configaddress:"+sendi_system_scheduler_host);
			  if(sendi_system_scheduler_host==null) return;
			  
			  if(!localaddr.equals(sendi_system_scheduler_host)) return;  //只有配置为本机器该执行时，定时任务才会加载执行
			  
		        SchedulerFactory schedulerFactory = new StdSchedulerFactory();
		      
		        Scheduler scheduler = schedulerFactory.getScheduler();
		       
		        Session session = this.sessionFactory.openSession();
		        List datas= session.createQuery("from SysJobInterface where isactive ='on'").list();
		        int count=0;
		        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
		        for(Object o:datas)
		        {
		        	SysJobInterface sysjob=(SysJobInterface)o;
		        	Class<Job> t=(Class<Job>) Class.forName(sysjob.getInterfacecalss());
		            if(sysjob.getJobtype().equals("s")) // 简单任务
		            {
		                 JobDetail jobDetail = new JobDetail(sysjob.getInterfaceid(),"simple", t);
		                    jobDetail.getJobDataMap().put("sessionFactory",this.sessionFactory);
			   		        jobDetail.getJobDataMap().put("applicationContextHelper",this.applicationContextHelper);
			   		        jobDetail.getJobDataMap().put("sysLogHelper",this.sysLogHelper);
		                SimpleTrigger simpleTrigger = new SimpleTrigger("CronTrigger"+sysjob.getInterfaceid(), "CronTriggergroupsimple");
		                simpleTrigger.setStartTime(sdf.parse(sysjob.getJobstartTime()));
		                simpleTrigger.setRepeatInterval(sysjob.getJobRepeatInterval());
		                simpleTrigger.setRepeatCount(sysjob.getJobRepeatcount());
		                scheduler.scheduleJob(jobDetail, simpleTrigger);
		             }
		            else //cron express任务 
		            {
		            	//10个任务为1组
		            	JobDetail jobDetail = new JobDetail(sysjob.getInterfaceid(), "complicate",t);
		   		        jobDetail.setDescription(sysjob.getDescription());
		   		        jobDetail.getJobDataMap().put("sessionFactory",this.sessionFactory);
		   		        jobDetail.getJobDataMap().put("applicationContextHelper",this.applicationContextHelper);
		   		        jobDetail.getJobDataMap().put("sysLogHelper",this.sysLogHelper);
		   		        jobDetail.addJobListener("wanglangjoblistener");
		   		     
		   		        CronTrigger cronTrigger = new CronTrigger("CronTrigger"+sysjob.getInterfaceid(), "CronTriggergroup");
		   		       
		   		        try {
		   		        	 CronExpression cexp = new CronExpression(sysjob.getCronexpression());
		   		             cronTrigger.setCronExpression(cexp);
		   		             scheduler.scheduleJob(jobDetail, cronTrigger);
		   		        } catch (Exception e) {
		   		            e.printStackTrace();
		   		        }
		   		        
		   		        
		            }
		            count++;
		         }
		        
		        session.close();
		    
		        scheduler.addJobListener(new TJobListener(this.applicationContextHelper,this.sysLogHelper,this.sessionFactory));
		        scheduler.start();
		        this.applicationContextHelper.servletContext.setAttribute(Globals.Scheduler, scheduler);
		        
		 }
		 catch (Exception e) {
			 e.printStackTrace();
		}
 }
     
}
