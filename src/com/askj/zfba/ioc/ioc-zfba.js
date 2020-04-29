/**
 * 执法办案子系统配置
 */
var ioc = {
	/* 案件登记管理*/
	ajdjModule : {
		type : "com.askj.zfba.module.AjdjModule",
		fields : {
			ajdjService : {
				refer : 'ajdjService'
			}
		}
	},
	ajdjService : {
		type : "com.askj.zfba.service.AjdjService",
		fields : {
			dao : {
				refer : 'dao'
			},
			wsgldyService : {
				refer : 'wsgldyService'
			}
		}
	},
	/* 文书管理打印*/
	wsgldyModule : {
		type : "com.askj.zfba.module.pub.WsgldyModule",
		fields : {
			wsgldyService : {
				refer : 'wsgldyService'
			}
		}
	},
	wsgldyService : {
		type : "com.askj.zfba.service.pub.WsgldyService",
		fields : {
			dao : {
				refer : 'dao'
			},
            pubService:{
                refer:'pubService'
			},
            pcompanyService:{
				refer:'pcompanyService'
			}
		}
	},
	/* 执法办案流程*/
	zfbalcModule : {
		type : "com.askj.zfba.module.pub.ZfbalcModule",
		fields : {
			zfbalcService : {
				refer : 'zfbalcService'
			}
		}
	},
	zfbalcService : {
		type : "com.askj.zfba.service.pub.ZfbalcService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 执法人员管理*/
	pzfryModule : {
		type : "com.askj.zfba.module.PzfryModule",
		fields : {
			pzfryService : {
				refer : 'pzfryService'
			}
		}
	},
	pzfryService : {
		type : "com.askj.zfba.service.PzfryService",
		fields : {
			dao : {
				refer : 'dao'
			},
            pubService :{
				refer :'pubService'
			}
		}
	},
	/*违法行为管理*/
	wfxwModule : {
		type : "com.askj.zfba.module.WfxwModule",
		fields : {
			wfxwService : {
				refer : 'wfxwService'
			}
		}
	},
	wfxwService : {
		type : "com.askj.zfba.service.WfxwService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************文书模板管理************************/
	wsmbglModule : {
		type : "com.askj.zfba.module.WsmbglModule",
		fields : {
			wsmbglService : {
				refer : 'wsmbglService'
			}
		}
	},
	wsmbglService : {
		type : "com.askj.zfba.service.WsmbglService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};
