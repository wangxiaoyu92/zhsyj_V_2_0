package com.zzhdsoft.siweb.service;

import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;

/**
 * 
 * BaseService的中文名称：服务实现类的基类
 * 
 * BaseService的描述：
 * 
 * Written by : zjf
 */
public class BaseService {
	public static final Log log = Logs.get();
	@Inject
	public Dao dao;
}
