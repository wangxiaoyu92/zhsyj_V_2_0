package com.askj.zfba.service;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;

import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.pubkeyDTO;
import com.askj.baseinfo.dto.ViewzfryDTO;
import com.askj.zfba.dto.ZfajcbrDTO;
import com.askj.zfba.dto.ZfajdjDTO;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Aa13;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.entity.workflow.Wf_node;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.baseinfo.entity.Viewzfry;
import com.askj.zfba.entity.Zfajcbr;
import com.askj.zfba.entity.Zfajdj;
import com.zzhdsoft.siweb.service.BaseService;
import com.askj.zfba.service.pub.WsgldyService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * NewsService的中文名称：新闻管理service
 * 
 * NewsService的描述：
 * 
 * Written by : gjf
 */
@IocBean
public class AjdjService extends BaseService {
	
	protected final Logger logger = Logger.getLogger(AjdjService.class);
	@Inject
	private Dao dao;
	@Inject
	private WsgldyService wsgldyService;
	
	/**
	 * 
	 * queryAjdjObj的中文名称：查询案件登记obj
	 * 
	 * queryAjdjObj的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	public Object queryAjdjObj(String prm_ajdjid) throws Exception {
		String v_sql = "select a.* from zfajdj a where a.ajdjid='"+prm_ajdjid+"'";
		return (ZfajdjDTO)DbUtils.getDataList(v_sql, ZfajdjDTO.class).get(0);	
	}
	

	/**
	 * 
	 * queryAjdj的中文名称：查询案件登记
	 * 
	 * queryAjdj的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * TODO
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryAjdj(ZfajdjDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		if (vSysUser == null) { //手机端登录获取登录用户
			vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
		}
		dto.setAaa027(vSysUser.getAaa027());


		StringBuffer sb = new StringBuffer();
		sb.append("  select a.*,(select count(t.ajdjid) from zfajcbr t where t.userid='"+
				vSysUser.getUserid()+"' and t.ajdjid=a.ajdjid) as ajslrbz ");
		// 关联aa13表，根据统筹区名查询
		sb.append("  from zfajdj a, aa13 b");
		sb.append("  where 1=1 ");
		sb.append("  and a.aaa027 = b.aaa027 "); // 案件登记id
		sb.append("  and a.ajdjid = :ajdjid "); // 案件登记id
		sb.append("  and a.aaa027 = :aaa027 "); // 统筹区
		sb.append("  and a.comdm = :comdm "); // 企业代码
		sb.append("  and a.commc like :commc "); // 企业名称
		sb.append("  and a.slbz = :slbz "); // 案件受理标志
		sb.append("  and a.ajjsbz = :ajjsbz "); // 案件结束标志
		sb.append("  and a.ajdjsfgx = :ajdjsfgx "); // 案件是否归本部门管辖
		if (dto.getAaa027name() != null && !"".equals(dto.getAaa027name())) {
			sb.append("  and b.aaa129 = '").append(dto.getAaa027name()).append("' "); // 案件所在统筹区
		}
		
		//加入案件相关人员的过滤  相关人员表中的人才有权限看到该案件 		
		//sb.append(" and (exists (select 1 from zfajcbr t where t.ajdjid=a.ajdjid and t.userid='"+
		//         vSysUser.getUserid()+"') or a.userid='"+vSysUser.getUserid()+"')");
		//改为后台函数控制  思路 ：没有设置案件经办人时都可以看，设置后，只有增加的操作员或设置的经办人中存在在人员
		//才可以操作
		sb.append(" and fun_ShiFouKeYiChaKanAnJian(a.ajdjid,'"+vSysUser.getUserid()+"')='1' ");
		sb.append(" order by a.ajdjid desc ");
		
		String sql = sb.toString();
		String[] ParaName = new String[] { "ajdjid", "aaa027", "comdm",
				"commc", "slbz", "ajjsbz", "ajdjsfgx" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("=============="+sql);
		Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, ZfajdjDTO.class,
				pd.getPage(), pd.getRows(),vSysUser.getUserid(),"aaa027,aae140,orgid");
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * saveAjdj的中文名称：保存案件登记
	 * 
	 * saveAjdj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */

	public String saveAjdj(HttpServletRequest request, ZfajdjDTO dto) {
		try {
			saveAjdjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void saveAjdjImp(HttpServletRequest request, ZfajdjDTO dto)
			throws Exception {
		if (null != dto.getAjdjid() && !"".equals(dto.getAjdjid())) {
			Zfajdj se = dao.fetch(Zfajdj.class, dto.getAjdjid());
			se.setAjdjbh(dto.getAjdjbh());
			se.setComdm(dto.getComdm());
			se.setCommc(dto.getCommc());
			se.setComdz(dto.getComdz());
			se.setComfrhyz(dto.getComfrhyz());
			se.setComfrsfzh(dto.getComfrsfzh());
			se.setComyddh(dto.getComyddh());
			se.setComyzbm(dto.getComyzbm());
			se.setAjdjafsj(dto.getAjdjafsj());
			se.setAjdjay(dto.getAjdjay());
			se.setAjdjajly(dto.getAjdjajly());
			se.setAjdjjbqk(dto.getAjdjjbqk());
			se.setAae140(dto.getAae140());
			se.setAjdjwfss(dto.getAjdjwfss());

			dao.update(se);
		} else {
			//gu20161010 获取comid
		   // String v_sql = "select a.* from pcompany a where a.comid = '" + dto.getComid() + "'";
			Pcompany v_pcompany = dao.fetch(Pcompany.class,dto.getComid());
						
			Sysuser vSysUser = SysmanageUtil.getSysuser();
			String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
			String vAjdjid = DbUtils.getSequenceStr();
			Zfajdj v_Zfajjd = new Zfajdj();
			BeanHelper.copyProperties(dto, v_Zfajjd);
			v_Zfajjd.setAjdjid(vAjdjid);
			v_Zfajjd.setAjdjczy(vSysUser.getDescription());
			v_Zfajjd.setAjdjczsj(v_dbDatetime);
			if (v_Zfajjd.getAjdjafsj() != null
					&& "".equals(v_Zfajjd.getAjdjafsj())) {
				v_Zfajjd.setAjdjafsj(null);
			}
			v_Zfajjd.setAaa027(vSysUser.getAaa027());
			v_Zfajjd.setSlbz("0");
			v_Zfajjd.setAjjsbz("0");
			v_Zfajjd.setOrgid(vSysUser.getOrgid());	
			v_Zfajjd.setUserid(vSysUser.getUserid());
			v_Zfajjd.setComid(v_pcompany.getComid());
			//v_Zfajjd.setComdalei(v_pcompany.getComdalei());
			
			dao.insert(v_Zfajjd);
			
			//20161231 新增时同时把当前操作员，设定为案件承办人
			Zfajcbr v_zfajcbr=new Zfajcbr();
			String v_ajcbrid=DbUtils.getSequenceStr();
			v_zfajcbr.setAjcbrid(v_ajcbrid);
			v_zfajcbr.setAjdjid(vAjdjid);
			v_zfajcbr.setUserid(vSysUser.getUserid());
			v_zfajcbr.setZfryxm(vSysUser.getDescription());
			v_zfajcbr.setZfrysflx("4");//4 案件登记人员
			v_zfajcbr.setZfrybmmc(vSysUser.getOrgname());
			dao.insert(v_zfajcbr);
			
			//插入节点对应的文书 gu20160923不用了
//			Wf_node v_wf_node=getStartNodeFromYwpym("zfbalc");
//			ZfajzfwsDTO v_ZfajzfwsDTO=new ZfajzfwsDTO();
//			v_ZfajzfwsDTO.setAjdjid(vAjdjid);
//			v_ZfajzfwsDTO.setPsbh(v_wf_node.getPsbh());
//			v_ZfajzfwsDTO.setNodeid(v_wf_node.getNodeid());
//			v_ZfajzfwsDTO.setNodename(v_wf_node.getNodename());
//			
//			wsgldyService.saveZfwsaddFromZfwsnode(request, v_ZfajzfwsDTO);
		}
	}

	/**
	 * 
	 * delAjdj的中文名称：删除案件登记
	 * 
	 * delAjdj的概要说明：
	 * 
	 * @param dto
	 * @return Written by : gjf
	 * 
	 */
	public String delAjdj(HttpServletRequest request, ZfajdjDTO dto) {
		try {
			if (null != dto.getAjdjid()) {
				// // 检查是否可删除
				// List sysuserList = dao.query(Zfajdj.class, Cnd.wrap(dto
				// .getAjdjid()
				// + " in ('0','1','2','3','4')"));
				// if (sysuserList != null && sysuserList.size() > 0) {
				// return "不允许删除系统预置标准用户！";
				// }
				delAjdjImp(request, dto);
			} else {
				return "没有接收到要删除的案件登记ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void delAjdjImp(HttpServletRequest request, ZfajdjDTO dto) {
		// 删除案件登记
		dao.clear(Zfajdj.class, Cnd.where("ajdjid", "=", dto.getAjdjid()));
	}
	/**
	 * 
	 * queryAjcbr的中文名称：查询案件承办人信息
	 * queryAjcbr的概要说明：
	 * Written  by : lfy
	 */
	@SuppressWarnings("rawtypes")
	public Object queryAjcbr(HttpServletRequest request, ZfajdjDTO dto)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from ");
		sb.append("  zfajcbr a ");
		sb.append("  where 1=1 ");
		sb.append("  and a.ajdjid = :ajdjid ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ajdjid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zfajcbr.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		String v_zfryzz="";
		String v_zfryzzid="";
		String v_zfryzy="";
		String v_zfryzyid="";
		 
		if (!"".equals(dto.getAjdjid()) && null != dto.getAjdjid()) {
			if (ls.size() > 0 && ls != null) {
				for (int i = 0; i < ls.size(); i++) {
					Zfajcbr zfajcbr = (Zfajcbr) ls.get(i);
					if ("0".equals(zfajcbr.getZfrysflx())) {
						//dto.setZfryzz(zfajcbr.getZfryxm());
						//dto.setZfryzzid(zfajcbr.getUserid().toString());
						if ("".equalsIgnoreCase(v_zfryzz)){
							v_zfryzz = zfajcbr.getZfryxm();
						}else{
							v_zfryzz = v_zfryzz + "," + zfajcbr.getZfryxm();
						}
						if ("".equalsIgnoreCase(v_zfryzzid)){
							v_zfryzzid = zfajcbr.getUserid().toString();
						}else{
							v_zfryzzid = v_zfryzzid + "," + zfajcbr.getUserid().toString();
						}						
					} else if ("1".equals(zfajcbr.getZfrysflx())) {
						if ("".equalsIgnoreCase(v_zfryzy)){
							v_zfryzy = zfajcbr.getZfryxm();
						}else{
							v_zfryzy = v_zfryzy + "," + zfajcbr.getZfryxm();
						}
						if ("".equalsIgnoreCase(v_zfryzyid)){
							v_zfryzyid = zfajcbr.getUserid().toString();
						}else{
							v_zfryzyid = v_zfryzyid + "," + zfajcbr.getUserid().toString();
						}							
					}
				}
				dto.setZfryzz(v_zfryzz);
				dto.setZfryzzid(v_zfryzzid);
				dto.setZfryzy(v_zfryzy);
				dto.setZfryzyid(v_zfryzyid);
			}
		}
		return dto;
	}

	/**
	 * 
	 * saveAjcbr的中文名称：保存案件承办人 saveAjcbr的概要描述：
	 * 
	 * @param request
	 * @param dto
	 * @return written by ： lfy
	 */
	public String saveAjcbr(HttpServletRequest request, ZfajdjDTO dto) {
		try {
			saveAjcbrImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * saveAjcbrImp的中文名称：删除或者添加承办人 
	 * saveAjcbrImp的概要描述：
	 * 
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @throws Exception
	 * written by ： lfy
	 */
	@SuppressWarnings("rawtypes")
	private void saveAjcbrImp(HttpServletRequest request, ZfajdjDTO dto)
			throws Exception, Exception {
		if (dto.getAjdjid() != null && !"".equals(dto.getAjdjafsj())) {
			// 根据案件登记id删除执法承办人的信息
			dao.clear(Zfajcbr.class, Cnd.where("ajdjid", "=", dto.getAjdjid()));
			if (null != dto.getZfryzz() && !"".equals(dto.getZfryzz())) {
				String vAjcid = DbUtils.getSequenceStr();
				Zfajcbr zf = new Zfajcbr();
				//BeanHelper.copyProperties(dto, zf);
				zf.setUserid(dto.getZfryzzid());
				zf.setAjcbrid(vAjcid);
				zf.setZfryxm(dto.getZfryzz());
				zf.setAjdjid(dto.getAjdjid());
				zf.setZfrysflx("0");
				List ls = queryViewzfryByUserid(dto.getZfryzzid());
				if (ls.size()>0) {
					Viewzfry zfaj = (Viewzfry) ls.get(0);
					zf.setZfrybmmc(zfaj.getOrgname());// 执法人员部门名称
					zf.setZfryzjhm(zfaj.getZfryzjhm());// 执法人员的证件编号
					zf.setZfryzw(zfaj.getZfryzw());// 执法人员职务
				}
				dao.insert(zf);
			}
			if (null != dto.getZfryzy() && !"".equals(dto.getZfryzy())) {
				String[] zfryzy = dto.getZfryzy().split(",");
				String[] zfryzyid = dto.getZfryzyid().split(",");
				for (int i = 0; i < zfryzy.length; i++) {
					String vAjcid2 = DbUtils.getSequenceStr();
					Zfajcbr zf = new Zfajcbr();
					//BeanHelper.copyProperties(dto, zf);
					zf.setAjcbrid(vAjcid2);
					zf.setUserid(zfryzyid[i]);
					zf.setZfryxm(zfryzy[i]);
					zf.setZfrysflx("1");
					zf.setAjdjid(dto.getAjdjid());
					List ls = queryViewzfryByUserid(zfryzyid[i]);
					if (ls.size()>0) {
						Viewzfry zfaj = (Viewzfry) ls.get(0);
						zf.setZfrybmmc(zfaj.getOrgname());// 执法人员部门名称
						zf.setZfryzjhm(zfaj.getZfryzjhm());// 执法人员的证件编号
						zf.setZfryzw(zfaj.getZfryzw());// 执法人员职务
					}
					dao.insert(zf);
				}
			}
		}
	}

	/**
	 * 
	 * queryViewzfryByUserid的中文名称：根据id查询执法人员视图信息 
	 * queryViewzfryByUserid的概要描述：
	 * 
	 * @param userid
	 * @return
	 * @throws Exception
	 *             written by ： lfy
	 */
	@SuppressWarnings("rawtypes")
	public List queryViewzfryByUserid(String userid) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT * from viewzfry ");
		sb.append("  where 1=1 ");
		sb.append("  and userid= '").append(userid).append("' ");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Viewzfry.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
	
	/**
	 * 
	 * queryViewzfry的中文名称：查询执法人员信息
	 * queryViewzfry的概要描述：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by ： lfy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryViewzfry(ViewzfryDTO dto,PagesDTO pd) throws Exception{
		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		dto.setAaa027(vSysUser.getAaa027());
		StringBuffer sb = new StringBuffer();
		sb.append("  select * ");
		sb.append("  from viewzfry ");
		sb.append("  where 1=1 ");
		sb.append("  and username = :username ");
		sb.append("  and mobile = :mobile ");
		sb.append("  and aaa027 = :aaa027 ");
		String sql = sb.toString();
		String[] ParaName = new String[] {"username", "mobile", "aaa027"};
		int[] ParaType = new int[] {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ViewzfryDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * getStartNodeFromYwpym的中文名称：根据业务拼音码查询开始节点
	 * 
	 * getStartNodeFromYwpym的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings("unchecked")
	public Wf_node  getStartNodeFromYwpym(String prm_yewumcpym) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		//String v_aaa027= vSysUser.getAaa027().toString().replaceAll("0*$", "");
		
		Wf_node v_wf_node = new Wf_node();
		String v_sql = " select a.* from wf_node a, wf_yewu_process b "+
		" where a.psbh = b.psbh and a.nodetype = 'START_NODE'  and b.yewumcpym = '" + prm_yewumcpym +
		"' and b.aaa027 = '" + vSysUser.getAaa027() + "'";
		System.out.println(v_sql);
		List<Wf_node> v_list = (List<Wf_node>) DbUtils.getDataList(v_sql, Wf_node.class);
		if (v_list != null && v_list.size() > 0){
			v_wf_node = v_list.get(0);
		}else{
			throw new BusinessException("没找到该地区配置的工作流绑定信息");
		}
        return v_wf_node;
	}	
	
	/**
	 * 
	 * queryAjdjCbr的中文名称：查询案件承办人
	 * 
	 * queryAjdjCbr的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryAjdjCbr(ZfajcbrDTO dto, PagesDTO pd) throws Exception {
		//Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		//dto.setAaa027(vSysUser.getAaa027());
  
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from zfajcbr a ");
		sb.append(" where 1=1 ");
		sb.append("  and ajdjid = :ajdjid ");
		sb.append("  and zfrysflx = :zfrysflx ");
		sb.append(" order by a.ajcbrid desc ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "ajdjid", "zfrysflx"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("sqlsqlsqlsql " + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZfajcbrDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * queryAjdjCbr的中文名称：查询案件承办人
	 *
	 * queryAjdjCbr的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : gjf
	 * @throws Exception
	 *
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String queryAjdjCbrMiaoshu(ZfajcbrDTO dto, PagesDTO pd) throws Exception {
		//Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		//dto.setAaa027(vSysUser.getAaa027());
		String v_sql="select group_concat(u.jbr) as zfryxm from (" +
				"select concat('主办人：',group_concat(t1.zfryxm)) as jbr from zfajcbr t1 where t1.zfrysflx='1' " +
				"  and t1.ajdjid='"+dto.getAjdjid()+"' " +
				"union " +
				"select concat('协办人：',group_concat(t1.zfryxm)) as jbr from zfajcbr t1 where t1.zfrysflx='1' " +
				"  and t1.ajdjid='"+dto.getAjdjid()+"' " +
				"union " +
				"select concat('其他相关人：',group_concat(t1.zfryxm)) as jbr from zfajcbr t1 where t1.zfrysflx='1' " +
				"  and t1.ajdjid='"+dto.getAjdjid()+"' " +
				"  ) u ";
		 String v_zfryxm=DbUtils.getOneValue(dao,v_sql);
		 if (v_zfryxm == null || v_zfryxm=="null"){
			 v_zfryxm="";
		 }
         return v_zfryxm;
	}
	
	/**
	 * 
	 * saveAjdjCbr的中文名称：保存案件承办人
	 * 
	 * saveAjdjCbr的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return Written by : gjf
	 * @throws Exception 
	 */
	public String saveAjdjCbr(HttpServletRequest request, ZfajcbrDTO dto) {
		try {
			saveAjdjCbrImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * @Description: 保存案件承办人实现方法
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author CatchU
	 */
	@Aop( { "trans" })
	public void saveAjdjCbrImp(HttpServletRequest request, ZfajcbrDTO dto)
			throws Exception {
		//先删除，再插入
		String v_sql = " delete from zfajcbr where ajdjid = '" + dto.getAjdjid() + "'";
		Sql sql = Sqls.create(v_sql);
		dao.execute(sql);	
		
		JSONArray v_array = null;
		Object[]  v_objArray = null;
		// 承办人
		v_array = JSONArray.fromObject(dto.getAjcbr_table_rows());
		v_objArray = v_array.toArray();
		String v_ajcbrid = "";
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			ZfajcbrDTO v_ZfajcbrDTO = (ZfajcbrDTO) JSONObject.toBean(
					v_obj, ZfajcbrDTO.class);
			// 执法案件承办人
			Zfajcbr v_Zfajcbr = new Zfajcbr();
			v_ajcbrid = DbUtils.getSequenceStr();
			v_Zfajcbr.setAjcbrid(v_ajcbrid);//
			v_Zfajcbr.setAjdjid(dto.getAjdjid());//案件登记ID
			v_Zfajcbr.setUserid(v_ZfajcbrDTO.getUserid());//对应sysuser表ID，对应viewZfry中userid
			v_Zfajcbr.setZfryxm(v_ZfajcbrDTO.getZfryxm());//执法人员姓名
			v_Zfajcbr.setZfrysflx("1");//执法人员身份类型如1组员0组长见代表表zfrysflx
			//v_Zfajcbr.setZfryzjhm(zfryzjhm);//执法人员证件号码
			v_Zfajcbr.setZfrybmmc(v_ZfajcbrDTO.getZfrybmmc());//执法人员部门名称
			//v_Zfajcbr.setZfryzw(zfryzw);//执法人员职务
			dao.insert(v_Zfajcbr);
		}	
		
		// 协办人
		v_array = JSONArray.fromObject(dto.getAjxbr_table_rows());
		v_objArray = v_array.toArray();
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			ZfajcbrDTO v_ZfajcbrDTO = (ZfajcbrDTO) JSONObject.toBean(
					v_obj, ZfajcbrDTO.class);
			// 执法案件协办人
			Zfajcbr v_Zfajcbr = new Zfajcbr();
			v_ajcbrid = DbUtils.getSequenceStr();
			v_Zfajcbr.setAjcbrid(v_ajcbrid);//
			v_Zfajcbr.setAjdjid(dto.getAjdjid());//案件登记ID
			v_Zfajcbr.setUserid(v_ZfajcbrDTO.getUserid());//对应sysuser表ID，对应viewZfry中userid
			v_Zfajcbr.setZfryxm(v_ZfajcbrDTO.getZfryxm());//执法人员姓名
			v_Zfajcbr.setZfrysflx("2");//执法人员身份类型如1组员0组长见代表表zfrysflx
			//v_Zfajcbr.setZfryzjhm(zfryzjhm);//执法人员证件号码
			v_Zfajcbr.setZfrybmmc(v_ZfajcbrDTO.getZfrybmmc());//执法人员部门名称
			//v_Zfajcbr.setZfryzw(zfryzw);//执法人员职务
			dao.insert(v_Zfajcbr);
		}
		
		// 其他相关人员人
		v_array = JSONArray.fromObject(dto.getAjqtry_table_rows());
		v_objArray = v_array.toArray();
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			ZfajcbrDTO v_ZfajcbrDTO = (ZfajcbrDTO) JSONObject.toBean(
					v_obj, ZfajcbrDTO.class);
			// 其他相关人员人
			Zfajcbr v_Zfajcbr = new Zfajcbr();
			v_ajcbrid = DbUtils.getSequenceStr();
			v_Zfajcbr.setAjcbrid(v_ajcbrid);//
			v_Zfajcbr.setAjdjid(dto.getAjdjid());//案件登记ID
			v_Zfajcbr.setUserid(v_ZfajcbrDTO.getUserid());//对应sysuser表ID，对应viewZfry中userid
			v_Zfajcbr.setZfryxm(v_ZfajcbrDTO.getZfryxm());//执法人员姓名
			v_Zfajcbr.setZfrysflx("3");//执法人员身份类型如1组员0组长见代表表zfrysflx
			//v_Zfajcbr.setZfryzjhm(zfryzjhm);//执法人员证件号码
			v_Zfajcbr.setZfrybmmc(v_ZfajcbrDTO.getZfrybmmc());//执法人员部门名称
			//v_Zfajcbr.setZfryzw(zfryzw);//执法人员职务
			dao.insert(v_Zfajcbr);
		}		
	}
	
	/**
	 * 
	 * queryAjdjtjCount中文名称:查询案件登记统计信息
	 * queryAjdjtjCount概要描述:
	 * 
	 * written by  :  zy
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryAjdjtjCount(HttpServletRequest request,
			pubkeyDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select count(*) value,'案件已结束' name ");
		sb.append(" from zfajdj where ajjsbz='1'");
		sb.append(" union all select count(*) value,'案件正在处理' name ");
		sb.append(" from zfajdj where slbz='1'");
		sb.append(" union all select count(*) value,'案件已登记' name ");
		sb.append(" from zfajdj where ajjsbz='0'");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, pubkeyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * queryAjdjtjCount中文名称:查询案件登记统计信息
	 * queryAjdjtjCount概要描述:
	 * 
	 * written by  :  zy
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map ajdjtjByDaleiCount(HttpServletRequest request,
			pubkeyDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select count(*) value,'食品' name ");
		sb.append(" from zfajdj where aae140='100' ");
		sb.append(" union all select count(*) value,'药品' name ");
		sb.append(" from zfajdj where aae140='200' ");
		sb.append(" union all select count(*) value,'化妆品' name ");
		sb.append(" from zfajdj where aae140='300' ");
		sb.append(" union all select count(*) value,'保健食品' name ");
		sb.append(" from zfajdj where aae140='400' ");
		sb.append(" union all select count(*) value,'医疗器械' name ");
		sb.append(" from zfajdj where aae140='500' ");
		sb.append(" union all select count(*) value,'未分类' name ");
		sb.append(" from zfajdj where (aae140 = '' OR aae140 IS NULL) ");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, pubkeyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * ajdjtjByComDaleiCount的中文名称：案件统计分析
	 * 
	 * ajdjtjByComDaleiCount的概要说明：根据企业大类进行分类统计
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map ajdjtjByComDaleiCount(HttpServletRequest request,
			pubkeyDTO dto) throws Exception {
		// 先查询出有多少企业分类
		List<Aa10> aa = (List<Aa10>) dao.query(Aa10.class, Cnd.where("AAA100", "=", "COMDALEI"));
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < aa.size(); i++) {
			if (i == 0) {
				sb.append(" select count(t.comdalei) value,a.AAA103 name ");
				
			} else {
				sb.append(" union all select count(t.comdalei) value,a.AAA103 name ");
			}
			sb.append(" FROM aa10 a LEFT JOIN ");
			sb.append(" (select p1.comdalei  from zfajdj z, pcompany p, pcompanycomdalei p1 ");
			sb.append(" where z.commc = p.commc AND p.comid = p1.comid  )t ");
			sb.append(" ON a.AAA102 = t.comdalei ");
			sb.append(" WHERE a.AAA100 = 'COMDALEI' AND a.AAA102 = '").append(aa.get(i).getAaa102()).append("' ");
		}
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, pubkeyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * ajdjtjByAaa027Count的中文名称：案件统计分析
	 * 
	 * ajdjtjByAaa027Count的概要说明：根据企业所属统筹区进行统计分析
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map ajdjtjByAaa027Count(HttpServletRequest request,
			pubkeyDTO dto) throws Exception {
		
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();	
		String ls_aaa027 = "";
		if(sysuser != null){
		    ls_aaa027 = sysuser.getAaa027();
		}
		// 如果是驻马店市本级管理员，默认可以查全市的
		if (ls_aaa027 != null && ls_aaa027.startsWith("4117")) {
			ls_aaa027 = "411700000000"; 
		}
		// 先查询出下属区县乡
		List<Aa13> aa = (List<Aa13>) dao.query(Aa13.class, Cnd.where("AAA148", "=", ls_aaa027));
		// 查询出当前所属区域统计信息
		StringBuffer sb = new StringBuffer();
		sb.append(" select count(t.aaa027) value,a.AAA129 name ");
		sb.append(" FROM aa13 a LEFT JOIN ");
		sb.append(" (select p.aaa027  from zfajdj z, pcompany p ");
		sb.append(" where z.commc = p.commc )t ");
		sb.append(" ON a.AAA027 = t.aaa027 ");
		sb.append(" WHERE a.AAA027 = '").append(ls_aaa027).append("' ");
		// 查询出管辖区域统计信息
		for (int i = 0; i < aa.size(); i++) {
			sb.append(" union all select count(t.aaa027) value,a.AAA129 name ");
			sb.append(" FROM aa13 a LEFT JOIN ");
			sb.append(" (select p.aaa027  from zfajdj z, pcompany p ");
			sb.append(" where z.commc = p.commc )t ");
			sb.append(" ON a.AAA027 = t.aaa027 ");
			sb.append(" WHERE a.AAA027 = '").append(aa.get(i).getAaa027()).append("' ");
		}
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, pubkeyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * getAa10List的中文名称：案件统计分析
	 * 
	 * getAa10List的概要说明：根据企业所属统筹区进行统计分析
	 * @param aaa100
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Aa10> getAa10List(String aaa100) throws Exception {
		// sql查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from Aa10 a ");
		sb.append(" WHERE a.AAA100 = '").append(aaa100.toUpperCase())
				.append("'");
		sb.append(" order by a.AAA102 ASC ");
		String sql = sb.toString();
		Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa10.class);
		List<Aa10> ls = (List<Aa10>) map.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
	
	/**
	 * 
	 * queryaaa207Strlist的中文名称：获取统筹区
	 * 
	 * queryaaa207Strlist的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<String> queryaaa207Strlist(HttpServletRequest request, ZfajdjDTO dto) 
			throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		List<String> aaa129list = new ArrayList<String>();
		sb.append(" select h.AAA129 from aa13 h ");
		sb.append(" where 1=1 ");
		sb.append(" and h.AAA027 like :aaa027 ");
		sb.append(" and (h.AAE383 = 4 or h.AAE383 = 3) ");
		sb.append(" ORDER BY h.AAA027");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{ "aaa027" };
		int[] paramType = new int[]{ Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa13.class);
		List<Aa13> list = (List<Aa13>) m.get(GlobalNames.SI_RESULTSET);
		if (list.size() > 0) {
			for(Aa13 aa13 : list){
				aaa129list.add(aa13.getAaa129());
			}
		}
		return aaa129list;
	}
	
	/**
	 * TODO
	 * queryZfajNumByAaa027的中文名称：获取案件统计
	 * 
	 * queryZfajNumByAaa027的概要说明：根据统筹区获取案件登记统计信息
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Integer> queryZfajNumByAaa027(HttpServletRequest request,
			ZfajdjDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("  select IFNULL(f.pajdjcount,0) value ,g.aaa129 name  ");
		sb.append("  from (select * from aa13 h where h.AAA027 like '%410523%'  ");
		sb.append("  and (h.AAE383 = 4 or h.AAE383 = 3)) g  ");
		sb.append("  LEFT JOIN ( SELECT sum(d.count) pajdjcount, d.AAA027, d.ajdjid, d.aae140  from ");
		sb.append("  (select count(*) count, aj.AAA027, aj.ajdjid, aj.aae140  ");
		sb.append("  from zfajdj aj where 1 = 1 ");
		sb.append(" and aj.aae140 = '").append(dto.getAae140()).append("' ");
		// 案件受理标识
		if (dto.getSlbz() != null && !"".equals(dto.getSlbz())) {
			sb.append(" and aj.slbz = '").append(dto.getSlbz()).append("' ");
		}
		// 案件结束标识
		if (dto.getAjjsbz() != null && !"".equals(dto.getAjjsbz())) {
			sb.append(" and aj.ajjsbz = '").append(dto.getAjjsbz()).append("' ");
		}
		sb.append("  GROUP BY aj.ajdjid ) d ");
		sb.append("  GROUP BY d.AAA027, d.aae140) f  ");
		sb.append("  on f.AAA027 = g.AAA027 ");
		sb.append("  where  (ISNULL(f.aae140) or f.aae140 = '").append(dto.getAae140()).append("' ");
		sb.append(" ) order by  g.aaa027 ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{};
		int[] paramType = new int[]{};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println("sql====================" + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, pubkeyDTO.class);
		List<pubkeyDTO> list = (List<pubkeyDTO>) m.get(GlobalNames.SI_RESULTSET);
		List<Integer> serieslist = new ArrayList<Integer>();
		if(list.size()>0){
			for(pubkeyDTO master: list){
				serieslist.add(Integer.parseInt(master.getValue()));
			}
		}
		return serieslist;
	}
	
}
