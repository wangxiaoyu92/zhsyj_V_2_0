/**
 * 食品溯源子系统配置
 */
var ioc = {
	/* 范围外企业管理*/
	comoutModule : {
		type : "com.askj.spsy.module.ComoutModule",
		fields : {
			comoutService : {
				refer : 'comoutService'
			}
		}
	},
	comoutService : {
		type : "com.askj.spsy.service.ComoutService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 范围外企业产品管理*/
	productoutModule : {
		type : "com.askj.spsy.module.ProductoutModule",
		fields : {
			productoutService : {
				refer : 'productoutService'
			},
			comoutService : {
				refer : 'comoutService'
			}			
		}
	},
	productoutService : {
		type : "com.askj.spsy.service.ProductoutService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/*食品生产加工溯源*/
	foodProductModule : {
		type : "com.askj.spsy.module.FoodProductModule",
		fields : {
			foodProductService : {
				refer : 'foodProductService'
			}
		}
	},
	foodProductService : {
		type : "com.askj.spsy.service.FoodProductService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 范围内企业产品管理*/
	productinModule : {
		type : "com.askj.spsy.module.ProductinModule",
		fields : {
			productinService : {
				refer : 'productinService'
			}, 		
		}
	},
	productinService : {
		type : "com.askj.spsy.service.ProductinService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},	
	
	/* 产品耗材管理*/
	cphcModule : {
		type : "com.askj.spsy.module.CphcModule",
		fields : {
			cphcService : {
				refer : 'cphcService'
			}, 		
		}
	},
	cphcService : {
		type : "com.askj.spsy.service.CphcService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},	
	
	/* 食品溯源对外接口*/
	spsyApiModule : {
		type : "com.askj.spsy.module.SpsyApiModule",
		fields : {
			spsyApiService : {
				refer : 'spsyApiService'
			}, 		
		}
	},
	spsyApiService : {
		type : "com.askj.spsy.service.SpsyApiService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}				
	
};
