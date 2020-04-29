/**
 * 农村集体聚餐监管子系统配置
 */
var ioc = {
	/**
	 * 厨师管理
	 */
	csglModule : {
		type : "com.askj.ncjtjc.module.CsglModule",
		fields : {
			csglService : {
				refer : 'csglService'
			}
		}
	},
	csglService : {
		type : "com.askj.ncjtjc.service.CsglService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/**
	 * 两员管理
	 */
	lyglModule : {
		type : "com.askj.ncjtjc.module.LyglModule",
		fields : {
			lyglService : {
				refer : 'lyglService'
			}
		}
	},
	lyglService : {
		type : "com.askj.ncjtjc.service.LyglService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/**
	 * 聚餐管理
	 */
	jcglModule : {
		type : "com.askj.ncjtjc.module.JcglModule",
		fields : {
			jcglService : {
				refer : 'jcglService'
			}
		}
	},
	jcglService : {
		type : "com.askj.ncjtjc.service.JcglService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/**
	 * 手机端接口
	 */
	ncjtjcApiModule : {
		type : "com.askj.ncjtjc.module.NcjtjcApiModule",
		fields : {
			ncjtjcApiService : {
				refer : 'ncjtjcApiService'
			},
			csglService : {
				refer : 'csglService'
			},
			jcglService : {
				refer : 'jcglService'
			},
			lyglService : {
				refer : 'lyglService'
			}
		}
	},
	ncjtjcApiService : {
		type : "com.askj.ncjtjc.service.NcjtjcApiService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};