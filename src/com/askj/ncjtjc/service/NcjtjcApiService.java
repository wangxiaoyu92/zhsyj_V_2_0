package com.askj.ncjtjc.service;

import com.zzhdsoft.siweb.service.BaseService;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

/**
 * 
 *  NcjtjcApiService的中文名称：【安全监管手机端】api接口service
 *
 *  NcjtjcApiService的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
public class NcjtjcApiService extends BaseService {
	
	protected final Logger logger = Logger.getLogger(NcjtjcApiService.class);
	
	@Inject
	private Dao dao;

}
