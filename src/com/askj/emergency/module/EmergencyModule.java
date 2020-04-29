package com.askj.emergency.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.emergency.dto.EmeventcheckinDTO;
import com.askj.emergency.dto.EmgroupinfoDTO;
import com.askj.emergency.dto.EmteampersonDTO;
import com.zzhdsoft.siweb.entity.news.News;
import com.askj.emergency.service.EmergencyService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 * EmergencyModule的中文名称：应急指挥管理
 * 
 * EmergencyModule的描述：
 * 
 * Written by : zy
 */
@IocBean
@At("/emergency")
public class EmergencyModule {
	protected final Logger logger = Logger.getLogger(EmergencyModule.class);

	@Inject
	protected EmergencyService emergencyService;

	/**
	 * 
	 * emergencyInfoIndex的中文名称：应急预案信息页面
	 * 
	 * emergencyInfoIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/emergencyInfo")
	public void emergencyInfoIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * addEmergency的中文名称：添加预案信息页面
	 * 
	 * addEmergency的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/addemergency")
	public void addEmergency(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * editNews的中文名称：编辑预案信息页面
	 * 
	 * editNews的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/editemergency")
	public void editEmergency(HttpServletRequest request, @Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		Map<?, ?> map = emergencyService.queryEmergencysList(dto, pd);
		List<?> newsList = (List<?>) map.get("rows");
		News news = null;
		if (newsList != null && newsList.size() > 0) {
			news = (News) newsList.get(0);
		}
		request.setAttribute("news", news);
	}

	/**
	 * 
	 * delEmergencyGroup的中文名称：删除应急小组（解散）
	 * 
	 * delEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object delEmergency(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(emergencyService.delEmergency(request, dto));
	}

	/**
	 * 
	 * queryNews的中文名称：查询预案信息
	 * 
	 * queryNews的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEmergencysList(@Param("..") News dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map=emergencyService.queryEmergencysList(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * emergencyEventMainIndex的中文名称：突发事件登记页面
	 * 
	 * emergencyEventMainIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/emergencydj")
	public void emergencyEventMainIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * emergencyFormIndex的中文名称：突发事件信息详情页面
	 * 
	 * emergencyFormIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/emergencyForm")
	public void emergencyFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEmergency的中文名称：查询突发事件登记信息
	 * 
	 * queryEmergency的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEmergency(@Param("..") EmeventcheckinDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			// 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
			String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
			dto.setAaa027(aaa027);
			map = emergencyService.queryEmergency(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * queryEmergencyDTO的中文名称：查询突发事件登记信息DTO
	 * 
	 * queryEmergencyDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEmergencyDTO(@Param("..") EmeventcheckinDTO dto, @Param("..") PagesDTO pd) throws Exception {

		Map map = new HashMap();
		try {
			map = emergencyService.queryEmergency(dto, pd);
			List ls = (List) map.get("rows");
			EmeventcheckinDTO csDTO = null;
			if (ls != null && ls.size() > 0) {
				csDTO = (EmeventcheckinDTO) ls.get(0);
			}
			map.put("data", csDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * saveEmergency的中文名称：保存突发事件登记
	 * 
	 * saveEmergency的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object saveEmergency(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto) {
		return SysmanageUtil.execAjaxResult(emergencyService.saveEmergency(request, dto));
	}

	/**
	 * 
	 * selectyaxxIndex的中文名称：应急预案信息页面
	 * 
	 * selectyaxxIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/selectyaxx")
	public void selectyaxxIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * emergencyGroupIndex的中文名称：应急队伍信息页面
	 * 
	 * emergencyGroupIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/emergencyGroup")
	public void emergencyGroupIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEmergencyGroupList的中文名称：查询应急队伍信息
	 * 
	 * queryEmergencyGroupList的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEmergencyGroupList(HttpServletRequest request, @Param("..") EmgroupinfoDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = emergencyService.queryEmergencyGroupList(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * emergencyGroupInfoIndex的中文名称：应急小组详情界面
	 * 
	 * emergencyGroupInfoIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/emergencyGroupInfo")
	public void emergencyGroupInfoIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * editEmergencyGroup的中文名称：编辑应急小组
	 * 
	 * editEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object saveEmergencyGroup(HttpServletRequest request, @Param("..") EmgroupinfoDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(emergencyService.saveEmergencyGroup(request, dto));
	}

	/**
	 * 
	 * delEmergencyGroup的中文名称：删除应急小组（解散）
	 * 
	 * delEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object delEmergencyGroup(HttpServletRequest request, @Param("..") EmgroupinfoDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(emergencyService.delEmergencyGroup(request, dto));
	}

	/**
	 * 
	 * rollbackEmergencyGroup的中文名称：将解散的应急小组恢复
	 * 
	 * rollbackEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object rollbackEmergencyGroup(HttpServletRequest request, @Param("..") EmgroupinfoDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(emergencyService.rollbackEmergencyGroup(request, dto));
	}

	/**
	 * 
	 * queryEmergencyGroupDto的中文名称：查询应急小组信息
	 * 
	 * queryEmergencyGroupDto的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEmergencyGroupDto(@Param("..") EmgroupinfoDTO dto) throws Exception {

		Map<String, EmgroupinfoDTO> result = new HashMap<String, EmgroupinfoDTO>();
		try {
			EmgroupinfoDTO v_emgroupinfoDTO = (EmgroupinfoDTO) emergencyService.queryEmergencyGroupDto(dto);
			if (v_emgroupinfoDTO != null && !"".equals(v_emgroupinfoDTO.getGroupid())) {
				result.put("data", v_emgroupinfoDTO);
			}
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(result, e);// 异常返回
		}
		return SysmanageUtil.execAjaxResult(result, null);// 无异常信息返回;
	}

	/**
	 * 
	 * emergencyGroupPersonIndex的中文名称：应急小组成员管理页面
	 * 
	 * emergencyGroupPersonIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/emergencyGroupPerson")
	public void emergencyGroupPersonIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEmergencyGroupPerson的中文名称：查询应急队伍成员信息
	 * 
	 * queryEmergencyGroupPerson的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEmergencyGroupPerson(HttpServletRequest request, @Param("..") EmteampersonDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map=new HashMap();
		try {
			map = emergencyService.queryEmergencyGroupPerson(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * addUserToEmergencyGroup的中文名称：添加用户到应急小组
	 * 
	 * addUserToEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object addUserToEmergencyGroup(HttpServletRequest request, @Param("..") EmteampersonDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(emergencyService.addUserToEmergencyGroup(request, dto));
	}

	/**
	 * 
	 * delUserOutOfEmergencyGroup的中文名称：将用户从应急小组中移除
	 * 
	 * delUserOutOfEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object delUserOutOfEmergencyGroup(HttpServletRequest request, @Param("..") EmteampersonDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(emergencyService.delUserOutOfEmergencyGroup(request, dto));
	}

	/**
	 * 
	 * emergencyGroupPersonFromIndex的中文名称：应急小组成员详情页面
	 * 
	 * emergencyGroupPersonFromIndex的概要说明：
	 * 
	 * @param request
	 *            Written by : zy
	 * 
	 */
	@At
	@Ok("jsp:/jsp/emergency/emergencyGroupPersonForm")
	public void emergencyGroupPersonFromIndex(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 * 
	 * queryEmergencyGroupPersonDTO的中文名称：查询应急队伍成员详细信息
	 * 
	 * queryEmergencyGroupPersonDTO的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object queryEmergencyGroupPersonDTO(HttpServletRequest request, @Param("..") EmteampersonDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = emergencyService.queryEmergencyGroupPerson(dto, pd);
			List<?> ls = (List<?>) map.get("rows");
			EmteampersonDTO zmteampersonDTO = null;
			if (ls != null && ls.size() > 0) {
				zmteampersonDTO = (EmteampersonDTO) ls.get(0);
			}
			map.put("data", zmteampersonDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 * 
	 * saveEmergencyGroupPerson的中文名称：保存应急小组成员信息
	 * 
	 * saveEmergencyGroupPerson的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@At
	@Ok("json")
	public Object saveEmergencyGroupPerson(HttpServletRequest request, @Param("..") EmteampersonDTO dto) throws Exception {
		return SysmanageUtil.execAjaxResult(emergencyService.saveEmergencyGroupPerson(request, dto));
	}

}
