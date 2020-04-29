package com.askj.oa.module;

import com.askj.oa.dto.EgarchiveinfoDTO;
import com.askj.oa.dto.OameetingDTO;
import com.askj.oa.dto.OameetingtaskDTO;
import com.askj.oa.entity.Oameeting;
import com.askj.oa.service.OameetApiService;
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
 *  会议
 */
@At("api/oa/meet")
@IocBean
public class OameetApiModule {

    protected final Logger logger = Logger.getLogger(OameetApiModule.class);

    @Inject
    private OameetApiService oameetApiService;

    /**
     * addOameet   添加会议/修改会议
     * @param request
     * @param dto
     * @return
     * @user :syh
     */
    @DocumentInfo(
            sort = 77,
            name = "addOameet",
            desc = "增加/修改会议",
            functiondesc = "增加/修改会议",
            author = "syh",
            params = " oameetingid：会议id /" +
                    "mettingcontent：会议内容 /" +
                    "starttime：开始时间 /" +
                    "endtime：结束时间 /" +
                    "meetingplace：会议地点 /" +
                    "sendtype：发送方式 /" +
                    "remindtype：到期提醒方式 /" +
                    "meetingremindtime：到期提醒时间 /" +
                    "jlrUserid：记录人id /" +
                    "chrUserid：参会人id /" +
                    "rylx：人员类型 /" +
                    "userid：人员id /" +
                    "receivedflag：确认收到标志 /" +
                    "havereadflag：已读标志 /" +
                    "meetingsignflag：确认签到标志 /" +
                    "completestate：完成状态 /" +
                    "cannotreason：不能完成原因 /" +
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
    public Object addOameet(HttpServletRequest request, @Param("..")OameetingDTO dto){
        Map<String, String> result = new HashMap<String, String>();
        try {
            String oameetingid = oameetApiService.addOameet(request, dto);
            if (oameetingid != null) {
                result.put("oameetingid", oameetingid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }

    /**
     * delOameet    删除会议
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 78,
            name = "delOameet",
            desc = "删除会议",
            functiondesc = "删除会议",
            author = "syh",
            params = " oameetingid：会议id ，必填 /",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delOameet(HttpServletRequest request,@Param("..")OameetingDTO dto){
        return SysmanageUtil.execAjaxResult(oameetApiService.delOameet(request,dto));
    }

    /**
     *  queryOameet    查询会议
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @DocumentInfo(
            sort = 79,
            name = "queryOameet",
            desc = "查询会议",
            functiondesc = "查询会议",
            author = "syh",
            params = " completestate：完成状态 ，必填 / " +
                    "oameetingid：会议id  /" +
                    "userid：记录人id/参会人id /" +
                    "meetingstate：会议状态 /" +
                    "aae011：操作人 /" ,
            returndesc = "{\"total\": \"2\",\"code\": \"0\"msg\": \"\",\n" +
                    "   \"rows\": [{\n" +
                    "   \"havereadflag\": \"1\",\n" +
                    "   \"receivedflag\": \"1\",\n" +
                    "   \"meetingsignflag\": \"0\",\n" +
                    "   \"completestate\": \"0\",\n" +
                    "   \"username\": \"中牟测试\",\n" +
                    "   \"meetingmantype\": \"2\",\n" +
                    "   \"txsj\": \"提前15分钟\",\n" +
                    "   \"oameetingid\": \"2018060508513526173786278\",\n" +
                    "   \"mettingcontent\": \"点击才到家驰骋疆场\",\n" +
                    "   \"starttime\": \"2018-06-05 08:51:00\",\n" +
                    "   \"endtime\": \"2018-06-05 09:51:00\",\n" +
                    "   \"meetingplace\": \"\",\n" +
                    "   \"sendtype\": \"1\",\n" +
                    "   \"remindtype\": \"1\",\n" +
                    "   \"meetingremindtime\": \"15\",\n" +
                    "   \"meetingstate\": \"10\",\n" +
                    "   \"aae011\": \"2018042016201642299953242\",\n" +
                    "   \"aae036\": \"2018-06-05 08:54:00\",\n" +
                    "   \"sfyx\": \"1\"" +
                    "\n}]\n}" ,
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryOameet(HttpServletRequest request, @Param("..")OameetingDTO dto,
                              @Param("..")PagesDTO pd) throws Exception{
        Map map = new HashMap();
        try {
            int rows = pd.getPageSize() == 0 ? 10 : pd.getPageSize();
            pd.setRows(rows);
            map = oameetApiService.queryOameet(dto,pd);
            List ls = (List) map.get("rows");
            return SysmanageUtil.execAjaxResult(map, null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

    /**
     * quxiaohuiyi   取消会议
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 84,
            name = "quxiaohuiyi",
            desc = "取消会议",
            functiondesc = "取消会议",
            author = "syh",
            params = " oameetingid：会议id ，必填 /" +
                     " aae011：操作人id /" +
                     " meetingstate：会议状态 /" +
                     " meetingcancelreason：取消会议的原因 /" ,
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2018-06-05",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object quxiaohuiyi(HttpServletRequest request, @Param("..")OameetingDTO dto){
        Map map = new HashMap();
        try {
            String oameetingid = oameetApiService.quxiaohuiyi(request,dto);
            return SysmanageUtil.execAjaxResult(map,null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map,e);
        }
    }

}
