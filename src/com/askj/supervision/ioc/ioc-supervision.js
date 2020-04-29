/**
 * 食药监管系统配置文件
 */
var ioc = {
		/**
		 * 检查基本信息管理
		 */
		checkInfoModule : {
			type : "com.askj.supervision.module.CheckInfoModule",
			fields : {
				checkInfoService : {
					refer : 'checkInfoService'
				}
			}
		},
		checkInfoService : {
			type : "com.askj.supervision.service.CheckInfoService",
			fields : {
				dao : {
					refer : 'dao'
				}
		     }
		},
		/**
		 * 检查计划管理
		 */
		checkPlanModule : {
			type : "com.askj.supervision.module.CheckPlanModule",
			fields : {
				checkPlanService : {
					refer : 'checkPlanService'
				}
			}
		},
		checkPlanService : {
			type : "com.askj.supervision.service.CheckPlanService",
			fields : {
				dao : {
					refer : 'dao'
				},
                checkInfoService:{
					refer:'checkInfoService'
				}
		     }
		},
		/**
		 * 检查结果管理
		 */
		checkResultModule : {
			type : "com.askj.supervision.module.CheckResultModule",
			fields : {
				checkHandlerService : {
					refer : 'checkHandlerService'
				},
				checkResultService : {
					refer : 'checkResultService'
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
		checkHandlerService : {
			type : "com.askj.supervision.service.CheckHandlerService",
			fields : {
				dao : {
					refer : 'dao'
				}
		     }
		},
		/**
		 * 检查结果统计
		 */
		checkPalnResultReportModule : {
			type : "com.askj.supervision.module.CheckPalnResultReportModule",
			fields : {
				checkHandlerService : {
					refer : 'checkHandlerService'
				}
			}
		},
		/**
		 * 检查结果表格
		 */
		checkTbodyInfoModule : {
			type : "com.askj.supervision.module.CheckTbodyInfoModule",
			fields : {
				checkTbodyService : {
					refer : 'checkTbodyService'
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

		/** 企业溯源监管**/
		companySySuperModule : {
			type : "com.askj.supervision.module.CompanySySuperModule",
			fields : {
				companySySuperService : {
					refer : 'companySySuperService'
				}
			}
		},
		companySySuperService : {
			type : "com.askj.supervision.service.CompanySySuperService",
			fields : {
				dao : {
					refer : 'dao'
				}
		     }
		},
		/**
		 * 量化分级
		 */
		lhfjModule : {
			type : "com.askj.supervision.module.LhfjModule",
			fields : {
				lhfjService : {
					refer : 'lhfjService'
				}
			}
		},
		lhfjService : {
			type : "com.askj.supervision.service.LhfjService",
			fields : {
				dao : {
					refer : 'dao'
				}
			}
		},
	   areaConditionModule : {
		type : "com.askj.supervision.module.AreaConditionModule",
		fields : {
			areaConditionService : {
				refer : 'areaConditionService'
			}
		}
	   },
	areaConditionService : {
		type : "com.askj.supervision.service.AreaConditionService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
		/**
		 * 检查管理
		 */
		aqjcglModule : {
			type : "com.askj.supervision.module.AqjcglModule",
			fields : {
				aqjcglService : {
					refer : 'aqjcglService'
				},
				checkHandlerService : {
					refer : 'checkHandlerService'
				},
				supervisionApiService : {
					refer : 'supervisionApiService'
				}
			}
		},
		aqjcglService : {
			type : "com.askj.supervision.service.AqjcglService",
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
		supervisionApiService : {
			type : "com.askj.supervision.service.SupervisionApiService",
			fields : {
				dao : {
					refer : 'dao'
				}
			}
		},
		/**
		 * 检查依据管理
		 */
		checkBasisModule : {
			type : "com.askj.supervision.module.CheckBasisModule",
			fields : {
				checkBasisService : {
					refer : 'checkBasisService'
				}
			}
		},
		checkBasisService : {
			type : "com.askj.supervision.service.CheckBasisService",
			fields : {
				dao : {
					refer : 'dao'
				}
		     }
		}
};