package com.askj.oa.module;
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
import com.zzhdsoft.utils.SysmanageUtil;
import com.askj.oa.dto.InforeGulationsDTO;
import com.askj.oa.service.InforegulationsService;

/**
*
*  InforegulationsModule的中文名称：信息上报数量设置Module
*
*  InforegulationsModule的描述：
*
*  @author : 孙意峰
*  @version : V1.0
*/
@IocBean
@At("/inforegulations")
public class InforegulationsModule {
    protected final Logger logger = Logger.getLogger(InforegulationsModule.class);

    @Inject
    protected InforegulationsService inforegulationsService;

    /**
    *
    * InforegulationsIndex的中文名称：信息上报数量设置管理页面
    *
    * InforegulationsIndex的概要说明：
    *
    * @param request
    * Written by : 孙意峰
    *
    */
    @At
    @Ok("jsp:/jsp/oa/inforegulations")
    public void inforegulationsIndex(HttpServletRequest request) {
    // 页面初始化
    }
    /**
    *
    * addInforegulations的中文名称：添加信息上报数量设置页面
    *
    * addInforegulations的概要说明：
    *
    * @param request
    * Written by : 孙意峰
    *
    */
    @At
    @Ok("jsp:/jsp/oa/inforegulationsForm")
    public void addInforegulationsIndex(HttpServletRequest request) {
    // 增加页面初始化
    }
    /**
    *
    * editInforegulations的中文名称：添加信息上报数量设置页面
    *
    * editInforegulations的概要说明：
    *
    * @param request
    * Written by : 孙意峰
    *
    */
    @At
    @Ok("jsp:/jsp/oa/inforegulationsForm")
    public void editInforegulationsIndex(HttpServletRequest request) {
    // 修改页面初始化
    }
    /**
    *
    * viewInforegulations的中文名称：添加信息上报数量设置页面
    *
    * viewInforegulations的概要说明：
    *
    * @param request
    * Written by : 孙意峰
    *
    */
    @At
    @Ok("jsp:/jsp/oa/inforegulationsForm")
    public void viewInforegulationsIndex(HttpServletRequest request) {
    // 查看页面初始化
    }

    /**
    *
    * queryInforegulations的中文名称：查询信息上报数量设置接口
    *
    * queryInforegulations的概要说明：
    *
    * @param request
    * @param dto
    * Written by : 孙意峰
    *
    */
    @At
    @Ok("json")
    public Object queryInforegulationss(HttpServletRequest request,@Param("..") InforeGulationsDTO dto,@Param("..") PagesDTO pd){
        Map map = new HashMap();
        try{
            return SysmanageUtil.execAjaxResult(inforegulationsService.queryInforegulationss(request, dto, pd),null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

    /**
     *
     * saveInfo的中文名称：保存信息
     *
     * saveInfo的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @author : wcl
     */
    @At
    @Ok("json")
    public Object saveInforegulations(HttpServletRequest request, @Param("..") InforeGulationsDTO dto) {
        return SysmanageUtil.execAjaxResult(inforegulationsService.saveInforegulations(request, dto));
    }


    /**
     *
     * queryInfoObj的中文名称：查询课程信息
     *
     * queryInfoObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : wcl
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryInforegulationsObj(HttpServletRequest request, @Param("..") InforeGulationsDTO dto) {
        Map map = new HashMap();
        try {
            map = inforegulationsService.queryInforegulationsObj(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }


    /**
     *
     * delInfo的中文名称：删除信息
     *
     * delInfo的概要说明：
     *
     * @param request
     * @return
     * @throws Exception
     * @author : wcl
     */
    @At
    @Ok("json")
    public Object delInforegulations(HttpServletRequest request, @Param("..") InforeGulationsDTO dto) {
        return SysmanageUtil.execAjaxResult(inforegulationsService.delInforegulations(request, dto));
    }

}

