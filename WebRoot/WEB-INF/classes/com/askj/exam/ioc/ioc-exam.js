/**
 * 考试子系统配置
 */
var ioc = {
	/***************试题管理************************/
	questionModule : {
		type : "com.askj.exam.module.QuestionModule",
		fields : {
			questionService : {
				refer : 'questionService'
			}
		}
	},
	questionService : {
		type : "com.askj.exam.service.QuestionService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************试卷管理************************/
	paperModule : {
		type : "com.askj.exam.module.PaperModule",
		fields : {
			paperService : {
				refer : 'paperService'
			}
		}
	},
	paperService : {
		type : "com.askj.exam.service.PaperService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************考试管理************************/
	examsModule : {
		type : "com.askj.exam.module.ExamsModule",
		fields : {
			examsService : {
				refer : 'examsService'
			}
		}
	},
	examsService : {
		type : "com.askj.exam.service.ExamsService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************考试结果管理************************/
	resultModule : {
		type : "com.askj.exam.module.ResultModule",
		fields : {
			resultService : {
				refer : 'resultService'
			}
		}
	},
	resultService : {
		type : "com.askj.exam.service.ResultService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************练习管理************************/
	practiseModule : {
		type : "com.askj.exam.module.PractiseModule",
		fields : {
			practiseService : {
				refer : 'practiseService'
			}
		}
	},
	practiseService : {
		type : "com.askj.exam.service.PractiseService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************手机端接口************************/
	examApiModule : {
		type : "com.askj.exam.module.ExamApiModule",
		fields : {
			examApiService : {
				refer : 'examApiService'
			},
			questionService : { // 试题
				refer : 'questionService'
			},
			examsService : { // 考试
				refer : 'examsService'
			},
			resultService : { // 考试结果
				refer : 'resultService'
			},
			practiseService : { // 练习
				refer : 'practiseService'
			}
		}
	},
	examApiService : {
		type : "com.askj.exam.service.ExamApiService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};
