/**
 * 极光推送配置
 */
var ioc = {
	jpushModule : {
		type : "com.zzhdsoft.mvc.jpush.JpushModule",
		fields : {
			jpushService : {
				refer : 'jpushService'
			}
		}
	},
	jpushService : {
		type : "com.zzhdsoft.siweb.service.jpush.JpushService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};