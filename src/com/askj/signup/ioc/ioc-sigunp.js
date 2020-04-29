/**
 * 注册报名考试
 */

var ioc = {
		/**************注册*************************/
		signupModule:{
			type :"com.askj.signup.module.SignupModule",
			fields : {
				signupService:{
					refer:'signupService'
				}
			}
		},
		signupService:{
			type :"com.askj.signup.service.SignupService",
			fields : {
				dao : {
					refer : 'dao'
				}
			}
		},
};