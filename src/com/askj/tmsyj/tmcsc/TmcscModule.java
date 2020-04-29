package com.askj.tmsyj.tmcsc;

import org.nutz.mvc.annotation.Encoding;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Modules;
/**
 * 
 *  tmcscModule的中文名称：【透明菜市场】主模块
 *
 *  tmcscModule的描述：
 *
 *  @author : ly
 *  @version : V1.0
 */
@Modules(scanPackage = true)
@Fail("jsp:/jsp/error/500.jsp")
@Encoding(input = "UTF-8", output = "UTF-8")
public class TmcscModule {}
