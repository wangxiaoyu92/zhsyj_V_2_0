package com.askj.aqcx.module;

import com.askj.aqcx.dto.DiscreditenterpriseDTO;
import com.askj.aqcx.service.DiscreditenterpriseService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;

import org.apache.log4j.Logger;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


/**
 *
 * DiscreditenterpriseModule的中文名称：安全诚信
 *
 * DiscreditenterpriseModule的描述：
 *
 * @author : wcl
 */
@At("/aqcx/discred")
@IocBean
public class DiscreditenterpriseModule {

    protected final Logger logger = Logger.getLogger(DiscreditenterpriseModule.class);

    @Inject
    protected DiscreditenterpriseService discreditenterpriseService;

    /**
     *
     * discredManagerIndex的中文名称：失信企业页面
     *
     * discredManagerIndex的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/aqcx/discred/discredManager")
    public void discredManagerIndex(HttpServletRequest request) {
        // 页面初始化
    }


    /**
     *
     * discredFormIndex的中文名称：失信信息页面
     *
     * discredFormIndex的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/aqcx/discred/discredForm")
    public void discredFormIndex(HttpServletRequest request) {
        // 页面初始化
    }





    /**
     *
     * queryDiscredInfos的中文名称：查询失信企业信息
     *
     * queryDiscredInfos的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryDiscredInfos(HttpServletRequest request,
                                   @Param("..") DiscreditenterpriseDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = discreditenterpriseService.queryDiscreditenterInfos(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     *
     * queryDiscredObj的中文名称：查询失信企业信息
     *
     * queryDiscredObj的概要说明：
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
    public Object queryDiscredObj(HttpServletRequest request, @Param("..") DiscreditenterpriseDTO dto) {
        Map map = new HashMap();
        try {
            map = discreditenterpriseService.queryDiscredObj(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }

    }

    /**
     *
     * saveDiscredObj的中文名称：保存企业失信
     *
     * saveDiscredObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @author : wcl
     */
    @At
    @Ok("json")
    public Object saveDiscredObj(HttpServletRequest request, @Param("..") DiscreditenterpriseDTO dto) {
        return SysmanageUtil.execAjaxResult(discreditenterpriseService.saveDiscred(request, dto));
    }


    /**
     *
     * delDiscred的中文名称：删除企业诚信
     *
     * delDiscred的概要说明：
     *
     * @param request
     * @return
     * @throws Exception
     * @author : wcl
     */
    @At
    @Ok("json")
    public Object delDiscred(HttpServletRequest request, @Param("..") DiscreditenterpriseDTO dto) {
        return SysmanageUtil.execAjaxResult(discreditenterpriseService.delDiscred(request, dto));
    }







}
