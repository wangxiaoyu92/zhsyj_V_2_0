/*
 * 客户关系
 * 
 */
var ioc = { 
	/**
	 * 生产商、供销商和经销商管理
	 */
	khgxModule : {
		type : "com.askj.tmsyj.tmspsc.module.KhgxModule",
		fields : {
			khgxService : {
				refer : 'khgxService'
			}
		}
	},
	khgxService : {
		type : "com.askj.tmsyj.tmspsc.service.KhgxService",
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