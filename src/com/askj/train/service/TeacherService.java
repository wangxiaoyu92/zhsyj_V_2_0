package com.askj.train.service;

import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;

import com.askj.train.dto.OtsTeacherDTO;
import com.askj.train.entity.OtsTeacher;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysrole;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuserrole;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.MD5Util;
import com.zzhdsoft.utils.PinYinUtil;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 *  TeacherService的中文名称：培训子系统-教师管理
 *
 *  TeacherService的描述：
 *
 *  Written  by  : zy
 */
@IocBean
public class TeacherService extends BaseService{
	
	protected final Logger logger = Logger.getLogger(TeacherService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryTeachers的中文名称：查询教师列表信息
	 * 
	 * queryTeachers的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryTeachers(HttpServletRequest request, OtsTeacherDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT t.teacher_id, t.teacher_name, t.teacher_age, t.teacher_sex, ");
		sb.append(" t.teacher_positional, t.teacher_tel, t.teacher_weibo, t.teacher_blog, ");
		sb.append(" t.teacher_addr, t.teacher_des, t.teacher_email, t.teacher_birthday, t.aae011, ");
		sb.append(" t.aae036, t.teacher_type ");
		sb.append(" FROM  ots_teacher t  ");
		sb.append(" where 1 = 1 ");
		sb.append(" and t.teacher_sex = :teacherSex "); // 教师性别
		sb.append(" and t.teacher_type = :teacherType "); // 教师类别
		sb.append(" and t.teacher_name like :teacherName "); // 教师姓名
		sb.append(" order by teacher_id desc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "teacherSex", "teacherType", "teacherName"  };
		int[] paramType = new int[] { Types.INTEGER, Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsTeacherDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * saveTeacher的中文名称：保存教师信息
	 * 
	 * saveTeacher的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String saveTeacher(HttpServletRequest request, OtsTeacherDTO dto) {
		try {
			saveTeacherImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveTeacherImp的中文名称：保存课程方法实现
	 * 
	 * saveTeacherImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop( { "trans" })
	public void saveTeacherImp(HttpServletRequest request, OtsTeacherDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		// 如果id存在，更新
		if (dto.getTeacherId() != null && !"".equals(dto.getTeacherId())) {
			// 更新教师信息
			OtsTeacher v_teacher = dao.fetch(OtsTeacher.class, dto.getTeacherId());
			v_teacher.setTeacherName(dto.getTeacherName()); // 教师姓名
			v_teacher.setTeacherAge(dto.getTeacherAge()); // 教师年龄
			v_teacher.setTeacherSex(dto.getTeacherSex()); // 教师性别
			v_teacher.setTeacherPositional(dto.getTeacherPositional()); // 讲师
			v_teacher.setTeacherTel(dto.getTeacherTel()); // 联系方式
			v_teacher.setTeacherWeibo(dto.getTeacherWeibo()); // 微博
			v_teacher.setTeacherBlog(dto.getTeacherBlog()); // 博客
			v_teacher.setTeacherAddr(dto.getTeacherAddr()); // 地址
			v_teacher.setTeacherDes(dto.getTeacherDes()); // 描述
			v_teacher.setTeacherEmail(dto.getTeacherEmail()); // 邮箱
			v_teacher.setTeacherBirthday(dto.getTeacherBirthday()); // 生日
			v_teacher.setAae011(vSysUser.getDescription()); // 经办人
			v_teacher.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
			v_teacher.setTeacherType(dto.getTeacherType()); // 1是内部讲师 0外部讲师
			dao.update(v_teacher);

			// 更新用户信息
			Sysuser v_user = dao.fetch(Sysuser.class, dto.getTeacherId());
			v_user.setUsername(PinYinUtil.GetChineseSpell(dto.getTeacherName()).toLowerCase()); // 用户名
			v_user.setPasswd(MD5Util.MD5("123456").toLowerCase()); // 初始密码
			v_user.setDescription(dto.getTeacherName()); // 用户描述
			v_user.setLockstate("0"); // 用户锁定状态，默认正常
			v_user.setUserkind("19"); // 用户类别 
			v_user.setMobile(dto.getTeacherTel()); // 联系方式
			v_user.setAaa027(vSysUser.getAaa027()); // 统筹区
			v_user.setOrgid(vSysUser.getOrgid()); // 组织机构id
			dao.update(v_user);
			
		} else {
			// 添加教师信息
			OtsTeacher v_teacher = new OtsTeacher();
			String v_id = DbUtils.getSequenceStr();
			v_teacher.setTeacherId(v_id); // id
			v_teacher.setTeacherName(dto.getTeacherName()); // 教师姓名
			v_teacher.setTeacherAge(dto.getTeacherAge()); // 教师年龄
			v_teacher.setTeacherSex(dto.getTeacherSex()); // 教师性别
			v_teacher.setTeacherPositional(dto.getTeacherPositional()); // 讲师
			v_teacher.setTeacherTel(dto.getTeacherTel()); // 联系方式
			v_teacher.setTeacherWeibo(dto.getTeacherWeibo()); // 微博
			v_teacher.setTeacherBlog(dto.getTeacherBlog()); // 博客
			v_teacher.setTeacherAddr(dto.getTeacherAddr()); // 地址
			v_teacher.setTeacherDes(dto.getTeacherDes()); // 描述
			v_teacher.setTeacherEmail(dto.getTeacherEmail()); // 邮箱
			v_teacher.setTeacherBirthday(dto.getTeacherBirthday()); // 生日
			v_teacher.setAae011(vSysUser.getDescription()); // 经办人
			v_teacher.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
			v_teacher.setTeacherType(dto.getTeacherType()); // 1是内部讲师 0外部讲师
			dao.insert(v_teacher);
			
			// 为该教师添加系统登录账户
			Sysuser v_user = new Sysuser();
			v_user.setUserid(v_id); // id
			v_user.setUsername(PinYinUtil.GetChineseSpell(dto.getTeacherName()).toLowerCase()); // 用户名
			v_user.setPasswd(MD5Util.MD5("000000").toLowerCase()); // 初始密码
			v_user.setDescription(dto.getTeacherName()); // 用户描述
			v_user.setLockstate("0"); // 用户锁定状态，默认正常
			v_user.setUserkind("19"); // 用户类别  考试培训教室角色
			v_user.setMobile(dto.getTeacherTel()); // 联系方式
			v_user.setAaa027(vSysUser.getAaa027()); // 统筹区
			v_user.setOrgid(vSysUser.getOrgid()); // 组织机构id
			dao.insert(v_user);
			
			// 为该用户绑定角色权限
			Sysuserrole userRole = new Sysuserrole();
			List<Sysrole> list = dao.query(Sysrole.class, Cnd.where("rolename", "like", "%教师%"));
			String roleId = "";
			if  (list != null && list.size() > 0) {
				roleId = list.get(0).getRoleid();
			}
			userRole.setRoleid(roleId);
			userRole.setUserid(v_id);
			userRole.setUserroleid(DbUtils.getSequenceStr());
			dao.insert(userRole);
		}
	}
	
	/**
	 * 
	 * queryTeacherObj的中文名称：查询教师信息
	 * 
	 * queryTeacherObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryTeacherObj(HttpServletRequest request, OtsTeacherDTO dto) throws Exception {
		// 教师信息
		OtsTeacher info = dao.fetch(OtsTeacher.class, dto.getTeacherId());
		Map map = new HashMap();
		map.put("teacherInfo", info); 
		return map;
	}
	
	/**
	 * 
	 * delTeacher的中文名称：删除教师
	 * 
	 * delTeacher的概要说明：
	 *
	 * @param request
	 * @return
	 *        Written by : zy
	 */
	public String delTeacher(HttpServletRequest request, OtsTeacherDTO dto) {
		try {
			delTeacherImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delTeacherImp的中文名称：删除教师信息
	 * 
	 * delTeacherImp的概要说明：
	 *
	 * @param request
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void delTeacherImp(HttpServletRequest request, OtsTeacherDTO dto) throws Exception {
		// 删除教师信息
		dao.clear(OtsTeacher.class, Cnd.where("teacher_id", "=", dto.getTeacherId()));
		// 删除该教师的用户信息
		dao.clear(Sysuser.class, Cnd.where("userid", "=", dto.getTeacherId()));
		// 删除该用户的角色绑定关系
		dao.clear(Sysuserrole.class, Cnd.where("userid", "=", dto.getTeacherId()));
	}
	
}
