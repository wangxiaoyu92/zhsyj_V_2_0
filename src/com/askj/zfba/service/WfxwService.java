package com.askj.zfba.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.baseinfo.dto.PwfxwcsDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.baseinfo.entity.Pwfxwcs;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/***
 * 
 * WfxwService的中文名称：
 *
 * WfxwService的中文描述：
 * 
 * Written by:wanghao
 */
public class WfxwService extends BaseService{
	protected final Logger logger = Logger.getLogger(AjdjService.class);
	@Inject
	private Dao dao;
	
	
	/***
	 * 
	 * queryAjdj的中文名称： 查询案件违法行为
	 *
	 * queryAjdj概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by:wanghao
	 */
	public Map queryWfxw(PwfxwcsDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from pwfxwcs a ");
		sb.append(" where 1=1 ");
		sb.append("  and wfxwbh like :wfxwbh");
		sb.append(" and ajdjajdl = :ajdjajdl");
		sb.append(" order by a.pwfxwcsid desc ");
		String sql = sb.toString();
		String[] ParaName = new String[] {"wfxwbh","ajdjajdl"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PwfxwcsDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/***
	 * 
	 * saveWfxw的中文名称：保存或者修改 违法行为
	 *
	 * saveWfxw概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * Written by:wanghao
	 */
	public String saveWfxw(HttpServletRequest request, PwfxwcsDTO dto) {
		try {
			saveWfxwImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 查询出所有的执行信息根据企业类别和计划id，
	 * @param dto企业实体类
	 * @param pd分页
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map checkCode(HttpServletRequest request, PwfxwcsDTO dto ) throws Exception {
		//使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
		//转化sql语句
		int li_count= dao.count(Pwfxwcs.class, Cnd.where("wfxwbh", "=", dto.getWfxwbh().trim()));
		Map map = new HashMap();
		map.put("total",li_count);
		return map;
	}
	@Aop({ "trans" })
	public void saveWfxwImp(HttpServletRequest request, PwfxwcsDTO dto)
			throws Exception {
		if (null != dto.getPwfxwcsid()&&!"".equals(dto.getPwfxwcsid())) {
			//修改
			Pwfxwcs se = dao.fetch(Pwfxwcs.class, dto.getPwfxwcsid());
			BeanHelper.copyProperties(dto, se);
			dao.update(se);
		} else {
			//保存

			String vpwfxwcsId = DbUtils.getSequenceStr();
			Pwfxwcs pwfxwcs = new Pwfxwcs();
			dto.setPwfxwcsid(vpwfxwcsId);
			BeanHelper.copyProperties(dto, pwfxwcs);
			dao.insert(pwfxwcs);
			
		}
	}
	
	/***
	 * 
	 * queryWfxw的中文名称：查询违法行为
	 *
	 * queryWfxw概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * Written by:wanghao
	 */
	public Object findWfxw(HttpServletRequest request, PwfxwcsDTO dto)
			throws Exception {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from ");
		sb.append(" pwfxwcs a ");
		sb.append("  where 1=1 ");
		sb.append("  and a.pwfxwcsid = :pwfxwcsid");
		String sql = sb.toString();
		String[] ParaName = new String[] { "pwfxwcsid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PwfxwcsDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		PwfxwcsDTO pdto = new PwfxwcsDTO();
		if (ls!=null && ls.size()>0) {
			pdto = (PwfxwcsDTO)ls.get(0);
		}
		
		return pdto;
	}
	
	
	/***
	 * 
	 * delWfxw的中文名称：删除违法行为
	 *
	 * delWfxw概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * Written by:wanghao
	 */
	public String delWfxw(HttpServletRequest request, PwfxwcsDTO dto) {
		try {
			if (null != dto.getPwfxwcsid()) {
				delWfxwImp(request, dto);
			} else {
				return "没有接收到要删除的违法行为ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void delWfxwImp(HttpServletRequest request, PwfxwcsDTO dto) {
		// 删除案件登记
		dao.clear(Pwfxwcs.class, Cnd.where("pwfxwcsid", "=", dto.getPwfxwcsid()));
	}
	
	
	
}
