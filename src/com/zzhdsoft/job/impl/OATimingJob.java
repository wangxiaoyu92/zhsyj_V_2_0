package com.zzhdsoft.job.impl;


import com.askj.app.service.SjbService;
import com.askj.jk.service.JkglService;
import com.askj.oa.dto.OanoticemanagerDTO;
import com.askj.oa.dto.OataskDTO;
import com.askj.oa.entity.Oanoticemanager;
import com.askj.oa.entity.Oatask;
import com.askj.oa.service.OaNoticeManagerApiService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.mvc.Mvcs;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * OATimingJob的中文名称：定时发送提醒
 * <p>
 * OATimingJob的描述：
 * <p>
 * Written by :
 */
public class OATimingJob implements Job {

    private static final Logger logger = Logger.getLogger(OATimingJob.class);

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        logger.info("消息提醒任务开始...");
        try {

            OaNoticeManagerApiService oaNoticeManagerApiService = Mvcs.ctx().getDefaultIoc().get(
                    OaNoticeManagerApiService.class);

            oaNoticeManagerApiService.getdsfs();
            oaNoticeManagerApiService.getjshy();
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("消息提醒任务结束...");
    }


}
