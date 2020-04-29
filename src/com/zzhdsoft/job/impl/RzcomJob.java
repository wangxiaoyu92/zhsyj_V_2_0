package com.zzhdsoft.job.impl;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.mvc.Mvcs;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.askj.baseinfo.service.PcompanyService;
import com.lbs.leaf.cache.LeafCache;
/**
 * 
 * SyncFromMCLZJob的中文名称：同步数据定时任务
 * 
 * SyncFromMCLZJob的描述：
 * 
 * Written by : sunyifeng
 */
public class RzcomJob implements Job {
	private static final Logger logger = Logger.getLogger(RzcomJob.class);

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		logger.info("汝州数据导入任务开始...");
		ServletContext application = LeafCache.getAppContext();
		
		org.nutz.mvc.ActionContext v_context=org.nutz.mvc.Mvcs.getActionContext(); 
		HttpServletRequest v_request = v_context.getRequest();
		
		PcompanyService v_service = Mvcs.ctx().getDefaultIoc().get(
				PcompanyService.class);
		try {
			v_service.RuZhouComDataRuku(v_request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.info("汝州数据导入任务结束...");
	}
}
