package com.zzhdsoft.job.impl;

import com.alibaba.fastjson.JSONObject;
import com.askj.jk.service.JkglService;
import com.zzhdsoft.siweb.dto.ParamDTO;
import com.zzhdsoft.siweb.dto.ResultDTO;
import com.zzhdsoft.siweb.service.DataServiceImpl;
import com.zzhdsoft.siweb.service.IDataService;
import org.apache.log4j.Logger;
import org.nutz.mvc.Mvcs;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 
 * SyncFromMCLZJob的中文名称：同步数据定时任务
 * 
 * SyncFromMCLZJob的描述：
 * 
 * Written by : sunyifeng
 */
public class SignInJob implements Job {
	private static final Logger logger = Logger.getLogger(SignInJob.class);
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		logger.info("清算考勤签到信息任务开始...");
		IDataService ids = Mvcs.ctx().getDefaultIoc().get(
				DataServiceImpl.class);
		ParamDTO param = new ParamDTO();
		param.setSql("prc_sign_in");
		param.setT("PROC");
		Date date = new Date();
		JSONObject json = new JSONObject();
		json.put("prm_date",sdf.format(date));
		json.put("prm_AppCode","");
		json.put("prm_AppCode","");
		param.setParam(json.toJSONString());
		ResultDTO  rs = (ResultDTO)ids.query(param);
		logger.error("==============...Result="+rs.getResult().get(0) +",msg="+rs.getMsg());
		logger.info("清算考勤签到信息任务结束...");
	}
}
