package com.zzhdsoft.siweb.service.sysmanager;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa13;
import com.zzhdsoft.siweb.entity.sysmanager.Sysorg;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * SysorgService的中文名称：机构管理service
 * 
 * SysorgService的描述：
 * 
 * Written by : zjf
 */
public class SysorgService extends BaseService {
	protected final Logger logger = Logger.getLogger(SysorgService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * querySysorgByOrgcode的中文名称：查询机构
	 * 
	 * querySysorgByOrgcode的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * 
	 */
	public Map querySysorgByOrgcode(Sysorg dto, PagesDTO pd) {
		Cnd c = null;
		c = Cnd.where("1", "=", "1");
		c.and("lower(orgcode)", "=", dto.getOrgcode().toLowerCase());

		Map r = new HashMap();
		r.put("rows", dao.query(Sysorg.class, c, SysmanageUtil.getPager(pd)));
		r.put("total", dao.count(Sysorg.class, c));
		return r;
	}

	/**
	 * 
	 * querySysorg的中文名称：查询机构
	 * 
	 * querySysorg的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * 
	 */
	public Map querySysorg(Sysorg dto, PagesDTO pd) {
		Cnd c = null;
		c = Cnd.where("1", "=", "1");
		if (!Strings.isEmpty(dto.getOrgname())) {
			c.and("orgname", "like", "%" + dto.getOrgname() + "%");
		}
		if (!Strings.isEmpty(dto.getOrgcode())) {
			c.and("orgcode", "=", dto.getOrgcode());
		}
		if (null != dto.getOrgid()) {
			c.and("orgid", "=", dto.getOrgid());
		}
		c.asc("orgid");

		Map r = new HashMap();
		r.put("rows", dao.query(Sysorg.class, c, SysmanageUtil.getPager(pd)));
		r.put("total", dao.count(Sysorg.class, c));
		return r;
	}

	/**
	 * 
	 * isExistsOrgcode的中文名称：校验机构编码是否存在
	 * 
	 * isExistsOrgcode的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String isExistsOrgcode(Sysorg dto) throws Exception {
		// 校验机构是否已经存在
		PagesDTO pd = new PagesDTO();
		Map m = querySysorgByOrgcode(dto, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			return "该机构已存在，机构编码不能重复！";
		}
		return null;
	}

	/**
	 * 
	 * saveSysorg的中文名称：保存机构
	 * 
	 * saveSysorg的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String saveSysorg(HttpServletRequest request, final Sysorg dto) {
		try {
			String flag;
			if (Strings.isNotBlank(dto.getOrgid())) {
				Sysorg se = dao.fetch(Sysorg.class, dto.getOrgid());
				if (!(se.getOrgcode()).equalsIgnoreCase(dto.getOrgcode())) {
					flag = isExistsOrgcode(dto);
					if (flag != null) {
						return flag;
					}
				}
			} else {
				flag = isExistsOrgcode(dto);
				if (flag != null) {
					return flag;
				}
			}

			saveSysorgImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveSysorgImp(HttpServletRequest request, Sysorg dto) throws Exception {
		// 特殊处理一级菜单的父菜单ID
		if ("0".equals(dto.getParent())) {
			dto.setParent(null);
		}
		if (Strings.isNotBlank(dto.getOrgid())) {
			Sysorg sysorg = dao.fetch(Sysorg.class, dto.getOrgid());
			BeanHelper.copyProperties(dto, sysorg);
			dao.update(sysorg);
		} else {
			Sysorg sysorg = new Sysorg();
			String orgid = DbUtils.getSequenceStr();
			dto.setOrgid(orgid);
			BeanHelper.copyProperties(dto, sysorg);
			//gu20160818add机构编码后台自动生成
			Sysorg v_sysorg=dao.fetch(Sysorg.class, Cnd.where("orgid","=",dto.getParent()));
			String v_neworgcode=SysmanageUtil.fun_getOrgCode(v_sysorg.getOrgcode(),dto.getParent());
			sysorg.setOrgcode(v_neworgcode);
			
			dao.insert(sysorg);
		}
	}

	/**
	 * 
	 * delSysorg的中文名称：删除机构
	 * 
	 * delSysorg的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delSysorg(HttpServletRequest request, final Sysorg dto) {
		try {
			if (Strings.isNotBlank(dto.getOrgid())) {
				// 检查是否可删除
				List sysorgList = dao.query(Sysorg.class, Cnd.where("orgid", "=", dto.getOrgid()).and("orgkind", "=", "1"));
				if (sysorgList != null && sysorgList.size() > 0) {
					return "该机构不允许被删除！";
				}
				delSysorgImp(request, dto);
			} else {
				return "没有接收到要删除的机构ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delSysorgImp(HttpServletRequest request, final Sysorg dto) {
		// 删除机构
		dao.clear(Sysorg.class, Cnd.where("orgid", "=", dto.getOrgid()));
	}

	/**
	 * 
	 * querySysorgZTreeAsync的中文名称：根据Ztree插件的树格式，组装机构树。
	 * 
	 * querySysorgZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List querySysorgZTreeAsync(HttpServletRequest request) throws Exception {
		String orgid = StringHelper.showNull2Empty(request.getParameter("orgid"));
		String v_querykind = StringHelper.showNull2Empty(request.getParameter("querykind"));
		
		String parent = "";
		if ("".equals(orgid)) {
			String orgcode = SysmanageUtil.getSysuserOrgcode();
			Sysorg sysorg = dao.fetch(Sysorg.class, Cnd.where("orgcode", "=", orgcode));
			parent = StringHelper.showNull2Empty(sysorg.getOrgid());
		} else {
			parent = orgid;
		}

		String sb = "";
		sb += " select orgid,orgname,shortname,orgdesc,parent,parentname,";
		sb += " address,principal,linkman,tel,orgkind,orgcode,orderno,fz,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isopen ";
		sb += " from(";
		sb += " select t.orgid,t.orgname,t.shortname,t.orgdesc,t.parent,";
		sb += " t.address,t.principal,t.linkman,t.tel,t.orgkind,t.orgcode,t.orderno,t.fz,";
		sb += " (select count(t1.orgid) from Sysorg t1 where t1.parent = t.orgid) childnum, ";
		sb += " (select t2.orgname from Sysorg t2 where t2.orgid = t.parent) parentname ";
		sb += " from Sysorg t ";
		sb += " where 1=1 ";
        if (!"all".equalsIgnoreCase(v_querykind)){
    		if ("".equals(orgid)) {
    			sb += " and t.orgid = '" + parent + "'";
    		} else {
    			sb += " and t.parent = '" + parent + "'";
    		}        	
        }
		sb += " ) h ";// mysql

		// sb +=
		// " start with t.parent is null connect by prior t.orgid = t.parent) h";

		Map m = DbUtils.DataQuery("sql", sb, null, Sysorg.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List querySysorgZTreeAsyncgw(HttpServletRequest request) throws Exception {
		String orgid = StringHelper.showNull2Empty(request.getParameter("orgid"));
		String v_querykind = StringHelper.showNull2Empty(request.getParameter("querykind"));

		String parent = "";
		if ("".equals(orgid)) {
			String orgcode = SysmanageUtil.getSysuserOrgcode();
			Sysorg sysorg = dao.fetch(Sysorg.class, Cnd.where("orgcode", "=", orgcode));
			parent = StringHelper.showNull2Empty(sysorg.getOrgid());
		} else {
			parent = orgid;
		}

		String sb = "";
		sb += " select orgid,orgname,shortname,orgdesc,parent,parentname,";
		sb += " address,principal,linkman,tel,orgkind,orgcode,orderno,fz,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isopen ";
		sb += " from(";
		sb += " select t.orgid,t.orgname,t.shortname,t.orgdesc,t.parent,";
		sb += " t.address,t.principal,t.linkman,t.tel,t.orgkind,t.orgcode,t.orderno,t.fz,";
		sb += " (select count(t1.orgid) from Sysorg t1 where t1.parent = t.orgid) childnum, ";
		sb += " (select t2.orgname from Sysorg t2 where t2.orgid = t.parent) parentname ";
		sb += " from Sysorg t ";
		sb += " where 1=1 ";
		sb += " and substring(t.PARENT, 1, 2)='20'";

		sb += " ) h ";// mysql

		// sb +=
		// " start with t.parent is null connect by prior t.orgid = t.parent) h";

		Map m = DbUtils.DataQuery("sql", sb, null, Sysorg.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public List querySystcqJxmZTree(HttpServletRequest request) throws Exception {
		String orgid = StringHelper.showNull2Empty(request.getParameter("orgid"));
		String parent = "";
		if ("".equals(orgid)) {
			parent = "2018032611020776143872669";
		} else {
			parent = orgid;
		}
		String sb = "";
		sb += "SELECT a.orgid,a.orgname,a.parent,b.userid fz";
		sb += " from sysorg a";
		sb += " left join sysuser b on a.ORGID=b.ORGID and b.userposition='3'";
		sb += " where 1=1";
		sb += " and substring(a.PARENT, 1, 2)='20'";
		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
				Sysorg.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	public String queryS(HttpServletRequest request) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		String sb = "";
		sb += " SELECT b.userid fz";
		sb += " from sysorg a";
		sb += " left join sysuser b on a.ORGID=b.ORGID and b.userposition='3'";
		sb += " where 1=1";
		sb += " and b.orgid = '" +vSysUser.getOrgid() + "'";
		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
				Sysorg.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Sysorg s=(Sysorg)ls.get(0);
		String fz=s.getFz();
		return fz;
	}
	/**
	 * 
	 * querySysorgZTree的中文名称：按Ztree插件格式构造机构树
	 * 
	 * querySysorgZTree的概要说明：
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List querySysorgZTree(HttpServletRequest request) throws Exception {
		String orgcode = SysmanageUtil.getSysuserOrgcode();
		orgcode = orgcode.replaceAll("0*$", "");

		String sb = "";
		sb += " select orgid,orgname,shortname,orgdesc,parent,parentname,";
		sb += " address,principal,linkman,tel,orgkind,orgcode,orderno,fz,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isopen ";
		sb += " from(";
		sb += " select t.orgid,t.orgname,t.shortname,t.orgdesc,t.parent,";
		sb += " t.address,t.principal,t.linkman,t.tel,t.orgkind,t.orgcode,t.orderno,t.fz,";
		sb += " (select count(t1.orgid) from Sysorg t1 where t1.parent = t.orgid) childnum, ";
		sb += " (select t2.orgname from Sysorg t2 where t2.orgid = t.parent) parentname ";
		sb += " from Sysorg t ";
		sb += " where 1=1 ";
		sb += " and t.orgcode like '" + orgcode + "%'";
		sb += " ) h ";// mysql

		// sb +=
		// " start with t.parent is null connect by prior t.orgid = t.parent) h";

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, Sysorg.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * querySysorgTree的中文名称：按easyui tree格式构造机构树
	 * 
	 * querySysorgTree的概要说明:
	 * 
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public List querySysorgTree(HttpServletRequest request) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String orgid = sysuser.getOrgid();
		List resLs = new ArrayList();
		List ls = querySysorgZTree(request);
		for (int i = 0; i < ls.size(); i++) {
			Sysorg s = (Sysorg) ls.get(i);
			if (s.getParent() == null || "".equals(s.getParent()) || (StringHelper.cpObj(s.getOrgid(), orgid))) {
				Map cm = new HashMap();
				cm.put("id", s.getOrgid());
				cm.put("text", s.getOrgname());
				cm.put("children", getOrgChild(ls, s.getOrgid().toString()));
				resLs.add(cm);
			}
		}
		return resLs;
	}

	/**
	 * 
	 * getOrgChild的中文名称：递归调用
	 * 
	 * getOrgChild的概要说明：
	 * 
	 * @param orglist
	 * @param parentid
	 * @return Written by : zjf
	 * 
	 */
	private List getOrgChild(List orglist, final String parentid) {
		List resLs = new ArrayList();
		for (int i = 0; i < orglist.size(); i++) {
			Sysorg s = (Sysorg) orglist.get(i);
			if (s.getParent() != null && parentid.equals(s.getParent().toString())) {
				Map cm = new HashMap();
				cm.put("id", s.getOrgid());
				cm.put("text", s.getOrgname());
				if (s.getChildnum() > 0) {
					cm.put("children", getOrgChild(orglist, s.getOrgid().toString()));
				}
				resLs.add(cm);
			}
		}
		return resLs;
	}

	/**
	 * 
	 * querySystcqZTreeAsync的中文名称：按Ztree插件格式构造统筹区树
	 * 
	 * querySystcqZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	public List querySystcqZTreeAsync(HttpServletRequest request) throws Exception {
		String v_opkind=StringHelper.showNull2Empty(request.getParameter("opkind"));
		String aaa027flag = StringHelper.showNull2Empty(request.getParameter("aaa027flag"));
		String aaa027lev = StringHelper.showNull2Empty(request.getParameter("aaa027lev"));
		String aaa027 = StringHelper.showNull2Empty(request.getParameter("aaa027"));//统筹区树节点入参
		String aaa027Sysuer = StringHelper.showNull2Empty(request.getParameter("aaa027Sysuer"));//手机APP入参
		String ndwj = StringHelper.showNull2Empty(request.getParameter("ndwj"));//你点我检
//		String aaa027SysuseNoZero = aaa027Sysuer.replaceAll("0*$", "");
		if ("".equals(aaa027Sysuer)) {
			Sysuser v_sysuser= SysmanageUtil.getSysuser();
			if (v_sysuser!=null){
			   aaa027Sysuer = StringHelper.showNull2Empty(v_sysuser.getAaa027());
			}
		}

		String aaa148 = "";
		if ("".equals(aaa027)) {
			if ("0".equals(aaa027flag)) {
				aaa148 = "0";// 根节点
			} else {
				aaa148 = aaa027Sysuer;// 过滤操作员统筹区
			}
			//驻马店单位信息 要求看到全市地区编码 这里做特殊处理
			if (v_opkind!=null && "addcompany".equals(v_opkind)
					&& "411799000000".equals(aaa148)){
				aaa148="411700000000";
			}				
		} else {
			aaa148 = aaa027;
		}

		String sb = "";
		sb += " select aaa027,aaa129,aaa129 aaa027name,aaa148,aaa148name,aae383,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end isopen  ";
		sb += " from(";
		sb += " select t.aaa027,t.aaa129,t.aaa148,t.aae383,t.baz002, ";
		sb += " (select count(t1.aaa027) from Aa13 t1 where t1.aaa148 = t.aaa027) childnum, ";
		sb += " (select t2.aaa129 from Aa13 t2 where t2.aaa027 = t.aaa148) aaa148name ";
		sb += " from Aa13 t  ";
		sb += " where 1=1 ";
		if (!"ndwj".equals(ndwj)) {
			if ("".equals(aaa027)) {
				if ("0".equals(aaa027flag)) {
					sb += " and t.aaa148 = '" + aaa148 + "'";
				} else {
					sb += " and t.aaa027 = '" + aaa148 + "'";
				}
			} else {
				sb += " and t.aaa148 = '" + aaa148 + "'";
			}
		}

		if (!Strings.isBlank(aaa027lev)) {// 过滤行政区划级别
			sb += " and t.aae383 <= " + aaa027lev;
		}
		// 20171124zy 对灵宝的特殊处理
//		if ("411282".equals(aaa027Sysuer.substring(0, 6))){
//			sb+=" and t.aaa027 like '%"+aaa027SysuseNoZero+"%'";
//		}
		sb += " ) h ";// mysql
System.out.println("querySystcqZTreeAsync "+sb.toString());
		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, Aa13.class);
		
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * querySystcqZTree的中文名称：按Ztree插件格式构造统筹区树
	 * 
	 * querySystcqZTree的概要说明：
	 * 
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	public List querySystcqZTree(HttpServletRequest request) throws Exception {
		String aaa027 = SysmanageUtil.getSysuser().getAaa027();
		// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
		aaa027 = SysmanageUtil.getSysuserAaa027(aaa027);

		String sb = "";
		sb += " select aaa027,aaa129,aab301,aaa148,childnum,aaa027name,";
		sb += " case when childnum > 0 then 'true' else 'false' end isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end isopen  ";
		sb += " from(";
		sb += " select t.aaa027,t.aaa129,t.aab301,t.aaa148, ";
		sb += " (select count(t1.aaa027) from Aa13 t1 where t1.aaa148 = t.aaa027) childnum, ";
		sb += " (select t2.aaa129 from Aa13 t2 where t2.aaa027 = t.aaa148) aaa027name ";
		sb += " from Aa13 t  ";
		sb += " where 1=1 ";
		sb += " and t.aaa148 like '" + aaa027 + "%'";
		sb += " ) h ";// mysql

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, Aa13.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 * 
	 * querySystcqTree的中文名称：按easyui tree格式构造统筹区树
	 * 
	 * querySystcqTree的概要说明:
	 * 
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	public List querySystcqTree(HttpServletRequest request) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String aaa027 = sysuser.getAaa027();
		List resLs = new ArrayList();
		List ls = querySystcqZTree(request);
		for (int i = 0; i < ls.size(); i++) {
			Aa13 s = (Aa13) ls.get(i);
			if (s.getAaa148() == null || "0".equals(s.getAaa148()) || (StringHelper.cpObj(s.getAaa027(), aaa027))) {
				Map cm = new HashMap();
				cm.put("id", s.getAaa027());
				cm.put("text", s.getAaa129());
				cm.put("children", getTcqChild(ls, s.getAaa027()));
				resLs.add(cm);
			}
		}
		return resLs;
	}

	/**
	 * 
	 * getTcqChild的中文名称：统筹区递归调用
	 * 
	 * getTcqChild的概要说明：
	 * 
	 * @param tcqlist
	 * @param parentid
	 * @return Written by : zjf
	 * 
	 */
	private List getTcqChild(List tcqlist, final String parentid) {
		List resLs = new ArrayList();
		for (int i = 0; i < tcqlist.size(); i++) {
			Aa13 s = (Aa13) tcqlist.get(i);
			if (s.getAaa148() != null && parentid.equals(s.getAaa148())) {
				Map cm = new HashMap();
				cm.put("id", s.getAaa027());
				cm.put("text", s.getAaa129());
				if (s.getChildnum() > 0) {
					cm.put("children", getTcqChild(tcqlist, s.getAaa027()));
				}
				resLs.add(cm);
			}
		}
		return resLs;
	}
}
