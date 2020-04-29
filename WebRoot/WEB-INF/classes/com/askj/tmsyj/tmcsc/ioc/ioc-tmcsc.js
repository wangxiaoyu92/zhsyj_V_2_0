/*
 * 透明菜市场
 * 
 */
var ioc = { 
	/**
	 * 市场分区和商户
	 */
	scfqHshModule : {
		type : "com.askj.tmsyj.tmcsc.module.ScfqHshModule",
		fields : {
			scfqHshService : {
				refer : 'scfqHshService'
			}
		}
	},
	scfqHshService : {
		type : "com.askj.tmsyj.tmcsc.service.ScfqHshService",
		fields : {
			dao : {
				refer : 'dao'
			},
	        pcompanyService:{
	        	refer:'pcompanyService'
	        }			
		}
	}
};