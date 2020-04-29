package com.zzhdsoft.job.impl;

import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import java.util.Calendar;
import java.util.HashMap;

/**
 * 
 * ClearSessionJob的中文名称：清除会话定时任务
 * 
 * ClearSessionJob的描述：
 * 
 * Written by : sunyifeng
 */
public class ClearSessionJob implements Job {
	private static final Logger logger = Logger.getLogger(ClearSessionJob.class);

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		logger.info("清除会话任务开始...");
		operateClearSessionContextForOverTime();
		logger.info("清除会话任务结束...");

	}
	private void operateClearSessionContextForOverTime() {
		HashMap<String, String[]> cache = SysmanageUtil.getSessionContext();
		for(String key:cache.keySet()){
			if(Calendar.getInstance().getTimeInMillis()-Long.parseLong(cache.get(key)[1])>80000){
				cache.remove(key);
				logger.debug("清除缓存sessionid="+key+"成功！");
			}
		}
	}

}
