package com.askj.oa.service;

import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.oa.dto.CirculationpaperDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.oa.entity.Circulationpaper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
/**
 * 
 * CirculationpaperService的中文名称：传阅信息管理service
 * 
 * CirculationpaperService的描述：
 * 
 * Written by : sunyifeng at 2016-06-30 18:11:34
 */
public class CirculationPaperService {
	protected final Logger logger = Logger.getLogger(CirculationPaperService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryCirculationpaper的中文名称：查询传阅信息
	 * 
	 * queryCirculationpaper的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * @throws Exception
	 * 
	 */
	public Map queryCirculationpaper(CirculationpaperDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append("   select * ");
		sb.append("   from Circulationpaper ");
		sb.append("   where 1 = 1 ");
		sb.append("   and paperid = :paperid ");
		sb.append("   and fileid = :fileid ");
		sb.append("   and paperusername like :paperusername ");
		sb.append("   and recusername like :recusername ");
		sb.append("   and paperstate = :paperstate ");
		sb.append("   and filetitle = :filetitle ");
		if(!"admin".equals(vSysUser.getUsername())){
			sb.append("   and recuserid like '%"+vSysUser.getUserid()+"%'");
		}
		String sql = sb.toString();
		String[] ParaName = new String[] {
					"paperid",
					"fileid",
					"paperusername",
					"recusername",
					"paperstate",
					"filetitle",
				};
		int[] ParaType = new int[] {
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.VARCHAR,
					Types.NUMERIC,
					Types.VARCHAR,
				};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Circulationpaper.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addCirculationpaper的中文名称：新增传阅信息
	 * 
	 * addCirculationpaper的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * 
	 */
	public String addCirculationpaper(HttpServletRequest request, final CirculationpaperDTO dto) {
		try {
			addCirculationpaperImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addCirculationpaperImp(HttpServletRequest request, CirculationpaperDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		Circulationpaper circulationPaper = new Circulationpaper();
		String sequence = DbUtils.getSequenceStr();
		dto.setPaperid(sequence);
		BeanHelper.copyProperties(dto, circulationPaper);
		dao.insert(circulationPaper);
		Timestamp endTime = SysmanageUtil.currentTime();
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);
	}

	/**
	 * 
	 * updateCirculationpaper的中文名称：修改传阅信息
	 * 
	 * updateCirculationpaper的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * 
	 */

	public String updateCirculationpaper(HttpServletRequest request, final CirculationpaperDTO dto) {
		try {
			updateCirculationpaperImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateCirculationpaperImp(HttpServletRequest request, CirculationpaperDTO dto) throws Exception {
		if (null != dto.getPaperid() && !"".equals(dto.getPaperid())) {
			String sql="UPDATE  circulationpaper   SET  paperstate=1  WHERE paperid='"+dto.getPaperid()+"'";
			Sql sqls = Sqls.create(sql.toString());
			dao.execute(sqls);
	}
	}

	/**
	 * 
	 * delCirculationpaper的中文名称：删除传阅信息
	 * 
	 * delCirculationpaper的概要说明：
	 * 
	 * @param dto
	 * @return Written by : sunyifeng at 2016-06-30 18:11:34
	 * 
	 */
	public String delCirculationpaper(HttpServletRequest request, CirculationpaperDTO dto) {
		try {
			delCirculationpaperImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delCirculationpaperImp(HttpServletRequest request, CirculationpaperDTO dto)  throws Exception {
		// 删除传阅信息
		dao.clear(Circulationpaper.class, Cnd.where("paperid", "=", dto.getPaperid()));
	}
	
}