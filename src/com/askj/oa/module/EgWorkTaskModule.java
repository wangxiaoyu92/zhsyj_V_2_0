package com.askj.oa.module;

import com.alibaba.fastjson.JSONObject;
import com.askj.oa.dto.*;
import com.askj.oa.service.EgWorkTaskService;
import com.askj.oa.service.OataskApiService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysorg;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.SysmanageUtil;
import net.sf.json.JSONArray;
import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * EgWorkTaskModule的中文名称：工作进度表
 *
 * CourseModule的描述：
 *
 * @author : wcl
 */
@At("/work/task")
@IocBean
public class EgWorkTaskModule {
    protected final Logger logger = Logger.getLogger(EgWorkTaskModule.class);

    @Inject
    protected EgWorkTaskService egWorkTaskService;



    /**
     *
     * workManagerIndex的中文名称：工作台账表页面
     *
     * 工作台账表的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/work/workTask")
    public void yearWorkTaskIndex(HttpServletRequest request) {
        // 页面初始化
        String curTime = "0";
        try {
            curTime = SysmanageUtil.getDbtime("%m");
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("curTime",curTime);
    }

    /**
     *
     * queryMonthlyWorkTaskIndex的中文名称：月度工作台账表页面
     *
     * 工作台账表的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/work/monthlyWorkTask")
    public void monthlyWorkTaskIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/gzrwMain")
    public void gzrwMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/gzrwForm")
    public void gzrwFormIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/gzrwsdMain")
    public void gzrwsdMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/gzrwhfMain")
    public void gzrwhfMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/gzrwhfydMain")
    public void gzrwhfydMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/gzrwhftaMain")
    public void gzrwhftaMainIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/gzrwsdForm")
    public void gzrwsdFormIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/gzrwhfForm")
    public void gzrwhfFormIndex(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/work/bnwcForm")
    public void bnwcFormIndex(HttpServletRequest request) {

    }

    /**
     *
     * department的中文名称：选择机构
     *
     * 选择机构的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/work/department")
    public void departmentIndex(HttpServletRequest request) {

    }

    /**
     *
     * queryDepartment的中文名称：机构信息查询
     *
     * queryDepartment的概要说明：
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
    public Object queryDepartment(HttpServletRequest request,
                                    @Param("..") Sysorg dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryDepartment(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }


    /**
     *
     * queryMonthlyWorkTaskIndex的中文名称：月度科室分任务统计图
     *
     * 工作台账表的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/info/informationForm")
    public void InformationForm(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/info/worksbForm")
    public void worksbForm(HttpServletRequest request) {

    }

    @At
    @Ok("jsp:/jsp/oa/info/workrwForm")
    public void workrwForm(HttpServletRequest request) {

    }
    @At
    @Ok("jsp:/jsp/oa/work/hfForm")
    public void hfForm(HttpServletRequest request) {

    }
    @At
    @Ok("jsp:/jsp/oa/info/worksbeditForm")
    public void worksbeditForm(HttpServletRequest request) {

    }
    @At
    @Ok("jsp:/jsp/oa/info/worksb")
    public void worksb(HttpServletRequest request) {

    }
    @At
    @Ok("jsp:/jsp/oa/info/workrw")
    public void workrw(HttpServletRequest request) {

    }

    /**
     *
     * queryMonthlyWorkTaskIndex的中文名称：月度科室分任务统计图
     *
     * 工作台账表的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/work/monthlyWorkTaskStat")
    public void queryStatIndex(HttpServletRequest request) {

    }

    /**
     *
     * Information的中文名称：信息管理页面
     *
     * 信息管理页面的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/info/information")
    public void queryInformationIndex(HttpServletRequest request) {

    }

    /**
     *
     * queryInfo的中文名称：信息管理查询
     *
     * queryInfo的概要说明：
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
    public Object queryInfo(HttpServletRequest request,
                            @Param("..") InformationDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryInfo(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }


    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryTaskZJ(HttpServletRequest request,
                            @Param("..") OataskDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryTaskZJ(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object querysdTaskZJ(HttpServletRequest request,
                              @Param("..") OataskDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.querysdTaskZJ(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object querysdTaskZJDB(HttpServletRequest request,
                                @Param("..") OataskDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.querysdTaskZJDB(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryhfTaskZJ(HttpServletRequest request,
                                @Param("..") OamatterdynamicDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryhfTaskZJ(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryhfsTaskZJ(HttpServletRequest request,
                                @Param("..") OamatterdynamicDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryhfsTaskZJ(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryhfsTaskZ(HttpServletRequest request,
                                 @Param("..") OamatterdynamicDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryhfsTaskZ(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryTaskZJDTO(HttpServletRequest request,
                            @Param("..") OataskDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            OataskDTO oataskDTO=null;
            map=egWorkTaskService.queryTaskZJ(request,dto, pd);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                oataskDTO = (OataskDTO) ls.get(0);
            }
            map.put("data", oataskDTO);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object querysdTaskZJDTO(HttpServletRequest request,
                                 @Param("..") OataskDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            OataskDTO oataskDTO=null;
            map=egWorkTaskService.querysdTaskZJ(request,dto, pd);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                oataskDTO = (OataskDTO) ls.get(0);
            }
            map.put("data", oataskDTO);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryW(HttpServletRequest request,
                         @Param("..") WorksbDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryW(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings("rawtypes")
    public Object queryW1(HttpServletRequest request,
                         @Param("..") WorksbDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryW1(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }

    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryWDTO(HttpServletRequest request,
                            @Param("..") WorksbDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            WorksbDTO egWorkScheduleDTO=null;
            map=egWorkTaskService.queryWa(request,dto, pd);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                egWorkScheduleDTO = (WorksbDTO) ls.get(0);
            }
            map.put("data", egWorkScheduleDTO);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     *
     * queryStatbarIndex的中文名称：各科室主月进度统计图
     *
     * 工作台账表的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/work/monthlyWorkTaskStatBar")
    public void queryStatbarIndex(HttpServletRequest request) {

    }


    /**
     *
     * workFormIndex的中文名称：工作台账表页面
     *
     * workFormIndex的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/work/workTaskForm")
    public void workFormIndex(HttpServletRequest request) {

        // 页面初始化
    }


    /**
     *
     * queryYearWorkTask的中文名称：年度工作台账表查询
     *
     * queryYearWorkTask的概要说明：
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
    public Object queryYearWorkTask(HttpServletRequest request,
                                   @Param("..") EgWorkTaskDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryYearWorkTask(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }



    /**
     *
     * queryMonthlyWorkTasks的中文名称：月度工作台账表查询
     *
     * queryMonthlyWorkTask的概要说明：
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
    public Object queryMonthlyWorkTask(HttpServletRequest request,
                                 @Param("..") EgWorkTaskDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryMonthlyWorkTask(request, dto, pd);
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
    public Object saveTask(HttpServletRequest request,
                           @Param("..") EgWorkTaskDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.saveTask(request,
                dto));
    }

    @At
    @Ok("json")
    public Object saveSb(HttpServletRequest request,
                           @Param("..") WorksbDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.saveSb(request,
                dto));
    }

    @At
    @Ok("json")
    public Object saveSbnew(HttpServletRequest request,
                         @Param("..") WorksbDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.saveSbnew(request,
                dto));
    }

    @At
    @Ok("json")
    public Object addOatask(HttpServletRequest request,
                            @Param("..")OataskDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.addOatask(request,
                dto));
    }

    @At
    @Ok("json")
    public Object addOamatterdynamic(HttpServletRequest request,
                            @Param("..")OamatterdynamicDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.addOamatterdynamic(request,
                dto));
    }

    @At
    @Ok("json")
    public Object updateoatsakman(HttpServletRequest request,
                                     @Param("..")OataskmanDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.updateoatsakman(request,
                dto));
    }

    @At
    @Ok("json")
    public Object wcoatsakman(HttpServletRequest request,
                                  @Param("..")OataskmanDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.wcoatsakman(request,
                dto));
    }

    @At
    @Ok("json")
    public Object bnwcoatsakman(HttpServletRequest request,
                              @Param("..")OataskmanDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.bnwcoatsakman(request,
                dto));
    }

    /**
     * cxsbTask的中文名称：重新上报工作台账
     * <p>
     * cxsbTask的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    @At
    @Ok("json")
    public Object cxsbTask(HttpServletRequest request,
                           @Param("..") EgWorkTaskDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.cxsbTask(request,
                dto));
    }
    /**
     *
     * saveSchedule的中文名称：保存工作进度表单页面
     *
     * saveSchedule的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object saveSchedule(HttpServletRequest request,
                               @Param("..") EgWorkScheduleDTO dto)throws Exception {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.saveSchedule(request,
                dto));
    }

    /**
     *
     * queryWorkSchedule的中文名称：查询当月工作进度
     *
     * queryWorkSchedule的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryWorkSchedule(HttpServletRequest request,
                                    @Param("..") EgWorkScheduleDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            EgWorkScheduleDTO egWorkScheduleDTO=null;
            map=egWorkTaskService.queryWorkSchedule(request,dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                egWorkScheduleDTO = (EgWorkScheduleDTO) ls.get(0);
            }
            String s=(String) map.get("userposition");
            map.put("data", egWorkScheduleDTO);
            map.put("userposition", s);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
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
    public Object queryWorkTask(HttpServletRequest request,
                                @Param("..") EgWorkTaskDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            EgWorkTaskDTO egWorkTaskDTO=null;
            map=egWorkTaskService.queryWorkTask(request,dto);
            List ls = (List) map.get("rows");
            if (ls != null && ls.size() > 0) {
                egWorkTaskDTO = (EgWorkTaskDTO) ls.get(0);
            }
            map.put("data", egWorkTaskDTO);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     *
     * workScheduleFormIndex的中文名称：到设置工作进度页面
     *
     * workScheduleFormIndex的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("jsp:/jsp/oa/work/workScheduleForm")
    public void workScheduleFormIndex(HttpServletRequest request) {
    }

    /**
     *
     * delTask的中文名称：删除工作台账
     *
     * delTask的概要说明：
     * @param request
     * @author : zk
     */
    @At
    @Ok("json")
    public Object delTask(HttpServletRequest request,
                          @Param("..") EgWorkTaskDTO dto) {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.delTask(request,
                dto));
    }

    @At
    @Ok("json")
    public Object delW(HttpServletRequest request,
                          @Param("..") WorksbDTO dto) {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.delW(request,
                dto));
    }

    /**
     *
     * queryStat的中文名称：月度科室分任务统计图
     *
     * queryStat的概要说明：
     * @param request
     * @author :
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryStat(HttpServletRequest request,
                                @Param("..") EgWorkTaskDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            EgWorkTaskDTO egWorkTaskDTO=null;
           /* dto.setOrgname("河南省食药局");*/
            Sysuser vSysUser = SysmanageUtil.getSysuser();
            dto.setOrgname(vSysUser.getOrgname());
            map=egWorkTaskService.queryYearWorkTaskStat(request, dto,new PagesDTO());
            List<EgWorkTaskDTO> ls = (List) map.get("rows");
            map = new HashedMap();
            JSONObject retJsonObject = new JSONObject();
            JSONObject json = new JSONObject();
            JSONArray dataArray = new JSONArray();
            JSONArray taskArray = new JSONArray();
            JSONArray tempArray = new JSONArray();
            for(EgWorkTaskDTO wt:ls){
                retJsonObject.put("orgName",wt.getOrgname());
                json = new JSONObject();
                tempArray = new JSONArray();
                json.put("name",wt.getWorkTaskContent());
                tempArray.add(wt.getJd1());
                tempArray.add(wt.getJd2());
                tempArray.add(wt.getJd3());
                tempArray.add(wt.getJd4());
                tempArray.add(wt.getJd5());
                tempArray.add(wt.getJd6());
                tempArray.add(wt.getJd7());
                tempArray.add(wt.getJd8());
                tempArray.add(wt.getJd9());
                tempArray.add(wt.getJd10());
                tempArray.add(wt.getJd11());
                tempArray.add(wt.getJd12());
                json.put("type", "line");
                json.put("data",tempArray);
                dataArray.add(json);
                taskArray.add(wt.getWorkTaskContent());
            }
            retJsonObject.put("taskArray",taskArray);
            retJsonObject.put("dataArray",dataArray);

            map.put("data", retJsonObject);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }


    /**
     *
     * queryStatbar的中文名称：各科室主月进度统计图
     *
     * queryStatbar的概要说明：
     * @param request
     * @author :
     */
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public Object queryStatbar(HttpServletRequest request,
                            @Param("..") EgWorkTaskDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            EgWorkTaskDTO egWorkTaskDTO=null;
            map=egWorkTaskService.queryYearWorkTaskbar(request, dto, new PagesDTO());
            List<EgWorkTaskDTO> ls = (List) map.get("rows");
            map = new HashedMap();
            JSONObject retJsonObjects = new JSONObject();
            JSONObject json = new JSONObject();
            JSONArray dataArray = new JSONArray();
            JSONArray orgArray = new JSONArray();
            JSONArray tempArray = new JSONArray();
            String orgName = null;
            int a=0;
            for(int i = 0;i<ls.size();i++){
                EgWorkTaskDTO wt = ls.get(i);

                if(i==0){
                    orgName = wt.getOrgname();
                }
                if((!wt.getOrgname().equals(orgName))){
                    json = new JSONObject();
                    json.put("name",orgName);
                    json.put("type", "bar");
                    json.put("label", "labelOption");
                    json.put("data",tempArray);
                    dataArray.add(json);
                    tempArray = new JSONArray();
                    orgArray.add(orgName);
                    orgName = wt.getOrgname();
                }
                    if(wt.getWorkScheduleMonth()>a){
                        for(int j=1;j<wt.getWorkScheduleMonth()-a;j++){
                            tempArray.add(0);
                        }
                    }else{
                        for(int j=1;j<wt.getWorkScheduleMonth();j++){
                            tempArray.add(0);
                        }
                    }
                    a=wt.getWorkScheduleMonth();
                tempArray.add(wt.getWorkSchedulePercent());
            }
            orgArray.add(orgName);
            json.put("name",orgName);
            json.put("data",tempArray);
            dataArray.add(json);

            retJsonObjects.put("orgArray",orgArray);
            retJsonObjects.put("dataArray",dataArray);

            map.put("data", retJsonObjects);
            return  SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
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
    public Object queryInfoObj(HttpServletRequest request, @Param("..") InformationDTO dto) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryInfoObj(request,dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
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
    public Object saveInfo(HttpServletRequest request, @Param("..") InformationDTO dto) {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.saveInfo(request, dto));
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
    public Object delInfo(HttpServletRequest request, @Param("..") InformationDTO dto) {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.delInfo(request, dto));
    }

    @At
    @Ok("json")
    public Object delOatask(HttpServletRequest request, @Param("..") OataskDTO dto) {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.delOatask(request, dto));
    }

    /**
     *
     * adoptInfo的中文名称：采纳
     *
     * adoptInfo的概要说明：
     *
     * @param request
     * @return
     * @throws Exception
     * @author : wcl
     */
    @At
    @Ok("json")
    public Object adoptInfo(HttpServletRequest request, @Param("..") InformationDTO dto) {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.adoptInfo(request,dto));
    }

    /**
     *
     * linkInfo的中文名称：采纳链接
     *
     * linkInfo的概要说明：
     *
     * @param request
     * @return
     * @throws Exception
     * @author : wcl
     */
    @At
    @Ok("json")
    public Object linkInfo(HttpServletRequest request, @Param("..") InformationDTO dto) {
        return SysmanageUtil.execAjaxResult(egWorkTaskService.linkInfo(request,dto));
    }

    /**
     *
     * linkInfoIndex的中文名称：跳转链接
     *
     * 选择机构的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/info/linkInfo")
    public void linkInfoIndex(HttpServletRequest request) {

    }

    /**
     *
     * infoStatisticsInsex的中文名称：跳转信息报表
     *
     * 的概要说明：
     * @param request
     * @author : wcl
     */
    @At
    @Ok("jsp:/jsp/oa/info/infoStatistics")
    public void infoStatisticsIndex(HttpServletRequest request) {

    }

    /**
     *
     * queryinfoStatistics的中文名称：查询信息报表
     *
     * queryinfoStatistics的概要说明：
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
    public Object queryinfoStatistics(HttpServletRequest request,
                                   @Param("..") InformationDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = egWorkTaskService.queryinfoStatistics(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null); // 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e); // 异常返回
        }
    }



    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked"})
    public  void exportToExcel(HttpServletResponse response, HttpServletRequest request, @Param("..") InformationDTO dto) throws Exception {

        Map map = new HashMap();
        map=egWorkTaskService.queryInfoExcel(request,dto);
        List ls = (List) map.get("rows");
        List<InformationDTO> datalist= new ArrayList<InformationDTO>();
        for (int i=0;i<ls.size();i++){
            InformationDTO dcv=(InformationDTO)ls.get(i);
            datalist.add(dcv);
        }
        new JcgzhbExcel().readWriters(datalist,request,response);

    }

}
