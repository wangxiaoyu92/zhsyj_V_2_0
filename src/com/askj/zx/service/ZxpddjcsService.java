package com.askj.zx.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxpddjcsDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.zx.entity.Zxpddjcs;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

import common.Logger;

/**
 * 征信评定等级参数业务逻辑层
 * @author CatchU
 *
 */
public class ZxpddjcsService extends BaseService{
	protected final Logger logger =Logger.getLogger(ZxpddjcsService.class); 

	@Inject
	private Dao dao;
	
	/**
	 * 查询评定等级参数
	 * @throws Exception 
	 */
	public Map query(ZxpddjcsDTO dto,PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select djcsid,djcsbm,djcsmc,djcsqsfz,djcsjsfz,djcsksrq,");
		sb.append(" djcsjsrq,czyxm,czsj,djcshh ");
		sb.append(" from zxpddjcs djcs");
		sb.append(" where 1=1");
		sb.append(" and djcs.djcsbm = :djcsbm");
		sb.append(" and djcs.djcsmc = :djcsmc");
		sb.append(" and djcs.djcshh = :djcshh");
		sb.append(" and djcs.djcsid = :djcsid");
		sb.append(" order by djcsid");
		String sql = sb.toString();
		String[] paraName = new String[]{"djcsbm","djcsmc","djcshh","djcsid"};
		int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paraName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxpddjcsDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 * 保存征信评定等级参数
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception 
	 */
	public String saveZxpddjcs(HttpServletRequest request, ZxpddjcsDTO dto){
		try {
			saveZxpddjcsImpl(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 保存征信评定等级参数实现方法
	 * @param request
	 * @param dto
	 * @throws Exception 
	 */
	@Aop({"trans"})
	private void saveZxpddjcsImpl(HttpServletRequest request, ZxpddjcsDTO dto) throws Exception {
		//获得登录系统用户，即操作员姓名
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		//获取操作时间
		String datetime = SysmanageUtil.getDbtimeYmdHns();
		
		//以下是将时间去掉"-",并转为字符串（等级参数开始日期）
		String temp[]  =  dto.getDjcsksrq().split("-");
		StringBuffer sb = new StringBuffer();
		for(int i =0;i<temp.length;i++){
			sb.append(temp[i]);
		}
		String djcsksrq = sb.toString();
		//以下是将时间去掉"-",并转为字符串（等级参数结束日期）
		String temp1[]  =  dto.getDjcsjsrq().split("-");
		StringBuffer sb1 = new StringBuffer();
		for(int i =0;i<temp1.length;i++){
			sb1.append(temp1[i]);
		}
		String djcsjsrq  = sb1.toString();
		//判断更新还是添加
		if(dto.getDjcsid()!=null && !"".equals(dto.getDjcsid())){
			//更新
			Zxpddjcs zxpddjcs = dao.fetch(Zxpddjcs.class, Cnd.where("djcsid", "=", dto.getDjcsid()));
		/*	BeanHelper.copyProperties(dto, zxpddjcs);*/
			zxpddjcs.setDjcsid(dto.getDjcsid());
			zxpddjcs.setDjcsbm(dto.getDjcsbm());
			zxpddjcs.setDjcsmc(dto.getDjcsmc());
			zxpddjcs.setDjcsqsfz(dto.getDjcsqsfz());
			zxpddjcs.setDjcsjsfz(dto.getDjcsjsfz());
			zxpddjcs.setDjcsksrq(djcsksrq);
			zxpddjcs.setDjcsjsrq(djcsjsrq);
			zxpddjcs.setCzyxm(sysuser.getUsername());
			zxpddjcs.setCzsj(datetime);
			zxpddjcs.setDjcshh(dto.getDjcshh());
			dao.update(zxpddjcs);
		}else{
			//添加
			String djcsid = DbUtils.getSequenceStr();
			Zxpddjcs zxpddjcs = new Zxpddjcs();
			BeanHelper.copyProperties(dto, zxpddjcs);
			
			zxpddjcs.setDjcsksrq(djcsksrq);
			zxpddjcs.setDjcsjsrq(djcsjsrq);
			zxpddjcs.setDjcsid(djcsid);
			zxpddjcs.setCzyxm(sysuser.getUsername());
			zxpddjcs.setCzsj(datetime);
			dao.insert(zxpddjcs);
		}
	}

	
	/**
	 * 删除征信评定等级参数
	 * @param request
	 * @param dto
	 * @return
	 */
	public String delZxpddjcs(HttpServletRequest request, ZxpddjcsDTO dto) {
		try {
			delZxpddjcsImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 删除征信评定等级参数实现方法,
	 * 事务管理
	 */
	@Aop({"trans"})
	private void delZxpddjcsImpl(HttpServletRequest request, ZxpddjcsDTO dto) {
		if(!(dto.getDjcsid()==null||"".equals(dto.getDjcsid()))){
			//删除
			dao.clear(Zxpddjcs.class, Cnd.where("djcsid", "=", dto.getDjcsid()));
		}
		
	}
	

}
