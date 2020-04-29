package com.askj.oa.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.oa.dto.CirculationpaperDTO;
import com.askj.oa.dto.EgarchiveinfoDTO;
import com.askj.oa.service.ArchiveService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 
 *ArchiveModule中文名称：公文管理
 *ArchiveModule概要描述：
 * 2016-6-21
 * written by : lfy
 */
@At("/egovernment/archive")
@IocBean
public class ArchiveModule {
	protected final Logger logger = Logger.getLogger(ArchiveModule.class);
	
	@Inject
	private ArchiveService archiveService;
	/**
	 * 
	 * rearchiveForm中文名称:收文管理
	 * rearchiveForm概要描述:
	 * written by  :  wcl
	 */
	@At
	@Ok("jsp:/jsp/oa/rearchiveForm")
	public void rearchiveForm(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * gdarchiveFome中文名称:归档管理跳转页面
	 * gdarchiveFome概要描述:
	 * written by  :  wcl
	 */
	@At
	@Ok("jsp:/jsp/oa/gdarchiveFome")
	public void gdarchiveFome(HttpServletRequest request) {
		// 页面初始化
	}

	/**
	 *
	 * CirculationForm中文名称:传阅信息跳转页面
	 * CirculationForm概要描述:
	 * written by  :  wcl
	 */
	@At
	@Ok("jsp:/jsp/oa/CirculationForm")
	public void CirculationForm(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 *
	 * archiveMainIndex中文名称:初始化页面
	 * archiveMainIndex概要描述:
	 * written by  :  lfy
	 */
	@At
	@Ok("jsp:/jsp/oa/archiveMain")
	public void archiveMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	@At
	@Ok("jsp:/jsp/oa/archiveayMain")
	public void archiveayMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * queryArchive中文名称:查询文档管理
	 * queryArchive概要描述:
	 * written by  :  lfy
	 */
	@At
	@Ok("json")
	public Object queryArchive(@Param("..") EgarchiveinfoDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = archiveService.queryArchive(dto, pd);
			List ls = (List) map.get("rows");
			EgarchiveinfoDTO EgarchiveinfoDTO = null;
			if (ls != null && ls.size() > 0) {
				EgarchiveinfoDTO = (EgarchiveinfoDTO) ls.get(0);
			}
			map.put("data", EgarchiveinfoDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		/*return archiveService.queryArchive(dto, pd);*/
	}
	/**
	 * 
	 * delArchive中文名称:删除公文
	 * delArchive概要描述:删除公文
	 * written by  :  lfy
	 */
	@At
	@Ok("json")
	public Object delArchive(HttpServletRequest request,@Param("..") EgarchiveinfoDTO dto) {
		return SysmanageUtil.execAjaxResult(archiveService.delArchive(request,dto));
	}
	/**
	 * 
	 * archiveFormIndex中文名称:添加界面
	 * archiveFormIndex概要描述:添加界面
	 * written by  :  lfy
	 */
	@At
	@Ok("jsp:/jsp/oa/archiveForm")
	public void archiveFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	@At
	@Ok("jsp:/jsp/oa/archiveayForm")
	public void archiveayFormIndex(HttpServletRequest request) {
		// 页面初始化
	}

	@At
	@Ok("jsp:/jsp/oa/archiveswForm")
	public void archiveswFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	@At
	@Ok("jsp:/jsp/oa/archiveaysbForm")
	public void archiveaysbFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	@At
	@Ok("jsp:/jsp/oa/archiveswEditForm")
	public void archiveswEditFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	@At
	@Ok("jsp:/jsp/oa/archiveayswForm")
	public void archiveayswFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	@At
	@Ok("jsp:/jsp/oa/archiveayswEditForm")
	public void archiveayswEditFormIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * addArchive中文名称:添加公文信息
	 * addArchive概要描述:
	 * written by  :  lfy
	 */
	@At
	@Ok("json")
	public Object addArchive(HttpServletRequest request,@Param("..") EgarchiveinfoDTO dto) {
		return SysmanageUtil.execAjaxResult(archiveService.addArchive(request,dto));
	}
	@At
	@Ok("json")
	public Object addArchivenew(HttpServletRequest request,@Param("..") EgarchiveinfoDTO dto) {
		return SysmanageUtil.execAjaxResult(archiveService.addArchivenew(request,dto));
	}
	/**
	 * 
	 * queryArchiveDTO中文名称:
	 * queryArchiveDTO概要描述:
	 * written by  :  lfy
	 */
	@At
	@Ok("json")
	public Object queryArchiveDTO(HttpServletRequest request,
			@Param("..") EgarchiveinfoDTO dto, @Param("..") PagesDTO pd) throws Exception {
		Map map = new HashMap();
		try {
			map = archiveService.queryArchiveDTO(dto, pd);
			List ls = (List) map.get("rows");
			EgarchiveinfoDTO EgarchiveinfoDTO = null;
			if (ls != null && ls.size() > 0) {
				EgarchiveinfoDTO = (EgarchiveinfoDTO) ls.get(0);
			}
			Sysuser vSysUser = SysmanageUtil.getSysuser();
			map.put("data", EgarchiveinfoDTO);
			map.put("orgid", vSysUser.getOrgid());
			map.put("orgname",vSysUser.getOrgname());
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	/**
	 *
	 * querySwbianhao中文含义:查询收文总编号
	 * querySwbianhao描述:
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by  ：  zk
	 */
	@At
	@Ok("json")
	public Object querySwbianhao(HttpServletRequest request,
								  @Param("..") EgarchiveinfoDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			map = archiveService.querySwbianhao(dto);
			List ls = (List) map.get("rows");
			EgarchiveinfoDTO egarchiveinfoDTO = null;
			String swzbh="";
			if (ls != null && ls.size() > 0) {
				egarchiveinfoDTO = (EgarchiveinfoDTO) ls.get(0);
				swzbh=egarchiveinfoDTO.getSwzbh();
			}
			map.put("data", swzbh);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}

	@At
	@Ok("json")
	public Object queryCount(HttpServletRequest request,
								 @Param("..") EgarchiveinfoDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			map = archiveService.queryCount(dto);
			List ls = (List) map.get("rows");
			map.put("data", ls.size()+1);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 * rearchiveMainIndex中文含义:收文
	 * rearchiveMainIndex描述:
	 * @param request
	 * written  by  ：  lfy
	 */
	@At
	@Ok("jsp:/jsp/oa/rearchiveMain")
	public void rearchiveMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * queryRearchive中文含义:查询收文
	 * queryRearchive描述:
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	@At
	@Ok("json")
	public Object queryRearchive(@Param("..") EgarchiveinfoDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map=new HashMap();
		try {
			map = archiveService.queryRearchive(dto, pd);
			return SysmanageUtil.execAjaxResult(map, null);
		}catch (Exception e){
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	/**
	 * 
	 * gdarchiveMainIndex中文含义:归档
	 * gdarchiveMainIndex描述:
	 * @param request
	 * written  by  ：  lfy
	 */
	@At
	@Ok("jsp:/jsp/oa/gdarchiveMain")
	public void gdarchiveMainIndex(HttpServletRequest request) {
		// 页面初始化
	}
	/**
	 * 
	 * queryGdarchive中文含义:查询归档
	 * queryGdarchive描述:
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	@At
	@Ok("json")
	public Object queryGdarchive(@Param("..") EgarchiveinfoDTO dto, @Param("..") PagesDTO pd)
			throws Exception {
		Map map = new HashMap();
		try {
			map = archiveService.queryGdarchive(dto, pd);
			List ls = (List) map.get("rows");
			EgarchiveinfoDTO EgarchiveinfoDTO = null;
			if (ls != null && ls.size() > 0) {
				EgarchiveinfoDTO = (EgarchiveinfoDTO) ls.get(0);
			}
			map.put("data", EgarchiveinfoDTO);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
		/*return SysmanageUtil.execAjaxResult(archiveService.queryGdarchive(dto, pd),null);*/
	}
	/**
	 * 
	 * updateArchive中文含义:根据id更新公文状态
	 * updateArchive描述:
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	@At
	@Ok("json")
	public Object updateArchive(HttpServletRequest request,@Param("..") EgarchiveinfoDTO dto)
			throws Exception {
		return SysmanageUtil.execAjaxResult(archiveService.updateArchive(request, dto));
	}
	/**
	 * 
	 * a2Rearchive中文含义:把发文数据添加或更新到收文数据
	 * a2Rearchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	@At
	@Ok("json")
	public Object a2Rearchive(HttpServletRequest request,@Param("..") EgarchiveinfoDTO dto,@Param("..") CirculationpaperDTO circulationpaperDTO)
			throws Exception {
		return SysmanageUtil.execAjaxResult(archiveService.a2Rearchive(request, dto,circulationpaperDTO));
	}
	/**
	 * delRearchive
	 * gdArchive中文含义:把发文数据添加或更新到归档数据里面
	 * gdArchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	@At
	@Ok("json")
	public Object gdArchive(HttpServletRequest request,@Param("..") EgarchiveinfoDTO dto)
			throws Exception {
		return SysmanageUtil.execAjaxResult(archiveService.gdAearchive(request, dto));
	}
	/**
	 * 
	 * delRearchive中文含义:把收文状态改为无效
	 * delRearchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	@At
	@Ok("json")
	public Object delRearchive(HttpServletRequest request,@Param("..") EgarchiveinfoDTO dto)
			throws Exception {
		return SysmanageUtil.execAjaxResult(archiveService.delRearchive(request, dto));
	}
	/**
	 * 
	 * delgdArchive中文含义:把归档的状态改为无效
	 * delgdArchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	@At
	@Ok("json")
	public Object delgdArchive(HttpServletRequest request,@Param("..") EgarchiveinfoDTO dto)
			throws Exception {
		return SysmanageUtil.execAjaxResult(archiveService.delgdArchive(request, dto));
	}
	/**
	 * 
	 * paperArchive中文含义:传阅
	 * paperArchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	@At
	@Ok("json")
	public Object paperArchive(HttpServletRequest request,@Param("..") CirculationpaperDTO dto)
			throws Exception {
		return SysmanageUtil.execAjaxResult(archiveService.paperArchive(request, dto));
	}
	
}
