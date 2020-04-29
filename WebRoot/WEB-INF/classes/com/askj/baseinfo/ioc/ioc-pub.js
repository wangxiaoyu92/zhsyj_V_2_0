/**
 * 系统级模块配置
 */
var ioc = {
	/* 子系统间的公共东西 */
	pubModule : {
		type : "com.askj.baseinfo.module.pub.pubModule",
		fields : { 
			pubService : {
				refer : 'pubService'
			},
			sysorgService : {
				refer : 'sysorgService'
			}			
		}
	},
	pubService : {
		type : "com.askj.baseinfo.service.pub.PubService",
		fields : {
			dao : {
				refer : 'dao'
			},
	        pcompanyService:{
	        	refer:'pcompanyService'
	        }
		}
	},
	pubLcFormModule : {
		type : "com.askj.baseinfo.module.pub.PubLcFormModule"  
	}, 
	/***********企业基本信息*****************/
	pcompanyModule : {
		type : "com.askj.baseinfo.module.PcompanyModule",
		fields : {
			pcompanyService : {
				refer : 'pcompanyService'
			}
		}
	},
	pcompanyService : {
		type : "com.askj.baseinfo.service.PcompanyService",
		fields : {
			dao : {
				refer : 'dao'
			},
			pubService : {
                refer : 'pubService'
            }
        }
	},
	/***********企业人员信息********************/
	pcomryModule : {
		type : "com.askj.baseinfo.module.PcomryModule",
		fields : {
			pcomryService : {
				refer : 'pcomryService'
			}
		}
	},
	pcomryService : {
		type : "com.askj.baseinfo.service.PcomryService",
		fields : {
			dao : {
				refer : 'dao'
			},
			pubService : {
				refer : 'pubService'
			}			
		}
	},
	/***********法律法规信息********************/
	pflfgModule : {
		type : "com.askj.baseinfo.module.PflfgModule",
		fields : {
			pflfgService : {
				refer : 'pflfgService'
			}
		}
	},
	pflfgService : {
		type : "com.askj.baseinfo.service.PflfgService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/******************法律法规***************************/
	omLawModule : {
		type : "com.askj.baseinfo.module.OmLawModule",
		fields : {
			omLawService : {
				refer : 'omLawService'
			}
		}
	},
	omLawService : {
		type : "com.askj.baseinfo.service.OmLawService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}

};
