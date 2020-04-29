/**
 * 重大活动
 */
var ioc = {
	zdhdModule : {
		type : "com.askj.zdhd.module.ZdhdModule",
		fields : {
			zdhdService : {
				refer : 'zdhdService'
			}
		}
	},
	zdhdService : {
		type : "com.askj.zdhd.service.ZdhdService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};