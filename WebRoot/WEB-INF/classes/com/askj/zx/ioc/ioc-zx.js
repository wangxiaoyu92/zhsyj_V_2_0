/**
 * 征信子系统配置
 */
var ioc = {
	/* 征信 */
	businessCodeModule : {
		type : "com.askj.zx.module.BusinessCodeModule",
		fields : {
			businessCodeService : {
				refer : 'businessCodeService'
			}
		}
	},
	businessCodeService : {
		type : "com.askj.zx.service.BusinessCodeService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}, 
	
	
	/*诚信公示*/
	integrityPubModule : {
		type : "com.askj.zx.module.IntegrityPubModule",
		fields : {
			integrityPubService : {
				refer : 'integrityPubService'

			}
		}
	},
	integrityPubService : {
		type : "com.askj.zx.service.IntegrityPubService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/*诚信评估*/
	 integrityAssessModule : {
		type : "com.askj.zx.module.IntegrityAssessModule",
		fields : {
			integrityassessService : {
				refer : 'integrityassessService'
			}
		}
	},
	integrityassessService : {
		type : "com.askj.zx.service.IntegrityassessService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 信息采集 */
	zxpdcjxxModule : {
		type : "com.askj.zx.module.ZxpdcjxxModule",
		fields : {
			zxpdcjxxService : {
				refer : 'zxpdcjxxService'
			}
		}
	},
	zxpdcjxxService : {
		type : "com.askj.zx.service.ZxpdcjxxService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	} ,
	
	/**
	 * 征信评定
	 */
	zxpdjgModule:{
		type : "com.askj.zx.module.ZxpdjgModule",
		fields : {
			zxpdjgService : {
				refer : 'zxpdjgService'
			}
		}
	},
	zxpdjgService : {
		type : 'com.askj.zx.service.ZxpdjgService',
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	
	/**
	 * 征信评定等级参数维护
	 */
	zxpddjcsModule : {
		type : 'com.askj.zx.module.ZxpddjcsModule',
		fields : {
			zxpddjcsService : {
				refer : 'zxpddjcsService',
			}
		}
	},
	zxpddjcsService :{
		type : 'com.askj.zx.service.ZxpddjcsService',
		fields :{
			dao :{
				refer :'dao'
			}
		}
	},
	/**
	 * 手机端征信接口
	 */
	zxApiModule : {
		type : 'com.askj.zx.module.ZxApiModule',
		fields : {
			zxpdjgService : {
				refer : 'zxpdjgService',
			}
		}
	} 
};