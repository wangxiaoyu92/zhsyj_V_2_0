/**
 * 监控子系统配置
 */
var ioc = {
	/**
	 * 监控管理
	 */
	jkglModule : {
		type : "com.askj.jk.module.JkglModule",
		fields : {
			jkglService : {
				refer : 'jkglService'
			}
		}
	},
	jkglService : {
		type : "com.askj.jk.service.JkglService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};