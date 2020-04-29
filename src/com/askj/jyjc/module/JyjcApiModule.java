package com.askj.jyjc.module;

import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.service.pub.PubService;
import com.askj.jyjc.dto.*;
import com.askj.jyjc.entity.Hkjbgd;
import com.askj.jyjc.service.JyjcService;
import com.askj.tmsyj.tmsyj.dto.HjcjgjcyqbDTO;
import com.askj.tmsyj.tmsyj.service.TmsyjService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.sysmanager.SysuserService;
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
 * Created by dpx on 2018/6/29.
 */
@At("/api/jyjc")
@IocBean
public class JyjcApiModule {
    protected final Logger logger = Logger.getLogger(JyjcApiModule.class);
    //注入
    @Inject
    protected JyjcService jyjcService;
    @Inject
    protected PubService pubService;
    @Inject
    protected TmsyjService tmsyjService;
    @Inject
    private SysuserService sysuserService;
    /***********************************************/
    /**
     * queryHjyjczb_zm 的中文名称:查询检验检测主表
     *
     * @param dto
     * @param pd
     * @throws Exception Written by wxy
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryHjyjczb_zm(@Param("..") HjyjczbDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = jyjcService.queryHjyjczb_zm(dto, pd);
            HjyjczbDTO jcDto = null;
            List list = (List) map.get("rows");
            if (list != null && list.size() > 0) {
                jcDto = (HjyjczbDTO) list.get(0);
            }
            map.put("data", jcDto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    /**
     *
     * querySelectcom的中文名称：查询企业
     *
     * querySelectcom的概要说明：
     *
     * @param dto 企业参数
     * @param pd 分页参数
     * @return Written by : zjf
     * @throws Exception
     *
     */
    @At
    @Ok("json")
    public Object querySelectcom(@Param("..") PcompanyDTO dto,
                                 @Param("..") PagesDTO pd) throws Exception {
        Map mapc = new HashMap();
        try {
            mapc =  pubService.querySelectcom(dto, pd);
            return SysmanageUtil.execAjaxResult(mapc,null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(mapc, e);
        }
    }
    /**
     *
     * querySelectjyjcyp的中文名称：查询检验检测样品
     * querySelectjyjcyp的概要描述：
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * Written by : lfy
     */
    @At
    @Ok("json")
    public Object querySelectjyjcyp(@Param("..") JyjcjgDTO dto,
                                    @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            System.out.println(pd);
            map = pubService.querySelectjyjcyp(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    /**
     * queryJianceyiqi 查询检测仪器
     *
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object queryJianceyiqi(HttpServletRequest request,
                                  @Param("..") HjcjgjcyqbDTO dto, @Param("..") PagesDTO pd) {
        Map m = new HashMap();
        try {
            m = tmsyjService.queryJianceyiqi(request, dto, pd);
            return SysmanageUtil.execAjaxResult(m, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(m, e);
        }
    }
    /**
     *
     * querySysuser的中文名称：查询用户
     *
     * querySysuser的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     *
     */
    @At
    @Ok("json")
    public Object querySysuser(@Param("..") Sysuser dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = jyjcService.querySysuser(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    /**
     * 查询安全监督抽检实施细则并分页
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object queryjycjssxz(HttpServletRequest request, @Param("..") JycjssxzDTO dto,
                                @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = jyjcService.queryjycjssxz(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    /**
     * saveHjyjczb_zm ：保存检测报告主表
     *
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object saveHjyjczb_zm(HttpServletRequest request, @Param("..") HjyjczbDTO dto) {
        //return SysmanageUtil.execAjaxResult(jyjcService.saveJyjccydj(request,dto));
        Map map = new HashMap();
        try {
            String id = jyjcService.saveHjyjczb_zm(request, dto);
            if (id != null) {
                map.put("id", id);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryHjyjcmxb_zm(@Param("..") HjyjcmxbDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = jyjcService.queryHjyjcmxb_zm(dto, pd);
            HjyjcmxbDTO jcDto = null;
            List list = (List) map.get("rows");
            if (list != null && list.size() > 0) {
                jcDto = (HjyjcmxbDTO) list.get(0);
            }
            map.put("data", jcDto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    /**
     * 选择检查项目接口
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object querySelectjyjcxm(@Param("..") JyjcjgDTO dto,
                                    @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = pubService.querySelectjyjcxm(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    @At
    @Ok("json")
    public Object queryJcffgl(@Param("..") JyjcffbzbDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = jyjcService.queryJcffgl(dto, pd);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    @At
    @Ok("json")
    public Object queryJyjcjcbzb(HttpServletRequest request, @Param("..") JyjcjcbzbDTO dto,
                                 @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = jyjcService.queryJyjcjcbzb(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    @At
    @Ok("json")
    public Object saveHjyjcxb(HttpServletRequest request, @Param("..") HjyjcmxbDTO dto) {
        Map map = new HashMap();
        try {
            String id = jyjcService.saveHjyjcxb(request, dto);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object delHjyjczb_zm(HttpServletRequest request, @Param("..") HjyjczbDTO dto) {
        //return SysmanageUtil.execAjaxResult(jyjcService.saveJyjccydj(request,dto));
        Map map = new HashMap();
        try {
            String id = jyjcService.delHjyjczb_zm(request, dto);
            if (id != null) {
                map.put("id", id);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object delHjyjcmxb(HttpServletRequest request, @Param("..") HjyjcmxbDTO dto) {
        //return SysmanageUtil.execAjaxResult(jyjcService.saveJyjccydj(request,dto));
        Map map = new HashMap();
        try {
            String id = jyjcService.delHjyjcmxb(request, dto);
            if (id != null) {
                map.put("id", id);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }

    /**
     * 添加/修改快检报告
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object saveHkjbgd(HttpServletRequest request, @Param("..") HjyjczbDTO dto) {
        Map map = new HashMap();
        try {
            jyjcService.saveHkjbgd(request,dto);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }

    /**
     * queryHkjbgd 的中文名称:查询快检报告列表
     *
     * @param dto
     * @param pd
     * @throws Exception Written by wxy
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryHkjbgd(@Param("..") HjyjczbDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = jyjcService.queryHkjbgd(dto, pd);
            if(dto==null || dto.getKjbgdpch()==null || "".equals(dto.getKjbgdpch())) {//查询列表
                List list = (List) map.get("rows");
                map.put("rows", list);
                return SysmanageUtil.execAjaxResult(map, null);
            }else{
                HjyjczbDTO hjyjczb = (HjyjczbDTO) map.get("rows");
                map.remove("rows");
                map.put("data", hjyjczb);
                return SysmanageUtil.execAjaxResult(map, null);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryHkjbgd 的中文名称:查询快检报告单
     *
     * @param dto
     * @param pd
     * @throws Exception Written by wxy
     */
    @At
    @Ok("raw:htm")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryKjbgdprint(@Param("..") Hkjbgd dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            String str = jyjcService.queryKjbgdprint(dto, pd);
            StringBuffer sb = new StringBuffer();
            sb.append("<!DOCTYPE html><html> <head><title>快检报告单打印</title><meta http-equiv='content-type' content='text/html; charset=UTF-8'>");
            sb.append("<meta name='Author' content=''> <meta name='Keywords' content=''> <meta name='Description' content=''>");
//				sb.append("</head><body>");
            sb.append("</head><body>");
            sb.append(str);
            sb.append("</body></html>");
            return sb.toString();
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * 删除快检报告
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object delHkjbgd(HttpServletRequest request, @Param("..") HjyjczbDTO dto) {
        Map map = new HashMap();
        try {
            String id = jyjcService.delHkjbgd(request, dto);
            if (id != null) {
                map.put("id", id);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }

    /**
     * queryHkjbgd 的中文名称:查询快检检测项目
     *
     * @param dto
     * @param pd
     * @throws Exception Written by wxy
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryKjjcxm(@Param("..") JyjcxmDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = jyjcService.queryKjjcxm(dto, pd);
            List list = (List) map.get("rows");
            map.put("rows", list);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
}
