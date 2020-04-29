package com.zzhdsoft.mvc;

import com.askj.animal.AnimalMainModule;
import com.askj.aqcx.AqcxMainModule;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.IocBy;
import org.nutz.mvc.annotation.Modules;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.SetupBy;
import org.nutz.mvc.ioc.provider.ComboIocProvider;
import com.askj.app.AppMainModule;
import com.askj.baseinfo.BaseinfoMainModule;
import com.askj.emergency.EmergercyMainModule;
import com.askj.environment.EnvironmentMainModule;
import com.askj.exam.ExamMainModule;
import com.askj.jk.JkMainModule;
import com.askj.jyjc.JyjcMainModule;
import com.askj.ncjtjc.NcjtjcMainModule;
import com.askj.oa.OaMainModule;
import com.askj.signup.SignupMainModule;
import com.askj.spsy.SpsyMainModule;
import com.askj.supervision.SupervisionMainModule;
import com.askj.tmsyj.TmSyjMainModule;
import com.askj.train.TrainMainModule;
import com.askj.zdhd.ZdhdMainModule;
import com.askj.zfba.ZfbaMainModule;
import com.askj.zx.ZxMainModule;

/**
 * 
 * MainModule的中文名称：【系统平台】主模块
 *
 * MainModule的描述：
 *
 * @author ：zjf 
 * @version ：V1.0
 */
@SetupBy(MainSetup.class)
@IocBy(type = ComboIocProvider.class, args = {
		"*js","com/zzhdsoft/ioc/","com/askj/",
		"*anno","com.zzhdsoft.mvc",
		"*async",
		"*tx"})
@Modules(value={
		BaseinfoMainModule.class,
		SupervisionMainModule.class,
		ZfbaMainModule.class,
		JyjcMainModule.class,
		ZxMainModule.class,
		JkMainModule.class,
		NcjtjcMainModule.class,
		EmergercyMainModule.class,
		OaMainModule.class,
		SpsyMainModule.class,
		ZdhdMainModule.class,
		EnvironmentMainModule.class,
		TrainMainModule.class,
		ExamMainModule.class,
		TmSyjMainModule.class,
		AppMainModule.class,
		SignupMainModule.class,
		AqcxMainModule.class,
		AnimalMainModule.class

},scanPackage = true)
@Ok("json:full")
@Fail("jsp:/jsp/error/500.jsp")
@Encoding(input = "UTF-8", output = "UTF-8")
@Filters(@By(type = SafetyFilter.class))
public class MainModule {

}