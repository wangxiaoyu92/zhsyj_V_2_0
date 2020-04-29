package com.askj.train.service;

import java.io.File;
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
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import com.askj.train.dto.OtsCoursewareDTO;
import com.askj.train.entity.OtsCourseware;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.covert.VideoUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 *  CoursewareService的中文名称：培训子系统-课件管理
 *
 *  CoursewareService的描述：
 *
 *  @author : wcl
 */
@IocBean
public class CoursewareService extends BaseService{
	protected final Logger logger = Logger.getLogger(CoursewareService.class);
	
	@Inject
	private Dao dao;
	/**
	 * 
	 * queryCoursewareInfos的中文名称：查询课件列表
	 * 
	 * queryCoursewareInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCoursewareInfos(HttpServletRequest request, OtsCoursewareDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT cour.ware_id, cour.ware_name, cour.ware_status, cour.ware_type, cour.ware_category, ");
		sb.append(" cour.ware_credit, cour.ware_source, cour.ware_video, cour.ware_des, ");
		sb.append(" cour.ware_length, cour.ware_des_h, cour.ware_point, cour.aae011, cour.aae036 ");
		sb.append(" FROM ots_courseware cour where 1=1 ");
		sb.append(" AND cour.ware_source = :wareSource");
		sb.append(" AND cour.ware_category = :wareCategory");
		sb.append(" AND cour.ware_name like :wareName");
		sb.append(" AND cour.ware_status = :wareStatus"); // 课件状态
		sb.append(" order by ware_id desc");
		String sql = sb.toString();
		String[] paramName = new String[] { "wareSource", "wareCategory", "wareName", "wareStatus" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
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
	 * saveCoursewareInfos的中文名称：保存课件信息
	 * 
	 * saveCoursewareInfos的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : wcl
	 */
	public String saveCoursewareInfos(HttpServletRequest request, OtsCoursewareDTO dto) {
		try {
			saveCoursewareInfosImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveCoursewareInfosImp的中文名称：保存课件方法实现
	 * 
	 * saveCoursewareInfosImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author : wcl
	 */
	@Aop( { "trans" })
	public void saveCoursewareInfosImp(HttpServletRequest request, 
			OtsCoursewareDTO dto) throws Exception {
	    Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
		String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
		// 课件id
		String v_wareid = (dto.getWareId() != null && !"".equals(dto.getWareId())) ?
				dto.getWareId() : DbUtils.getSequenceStr();
		// 如果id不为空，更新
		if(dto.getWareId() != null && !"".equals(dto.getWareId())){
			OtsCourseware v_ware = dao.fetch(OtsCourseware.class, v_wareid);
			v_ware.setWareName(dto.getWareName()); // 课件名称
			v_ware.setWareStatus(dto.getWareStatus()); // 课件状态
			v_ware.setWareCredit(dto.getWareCredit()); // 所需积分
			v_ware.setWareCategory(dto.getWareCategory()); // 课件分类
			v_ware.setWareType(dto.getWareType()); // 课件来源
			v_ware.setWareSource(dto.getWareSource());
			if ("1".equals(dto.getWareType())) {
				v_ware.setWareVideo(changeWareName(request, dto.getWareVideo())); // 课件路径
			} else {
				v_ware.setWareVideo(dto.getWareVideo()); // 课件路径
			}
			v_ware.setWareDes(dto.getWareDes()); // 课件讲义
			v_ware.setWareLength(dto.getWareLength()); // 媒体时长
			v_ware.setWarePoint(dto.getWarePoint()); // 课件学分
			v_ware.setAae011(vSysUser.getUserid());
			v_ware.setAae036(Timestamp.valueOf(v_dbDatetime));		
			dao.update(v_ware); // 更新 
		} else{
			OtsCourseware v_ware = new OtsCourseware();
			v_ware.setWareId(v_wareid); // id
			v_ware.setWareName(dto.getWareName()); // 课件名称
			v_ware.setWareStatus(dto.getWareStatus()); // 课件状态
			v_ware.setWareCredit(dto.getWareCredit()); // 所需积分
			v_ware.setWareCategory(dto.getWareCategory()); // 课件分类
			v_ware.setWareType(dto.getWareType()); // 课件类型
			v_ware.setWareSource(dto.getWareSource()); // 课件来源
			if ("1".equals(dto.getWareType())) {
				v_ware.setWareVideo(changeWareName(request, dto.getWareVideo())); // 课件路径
			} else {
				v_ware.setWareVideo(dto.getWareVideo()); // 课件路径
			}
			v_ware.setWareDes(dto.getWareDes()); // 课件讲义
			v_ware.setWareLength(dto.getWareLength()); // 媒体时长
			v_ware.setWarePoint(dto.getWarePoint()); // 课件学分
			v_ware.setAae011(vSysUser.getUserid());
			v_ware.setAae036(Timestamp.valueOf(v_dbDatetime));	
			dao.insert(v_ware);
		}
	}
	
	/**
	 * 
	 * changeWareName的中文名称：更改课件名称
	 * 
	 * changeWareName的概要说明：视频格式课件转换为flv格式
	 *
	 * @param request
	 * @param oldName
	 * @return
	 * @author : zy
	 */
	public String changeWareName(HttpServletRequest request, String oldName) {
	
		if (oldName == null || "".equals(oldName)) {
			return oldName;
		}
		String newName = oldName.substring(0, oldName.lastIndexOf(".")) + ".flv";
		String basePath = request.getSession().getServletContext().getRealPath("/"); // 工程路径
		// 判断转换格式后的文件是否存在
		File file = new File(basePath + newName);
		if (file.exists()) {
			return newName;
		}
		return oldName;
	}
	
	/**
	 * 
	 * delCoursewareInfos的中文名称：删除课件
	 * 
	 * delCoursewareInfos的概要说明：
	 *
	 * @param request
	 * @return
	 * @author : wcl
	 */
	public String delCoursewareInfos(HttpServletRequest request) {
		try {
			delCoursewareInfosImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
		
	}

	/**
	 * 
	 * delCoursewareInfosImp的中文名称：删除课件信息方法实现
	 * 
	 * delCoursewareInfosImp的概要说明：
	 *
	 * @param request
	 * @throws Exception
	 * @author : wcl
	 */
	@Aop({ "trans" })
	public void delCoursewareInfosImp(HttpServletRequest request) throws Exception {
		String JsonStr = request.getParameter("JsonStr");
		List<OtsCoursewareDTO> infoList = Json.fromJsonAsList(OtsCoursewareDTO.class, JsonStr);
		for (int i = 0; i < infoList.size(); i++) {
			OtsCoursewareDTO info = (OtsCoursewareDTO)infoList.get(i);
			dao.clear(OtsCourseware.class, Cnd.where("ware_id", "=", info.getWareId()));
		}
	}

	/**
	 * 
	 * queryCoursewareObj的中文名称：查询课件信息
	 * 
	 * queryCoursewareObj的概要说明：查询课件信息
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * @author : wcl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryCoursewareObj(HttpServletRequest request, OtsCoursewareDTO dto){
		OtsCourseware courseware = dao.fetch(OtsCourseware.class, dto.getWareId());
		OtsCoursewareDTO v_dto = new OtsCoursewareDTO();
		BeanHelper.copyProperties(courseware, v_dto);
		if (v_dto.getWareVideo() != null && !"".equals(v_dto.getWareVideo())) {
			String fileName = v_dto.getWareVideo().substring(v_dto.getWareVideo().lastIndexOf("/") + 1);
			v_dto.setFileName(fileName);
		}
		Map map = new HashMap();
		map.put("courseware", v_dto); // 课件信息
		return map;
	}
	
	/**
	 * 
	 * converFile的中文名称：转换文件格式
	 * 
	 * converFile的概要说明：视频格式的课件转换为flv格式的
	 *
	 * @param request
	 * @return
	 * @author : zy
	 */
	public String converFile(HttpServletRequest request) {
		try {
			converFileImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * converFileImp的中文名称：转换文件格式方法实现
	 * 
	 * converFileImp的概要说明：
	 *
	 * @param request
	 * @throws Exception
	 * @author : zy
	 */
	@Aop({ "trans" })
	public void converFileImp(HttpServletRequest request) throws Exception {
		
		String wareType = request.getParameter("wareType"); // 课件类型
		String warePath = request.getParameter("warePath"); // 课件名称
		String basePath = request.getSession().getServletContext().getRealPath("/"); // 工程路径
		VideoUtil.OUTPUT_PATH = basePath + "upload\\train\\";
		if (wareType.equals("1")) { // 视频
			VideoUtil.convert(basePath + "upload\\train\\" + warePath.substring(warePath.lastIndexOf("/")+1));
		}
		/*// 转换成功后删除原文件
		File file = new File(VideoUtil.OUTPUT_PATH+warePath.substring(warePath.lastIndexOf("/")+1));
		if (file.exists()) {
			file.delete();
		}*/
	}
	/**
	 * 
	 * checkWareIsExit的中文名称：检查课件是否存在
	 * 
	 * checkWareIsExit的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map checkWareIsExit(HttpServletRequest request, OtsCoursewareDTO dto){
		Map map = new HashMap();
		String basePath = request.getSession().getServletContext().getRealPath("/"); // 工程路径
		if (dto.getWareVideo() == null || "".equals(dto.getWareVideo())) {
			map.put("isExit", "-1"); // 课件不存在
		} else {
			String filePath = dto.getWareVideo(); // 课件路径
			File file = new File(basePath + filePath);
			if (file.exists()) {
				map.put("isExit", "1"); // 课件存在
			} else {
				map.put("isExit", "-1"); // 课件不存在
			}
		}
		return map;
	}
}
