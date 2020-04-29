package com.zzhdsoft.job;

import com.zzhdsoft.SysException;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.SchedulerException;
import org.quartz.impl.StdSchedulerFactory;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 
 * JobListener的中文名称：定时任务构造器
 * 
 * JobListener的描述：
 * 
 * Written by : zjf
 */
public class JobListener implements ServletContextListener {
	private static final Logger logger = Logger.getLogger(JobListener.class);
	private boolean performShutdown = true;
	private Properties jobTask = null;

	public void contextDestroyed(final ServletContextEvent arg0) {
		if (!performShutdown) {
			return;
		}
		try {
			for (Object jobItem : jobTask.keySet()) {
				QuartzManager.removeJob(jobItem.toString());
			}
		} catch (final Exception e) {
			logger.error("Quartz Scheduler failed to shutdown cleanly: "
					+ e.toString());
			e.printStackTrace();
		}

		logger.info("Quartz Scheduler successful shutdown.");
	}

	/*
	 * 概要说明：组装定时任务
	 * 
	 * @param arg0 定时容器
	 */
	public void contextInitialized(final ServletContextEvent sce) {
		logger.info("Quartz Scheduler initializing ...");
		final ServletContext servletContext = sce.getServletContext();
		try {
			final String configFile = servletContext
					.getInitParameter("quartz-config-file");
			final String jobConfigFile = servletContext
					.getInitParameter("job-config-file");
			final String shutdownPref = servletContext
					.getInitParameter("shutdown-on-unload");
			if (shutdownPref != null) {
				performShutdown = Boolean.valueOf(shutdownPref);
			}
			StdSchedulerFactory factory;
			if (configFile != null) {
				factory = new StdSchedulerFactory(configFile);
			} else {
				factory = new StdSchedulerFactory();
			}
			if (jobConfigFile != null) {
				jobTask = initJobConfig(jobConfigFile);
			}

			logger.info("组装定时任务：开始");
			QuartzManager.factory = factory;
			Job job;
			for (Object jobItem : jobTask.keySet()) {
				job = (Job) Class.forName("com.zzhdsoft.job.impl."+jobItem).newInstance();
				QuartzManager.addJob(jobItem.toString(), job,jobTask.getProperty(jobItem.toString()));
			}
			logger.info("组装定时任务：结束");
		} catch (final Exception e) {
			logger.error("Quartz Scheduler failed to initialize: "
					+ e.toString());
			e.printStackTrace();
		}
	}

	private Properties initJobConfig(String fileName){
		Object is = null;
		Properties props = new Properties();
		is = Thread.currentThread().getContextClassLoader().getResourceAsStream(fileName);

		try {
			if(is != null) {
				is = new BufferedInputStream((InputStream)is);
			} else {
				is = new BufferedInputStream(new FileInputStream(fileName));
			}

			props.load((InputStream)is);
		} catch (IOException i) {
			throw new SysException("定时任务配置文件加载失败:job.properties不存在或配置错误",i);
		} finally {
			if(is != null) {
				try {
					((InputStream)is).close();
				} catch (IOException e) {
					;
				}
			}

		}
		return props;
	}

}
