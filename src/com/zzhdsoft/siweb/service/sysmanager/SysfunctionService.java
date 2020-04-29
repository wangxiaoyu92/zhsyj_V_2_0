package com.zzhdsoft.siweb.service.sysmanager;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.entity.sysmanager.Sysfunction;
import com.zzhdsoft.siweb.entity.sysmanager.Sysrolefunction;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.db.DbUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * SysfunctionService的中文名称:系统菜单Service
 * 
 * SysfunctionService的描述:
 * 
 * Written by : zjf
 */
@IocBean
public class SysfunctionService extends BaseService {
	protected final Logger logger = Logger.getLogger(SysfunctionService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * getSysfunctionById的中文名称：根据id获取菜单项
	 * 
	 * getSysfunctionById的概要说明:
	 * 
	 * @param functionId
	 * @return Written by : zjf
	 * 
	 */
	public List getSysfunctionById(final String functionId) {
		return dao.query(Sysfunction.class, Cnd.where("functionid", "=", functionId));
	}

	/**
	 * 
	 * saveSysfunction的中文名称：保存菜单项
	 * 
	 * saveSysfunction的概要说明:
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String saveSysfunction(HttpServletRequest request, final Sysfunction dto) {
		try {
			saveSysfunctionImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveSysfunctionImp(HttpServletRequest request, Sysfunction dto) throws Exception {
		// 特殊处理一级菜单的父菜单ID
		if ("0".equals(dto.getParent())) {
			dto.setParent(null);
		}
		if (!Strings.isBlank(dto.getFunctionid())) {// 修改
			Sysfunction sysfunction = dao.fetch(Sysfunction.class, dto.getFunctionid());
			BeanHelper.copyProperties(dto, sysfunction);
			dao.update(sysfunction);
		} else {// 新增
			Sysfunction sysfunction = new Sysfunction();
			BeanHelper.copyProperties(dto, sysfunction);
			// Long functionid = DbUtils.getSequenceL("sq_functionid");
			String functionid = DbUtils.getSequenceStr();
			sysfunction.setFunctionid(functionid);
			dao.insert(sysfunction);
			// 自动插入到超级管理员角色权限中
			Sysrolefunction s = new Sysrolefunction();
			String rolefunctionid = DbUtils.getSequenceStr();
			s.setRolefunctionid(rolefunctionid);
			s.setRoleid("0");
			s.setFunctionid(functionid);
			dao.insert(s);
		}
	}

	/**
	 * 
	 * delSysfunction的中文名称：根据id删除菜单项
	 * 
	 * delSysfunction的概要说明:
	 * 
	 * @param functionId
	 * @return Written by : zjf
	 * 
	 */
	public String delSysfunction(HttpServletRequest request, final String functionId) {
		// 1.检查是否可删除(暂时没有实现？？？)
		// 2.删除菜单表sysfunction
		// 3.删除角色权限表sysrolefunction
		try {
			delSysfunctionImp(request, functionId);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delSysfunctionImp(HttpServletRequest request, final String functionId) {
		if (!(functionId == null || "".equals(functionId))) {
			// 删除菜单
			dao.clear(Sysfunction.class, Cnd.where("functionid", "=", functionId));
			// 删除子菜单
			dao.clear(Sysfunction.class, Cnd.where("parent", "=", functionId));
			// 删除角色权限表
			dao.clear(Sysrolefunction.class, Cnd.where("functionid", "=", functionId));
		}
	}

	/**
	 * 
	 * querySysfunctionByUserid的中文名称：组装查询用户权限sql语句
	 * 
	 * querySysfunctionByUserid的概要说明：flag=1,不包含按钮
	 * 
	 * @param userid
	 * @param userkind
	 * @param flag
	 * @param systemcode
	 * @return Written by : zjf
	 * 
	 */
	public String querySysfunctionByUserid(String userid, String userkind, String flag, String systemcode) {
		String haveBtn = "";
		String haveBtn1 = "";
		if ("1".equals(flag)) {
			haveBtn = " and (t.type !='2' or t.type is null) ";
			haveBtn1 = " and (t1.type !='2' or t1.type is null) ";
		}

		String sb = "";
		sb += " select functionid,title,location,parent,orderno,imageurl,type,visible,description,bizid,childnum,target,systemcode,parentname,";
		sb += " case when childnum > 0 then 'true' else 'false' end isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end isopen ";
		sb += " from(";
		sb += " select t.functionid,t.title,t.location,t.parent,t.orderno,t.imageurl,t.type,t.visible,t.description,t.bizid,";
		sb += " (select count(t1.functionid) from Sysfunction t1 where t1.parent=t.functionid ";
		sb += " and (t1.visible !='0' or t1.visible is null) " + haveBtn1 + ") childnum,target,systemcode, ";
		sb += " (select t2.title from Sysfunction t2 where t2.functionid = t.parent) parentname ";
		sb += " from Sysfunction t ";
		sb += " where (t.visible !='0' or t.visible is null) " + haveBtn;
		if (null != userid) {
			sb += " and exists";
			sb += " (select 1 from (";
			// sb += " select distinct parent as functionid";
			// sb += "   from sysfunction s4";
			// sb += "  where functionid in (";
			// sb += " select functionid";
			// sb += "   from sysrolefunction s1";
			// sb += "  where roleid in (select roleid";
			// sb += "                     from sysuserrole s2";
			// sb += "                    where userid = " + userid + " ))";
			// sb += " union all";
			// sb += " select functionid";
			// sb += "   from sysrolefunction s1";
			// sb += "  where roleid in (select roleid";
			// sb += "                     from sysuserrole s2";
			// sb += "                    where userid = " + userid + " )";

			sb += " SELECT DISTINCT parent AS functionid ";
			sb += " FROM sysfunction s4,sysrolefunction s1,sysuserrole s2 ";
			sb += " WHERE s4.functionid=s1.functionid ";
			sb += "  AND s1.roleid=s2.roleid ";
			sb += "  AND s2.userid='" + userid;
			sb += "' union all";
			sb += " select functionid";
			sb += "   from sysrolefunction s1,sysuserrole s2 ";
			sb += "  where s1.roleid=s2.roleid and s2.userid='" + userid;
			sb += "' ) u";
			sb += " where u.functionid = t.functionid)";
			sb += " order by t.orderno";
		}
		sb += " ) h";// mysql
		if(Strings.isNotBlank(systemcode)){
			sb += " where systemcode = '" + systemcode + "'";
		}
		// sb +=
		// " start with  t.parent is null connect by prior t.functionid=t.parent) h";//oracle
		System.out.println("sysfunction " + sb.toString());
		return sb;
	}

	/**
	 * 
	 * isExistsFuncByUrl的中文名称：检查用户是否有这个功能模块的操作权限
	 * 
	 * isExistsFuncByUrl的概要说明：
	 * 
	 * @param userid
	 * @param userkind
	 * @param url
	 * @return Written by : zjf
	 * 
	 */
	public int isExistsFuncByUrl(String userid, String userkind, String url) {
		String sql = querySysfunctionByUserid(userid, userkind, "0", "");
		StringBuffer sbsql = new StringBuffer();
		sbsql.append(" select count(*) as cnt from( ");
		sbsql.append(sql);
		sbsql.append(" ) h where location = '").append(url).append("' ");

		String v = DbUtils.getOneValue(dao, sbsql.toString());
		return Integer.valueOf(v).intValue();
	}

	/**
	 * 
	 * querySysfunctionTree的中文名称：按easyui tree格式构造菜单树
	 * 
	 * querySysfunctionTree的概要说明:
	 * 
	 * @param userid
	 * @param flag
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public List querySysfunctionTree(final String userid, final String userkind, final String flag, final String systemcode) throws Exception {
		List resLs = new ArrayList();
		List ls = querySysfunctionZTree(userid, userkind, flag, systemcode);
		for (int i = 0; i < ls.size(); i++) {
			Sysfunction s = (Sysfunction) ls.get(i);
			if (s.getParent() == null || "".equals(s.getParent())) {
				Map cm = new HashMap();
				cm.put("id", s.getFunctionid());
				cm.put("text", s.getTitle());
				cm.put("attributes", "url:" + s.getLocation());
				// cm.put("attributes", "{\"url\":\"" + s.getLocation() +
				// "\"}");
				cm.put("children", getFuncChild(ls, s.getFunctionid().toString()));
				resLs.add(cm);
			}
		}
		return resLs;
	}

	/**
	 * 
	 * getFuncChild的中文名称：递归调用
	 * 
	 * getFuncChild的概要说明：
	 * 
	 * @param funlist
	 * @param parentid
	 * @return Written by : zjf
	 * 
	 */
	private List getFuncChild(List funlist, final String parentid) {
		List resLs = new ArrayList();
		for (int i = 0; i < funlist.size(); i++) {
			Sysfunction s = (Sysfunction) funlist.get(i);
			if (s.getParent() != null && parentid.equals(s.getParent().toString())) {
				Map cm = new HashMap();
				cm.put("id", s.getFunctionid());
				cm.put("text", s.getTitle());
				cm.put("attributes", "{\"url\":\"" + s.getLocation() + "\"}");
				if (s.getChildnum() > 0) {
					cm.put("children", getFuncChild(funlist, s.getFunctionid().toString()));
				}
				resLs.add(cm);

			}
		}
		return resLs;
	}

	/**
	 * 
	 * querySysfunctionZTree的中文名称：按Ztree插件格式构造菜单树
	 * 
	 * querySysfunctionZTree的概要说明：flag=1,不包含按钮
	 * 
	 * @param userid
	 * @param userkind
	 * @param flag
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List querySysfunctionZTree(String userid, String userkind, String flag, String systemcode) throws Exception {
		String sql = querySysfunctionByUserid(userid, userkind, flag, systemcode);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysfunction.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
	
	/**
	 * 
	 * querySysfunctionAll的中文名称：查询所有的菜单
	 * 
	 * querySysfunctionAll的概要说明：
	 * 
	 * @param prm_menutype //结点类型：菜单节点是0，菜单叶子是1，按钮是2',
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public List querySysfunctionAll(String prm_menutype) throws Exception {
		String sql = "select * from sysfunction where type='"+prm_menutype+"'";
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysfunction.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}	

	/**
	 * 
	 * querySysfunctionZTreeAsync的中文名称：按Ztree插件格式构造菜单树
	 * 
	 * querySysfunctionZTreeAsync的概要说明：异步加载（传入父节点ID）
	 * 
	 * @param userid
	 * @param userkind
	 * @param flag
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List querySysfunctionZTreeAsync(HttpServletRequest request, String userid, String userkind, String flag) throws Exception {
		String functionid = StringHelper.showNull2Empty(request.getParameter("functionid"));

		String haveBtn = "";
		String haveBtn1 = "";
		if ("1".equals(flag)) {
			haveBtn = " and (t.type !='2' or t.type is null) ";
			haveBtn1 = " and (t1.type !='2' or t1.type is null) ";
		}

		String sb = "";
		sb += " select functionid,title,location,parent,orderno,type,visible,imageurl,description,bizid,childnum,target,systemcode,parentname,";
		sb += " case when childnum > 0 then 'true' else 'false' end isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end isopen ";
		sb += " from(";
		sb += " select t.functionid,t.title,t.location,t.parent,t.orderno,t.type,t.visible,t.imageurl,t.description,t.bizid,";
		sb += " (select count(t1.functionid) from Sysfunction t1 where t1.parent=t.functionid ";
		//sb += " and (t1.visible !='0' or t1.visible is null) " + haveBtn1 + ") childnum,target,systemcode, ";
		sb += " and 1=1 " + haveBtn1 + ") childnum,target,systemcode, ";
		sb += " (select t2.title from Sysfunction t2 where t2.functionid = t.parent) parentname ";
		sb += " from Sysfunction t ";
		//sb += " where (t.visible !='0' or t.visible is null) " + haveBtn;
		sb += " where 1=1 " + haveBtn;

		if (Strings.isBlank(functionid)) {
			sb += " and (t.parent = '' or t.parent is null)";
		} else {
			sb += " and t.parent = '" + functionid + "'";
		}		
		sb += " order by t.orderno";
		sb += " ) h";// mysql
		// sb +=
		// " start with  t.parent is null connect by prior t.functionid=t.parent) h";//oracle
		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, Sysfunction.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
}
