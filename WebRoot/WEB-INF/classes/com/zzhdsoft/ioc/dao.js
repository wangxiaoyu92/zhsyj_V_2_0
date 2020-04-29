/**
 * 数据库连接池配置
 */
var ioc = {
	config : {
		type : "org.nutz.ioc.impl.PropertiesProxy",
		fields : {
			paths : [ "config.properties" ]
		}
	},
	dataSource : {
		//type : "org.apache.commons.dbcp.BasicDataSource",
		type : "com.alibaba.druid.pool.DruidDataSource",
		events : {
			create : "init",
			depose : "close"
		},
		fields : {
			driverClassName : {
				java : "$config.get('db_driver')"
			},
			url : {
				java : "$config.get('db_url')"
			},
			username : {
				java : "$config.get('db_user')"
			},
			password : {
				java : "$config.get('db_password')"
			},
			testWhileIdle : true,// 非常重要,预防mysql的8小时timeout问题
			validationQuery : {
				java : "$config.get('db_validationQuery')"
			},
			maxActive : {
				java : "$config.get('db_maxActive')"
			},
			filters : "mergeStat",//带合并的sql状态过滤器
			connectionProperties : "druid.stat.slowSqlMillis=2000",//如果sql执行超过2秒,就输出日志
			maxWait : "60000"
		}
	},
	dao : {
		type : 'org.nutz.dao.impl.NutDao',
		args : [ {
			refer : 'dataSource'
		} ]
	},	
	trans:{
		type : 'org.nutz.aop.interceptor.TransactionInterceptor'
	},	
	dataModule: {
		type : "com.zzhdsoft.mvc.DataModule",
		fields : {
			dataServiceImpl : {
				refer : 'dataServiceImpl'
			}
		}
	},	
	dataServiceImpl: {
		type : "com.zzhdsoft.siweb.service.DataServiceImpl",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},	
	procedureUtil: {
		type : "com.zzhdsoft.utils.db.ProcedureUtil",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};
