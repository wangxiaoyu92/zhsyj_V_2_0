package com.zzhdsoft.siweb.service.sysmanager;

import com.alibaba.druid.util.StringUtils;
import com.askj.baseinfo.entity.Pcomry;
import com.askj.baseinfo.entity.Pzfry;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.QddszDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuseraaeDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Aa13;
import com.zzhdsoft.siweb.entity.sysmanager.*;
import com.zzhdsoft.utils.MD5Util;
import com.zzhdsoft.utils.PinYinUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 
 * SysuserService的中文名称：用户管理service
 * 
 * SysuserService的描述：
 * 
 * Written by : zjf
 */
public class SysuserService {
	protected final Logger logger = Logger.getLogger(SysuserService.class);
	@Inject
	private Dao dao;
	private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


	/**
	 * 
	 * querySysuserByUsername的中文名称：查询用户
	 * 
	 * querySysuserByUsername的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public Map querySysuserByUsername(Sysuser dto, PagesDTO pd) throws Exception {
		Cnd c = null;
		c = Cnd.where("1", "=", "1");
		c.and("lower(username)", "=", dto.getUsername().toLowerCase());

		Map r = new HashMap();
		r.put("rows", dao.query(Sysuser.class, c, SysmanageUtil.getPager(pd)));
		r.put("total", dao.count(Sysuser.class, c));
		return r;
	}

	/**
	 * 
	 * querySysuser的中文名称：查询用户
	 * 
	 * querySysuser的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 * 
	 */
	public Map querySysuser(Sysuser dto, PagesDTO pd) throws Exception {
		String v_querytype="null";
		if (!StringUtils.isEmpty(dto.getQuerytype())){
			v_querytype=dto.getQuerytype();
		}
		Sysuser sysuser = SysmanageUtil.getSysuser();
		if (sysuser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
			sysuser = dao.fetch(Sysuser.class, dto.getUserid());
		}
		if (sysuser==null && !StringUtils.isEmpty(dto.getOperuserid())){
			sysuser=dao.fetch(Sysuser.class,dto.getOperuserid());
		}
		String orgcode=null;
		String orgid = dto.getOrgid();
		
		//gu20170918 手机端 设置日常监督管理人员 只查非企业用户
		if (!"2".equalsIgnoreCase(dto.getQuerykind())){//企业管理界面 选择日常监督管理人员 中查询 已选择的人员
			if (Strings.isBlank(orgid)) {
				orgcode = SysmanageUtil.getSysuserOrgcode();
			} else {
				Sysorg se = dao.fetch(Sysorg.class, orgid);
				orgcode = se.getOrgcode();
			}
		};
//		if ("comusersel".equals(dto.getQuerykind())) {//gu20180520企业用户选择人员
//			orgcode="410003";
//		}
		
//		orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" select userid, username, passwd, description,userkind,a.usercomid,");
		sb.append(" lockstate,locktime, unlocktime, lockreason,userposition,");
		sb.append(" createtime,remark, a.orgid, aac002,aac154,aac003,signintime,allowsignintime,  ");
		sb.append(" mobile, mobile2,telephone,aaa027, aaz010,b.orgname,");
		sb.append(" (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,selfcomflag ");
		sb.append(" from Sysuser a,Sysorg b");
		sb.append(" where 1=1");
		sb.append("  and a.orgid = b.orgid");
		if (!"mobilegetall".equals(v_querytype)){
			sb.append("  and userid = :userid");
		}
		//sb.append("  and username like :username");
		if (!StringUtils.isEmpty(dto.getUsername())){
			sb.append("  and (username like '%"+dto.getUsername()+"%' or description like '%"+dto.getUsername()+"%' or mobile like '%"+dto.getUsername()+"%' or mobile2 like '"+dto.getUsername()+"')");
		}
		sb.append("  and description like :description ");
		sb.append("  and userjc like :userjc ");
		sb.append("  and userkind = :userkind");
		sb.append("  and lockstate = :lockstate");
		sb.append("  and aac002 = :aac002");
		sb.append("  and aac003 = :aac003");
		sb.append("  and aac154 = :aac154");
		sb.append("  and aaz010 = :aaz010");
		sb.append("  and mobile = :mobile");
		sb.append("  and aaa027 = :aaa027");
		sb.append(" and a.usercomid=:usercomid ");
		if (!"6".equals(sysuser.getUserkind())   && !"7".equals(sysuser.getUserkind())  && !"8".equals(sysuser.getUserkind())
				&& !"20".equals(sysuser.getUserkind())&& !"21".equals(sysuser.getUserkind()) ){
			if (!"all".equalsIgnoreCase(dto.getQuerykind()) && !"2".equalsIgnoreCase(dto.getQuerykind())){ //gu20161210 add 报请页面需要查到所有的操作员
				sb.append("  and b.orgcode like '").append(orgcode).append("%'");
			}
//			if ("comusersel".equals(dto.getQuerykind())) {//gu20180520企业用户选择人员
//				sb.append(" and a.usercomid='"+dto.getUsercomid()+"'");
//			}
		}else{
			dto.setUserkind(null);//gu20180603
			sb.append(" and a.usercomid='"+sysuser.getUsercomid()+"'");
		}
		
		//gu20170915
		if ("1".equalsIgnoreCase(dto.getQuerykind())){//企业管理界面 选择日常监督管理人员 中查询 已选择的人员 
			if (!StringUtils.isEmpty(dto.getUseridstr())){
				String v_useridstr=dto.getUseridstr();
				String[] v_useridarr=v_useridstr.split(",");
				String v_useridstrcon="";
				for (int i=0;i<v_useridarr.length;i++){
					if (i==0){
						v_useridstrcon="'"+v_useridarr[i]+"'";
					}else{
						v_useridstrcon=v_useridstrcon+",'"+v_useridarr[i]+"'";
					}
				}
				sb.append(" and  a.userid in ("+v_useridstrcon+")");
			}else{
				sb.append(" and  a.userid='no' ");
			};
		};
		
		//gu20170918 手机端 设置日常监督管理人员 只查非企业用户
		if ("2".equalsIgnoreCase(dto.getQuerykind())){//企业管理界面 选择日常监督管理人员 中查询 已选择的人员 
			sb.append(" and  a.userkind not in ('6','7','8','20','21','30') ");
		};			
		
		sb.append("  order by b.orgname");
		String sql = sb.toString();
		String[] ParaName = new String[] {"userid", "username", "description",
				"userjc","userkind", "lockstate", "aac002", "aac003", "aac154", 
				"aaz010", "mobile", "aaa027","orgid","usercomid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,
				Types.VARCHAR,Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, 
				Types.VARCHAR, Types.VARCHAR,Types.VARCHAR, Types.VARCHAR, 
				Types.VARCHAR, Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("kdkkdkdk "+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysuser.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 * 
	 * isExistsUsername的中文名称：校验用户名是否存在
	 * 
	 * isExistsUsername的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String isExistsUsername(Sysuser dto) throws Exception {
		// 校验用户名是否已经存在
		PagesDTO pd = new PagesDTO();
		Map m = querySysuserByUsername(dto, pd);
		List ls = (List) m.get("rows");
		if (ls != null && ls.size() > 0) {
			return "该用户已存在，用户名不能重复！";
		}
		return null;
	}

	/**
	 * 
	 * addSysuser的中文名称：新增用户
	 * 
	 * addSysuser的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String addSysuser(HttpServletRequest request, final Sysuser dto) {
		try {
			String flag;
			flag = isExistsUsername(dto);
			if (flag != null) {
				return flag;
			}

			addSysuserImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addSysuserImp(HttpServletRequest request, Sysuser dto) throws Exception {
		Sysuser v_Sysuser= (Sysuser)SysmanageUtil.getSysuser();//gu20180601

		//gu20180601检测机构进去添加人员 往检测机构企业人员表插入一条
		String ryid = DbUtils.getSequenceStr();
		if (!StringUtils.isEmpty(v_Sysuser.getUsercomdalei()) && v_Sysuser.getUsercomdalei().indexOf("106001")!=-1) {//106001 检验检测机构
			Pcomry v_newPcomry=new Pcomry();
			v_newPcomry.setRyid(ryid);
			v_newPcomry.setComid(v_Sysuser.getUsercomid());
			v_newPcomry.setRyxm(dto.getDescription());
			v_newPcomry.setRylxdh(dto.getMobile());
			dto.setAaz001(ryid);
			dto.setUsercomid(v_Sysuser.getUsercomid());
			dao.insert(v_newPcomry);
		}

		Timestamp startTime = SysmanageUtil.currentTime();// 1.
		Sysuser se = new Sysuser();
		String userid = DbUtils.getSequenceStr();
		dto.setUserid(userid);
		dto.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());

		//SysEasemobService.getInstance().addSysuserToEasemob(dto);

		BeanHelper.copyProperties(dto, se);
		dto.setUserjc(PinYinUtil.GetChineseSpell(dto.getDescription()));
		dao.insert(se);
		
		//gu20170920 同步下全局操作员信息
		SysmanageUtil.g_updateGlobalSysUserList(userid,"add");

		Timestamp endTime = SysmanageUtil.currentTime();// 2.
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);// 3.

	}

	/**
	 * 
	 * updateSysuser的中文名称：修改用户
	 * 
	 * updateSysuser的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */

	public String updateSysuser(HttpServletRequest request, final Sysuser dto) {
		try {
			String flag;
			Sysuser se = dao.fetch(Sysuser.class, dto.getUserid());
			if (!(se.getUsername()).equalsIgnoreCase(dto.getUsername())) {
				flag = isExistsUsername(dto);
				if (flag != null) {
					return flag;
				}
			}

			updateSysuserImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void updateSysuserImp(HttpServletRequest request, Sysuser dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();// 1.
		Sysuser v_Sysuser= (Sysuser)SysmanageUtil.getSysuser();//gu20180601

		Sysuser se = dao.fetch(Sysuser.class, dto.getUserid());
		se.setUsername(dto.getUsername());
		se.setDescription(dto.getDescription());
		se.setUserkind(dto.getUserkind());
		se.setLockstate(dto.getLockstate());
		se.setAaa027(dto.getAaa027());
		se.setOrgid(dto.getOrgid());
		se.setMobile(dto.getMobile());
		se.setMobile2(dto.getMobile2());
		se.setTelephone(dto.getTelephone());
		se.setSelfcomflag(dto.getSelfcomflag());
		se.setUserposition(dto.getUserposition());
		se.setUserjc(PinYinUtil.GetChineseSpell(se.getDescription()));
		dao.update(se);
		
		//gu20170920 同步下全局操作员信息
		SysmanageUtil.g_updateGlobalSysUserList(dto.getUserid(),"update");

		Timestamp endTime = SysmanageUtil.currentTime();// 2.
		SysmanageUtil.writeSysoperatelog(request, startTime, endTime);// 3.

		//gu20180601检测机构进去添加人员 往检测机构企业人员表插入一条
		String v_aaz001 = se.getAaz001();
		if (v_Sysuser.getUsercomdalei()!=null&&v_Sysuser.getUsercomdalei().indexOf("106001")!=-1) {//106001 检验检测机构
			Pcomry v_oldPcomry=dao.fetch(Pcomry.class,v_aaz001);
			v_oldPcomry.setComid(v_Sysuser.getUsercomid());
			v_oldPcomry.setRyxm(dto.getDescription());
			v_oldPcomry.setRylxdh(dto.getMobile());
			dao.update(v_oldPcomry);
		}

	}

	/**
	 * 
	 * delSysuser的中文名称：删除用户
	 * 
	 * delSysuser的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zjf
	 * 
	 */
	public String delSysuser(HttpServletRequest request, Sysuser dto) {
		try {
			if (Strings.isNotBlank(dto.getUserid())) {
				// 检查是否可删除
				List sysuserList = dao.query(Sysuser.class, Cnd.wrap(dto.getUserid() + " in ('0','1','2','3','4')"));
				if (sysuserList != null && sysuserList.size() > 0) {
					return "不允许删除系统预置标准用户！";
				}
				delSysuserImp(request, dto);
			} else {
				return "没有接收到要删除的用户ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delSysuserImp(HttpServletRequest request, Sysuser dto) throws Exception {
		Sysuser v_Sysuser= (Sysuser)SysmanageUtil.getSysuser();//gu20180601
		// 删除用户
		Sysuser sysuserEasemob =dao.fetch(Sysuser.class, dto.getUserid());
		SysEasemobService.getInstance().delSysuserFromEasemob(sysuserEasemob);
		String sql="select zfrysfzh from viewzfry where userid ="+"'"+dto.getUserid()+"'";
		List list=(List)DbUtils.getDataList(sql,null);
		//// list : {[zfrysfzh=411*****]} 如果为空 则{[]} 如果 不是执法人员 size为0 如果两个都不满足 则表示 既是执法人员又有身份证号 则执行删除Pzfry身份证号的方法
		if(list.size()!=0&&!list.toString().substring(2).equals("}]")){
			String zfrysfzh=list.toString().split("=")[1].split("}")[0];
			dao.clear(Pzfry.class,Cnd.where("zfrysfzh","=",zfrysfzh));
		}

		dao.clear(Sysuser.class, Cnd.where("userid", "=", dto.getUserid()));
		// 删除用户角色
		dao.clear(Sysuserrole.class, Cnd.where("userid", "=", dto.getUserid()));
		//gu20170920 同步下全局操作员信息
		SysmanageUtil.g_updateGlobalSysUserList(dto.getUserid(),"delete");

		//gu20180601检测机构进去添加人员 往检测机构企业人员表插入一条
		String v_aaz001 = dto.getAaz001();
		if (!StringUtils.isEmpty(v_Sysuser.getUsercomdalei()) && v_Sysuser.getUsercomdalei().indexOf("106001")!=-1) {//106001 检验检测机构
			dao.clear(Pcomry.class,Cnd.where("ryid","=",v_aaz001));
		}
	}

	/**
	 * 
	 * lockSysuser的中文名称：封锁用户
	 * 
	 * lockSysuser的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String lockSysuser(HttpServletRequest request, Sysuser dto) {
		try {
			lockSysuserImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void lockSysuserImp(HttpServletRequest request, Sysuser dto) throws Exception {
		Sysuser se = dao.fetch(Sysuser.class, dto.getUserid());
		if ("1".equals(se.getLockstate())) {
			throw new BusinessException("该用户当前已经是封锁状态，无需封锁操作!");
		}
		// 1、更新状态
		Timestamp locktime = new Timestamp(System.currentTimeMillis());
		se.setLockreason(dto.getLockreason());
		se.setLockstate("1");
		se.setLocktime(locktime);
		dao.update(se);
		// 2、插入系统用户日志
		Sysuserlog sl = new Sysuserlog();
		String userlogid = DbUtils.getSequenceStr();
		sl.setUserlogid(userlogid);
		sl.setUserid(dto.getUserid());
		sl.setDescr(dto.getLockreason());
		sl.setChangetype("2");
		sl.setChangetime(locktime);
		Sysuser s = SysmanageUtil.getSysuser();
		sl.setAae011(s.getUserid());
		sl.setAae011Name(s.getAac003());
		dao.insert(sl);
	}

	/**
	 * 
	 * unlockSysuser的中文名称：解锁用户
	 * 
	 * unlockSysuser的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String unlockSysuser(HttpServletRequest request, Sysuser dto) {
		try {
			unlockSysuserImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void unlockSysuserImp(HttpServletRequest request, Sysuser dto) throws Exception {
		Sysuser se = dao.fetch(Sysuser.class, dto.getUserid());
		if ("0".equals(se.getLockstate()) || "".equals(se.getLockstate())) {
			throw new BusinessException("该用户当前已经是正常状态，无需解锁操作!");
		}
		// 1、更新状态
		Timestamp unlocktime = new Timestamp(System.currentTimeMillis());
		se.setLockstate("0");
		se.setLockreason("");
		se.setUnlocktime(unlocktime);
		dao.update(se);
		// 2、插入系统用户日志
		Sysuserlog sl = new Sysuserlog();
		String userlogid = DbUtils.getSequenceStr();
		sl.setUserlogid(userlogid);

		sl.setUserid(dto.getUserid());
		sl.setChangetype("3");
		sl.setChangetime(unlocktime);
		sl.setDescr("解锁");
		Sysuser s = SysmanageUtil.getSysuser();
		sl.setAae011(s.getUserid());
		sl.setAae011Name(s.getAac003());
		dao.insert(sl);
	}

	/**
	 * 
	 * resetPasswd的中文名称：重置密码
	 * 
	 * resetPasswd的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String resetPasswd(HttpServletRequest request, Sysuser dto) {
		try {
			resetPasswdImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void resetPasswdImp(HttpServletRequest request, Sysuser dto) throws Exception {
		Sysuser se = dao.fetch(Sysuser.class, dto.getUserid());
		if (se == null) {
			throw new BusinessException("没有找到该用户记录，请联系系统管理员!");
		}
		// 1、重置密码
		Timestamp changetime = new Timestamp(System.currentTimeMillis());
		se.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());
		//SysEasemobService.getInstance().resetSysuserPasswordToEasemob(se);
		dao.update(se);
		// 2、插入系统用户日志
		Sysuserlog sl = new Sysuserlog();
		String userlogid = DbUtils.getSequenceStr();
		sl.setUserlogid(userlogid);
		sl.setUserid(dto.getUserid());
		sl.setChangetype("4");
		sl.setChangetime(changetime);
		sl.setDescr("重置密码");
		Sysuser s = SysmanageUtil.getSysuser();
		sl.setAae011(s.getUserid());
		sl.setAae011Name(s.getAac003());
		dao.insert(sl);
	}	

	/**
	 * 
	 * initSuper的中文名称：初始化超级管理员角色权限
	 * 
	 * initSuper的概要说明：
	 * 
	 * @param request
	 * @return Written by : zjf
	 * 
	 */
	public String initSuper(HttpServletRequest request) {
		try {
			initSuperImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void initSuperImp(HttpServletRequest request) throws Exception {
		// 先删除原角色权限
		dao.clear("sysrolefunction", Cnd.where("roleid", "=", "0"));

		List sysfunctionList = dao.query(Sysfunction.class, null);
		for (int i = 0; i < sysfunctionList.size(); i++) {
			// 自动插入到超级管理员角色权限中
			Sysfunction sysfunction = (Sysfunction) sysfunctionList.get(i);
			Sysrolefunction s = new Sysrolefunction();
			String rolefunctionid = DbUtils.getSequenceStr();
			s.setRolefunctionid(rolefunctionid);
			s.setRoleid("0");
			s.setFunctionid(sysfunction.getFunctionid());
			dao.insert(s);
		}
	}
	
	/**
	 * 
	 * querySysuserNoRole的中文名称：查询操作员【可绑定】的角色
	 * 
	 * querySysuserNoRole的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map querySysuserNoRole(SysuserDTO dto, PagesDTO pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String userid = sysuser.getUserid();
		dto.setUserid(sysuser.getUserid());
		String orgcode = SysmanageUtil.getSysuserOrgcode();
		orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" select roleid, roledesc, rolename, sysroleflag, a.orgid");
		sb.append(" from sysrole a");
		if ("0".equals(userid)) {// 超级管理员
			sb.append(" ,sysorg b where 1=1 and a.orgid = b.orgid ");
		} else {
			sb.append(" where exists (select roleid");
			sb.append("                 from sysuserrole b");
			sb.append("                where a.roleid = b.roleid");
			sb.append("                  and b.userid = :userid)");
			sb.append("and a.rolename not in");
			sb.append("(select c.rolename from sysuser a,sysuserrole b,sysrole c where 1=1 and a.userid = b.userid and b.roleid = c.roleid and a.userid = :userid)");
			sb.append(" union ");
			sb.append(" select roleid,roledesc,rolename,sysroleflag,a.orgid");
			sb.append("   from sysrole a,sysorg b");
			sb.append("  where a.orgid = b.orgid");
			sb.append("    and b.orgcode like '").append(orgcode).append("%'");
			sb.append("and a.rolename not in");
			sb.append("(select c.rolename from sysuser a,sysuserrole b,sysrole c where 1=1 and a.userid = b.userid and b.roleid = c.roleid and a.userid = :userid)");
		}
		String sql = sb.toString();
		String[] ParaName = new String[] { "userid" };
		int[] ParaType = new int[] { Types.VARCHAR };
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
	 * querySysuserRole的中文名称：查询操作员【已绑定】的角色
	 * 
	 * querySysuserRole的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public Map querySysuserRole(SysuserDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.userid,a.username,a.userkind,");
		sb.append(" b.roleid,c.rolename,c.roledesc");
		sb.append(" from sysuser a,sysuserrole b,sysrole c");
		sb.append(" where 1=1");
		sb.append(" and a.userid = b.userid");
		sb.append(" and b.roleid = c.roleid");
		sb.append(" and a.userid = :userid");
		sb.append(" and b.roleid = :roleid");
		String sql = sb.toString();
		String[] ParaName = new String[] { "userid", "roleid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
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
	 * saveSysuserRole的中文名称：操作员角色授权【保存】
	 * 
	 * saveSysuserRole的概要说明：
	 * 
	 * @param dto
	 * @param JsonStr
	 * @return Written by : zjf
	 * 
	 */
	public String saveSysuserRole(HttpServletRequest request, Sysuser dto, String JsonStr) {
		try {
			saveSysuserRoleImp(request, dto, JsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void saveSysuserRoleImp(HttpServletRequest request, Sysuser dto, String JsonStr) throws Exception {
		// 删除该用户原有角色权限
		dao.clear(Sysuserrole.class, Cnd.where("userid", "=", dto.getUserid()));
		// 插入新赋予的角色权限
		List<Sysrole> list = Json.fromJsonAsList(Sysrole.class, JsonStr);
		for (int i = 0; i < list.size(); i++) {
			Sysrole sysrole = (Sysrole) list.get(i);

			Sysuserrole s = new Sysuserrole();
			String userroleid = DbUtils.getSequenceStr();
			s.setUserroleid(userroleid);
			s.setUserid(dto.getUserid());
			s.setRoleid(sysrole.getRoleid());
			dao.insert(s);
		}
	}
	
	/**
	 * 
	 * querySysuserNoAae140的中文名称：查询操作员【未授权】的四品一械大类
	 * 
	 * querySysuserNoAae140的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public Map querySysuserNoAae140(SysuserDTO dto, PagesDTO pd) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String userid = sysuser.getUserid();
//		dto.setUserid(sysuser.getUserid());
		//String orgcode = SysmanageUtil.getSysuserOrgcode();
		//orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.aaa102 as aae140,a.aaa103 as aae140name ");
		sb.append(" FROM viewaae140 a ");
		if ("0".equals(userid)) {// 超级管理员
			sb.append(" WHERE 1=1 ");
		} else {
			sb.append(" where not exists (select aae140 ");
			sb.append(" from sysuseraae b");
			sb.append(" where a.aaa102 = b.aae140 ");
			sb.append(" and b.userid = :userid)");
		}
		String sql = sb.toString();
		String[] ParaName = new String[] { "userid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, SysuseraaeDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}	
	
	/**
	 * 
	 * querySysuserAae140的中文名称：查询操作员【已授权】的四品一械大类
	 * 
	 * querySysuserAae140的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : gjf
	 * 
	 */
	public Map querySysuserAae140(SysuserDTO dto, PagesDTO pd) throws Exception {
		//Sysuser sysuser = SysmanageUtil.getSysuser();
		//String userid = sysuser.getUserid();
		//dto.setUserid(sysuser.getUserid());
		//String orgcode = SysmanageUtil.getSysuserOrgcode();
		//orgcode = orgcode.replaceAll("0*$", "");

		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.aaa102 as aae140,a.aaa103 as aae140name ");
		sb.append(" FROM viewaae140 a ");
			sb.append(" where exists (select aae140");
			sb.append("  from sysuseraae b");
			sb.append("  where a.aaa102 = b.aae140 ");
			sb.append("  and b.userid = :userid)");

		String sql = sb.toString();
		String[] ParaName = new String[] { "userid" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, SysuseraaeDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}	
	
	/**
	 * 
	 * saveSysuserAae140的中文名称：用户四品一械大类授权【保存】
	 * 
	 * saveSysuserAae140的概要说明：
	 * 
	 * @param dto
	 * @param JsonStr
	 * @return Written by : zjf
	 * 
	 */
	public String saveSysuserAae140(HttpServletRequest request, Sysuser dto, String JsonStr) {
		try {
			saveSysuserAae140Imp(request, dto, JsonStr);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void saveSysuserAae140Imp(HttpServletRequest request, Sysuser dto, String JsonStr) throws Exception {
		// 删除该用户原有四品一械大类权限
		dao.clear(Sysuseraae.class, Cnd.where("userid", "=", dto.getUserid()));
		// 插入新赋予的四品一械大类权限
		List<Sysuseraae> list = Json.fromJsonAsList(Sysuseraae.class, JsonStr);
		for (int i = 0; i < list.size(); i++) {
			Sysuseraae sysuseraae = (Sysuseraae) list.get(i);

			Sysuseraae s = new Sysuseraae();
			String v_sysuseraaeid = DbUtils.getSequenceStr();
			s.setSysuseraaeid(v_sysuseraaeid);
			s.setUserid(dto.getUserid());
			s.setAae140(sysuseraae.getAae140());
			dao.insert(s);
		}
	}
	
	/**
	 * 
	 * querySysuserAaeZTree的中文名称：按Ztree插件格式构造统筹区树
	 * 
	 * querySysuserAaeZTree的概要说明：
	 * 
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	public List querySysuserAaa027ZTree(HttpServletRequest request) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String v_aaa027 = sysuser.getAaa027();
		//v_aaa027="411700000000";
		v_aaa027 = SysmanageUtil.getSysuserAaa027(v_aaa027);
		
		Aa01 v_aa01 = SysmanageUtil.getAa01("AAA027GRANTLEVEL");
		String v_aaa027level = " and (t.aae383='1' or t.aae383='2' or t.aae383='3') ";
		String v_aaa027level2 = " and (t1.aae383='1' or t1.aae383='2' or t1.aae383='3') ";
		if (v_aa01 != null && !"".equals(v_aa01.getAaa005())) {
			if (v_aa01.getAaa005().equalsIgnoreCase("1")) {
				v_aaa027level = " and t.aae383='1' ";
				v_aaa027level2 = " and t1.aae383='1' ";
			} else if (v_aa01.getAaa005().equalsIgnoreCase("2")) {
				v_aaa027level = " and (t.aae383='1' or t.aae383='2') ";
				v_aaa027level2 = " and (t1.aae383='1' or t1.aae383='2') ";
			} else if (v_aa01.getAaa005().equalsIgnoreCase("3")) {
				v_aaa027level = " and (t.aae383='1' or t.aae383='2' or t.aae383='3') ";
				v_aaa027level2 = " and (t1.aae383='1' or t1.aae383='2' or t1.aae383='3') ";
			} else if (v_aa01.getAaa005().equalsIgnoreCase("4")) {
				v_aaa027level = " and (t.aae383='1' or t.aae383='2' or t.aae383='3' or t.aae383='4') ";
				v_aaa027level2 = " and (t1.aae383='1' or t1.aae383='2' or t1.aae383='3' or t1.aae383='4') ";
			} else if (v_aa01.getAaa005().equalsIgnoreCase("5")) {
				v_aaa027level = " and (t.aae383='1' or t.aae383='2' or t.aae383='3' or t.aae383='4' or t.aae383='5') ";
				v_aaa027level2 = " and (t1.aae383='1' or t1.aae383='2' or t1.aae383='3' or t1.aae383='4' or t1.aae383='5') ";
			}
		}

		String sb = "";
		sb += " select aaa027,aaa129,aaa129 aaa027name,aaa148,aaa148name,aae383,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end isopen  ";
		sb += " from(";
		sb += " select t.aaa027,t.aaa129,t.aaa148,t.aae383,t.baz002, ";
		sb += " (select count(t1.aaa027) from Aa13 t1 where t1.aaa148 = t.aaa027 and (t1.aaa027 like '"+v_aaa027
				+"%' OR t1.AAA148 LIKE '%411799%' )  "+v_aaa027level2+") childnum, ";
		sb += " (select t2.aaa129 from Aa13 t2 where t2.aaa027 = t.aaa148) aaa148name ";
		sb += " from Aa13 t  ";
		sb += " where 1=1 ";
        sb += " and (t.aaa027 like '"+v_aaa027+"%' or t.aaa148 like '"+v_aaa027+"%') ";
        sb += v_aaa027level;
		sb += " ) h ";// mysql

		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, Aa13.class);
		System.out.println("querySysuserAaa027ZTree "+sb.toString());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
	
	/**
	 * 
	 * querySysuserHaveAaa027Grant的中文名称：查询操作员【已授权】的统筹区
	 * 
	 * querySysuserHaveAaa027Grant的概要说明：
	 * 
	 * @param userid
	 * @return Written by : zjf
	 * 
	 */
	public List querySysuserHaveAaa027Grant(final String userid) {
		return dao.query(Sysuserarea.class, Cnd.where("userid", "=", userid));
	}
	
	/**
	 * 
	 * saveSysuserAaa027Grant的中文名称：统筹区授权【保存】
	 * 
	 * saveSysuserAaa027Grant的概要说明：
	 * 
	 * @param userid
	 * @param fid
	 * @return Written by : zjf
	 * 
	 */
	public String saveSysuserAaa027Grant(HttpServletRequest request, 
			final String userid, final List fid) {
		try {
			saveSysuserAaa027GrantImp(request, userid, fid);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void saveSysuserAaa027GrantImp(HttpServletRequest request, final String userid, final List fid) throws Exception {
		// 删除该角色所有权限
		dao.clear(Sysuserarea.class, Cnd.where("userid", "=", userid));

		if (fid != null) {
			// 插入提交的权限
			Iterator it = fid.iterator();
			while (it.hasNext()) {
				Sysuserarea s = new Sysuserarea();
				String sysuserareaid = DbUtils.getSequenceStr();
				s.setSysuserareaid(sysuserareaid);
				s.setUserid(userid);
				s.setAaa027(String.valueOf(it.next()));
				dao.insert(s);
			}
		}
	}	
	
	/**
	 * 
	 * querySysuserOrgZTree的中文名称：根据Ztree插件的树格式，组装机构树。
	 * 
	 * querySysuserOrgZTree的概要说明：异步加载（传入父节点ID）
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public List querySysuserOrgZTree(HttpServletRequest request) throws Exception {
		Sysuser sysuser = SysmanageUtil.getSysuser();
		String orgid = sysuser.getOrgid();
		String v_orgcode = sysuser.getOrgcode();

		//v_aaa027="411700000000";
		//v_aaa027=SysmanageUtil.getSysuserAaa027(v_aaa027);		

		String sb = "";
		sb += " select orgid,orgname,shortname,orgdesc,parent,parentname,";
		sb += " address,principal,linkman,tel,orgkind,orgcode,orderno,fz,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isopen ";
		sb += " from(";
		sb += " select t.orgid,t.orgname,t.shortname,t.orgdesc,t.parent,";
		sb += " t.address,t.principal,t.linkman,t.tel,t.orgkind,t.orgcode,t.orderno,t.fz,";
		sb += " (select count(t1.orgid) from Sysorg t1 where t1.parent = t.orgid and t1.orgcode like '"+v_orgcode
				+"%' ) childnum, ";
		sb += " (select t2.orgname from Sysorg t2 where t2.orgid = t.parent) parentname ";
		sb += " from Sysorg t ";
		sb += " where t.orgcode like '"+v_orgcode+"%' ";
		//sb += "  and f_orgidischildren(t.orgid,'"+orgid+"')='1' ";
		sb += " ) h ";// mysql

		Map m = DbUtils.DataQuery("sql", sb, null, Sysorg.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}	
	
	/**
	 * 
	 * querySysuserHaveOrgGrant的中文名称：查询操作员【已授权】的机构
	 * 
	 * querySysuserHaveOrgGrant的概要说明：
	 * 
	 * @param userid
	 * @return Written by : zjf
	 * 
	 */
	public List querySysuserHaveOrgGrant(final String userid) {
		return dao.query(Sysuserorg.class, Cnd.where("userid", "=", userid));
	}
	
	/**
	 * 
	 * saveSysuserOrgGrant的中文名称：操作员机构授权【保存】
	 * 
	 * saveSysuserOrgGrant的概要说明：
	 * 
	 * @param userid
	 * @param fid
	 * @return Written by : zjf
	 * 
	 */
	public String saveSysuserOrgGrant(HttpServletRequest request, 
			final String userid, final List fid) {
		try {
			saveSysuserOrgGrantImp(request, userid, fid);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop("trans")
	public void saveSysuserOrgGrantImp(HttpServletRequest request, final String userid, final List fid) throws Exception {
		// 删除该角色所有权限
		dao.clear(Sysuserorg.class, Cnd.where("userid", "=", userid));

		if (fid != null) {
			// 插入提交的权限
			Iterator it = fid.iterator();
			while (it.hasNext()) {
				Sysuserorg s = new Sysuserorg();
				String sysuserorgid = DbUtils.getSequenceStr();
				s.setSysuserorgid(sysuserorgid);
				s.setUserid(userid);
				s.setOrgid(String.valueOf(it.next()));
				dao.insert(s);
			}
		}
	}
	
	/**
     * 
     *  Queryqdd的中文名称：查询全部签到点
     *
     *  Queryqdd的概要说明：
     *
     *  @param request
     *  @param dto
     *  @param pd
     *  @return
     *  Written  by  : ly
     * @throws Exception 
     *
     */
    public Map Queryqdd(HttpServletRequest request, Qddsz dto, PagesDTO pd) throws Exception{
    	StringBuffer sb = new StringBuffer();
    	sb.append(" SELECT * FROM qddsz sz WHERE 1=1   ");  
    	sb.append(" and sz.aae100=:aae100 ");  
    	sb.append(" and sz.qddszid=:qddszid ");  
    	String sql = sb.toString();
    	String[] ParaName = new String[] {"qddszid","aae100"};
    	int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR };
    	sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
    	Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Qddsz.class,
    			pd.getPage(), pd.getRows());
    	List ls = (List) m.get(GlobalNames.SI_RESULTSET);
    	Map r = new HashMap();
    	r.put("rows", ls);
    	r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
    	return r;
    }
    /**
     * 
     *  addqdd的中文名称：保存签到点
     *
     *  addqdd的概要说明：
     *
     *  @param request
     *  @param dto
     *  @return
     *  Written  by  : ly
     *
     */
    public String addqdd(HttpServletRequest request, Qddsz dto){
    	try{
    		addqddImpl(request,dto);
    	}catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
    	}
    	return null; 
    }
    /**
     * 
     *  addqddImpl的中文名称：实现签到点保存
     *
     *  addqddImpl的概要说明：事物控制完整性
     *
     *  @param request
     *  @param dto
     *  @throws Exception
     *  Written  by  : ly
     *
     */
    @Aop({"trans"})
    public void addqddImpl(HttpServletRequest request, Qddsz dto) throws Exception{
    	Qddsz qddsz = dao.fetch(Qddsz.class,Cnd.where("qddszid", "=", dto.getQddszid()));
    	if(qddsz == null){ 
    		Qddsz qdd = new Qddsz(); 
    		BeanHelper.copyProperties(dto, qdd);
    		qdd.setQddszid(DbUtils.getSequenceStr());
    		qdd.setAae011(SysmanageUtil.getSysuser().getUsername());
    		qdd.setAae036(SysmanageUtil.getDbtimeYmd());
    		dao.insert(qdd);
    	}else{
    		BeanHelper.copyProperties(dto, qddsz);
    		dao.update(qddsz);
    	}
    }
    /**
     * 
     *  delqdd的中文名称：删除签到点
     *
     *  delqdd的概要说明：
     *
     *  @param request
     *  @param dto
     *  @return
     *  Written  by  : ly
     *
     */
    public String delqdd(HttpServletRequest request,Qddsz dto){
    	try {
    		delqddImpl(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
    	return null;
    }
    /**
     * 
     *  delqddImpl的中文名称：删除签到点
     *
     *  delqddImpl的概要说明：
     *
     *  @param request
     *  @param dto
     *  Written  by  : ly
     *
     */
    @Aop({"trans"})
    public void delqddImpl (HttpServletRequest request,Qddsz dto){
        dao.delete(Qddsz.class,  dto.getQddszid())  ;	
    }
    /**
     * 
     *  Queryqddmx的中文名称：查看操作员绑定的签到点
     *
     *  Queryqddmx的概要说明：
     *
     *  @param dto
     *  @param pd
     *  @return
     *  @throws Exception
     *  Written  by  : ly
     *
     */
    public Map Queryqddczybd(QddszDTO dto, PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT sz.qddszid, sz.qddmc,sz.qddyxjl,sz.qdddz,bd.qddczybdid FROM qddczybd bd ,qddsz sz "); 
		sb.append(" where bd.qddszid=sz.qddszid  "); 
		sb.append(" and sz.aae100=:aae100 "); 
		sb.append(" and bd.userid=:userid "); 
		String sql = sb.toString();
		String[] ParaName = new String[] {"userid","aae100"};
		int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QddszDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
    }
    /**
     * 
     *  Queryqddsz的中文名称：查询除绑定外的签到点
     *
     *  Queryqddsz的概要说明：
     *
     *  @param dto
     *  @param pd
     *  @return
     *  @throws Exception
     *  Written  by  : ly
     *
     */
    public Map Queryqddsz(QddszDTO dto, PagesDTO pd) throws Exception{
    	StringBuffer sb = new StringBuffer();
    	sb.append(" SELECT sz.qddszid, sz.qddmc,sz.qddyxjl,sz.qdddz FROM qddsz sz WHERE 1=1 and sz.qddszid NOT in   "); 
    	sb.append(" (SELECT q.qddszid FROM qddczybd q WHERE 1=1  "); 
    	sb.append(" and q.userid=:userid ");  
    	sb.append(" and sz.aae100=:aae100 ) ");  
    	String sql = sb.toString();
    	String[] ParaName = new String[] {"userid","aae100"};
    	int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR };
    	sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
    	Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QddszDTO.class,
    			pd.getPage(), pd.getRows());
    	List ls = (List) m.get(GlobalNames.SI_RESULTSET);
    	Map r = new HashMap();
    	r.put("rows", ls);
    	r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
    	return m;
    }
    /**
     * 
     *  Saveqddczybd的中文名称：保存签到点和执法人员的绑定
     *
     *  Saveqddczybd的概要说明：
     *
     *  @param request
     *  @param dto
     *  @param succes
     *  @return
     *  @throws Exception
     *  Written  by  : ly
     *
     */
    public String Saveqddczybd(HttpServletRequest request, Qddczybd dto ,String succes) {
		try {
			SaveqddczybdImpl( request,dto,succes);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
    	return null;
    }
    /**
     * 
     *  SaveqddczybdImpl的中文名称：保存绑定
     *
     *  SaveqddczybdImpl的概要说明：
     *
     *  @param request
     *  @param dto
     *  @param succes
     *  Written  by  : ly
     * @throws Exception 
     *
     */
    @Aop({"trans"})
    public void SaveqddczybdImpl(HttpServletRequest request, Qddczybd dto ,String succes) throws Exception{
    	List<Qddczybd> lst = Json.fromJsonAsList(Qddczybd.class, succes);
    	dao.clear(Qddczybd.class, Cnd.where("userid", "=", dto.getUserid()));
    	for(int i=0;i<lst.size();i++){
    		Qddczybd bd = lst.get(i);
    		bd.setUserid(dto.getUserid());
    		bd.setQddczybdid(DbUtils.getSequenceStr());
    		bd.setAae011(SysmanageUtil.getSysuser().getUsername());
    		bd.setAae036(SysmanageUtil.getDbtimeYmd());
    		dao.insert(bd);
    	}
    }
    
    /**
	 * queryversion 查看版本号
	 * @param dto
	 * @return
	 * @throws Exception
	 */
    public List<Syslogonlog> queryversion( Syslogonlog dto) throws Exception{
    	String tim = "";
    	String endtim = "";
    	if(dto.getLogontime() == null || "".equals(dto.getLogontime())){
    		  tim = SysmanageUtil.getDbtimeYmd();
    		 endtim = tim+" 23:59:59"; 
   	    }else{
   	    	tim = dto.getLogontime().toString().substring(0, 10);
   	    	endtim = tim+" 23:59:59";
   	    } 
    	StringBuffer sb = new StringBuffer();
    	sb.append(" SELECT l.logonlogid,l.logontime ,l.logonappvision,s.username as userid, ");
    	sb.append(" s.description logfailedreason FROM syslogonlog l,sysuser s  WHERE ");
    	sb.append(" s.userkind='5' AND s.aaa027 LIKE '410523%' and s.userid=l.userid ");
    	sb.append(" and LOGONAPPVISION !='' and logonflag = '0'  ");
    	sb.append(" and s.username like :userid ");
    	sb.append(" and l.logontime > '"+tim );
    	sb.append("' and l.logontime < '"+endtim );
		sb.append("' ORDER BY LOGONTIME desc  ");
		String sql = sb.toString();
		String[] ParaName = new String[] {"userid"};
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Syslogonlog.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		/*Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));*/
		return ls; 
    }
    /**
     * qiandaoquery ：签到查询
     * @param dto
     * @return
     * @throws Exception
     */
    public List<SysuserDTO> qiandaoquery(SysuserDTO dto ) throws Exception{
    	String endtime = ""; //某一天的结束时间   
    	String statime = ""; //某一天的开始时间
    	String xjtim = ""; //县局迟到时间
    	String xztim = ""; //乡镇迟到时间
    	if(dto.getUnlocktime()!=null&&!"".equals(dto.getUnlocktime())){ 
    		 statime = dto.getUnlocktime().toString(); //某一天的开始时间
    		 endtime = statime.replace("00:00:00.0","23:59:59"); 
    		 xjtim = statime.replace("00:00:00.0","08:01:00"); //县局迟到时间
    		 xztim = statime.replace("00:00:00.0","08:01:00"); //乡镇迟到时间
    	}else{
    		statime =SysmanageUtil.getDbtimeYmd();
    		endtime = statime+" 23:59:59";//某一天的开始时间
    		xjtim = statime+" 08:01:00";//县局迟到时间
   		    xztim = statime+" 08:01:00";//乡镇迟到时间 
    	}   
    	StringBuffer sb = new StringBuffer();//用unlocktime 作为签到时间   remark  作为定位地点
    	 
 		sb.append(" SELECT us.userid ,us.mobile ,us.mobile2 ,us.username ,us.description,us.aaa027,dw.dwsj unlocktime , ");
		sb.append(" CASE WHEN  AAA027 = '410523000000' THEN ( CASE WHEN  dw.dwsj != '' THEN ( CASE WHEN  dw.dwsj > '"+xjtim+"' THEN '迟到' ELSE '正常' END) ELSE  '没有打卡' END) ELSE");
		sb.append(" (CASE WHEN  dw.dwsj != '' THEN ( CASE WHEN  dw.dwsj > '"+xztim+"' THEN '迟到' ELSE '正常' END) ELSE  '没有打卡' END)   END AS remark ");
		sb.append(" ,us.AAA129 aaa027name FROM (SELECT  u.userid,u.mobile ,u.mobile2 ,u.username ,u.description, ");
		sb.append(" u.aaa027 ,a.aaa129,t.odb FROM sysuser u,aa13 a,tjuser t  WHERE t.id=u.userid and a.AAA027=u.AAA027 AND u.userkind='5' AND u.aaa027 LIKE '410523%') us ");
		sb.append(" LEFT JOIN (SELECT userid ,d.dwsj,d.dwdd  FROM sysuserdw d WHERE d.dwfs=1 ");
		sb.append(" AND d.dwsj>'"+statime+"' AND d.dwsj<'"+endtime+"') dw ");
		sb.append(" ON us.USERID=dw.userid GROUP BY us.USERID ORDER BY us.odb");
		String sql = sb.toString();
 		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto );
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, SysuserDTO.class );
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls; 
    }
    
	/**
     * queryhtml ：签到页面表格        ------- 将查出的签到情况拼成字符串返回
     * @param dto
     * @return
     * @throws Exception
     */
    public String queryqdhtml(SysuserDTO dto) throws Exception{
    	List<SysuserDTO> lis= qiandaoquery(dto); 
    	StringBuffer sb = new StringBuffer(); 
    	sb.append("<!DOCTYPE html> <html> <head lang='en'><title>签到统计</title>");
    	sb.append(" <meta http-equiv='content-type' content='text/html; charset=UTF-8'> ");
    	sb.append("<style type='text/css'>       ");  
    	sb.append("    	table{			 ");
    	sb.append("    	width:600px;		 ");
    	sb.append("    	margin:0px auto;	 ");
    	sb.append("    	font:Georgia 11px;	 ");
    	sb.append("    	color:black;		 ");
    	sb.append("    	text-align:center;	 ");
    	sb.append("    	border-collapse:collapse;");
    	sb.append("    	}			 ");
    	sb.append("    	table td{		 ");
    	sb.append("    	border:1px solid gray;	 ");
    	sb.append("    	width:100px;		 ");
    	sb.append("    	height:30px;		 ");
    	sb.append("    	}			 ");
    	sb.append("</style>                      ");  
    	sb.append("</head> <body> <table width='99%'; border='1px'> ");
    	sb.append("<tr> <td>电话号1</td><td>用户名</td><td>所属区域</td><td>签到时间</td><td>签到情况</td> </tr>");
    	
    	if(lis.size()>0){
    		String mobile = "";
			String mobile2 = "";
			String description = "";
			String aaa027name = "";
			String unlocktime = "";
			String remark = "";
    		for(int i=0;i<lis.size();i++){
    			SysuserDTO user=lis.get(i);
    			mobile = user.getMobile();//手机号1
    			mobile2 = user.getMobile2();//手机号2
    			description = user.getDescription();//执法人员姓名
    			aaa027name = user.getAaa027name();//所属区域
    			unlocktime = (user.getUnlocktime()==null||"".equals(user.getUnlocktime()))?"":DATE_FORMAT.format(user.getUnlocktime());//签到时间
    			remark = user.getRemark();//是否迟到 
    			sb.append("<tr> <td>"+mobile+"</td>"
    					+ "<td>"+description+"</td><td>"+aaa027name+"</td><td>"
    			        +unlocktime+"</td><td>"+ remark+"</td></tr>");
    		}
    	}
    	sb.append(" </table> </body> </html>");
		return sb.toString().replaceAll("null","");
    	
    }
    
    public String queryloghtml(Syslogonlog dto) throws Exception{ 
		List<Syslogonlog> ls = queryversion(dto);		  
		StringBuffer sbhtml = new StringBuffer(); 
		sbhtml.append("<!DOCTYPE html> <html> <head lang='en'><title>登录统计</title>");
		sbhtml.append(" <meta http-equiv='content-type' content='text/html; charset=UTF-8'> ");
		sbhtml.append("<style type='text/css'>       ");  
		sbhtml.append("    	table{			 ");
    	sbhtml.append("    	width:600px;		 ");
    	sbhtml.append("    	margin:0px auto;	 ");
    	sbhtml.append("    	font:Georgia 11px;	 ");
    	sbhtml.append("    	color:black;		 ");
    	sbhtml.append("    	text-align:center;	 ");
    	sbhtml.append("    	border-collapse:collapse;");
    	sbhtml.append("    	}			 ");
    	sbhtml.append("    	table td{		 ");
    	sbhtml.append("    	border:1px solid gray;	 ");
    	sbhtml.append("    	width:196px;		 ");
    	sbhtml.append("    	height:30px;		 ");
    	sbhtml.append("    	}			 ");
    	sbhtml.append("</style>                      ");  
		sbhtml.append("</head> <body> <table width='99%'; border='1px'> ");
		sbhtml.append("<tr>  <td>登录时间</td> <td>用户名</td><td>版本号</td></tr>");
		if(ls.size()>0){
			String logontime = "";  //登录时间
			String logfailedreason = "";  //执法人员姓名
			String logonappvision = "";  //手机版本号
			for(int i=0 ; i<ls.size();i++){
				Syslogonlog log = (Syslogonlog) ls.get(i);
				logontime = (log.getLogontime()==null||"".equals(log.getLogontime()))?"":DATE_FORMAT.format(log.getLogontime());
				logfailedreason = log.getLogfailedreason();
				logonappvision = log.getLogonappvision();
				sbhtml.append(" <tr> <td>"+logontime+"</td><td>"
				+logfailedreason+"</td><td>"+logonappvision+"</td></tr>");	
			}
		}
		sbhtml.append(" </table> </body> </html>");
		return sbhtml.toString();
    	
    }    
	public Map find_zfry(String aaa027) throws Exception {
		if(aaa027==null || aaa027.equals("")){
			aaa027 = SysmanageUtil.getSysuser().getAaa027();
		}
		String sql = "select userid,description from sysuser where USERKIND =5 AND AAA027='"+aaa027+"'";
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null );
		return m;
	}

	/**
	 * 用户签到时间设置
	 * @param request
	 * @param dto
	 * @return
	 * zy
	 */
	public String saveSysuserSignInTime(HttpServletRequest request, SysuserDTO dto){
		try {
			saveSysuserSignInTimeImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 用户签到时间设置
	 * @param request
	 * @param dto
	 * @throws Exception
	 * zy
	 */
	@Aop({"trans"})
	public void saveSysuserSignInTimeImpl(HttpServletRequest request, SysuserDTO dto) throws Exception{

		// 是否全部设置
		String isAll = StringHelper.showNull2Empty(request.getParameter("isAll"));
		// 通过组织机构
		String byOrg = StringHelper.showNull2Empty(request.getParameter("byOrg"));
		if ("true".equals(isAll)) {
			// 查找出汤阴食药监机构下的所有用户
			String v_sql = "SELECT s.* FROM sysuser s, sysorg s1 WHERE s.orgid = s1.ORGID " +
					"AND s1.orgcode like '410001%' ";
			List<Sysuser> userList = DbUtils.getDataList(v_sql, Sysuser.class);
			for (int j = 0; j < userList.size(); j++) {
				Sysuser v_user = userList.get(j);
				v_user.setAllowsignintime(dto.getAllowsignintime()); // 允许开始签到时间
				v_user.setSignintime(dto.getSignintime()); // 签到截至时间
				if ("".equals(v_user.getAllowloginperiod())) {
					v_user.setAllowloginperiod(null);
				}
				dao.update(v_user);
			}
		} else if ("true".equals(byOrg)) {
			if (dto.getOrgid() != null && !"".equals(dto.getOrgid())) {
				String[] orgids = dto.getOrgid().split(",");
				for (int i = 0; i < orgids.length; i++) {
					// 查找出汤阴食药监机构下的所有用户
					String v_sql = "SELECT s.* FROM sysuser s, sysorg s1 WHERE s.orgid = s1.ORGID " +
							"AND s1.orgid = '" + orgids[i] + "' ";
					List<Sysuser> userList = DbUtils.getDataList(v_sql, Sysuser.class);
					for (int j = 0; j < userList.size(); j++) {
						Sysuser v_user = userList.get(j);
						v_user.setAllowsignintime(dto.getAllowsignintime()); // 允许开始签到时间
						v_user.setSignintime(dto.getSignintime()); // 签到截至时间
						if ("".equals(v_user.getAllowloginperiod())) {
							v_user.setAllowloginperiod(null);
						}
						dao.update(v_user);
					}
				}
			}
		} else {
			Sysuser user = dao.fetch(Sysuser.class, dto.getUserid());
			user.setAllowsignintime(dto.getAllowsignintime()); // 允许开始签到时间
			user.setSignintime(dto.getSignintime()); // 签到截至时间
			dao.update(user);
		}
	}

	/**
	 *
	 * addSysuser的中文名称：新增用户
	 *
	 * addSysuser的概要说明：
	 *
	 * @return Written by : zjf
	 *
	 */
	public String recreateHuanXinUser(HttpServletRequest request) {
		try {
			recreateHuanXinUserImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void recreateHuanXinUserImp(HttpServletRequest request) throws Exception {
		String v_sql="select a.* from sysuser a where a.userid not  in ('0') and  substring(username,1,1)<>'m' and a.userkind not in ('6','7','8','20','21','30') ";
		List<Sysuser> v_userlist=(List<Sysuser>)DbUtils.getDataList(v_sql,Sysuser.class);
		if (v_userlist!=null && v_userlist.size()>0){
			for (Sysuser v_sysuserTemp:v_userlist){
				System.out.println("recreateHuanXinUserImp"+ v_sysuserTemp.getUserid());
				//SysEasemobService.getInstance().delSysuserFromEasemob(v_sysuserTemp);
				SysEasemobService.getInstance().addSysuserToEasemob(v_sysuserTemp);
			}
		}

	}

	/**
	 *
	 * addSysuser的中文名称：新增用户
	 *
	 * addSysuser的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public boolean zhucehuanxin(HttpServletRequest request, final Sysuser dto) {
		try {
			return zhucehuanxinImp(request, dto);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Aop( { "trans" })
	public boolean  zhucehuanxinImp(HttpServletRequest request, Sysuser dto) throws Exception {
		//dto.setUserid(userid);
		//dto.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());
        //需要有userid  passwd
		return SysEasemobService.getInstance().addSysuserToEasemob(dto);

	}

	/**
	 *
	 * addSysuser的中文名称：注销环信用户
	 *
	 * addSysuser的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public boolean delHuanxinUser(HttpServletRequest request, final Sysuser dto) {
		try {
			return delHuanxinUserImp(request, dto);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Aop( { "trans" })
	public boolean  delHuanxinUserImp(HttpServletRequest request, Sysuser dto) throws Exception {
		//dto.setUserid(userid);
		//dto.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());
		//需要有userid  passwd
		return SysEasemobService.getInstance().delSysuserFromEasemob(dto);

	}

	/**
	 *
	 * addSysuser的中文名称：注销环信用户
	 *
	 * addSysuser的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public boolean delHuanxinUserBatch(HttpServletRequest request, final Sysuser dto) {
		try {
			return delHuanxinUserBatchImp(request, dto);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Aop( { "trans" })
	public boolean  delHuanxinUserBatchImp(HttpServletRequest request, Sysuser dto) throws Exception {
		//dto.setUserid(userid);
		//dto.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());
		//需要有userid  passwd
		String v_sql="";
		List<Sysuser> v_listuser=new ArrayList<Sysuser>();
		if (!StringUtils.isEmpty(dto.getUsergridstr())){
			v_listuser=Json.fromJsonAsList(Sysuser.class,dto.getUsergridstr());
		}

		Sysuser paramSysuser=new Sysuser();
		for (int i=0;i<v_listuser.size();i++){
			paramSysuser=v_listuser.get(i);
			if (!SysEasemobService.getInstance().delSysuserFromEasemob(paramSysuser)){
				//throw new BusinessException("删除环信用户失败");
				return false;
			};
			v_sql="update sysuser set easemobflag='0' where userid='"+paramSysuser.getUserid()+"'";
			Sql v_sqls=  Sqls.create(v_sql);
			dao.execute(v_sqls);

			v_sql="delete t from sysuserhuanxinfriend t where userid='"+paramSysuser.getUserid()+"'";
			Sql v_exesql=Sqls.create(v_sql);
			dao.execute(v_exesql);
		}
        return true;
	}

	/**
	 *
	 * addSysuser的中文名称：注销环信用户
	 *
	 * addSysuser的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public boolean addHuanxinUserBatch(HttpServletRequest request, final Sysuser dto) {
		try {
			return addHuanxinUserBatchImp(request, dto);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Aop( { "trans" })
	public boolean  addHuanxinUserBatchImp(HttpServletRequest request, Sysuser dto) throws Exception {
		//dto.setUserid(userid);
		//dto.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());
		//需要有userid  passwd
		String v_sql="";
		List<Sysuser> v_listuser=new ArrayList<Sysuser>();
		if (!StringUtils.isEmpty(dto.getUsergridstr())){
			v_listuser=Json.fromJsonAsList(Sysuser.class,dto.getUsergridstr());
		}
		Sysuser paramSysuser=new Sysuser();
		for (int i=0;i<v_listuser.size();i++){
			paramSysuser=v_listuser.get(i);
			if (!SysEasemobService.getInstance().addSysuserToEasemob(paramSysuser)){
				//throw new BusinessException("删除环信用户失败");
				return false;
			}
			v_sql="update sysuser set easemobflag='1' where userid='"+paramSysuser.getUserid()+"'";
			Sql v_sqls=  Sqls.create(v_sql);
			dao.execute(v_sqls);
		}
		return true;

	}


	/**
	 *
	 * queryHuanxinSysuser的中文名称：查询环信用户
	 *
	 * queryHuanxinSysuser的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	public Map queryHuanxinSysuser(Sysuser dto, PagesDTO pd) throws Exception {
        String v_easemobflag="no";
        if (!StringUtils.isEmpty(dto.getEasemobflag())){
			v_easemobflag=dto.getEasemobflag();
		};

        String v_querytype="no";
        if (!StringUtils.isEmpty(dto.getQuerytype())){
        	v_querytype=dto.getQuerytype();
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select userid, username, passwd, description,userkind,a.usercomid,");
		sb.append(" lockstate,locktime, unlocktime, lockreason,userposition,");
		sb.append(" createtime,remark, a.orgid, aac002,aac154,aac003,signintime,allowsignintime,  ");
		sb.append(" mobile, mobile2,telephone,aaa027, aaz010,b.orgname,");
		sb.append(" (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,selfcomflag ");
		sb.append(" from Sysuser a,Sysorg b");
		sb.append(" where 1=1");
		sb.append("  and a.orgid = b.orgid");
		sb.append("  and a.userkind not in ('6','7','8','20','21','30') ");
		if ("0".equals(v_easemobflag)){
			sb.append("  and (a.easemobflag = '0' or a.easemobflag='' or a.easemobflag is null) ");
		}else if ("1".equals(v_easemobflag)){
			sb.append("  and a.easemobflag = '1' ");
		};

		if ("friend".equals(v_querytype)){
			sb.append(" and  exists (select 1 from sysuserhuanxinfriend t where t.frienduserid=a.userid and t.userid='"+dto.getUserid()+"') ");
		}else if ("nofriend".equals(v_querytype)){
			sb.append(" and a.easemobflag='1' and a.userid<>'"+dto.getUserid()+"' and not exists (select 1 from sysuserhuanxinfriend t where t.frienduserid=a.userid and t.userid='"+dto.getUserid()+"') ");
		};

		sb.append("  order by b.orgid,a.userid ");

		String sql = sb.toString();
		String[] ParaName = new String[] {"easemobflag" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysuser.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * delHuanxinUserBatch的中文名称：删除环信好友
	 *
	 * delHuanxinUserBatch的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public boolean delHuanxinFriendBatch(HttpServletRequest request, final Sysuser dto) {
		try {
			return delHuanxinFriendBatchImp(request, dto);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Aop( { "trans" })
	public boolean  delHuanxinFriendBatchImp(HttpServletRequest request, Sysuser dto) throws Exception {
		//dto.setUserid(userid);
		//dto.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());
		//需要有userid  passwd
		Sysuser v_Sysuser= (Sysuser)SysmanageUtil.getSysuser();
		String v_sql="";
		List<Sysuser> v_listuser=new ArrayList<Sysuser>();
		if (!StringUtils.isEmpty(dto.getUsergridstr())){
			v_listuser=Json.fromJsonAsList(Sysuser.class,dto.getUsergridstr());
		}
		Sysuser v_oldsysuser=dao.fetch(Sysuser.class,dto.getUserid());
		Sysuser paramSysuser=new Sysuser();
		Sysuser tempSysuser=new Sysuser();
		paramSysuser.setUserid(dto.getUserid());
		paramSysuser.setPasswd(v_oldsysuser.getPasswd());

		for (int i=0;i<v_listuser.size();i++){
			tempSysuser=v_listuser.get(i);
			paramSysuser.setEasemobfriend(tempSysuser.getUserid());
			if (!SysEasemobService.getInstance().delEasemobFriend(paramSysuser)){
				//throw new BusinessException("删除环信用户失败");
				return false;
			}

            v_sql="delete t from sysuserhuanxinfriend t where userid='"+dto.getUserid()+"' and frienduserid='"+tempSysuser.getUserid()+"'";
            Sql v_exesql=Sqls.create(v_sql);
            dao.execute(v_exesql);

		}
		return true;
	}

	/**
	 *
	 * addHuanxinFriendBatch的中文名称：增加环信好友
	 *
	 * addSysuser的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public boolean addHuanxinFriendBatch(HttpServletRequest request, final Sysuser dto) {
		try {
			return addHuanxinFriendBatchImp(request, dto);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Aop( { "trans" })
	public boolean  addHuanxinFriendBatchImp(HttpServletRequest request, Sysuser dto) throws Exception {
		//dto.setUserid(userid);
		//dto.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());
		//需要有userid  passwd
		Sysuser v_Sysuser= (Sysuser)SysmanageUtil.getSysuser();
		String v_sql="";
		List<Sysuser> v_listuser=new ArrayList<Sysuser>();
		if (!StringUtils.isEmpty(dto.getUsergridstr())){
			v_listuser=Json.fromJsonAsList(Sysuser.class,dto.getUsergridstr());
		}
		Sysuser v_oldsysuser=dao.fetch(Sysuser.class,dto.getUserid());
		Sysuser paramSysuser=new Sysuser();
		Sysuser tempSysuser=new Sysuser();
		paramSysuser.setUserid(dto.getUserid());
		paramSysuser.setPasswd(v_oldsysuser.getPasswd());
		for (int i=0;i<v_listuser.size();i++){
			tempSysuser=v_listuser.get(i);
			paramSysuser.setEasemobfriend(tempSysuser.getUserid());
			if (!SysEasemobService.getInstance().addSysuserEasemobFriend(paramSysuser)){
				//throw new BusinessException("删除环信用户失败");
				return false;
			}

			Sysuserhuanxinfriend v_newSysuserhuanxinfriend=new Sysuserhuanxinfriend();
			String v_Sysuserhuanxinfriendid=DbUtils.getSequenceStr();
			v_newSysuserhuanxinfriend.setSysuserhuanxinfriendid(v_Sysuserhuanxinfriendid);
			v_newSysuserhuanxinfriend.setUserid(dto.getUserid());
			v_newSysuserhuanxinfriend.setFrienduserid(tempSysuser.getUserid());
			v_newSysuserhuanxinfriend.setCzyname(v_Sysuser.getDescription());
			v_newSysuserhuanxinfriend.setCzsj(SysmanageUtil.currentTime());
			dao.insert(v_newSysuserhuanxinfriend);
		}
		return true;

	}

	/**
	 *
	 * queryUserHuanxinFriend的中文名称：查询环信用户好友
	 *
	 * queryUserHuanxinFriend的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	public Map queryUserHuanxinFriend(Sysuser dto, PagesDTO pd) throws Exception {
		String v_querytype="null";
		if (!StringUtils.isEmpty(dto.getQuerytype())){
			v_querytype=dto.getQuerytype();
		}

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.userid,a.description");
		sb.append(" from Sysuser a ");
		sb.append(" where 1=1");
		if ("huanxinfriend".equals(v_querytype)){
			sb.append("  and exists (select 1 from sysuserhuanxinfriend t where t.userid='"+dto.getUserid()+
							  "' and t.frienduserid=a.userid ) ");
		}

		if ("userinfo".equals(v_querytype)){
			sb.append("  and a.userid='"+dto.getUserid()+"' ");
		}


		sb.append("  order by a.userid");
		String sql = sb.toString();
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] { };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("kdkkdkdk "+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysuser.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * querySysuserNocom的中文名称：查询所有非企业操作员
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zjf
	 * @throws Exception
	 *
	 */
	public Map querySysuserNocom(Sysuser dto, PagesDTO pd) throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.userid,a.username,a.passwd,a.description,a.mobile,a.mobile2,b.orgname ");
		sb.append(" from Sysuser a,Sysorg b");
		sb.append(" where 1=1");
		sb.append("  and a.orgid = b.orgid");
        sb.append(" and a.userkind not in ('6','7','8','20','21','30') ");
		sb.append("  order by b.orgname,a.userid");
		String sql = sb.toString();
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] { };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("kdkkdkdk "+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysuser.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

}
