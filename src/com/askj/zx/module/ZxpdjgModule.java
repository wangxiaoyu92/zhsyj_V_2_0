package com.askj.zx.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.askj.oa.dto.EgWorkTaskDTO;
import com.askj.zx.dto.ZxpddjcsDTO;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Fail;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxpdjgDTO;
import com.askj.zx.entity.Zxpdcjxx;
import com.askj.zx.service.ZxpdjgService;
import com.zzhdsoft.utils.SysmanageUtil;

/**
 * 征信评定结果控制层
 * @author CatchU
 *
 */
@IocBean
@At("/zx/zxpdjg")
@Fail("jsp:/jsp/error/error")
public class ZxpdjgModule extends BaseModule {

	protected final Logger logger = Logger.getLogger(ZxpdjgModule.class);
	
	@Inject
	private ZxpdjgService zxpdjgService; 
	
	/**
	 * 跳转到征信评定结果信息页
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpdjg/zxpdjg")
	public void zxpdjgIndex(HttpServletRequest request){
		//诚信评定结果初始化
	}

	/**
	 * 跳转到征信评定结果信息页
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpdjg/zxpdjgs")
	public void zxpdjgsIndex(HttpServletRequest request){
		//诚信评定结果初始化
	}

	/**
	 * 跳转到行政救济页面
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpdjg/reasonBlacklist")
	public void reasonBlacklistIndex(HttpServletRequest request){
		//诚信评定结果初始化
	}

	/**
	 * 跳转到行政救济修改页面
	 */
	@At
	@Ok("jsp:/jsp/zx/zxpdjg/reasonBlacklistForm")
	public void reasonBlacklistForm(HttpServletRequest request){
		//诚信评定结果初始化
	}
	
	//跳转到企业诚信评定信息详情页
	@At
	@Ok("jsp:/jsp/zx/zxpdjg/zxpdjgForm")
	public void zxpdjgFormIndex(HttpServletRequest request){
		//诚信评定结果页详情
	}

	//跳转到企业诚信评定信息详情页
	@At
	@Ok("jsp:/jsp/zx/zxpdjg/zxpdjgsForm")
	public void zxpdjgsFormIndex(HttpServletRequest request){
		//诚信评定结果页详情
	}
	
	/**
	 * 查询企业诚信评估信息
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object queryZxpdjg(@Param("..") ZxpdjgDTO dto,@Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			map = zxpdjgService.queryZxpdjg(dto,pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}


	/**
	 * 查询企业诚信评估信息
	 * @throws Exception
	 */
	@At
	@Ok("json")
	public Object queryZxpdjgs(@Param("..") ZxpdjgDTO dto,@Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			map = zxpdjgService.queryZxpdjgs(dto,pd);
			return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e); // 异常返回
		}
	}


	/**
	 * 查询诚信评定信息
	 */
	@At
	@Ok("json")
	public Object queryZxpdjgDTO(HttpServletRequest request,
			@Param("..") ZxpdjgDTO dto,
			@Param("..") PagesDTO pd) throws Exception{
		Map map = new HashMap();
		try {
			map = zxpdjgService.queryZxpdjg(dto, pd);
			List list = (List) map.get("rows");
			ZxpdjgDTO pdjgDto = null;
			if(list!=null && list.size()>0){
				pdjgDto = (ZxpdjgDTO)list.get(0);
			}
			map.put("data", pdjgDto);
			return SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
	}
	/**
	 * 添加企业诚信评定信息
	 */
	@At
	@Ok("json")
	public Object saveZxpdjg(HttpServletRequest request,@Param("..") ZxpdjgDTO dto){
		return SysmanageUtil.execAjaxResult(zxpdjgService.saveZxpdjg(request,dto));
	}

	/**
	 * 添加企业诚信评定信息
	 */
	@At
	@Ok("json")
	public Object saveZxpdjgs(HttpServletRequest request,@Param("..") ZxpdjgDTO dto){
		return SysmanageUtil.execAjaxResult(zxpdjgService.saveZxpdjgs(request,dto));
	}
	/**
	 * 删除诚信评定
	 * 
	 */
	@At
	@Ok("json")
	public Object delZxpdjg(HttpServletRequest request,@Param("..") ZxpdjgDTO dto){
		return SysmanageUtil.execAjaxResult(zxpdjgService.delZxpdjg(request, dto));
	}
	
	/**
	 * 使用ajax异步计算企业年度得分方法
	 */
	@At
	@Ok("json")
	public Object sumScore(HttpServletRequest request,@Param("..")ZxpdjgDTO dto) throws Exception{
		Map map = new HashMap();
		try {
			map = zxpdjgService.sumScore(request, dto);
			List list = (List) map.get("rows");
			Integer sum = 0;
			if(list!=null && list.size()>0){
				for(int i = 0;i<list.size();i++){
					Zxpdcjxx cjxx = (Zxpdcjxx) list.get(i);
					System.out.println(cjxx.getCjdf());
					Integer math=cjxx.getCjdf();
					sum =sum + math;
				}
			}
			System.out.println(sum);
			map.put("rows", sum);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);   
		}
		return SysmanageUtil.execAjaxResult(map, null);
	}
	
	/**
	 * 添加企业诚信评定信息
	 */
	@At
	@Ok("json")
	public Object scZxpdjgFromCjxx(HttpServletRequest request,@Param("..") ZxpdjgDTO dto){
		return SysmanageUtil.execAjaxResult(zxpdjgService.scZxpdjgFromCjxx(request,dto));
	}

	/**
	 *
	 * queryzxpddjcs的中文名称：查询红黑榜对应的分值
	 *
	 * queryzxpddjcs的概要说明：
	 * @param request
	 * @author : zk
	 */
	@At
	@Ok("json")
	@SuppressWarnings({ "rawtypes", "unchecked"})
	public Object queryzxpddjcs(HttpServletRequest request,
								@Param("..") ZxpddjcsDTO dto) throws Exception {
		Map map = new HashMap();
		try {
			ZxpddjcsDTO zxpddjcsDTO=null;
			map=zxpdjgService.queryzxpddjcs(request,dto);
			List ls = (List) map.get("rows");
			if (ls != null && ls.size() > 0) {
				zxpddjcsDTO = (ZxpddjcsDTO) ls.get(0);
			}
			map.put("data", zxpddjcsDTO);
			return  SysmanageUtil.execAjaxResult(map, null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(map, e);
		}
	}
	
}
