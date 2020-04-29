package com.askj.supervision.module;

import com.askj.supervision.dto.AreaConditionDTO;
import com.askj.supervision.service.AreaConditionService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * AreaConditionModule的中文名称：区域情况表
 * Created by ce on 2018/5/12.
 */
@At("/area/condition")
@IocBean
public class AreaConditionModule {
    protected final Logger logger = Logger.getLogger(AreaConditionModule.class);

    @Inject
    protected AreaConditionService areaConditionService;

    @At
    @Ok("jsp:/jsp/supervision/areacondition/areaConditionMain")
    public void areaConditionMainIndex(HttpServletRequest request){
        //页面初始化
    }

    @At
    @Ok("json")
    public Object queryareaCondition(@Param("..") AreaConditionDTO dto,
                            @Param("..") PagesDTO pd) throws Exception {
        Map map=new HashMap();
        try{
            map=areaConditionService.queryAreaCondition(dto, pd);
            return  SysmanageUtil.execAjaxResult(map, null);
        }catch (Exception e){
            return  SysmanageUtil.execAjaxResult(map, e);
        }
    }

    @At
    @Ok("jsp:/jsp/supervision/areacondition/areaConditonForm")
    public void areaConditionFormIndex(HttpServletRequest request){
        // 页面初始化
    }

    @At
    @Ok("json")
    public Object saveareaCondition(HttpServletRequest request,
                           @Param("..") AreaConditionDTO dto) {
        return SysmanageUtil.execAjaxResult(areaConditionService.saveAreaCondition(request,
                dto));
    }

    @At
    @Ok("json")
    public Object findAreaCondition(HttpServletRequest request,
                           @Param("..") AreaConditionDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            AreaConditionDTO areaConditionDTO=null;
            areaConditionDTO=(AreaConditionDTO)areaConditionService.findAreaCondition(request,dto);
            map.put("data", areaConditionDTO);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return  SysmanageUtil.execAjaxResult(map, e);
        }
    }

    @At
    @Ok("json")
    public Object delAreaCondition(HttpServletRequest request,
                          @Param("..") AreaConditionDTO dto) {
        return SysmanageUtil.execAjaxResult(areaConditionService.delAreaCondition(request,
                dto));
    }
}
