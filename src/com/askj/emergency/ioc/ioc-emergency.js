/**
 * 应急指挥子系统配置文件
 */
var ioc = {
    emergencyModule : {
        type : "com.askj.emergency.module.EmergencyModule",
        fields : {
            emergencyService : {
                refer : 'emergencyService'
            }
        }
    },
    emergencyApiModule : {
        type : "com.askj.emergency.module.EmergencyApiModule",
        fields : {
            emergencyService : {
                refer : 'emergencyService'
            }
        }
    },
    emergencyService : {
        type : "com.askj.emergency.service.EmergencyService",
        fields : {
            dao : {
                refer : 'dao'
            }
        }
    }
};