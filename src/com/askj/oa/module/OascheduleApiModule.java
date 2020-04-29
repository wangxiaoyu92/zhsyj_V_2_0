package com.askj.oa.module;

import com.askj.oa.dto.OascheduleDTO;
import com.askj.oa.service.OascheduleApiService;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.document.DocumentInfo;
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
 * 日程
 */
@At("/api/oa/schedule")
@IocBean
public class OascheduleApiModule {

    protected final Logger logger = Logger.getLogger(OascheduleApiModule.class);

    @Inject
    private OascheduleApiService oascheduleApiService;

    /**
     * 添加日程
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 80,
            name = "addOaschedule",
            desc = "增加/修改日程",
            functiondesc = "增加/修改日程",
            author = "syh",
            params = " oascheduleid：日程id /" +
                    "schedulecontent：日程内容 /" +
                    "starttime：日程开始时间 /" +
                    "endtime：日程结束时间 /" +
                    "needremindflag：到期是否提醒 /" +
                    "remindtype：到期提醒方式 /" +
                    "scheduleremindtime：日程到期提醒时间 /" +
                    "remarks：备注 /" +
                    "aae011：操作员id /" +
                    "aae036：操作时间 /",
            returndesc = "{ " +
                    "\"code\": 返回码, " +
                    "\"msg\": 返回信息, " +
                    "}",
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object addOaschedule(HttpServletRequest request,@Param("..")OascheduleDTO dto){
        Map<String, String> result = new HashMap<String, String>();
        try {
            String oascheduleid = oascheduleApiService.addOaschedule(request, dto);
            if (oascheduleid != null) {
                result.put("oascheduleid", oascheduleid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }

    /**
     * 删除日程
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 81,
            name = "delOaschedule",
            desc = "删除日程",
            functiondesc = "删除日程",
            author = "syh",
            params = " oascheduleid：日程id ，必填 /",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delOaschedule(HttpServletRequest request,@Param("..")OascheduleDTO dto){
        return SysmanageUtil.execAjaxResult(oascheduleApiService.delOaschedule(request,dto));
    }

    /**
     * queryOascheduleList    查询当前操作人的日程(当前包含查询任务和会议)
     * @param request
     * @param dto
     * @param pd
     * @return
     */
    @DocumentInfo(
            sort = 82,
            name = "queryOascheduleList",
            desc = "查询日程",
            functiondesc = "查询日程",
            author = "syh",
            params = " rcsj：日程时间 ，必填 / " +
                    "aae011：操作人id /" ,
            returndesc = "{ total\": 1,code\": \"0\",\n" +
                    "   \"dthy\": [{\n" +
                    "      \"oameetingid\": \"2018060508431608463149289\",\n" +
                    "      \"mettingcontent\": \"下午三点开会\"}, {\n" +
                    "      \"oameetingid\": \"2018060508513526173786278\",\n" +
                    "      \"mettingcontent\": \"点击才到家驰骋疆场\"}],\n" +
                    "   \"msg\": \"\",\n" +
                    "   \"dtrw\": [{\n" +
                    "      \"oataskid\": \"2018060508372829358832570\",\n" +
                    "      \"taskcontent\": \"开始大扫除\"}],\n" +
                    "   \"rows\": [{\n" +
                    "      \"oascheduleid\": \"2018060509223823167516558\",\n" +
                    "      \"schedulecontent\": \"反反复复反反复复\"\n" +
                    "   }]}" ,
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryOascheduleList(HttpServletRequest request, @Param("..")OascheduleDTO dto,
                                  @Param("..")PagesDTO pd){
        Map map = new HashMap();
        try {
            int rows = pd.getPageSize() == 0 ? 10 : pd.getPageSize();
            pd.setRows(rows);
            map = oascheduleApiService.queryOascheduleList(dto,pd);
            List ls = (List) map.get("rows");
            return SysmanageUtil.execAjaxResult(map, null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

    /**
     * queryOaschedule   查询单个或者当前操作人的日程
     * @param request
     * @param dto
     * @param pd
     * @return
     */
    @DocumentInfo(
            sort = 83,
            name = "queryOaschedule",
            desc = "查询单个日程",
            functiondesc = "查询单个日程",
            author = "syh",
            params = " oascheduleid：日程id ，必填 / " +
                    "aae011：操作人id /" ,
            returndesc = "\n" +
                    "{ \"total\": 1,\"code\": \"0\",\"msg\": \"\"," +
                    "    \"rows\": [{\n" +
                    "      \"remindtime\": \"提前15分钟\",\n" +
                    "      \"oascheduleid\": \"2018060509223823167516558\",\n" +
                    "      \"schedulecontent\": \"反反复复反反复复\",\n" +
                    "      \"starttime\": \"2018-06-05 09:22:00\",\n" +
                    "      \"endtime\": \"2018-06-05 10:22:00\",\n" +
                    "      \"needremindflag\": \"0\",\n" +
                    "      \"scheduleremindtime\": \"15\",\n" +
                    "      \"aae011\": \"2018042016201642299953242\",\n" +
                    "      \"aae036\": \"2018-06-05 09:25:03\",\n" +
                    "      \"remarks\": \"v刚刚古古怪怪\",\n" +
                    "      \"sfyx\": \"1\"\n" +
                    "   }]}" ,
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryOaschedule(HttpServletRequest request,@Param("..")OascheduleDTO dto,@Param("..")PagesDTO pd){
        Map map = new HashMap();
        try {
            int rows = pd.getPageSize() == 0 ? 10 : pd.getPageSize();
            pd.setRows(rows);
            map = oascheduleApiService.queryOaschedule(dto,pd);
            List ls = (List) map.get("rows");
            return SysmanageUtil.execAjaxResult(map, null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

}
