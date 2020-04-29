package com.askj.animal;

import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Modules;

/**
 *
 * AnimalMainModule的中文名称：【动物管理】主模块
 *
 * AnimalMainModule的描述：
 *
 * @author ：zk
 * @version ：V1.0
 */
@Modules(scanPackage = true)

@Fail("jsp:/jsp/error/500.jsp")
@Encoding(input = "UTF-8", output = "UTF-8")
public class AnimalMainModule {
}
