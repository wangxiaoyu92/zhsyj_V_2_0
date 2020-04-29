package com.askj.aqcx.module;

import com.askj.aqcx.dto.TrustworthinessDTO;
import com.askj.aqcx.service.TrustworthinessService;
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
 * TrustworthinessModule的中文名称：人员诚信
 *
 * TrustworthinessModule的描述：
 *
 * @author : wcl
 */
@At("/aqcx/trust")
@IocBean
public class TrustworthinessModule {
    protected final Logger logger = Logger.getLogger(TrustworthinessModule.class);

    @Inject
    protected TrustworthinessService trustworthinessService;

    /**
     *
     * trustManagerIndex的中文名称：人员诚信页面
     *
     * trustManagerIndex的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/aqcx/trust/trustManager")
    public void trustManagerIndex(HttpServletRequest request) {
        // 页面初始化
    }


    /**
     *
     * personnelIndex的中文名称：选择人员
     *
     * personnelIndex的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/aqcx/trust/personnel")
    public void personnelIndex(HttpServletRequest request) {
        // 页面初始化
    }



    /**
     *
     * trustFormIndex的中文名称：人员信息页面
     *
     * courseFormIndex的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/aqcx/trust/trustForm")
    public void trustFormIndex(HttpServletRequest request) {
        // 页面初始化
    }

    /**
     *
     * queryTrustInfos的中文名称：查询人员档案信息
     *
     * queryTrustInfos的概要说明：
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
    public Object queryTrustInfos(HttpServletRequest request,
                                    @Param("..") TrustworthinessDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = trustworthinessService.queryTrustInfos(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     *
     * queryTrustObj的中文名称：查询人员信息
     *
     * queryTrustObj的概要说明：
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
    public Object queryTrustObj(HttpServletRequest request, @Param("..") TrustworthinessDTO dto) {
        Map map = new HashMap();
        try {
            map = trustworthinessService.queryTrustObj(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }

    }

    /**
     *
     * saveTrustObj的中文名称：保存人员
     *
     * saveTrustObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @author : wcl
     */
    @At
    @Ok("json")
    public Object saveTrustObj(HttpServletRequest request, @Param("..") TrustworthinessDTO dto) {
        return SysmanageUtil.execAjaxResult(trustworthinessService.saveTrust(request, dto));
    }

    /**
     *
     * delTrust的中文名称：删除人员诚信
     *
     * delTrust的概要说明：
     *
     * @param request
     * @return
     * @throws Exception
     * @author : wcl
     */
    @At
    @Ok("json")
    public Object delTrust(HttpServletRequest request, @Param("..") TrustworthinessDTO dto) {
        return SysmanageUtil.execAjaxResult(trustworthinessService.delTrust(request, dto));
    }


}
