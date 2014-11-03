/*
 * Created on Sep 21, 2006
 * 
 * This class is a simple Job which prints out execution time with its trigger's name
 */
package com.sendi.system.quaztz;

import java.util.Date;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.sendi.system.bean.ApplicationContextHelper;

/**
 */
public class TestQuartzJob implements Job {

    public TestQuartzJob() {
    }

    public void execute(JobExecutionContext context) throws JobExecutionException {
    	ApplicationContextHelper applicationContextHelper =(ApplicationContextHelper )context.getJobDetail().getJobDataMap().get("applicationContextHelper");
    	String a=(String)applicationContextHelper.servletContext.getAttribute("sendi_tetranm_back_dir");
    	//Runtime.getRuntime().exec("");
        System.out.println( new Date() + "  by " + context.getTrigger().getName()+" "+context.getJobDetail().getDescription()+"  "+context.getJobDetail().getName());
       try {
		Thread.currentThread().sleep(3000);
	} catch (InterruptedException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    }
}
