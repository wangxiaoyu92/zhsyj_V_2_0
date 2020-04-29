package com.askj.zdhd;

import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Modules;

/**
 * 
 * ZdhdMainModule的中文名称：【重大活动保障系统】主模块
 *
 * ZdhdMainModule的描述：
 *
 * @author ：zjf 
 * @version ：V1.0
 */
@Modules(scanPackage = true)
@Fail("jsp:/jsp/error/500.jsp")
@Encoding(input = "UTF-8", output = "UTF-8")
public class ZdhdMainModule {

}