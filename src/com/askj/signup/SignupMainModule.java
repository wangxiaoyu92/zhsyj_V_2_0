package com.askj.signup;

import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Modules;


/**
 * 
 * SignupMainModule的中文名称：【注册报名】主模块 
 *
 * SignupMainModule的描述：
 *
 * @author ：wcl 
 * @version ：V1.0
 */
@Modules(scanPackage = true)
@Fail("jsp:/jsp/error/500.jsp")
@Encoding(input = "UTF-8", output = "UTF-8")
public class SignupMainModule {

}