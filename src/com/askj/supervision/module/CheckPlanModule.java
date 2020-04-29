package com.askj.supervision.module;

import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.supervision.dto.*;
import com.askj.supervision.entity.CheckGroup;
import com.askj.supervision.service.CheckPlanService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.ViewModel;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 检查计划管理Module
 *
 * @author Administrator
 */
@IocBean
@At("/supervision")
public class CheckPlanModule {
    protected final Logger logger = Logger.getLogger(CheckPlanModule.class);
    @Inject
    private CheckPlanService checkPlanService;

    /**
     * plansIndex的中文名称：检查计划管理初始化页面
     * <p/>
     * plansIndex的概要说明：
     *
     * @param request
     */
    @At
    @Ok("jsp:/jsp/supervision/contentPlanList.jsp")
    public void plansIndex(HttpServletRequest request) {
        // 页面初始化
    }

    /**
     * addPlansIndex的中文名称：增加计划信息页面
     * <p/>
     * addPlansIndex的概要说明：
     *
     * @param request
     */
    @At
    @Ok("jsp:/jsp/supervision/contentPlanForm.jsp")
    public void addPlansIndex(HttpServletRequest request) {
    }

    /**
     * updatePlansIndex的中文名称：修改计划信息页面
     * 附加逻辑 初始化时加载计划信息
     * <p/>
     * updatePlansIndex的概要说明：
     *
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    @At
    @Ok("jsp:/jsp/supervision/updatecontentPlan.jsp")
    public Object updatePlansIndex(HttpServletRequest request, ViewModel model, @Param("..") BscheckplanDTO dto) {
        Map map = new HashMap();
        try {

            //根据计划ID获取计划信息
            map = checkPlanService.getPlanByid(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * updatePlan的中文名称：修改执行项和计划信息
     * <p/>
     * updatePlan的概要说明：
     *
     * @param request
     */
    @At
    @Ok("json")
    public Object updatePlan(HttpServletRequest request, @Param("..") BscheckplanDTO dto, @Param("..") BscheckpicsetDTO itemDto) {
        return SysmanageUtil.execAjaxResult(checkPlanService.updateInfo(request, dto, itemDto));
    }

    /**
     * getqiyeType的中文名称：查询企业类别
     * <p/>
     * getqiyeType的概要说明：
     *
     * @param request
     */
    @SuppressWarnings("rawtypes")
    @At
    @Ok("json")
    public Object getqiyeType(HttpServletRequest request) {
        String type = request.getParameter("type");
        Map map = new HashMap();
        try {
            map = checkPlanService.getqiyeType(request, type);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }


    /**
     * 添加计划信息
     *
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object savePlan(HttpServletRequest request, @Param("..") BscheckplanDTO dto) throws Exception {

        //检查计划编号是否被占用
        int total = (Integer) checkPlanService.checkCode(request, dto).get("total");


        if (total > 0) {
            return SysmanageUtil.execAjaxResult("编号已被占用，请您在重新输入新的编号");
        }
        return SysmanageUtil.execAjaxResult(checkPlanService.savePlan(request, dto));
    }

    /**
     * 审核  @未用到
     */
    @At
    @Ok("json")
    public Object saveCheckPlan(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
        return SysmanageUtil.execAjaxResult(checkPlanService.saveCheckPlan(request, dto));
    }

    /**
     * 查询所有计划信息并分页显示
     *
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object queryPlan(HttpServletRequest request,
                            @Param("..") BscheckplanDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map mapc = new HashMap();
        try {
            mapc = checkPlanService.queryPlan(request, dto, pd);
            return SysmanageUtil.execAjaxResult(mapc, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(mapc, e);
        }
    }

    /**
     * 查询计划信息
     *
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @At
    @Ok("json")
    public Object queryPlanDTO(HttpServletRequest request,
                               @Param("..") BscheckplanDTO dto,
                               @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = checkPlanService.queryPlan(request, dto, pd);
            List list = (List) map.get("rows");
            BscheckplanDTO planDto = null;
            if (list != null && list.size() > 0) {
                planDto = (BscheckplanDTO) list.get(0);
            }
            map.put("data", planDto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }


    /**
     * 多级联动查询检查项信息
     *
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @At
    @Ok("json")
    public Object queryOnePlanDTO(HttpServletRequest request,
                                  @Param("..") CheckGroup dto) throws Exception {
        Map map = new HashMap();
        try {
            map = checkPlanService.queryOnePlan(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }


    /**
     * 查询执法项
     *
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @At
    @Ok("json")
    public Object queryThreePlanDTO(HttpServletRequest request,
                                    @Param("..") BscheckItemplanDTO dto,
                                    @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            pd.setPage(5);
            map = checkPlanService.queryItemPlans(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * 删除计划信息
     */
    @At
    @Ok("json")
    public Object delPlan(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
        // 删除
        return SysmanageUtil.execAjaxResult(checkPlanService.delPlan(request, dto));
    }

    /**
     * setPlanScope的中文名称: 设置执行范围信息
     * <p/>
     * setPlanScope的概要说明：
     *
     * @param request
     */
    @At
    @Ok("jsp:/jsp/supervision/contentPlanScope.jsp")
    public void setPlanScope(HttpServletRequest request) {
    }

    /**
     * getPlansByid的中文名称：得到计划关联的执行项
     * <p/>
     * getPlansByid的概要说明：
     *
     * @param request
     */
    @SuppressWarnings("rawtypes")
    @At
    @Ok("json")
    public Object getPlansByid(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
        Map map = new HashMap();
        try {
            map = checkPlanService.queryPlanByid(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * getPlansAndpidnameByid的中文名称：得到计划关联的执行项和父类的名称
     * <p/>
     * getPlansAndpidnameByid的概要说明：
     *
     * @param request
     */
    @SuppressWarnings("rawtypes")
    @At
    @Ok("json")
    public Object getPlansAndpidnameByid(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
//		String planid =request.getParameter("planid");
        Map map = new HashMap();
        try {
            map = checkPlanService.getPlansAndpidnameByid(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * getitemsByid的中文名称：查询执行项对象
     * <p/>
     * getitemsByid的概要说明：
     *
     * @param request
     */
    @SuppressWarnings("rawtypes")
    @At
    @Ok("json")
    public Object getitemsByid(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
//		String itemid =request.getParameter("itemid");
        Map map = new HashMap();
        try {
            map = checkPlanService.queryitemsByid(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * 查询编号唯一性
     *
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @At
    @Ok("json")
    public Object checkCode(HttpServletRequest request,
                            @Param("..") BscheckplanDTO dto) throws Exception {
        Map map = new HashMap();
        try {
            map = checkPlanService.checkCode(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }


    /*********计划项设置**********/

    /**
     * 添加基本信息
     * 完成的是注册功能
     */
    @At
    @Ok("json")
    public Object savePicset(HttpServletRequest request, @Param("..") BscheckpicsetDTO dto) {
        return SysmanageUtil.execAjaxResult(checkPlanService.savePicset(request, dto));
    }

    /**
     * queryTaskList的中文名称：根据检查计划查询分派任务
     * <p/>
     * queryTaskList的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zy
     */
    @At
    @Ok("json")
    public Object queryTaskList(HttpServletRequest request,
                                @Param("..") BschecktaskDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = checkPlanService.queryTaskList(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
//		return checkPlanService.queryTaskList(request, dto, pd);
    }

    /**
     * queryTaskObj的中文名称：查询检查任务详细信息
     * <p/>
     * queryTaskObj的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zy
     */

    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryTaskObj(HttpServletRequest request,
                               @Param("..") BschecktaskDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = checkPlanService.queryTaskList(request, dto, pd);
            List list = (List) map.get("rows");
            BschecktaskDTO taskDto = null;
            if (list != null && list.size() > 0) {
                taskDto = (BschecktaskDTO) list.get(0);
            }
            map.put("data", taskDto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * taskFormIndex的中文名称：任务信息页面
     * <p/>
     * taskFormIndex的概要说明：
     *
     * @param request Written by : zy
     */
    @At
    @Ok("jsp:/jsp/supervision/taskForm")
    public void taskFormIndex(HttpServletRequest request) {
    }

    /**
     * saveTask的中文名称：保存任务
     * <p/>
     * saveTask的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    @At
    @Ok("json")
    public Object saveTask(HttpServletRequest request, @Param("..") BschecktaskDTO dto) {
        return SysmanageUtil.execAjaxResult(checkPlanService.saveTask(request, dto));
    }

    /**
     * deleteTask的中文名称：删除任务
     * <p/>
     * deleteTask的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    @At
    @Ok("json")
    public Object deleteTask(HttpServletRequest request, @Param("..") BschecktaskDTO dto) {
        return SysmanageUtil.execAjaxResult(checkPlanService.deleteTask(request, dto));
    }

    /**
     * querySurpervisionCompany的中文名称：查询检查公司
     * <p/>
     * querySurpervisionCompany的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zy
     */
    @At
    @Ok("json")
    public Object querySupervisionCompany(HttpServletRequest request,
                                          @Param("..") BschecktaskdetailDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = checkPlanService.querySupervisionCompany(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
//		return checkPlanService.querySupervisionCompany(request, dto, pd);
    }

    /**
     * querySupervisionPerson的中文名称：查询检查人
     * <p/>
     * querySupervisionPerson的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zy
     */
    @At
    @Ok("json")
    public Object querySupervisionPerson(HttpServletRequest request,
                                         @Param("..") BschecktaskpersonDTO dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = checkPlanService.querySupervisionPerson(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
//		return checkPlanService.querySupervisionPerson(request, dto, pd);
    }

    /**
     * saveSuperVisionItem的中文名称：保存检查内容设置（检查公司，检查人员）
     * <p/>
     * saveSuperVisionItem的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    @At
    @Ok("json")
    public Object saveSuperVisionItem(HttpServletRequest request, @Param("..") BschecktaskDTO dto) {
        return SysmanageUtil.execAjaxResult(checkPlanService.saveSuperVisionItem(request, dto));
    }

    /**
     * selComByPlanIndex的中文名称：跳转到选择公司页面
     * <p/>
     * selComByPlanIndex的概要说明：
     *
     * @param request Written by : zy
     */
    @At
    @Ok("jsp:/jsp/supervision/selComByPlan")
    public void selComByPlanIndex(HttpServletRequest request) {
    }

    /**
     * queryComByPlan的中文名称：根据检查计划范围过滤公司
     * <p/>
     * queryComByPlan的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zy
     */
    @At
    @Ok("json")
    public Object queryComByPlan(HttpServletRequest request, @Param("..") PcompanyDTO dto,
                                 @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try {
            map = checkPlanService.queryComByPlan(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
//		return checkPlanService.queryComByPlan(request, dto, pd);
    }

    /**
     *
     * autoCreatePlans：自动创建检查计划
     *
     * @param request
     * @return
     * @throws Exception
     * Written by : zy
     */
    @At
    @Ok("json")
    public Object autoCreatePlans(HttpServletRequest request) {
        return SysmanageUtil.execAjaxResult(checkPlanService.autoCreatePlans(request));
    }

    /**
     *
     * autoCreatePlans：自动创建检查计划
     *
     * @param request
     * @return
     * @throws Exception
     * Written by : zy
     */
    @At
    @Ok("json")
    public Object autoCreatePlansTwo(HttpServletRequest request) {
        return SysmanageUtil.execAjaxResult(checkPlanService.autoCreatePlansTwo(request));
    }

}
