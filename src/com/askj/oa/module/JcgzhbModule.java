package com.askj.oa.module;

import com.askj.oa.dto.JcgzhbDTO;
import com.askj.oa.dto.JcgzhbExcel;
import com.askj.oa.service.JcgzhbService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 *
 *  JcgzhbService的中文名称：稽查工作汇报表
 *
 *
 *  Written  by  : zk
 */
@At("/jcgzhb")
@IocBean
public class JcgzhbModule {
    protected final Logger logger = Logger.getLogger(JcgzhbModule.class);
    @Inject
    protected JcgzhbService jcgzhbService;

    @At
    @Ok("jsp:/jsp/oa/jcgzhb/jcgzhb")
    public void jcgzhbIndex(HttpServletRequest request) {
    }

    @At
    @Ok("jsp:/jsp/oa/jcgzhb/jcgzhbForm")
    public void jcgzhbFormIndex(HttpServletRequest request) {

    }

    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryJcgzhb(HttpServletRequest request,
                                  @Param("..") JcgzhbDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = jcgzhbService.queryJcgzhb(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     *
     * saveTask的中文名称：保存工作台账表单页面
     *
     * saveTask的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object saveJcgzhb(HttpServletRequest request,
                           @Param("..") JcgzhbDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(jcgzhbService.saveJcgzhb(request,
                dto));
    }

    /**
     *
     * queryWorkTask的中文名称：查询单个工作台账
     *
     * queryWorkTask的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryJcgzhbDTO(HttpServletRequest request,
                                @Param("..") JcgzhbDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            JcgzhbDTO jcgzhbDTO=null;
            map=jcgzhbService.queryJcgzhbDTO(request,dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                jcgzhbDTO = (JcgzhbDTO) ls.get(0);
            }
            map.put("data", jcgzhbDTO);

            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryJcgzhbORG(HttpServletRequest request,
                                 @Param("..") JcgzhbDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            JcgzhbDTO jcgzhbDTO=null;
            map=jcgzhbService.queryJcgzhbORG(dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                jcgzhbDTO = (JcgzhbDTO) ls.get(0);
                map.put("data", jcgzhbDTO);
                map.put("jcgzhb","old");
            }else{
                map.put("jcgzhb", "new");
            }

            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryJcgzhbZuiJing(HttpServletRequest request,
                                 @Param("..") JcgzhbDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            JcgzhbDTO jcgzhbDTO=null;
            map=jcgzhbService.queryJcgzhbZuiJing(dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                jcgzhbDTO = (JcgzhbDTO) ls.get(0);
                map.put("data", jcgzhbDTO);
                map.put("jcgzhb","old");
            }else{
                map.put("jcgzhb", "new");
            }

            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    @At
    @Ok("json")
    public Object delJcgzhb(HttpServletRequest request,
                          @Param("..") JcgzhbDTO dto) {
        return SysmanageUtil.execAjaxResult(jcgzhbService.delJcgzhb(request,
                dto));
    }

    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public  void exportToExcel(HttpServletResponse response,HttpServletRequest request, @Param("..") JcgzhbDTO dto) throws Exception {

       Map map = new HashMap();
        map=jcgzhbService.queryJcgzhbExcel(request,dto);
        List ls = (List) map.get("rows");
        List<JcgzhbDTO> datalist= new ArrayList<JcgzhbDTO>();
        for (int i=0;i<ls.size();i++){
            JcgzhbDTO dcv=(JcgzhbDTO)ls.get(i);
            datalist.add(dcv);
        }
      new JcgzhbExcel().readWriter(datalist,request,response);

    }


}


