/**
 * 环境信息--土壤信息配置文件
 */
var ioc = {
	envSoilInfoModule : {
		type : "com.askj.environment.module.EnvSoilInfoModule",
		fields : {
			envSoilInfoService : {
				refer : 'envSoilInfoService'
			}
		}
	},
	envSoilInfoService : {
		type : "com.askj.environment.service.EnvSoilInfoService",
		fields : {
			dao : {
				refer : 'dao'
			}
	     }
	},
	envAirInfoModule : {
		type : "com.askj.environment.module.EnvAirInfoModule",
			fields : {
			envAirInfoService : {
				refer : 'envAirInfoService'
			}
		}
	},
	envAirInfoService : {
		type : "com.askj.environment.service.EnvAirInfoService",
			fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	envWalterInfoModule : {
		type : "com.askj.environment.module.EnvWalterInfoModule",
		fields : {
			envWalterInfoService : {
				refer : 'envWalterInfoService'
			}
		}
	},
	envWalterInfoService : {
		type : "com.askj.environment.service.EnvWalterInfoService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};