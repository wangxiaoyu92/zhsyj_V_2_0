package com.askj.oa.module;

import com.askj.oa.dto.OaemailDTO;
import com.askj.oa.dto.OaemailmanDTO;
import com.askj.oa.dto.OareportDTO;
import com.askj.oa.dto.OareportmanDTO;
import com.askj.oa.service.OaemailService;
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
import java.util.List;
import java.util.Map;

/**
 *
 *  OaemailModule的中文名称：站内信
 *
 *
 *  Written  by  : zk
 */
@At("/oaeamil")
@IocBean
public class OaemailModule {
    protected final Logger logger = Logger.getLogger(OaemailModule.class);
    @Inject
    protected OaemailService oaemailService;


    /**
     * queryOaemail的中文名称：站内信发件箱查询
     * <p>
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryOaemailSend(HttpServletRequest request,
                                   @Param("..") OaemailDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = oaemailService.queryOaemailSend(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     * queryOaemail的中文名称：站内信发件箱查询
     * <p>
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryOaemailGet(HttpServletRequest request,
                                   @Param("..") OaemailDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = oaemailService.queryOaemailGet(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     *
     * queryOaemailSendDTO的中文名称：查询单个站内信发件
     *
     * queryOaemailSendDTO的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryOaemailSendDTO(HttpServletRequest request,
                                 @Param("..") OaemailDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            OaemailDTO oaemailDTO=null;
            map=oaemailService.queryOaemailSend(request, dto, pd);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                oaemailDTO = (OaemailDTO) ls.get(0);
            }
            map.put("data", oaemailDTO);

            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     *
     * queryOaemailGetDTO的中文名称：查询单个站内信收件
     *
     * queryOaemailGetDTO的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryOaemailGetDTO(HttpServletRequest request,
                                      @Param("..") OaemailDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            OaemailDTO oaemailDTO=null;
            map=oaemailService.queryOaemailGet(request, dto, pd);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                oaemailDTO = (OaemailDTO) ls.get(0);
            }
            map.put("data", oaemailDTO);

            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     *
     * addOaemail的中文名称：添加站内信
     *
     * addOaemail的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object addOaemail(HttpServletRequest request,
                             @Param("..") OaemailDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(oaemailService.addOaemail(request,
                dto));
    }

    /**
     *
     * backOaemail的中文名称：回复站内信
     *
     * backOaemail的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object backOaemail(HttpServletRequest request,
                             @Param("..") OaemailDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(oaemailService.backOaemail(request,
                dto));
    }

    /**
     *
     * updateoaemailman的中文名称：标记站内信为已读
     *
     * updateoaemailman的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object updateoaemailman(HttpServletRequest request,
                              @Param("..") OaemailmanDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(oaemailService.updateoaemailman(request,
                dto));
    }

    /**
     *
     * delOaemail的中文名称：删除站内信
     *
     * delOaemail的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object delOaemail(HttpServletRequest request,
                              @Param("..") OaemailDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(oaemailService.delOaemail(request,
                dto));
    }


    @At
    @Ok("jsp:/jsp/oa/email/emailMain")
    public void emailMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/email/emailForm")
    public void emailFormIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/email/emailsdMain")
    public void emailsdMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/email/emailsdForm")
    public void emailsdFormIndex(HttpServletRequest request) {

    }


    /**
     * queryOareport的中文名称：工作上报发件箱查询
     * <p>
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryOareportSend(HttpServletRequest request,
                                    @Param("..") OareportDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = oaemailService.queryOareportSend(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     * queryOareport的中文名称：工作上报发件箱查询
     * <p>
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryOareportGet(HttpServletRequest request,
                                  @Param("..") OareportDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = oaemailService.queryOareportGet(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     *
     * queryOareportSendDTO的中文名称：查询单个工作上报发件
     *
     * queryOareportSendDTO的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryOareportSendDTO(HttpServletRequest request,
                                      @Param("..") OareportDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            OareportDTO oareportDTO=null;
            map=oaemailService.queryOareportSend(request, dto, pd);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                oareportDTO = (OareportDTO) ls.get(0);
            }
            map.put("data", oareportDTO);

            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     *
     * queryOareportGetDTO的中文名称：查询单个工作上报收件
     *
     * queryOareportGetDTO的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryOareportGetDTO(HttpServletRequest request,
                                     @Param("..") OareportDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            OareportDTO oareportDTO=null;
            map=oaemailService.queryOareportGet(request, dto, pd);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                oareportDTO = (OareportDTO) ls.get(0);
            }
            map.put("data", oareportDTO);

            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     *
     * addOareport的中文名称：添加工作上报
     *
     * addOareport的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object addOareport(HttpServletRequest request,
                             @Param("..") OareportDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(oaemailService.addOareport(request,
                dto));
    }

    /**
     *
     * backOareport的中文名称：回复工作上报
     *
     * backOareport的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object backOareport(HttpServletRequest request,
                              @Param("..") OareportDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(oaemailService.backOareport(request,
                dto));
    }

    /**
     *
     * updateoareportman的中文名称：标记工作上报为已读
     *
     * updateoareportman的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object updateoareportman(HttpServletRequest request,
                                   @Param("..") OareportmanDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(oaemailService.updateoareportman(request,
                dto));
    }

    /**
     *
     * delOareport的中文名称：删除工作上报
     *
     * delOareport的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object delOareport(HttpServletRequest request,
                             @Param("..") OareportDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(oaemailService.delOareport(request,
                dto));
    }


    @At
    @Ok("jsp:/jsp/oa/report/reportMain")
    public void reportMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/report/reportForm")
    public void reportFormIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/report/reportsdMain")
    public void reportsdMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/report/reportsdForm")
    public void reportsdFormIndex(HttpServletRequest request) {

    }

}
