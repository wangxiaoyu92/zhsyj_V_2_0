package com.askj.oa.module;

import com.askj.oa.dto.OamatterdynamicDTO;
import com.askj.oa.dto.OataskDTO;
import com.askj.oa.dto.OataskmanDTO;
import com.askj.oa.entity.Oataskman;
import com.askj.oa.service.OataskApiService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.document.DocumentInfo;
import org.apache.log4j.Logger;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *  任务
 */
@At("api/oa/task")
@IocBean
public class OataskApiModule {

    protected final Logger logger = Logger.getLogger(OataskApiModule.class);

    @Inject
    private OataskApiService oataskApiService;

    /**
     * addOatask    添加任务/修改任务
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 69,
            name="addOatask",
            desc = "新增任务/修改任务",
            functiondesc = "新增任务/修改任务",
            author = "syh",
            params = " oataskid：任务id /" +
                    "parenttaskid：父任务id /" +
                    "tasktype：任务形式 /" +
                    "taskcontent：任务内容 /" +
                    "sendtype：发送方式 /" +
                    "endtime：截止时间 /" +
                    "needremindflag：到期是否提醒 /" +
                    "remindtype：到期提醒方式 /" +
                    "taskremindtime：到期前提醒时间 /" +
                    "zxrUserid：执行人id /" +
                    "csrUserid：抄送人id /" +
                    "taskmantype：执行人0/抄送人1 /" +
                    "aae011：操作人 /" +
                    "aae036：操作时间 /" ,
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date="2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Object addOatask(HttpServletRequest request, @Param("..")OataskDTO dto){
        Map<String, String> result = new HashMap<String, String>();
        try {
            String oataskid = oataskApiService.addOatask(request, dto);
            if (oataskid != null) {
                result.put("oataskid", oataskid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }

    /**
     * delOatask     删除任务
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 70,
            name = "delOatask",
            desc = "删除任务",
            functiondesc = "删除任务",
            author = "syh",
            params = " oataskid：任务id ，必填 /",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delOatask(HttpServletRequest request,@Param("..")OataskDTO dto){
        return SysmanageUtil.execAjaxResult(oataskApiService.delOatask(request,dto));
    }

    /**
     * queryOatask    查询任务
     * @param request
     * @param dto
     * @param pd
     * @return
     */
    @DocumentInfo(
            sort = 71,
            name = "queryOatask",
            desc = "查询任务",
            functiondesc = "查询任务",
            author = "syh",
            params = " completestate：完成状态 ，必填 / " +
                    "oataskid：任务id  /" +
                    "userid：执行人id/抄送人id /" +
                    "aae011：操作人 /" ,
            returndesc = "{\"total\":1,\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"taskmantype\":\"0\"," +
                    "\"userid\":\"2018042016201642299953242\"," +
                    "\"havereadflag\":\"1\"," +
                    "\"receivedflag\":\"1\"," +
                    "\"completestate\":\"已完成\"," +
                    "\"zrwgs\":0," +
                    "\"username\":\"中牟测试\"," +
                    "\"hygs\":0," +
                    "\"oataskid\":\"2018060508372829358832570\"," +
                    "\"tasktype\":\"0\"," +
                    "\"taskcontent\":\"开始大扫除\"," +
                    "\"sendtype\":\"1\"," +
                    "\"endtime\":\"2018-06-05 18:00:00\"," +
                    "\"needremindflag\":\"1\"," +
                    "\"remindtype\":\"1\"," +
                    "\"taskremindtime\":\"15\"," +
                    "\"aae011\":\"2018042016201642299953242\"," +
                    "\"aae036\":\"2018-06-05 08:39:53\"," +
                    "\"sfyx\":\"1\"}]}" ,
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryOatask(HttpServletRequest request, @Param("..")OataskDTO dto,
                              @Param("..")PagesDTO pd){
        Map map = new HashMap();
        try {
            int rows = pd.getPageSize() == 0 ? 10 : pd.getPageSize();
            pd.setRows(rows);
            map = oataskApiService.queryOatask(dto,pd);
            List ls = (List) map.get("rows");
            return SysmanageUtil.execAjaxResult(map, null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

    /**
     * TransferOatask  转交任务
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 72,
            name = "TransferOatask",
            desc = "转交任务",
            functiondesc = "转交任务",
            author = "syh",
            params = " oataskid：任务id ，必填 /" +
            "zxrUserid：执行人id" +
            "userid：执行人id" ,
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object TransferOatask(HttpServletRequest request, @Param("..")OataskmanDTO dto){
        Map<String, String> result = new HashMap<String, String>();
        try {
            String oataskid = oataskApiService.TransferOatask(request,dto);
            if (oataskid != null) {
                result.put("oataskid", oataskid);
            }
            return SysmanageUtil.execAjaxResult(result, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }

    }

    /**
     * OataskDynamic    添加任务/会议动态
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 73,
            name="OataskDynamic",
            desc = "新增任务/会议回复",
            functiondesc = "新增任务/会议回复",
            author = "syh",
            params = " oamatterdynamicid：oa任务动态id /" +
                    "othertableid：任务/会议id /" +
                    "replytype：回复类型 /" +
                    "replycontent：动态内容 /" +
                    "aae011：操作人 /" +
                    "aae036：操作时间 /" ,
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date="2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object OataskDynamic(HttpServletRequest request, @Param("..")OamatterdynamicDTO dto){
        Map map = new HashMap();
        try {
            String oataskid = oataskApiService.OataskDynamic(request,dto);
            return SysmanageUtil.execAjaxResult(map,null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

    /**
     * delOataskDynamic   删除任务/会议回复
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 74,
            name = "delOataskDynamic",
            desc = "删除任务/会议回复",
            functiondesc = "删除任务/会议回复",
            author = "syh",
            params = " oamatterdynamicid：oa任务动态id ，必填 /" +
                     " aae011：操作人id /",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delOataskDynamic(HttpServletRequest request,@Param("..")OamatterdynamicDTO dto){
        return SysmanageUtil.execAjaxResult(oataskApiService.delOataskDynamic(request,dto));
    }

    /**
     * queryOataskDynamic   查询任务/会议回复
     * @param request
     * @param dto
     * @param pd
     * @return
     */
    @DocumentInfo(
            sort = 75,
            name = "queryOatask",
            desc = "查询任务",
            functiondesc = "查询任务",
            author = "syh",
            params = " completestate：完成状态 ，必填 / " +
                    "oataskid：任务id  /" +
                    "userid：执行人id/抄送人id /" +
                    "aae011：操作人 /" ,
            returndesc = " {\"total\": 1,\n" +
                    "\"code\": \"0\",\n" +
                    "\"msg\": \"\",\n" +
                    "\"rows\": [{\n" +
                    "\"oamatterdynamicid\": \"2018060508412670941079448\",\n" +
                    "\"othertableid\": \"2018060508372829358832570\",\n" +
                    "\"replytype\": \"0\",\n" +
                    "\"replycontent\": \"中牟测试已完成\",\n" +
                    "\"aae011\": \"系统回复\",\n" +
                    "\"aae036\": \"2018-06-05 08:43:51\"}\n}" +
                    "]}" ,
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryOataskDynamic(HttpServletRequest request,@Param("..")OamatterdynamicDTO dto,
                                     @Param("..")PagesDTO pd){
        Map map = new HashMap();
        try {
            int rows = pd.getPageSize() == 0 ? 10 : pd.getPageSize();
            pd.setRows(rows);
            map = oataskApiService.queryOataskDynamic(dto,pd);
            List ls = (List) map.get("rows");
            return SysmanageUtil.execAjaxResult(map, null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

    /**
     * updateBZ       修改任务状态、已读标志、确认收到标志
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 76,
            name = "updatezhuangtai",
            desc = "修改状态",
            functiondesc = "修改状态",
            author = "syh",
            params = " oataskid：任务id ，必填 / " +
                    "taskmantype：人员类型 /" +
                    "userid：人员id /" +
                    "havereadflag：已读标志 /" +
                    "receivedflag：确认收到标志 /" +
                    "completestate：完成状态 /" +
                    "cannotreason：不能完成原因 /",
            returndesc = " {\"total\": 1,\n" +
                    "\"code\": \"0\",\n" +
                    "\"msg\": \"\",\n" +
                    "\"rows\": [{\n" +
                    "\"oamatterdynamicid\": \"2018060508412670941079448\",\n" +
                    "\"othertableid\": \"2018060508372829358832570\",\n" +
                    "\"replytype\": \"0\",\n" +
                    "\"replycontent\": \"中牟测试已完成\",\n" +
                    "\"aae011\": \"系统回复\",\n" +
                    "\"aae036\": \"2018-06-05 08:43:51\"}\n}" +
                    "]}" ,
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object updatezhuangtai(HttpServletRequest request,@Param("..")OataskmanDTO dto){
        Map map = new HashMap();
        try {
            String oataskid = oataskApiService.updatezhuangtai(request,dto);
            return SysmanageUtil.execAjaxResult(map,null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

}
