/**
 * 系统管理配置
 */
var ioc = {

	apiModule : {
		type : "com.zzhdsoft.mvc.bridge.ApiModule",
		fields : {
			authApi : {
				refer : 'authApi'
			}
		}
	},
	authApi : {
		type : "com.zzhdsoft.bridge.api.server.AuthApi"
	},

	/* 用户注册(暂时不用) */
	userregModule : {
		type : "com.zzhdsoft.mvc.sysmanager.UserregModule",
		fields : {
			userregService : {
				refer : 'userregService'
			}
		}
	},
	userregService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.UserregService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 用户登录 */
	loginModule : {
		type : "com.zzhdsoft.mvc.sysmanager.LoginModule",
		fields : {
			loginService : {
				refer : 'loginService'
			}
		}
	},
	loginService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.LoginService",
		fields : {
			dao : {
				refer : 'dao'
			},
			sysfunctionService : {
				refer : 'sysfunctionService'
			}
		}
	},
	/* 用户管理 */
	sysuserModule : {
		type : "com.zzhdsoft.mvc.sysmanager.SysuserModule",
		fields : {
			sysuserService : {
				refer : 'sysuserService'
			}
		}
	},
	sysuserService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.SysuserService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 角色管理 */
	sysroleModule : {
		type : "com.zzhdsoft.mvc.sysmanager.SysroleModule",
		fields : {
			sysroleService : {
				refer : 'sysroleService'
			},
			sysfunctionService : {
				refer : 'sysfunctionService'
			}
		}
	},
	sysroleService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.SysroleService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 机构管理 */
	sysorgModule : {
		type : "com.zzhdsoft.mvc.sysmanager.SysorgModule",
		fields : {
			sysorgService : {
				refer : 'sysorgService'
			}
		}
	},
	sysorgService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.SysorgService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 菜单管理 */
	sysfunctionModule : {
		type : "com.zzhdsoft.mvc.sysmanager.SysfunctionModule",
		fields : {
			sysfunctionService : {
				refer : 'sysfunctionService'
			}
		}
	},
	sysfunctionService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.SysfunctionService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 系统参数管理 */
	sysparamModule : {
		type : "com.zzhdsoft.mvc.sysmanager.SysparamModule",
		fields : {
			sysparamService : {
				refer : 'sysparamService'
			}
		}
	},
	sysparamService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.SysparamService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 系统公用功能 */
	sysCommonFunModule : {
		type : "com.zzhdsoft.mvc.sysmanager.SysCommonFunModule",
		fields : {
			sysCommonFunService : {
				refer : 'sysCommonFunService'
			}
		}
	},
	sysCommonFunService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.SysCommonFunService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 系统操作日志管理 */
	sysoperatelogModule : {
		type : "com.zzhdsoft.mvc.sysmanager.SysoperatelogModule",
		fields : {
			sysoperatelogService : {
				refer : 'sysoperatelogService'
			}
		}
	},
	sysoperatelogService : {
		type : "com.zzhdsoft.siweb.service.sysmanager.SysoperatelogService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 工作流管理 */
	workflowModule : {
		type : "com.zzhdsoft.mvc.workflow.WorkflowModule",
		fields : {
			workflowService : {
				refer : 'workflowService'
			}


		}
	},
	/* 工作流api */
	workflowAPIModule : {
		type : "com.zzhdsoft.mvc.workflow.WorkflowAPIModule",
		fields : {
			workflowService : {
				refer : 'workflowService'
			},
			ajdjService: {
				refer : 'ajdjService'
			},
			archiveService: {
				refer : 'archiveService'
			}
		}
	},

	workflowService : {
		type : "com.zzhdsoft.siweb.service.workflow.WorkflowService",
		fields : {
			dao : {
				refer : 'dao'
			},
			wsgldyService : {
				refer : 'wsgldyService'
			},
			jpushService : {
				refer : 'jpushService'
			}
		}
	},
	ajdjService : {
		type : "com.askj.zfba.service.AjdjService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	archiveService : {
		type : "com.askj.oa.service.ArchiveService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 新闻分类管理 */
	newsCateModule : {
		type : "com.zzhdsoft.mvc.news.NewsCateModule",
		fields : {
			newsCateService : {
				refer : 'newsCateService'
			}
		}
	},
	newsCateService : {
		type : "com.zzhdsoft.siweb.service.news.NewsCateService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 新闻管理 */
	newsModule : {
		type : "com.zzhdsoft.mvc.news.NewsModule",
		fields : {
			newsService : {
				refer : 'newsService'
			}
		}
	},
	newsService : {
		type : "com.zzhdsoft.siweb.service.news.NewsService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/* 新闻管理手机端 */
	newsApiModule : {
		type : "com.zzhdsoft.mvc.news.NewsApiModule",
		fields : {
			newsService : {
				refer : 'newsService'
			}
		}
	},

	/* 新闻管理手机端 */
	docApiModule : {
		type : "com.zzhdsoft.mvc.DocApiModule"
	}
};
