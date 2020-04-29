/*
 * 透明执法
 * 
 */
var ioc = { 
	/**
	 * 【透明执法】api接口
	 */
	tmzfApiModule : {
		type : "com.askj.tmsyj.tmzf.module.TmzfApiModule",
		fields : {
			tmzfApiService : {
				refer : 'tmzfApiService'
			}
		}
	},
	tmzfApiService : {
		type : "com.askj.tmsyj.tmzf.service.TmzfApiService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};