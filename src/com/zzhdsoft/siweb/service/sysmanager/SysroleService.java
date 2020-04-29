package com.zzhdsoft.siweb.service.sysmanager;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.sysmanager.*;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 
 * SysroleService的中文名称：角色管理service
 * 
 * SysroleService的描述：
 * 
 * Written by : zjf
 */
public class SysroleService extends BaseService {
	protected final Logger logger = Logger.getLogger(SysroleService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * querySysroleByRolename的中文名称：查询角色
	 * 
	 * querySysroleByRolename的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public Map querySysroleByRolename(Sysrole dto, PagesDTO pd) throws Exception {
		Cnd c = null;
		c = Cnd.where("1", "=", "1");
		c.and("lower(rolename)", "=", dto.getRolename().toLowerCase());

		Map r = new HashMap();
		r.put("rows", dao.query(Sysrole.class, c, SysmanageUtil.getPager(pd)));
		r.put("total", dao.count(Sysrole.class, c));
		return r;
	}

	/**
	 * 
	 * querySysrole的中文名称：查询角色
	 * 
	 * querySysrole的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public Map querySysrole(Sysrole dto, PagesDTO pd) throws Exception {
		String orgcode;
		String orgid = dto.getOrgid();
		if (Strings.isBlank(orgid)) {
			orgcode = SysmanageUtil.getSysuserOrgcode();
		} else {
			Sysorg se = dao.fetch(Sysorg.class, orgid);
			orgcode = se.getOrgcode();
		}
		orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" select roleid, rolename, roledesc,sysroleflag,a.orgid,b.orgname");
		sb.append(" from sysrole a,sysorg b");
		sb.append(" where 1=1");
		sb.append("  and a.orgid = b.orgid");
		sb.append("  and roleid = :roleid");
		sb.append("  and rolename like :rolename");
		sb.append("  and roledesc like :roledesc");
		sb.append("  and sysroleflag = :sysroleflag");
		sb.append("  and b.orgcode like '").append(orgcode).append("%'");
		sb.append("  order by roleid");
		String sql = sb.toString();
		String[] ParaName = new String[] { "roleid", "rolename", "roledesc", "sysroleflag" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysrole.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * isExistsRolename的中文名称：校验角色名称是否存在
	 * 
	 * isExistsRolename的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String isExistsRolename(Sysrole dto) throws Exception {
		// 校验角色名称是否已经存在
		PagesDTO pd = new PagesDTO();
		Map m = querySysroleByRolename(dto, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			return "该角色已存在，角色名称不能重复！";
		}
		return null;
	}

	/**
	 * 
	 * addSysrole的中文名称：新增角色
	 * 
	 * addSysrole的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */

	public String addSysrole(HttpServletRequest request, final Sysrole dto) {
		try {
			String flag;
			flag = isExistsRolename(dto);
			if (flag != null) {
				return flag;
			}

			addSysroleImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addSysroleImp(HttpServletRequest request, Sysrole dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();// 1.

		Sysrole se = new Sysrole();
		String roleid = DbUtils.getSequenceStr();
		dto.setRoleid(roleid);
		BeanHelper.copyProperties(dto, se);
		dao.insert(se);

		Timestamp endTime = SysmanageUtil.currentTime();// 2.
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);// 3.
	}

	/**
	 * 
	 * updateSysrole的中文名称：修改角色
	 * 
	 * updateSysrole的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */

	public String updateSysrole(HttpServletRequest request, final Sysrole dto) {
		try {
			String flag;
			Sysrole se = dao.fetch(Sysrole.class, dto.getRoleid());
			if (!(se.getRolename()).equalsIgnoreCase(dto.getRolename())) {
				flag = isExistsRolename(dto);
				if (flag != null) {
					return flag;
				}
			}

			updateSysroleImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateSysroleImp(HttpServletRequest request, Sysrole dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();// 1.

		Sysrole se = dao.fetch(Sysrole.class, dto.getRoleid());
		se.setRolename(dto.getRolename());
		se.setRoledesc(dto.getRoledesc());
		se.setSysroleflag(dto.getSysroleflag());
		se.setOrgid(dto.getOrgid());
		dao.update(se);

		Timestamp endTime = SysmanageUtil.currentTime();// 2.
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);// 3.
	}

	/**
	 * 
	 * delSysrole的中文名称：删除角色
	 * 
	 * delSysrole的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delSysrole(HttpServletRequest request, final Sysrole dto) {
		try {
			if (Strings.isNotBlank(dto.getRoleid())) {
				// 检查是否可删除
				// 1、不能有用户
				List sysuserroleList = dao.query(Sysuserrole.class, Cnd.where("roleid", "=", dto.getRoleid()));
				if (sysuserroleList != null && sysuserroleList.size() > 0) {
					return "该角色下存在【" + sysuserroleList.size() + "】个用户，不能删除！";
				}
				delSysroleImp(request, dto);
			} else {
				return "没有接收到要删除的角色ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delSysroleImp(HttpServletRequest request, final Sysrole dto) {
		// 删除角色
		dao.clear(Sysrole.class, Cnd.where("roleid", "=", dto.getRoleid()));
		// 删除角色对应的功能清单
		dao.clear(Sysrolefunction.class, Cnd.where("roleid", "=", dto.getRoleid()));
		// 删除用户拥有此角色的记录
		dao.clear(Sysuserrole.class, Cnd.where("roleid", "=", dto.getRoleid()));
	}

	/**
	 * 
	 * querySysroleGrant的中文名称：查询某个角色的权限
	 * 
	 * querySysroleGrant的概要说明：
	 * 
	 * @param roleid
	 * @return Written by : zjf
	 * 
	 */
	public List querySysroleGrant(final String roleid) {
		return dao.query(Sysrolefunction.class, Cnd.where("roleid", "=", roleid));
	}

	/**
	 * 
	 * saveSysroleGrant的中文名称：保存角色授权
	 * 
	 * saveSysroleGrant的概要说明：
	 * 
	 * @param roleid
	 * @param fid
	 * @return Written by : zjf
	 * 
	 */
	public String saveSysroleGrant(HttpServletRequest request, final String roleid, final List fid) {
		try {
			saveSysroleGrantImp(request, roleid, fid);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void saveSysroleGrantImp(HttpServletRequest request, final String roleid, final List fid) throws Exception {
		// 删除该角色所有权限
		dao.clear(Sysrolefunction.class, Cnd.where("roleid", "=", roleid));

		if (fid != null) {
			// 插入提交的权限
			Iterator it = fid.iterator();
			while (it.hasNext()) {
				Sysrolefunction s = new Sysrolefunction();
				String rolefunctionid = DbUtils.getSequenceStr();
				s.setRolefunctionid(rolefunctionid);
				s.setRoleid(roleid);
				s.setFunctionid(String.valueOf(it.next()));
				dao.insert(s);
			}
		}
	}

	/**
	 * 
	 * querySysroleUser的中文名称：查询角色已绑定的用户
	 * 
	 * querySysroleUser的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map querySysroleUser(SysuserDTO dto, PagesDTO pd) throws Exception {
		Sysorg se = dao.fetch(Sysorg.class, dto.getOrgid());
		String orgcode = se.getOrgcode();
		orgcode = orgcode.replaceAll("0*$", "");
		
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.userid,a.username,a.userkind,a.description,");
		sb.append(" (select orgname from Sysorg where orgid = a.orgid) orgname,");
		sb.append(" b.userroleid,b.roleid,c.rolename,c.roledesc");
		sb.append(" from sysuser a,sysuserrole b,sysrole c");
		sb.append(" where 1=1");
		sb.append(" and a.userid = b.userid");
		sb.append(" and b.roleid = c.roleid");
		sb.append(" and exists (select 1");
		sb.append("   			   from Sysorg m");
		sb.append("               where a.orgid = m.orgid");
		sb.append("                 and m.orgcode like '").append(orgcode).append("%')");
		sb.append(" and a.username = :username");
		sb.append(" and a.userkind = :userkind");
		sb.append(" and b.roleid = :roleid");
		
		String sql = sb.toString();
		String[] ParaName = new String[] { "username","userkind","roleid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * querySysroleNoUser的中文名称：查询角色未绑定的用户
	 * 
	 * querySysroleNoUser的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map querySysroleNoUser(SysuserDTO dto, PagesDTO pd) throws Exception {
		Sysorg se = dao.fetch(Sysorg.class, dto.getOrgid());
		String orgcode = se.getOrgcode();
		orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.userid,a.username,a.userkind,a.description,");
		sb.append(" (select orgname from Sysorg where orgid = a.orgid) orgname");
		sb.append(" from Sysuser a");
		sb.append(" where exists (select 1");
		sb.append("   			   from Sysorg b");
		sb.append("               where a.orgid = b.orgid");
		sb.append("                 and b.orgcode like '").append(orgcode).append("%')");
		sb.append(" and not exists (select 1");
		sb.append("                 from Sysuserrole b");
		sb.append("                where a.userid = b.userid");
		sb.append("                  and b.roleid = '").append(dto.getRoleid()).append("')");
		sb.append(" and a.username = :username");
		sb.append(" and a.userkind = :userkind");
		
		String sql = sb.toString();
		String[] ParaName = new String[] { "username","userkind"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * addSysuserRole的中文名称：角色绑定用户
	 * 
	 * addSysuserRole的概要说明：
	 * 
	 * @param dto
	 * @param JsonStr
	 * @return Written by : zjf
	 * 
	 */
	public String addSysuserRole(HttpServletRequest request, SysuserDTO dto, String JsonStr) {
		try {
			addSysuserRoleImp(request, dto, JsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void addSysuserRoleImp(HttpServletRequest request, SysuserDTO dto, String JsonStr) throws Exception {
		List<Sysuser> list = Json.fromJsonAsList(Sysuser.class, JsonStr);
		for (int i = 0; i < list.size(); i++) {
			Sysuser sysuser = (Sysuser) list.get(i);

			Sysuserrole s = new Sysuserrole();
			String userroleid = DbUtils.getSequenceStr();
			s.setUserroleid(userroleid);
			s.setUserid(sysuser.getUserid());
			s.setRoleid(dto.getRoleid());
			dao.insert(s);
		}
	}

	/**
	 * 
	 * delSysuserRole的中文名称：角色绑定用户【解除】
	 * 
	 * delSysuserRole的概要说明：
	 * 
	 * @param dto
	 * @param JsonStr
	 * @return Written by : zjf
	 * 
	 */
	public String delSysuserRole(HttpServletRequest request, SysuserDTO dto, String JsonStr) {
		try {
			delSysuserRoleImp(request, dto, JsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void delSysuserRoleImp(HttpServletRequest request, SysuserDTO dto, String JsonStr) throws Exception {
		List<Sysuserrole> list = Json.fromJsonAsList(Sysuserrole.class, JsonStr);
		for (int i = 0; i < list.size(); i++) {
			Sysuserrole sysuserrole = (Sysuserrole) list.get(i);
			dao.clear(Sysuserrole.class, Cnd.where("userid", "=", sysuserrole.getUserid()).and("roleid", "=", sysuserrole.getRoleid()));
		}
	}
}
