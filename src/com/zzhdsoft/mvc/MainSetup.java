package com.zzhdsoft.mvc;

import java.nio.charset.Charset;
import org.nutz.dao.Dao;
import org.nutz.ioc.Ioc;
import org.nutz.ioc.impl.PropertiesProxy;
import org.nutz.lang.Encoding;
import org.nutz.lang.Mirror;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.NutConfig;
import org.nutz.mvc.Setup;
import org.nutz.mvc.view.UTF8JsonView;
import org.quartz.Scheduler;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * MainSetup的中文名称：Nutz内核初始化
 * 
 * MainSetup的描述：【启动入口】
 * 
 * @author ：zjf
 * @version ：V1.0
 */
public class MainSetup implements Setup {
	private static final Log log = Logs.get();

	public void init(NutConfig nutConfig) {
		System.out.println("Nutz Service Start!!!");
		UTF8JsonView.CT = "text/plain";

		// 检查环境
		if (!Charset.defaultCharset().name().equalsIgnoreCase(Encoding.UTF8)) {
			log.warn("This project must run in UTF-8, pls add -Dfile.encoding=UTF-8 to JAVA_OPTS");
		}
		
		// 获取Ioc容器及Dao对象
		Ioc ioc = nutConfig.getIoc();
		Dao dao = ioc.get(Dao.class);
		
		// 获取配置对象
		PropertiesProxy config = ioc.get(PropertiesProxy.class, "config");
		/**
		if (dao.meta().isMySql()) {
			String schema = dao.execute(Sqls.fetchString("SELECT DATABASE()")).getString();
			// 检查所有非日志表,如果表引擎是MyISAM,切换到InnoDB
			Sql sql = Sqls.queryString("SELECT TABLE_NAME FROM information_schema.TABLES where TABLE_SCHEMA = @schema and engine = 'MyISAM'");
			sql.params().set("schema", schema);
			for (String tableName : dao.execute(sql).getObject(String[].class)) {
				if (tableName.startsWith("t_syslog"))
					continue;
				dao.execute(Sqls.create("alter table " + tableName + " ENGINE = InnoDB"));
			}
		}*/

		// 1、初始化代码表
		SysmanageUtil.initAa10Map();
		// 1、初始化统筹区表
		// SysmanageUtil.initAa13Map();
		// 2、初始化全局配置
		GlobalConfig.init();
		// 3、初始化sql配置
		// GlobalConfig.initSqlConf();

		// 4初始化代码表zfajzfwsmbfgcs执法文书模板覆盖参数
		try {
			SysmanageUtil.initZfwsmbfgcsMap();
			SysmanageUtil.initGlobalVariable();
			SysmanageUtil.initGlobalSysUserList();//初始化系统中除企业虚拟用户外所有用户gu20170915
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public void destroy(NutConfig nutConfig) {
		System.out.println("Nutz Service Stop!!!");
		// 非mysql数据库,或多webapp共享mysql驱动的话,以下语句删掉
//		try {
//			Mirror.me(Class.forName("com.mysql.jdbc.AbandonedConnectionCleanupThread")).invoke(null, "shutdown");
//		} catch (Throwable e) {
//		}
		// 解决quartz有时候无法停止的问题
//		try {
//			nutConfig.getIoc().get(Scheduler.class).shutdown(true);
//		} catch (Exception e) {
//		}
	}
}