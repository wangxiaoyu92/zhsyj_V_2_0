package com.askj.tmsyj.tmcsc.module;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.askj.tmsyj.tmcsc.dto.PscfqDTO;
import com.askj.tmsyj.tmcsc.dto.PshDTO;
import com.askj.tmsyj.tmcsc.service.ScfqHshService;
import com.zzhdsoft.mvc.BaseModule;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
/**
 * 
 *  ScfqHshModule的中文名称：市场分区和商户
 *
 *  ScfqHshModule的描述：
 *
 *  @author : ly
 *  @version : V1.0
 */
@IocBean
@At("/tmcsc/scfqHsh")
public class ScfqHshModule extends BaseModule {
    @Inject
	private ScfqHshService scfqHshService;
    /**
     * 
     * scfqMainIndex的中文名称：
     * 
     * scfqMainIndex的概要说明：市场分区主页
     *
     * @author : ly
     */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcsc/scfqHsh/scfqMain")
    public void scfqMainIndex(){
    	
    }
	
	/**
	 * 
	 * queryScfq的中文名称：查询分区
	 * 
	 * queryScfq的概要说明：
	 *
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@At
	@Ok("json")
	public Object queryScfq(@Param("..")PscfqDTO dto ,@Param("..")PagesDTO pd) throws Exception{
		  try {
			   List lis = scfqHshService.queryScfq(dto, pd) ;
			   String orgData = Json.toJson(lis, JsonFormat.compact());
				orgData = orgData.replace("isparent", "isParent");
				orgData = orgData.replace("isopen", "open");
				Map m = new HashMap();
				m.put("orgData", orgData);
				return SysmanageUtil.execAjaxResult(m, null);
		  } catch (Exception e) {
			    return SysmanageUtil.execAjaxResult(null, e);
		  }  
	}
    /**
     * 	
     * saveScfq的中文名称：保存市场分区
     * 
     * saveScfq的概要说明：
     *
     * @param dto
     * @return
     * @author : ly
     */
	@At
	@Ok("json")
	public Object saveScfq(@Param("..")PscfqDTO dto){
		return SysmanageUtil.execAjaxResult(scfqHshService.saveScfq(dto));
	}
	/**
	 * 
	 * delScfq的中文名称：删除市场分区
	 * 
	 * delScfq的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object delScfq(@Param("..")PscfqDTO dto){
		return SysmanageUtil.execAjaxResult(scfqHshService.delScfq(dto));
	}
	
	/**
	 * 
	 * scfqMainIndex的中文名称：商户主页
	 * 
	 * scfqMainIndex的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcsc/scfqHsh/shMain")
    public void shMainIndex(){}
	
	/**
	 * 
	 * shFromIndex的中文名称：商户附页
	 * 
	 * shFromIndex的概要说明：
	 *
	 * @author : ly
	 */
	@At
	@Ok("jsp:/jsp/tmsyj/tmcsc/scfqHsh/shFrom")
	public void shFromIndex(){}
	
	/**
	 * 
	 * querySh的中文名称：查看商户
	 * 
	 * querySh的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object querySh(@Param("..") PshDTO dto,@Param("..") PagesDTO pd) throws Exception{
		try {
			return SysmanageUtil.execAjaxResult(scfqHshService.querySh(dto, pd),null);
		} catch (Exception e) {
			return SysmanageUtil.execAjaxResult(scfqHshService.querySh(dto, pd),e);
		}
	}
	
	/**
	 * 
	 * saveSh的中文名称：保存或更新商户
	 * 
	 * saveSh的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@At
	@Ok("json")
	public Object saveSh(@Param("..") PshDTO dto){
		return SysmanageUtil.execAjaxResult(scfqHshService.saveSh(dto)); 
	}
	
	/**
	 * 
	 * delSh的中文名称：删除商户
	 * 
	 * delSh的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 * @throws Exception 
	 */
	@At
	@Ok("json")
	public Object delSh(@Param("..") PshDTO dto) throws Exception{
		return SysmanageUtil.execAjaxResult(scfqHshService.delSh(dto)); 
	}
	
}
