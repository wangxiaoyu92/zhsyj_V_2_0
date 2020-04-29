package com.zzhdsoft.siweb.service;

import java.util.Map;

/**
 * 
 * IPubService的中文名称：webService数据查询接口
 * 
 * IPubService的描述：
 * 
 * Written by : zjf
 */
public interface IPubService {
	public String execSQL(String t, String sql, String param);

	public String wlService(String signature, String timestamp, String ywdm,
			String inParams) throws Exception;
}
