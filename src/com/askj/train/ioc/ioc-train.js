/**
 * 培训子系统配置
 */
var ioc = {
	/***************课件管理************************/
	coursewareModule : {
		type : "com.askj.train.module.CoursewareModule",
		fields : {
			coursewareService : {
				refer : 'coursewareService'
			}
		}

	},
	coursewareService : {
		type : "com.askj.train.service.CoursewareService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************课程管理************************/
	courseModule : {
		type : "com.askj.train.module.CourseModule",
		fields : {
			courseService : {
				refer : 'courseService'
			}
		}
	},
	courseService : {
		type : "com.askj.train.service.CourseService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************教师管理************************/
	teacherModule : {
		type : "com.askj.train.module.TeacherModule",
		fields : {
			teacherService : {
				refer : 'teacherService'
			}
		}
	},
	teacherService : {
		type : "com.askj.train.service.TeacherService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	},
	/***************手机端接口************************/
	trainApiModule : {
		type : "com.askj.train.module.TrainApiModule",
		fields : {
			trainApiService : {
				refer : 'trainApiService'
			},
			coursewareService : { // 课件
				refer : 'coursewareService'
			},
			courseService : { // 课程
				refer : 'courseService'
			}
		}
	},
	trainApiService : {
		type : "com.askj.train.service.TrainApiService",
		fields : {
			dao : {
				refer : 'dao'
			}
		}
	}
};
