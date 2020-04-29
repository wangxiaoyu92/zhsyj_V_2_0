/**
 * 手机接口配置
 */
var ioc = {
	sjbModule : {
		type : "com.askj.app.module.SjbModule",
		fields : {
			sjbService : {
				refer : 'sjbService'
			},
			supervisionApiModule : {
				refer : 'supervisionApiModule'
			},
			supervisionOldApiModule : {
				refer : 'supervisionOldApiModule'
			},
			ncjtjcApiModule : {
				refer : 'ncjtjcApiModule'
			},
			wsgldyService : {
				refer : 'wsgldyService'
			},
			sysorgService : {
				refer : 'sysorgService'
			},
			pubService : {
				refer : 'pubService'
			},
			emergencyService : {
				refer : 'emergencyService'
			},
			pcompanyService : {
				refer : 'pcompanyService'
			},
			jkglService : {
				refer : 'jkglService'
			},
			sysuserService : {
				refer : 'sysuserService'
			},
			pcomryService :{
				refer : 'pcomryService'
			},
			pzfryService :{
				refer : 'pzfryService'
			}
		}
	},
	pcomryService :{
		type : "com.askj.baseinfo.service.PcomryService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	pzfryService : {
		type : "com.askj.zfba.service.PzfryService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	sjbService : {
		type : "com.askj.app.service.SjbService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	supervisionApiModule : {
		type : "com.askj.supervision.module.SupervisionApiModule",
		fields : {
			supervisionApiService : {
				refer : 'supervisionApiService'
			},
			checkHandlerService:{
				refer : 'checkHandlerService'
			},
			checkResultService:{
				refer : 'checkResultService'
			}
		}
	},
	supervisionOldApiModule : {
		type : "com.askj.supervision.module.SupervisionOldApiModule",
		fields : {
			supervisionApiService : {
				refer : 'supervisionApiService'
			},
			checkHandlerService:{
				refer : 'checkHandlerService'
			},
			checkTbodyService : {
				refer : 'checkTbodyService'
			},
			checkForNcjtjcService:{
				refer : 'checkForNcjtjcService'
			}
		}
	},
	supervisionApiService : {
		type : "com.askj.supervision.service.SupervisionApiService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	checkTbodyService : {
		type : "com.askj.supervision.service.CheckTbodyService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	checkForNcjtjcService : {
		type : "com.askj.supervision.service.CheckForNcjtjcService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	checkResultService : {
		type : "com.askj.supervision.service.CheckResultService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
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
	},
	csglService : {
		type : "com.askj.ncjtjc.service.CsglService",
		fields : {
			dao : {
				refer : 'dao'
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
	jcglService : {
		type : "com.askj.ncjtjc.service.JcglService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};
