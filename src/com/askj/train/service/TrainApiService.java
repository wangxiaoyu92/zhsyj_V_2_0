package com.askj.train.service;

import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.zzhdsoft.siweb.service.BaseService;

/**
 * 
 * TrainApiService的中文名称：【培训系统】api接口service
 * 
 * TrainApiService的描述：
 * 
 * @author ：zy
 * @version ：V1.0
 */
public class TrainApiService extends BaseService {
	public static final Log log = Logs.get();
	@Inject
	public Dao dao;
	
}
