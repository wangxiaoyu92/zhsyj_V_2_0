/**
 * 安全诚信配置
 */
var ioc = {
    /***************企业诚信************************/
    discreditenterpriseModule : {
        type : "com.askj.aqcx.module.DiscreditenterpriseModule",
        fields : {
            discreditenterpriseService : {
                refer : 'discreditenterpriseService'
            }
        }
    },
    discreditenterpriseService : {
        type : "com.askj.aqcx.service.DiscreditenterpriseService",
        fields : {
            dao : {
                refer : 'dao'
            }
        }

    },
    /***************课程管理************************/
    trustworthinessModule : {
        type : "com.askj.aqcx.module.TrustworthinessModule",
        fields : {
            trustworthinessService : {
                refer : 'trustworthinessService'
            }
        }
    },
    trustworthinessService : {
        type : "com.askj.aqcx.service.TrustworthinessService",
        fields : {
            dao : {
                refer : 'dao'
            }
        }
    }

}