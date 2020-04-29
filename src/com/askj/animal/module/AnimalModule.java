package com.askj.animal.module;

import com.askj.animal.dto.AnimaldeathDTO;
import com.askj.animal.dto.AnimalfenceDTO;
import com.askj.animal.dto.AnimalhouseDTO;
import com.askj.animal.dto.AnimalinfoDTO;
import com.askj.animal.service.AnimalService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 *  AnimalModule的中文名称：动物管理
 *
 *  AnimalModule的描述：
 *
 *  Written  by  : zk
 */
@At("/animal")
@IocBean
public class AnimalModule {

    protected final Logger logger = Logger.getLogger(AnimalModule.class);

    @Inject
    protected AnimalService animalService;

    @At
    @Ok("jsp:/jsp/animal/animalhouse/animalhouse")
    public void animalhouseIndex(HttpServletRequest request) {
        // 页面初始化
    }

    @At
    @Ok("jsp:/jsp/animal/animalinfo/animalinfo")
    public void animalinfoIndex(HttpServletRequest request) {
        // 页面初始化
    }

    @At
    @Ok("jsp:/jsp/animal/animalfence/animalfence")
    public void animalfenceIndex(HttpServletRequest request) {
        // 页面初始化
    }

    @At
    @Ok("jsp:/jsp/animal/animaldeath/animaldeathMain")
    public void animaldeathIndex(HttpServletRequest request) {
        // 页面初始化
    }

    @At
    @Ok("jsp:/jsp/animal/animaldeath/animaldeathForm")
    public void animaldeathFormIndex(HttpServletRequest request) {
        // 页面初始化
    }

    @At
    @Ok("jsp:/jsp/animal/animalinfo/animalForm")
    public void animalinfoFormIndex(HttpServletRequest request) {
        // 页面初始化
    }

    @At
    @Ok("jsp:/jsp/animal/animalfence/animalfenceForm")
    public void animalfenceFormIndex(HttpServletRequest request) {
        // 页面初始化
    }

    /**
     * queryAnimalinfo的中文名称：动物信息列表查询
     * <p>
     * queryAnimalinfo的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryAnimalinfo(HttpServletRequest request,
                                  @Param("..") AnimalinfoDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = animalService.queryAnimalinfo(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     * queryAnimalfence的中文名称：动物栅栏信息列表查询
     * <p>
     * queryAnimalfence的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryAnimalfence(HttpServletRequest request,
                                   @Param("..") AnimalfenceDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = animalService.queryAnimalfence(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     * queryAnimaldeath的中文名称：动物死亡信息列表查询
     * <p>
     * queryAnimaldeath的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryAnimaldeath(HttpServletRequest request,
                                   @Param("..") AnimaldeathDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = animalService.queryAnimaldeath(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    /**
     * saveAnimalinfo的中文名称：动物信息保存
     * <p>
     * saveAnimalinfo的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object saveAnimalinfo(HttpServletRequest request,
                           @Param("..") AnimalinfoDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(animalService.saveAnimalinfo(request,
                dto));
    }

    /**
     * saveAnimaldeath的中文名称：动物死亡信息保存
     * <p>
     * saveAnimaldeath的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object saveAnimaldeath(HttpServletRequest request,
                                 @Param("..") AnimaldeathDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(animalService.saveAnimaldeath(request,
                dto));
    }

    /**
     * saveAnimalhouse的中文名称：动物舍所信息保存
     * <p>
     * saveAnimalhouse的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object saveAnimalhouse(HttpServletRequest request,
                                  @Param("..") AnimalhouseDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(animalService.saveAnimalhouse(request,
                dto));
    }

    /**
     * saveAnimalfence的中文名称：动物栅栏信息保存
     * <p>
     * saveAnimalfence的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object saveAnimalfence(HttpServletRequest request,
                                  @Param("..") AnimalfenceDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(animalService.saveAnimalfence(request,
                dto));
    }

    /**
     * queryAnimalinfoDTO的中文名称：动物信息查询
     * <p>
     * queryAnimalinfoDTO的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryAnimalinfoDTO(HttpServletRequest request,
                                 @Param("..") AnimalinfoDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            AnimalinfoDTO animalinfoDTO=null;
            map=animalService.queryAnimalinfoDTO(request,dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                animalinfoDTO = (AnimalinfoDTO) ls.get(0);
            }
            map.put("data", animalinfoDTO);

            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryAnimaldeathDTO的中文名称：动物死亡信息查询
     * <p>
     * queryAnimaldeathDTO的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryAnimaldeathDTO(HttpServletRequest request,
                                     @Param("..") AnimaldeathDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            AnimaldeathDTO animaldeathDTO=null;
            map=animalService.queryAnimaldeathDTO(request,dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                animaldeathDTO = (AnimaldeathDTO) ls.get(0);
            }
            map.put("data", animaldeathDTO);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryAnimalfenceDTO的中文名称：动物栅栏信息查询
     * <p>
     * queryAnimalfenceDTO的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryAnimalfenceDTO(HttpServletRequest request,
                                      @Param("..") AnimalfenceDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            AnimalfenceDTO animalfenceDTO=null;
            map=animalService.queryAnimalfenceDTO(request,dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                animalfenceDTO = (AnimalfenceDTO) ls.get(0);
            }
            map.put("data", animalfenceDTO);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryAnimalhouseDTO的中文名称：动物舍所信息查询
     * <p>
     * queryAnimalhouseDTO的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryAnimalhouseDTO(HttpServletRequest request,
                                      @Param("..") AnimalhouseDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            AnimalhouseDTO animalhouseDTO=null;
            map=animalService.queryAnimalhouseDTO(request,dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                animalhouseDTO = (AnimalhouseDTO) ls.get(0);
            }
            map.put("data", animalhouseDTO);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryAnimalZTreeAsync的中文名称：动物舍所信息分类树
     * <p>
     * queryAnimalZTreeAsync的概要说明：
     *
     * @param request
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object queryAnimalZTreeAsync(HttpServletRequest request) {
        try {
            List animalhouseList = (List) animalService.queryAnimalZTreeAsync(request);
            String mydata = Json.toJson(animalhouseList, JsonFormat.compact());
            Map m = new HashMap();
            m.put("animalhouseData", mydata);
            return SysmanageUtil.execAjaxResult(m, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(null, e);
        }
    }

    /**
     * delAnimaldeath的中文名称：动物死亡信息删除
     * <p>
     * delAnimaldeath的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object delAnimaldeath(HttpServletRequest request,
                          @Param("..") AnimaldeathDTO dto) {
        return SysmanageUtil.execAjaxResult(animalService.delAnimaldeath(request,
                dto));
    }

    /**
     * delAnimalinfo的中文名称：动物信息删除
     * <p>
     * delAnimalinfo的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object delAnimalinfo(HttpServletRequest request,
                                 @Param("..") AnimalinfoDTO dto) {
        return SysmanageUtil.execAjaxResult(animalService.delAnimalinfo(request,
                dto));
    }

    /**
     * delAnimalfence的中文名称：动物栅栏信息删除
     * <p>
     * delAnimalfence的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object delAnimalfence(HttpServletRequest request,
                                 @Param("..") AnimalfenceDTO dto) {
        return SysmanageUtil.execAjaxResult(animalService.delAnimalfence(request,
                dto));
    }

    /**
     * delAnimalhouse的中文名称：动物舍所信息删除
     * <p>
     * delAnimalhouse的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object delAnimalhouse(HttpServletRequest request,
                                 @Param("..") AnimalhouseDTO dto) {
        return SysmanageUtil.execAjaxResult(animalService.delAnimalhouse(request,
                dto));
    }

}
