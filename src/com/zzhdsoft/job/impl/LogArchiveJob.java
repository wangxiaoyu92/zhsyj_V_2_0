package com.zzhdsoft.job.impl;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.beanutils.BasicDynaBean;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * 
 * LogArchiveJob的中文名称：操作日志归档定时任务
 * 
 * LogArchiveJob的描述：
 * 
 * Written by : zjf
 */
public class LogArchiveJob implements Job {
	private static final Logger logger = Logger.getLogger(LogArchiveJob.class);

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
//		Date lastRunTime = new Date(context.getPreviousFireTime().getTime());
//		Date thisRunTime = new Date(context.getFireTime().getTime());
		logger.info("开始执行日志归档任务...");
		// logger.info("日志归档...");
//		 archive(lastRunTime, thisRunTime);
		// logger.info("日志归档完成.");
		// logger.info("过期日志清理...");
		 clean();
		// logger.info("过期日志清理完成.");
		logger.info("日志归档任务执行结束.");
	}

	private void archive(Date lastRunTime, Date thisRunTime) {
		Date fromtime = archiveFromDate(lastRunTime);
		Date totime = archiveToDate(thisRunTime);
		if (fromtime.before(totime)) {
			String extname = todayYYYYMMDD();
			
//			operateLogArchive(extname, fromtime, totime);
			
		}
	}

	private void operateLogArchive(String extName, Date fromtime, Date totime) {
		logger.info("操作日志归档...");
		String tableName = "SYSOPERATELOG_ARC_" + extName;
		String sql = "select count(*) isexist from all_tables where table_name = '"
				+ tableName + "'";
		Map retMap = new HashMap();//
		List exist = (List) retMap.get("rows");
		if (exist != null && exist.size() > 0) {
			BasicDynaBean bdb = (BasicDynaBean) exist.get(0);
			Object tempo = bdb.get("isexist");
			if (tempo != null && "1".equals(tempo.toString())) {
				logger.warn("删除已存在的表" + tableName);
				// long records = pst.executeSQLDelete(sb.toString());
			}
		}
		StringBuffer sb = new StringBuffer();
		sb.append("create table ").append(tableName);
		sb.append(" as select * from SYSOPERATELOG where ");
		sb.append(" starttime between ");
		sb.append(getDbDate(fromtime));
		sb.append(" and ");
		sb.append(getDbDate(totime));
		logger.debug("操作日志归档:" + sb);
		// long records = pst.executeSQLUpdate(sb.toString());
		logger.info("操作日志归档完成.");
	}

	private void clean() {
		logger.info("操作日志清理...");
		operateLogClean();
		logger.info("操作日志清理完成.");
	}

	private void operateLogClean() {
		String cleanDate = "";
		StringBuffer hql = new StringBuffer();
		hql.append("delete Operatelog where starttime < ");
		hql.append(getDbDate(cleanDate));
		// pst.executeUpdate(hql.toString());
	}

	private Date archiveFromDate(Date lastRunTime) {
		Calendar now = Calendar.getInstance();
		if (lastRunTime != null) {
			now.setTime(lastRunTime);
		} else {
			int month = now.get(2) - 1;
			int year = now.get(1);
			for (; month < 0; month += 12)
				year--;

			now.set(1, year);
			now.set(2, month);
		}
		now.set(5, 1);
		now.set(11, 0);
		now.set(12, 0);
		now.set(13, 0);
		return new Date(now.getTimeInMillis());
	}

	private Date archiveToDate(Date thisRunTime) {
		Calendar now = Calendar.getInstance();
		now.setTime(thisRunTime);
		now.set(5, 1);
		now.set(11, 0);
		now.set(12, 0);
		now.set(13, 0);
		return new Date(now.getTimeInMillis());
	}

	private int compareStrAsDate(String date, String maxArcTime) {
		Calendar c1 = Calendar.getInstance();
		c1.setTimeInMillis(0L);
		c1.set(1, Integer.parseInt(date.substring(0, 4)));
		c1.set(2, Integer.parseInt(date.substring(5, 7)));
		Calendar c2 = Calendar.getInstance();
		c2.setTimeInMillis(0L);
		c2.set(1, Integer.parseInt(maxArcTime.substring(0, 4)));
		c2.set(2, Integer.parseInt(maxArcTime.substring(5, 7)));
		return c1.getTime().compareTo(c2.getTime());
	}

	private String todayYYYYMMDD() {
		Calendar now = Calendar.getInstance();
		int year = now.get(1);
		int month = now.get(2) + 1;
		int date = now.get(5);
		String yearStr = (new Integer(year)).toString();
		String monthStr = (new Integer(month)).toString();
		String dateStr = (new Integer(date)).toString();
		if (monthStr.length() == 1)
			monthStr = "0" + monthStr;
		if (dateStr.length() == 1)
			dateStr = "0" + dateStr;
		String time = yearStr + monthStr + dateStr;
		return time;
	}

	private String getDbDate(Date time) {
		String dbDate = "to_date('" + getString(time)
				+ "','YYYY-MM-DD HH24:MI:SS')";
		return dbDate;
	}

	private String getDbDate(String time) {
		String dbDate = "to_date('" + time + "','YYYY-MM-DD HH24:MI:SS')";
		return dbDate;
	}

	private String getString(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}

}
