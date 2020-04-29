/**
 * 检验检测系统配置文件
 */
var ioc = {
		jyjcModule : {
			type : "com.askj.jyjc.module.JyjcModule",
			fields : {
				jyjcService : {
					refer : 'jyjcService'
				}
			}
		},
		jyjcService : {
			type : "com.askj.jyjc.service.JyjcService",
			fields : {
				dao : {
					refer : 'dao'
				},
				pubService : {
					refer : 'pubService'
				}					
		     }
		},
		jyjcApiModule : {
			type : "com.askj.jyjc.module.JyjcApiModule",
			fields : {
				jyjcService : {
					refer : 'jyjcService'
				},
				pubService : {
					refer : 'pubService'
				},
				tmsyjService : {
					refer : 'tmsyjService'
				},
				sysuserService : {
					refer : 'sysuserService'
				}
			}
		}
};