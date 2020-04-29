package com.askj.spsy.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import com.lbs.leaf.ExportedExcelDataInfo;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.leaf.util.ExcelUtil;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.alibaba.druid.util.StringUtils;
import com.askj.spsy.dto.QcompanygxDTO;
import com.askj.spsy.dto.QjhkchzbDTO;
import com.askj.spsy.dto.QledgerstockDTO;
import com.askj.spsy.dto.QproductDTO;
import com.askj.spsy.dto.QproductjcDTO;
import com.askj.spsy.dto.QproductpcDTO;
import com.askj.spsy.dto.QproductszgcxxDTO;
import com.askj.spsy.dto.QsymscbDTO;
import com.askj.spsy.dto.QsymscmxbDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.spsy.entity.Qcompanygx;
import com.askj.spsy.entity.Qjhkchzb;
import com.askj.spsy.entity.Qledgerstock;
import com.askj.spsy.entity.Qproductjc;
import com.askj.spsy.entity.Qproductpc;
import com.askj.spsy.entity.Qproductszgcxx;
import com.askj.spsy.entity.Qsymscb;
import com.askj.spsy.entity.Qsymscmxb;
import com.askj.tmsyj.tmcy.dto.HsplyDTO;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.baseinfo.entity.Pcomqrcode;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.ExcelServlet;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * SpsyApiService的中文名称：食品溯源对外接口service
 * 
 * SpsyApiService的描述：
 * 
 * Written by : zy
 */
public class SpsyApiService extends BaseService {
	protected final Logger logger = Logger.getLogger(SpsyApiService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * getComProductList的中文名称：获取企业产品列表
	 *
	 * getComProductList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：gjf
	 */
	public Map getComProductList(HttpServletRequest request,QproductDTO dto ,PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.proid,a.proname,a.progg,a.probzgg,");
		sb.append("(SELECT t.fjpath FROM fj t WHERE t.FJWID=a.proid AND t.FJID ");
		sb.append(" IN (SELECT MAX(t2.FJID) FROM fj t2 WHERE t2.FJWID=a.proid AND t2.FJTYPE='1')) AS fjpath ");
		sb.append(" FROM qproduct a ");
		sb.append(" WHERE a.procomid=:procomid ");
		sb.append(" AND a.cphyclbz='1' ");
		
		String[] ParaName = new String[]{"procomid"};
		int[] ParaType = new int[]{Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		return m;
	}	
	
	/**
	 * 
	 * getComProductDetailList的中文名称：获取企业单个产品的明细信息
	 *
	 * getComProductDetailList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：gjf
	 */
	public Map getComProductDetailList(HttpServletRequest request,QproductDTO dto ,PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.proid,a.proname,a.prosb,a.prosccj,a.propm,a.procdjd,a.probzq,a.procpbzh,");
		sb.append(" getAa10_aaa103('PROZL',a.prozl) AS prozl,projj ");
		sb.append(" FROM qproduct a ");
		sb.append(" WHERE a.proid=:proid ");		
		
		String[] ParaName = new String[]{"proid"};
		int[] ParaType = new int[]{Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		return m;
	}	
	
	/**
	 * 
	 * getComProductPicList的中文名称：获取企业产品图片列表
	 *
	 * getComProductPicList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：gjf
	 */
	public Map getComProductPicList(HttpServletRequest request,FjDTO dto ,PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT * FROM fj WHERE FJTYPE='1' ");
		sb.append(" and fjwid=:fjwid  ");	
		
		String[] ParaName = new String[]{"fjwid"};
		int[] ParaType = new int[]{Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		return m;
	}
	
	
	 
}
