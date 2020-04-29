package com.zzhdsoft.siweb.service.sysmanager;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.lbs.util.StringUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.lang.Lang;
import com.lbs.leaf.cache.LeafCache;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.sysmanager.Syslogonlog;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.baseinfo.entity.Pcompany;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;

/**
 * 
 * LoginService的中文名称：用户登录service
 *
 * LoginService的描述：
 *
 * @author ：zjf 
 * @version ：V1.0
 */
public class LoginService extends BaseService {
	protected final Logger logger = Logger.getLogger(LoginService.class);
	@Inject
	private Dao dao;
	@Inject
	protected SysfunctionService sysfunctionService;

	/**
	 * 
	 * verify的中文名称：登录验证
	 * 
	 * verify的概要说明：
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String verify(HttpServletRequest request, Sysuser dto) throws Exception {
		try {
			// 通过手机获取验证码
			// if ("4".equals(dto.getUserkind())) {
			// // 前台输入的验证码yzm与后台生成的验证码记录表Syscaptcha中的记录比较，校验有效性、正确性。
			// String yzm = dto.getYzm();
			// Long yzmId = dto.getYzmId();
			// if (yzmId == null || "".equals(yzmId)) {
			// return "验证码生成失败，请重新获取！";
			// } else {
			// List ls = dao.query(Syscaptcha.class, Cnd
			// .wrap("Syscaptchaid=" + yzmId));
			// if (ls != null && ls.size() > 0) {
			// Syscaptcha syscaptcha = (Syscaptcha) ls.get(0);
			// Timestamp sendTime = syscaptcha.getSendtime();
			// Timestamp nowTime = new Timestamp(System
			// .currentTimeMillis());
			// int timeDiff = Integer.valueOf(
			// DateUtil.getTimeDifference(nowTime, sendTime))
			// .intValue();
			// int yzm_invalid = Integer.valueOf(
			// GlobalConfig.getAppConfig("yzm_invalid"))
			// .intValue();
			// if (timeDiff > yzm_invalid) {
			// return "验证码已过期，请重新获取！";
			// }
			//
			// String yzmContent = syscaptcha.getContent();
			// if (!yzm.equals(yzmContent)) {
			// return "验证码错误，请认真核对或重新获取！";
			// }
			// } else {
			// return "验证码无效，请重新获取！";
			// }
			// }
			// }


			
			//用户名+密码+验证码登录开关
			String yzmSwitch = "1";
			String qryzmSwitch = StringHelper.showNull2Empty(SysmanageUtil.getAa01("QRYZMSWITCH").getAaa005());
			if(!"".equals(qryzmSwitch)){
				yzmSwitch = qryzmSwitch;
			}

			//gu2018070 如何comid不为空，是万象企业登录
			//Boolean v_wanxiangcomlogin=false;
			String v_sql2="";
			if (StringUtils.isNotEmpty(dto.getComid())){
				v_sql2="select a.* from sysuser a,pcompany b where a.username=b.comdm and b.comid='"+dto.getComid()+"'";
				List<Sysuser> v_Sysuserlist=DbUtils.getDataList(v_sql2,Sysuser.class);
				if (v_Sysuserlist!=null && v_Sysuserlist.size()>0){
					Sysuser v_existsSysuser=(Sysuser)v_Sysuserlist.get(0);
					dto.setUsername(v_existsSysuser.getUsername());
				}else{
					return "用户名不能为空！";
				}
				yzmSwitch="0";//不用验证
				//v_wanxiangcomlogin=true;
			}

			if("1".equals(yzmSwitch) && !"".equals(StringHelper.showNull2Empty(dto.getYzm()))){
				// 前台页面自动生成验证码
				String yzm = dto.getYzm().toLowerCase();
				String verifyCode = (String) request.getSession().getAttribute(GlobalNames.VERIFYCODE);
				if (!yzm.equals(verifyCode)) {
					return "验证码错误，请认真核对或重新获取！";
				}
			}

			List<Sysuser> ls = null;
			// StringBuffer wh = new StringBuffer();
			// wh.append(" username='").append(dto.getUsername()).append("' ");
			// wh.append(" and passwd='").append(dto.getPasswd()).append("' ");
			// wh.append(" and userkind='").append(dto.getUserkind()).append("' ");
			// ls = dao.query(Sysuser.class, Cnd.wrap(wh.toString()));

			//登陆方式区分
			Aa01 aa01 = SysmanageUtil.getAa01("LOGIN");
			
			String v_sql = "select userid, username, passwd, description,userkind,lockstate,locktime, unlocktime, lockreason,a.usercomid,"
					+ " createtime,remark,reprole, a.orgid, aac002,aac154, mobile,mobile2, aac003, aaa027, aaz010,aaz001,b.orgname,"
					+ " (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,"
					+ " (select aae007 from Aa13 where aaa027 = a.aaa027) aae007,"
					+ " (select aae383 from Aa13 where aaa027 = a.aaa027) aae383,b.orgcode "
					+ " ,(select max(fjpath) from fj t where t.fjwid=a.userid) as qzpicpath "//gu20170110 用户签字图片存放路径
					+",selfcomflag "
					+",(case when userkind IN ('6','7','8','20','21','30') then '2' else '1' end) as userdalei "
					+ " from Sysuser a,Sysorg b " 
					+ " where a.orgid = b.orgid ";
			//手机扫码登录使用
			String userid = StringHelper.showNull2Empty(dto.getUserid());
			if(!"".equals(userid)){
				v_sql += " and a.userid = '" + userid+"' ";
			}
			if (dto.getUsername() != null && !"".equals(dto.getUsername())) {				
				if(aa01.getAaa005()==null ||  "".equals(aa01.getAaa005())){//默认登陆方式：用户名、手机号登录
					v_sql += " and (a.username='" + dto.getUsername() + "'";
					v_sql += "    or a.mobile = '" + dto.getUsername() + "'";
					v_sql += "    or a.mobile2 = '" + dto.getUsername() + "')";
				}else{
					if(dto.getUsername().startsWith(aa01.getAaa005()) || "admin".equals(dto.getUsername())){
						v_sql += " and (a.username='" + dto.getUsername() + "'";
						v_sql += "    or a.mobile = '" + dto.getUsername() + "'";
						v_sql += "    or a.mobile2 = '" + dto.getUsername() + "')";
					}else {
						//汤阴普通客户限定用手机号登录需要特殊处理(暂时未处理)
						v_sql += " and (a.username='" + dto.getUsername() + "'";
						v_sql += "    or a.mobile = '" + dto.getUsername() + "'";
						v_sql += "    or a.mobile2 = '" + dto.getUsername() + "')";//汤阴地区限制：只能用手机号登录
					}					
				}
			}else{
				return "用户名不能为空！";
			}
			
			if (dto.getPasswd() != null && !"".equals(dto.getPasswd())) {
				v_sql += " and a.passwd='" + dto.getPasswd() + "'";
			}
			if (dto.getUserkind() != null && !"".equals(dto.getUserkind())) {
				// v_sql+=" and a.userkind='"+dto.getUserkind()+"'";
			}
			ls = DbUtils.getDataList(v_sql, Sysuser.class);
			if (ls != null && ls.size() > 0) {
				Sysuser su = ls.get(0);

				if ("1".equals(su.getLockstate())) {
					return "该用户已经被锁定，锁定原因:" + su.getLockreason();
				}
				
				//gu 20160706 如果是企业登录记录 溯源企业类型
				su.setComsyqylx("0");
				if ("6".equals(su.getUserkind()) || "7".equals(su.getUserkind()) ||"8".equals(su.getUserkind())
						||"20".equals(su.getUserkind())||"21".equals(su.getUserkind())){
					//gu20170503 Pcompany v_pcom=dao.fetch(Pcompany.class, su.getUserid());
					//Pcompany v_pcom=dao.fetch(Pcompany.class, su.getAaz001());
					Pcompany v_pcom=dao.fetch(Pcompany.class, su.getUsercomid());
					su.setUsercommc(v_pcom.getCommc());
					su.setComsyqylx(v_pcom.getComsyqylx());
					su.setUsercomdalei(v_pcom.getComdalei());
				}
				SysmanageUtil.setSysuser(su);

				//子系统编码
				String systemcode = request.getParameter("systemcode");
				request.getSession().setAttribute("systemcode",systemcode);
				
				// 用户权限【菜单级】
				String menuData = Json.toJson(sysfunctionService.querySysfunctionZTree(su.getUserid(), su.getUserkind(), "1", null), JsonFormat
						.compact());
				// 用户权限【按钮级】
				String menuDataAll = Json.toJson(sysfunctionService.querySysfunctionZTree(su.getUserid(), su.getUserkind(), "", null),
						JsonFormat.compact());
				menuData = menuData.replace("isparent", "isParent");
				menuData = menuData.replace("isopen", "open");
				SysmanageUtil.setMenuData(menuData);
				SysmanageUtil.setMenuDataAll(menuDataAll);
				
				// 系统权限【按钮级】
				String menuDataSysAll = Json.toJson(sysfunctionService.querySysfunctionAll("2"),//结点类型：菜单节点是0，菜单叶子是1，按钮是2',
						JsonFormat.compact());	
				SysmanageUtil.setMenuDataSysAll(menuDataSysAll);

				SysmanageUtil.doLogonLog(request, su);
			} else {
				return "登录用户名或密码错误，请认真核对！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * modifyPwd的中文名称：用户修改密码
	 * 
	 * modifyPwd的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String modifyPwd(HttpServletRequest request, Sysuser dto) throws Exception {
		try {
			String userpwd_old = request.getParameter("passwd");
			String userpwd_new = request.getParameter("passwd2");
			if("e10adc3949ba59abbe56e057f20f883e".equals(userpwd_new)){
				return "新密码不能为初始密码！";
			}
			if(userpwd_old.equals(userpwd_new)){
				return "新密码密码不能于原来密码相同！";
			}
			Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();

			sysuser = dao.fetch(Sysuser.class, sysuser.getUserid());			
			if (sysuser != null) {
				String passwd = sysuser.getPasswd();

				if (passwd.equals(userpwd_old)) {
					sysuser.setPasswd(userpwd_new);
					SysEasemobService.getInstance().resetSysuserPasswordToEasemob(sysuser);
					dao.update(sysuser);
				} else {
					return "用户原密码不正确，无法修改密码！";
				}
			} else {
				throw new BusinessException("用户不存在，请联系系统管理员！");
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	
	
}
