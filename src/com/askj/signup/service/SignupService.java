package com.askj.signup.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.askj.exam.dto.OtsExamsInfoDTO;
import com.askj.signup.dto.OtsExamUserEnrollDTO;
import com.askj.signup.dto.OtsExamUserRegDTO;
import com.askj.signup.entity.OtsExamUserEnroll;
import com.askj.signup.entity.OtsExamUserReg;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.MD5Util;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
/**
 * 
 *  SignupService的中文名称：注册用户
 *
 *  SignupService的描述：
 *
 *  Written  by  : wcl
 */
public class SignupService extends BaseService {

protected final Logger logger = Logger.getLogger(SignupService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * saveUser的中文名称：保存注册信息
	 * 
	 * saveUser的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : wcl
	 */
	public String saveUser(HttpServletRequest request,OtsExamUserRegDTO dto){
		try {
			saveUserImpl(request,dto);
		} catch (Exception e) {
			// TODO: handle exception
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveUserImp的中文名称：保存注册用户实现
	 *
	 * saveUserImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : wcl
	 */
	@Aop( { "trans" })
	public void saveUserImpl(HttpServletRequest request,OtsExamUserRegDTO dto)throws Exception{
		String userId=DbUtils.getSequenceStr();
		String passWord=dto.getRegPass();
		String userpwd= MD5Util.MD5(passWord).toLowerCase();
		OtsExamUserReg v_examuser=new OtsExamUserReg();
		Sysuser v_user=new Sysuser();
		v_examuser.setRegId(DbUtils.getSequenceStr());
		v_examuser.setRegName(dto.getRegName());
		v_examuser.setUserid(userId);
		v_examuser.setRegEmail(dto.getRegEmail());
		v_examuser.setRegTel(dto.getRegTel());
		dao.insert(v_examuser);
		v_user.setUserid(userId);
		v_user.setUsername(dto.getRegName());
		v_user.setPasswd(userpwd);
		dao.insert(v_user);
	}
	/**
	 * 
	 * examCom的中文名称：考试下拉框
	 * 
	 * examCom的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List examCom(HttpServletRequest request,OtsExamsInfoDTO dto) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT * from ots_exams_info a");
		String sql = sb.toString();
		String[] paramName = new String[] {};
		int[] paramType = new int[] {};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsExamsInfoDTO.class);
		List  ls = (List) m.get(GlobalNames.SI_RESULTSET);
		List resLs = new ArrayList();
		for (int i = 0; i < ls.size(); i++) {
			OtsExamsInfoDTO s=(OtsExamsInfoDTO) ls.get(i);
			Map cm = new HashMap();
			cm.put("id", s.getExamsInfoId());
			cm.put("text", s.getExamsInfoName());
			resLs.add(cm);
		}
		return resLs;
	}
	
	
	/**
	 * 
	 * queryRegisterObj的中文名称：查询当前用户
	 * 
	 * queryRegisterObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryRegisterObj(HttpServletRequest request, OtsExamUserRegDTO dto) throws Exception {
		String RegisterId="2017060117213879099263400";//获取当前用户ID
		OtsExamUserReg v_examUserReg=dao.fetch(OtsExamUserReg.class, RegisterId);
		OtsExamUserRegDTO v_dto=new OtsExamUserRegDTO();
		BeanHelper.copyProperties(v_examUserReg, v_dto);
		Map map = new HashMap();
		map.put("v_examUserReg", v_dto); // 注册信息
		return map;
		
		
	}
	
	
	
	
	
	/**
	 * 
	 * saveSign的中文名称：保存报名信息方法
	 * 
	 * saveSign的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : wcl
	 */
	
	public String saveSign(HttpServletRequest request,OtsExamUserEnrollDTO dto){
		try {
			saveSignImp(request,dto);
		} catch (Exception e) {
			// TODO: handle exception
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
		
	} 
	
	/**
	 * 
	 * saveSignImp的中文名称：保存报名信息方法实现
	 * 
	 * saveSignImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : wcl
	 */
	@Aop( { "trans" })
	public void saveSignImp(HttpServletRequest request,OtsExamUserEnrollDTO dto)throws Exception{
		String enroll_state="2";//提交时的的状态
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		OtsExamUserEnroll v_examUserEnroll=new OtsExamUserEnroll();
		v_examUserEnroll.setEnrollId(DbUtils.getSequenceStr());
		v_examUserEnroll.setRegId(dto.getRegId());
		v_examUserEnroll.setEnrollName(dto.getEnrollName());
		v_examUserEnroll.setEnrollExamId(dto.getEnrollExamName());
		v_examUserEnroll.setEnrollExamName(dto.getEnrollExamId());
		v_examUserEnroll.setEnrollSex(dto.getEnrollSex());
		v_examUserEnroll.setEnrollUnit(dto.getEnrollUnit());
		v_examUserEnroll.setEnrollIdcardType(dto.getEnrollIdcardType());
		v_examUserEnroll.setEnrollIdcardNo(dto.getEnrollIdcardNo());
		v_examUserEnroll.setEnrollState(enroll_state);
		v_examUserEnroll.setEnrollRemark(dto.getEnrollRemark());
		v_examUserEnroll.setEnrollTime(Timestamp.valueOf(v_dbDatetime));
		dao.insert(v_examUserEnroll);
	}
	
	
	
	/**
	 * 
	 * queryAuditorsInfos的中文名称：查询审核中的人员
	 * 
	 * queryAuditorsInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryAuditorsInfos(HttpServletRequest request, OtsExamUserEnrollDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.enroll_id,a.reg_id,a.enroll_name,a.enroll_exam_id,a.enroll_exam_name, ");
		sb.append(" a.enroll_idcard_type,a.enroll_idcard_no,a.enroll_sex,a.enroll_state,a.enroll_time, ");
		sb.append(" a.enroll_unit,a.enroll_remark from ots_exam_user_enroll a WHERE a.enroll_state='2' ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] {};
		int[] paramType = new int[] {};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsExamUserEnrollDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * queryDetailedObj的中文名称：查询当前用户报名的详细信息
	 * 
	 * queryDetailedObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryDetailedObj(HttpServletRequest request, OtsExamUserEnrollDTO dto) throws Exception {
		String enrollId=dto.getEnrollId();
		OtsExamUserEnroll v_examUserEnroll=dao.fetch(OtsExamUserEnroll.class, enrollId);
		OtsExamUserEnrollDTO v_dto=new OtsExamUserEnrollDTO();
		BeanHelper.copyProperties(v_examUserEnroll, v_dto);
		Map map = new HashMap();
		map.put("v_examUserEnroll", v_dto); // 报名信息
		return map;
	}
	
	
	/**
	 * 
	 * uodateSign的中文名称：修改审核状态
	 * 
	 * uodateSign的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	public String uodateSign(HttpServletRequest request,OtsExamUserEnrollDTO dto){
		try {
			uodateSignImp(request,dto);
		} catch (Exception e) {
			// TODO: handle exception
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
		
	}
	/**
	 * 
	 * uodateSignImp的中文名称：修改审核状态实现
	 * 
	 * uodateSignImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : wcl
	 */
	@Aop( { "trans" })
	public void uodateSignImp(HttpServletRequest request,OtsExamUserEnrollDTO dto)throws Exception{
		String v_enrollState=request.getParameter("v_state");
		String v_enrollId=dto.getEnrollId();
		if(v_enrollState.equals("3")){
			OtsExamUserEnroll v_examUserEnroll=dao.fetch(OtsExamUserEnroll.class, v_enrollId);
			v_examUserEnroll.setEnrollState("3");
			dao.update(v_examUserEnroll);
		}else{
			OtsExamUserEnroll v_examUserEnroll=dao.fetch(OtsExamUserEnroll.class, v_enrollId);
			v_examUserEnroll.setEnrollState("4");
			dao.update(v_examUserEnroll);
		}
	}
	
	
	
	/**
	 * 
	 * queryExamineObj的中文名称：查询当前用户的审核信息
	 * 
	 * queryExamineObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	 
		@SuppressWarnings({ "rawtypes", "unchecked" })
		public Map queryExamineObj(HttpServletRequest request, OtsExamUserEnrollDTO dto) throws Exception {
			String RegisterId="2017060616012129775395718";//获取当前用户ID
			OtsExamUserEnroll v_examUserEnroll=dao.fetch(OtsExamUserEnroll.class, RegisterId);	//根据当前用户ID查询报名的信息
			OtsExamUserEnrollDTO v_dto=new OtsExamUserEnrollDTO();
			BeanHelper.copyProperties(v_examUserEnroll, v_dto);
			Map map = new HashMap();
			map.put("v_examUserEnroll", v_dto); // 报名的信息
			return map;
		}
		
		
		
		/**
		 * 
		 * uodateState的中文名称：点击缴费修改状态
		 * 
		 * uodateState的概要说明：
		 *
		 * @param request
		 * @param dto
		 * @return
		 * @author : wcl
		 */
		public String uodateState(HttpServletRequest request,OtsExamUserEnrollDTO dto){
			try {
				uodateStateImp(request,dto);
			} catch (Exception e) {
				// TODO: handle exception
				return Lang.wrapThrow(e).getMessage();
			}
			return null;
			
		}
		
		/**
		 * 
		 * uodateSignImp的中文名称：修改审核状态实现
		 * 
		 * uodateSignImp的概要说明：
		 *
		 * @param request
		 * @param dto
		 * @throws Exception
		 * @author : wcl
		 */
		@Aop( { "trans" })
		public void uodateStateImp(HttpServletRequest request,OtsExamUserEnrollDTO dto)throws Exception{
			OtsExamUserEnroll v_examUserEnroll=dao.fetch(OtsExamUserEnroll.class, dto.getEnrollId());
			v_examUserEnroll.setEnrollState("5");
			v_examUserEnroll.setEnrollNumber(DbUtils.getSequenceStr());
			dao.update(v_examUserEnroll);
		}
		
		
		

}
