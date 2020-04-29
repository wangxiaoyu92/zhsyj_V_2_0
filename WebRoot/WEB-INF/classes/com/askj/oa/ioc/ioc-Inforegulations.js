/**
* 信息上报数量设置模块配置
*/
var ioc = {
inforegulationsModule : {
        type : "com.askj.oa.module.InforegulationsModule",
        fields : {
inforegulationsService : {
                refer : 'inforegulationsService'
            }
        }
    },
inforegulationsService : {
        type : "com.askj.oa.service.InforegulationsService",
        fields : {
            dao : {
                refer : 'dao'
            }
        }
    }
};
