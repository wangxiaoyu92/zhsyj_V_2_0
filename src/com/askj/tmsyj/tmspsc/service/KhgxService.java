package com.askj.tmsyj.tmspsc.service;

import java.sql.Types;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.askj.baseinfo.dto.HviewjgztDTO;
import com.askj.baseinfo.service.PcompanyService;
import com.askj.tmsyj.tmsyj.dto.HjgztkhgxDTO;
import com.askj.tmsyj.tmsyj.entity.Hjgztkhgx;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.PinYinUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

@IocBean
public class KhgxService extends BaseService{
	
	public static final Log log = Logs.get();
	@Inject
	public Dao dao;
	@Inject
	private PcompanyService pcompanyService;		
	
	@SuppressWarnings({ "rawtypes" })
	public Map queryKhgxList(HttpServletRequest request, HjgztkhgxDTO dto, 
			PagesDTO pd) throws Exception{
		// 获取当前用户
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT h.*, ");
		sb.append(" getAa10_aaa103('COMZZZM', h.jgztkhzzzmmc) jgztkhzzzmmcinfo "); // 资质证明名称
		sb.append(" FROM hjgztkhgx h ");
		sb.append(" where 1=1   ");
		sb.append(" and h.hjgztkhgxid = :hjgztkhgxid "); // 监管主体客户关系表id
		sb.append(" and h.jgztkhgx = :jgztkhgx "); // 客户关系 1供应2生产3经销
		sb.append(" and h.jgztfwnfww = :jgztfwnfww "); // 范围内范围外 1范围内2范围外
		sb.append(" and h.jgztkhmc like :jgztkhmc "); // 客户名称
		sb.append(" and h.hviewjgztid = '").append(sysuser.getAaz001()).append("' "); // 监管主体ID（用户公司id）
		sb.append(" ORDER BY hjgztkhgxid DESC ");
		String[] ParaName = new String[] { "hjgztkhgxid", "jgztkhgx", "jgztfwnfww", "jgztkhmc" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		return m ;
	}
	/**
	 * 
	 * 
	 *  saveKhgx的中文名称：保存更新客户关系
	 * 
	 *  saveKhgx的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String saveKhgx(HttpServletRequest request, HjgztkhgxDTO dto){
		try {
			saveKhgxImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null; 
	}
	/**
	 * 
	 * 
	 *  saveKhgxImpl的中文名称：实现客户关系的 保存 更新
	 * 
	 *  saveKhgxImpl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@Aop("trans")
	public void saveKhgxImpl(HttpServletRequest request, HjgztkhgxDTO dto) throws Exception{
		// 获取当前用户
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		dto.setJgztkhmcjc(PinYinUtil.GetChineseSpell(dto.getJgztkhmc().trim()));
		Hjgztkhgx khgx = new Hjgztkhgx();
		BeanHelper.copyProperties(dto, khgx);
		 if("".equals(dto.getHjgztkhgxid()) || dto.getHjgztkhgxid() == null){
			 String v_Hjgztkhgxid = DbUtils.getSequenceStr();
			 khgx.setHjgztkhgxid(v_Hjgztkhgxid);
			 khgx.setHviewjgztid(sysuser.getAaz001());
			 khgx.setJgztfwnztid(sysuser.getAaz001());//gu20170502 现在这块都增加范围外的，这个字段记录当前操作员aaz001
			 khgx.setJgztfwnfww("2"); // 1范围内2范围外
			 khgx.setAaa027(sysuser.getAaa027());
			 dao.insert(khgx);
			 
			//gu20170425 往主体信息表同步数据
			HviewjgztDTO v_HviewjgztDTO = new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(v_Hjgztkhgxid);
			v_HviewjgztDTO.setDokind("add");
			v_HviewjgztDTO.setTablemc("hjgztkhgx");
			pcompanyService.HviewjgztManage(v_HviewjgztDTO);			 
		 }else{
			 dao.update(khgx);
			 
			//gu20170425 往主体信息表同步数据
			HviewjgztDTO v_HviewjgztDTO = new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(khgx.getHjgztkhgxid());
			v_HviewjgztDTO.setDokind("update");
			v_HviewjgztDTO.setTablemc("hjgztkhgx");
			pcompanyService.HviewjgztManage(v_HviewjgztDTO);				 
		 }
	}
	
	/**
	 * 
	 * 
	 *  delKhgx的中文名称：
	 * 
	 *  delKhgx的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String delKhgx(HjgztkhgxDTO dto){
		try {
			delKhgxImpl(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null; 
	}
	/**
	 * 
	 * 
	 *  delKhgxImpl的中文名称：
	 * 
	 *  delKhgxImpl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	@Aop("trans")
	public void delKhgxImpl(HjgztkhgxDTO dto) throws Exception{
		 if(!"".equals(dto.getHjgztkhgxid()) && dto.getHjgztkhgxid() != null){
			 Hjgztkhgx khgx = dao.fetch(Hjgztkhgx.class, dto.getHjgztkhgxid());
			 if(khgx != null){
				 dao.delete(Hjgztkhgx.class,dto.getHjgztkhgxid());
				 
				//gu20170425 往主体信息表同步数据
				HviewjgztDTO v_HviewjgztDTO=new HviewjgztDTO();
				v_HviewjgztDTO.setHviewjgztid(dto.getHjgztkhgxid());
				v_HviewjgztDTO.setDokind("delete");
				v_HviewjgztDTO.setTablemc("hjgztkhgx");
				pcompanyService.HviewjgztManage(v_HviewjgztDTO);	
					
			 }else{
				 throw new BusinessException("没有这条信息！！！");
			 }
		 }else{
			 throw new BusinessException("关系ID不能为空！！！");
		 }
	}
}
