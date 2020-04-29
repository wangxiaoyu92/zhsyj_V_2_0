package com.zzhdsoft.mvc;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.util.NutMap;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.View;
import org.nutz.mvc.view.HttpStatusView;

/**
 * 
 * BaseModule的中文名称：模块基类，预留扩展
 * 
 * BaseModule的描述：
 * 
 * Written by : zjf
 */
public class BaseModule {
	protected static final Log log = Logs.get();
	@Inject
	protected Dao dao;

	protected NutMap ajaxOk(Object data) {
		return new NutMap().setv("ok", true).setv("data", data);
	}

	protected NutMap ajaxFail(String msg) {
		return new NutMap().setv("ok", false).setv("msg", msg);
	}

	// 常用HTTP状态
	public static final View HTTP_403 = new HttpStatusView(403);
	public static final View HTTP_404 = HttpStatusView.HTTP_404;
	public static final View HTTP_500 = HttpStatusView.HTTP_500;
	public static final View HTTP_502 = HttpStatusView.HTTP_502;
	public static final View HTTP_200 = new HttpStatusView(200);

	// 生成json响应的辅助方法
	public static NutMap _map(Object... args) {
		NutMap re = new NutMap();
		for (int i = 0; i < args.length; i += 2) {
			re.put(args[i].toString(), args[i + 1]);
		}
		return re;
	}
}
