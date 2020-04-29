/*
 * 透明食药监
 * 
 */
var ioc = {
	/**
	 * 【透明食药监】api接口
	 */
	tmsyjApiModule : {
		type : "com.askj.tmsyj.tmsyj.module.TmsyjApiModule",
		fields : {
			tmsyjApiService : {
				refer : 'tmsyjApiService'
			},
			pcomryService : {
				refer : 'pcomryService' // 企业人员管理
			},
			khgxService : {
				refer : 'khgxService' // 企业客户关系管理
			},
			jyjcService : {
				refer : 'jyjcService' // 企业商品管理
			},
			tmsyjService : {
				refer : 'tmsyjService' // 企业进销货管理
			},
            jkglService : {
                refer : 'jkglService' // 监控管理
            }
			//pcompanyService:{
			//	refer : 'pcompanyService' // 监控管理
			//}
		}
	},
	tmsyjApiService : {
		type : "com.askj.tmsyj.tmsyj.service.TmsyjApiService",
		fields : {
			dao : {
				refer : 'dao'
			},
			pcompanyService : {
				refer : 'pcompanyService' // 企业管理
			},
			pubService : {
				refer : 'pubService'
			}
		}
	},
	/**
	 * 【透明食药监】接口
	 */
	tmsyjModule : {
		type : "com.askj.tmsyj.tmsyj.module.TmsyjModule",
		fields : {
			tmsyjService : {
				refer : 'tmsyjService'
			}
		}
	},
	tmsyjService : {
		type : "com.askj.tmsyj.tmsyj.service.TmsyjService",
		fields : {
			dao : {
				refer : 'dao'
			},
			pubService : {
				refer : 'pubService'
			}				
		}
	},

	wanBangModule : {
		type : "com.askj.tmsyj.tmsyj.module.WanBangModule",
		fields : {
			wanBangService : {
				refer : 'wanBangService'
			}
		}
	},
	wanBangService : {
		type : "com.askj.tmsyj.tmsyj.service.WanBangService"
	}
};