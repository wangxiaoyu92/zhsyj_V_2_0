package com.zzhdsoft.job.impl;

import com.askj.jk.service.JkglService;
import org.apache.log4j.Logger;
import org.nutz.mvc.Mvcs;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
/**
 * 
 * SyncFromMCLZJob的中文名称：同步数据定时任务
 * 
 * SyncFromMCLZJob的描述：
 * 
 * Written by : sunyifeng
 */
public class SyncFromMCLZJob implements Job {
	private static final Logger logger = Logger.getLogger(SyncFromMCLZJob.class);

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		logger.info("同步明厨亮灶监控数据任务开始...");
		JkglService jkglService = Mvcs.ctx().getDefaultIoc().get(
				JkglService.class);
		jkglService.saveOrUpdatePcompanyImport(null);
		int[] flag = new int[]{1,1};
		jkglService.updatePcompanyImportComid(flag);
		logger.info("同步明厨亮灶监控数据任务结束...");
		jkglService.addlddk("2016060618182112726397442");//李富国
		//jkglService.addlddk("2016060709441825389408921");//lcc
	}
}
