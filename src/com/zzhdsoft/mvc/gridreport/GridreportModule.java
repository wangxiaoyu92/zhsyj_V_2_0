package com.zzhdsoft.mvc.gridreport;

import javax.servlet.http.HttpServletResponse;
import com.zzhdsoft.siweb.service.gridreport.GridreportService;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import com.zzhdsoft.mvc.BaseModule;

/**
 * gridreport 控制层
 * 
 * @author CatchU
 * 
 */
@IocBean
@At("/gridreport")
public class GridreportModule extends BaseModule {

	protected final Logger logger = Logger.getLogger(GridreportModule.class);

	@Inject
	private GridreportService gridreportService;
	
	/**
	 * 操作日志管理
	 * 
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public void operatelog(HttpServletResponse response) throws Exception {
		String v_sql="";	
		gridreportService.XML_GenOneRecordset(response,v_sql);		
	}	
	
}
