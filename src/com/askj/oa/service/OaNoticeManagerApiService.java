package com.askj.oa.service;

import com.askj.app.service.SjbService;
import com.askj.oa.dto.*;
import com.askj.oa.entity.*;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 *
 */
public class OaNoticeManagerApiService {

    protected final Logger logger = Logger.getLogger(OaNoticeManagerApiService.class);

    @Inject
    private Dao dao;

    @Inject
    private SjbService sjbService;


    public void OaNotice(HttpServletRequest request, Object obj, String noticetype) throws Exception {
        Oanoticemanager oanoticemanager = new Oanoticemanager();
        // 判断传递过来的noticetype是否为空
        if (null != noticetype && !"".equals(noticetype)) {
            // noticetype = 1 添加的是任务，=2添加的是会议，=3添加的是日程，=5转交任务添加的执行人
            if ("1".equals(noticetype)) {
                OataskDTO oataskDTO = (OataskDTO) obj;
                // 查询操作人的姓名
                Sysuser v_name = dao.fetch(Sysuser.class, oataskDTO.getAae011());
                oanoticemanager.setOanoticemanagerid(DbUtils.getSequenceStr());
                oanoticemanager.setNoticetype("1");
                oanoticemanager.setOthertableid(oataskDTO.getOataskmanid());
                oanoticemanager.setReceivemanid(oataskDTO.getTxr());
                oanoticemanager.setNoticecontent(oataskDTO.getTaskcontent());
                oanoticemanager.setHavereadflag("0");
                oanoticemanager.setSendflag("0");
                oanoticemanager.setSendokflag("0");
                oanoticemanager.setCzyid(oataskDTO.getAae011());
                oanoticemanager.setCzyname(v_name.getDescription());
                oanoticemanager.setAae036(oataskDTO.getAae036());
                oanoticemanager.setNoticetitle("任务提醒：您有新的任务！请注意查收");
                dao.insert(oanoticemanager);
            } else if ("2".equals(noticetype)) {
                OameetingDTO oameeting = (OameetingDTO) obj;
                // 查询操作人的姓名
                Sysuser v_name = dao.fetch(Sysuser.class, oameeting.getAae011());
                oanoticemanager.setOanoticemanagerid(DbUtils.getSequenceStr());
                oanoticemanager.setNoticetype("2");
                oanoticemanager.setOthertableid(oameeting.getOameetingmanid());
                oanoticemanager.setReceivemanid(oameeting.getUserid());
                oanoticemanager.setNoticecontent(oameeting.getMettingcontent());
                oanoticemanager.setHavereadflag("0");
                oanoticemanager.setSendflag("0");
                oanoticemanager.setSendokflag("0");
                oanoticemanager.setCzyid(oameeting.getAae011());
                oanoticemanager.setCzyname(v_name.getDescription());
                oanoticemanager.setAae036(oameeting.getAae036());
                oanoticemanager.setNoticetitle("会议提醒：您有新的会议！请注意查收");
                dao.insert(oanoticemanager);
            } else if ("3".equals(noticetype)) {
                OascheduleDTO oascheduleDTO = (OascheduleDTO) obj;
                // 查询操作人的姓名
                Sysuser v_name = dao.fetch(Sysuser.class, oascheduleDTO.getAae011());
                oanoticemanager.setOanoticemanagerid(DbUtils.getSequenceStr());
                oanoticemanager.setNoticetype("3");
                oanoticemanager.setOthertableid(oascheduleDTO.getOascheduleid());
                oanoticemanager.setReceivemanid(oascheduleDTO.getAae011());
                oanoticemanager.setNoticecontent(oascheduleDTO.getSchedulecontent());
                oanoticemanager.setHavereadflag("0");
                oanoticemanager.setSendflag("0");
                oanoticemanager.setSendokflag("0");
                oanoticemanager.setCzyid(oascheduleDTO.getAae011());
                oanoticemanager.setCzyname(v_name.getDescription());
                oanoticemanager.setAae036(oascheduleDTO.getAae036());
                oanoticemanager.setNoticetitle("日程提醒：您有新的日程！请注意查看");
                dao.insert(oanoticemanager);
            }
            if ("5".equals(noticetype)) {
                OataskmanDTO oataskmanDTO = (OataskmanDTO) obj;
                // 查询操作人的姓名
                Sysuser v_name = dao.fetch(Sysuser.class, oataskmanDTO.getUserid());
                oanoticemanager.setOanoticemanagerid(DbUtils.getSequenceStr());
                oanoticemanager.setNoticetype("1");
                oanoticemanager.setOthertableid(oataskmanDTO.getOataskmanid());
                oanoticemanager.setReceivemanid(oataskmanDTO.getUserid());
                oanoticemanager.setNoticecontent(oataskmanDTO.getTaskcontent());
                oanoticemanager.setHavereadflag("0");
                oanoticemanager.setSendflag("0");
                oanoticemanager.setSendokflag("0");
                oanoticemanager.setCzyid(oataskmanDTO.getUserid());
                oanoticemanager.setCzyname(v_name.getDescription());
                oanoticemanager.setAae036(oataskmanDTO.getAae036());
                oanoticemanager.setNoticetitle("任务提醒：您有新的任务！请注意查看");
                dao.insert(oanoticemanager);
            }
        }
    }

    public void getdsfs() throws Exception {


        String currTime = SysmanageUtil.getDbtimeYmdHns();
        // 任务
        String sql = "  SELECT a.oataskmanid othertableid, " +
                "  a.userid receivemanid, b.taskcontent noticecontent,b.oataskid oataskid " +
                "  FROM oataskman  a,oatask b  " +
                "  WHERE a.oataskid=b.oataskid  " +
                "  AND b.needremindflag = '1' " +
                "  AND a.completestate='0'  " +
                "  and b.remindtype='1' " +
                "  and b.sfyx='1'  " +
                "  AND DATE_ADD(b.endtime,INTERVAL 0-b.taskremindtime MINUTE)<=NOW(); ";
        List<OanoticemanagerDTO> list = (List<OanoticemanagerDTO>) DbUtils.getDataList(sql, OanoticemanagerDTO.class);
        Oanoticemanager manager = new Oanoticemanager();
        OanoticemanagerDTO dto = null;
        if (null != list && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                String oanoticemanagerid = DbUtils.getSequenceStr();
                dto = (OanoticemanagerDTO) list.get(i);
                manager.setOanoticemanagerid(oanoticemanagerid);
                manager.setNoticetype("1");
                manager.setReceivemanid(dto.getReceivemanid());
                manager.setOthertableid(dto.getOthertableid());
                manager.setNoticecontent(dto.getNoticecontent());
                manager.setHavereadflag("0");
                manager.setSendflag("0");
                manager.setSendokflag("0");
                manager.setCzyname("系统提示");
                manager.setAae036(currTime);
                manager.setNoticetitle("任务提醒：您有任务即将结束！");
                dao.insert(manager);
                Oatask oatask = dao.fetch(Oatask.class,dto.getOataskid());
                oatask.setNeedremindflag("0");
                dao.update(oatask);
            }
        }

        // 会议
        String sql1 = " SELECT a.oameetingmanid othertableid,a.userid receivemanid, " +
                "  b.mettingcontent noticecontent , b.oameetingid oameetingid " +
                "  FROM oameetingman a,oameeting b " +
                "  WHERE a.oameetingid = b.oameetingid " +
                "  AND a.completestate = '0' " +
                "  AND b.needremindflag = '1' " +
                "  AND b.sfyx = '1' " +
                "  AND b.remindtype = '1' " +
                "  AND DATE_ADD(b.starttime,INTERVAL 0-b.meetingremindtime MINUTE)<=NOW(); ";
        List<OanoticemanagerDTO> list1 = (List<OanoticemanagerDTO>) DbUtils.getDataList(sql1, OanoticemanagerDTO.class);
        Oanoticemanager manager1 = new Oanoticemanager();
        OanoticemanagerDTO dto1 = null;
        if (null != list1 && list1.size() > 0) {
            for (int i = 0; i < list1.size(); i++) {
                String oanoticemanagerid = DbUtils.getSequenceStr();
                dto1 = (OanoticemanagerDTO) list1.get(i);
                manager1.setOanoticemanagerid(oanoticemanagerid);
                manager1.setNoticetype("2");
                manager1.setReceivemanid(dto1.getReceivemanid());
                manager1.setOthertableid(dto1.getOthertableid());
                manager1.setNoticecontent(dto1.getNoticecontent());
                manager1.setHavereadflag("0");
                manager1.setSendflag("0");
                manager1.setSendokflag("0");
                manager1.setCzyname("系统提示");
                manager1.setAae036(currTime);
                manager1.setNoticetitle("会议提醒：您有会议即将开始！");
                dao.insert(manager1);
                Oameeting oameeting = dao.fetch(Oameeting.class,dto.getOameetingid());
                oameeting.setNeedremindflag("0");
                dao.update(oameeting);
            }
        }

        // 日程
        String sql2 = "SELECT o.oascheduleid othertableid,o.schedulecontent noticecontent, " +
                "  o.aae011 receivemanid  " +
                "  FROM oaschedule o " +
                "  WHERE o.needremindflag = '1' " +
                "  AND o.remindtype = '1' " +
                "  AND o.sfyx = '1' " +
                "  AND DATE_ADD(o.endtime,INTERVAL 0-scheduleremindtime MINUTE)=NOW() " +
                "  AND NOT exists (select 1 from oanoticemanager t " +
                "  where t.othertableid=o.oascheduleid and t.noticetype='4');";
        List<OanoticemanagerDTO> list2 = (List<OanoticemanagerDTO>) DbUtils.getDataList(sql2, OanoticemanagerDTO.class);
        Oanoticemanager manager2 = new Oanoticemanager();
        OanoticemanagerDTO dto2 = null;
        if (null != list2 && list2.size() > 0) {
            for (int i = 0; i < list2.size(); i++) {
                String oanoticemanagerid = DbUtils.getSequenceStr();
                dto2 = (OanoticemanagerDTO) list2.get(i);
                manager2.setOanoticemanagerid(oanoticemanagerid);
                manager2.setNoticetype("3");
                manager2.setReceivemanid(dto2.getReceivemanid());
                manager2.setOthertableid(dto2.getOthertableid());
                manager2.setNoticecontent(dto2.getNoticecontent());
                manager2.setHavereadflag("0");
                manager2.setSendflag("0");
                manager2.setSendokflag("0");
                manager2.setCzyname("系统提示");
                manager2.setAae036(currTime);
                manager2.setNoticetitle("日程提醒：您有日程即将结束！");
                dao.insert(manager2);
                Oaschedule oaschedule = dao.fetch(Oaschedule.class,dto.getOthertableid());
                oaschedule.setNeedremindflag("0");
                dao.update(oaschedule);
            }
        }
        sjbService.jpushNotice(null);
    }

    /**
     * 自动改变会议
     * @throws Exception
     */
    public void getjshy() throws Exception {
        String sql = "SELECT * FROM oameeting o WHERE o.endtime <= NOW() " +
                     "  AND o.meetingstate = 10;";
        List<Oameeting> list = DbUtils.getDataList(sql,Oameeting.class);
        Oameeting oameeting = new Oameeting();
        Oamatterdynamic oamatterdynamic = new Oamatterdynamic();
        if (null != list && list.size()>0 ){
            for (int i = 0 ; i < list.size() ; i++) {
                oameeting = list.get(i);
                oameeting.setMeetingstate("40");
                oameeting.setMeetingcancelreason("会议超时结束！");
                dao.update(oameeting);
                oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                oamatterdynamic.setOthertableid(oameeting.getOameetingid());
                oamatterdynamic.setReplytype("0");
                oamatterdynamic.setAae011("系统回复");
                oamatterdynamic.setReplycontent("会议超时结束！");
                oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                dao.insert(oamatterdynamic);
            }
        }
    }
}
