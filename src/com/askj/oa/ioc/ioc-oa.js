/**
 * 公文管理--传阅信息配置文件
 */
var ioc = {
	testAPi : {
		type : "com.askj.oa.module.TestAPi",

	},
	circulationPaperModule : {
		type : "com.askj.oa.module.CirculationPaperModule",
		fields : {
			circulationPaperService : {
				refer : 'circulationPaperService'
			}
		}
	},
	circulationPaperService : {
		type : "com.askj.oa.service.CirculationPaperService",
		fields : {
			dao : {
				refer : 'dao'
			}
	     }
	},
	//公文流转
	archiveModule : {
		type : "com.askj.oa.module.ArchiveModule",
		fields : {
			archiveService : {
				refer : 'archiveService'
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
	//工作台账表
	egWorkTaskModule : {
		type : "com.askj.oa.module.EgWorkTaskModule",
		fields : {
            egWorkTaskService : {
				refer : 'egWorkTaskService'
			}
		}
	},
    egWorkTaskService : {
		type : "com.askj.oa.service.EgWorkTaskService",
		fields : {
			dao : {
				refer : 'dao'
			},
            pubService : {
                refer : 'pubService'
            },
            sjbService : {
                refer : 'sjbService' // 极光推送
            },
            oaNoticeManagerApiService : {
                refer : 'oaNoticeManagerApiService' // 消息通知
            }
		}
	},
	//Oa任务
	oataskApiModule : {
		type : "com.askj.oa.module.OataskApiModule",
		fields : {
            oataskApiService : {
            	refer : 'oataskApiService'
			}
		}
	},
    oataskApiService : {
		type : "com.askj.oa.service.OataskApiService",
		fields : {
			dao : {
				refer : 'dao'
			},
			sjbService : {
				refer : 'sjbService' // 极光推送
			},
            oaNoticeManagerApiService : {
				refer : 'oaNoticeManagerApiService' // 消息通知
			}
		}
	},
	// Oa会议
    oameetApiModule : {
        type : "com.askj.oa.module.OameetApiModule",
        fields : {
            oameetApiService : {
                refer : 'oameetApiService'
            }
        }
    },
    oameetApiService : {
        type : "com.askj.oa.service.OameetApiService",
        fields : {
            dao : {
                refer : 'dao'
            },
            sjbService : {
                refer : 'sjbService' // 极光推送
            },
            oaNoticeManagerApiService : {
            	refer : 'oaNoticeManagerApiService' // 消息通知
			}
        }
    },
	// Oa日程
    oascheduleApiModule : {
        type : "com.askj.oa.module.OascheduleApiModule",
        fields : {
            oascheduleApiService : {
                refer : 'oascheduleApiService'
            }
        }
    },
    oascheduleApiService : {
        type : "com.askj.oa.service.OascheduleApiService",
        fields : {
            dao : {
                refer : 'dao'
            },
            sjbService : {
                refer : 'sjbService' // 极光推送
            },
            oaNoticeManagerApiService : {
            	refer : 'oaNoticeManagerApiService' // 消息通知
			}
        }
    },
	// OA消息通知
    // oascheduleApiModule : {
     //    type : "com.askj.oa.module.OascheduleApiModule",
     //    fields : {
     //        oascheduleApiService : {
     //            refer : 'oascheduleApiService'
     //        }
     //    }
    // },
    oaNoticeManagerApiService : {
        type : "com.askj.oa.service.OaNoticeManagerApiService",
        fields : {
            dao : {
                refer : 'dao'
            },
            sjbService : {
                refer : 'sjbService' // 极光推送
            }
        }
    },
	//稽查工作汇报
	jcgzhbModule : {
		type : "com.askj.oa.module.JcgzhbModule",
		fields : {
			jcgzhbService : {
				refer : 'jcgzhbService'
			}
		}
	},
	jcgzhbService : {
		type : "com.askj.oa.service.JcgzhbService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
    //稽查工作汇报
    oaemailModule : {
        type : "com.askj.oa.module.OaemailModule",
        fields : {
            oaemailService : {
                refer : 'oaemailService'
            }
        }
    },
    oaemailService : {
        type : "com.askj.oa.service.OaemailService",
        fields : {
            dao : {
                refer : 'dao'
            }
        }
    }
}