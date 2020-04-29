/*
 * 透明餐饮
 * 
 */
var ioc = {
		
	/**
	 * 【透明餐饮子系统】api接口
	 */
	tmcyApiModule : {
		type : "com.askj.tmsyj.tmcy.module.TmcyApiModule",
		fields : {
			tmcyApiService : {
				refer : 'tmcyApiService'
			},
			hcycdService : {
				refer : 'hcycdService' // 透明餐饮管理
			}

		}
	},
	tmcyApiService : {
		type : "com.askj.tmsyj.tmcy.service.TmcyApiService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},	
	/**
	 * 菜品、一周菜谱、食品留样、餐具清洗记录
	 */
	hcycdModule : {
		type : "com.askj.tmsyj.tmcy.module.HcycdModule",
		fields : {
			hcycdService : {
				refer : 'hcycdService'
			}
		}
	},
	hcycdService : {
		type : "com.askj.tmsyj.tmcy.service.HcycdService",
		fields : {
			dao : {
				refer : 'dao'
			}
		} 
	}
};