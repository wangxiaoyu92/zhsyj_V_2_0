package com.askj.train.service;

import java.sql.Timestamp;
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
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import com.askj.train.dto.OtsCourseAppraiseDTO;
import com.askj.train.dto.OtsCourseDTO;
import com.askj.train.dto.OtsCourseHomeworkDTO;
import com.askj.train.dto.OtsCourseUserDTO;
import com.askj.train.dto.OtsCoursewareDTO;
import com.askj.train.dto.OtsHomeworkDTO;
import com.askj.train.dto.OtsTeacherDTO;
import com.askj.train.entity.OtsCourse;
import com.askj.train.entity.OtsCourseAppraise;
import com.askj.train.entity.OtsCourseHomework;
import com.askj.train.entity.OtsCourseTeacher;
import com.askj.train.entity.OtsCourseUser;
import com.askj.train.entity.OtsCourseWarelist;
import com.askj.train.entity.OtsHomework;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 *  CourseService的中文名称：培训子系统-课程管理
 *
 *  CourseService的描述：
 *
 *  Written  by  : zy
 */
public class CourseService extends BaseService{
	
	protected final Logger logger = Logger.getLogger(CourseService.class);
	
	@Inject
	private Dao dao;
	
	/**
	 * 
	 * queryCourseInfos的中文名称：查询课程列表
	 * 
	 * queryCourseInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCourseInfos(HttpServletRequest request, OtsCourseDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.course_id, a.course_name, a.course_category, a.course_status, a.course_des, ");
		sb.append(" a.course_click, a.course_elective, a.course_approve, a.course_pass_condition, a.course_start_time, ");
		sb.append(" a.course_end_time, a.class_start_time, a.class_end_time, a.course_allow_ip, a.course_frontCoverImg, ");
		sb.append(" a.course_isModifyProgress, a.course_train_type, a.course_offline_length, a.course_offline_credit, ");
		sb.append(" a.course_point_way, a.course_isListShow, a.course_proportion, a.course_see_single, a.course_auto_adopt, ");
		sb.append(" a.course_person_amount, a.course_courseLocation, a.registration, a.aae011, a.aae036, COUNT(b.ware_id) warecount ");
		sb.append(" FROM ots_course a LEFT JOIN ots_course_warelist b ON a.course_id = b.course_id ");
		sb.append(" where 1 = 1 ");
		if (dto.getCourseStatus() != null && !"".equals(dto.getCourseStatus())) {
			sb.append(" and a.course_status = '").append(dto.getCourseStatus()).append("' "); // 课程状态
		}
		if (dto.getCourseName() != null && !"".equals(dto.getCourseName())) {
			sb.append(" and a.course_name like '%").append(dto.getCourseName()).append("%' "); // 课程状态
		}
		
		sb.append(" GROUP BY a.course_id ");
		sb.append(" order by a.course_id desc");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] {};
		int[] paramType = new int[] {};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsCourseDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * queryStatistics的中文名称：查询课程统计评分统计
	 * 
	 * queryStatistics的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryStatistics(HttpServletRequest request, OtsCourseAppraiseDTO dto)throws Exception{
		
		String sql = "SELECT count(*) count, a.score score FROM ots_course_appraise a " +
				"WHERE 1=1 and a.course_id = :courseId GROUP BY a.score";
		String[] paramName = new String[] { "courseId" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsCourseAppraiseDTO.class);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		List countList = new ArrayList(); // 人数
		List scoreList = new ArrayList(); // 分数
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				OtsCourseAppraiseDTO v_dto = (OtsCourseAppraiseDTO) list.get(i);
				countList.add(v_dto.getCount());
				scoreList.add(v_dto.getScore());
			}
		}
		map.put("count", countList);
		map.put("score", scoreList);
		return map;
	}
	
	/**
	 * 
	 * saveCourse的中文名称：保存课程信息
	 * 
	 * saveCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String saveCourse(HttpServletRequest request, OtsCourseDTO dto) {
		try {
			saveCourseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveCourseImp的中文名称：保存课程方法实现
	 * 
	 * saveCourseImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop( { "trans" })
	public void saveCourseImp(HttpServletRequest request, OtsCourseDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		
		// 对课程信息保存
		// 如果id存在，更新
		if (dto.getCourseId() != null && !"".equals(dto.getCourseId())) {
			OtsCourse v_course = dao.fetch(OtsCourse.class, dto.getCourseId());
			v_course.setCourseName(dto.getCourseName()); // 课程名称
			v_course.setCourseCategory(dto.getCourseCategory()); // 课程分类
			v_course.setCourseStatus(dto.getCourseStatus()); // 课程状态
			v_course.setCourseDes(dto.getCourseDes()); // 课程描述
			v_course.setCoursePassCondition(dto.getCoursePassCondition()); // 通过条件
			v_course.setCourseIsmodifyprogress(dto.getCourseIsmodifyprogress()); // 播放限制
			v_course.setCourseTrainType(dto.getCourseTrainType()); // 培训类型
			v_course.setCourseAutoAdopt(dto.getCourseAutoAdopt()); // 报名自动审核
			v_course.setRegistration(dto.getRegistration()); // 代报名
			v_course.setAae011(vSysUser.getUserid()); // 经办人
			v_course.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
			dao.update(v_course);
		} else {
			OtsCourse v_course = new OtsCourse();
			v_course.setCourseId(DbUtils.getSequenceStr());
			v_course.setCourseName(dto.getCourseName()); // 课程名称
			v_course.setCourseCategory(dto.getCourseCategory()); // 课程分类
			v_course.setCourseStatus(dto.getCourseStatus()); // 课程状态
			v_course.setCourseDes(dto.getCourseDes()); // 课程描述
			v_course.setCoursePassCondition(dto.getCoursePassCondition()); // 通过条件
			v_course.setCourseIsmodifyprogress(dto.getCourseIsmodifyprogress()); // 播放限制
			v_course.setCourseTrainType(dto.getCourseTrainType()); // 培训类型
			v_course.setCourseAutoAdopt(dto.getCourseAutoAdopt()); // 报名自动审核
			v_course.setRegistration(dto.getRegistration()); // 代报名
			v_course.setAae011(vSysUser.getUserid()); // 经办人
			v_course.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
			dao.insert(v_course);
		}
	}
	
	/**
	 * 
	 * queryCourseObj的中文名称：查询课程信息
	 * 
	 * queryCourseObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCourseObj(HttpServletRequest request, OtsCourseDTO dto) throws Exception {
		// 课程信息
		OtsCourse courseInfo = dao.fetch(OtsCourse.class, dto.getCourseId());
		Map map = new HashMap();
		map.put("courseInfo", courseInfo); // 课程信息
		return map;
	}
	
	/**
	 * 
	 * delCourse的中文名称：删除课程信息
	 * 
	 * delCourse的概要说明：
	 *
	 * @param request
	 * @return
	 *        Written by : zy
	 */
	public String delCourse(HttpServletRequest request, OtsCourseDTO dto) {
		try {
			delCourseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delCourseImp的中文名称：删除课程信息方法实现
	 * 
	 * delCourseImp的概要说明：
	 *
	 * @param request
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void delCourseImp(HttpServletRequest request, OtsCourseDTO dto) throws Exception {
		// 删除课程课件对应关系
		dao.clear(OtsCourseWarelist.class, Cnd.where("course_id", "=", dto.getCourseId()));
		// 删除课程讲师对应关系
		dao.clear(OtsCourseTeacher.class, Cnd.where("course_id", "=", dto.getCourseId()));
		// 删除课程信息
		dao.clear(OtsCourse.class, Cnd.where("course_id", "=", dto.getCourseId()));
	}
	
	/**
	 * 
	 * queryTeacherOfCourse的中文名称：查询课程所包含讲师
	 * 
	 * queryTeacherOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryTeacherOfCourse(HttpServletRequest request, OtsCourseDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.teacher_id, a.teacher_name, a.teacher_age, a.teacher_sex, ");
		sb.append(" a.teacher_tel, a.teacher_addr, a.teacher_type, a.aae011, a.aae036 ");
		sb.append(" FROM ots_teacher a, ots_course b, ots_course_teacher c ");
		sb.append(" where 1=1 ");
		sb.append(" and b.course_id = c.course_id "); 
		sb.append(" and a.teacher_id = c.teacher_id ");
		sb.append(" and b.course_id = :courseId "); // 课程id
		sb.append(" order by a.teacher_id ASC ");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "courseId" };
		int[] paramType = new int[] { Types.VARCHAR };
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
	 * queryCourseWareOfCourse的中文名称：查询课程对应课件
	 * 
	 * queryCourseWareOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCourseWareOfCourse(HttpServletRequest request, OtsCourseDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.ware_id, a.ware_name, a.ware_status, a.ware_credit, a.ware_category, ");
		sb.append(" a.ware_type, a.ware_source, a.ware_video, a.ware_des, a.ware_length, ");
		sb.append(" substring_index(a.ware_video, '/', -1) file_name, "); // 文件名
		sb.append(" a.ware_des_h, a.ware_point, a.aae011, a.aae036 ");
		sb.append(" FROM ots_courseware a, ots_course b, ots_course_warelist c ");
		sb.append(" where 1 = 1 ");
		sb.append(" and a.ware_status = '0' "); // 课件状态,0=启用,1=禁用
		sb.append(" and b.course_id = c.course_id "); 
		sb.append(" and a.ware_id = c.ware_id ");
		sb.append(" and b.course_id = :courseId "); // 课程id
		sb.append(" order by c.ware_sequence ASC ");

		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "courseId" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsCoursewareDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * queryHomeworks的中文名称：查询作业列表
	 * 
	 * queryHomeworks的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryHomeworks(HttpServletRequest request, OtsHomeworkDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.homework_id, a.title, a.type, a.content, a.doc_id, a.score,  ");
		sb.append(" a.pass, a.aae011, a.aae036 ");
		sb.append(" FROM ots_homework a ");
		sb.append(" order by a.homework_id ASC ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] {};
		int[] paramType = new int[] {};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsHomeworkDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * queryHomeOfCourse的中文名称：查询课程所包含课后作业
	 * 
	 * queryHomeOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryHomeOfCourse(HttpServletRequest request, OtsCourseDTO dto, PagesDTO pd) throws Exception {
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT b.homework_id, b.type, b.title, b.content, b.score, b.pass, b.aae011, b.aae036  ");
		sb.append(" FROM ots_course a, ots_homework b, ots_course_homework c ");
		sb.append(" where a.course_id = c.course_id AND b.homework_id = c.homework_id ");
		sb.append(" and a.course_id = :courseId ");
		sb.append(" order by b.homework_id ASC ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "courseId" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsHomeworkDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * addHomeworkToCourse的中文名称：添加作业到课程
	 * 
	 * addHomeworkToCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String addHomeworkToCourse(HttpServletRequest request, OtsCourseHomeworkDTO dto) {
		try {
			addHomeworkToCourseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * addHomeworkToCourseImp的中文名称：添加课件到课程方法实现
	 * 
	 * addHomeworkToCourseImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void addHomeworkToCourseImp(HttpServletRequest request, OtsCourseHomeworkDTO dto)
			throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		// 保存课程作业对应关系
		JSONArray hwArr = JSONArray.fromObject(dto.getHomeworks());
		Object[] v_hwArray  = hwArr.toArray();
		if (v_hwArray.length > 0) {
			for (int i = 0; i < v_hwArray.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_hwArray[i]);
				// 判断作业是否加入课程
				boolean flag = checkHomeworkIsInCourse(v_obj.getString("homeworkId"), dto.getCourseId());
				if (!flag) {
					// 课程课件对应表保存
					OtsCourseHomework v_data = new OtsCourseHomework();
					v_data.setCourseId(dto.getCourseId()); // 关联课程ID
					v_data.setHomeworkId(v_obj.getString("homeworkId")); // 关联作业ID
					v_data.setAae011(vSysUser.getUserid()); // 经办人
					v_data.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
					dao.insert(v_data);
				}
			}
		}
	}
	
	/**
	 * 
	 * checkHomeworkIsInCourse的中文名称：检测课件是否在课程中
	 * 
	 * checkHomeworkIsInCourse的概要说明：
	 *
	 * @param homeworkId
	 * @param courseId
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	public boolean checkHomeworkIsInCourse(String homeworkId, String courseId)
			throws Exception {
		
		List<OtsCourseHomework> list = dao.query(OtsCourseHomework.class, Cnd.where("homework_id", "=", homeworkId)
				.and("course_id", "=", courseId));
		if (list != null && list.size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 
	 * delHomeworkOutOfCourse的中文名称：将作业从课程中删除
	 * 
	 * delHomeworkOutOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String delHomeworkOutOfCourse(HttpServletRequest request, OtsCourseHomeworkDTO dto) {
		try {
			delHomeworkOutOfCourseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delHomeworkOutOfCourseImp的中文名称：将作业从课程中删除实现方法
	 * 
	 * delHomeworkOutOfCourseImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void delHomeworkOutOfCourseImp(HttpServletRequest request, OtsCourseHomeworkDTO dto)
			throws Exception {
		JSONArray hwArr = JSONArray.fromObject(dto.getHomeworks());
		Object[] v_hwArray  = hwArr.toArray();
		if (v_hwArray.length > 0) {
			for (int i = 0; i < v_hwArray.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_hwArray[i]);
				dao.clear(OtsCourseHomework.class, Cnd.where("course_id", "=", dto.getCourseId())
						.and("homework_id", "=", v_obj.getString("homeworkId")));
			}
		}
	}
	
	/**
	 * 
	 * queryMyCourse的中文名称：查询我的课程
	 * 
	 * queryMyCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryMyCourse(HttpServletRequest request, OtsCourseDTO dto, PagesDTO pd)
			throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = new Sysuser();
			vSysUser = dao.fetch(Sysuser.class, userid);
		} else {
			if (vSysUser == null) {
				throw new Exception("用户id不能为空");
			}
		}
		dto.setUserid(vSysUser.getUserid());
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.course_name, a.course_category, a.course_id, a.course_status, a.aae011, a.aae036, c.score ");
		sb.append(" FROM ots_course_user b, ots_course a LEFT JOIN ots_course_appraise c ON a.course_id = c.course_id  ");
		sb.append(" and c.userid = '").append(vSysUser.getUserid()).append("' ");
		sb.append(" WHERE a.course_id = b.course_id ");
		sb.append(" and b.user_id = '").append(vSysUser.getUserid()).append("' ");
		sb.append(" and a.course_name like :courseName ");
		String sql = sb.toString();
		String[] paramName = new String[] { "courseName" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsCourseDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
	/**
	 * 
	 * addWareToCourse的中文名称：添加课件到课程
	 * 
	 * addWareToCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String addWareToCourse(HttpServletRequest request, OtsCourseDTO dto) {
		try {
			addWareToCourseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * addWareToCourseImp的中文名称：添加课件到课程方法实现
	 * 
	 * addWareToCourseImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void addWareToCourseImp(HttpServletRequest request, OtsCourseDTO dto)
			throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		// 保存课程课件对应关系
		JSONArray wareArr = JSONArray.fromObject(dto.getCourseWares());
		Object[] v_wareArray  = wareArr.toArray();
		if (v_wareArray.length > 0) {
			for (int i = 0; i < v_wareArray.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_wareArray[i]);
				// 判断课件是否加入课程
				boolean flag = checkWareIsInCourse(v_obj.getString("wareId"), dto.getCourseId());
				if (!flag) {
					// 课程课件对应表保存
					OtsCourseWarelist v_data = new OtsCourseWarelist();
					v_data.setCourseWareId(DbUtils.getSequenceStr()); // id
					v_data.setCourseId(dto.getCourseId()); // 关联课程ID
					v_data.setWareId(v_obj.getString("wareId")); // 关联课件ID
					v_data.setWareSequence(i + 1); // 顺序号
					v_data.setAae011(vSysUser.getUserid()); // 经办人
					v_data.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
					dao.insert(v_data);
				}
			}
		}
	}
	
	/**
	 * 
	 * checkWareIsInCourse的中文名称：检测课件是否在课程中
	 * 
	 * checkWareIsInCourse的概要说明：
	 *
	 * @param wareid
	 * @param courseId
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	public boolean checkWareIsInCourse(String wareid, String courseId)
			throws Exception {
		
		List<OtsCourseWarelist> list = dao.query(OtsCourseWarelist.class, Cnd.where("ware_id", "=", wareid)
				.and("course_id", "=", courseId));
		if (list != null && list.size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 
	 * delWareOutOfCourse的中文名称：将课件从课程中删除
	 * 
	 * delWareOutOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String delWareOutOfCourse(HttpServletRequest request, OtsCourseDTO dto) {
		try {
			delWareOutOfCourseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delWareOutOfCourseImp的中文名称：将课件从课程中删除实现方法
	 * 
	 * delWareOutOfCourseImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void delWareOutOfCourseImp(HttpServletRequest request, OtsCourseDTO dto)
			throws Exception {
		JSONArray wareArr = JSONArray.fromObject(dto.getCourseWares());
		Object[] v_wareArray  = wareArr.toArray();
		if (v_wareArray.length > 0) {
			for (int i = 0; i < v_wareArray.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_wareArray[i]);
				dao.clear(OtsCourseWarelist.class, Cnd.where("course_id", "=", dto.getCourseId())
						.and("ware_id", "=", v_obj.getString("wareId")));
			}
		}
	}
	
	/**
	 * 
	 * addTeacherToCourse的中文名称：添加讲师到课程
	 * 
	 * addTeacherToCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String addTeacherToCourse(HttpServletRequest request, OtsCourseDTO dto) {
		try {
			addTeacherToCourseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * addTeacherToCourseImp的中文名称：添加讲师到课程方法实现
	 * 
	 * addTeacherToCourseImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void addTeacherToCourseImp(HttpServletRequest request, OtsCourseDTO dto)
			throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		// 保存课程讲师对应关系
		JSONArray teacherArr = JSONArray.fromObject(dto.getCourseTeachers());
		Object[] v_teacherArray  = teacherArr.toArray();
		if (v_teacherArray.length > 0) {
			for (int i = 0; i < v_teacherArray.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_teacherArray[i]);
				// 判断讲师是否加入课程
				boolean flag = checkTeacherIsInCourse(v_obj.getString("teacherId"), dto.getCourseId());
				if (!flag) {
					// 课程教师中间表保存
					OtsCourseTeacher v_data = new OtsCourseTeacher();
					v_data.setCourseId(dto.getCourseId()); // 关联课程ID
					v_data.setTeacherId(v_obj.getString("teacherId")); // 关联讲师ID
					v_data.setAae011(vSysUser.getUserid()); // 经办人
					v_data.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
					dao.insert(v_data);
				}
			}
		}
	}
	
	/**
	 * 
	 * checkTeacherIsInCourse的中文名称：检测讲师是否加入过课程
	 * 
	 * checkTeacherIsInCourse的概要说明：
	 *
	 * @param teacherId
	 * @param courseId
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	public boolean checkTeacherIsInCourse(String teacherId, String courseId)
			throws Exception {
		
		List<OtsCourseTeacher> list = dao.query(OtsCourseTeacher.class, Cnd.where("teacher_id", "=", teacherId)
				.and("course_id", "=", courseId));
		if (list != null && list.size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 
	 * delTeacherOutOfCourse的中文名称：将讲师从课程中删除
	 * 
	 * delTeacherOutOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String delTeacherOutOfCourse(HttpServletRequest request, OtsCourseDTO dto) {
		try {
			delTeacherOutOfCourseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delTeacherOutOfCourseImp的中文名称：将讲师从课程中删除实现方法
	 * 
	 * delTeacherOutOfCourseImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void delTeacherOutOfCourseImp(HttpServletRequest request, OtsCourseDTO dto)
			throws Exception {
		JSONArray teacherArr = JSONArray.fromObject(dto.getCourseTeachers());
		Object[] v_teacherArr  = teacherArr.toArray();
		if (v_teacherArr.length > 0) {
			for (int i = 0; i < v_teacherArr.length; i++) {
				JSONObject v_obj = JSONObject.fromObject(v_teacherArr[i]);
				dao.clear(OtsCourseTeacher.class, Cnd.where("course_id", "=", dto.getCourseId())
						.and("teacher_id", "=", v_obj.getString("teacherId")));
			}
		}
	}
	
	/**
	 * 
	 * queryCourseUsers的中文名称：查询课程用户关系
	 * 
	 * queryCourseUsers的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCourseUsers(OtsCourseUserDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("  SELECT c.course_user_id, c.course_id, c.user_id,  ");
		sb.append("  sys.username, sys.userkind, sys.description, sys.mobile, org.orgname  ");
		sb.append("  from ots_course_user c, sysuser sys, sysorg org  ");
		sb.append("  where 1 = 1  ");
		sb.append("  and c.user_id = sys.USERID  ");
		sb.append("  and sys.ORGID = org.ORGID  ");
		sb.append("  and c.course_id = :courseId  ");
		String[] ParaName = new String[] { "courseId" };
		int[] ParaType = new int[] { Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OtsCourseUserDTO.class,pd
				.getPage(),pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * addUserToCourse的中文名称：添加课程人员
	 * 
	 * addUserToCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	
	public String addUserToCourse(HttpServletRequest request, OtsCourseUserDTO dto){
		try {
			addUserToCourseImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	
	/**
	 * 
	 * addUserToCourseImp的中文名称：添加课程人员实现
	 * 
	 * addUserToCourseImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	@Aop({ "trans" })
	public void addUserToCourseImp(HttpServletRequest request,OtsCourseUserDTO dto)
			throws Exception {
		String JsonStr = request.getParameter("JsonStr");
		List<SysuserDTO> userList = Json.fromJsonAsList(SysuserDTO.class, JsonStr);
		for (int i = 0; i < userList.size(); i++) {
			SysuserDTO user = (SysuserDTO) userList.get(i);
			// 判断用户是否加入课程
			boolean flag = checkUserIsInCourse(user.getUserid(), dto.getCourseId());
			if (!flag) {
				String v_id = DbUtils.getSequenceStr();
				OtsCourseUser cu = new OtsCourseUser();
				cu.setCourseUserId(v_id);//课程用户ID
				cu.setCourseId(dto.getCourseId());//课程ID
				cu.setUserId(user.getUserid()); // 用户id
				dao.insert(cu);
			}
		}
	}
	
	/**
	 * 
	 * checkUserIsInCourse的中文名称：判断用户是否与课程建立关系
	 * 
	 * checkUserIsInCourse的概要说明：
	 *
	 * @param userid
	 * @param examInfoId
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	public boolean checkUserIsInCourse(String userid, String courseId)
			throws Exception {
		List<OtsCourseUser> list = dao.query(OtsCourseUser.class, Cnd.where("user_id", "=", userid)
				.and("course_id", "=", courseId));
		if (list != null && list.size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 
	 * delUserOutOfCourse的中文名称：将用户从课程用户关系表中删除
	 * 
	 * delUserOutOfCourse的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	public String delUserOutOfCourse(HttpServletRequest request, OtsCourseUserDTO dto){
		try {
			delUserOutOfCourseImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delUserOutOfCourseImp的中文名称：将用户从课程用户关系表中删除实现方法
	 * 
	 * delUserOutOfCourseImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : wcl
	 */
	@Aop({ "trans" })
	public void delUserOutOfCourseImp(HttpServletRequest request,OtsCourseUserDTO dto)
			throws Exception {
		String JsonStr = request.getParameter("JsonStr");
		List<OtsCourseUserDTO> list = Json.fromJsonAsList(OtsCourseUserDTO.class, JsonStr);
		for (int i = 0; i < list.size(); i++) {
			OtsCourseUserDTO v_dto = (OtsCourseUserDTO)list.get(i);
			dao.clear(OtsCourseUser.class,Cnd.where("course_user_id", "=", v_dto.getCourseUserId()));
		}
	}

	/**
	 * 
	 * saveAppraise的中文名称：保存课程评分
	 * 
	 * saveAppraise的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String saveAppraise(HttpServletRequest request, OtsCourseAppraiseDTO dto) {
		try {
			saveAppraiseImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveAppraiseImp的中文名称：保存课程评分实现
	 * 
	 * saveAppraiseImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop( { "trans" })
	public void saveAppraiseImp(HttpServletRequest request, OtsCourseAppraiseDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		List<OtsCourseAppraise> oca = dao.query(OtsCourseAppraise.class, Cnd.where("course_id", "=", dto.getCourseId())
				.and("userid", "=", vSysUser.getUserid()));
		// 如果已经评过分，则更新
		if (oca != null && oca.size() > 0) {
			OtsCourseAppraise v_Appraise = oca.get(0);
			v_Appraise.setCourseId(dto.getCourseId());
			v_Appraise.setUserid(vSysUser.getUserid());
			v_Appraise.setAae011(vSysUser.getUserid());
			v_Appraise.setAae036(Timestamp.valueOf(v_dbDatetime));
			v_Appraise.setScore(dto.getScore());
			dao.update(v_Appraise);
		}else{
			OtsCourseAppraise v_Appraise=new OtsCourseAppraise();
			v_Appraise.setCourseId(dto.getCourseId());
			v_Appraise.setUserid(vSysUser.getUserid());
			v_Appraise.setAae011(vSysUser.getUserid());
			v_Appraise.setAae036(Timestamp.valueOf(v_dbDatetime));
			v_Appraise.setScore(dto.getScore());
			dao.insert(v_Appraise);
		}
	}
	
	/**
	 * 
	 * queryHomeworkObj的中文名称：查询作业信息
	 * 
	 * queryHomeworkObj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryHomeworkObj(HttpServletRequest request, OtsHomeworkDTO dto) throws Exception {
		// 作业信息
		OtsHomework info = dao.fetch(OtsHomework.class, dto.getHomeworkId());
		Map map = new HashMap();
		map.put("homework", info); // 作业信息
		return map;
	}
	
	/**
	 * 
	 * saveHomework的中文名称：保存作业
	 * 
	 * saveHomework的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String saveHomework(HttpServletRequest request, OtsHomeworkDTO dto) {
		try {
			saveHomeworkImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveHomeworkImp的中文名称：保存作业方法实现
	 * 
	 * saveHomeworkImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void saveHomeworkImp(HttpServletRequest request, OtsHomeworkDTO dto) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		// 如果已存在，更新
		if (dto.getHomeworkId() != null && !"".equals(dto.getHomeworkId())) {
			OtsHomework v_hw = dao.fetch(OtsHomework.class, dto.getHomeworkId());
			v_hw.setTitle(dto.getTitle()); // 作业名称
			v_hw.setType(dto.getType()); // 作业类型
			v_hw.setContent(dto.getContent()); // 作业内容
			// TODO 附件id
			v_hw.setScore(dto.getScore()); // 满分
			v_hw.setPass(dto.getPass()); // 及格
			v_hw.setAae011(vSysUser.getUserid()); // 经办人
			v_hw.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
			dao.update(v_hw);
		}else{
			OtsHomework v_hw = new OtsHomework();
			v_hw.setHomeworkId(DbUtils.getSequenceStr()); // id
			v_hw.setTitle(dto.getTitle()); // 作业名称
			v_hw.setType(dto.getType()); // 作业类型
			v_hw.setContent(dto.getContent()); // 作业内容
			// TODO 附件id
			v_hw.setScore(dto.getScore()); // 满分
			v_hw.setPass(dto.getPass()); // 及格
			v_hw.setAae011(vSysUser.getUserid()); // 经办人
			v_hw.setAae036(Timestamp.valueOf(v_dbDatetime)); // 经办时间
			dao.insert(v_hw);
		}
	}
	
	/**
	 * 
	 * delHomework的中文名称：删除作业
	 * 
	 * delHomework的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String delHomework(HttpServletRequest request, OtsHomeworkDTO dto) {
		try {
			delHomeworkImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delHomeworkImp的中文名称：删除作业
	 * 
	 * delHomeworkImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void delHomeworkImp(HttpServletRequest request, OtsHomeworkDTO dto)
			throws Exception {
		// 删除作业
		dao.clear(OtsHomework.class, Cnd.where("homeworkId", "=", dto.getHomeworkId()));
	}
}
