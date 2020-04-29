package com.zzhdsoft.mvc.sysmanager;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.lbs.util.StringUtils;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import com.alibaba.fastjson.util.Base64;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.sysmanager.LoginService;
import com.zzhdsoft.utils.Encrypt;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * LoginModule的中文名称：用户登录module
 *
 * LoginModule的描述：
 *
 * @author ：zjf 
 * @version ：V1.0
 */
@IocBean
@At("/login")
@Fail("jsp:/jsp/error/error")
public class LoginModule {

	@Inject
	private LoginService loginService;

	/**
	 * 
	 * verify的中文名称：登录校验
	 * 
	 * verify的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("json")
	public Object verify(HttpServletRequest request, @Param("..") Sysuser dto)
			throws Exception {
		return SysmanageUtil.execAjaxResult(loginService.verify(request, dto));
	}

	/**
	 *
	 * verify的中文名称：登录校验
	 *
	 * verify的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@At
	@Ok("re:jsp:/jsp/error/error")
	public String comuserlogin(HttpServletRequest request, @Param("..") Sysuser dto)
			throws Exception {
		String v_ret=loginService.verify(request, dto);
		if (StringUtils.isNotEmpty(v_ret)){
			//return SysmanageUtil.execAjaxResult(v_ret);
			return v_ret;
		}else{
			//return "jsp:/jsp/main";
			return "jsp:/jsp/main";
		}
	}

	/**
	 * 
	 * gohome的中文名称：跳转主页
	 * 
	 * gohome的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	@At
	@Ok("jsp:/jsp/main")
	public void gohome(HttpServletRequest request, @Param("..") Sysuser dto)
			throws Exception {
		Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
		String passwordflag = "";
		// session是否有效
		HttpSession session = Mvcs.getHttpSession(false);
		if (session != null && sysuser !=null) {			
			if("e10adc3949ba59abbe56e057f20f883e".equalsIgnoreCase(sysuser.getPasswd())){
				passwordflag = "1";//强制用户更改系统初始化密码
				session.setAttribute("passwordflag", passwordflag);				
			}
		}
//		return new JspView(GlobalNames.MAIN_PAGE);
	}

	/**
	 * 
	 * logout的中文名称：退出系统
	 * 
	 * logout的概要说明：
	 * 
	 * @param req
	 *            Written by : zjf
	 * 
	 */
	@At
	@Ok("redirect:/")
	public void logout(HttpServletRequest req) {
		req.getSession().removeAttribute("systemcode");//zjf
		req.getSession().invalidate();
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
	@At
	@Ok("json")
	public Object modifyPwd(HttpServletRequest request, @Param("..") Sysuser dto)
			throws Exception {
		return SysmanageUtil.execAjaxResult(loginService
				.modifyPwd(request, dto));
	}
	
	/**
	 * 
	 * checkStat的中文名称：检测扫码登录
	 * 
	 * checkStat的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object checkStat(HttpServletRequest request) {
		Map<String, String> result = new HashMap<String, String>();
		try {
			//获取sessionid
			String sessionId = request.getSession().getId();
			//System.out.println("checkStat:sessionId="+sessionId);
			if(SysmanageUtil.getSessionContext().containsKey(sessionId)){
				int stat = Integer.parseInt(SysmanageUtil.getSessionContext().get(sessionId)[2]);
				if(Calendar.getInstance().getTimeInMillis()-Long.parseLong(SysmanageUtil.getSessionContext().get(sessionId)[1])>60000){
					result.put("STAT", "1031");
					result.put("MSG", "二维码超时！");
					return SysmanageUtil.execAjaxResult(result, null);
				}
				switch(stat){
				case 100: 
					result.put("STAT", "100"); 
					result.put("MSG", "检测登录状态!");
					break;
				case 106: 
					String msgcode = "106";
					boolean flag = false;
					// 调用登录接口
					Sysuser dto = new Sysuser();
					dto.setUserid(SysmanageUtil.getSessionContext().get(sessionId)[3]);
					dto.setUsername(SysmanageUtil.getSessionContext().get(sessionId)[4]);
					String res = loginService.verify(request, dto);
					if(res==null){
						result.put("STAT", "200"); 
						result.put("MSG", "登录成功!");
						String[] bb=  SysmanageUtil.getSessionContext().get(sessionId);
						bb[2] = "200";
						String[] bbc = new String[]{bb[0],bb[1],bb[2],bb[3],bb[4]};
						SysmanageUtil.getSessionContext().put(sessionId, bbc);
					}else{
						result.put("STAT", "300"); 
						result.put("MSG", "登录过程中出现错误：" + res);
					}				
					break;
				}				
			}else{
				result.put("STAT", "102");
				result.put("MSG", "会话超时,请刷新页面！");
			}
			return SysmanageUtil.execAjaxResult(result, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);
		}
	}
	
	
	/**
	 * 
	 * qrlogin的中文名称：手机APP扫码登录
	 * 
	 * qrlogin的概要说明： 
	 * 
	 * @param request
	 *            Written by : gjf
	 * 
	 */
	@At
	@Ok("json")
	public Object qrlogin(HttpServletRequest request) {
		//获取sessionid
		String sessionId = "";
		Map<String, String> result = new HashMap<String, String>();
		String content = request.getParameter("content");
		
		try {
			if(content==null||"".equals(content)){
				result.put("STAT", "1011");
				result.put("MSG", "发送的信息不能为空！");
				return SysmanageUtil.execAjaxResult(result, null);
			}
			String userinfo = content.substring(152);//
			userinfo = new String(Base64.decodeFast(userinfo),"UTF-8");
			String[] userinfos = userinfo.split("\\.");
			if(userinfos.length!=2){
				result.put("STAT", "1014");
				result.put("MSG", "发送的信息不符合规范！");
				return SysmanageUtil.execAjaxResult(result, null);
			}
			String userid = userinfos[0];
			String username = userinfos[1];
			content = content.substring(0,152);//
			String codeST = content.substring(content.length()-4);
			String codeED = content.substring(0,4);
			String key = codeST+codeED;
			
			//把手机端发过来的信息解密
			content = Encrypt.decrypt(content.substring(4,content.length()-4), key);
			
			if(content==null){
				result.put("STAT", "1012");
				result.put("MSG", "解密失败！");
				return SysmanageUtil.execAjaxResult(result, null);
			}
			
			String[] contents = content.split("\\.");
			sessionId = contents[0];
			String grantCodeSrc = contents[1];
			if(contents.length==2){
				if(SysmanageUtil.getSessionContext().containsKey(sessionId)){
					int stat = Integer.parseInt(SysmanageUtil.getSessionContext().get(sessionId)[2]);
					if(Calendar.getInstance().getTimeInMillis()-Long.parseLong(SysmanageUtil.getSessionContext().get(sessionId)[1])>60000){
						result.put("STAT", "1031");
						result.put("MSG", "二维码超时！");
						return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
					}
					switch(stat){
					case 100: 
						//检测授权ID是否合法
						String grantCode = SysmanageUtil.getSessionContext().get(sessionId)[0];
						if(!grantCode.equals(grantCodeSrc)){
							result.put("STAT", "1032"); 
							result.put("MSG", "二维码不符合！");
							return SysmanageUtil.execAjaxResult(result, null);
						}
						String[] bb =  SysmanageUtil.getSessionContext().get(sessionId);
						bb[2] = "106";
						String[] bbc = new String[]{bb[0],bb[1],bb[2],userid,username};
						SysmanageUtil.getSessionContext().put(sessionId, bbc);
						//修改控制码状态为106
						result.put("STAT", "106"); 
						result.put("MSG", "扫描成功!");
						break;
					case 106: 
						//状态为106
						result.put("STAT", "108"); 
						result.put("MSG", "正在登录！");
						break;
					case 200: 
						result.put("STAT", "200"); 
						result.put("MSG", "登录成功!");
						break;
					}
									
				}else{
					result.put("STAT", "102");
					result.put("MSG", "会话超时,请刷新页面！");
				}
			}else{
				result.put("STAT", "1013");
				result.put("MSG", "解密失败！");
			}
			return SysmanageUtil.execAjaxResult(result, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);
		}
	}
}
