package com.askj.oa.service;

import com.askj.app.service.SjbService;
import com.askj.oa.dto.OameetingDTO;
import com.askj.oa.dto.OameetingtaskDTO;
import com.askj.oa.dto.OataskDTO;
import com.askj.oa.entity.*;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * OameetApiService的中文名称：【OA会议】api接口service
 * OameetApiService的描述：【OA会议】的方法集成
 *
 * @author ：syh
 */
public class OameetApiService extends BaseService {

    protected final Logger logger = Logger.getLogger(OameetApiService.class);

    @Inject
    private Dao dao;

    @Inject
    private SjbService sjbService;

    @Inject
    private OaNoticeManagerApiService oaNoticeManagerApiService;

    /**
     * 添加会议
     *
     * @param request
     * @param dto
     * @return
     */
    public String addOameet(HttpServletRequest request, OameetingDTO dto) {
        try {
            addOameetImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * 会议添加的实现
     *
     * @param request
     * @param dto
     */
    @Aop({"trans"})
    private void addOameetImp(HttpServletRequest request, OameetingDTO dto) throws Exception {
        String oameetingid = "";
        // 会议关联人
        Oameetingman oameetingman = new Oameetingman();
        // 会议
        Oameeting v_ot = new Oameeting();
        // 通知管理
        Oanoticemanager oanoticemanager = new Oanoticemanager();
        String currTime = SysmanageUtil.getDbtimeYmdHns();

        // 判断会议id是否为空，不为空进行修改操作，为空进行添加操作
        if (null != dto.getOameetingid() && !"".equals(dto.getOameetingid())) {
            Oameeting oameeting = dao.fetch(Oameeting.class, dto.getOameetingid());
            oameeting.setMettingcontent(dto.getMettingcontent()); // 会议内容
            oameeting.setStarttime(dto.getStarttime()); // 开始时间
            oameeting.setEndtime(dto.getEndtime()); // 结束时间
            oameeting.setMeetingplace(dto.getMeetingplace()); //会议地点
            oameeting.setMeetingstate(dto.getMeetingstate()); // 会议状态
            oameeting.setMeetingremindtime(dto.getMeetingremindtime());// 会议到期前提醒时间
            dao.update(oameeting);
            // 修改的时候添加参会人
            String chrUserid = request.getParameter("chrUserid");
            if (null != chrUserid && !"".equals(chrUserid)) {
                String[] chr = chrUserid.split(",");
                for (int i = 0; i < chr.length; i++) {
                    String oameetingmanid = DbUtils.getSequenceStr();
                    oameetingman.setOameetingmanid(oameetingmanid);
                    oameetingman.setOameetingid(dto.getOameetingid());
                    oameetingman.setCannotreason(dto.getCannotreason());
                    oameetingman.setUserid(chr[i]);
                    oameetingman.setAae011(dto.getAae011());
                    oameetingman.setMeetingmantype("2");
                    oameetingman.setHavereadflag("0");
                    oameetingman.setReceivedflag("0");
                    oameetingman.setMeetingsignflag("0");
                    oameetingman.setCompletestate("0");
                    oameetingman.setAae036(currTime);
                    dao.insert(oameetingman);
                    dto.setTxr(chr[i]);
                    dto.setOameetingmanid(oameetingmanid);
                    oaNoticeManagerApiService.OaNotice(request, dto, "2");
                }

            }
            // 修改记录人
            if (null != dto.getJlrUserid() && !"".equals(dto.getJlrUserid())) {
                dao.clear(Oameetingman.class, Cnd.where("oameetingid", "=", dto.getOameetingid()).
                        and("meetingmantype", "=", "1"));
                String jlrUserid = dto.getJlrUserid();
                String[] jlr = jlrUserid.split(",");
                for (int i = 0; i < jlr.length; i++) {
                    String oameetingmanid = DbUtils.getSequenceStr();
                    oameetingman.setOameetingmanid(oameetingmanid);
                    oameetingman.setOameetingid(dto.getOameetingid());
                    oameetingman.setCannotreason(dto.getCannotreason());
                    oameetingman.setUserid(jlr[i]);
                    oameetingman.setAae011(dto.getAae011());
                    oameetingman.setMeetingmantype("1");
                    oameetingman.setHavereadflag("0");
                    oameetingman.setReceivedflag("0");
                    oameetingman.setMeetingsignflag("0");
                    oameetingman.setCompletestate("0");
                    oameetingman.setAae036(currTime);
                    dao.insert(oameetingman);
                    dto.setTxr(jlr[i]);
                    dto.setOameetingmanid(oameetingmanid);
                    oaNoticeManagerApiService.OaNotice(request, dto, "2");
                }
            }
            // 判断人员类型'2'是参会人 '1'是记录人       修改记参会人的状态
            Oameetingman omman = dao.fetch(Oameetingman.class, Cnd.where("oameetingid", "=", dto.getOameetingid()).
                    and("userid", "=", dto.getUserid()));
            Oamatterdynamic oamatterdynamic = new Oamatterdynamic();
            // 查询出来当前操作人的姓名
            String sql = " SELECT s.DESCRIPTION FROM sysuser s WHERE s.USERID = '" + dto.getUserid() + "' ";
            String v_name = DbUtils.getOneValue(dao, sql);
            // 已读标志
            if (null != dto.getHavereadflag() && !"".equals(dto.getHavereadflag()) && !"1".equals(dto.getHavereadflag())) {
                if ("0".equals(omman.getHavereadflag())) {
                    oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                    oamatterdynamic.setOthertableid(dto.getOameetingid());
                    oamatterdynamic.setReplytype("0");
                    oamatterdynamic.setAae011("系统回复");
                    oamatterdynamic.setReplycontent(v_name + "已读");
                    oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                    dao.insert(oamatterdynamic);
                }
                omman.setHavereadflag("1");
                dao.update(omman);
            }
            // 确认收到标志
            if (null != dto.getReceivedflag() && !"".equals(dto.getReceivedflag()) && !"1".equals(dto.getReceivedflag())) {
                if ("0".equals(omman.getReceivedflag())) {
                    oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                    oamatterdynamic.setOthertableid(dto.getOameetingid());
                    oamatterdynamic.setReplytype("0");
                    oamatterdynamic.setAae011("系统回复");
                    oamatterdynamic.setReplycontent(v_name + "已收到");
                    oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                    dao.insert(oamatterdynamic);
                }
                omman.setReceivedflag("1");
                dao.update(omman);
            }
            // 会议签到标志
            if (null != dto.getMeetingsignflag() && !"".equals(dto.getMeetingsignflag()) && "0".equals(dto.getMeetingsignflag())) {
                if ("0".equals(omman.getMeetingsignflag())) {
                    oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                    oamatterdynamic.setOthertableid(dto.getOameetingid());
                    oamatterdynamic.setReplytype("0");
                    oamatterdynamic.setAae011("系统回复");
                    oamatterdynamic.setReplycontent(v_name + "已签到");
                    oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                    dao.insert(oamatterdynamic);
                }
                omman.setMeetingsignflag("1");
                dao.update(omman);
            }
            // 完成状态
            if (null != dto.getCompletestate() && !"".equals(dto.getCompletestate())) {
                if ("1".equals(dto.getCompletestate())) {
                    if ("0".equals(omman.getCompletestate())) {
                        oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                        oamatterdynamic.setOthertableid(dto.getOameetingid());
                        oamatterdynamic.setReplytype("0");
                        oamatterdynamic.setAae011("系统回复");
                        oamatterdynamic.setReplycontent(v_name + "已完成");
                        oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                        dao.insert(oamatterdynamic);
                    }
                    omman.setCompletestate("1");
                    dao.update(omman);
                } else if (null != dto.getCannotreason() && !"".equals(dto.getCannotreason())) {
                    if ("0".equals(omman.getCompletestate())) {
                        oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                        oamatterdynamic.setOthertableid(dto.getOameetingid());
                        oamatterdynamic.setReplytype("0");
                        oamatterdynamic.setAae011("系统回复");
                        oamatterdynamic.setReplycontent(v_name + "不能完成："+dto.getCannotreason());
                        oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                        dao.insert(oamatterdynamic);
                    }
                    omman.setCompletestate("2");
                    omman.setCannotreason(dto.getCannotreason());
                    dao.update(omman);
                }
            }
        } else {
            // 添加会议
            oameetingid = DbUtils.getSequenceStr();
            BeanHelper.copyProperties(dto, v_ot);
            v_ot.setOameetingid(oameetingid); // 会议id
            v_ot.setAae036(currTime);
            v_ot.setAae011(dto.getAae011());
            v_ot.setMeetingstate(dto.getMeetingstate());
            v_ot.setSfyx("1");
            v_ot.setNeedremindflag("1");
            dao.insert(v_ot);
            // 添加参会人（判断是否为空，不为空则添加参会人，为空则添加创建人为参会人）
            String chrUserid = request.getParameter("chrUserid");
            if (null != chrUserid && !"".equals(chrUserid)) {
                String[] chr = chrUserid.split(",");
                for (int i = 0; i < chr.length; i++) {
                    String oameetingmanid = DbUtils.getSequenceStr();
                    oameetingman.setOameetingmanid(oameetingmanid);
                    oameetingman.setOameetingid(oameetingid);
                    oameetingman.setCannotreason(dto.getCannotreason());
                    oameetingman.setUserid(chr[i]);
                    oameetingman.setAae011(dto.getAae011());
                    oameetingman.setMeetingmantype("2");
                    oameetingman.setHavereadflag("0");
                    oameetingman.setReceivedflag("0");
                    oameetingman.setMeetingsignflag("0");
                    oameetingman.setCompletestate("0");
                    oameetingman.setAae036(currTime);
                    dao.insert(oameetingman);
                    dto.setUserid(chr[i]);
                    dto.setOameetingmanid(oameetingmanid);
                    oaNoticeManagerApiService.OaNotice(request, dto, "2");
                }
            }
            // 添加记录人（判断是否为空，不为空则添加记录人，为空则添加创建人为记录人）
            String jlrUserid = request.getParameter("jlrUserid");
            if (null != jlrUserid && !"".equals(jlrUserid)) {
                String[] jlr = jlrUserid.split(",");
                for (int i = 0; i < jlr.length; i++) {
                    String oameetingmanid = DbUtils.getSequenceStr();
                    oameetingman.setOameetingmanid(oameetingmanid);
                    oameetingman.setOameetingid(oameetingid);
                    oameetingman.setCannotreason(dto.getCannotreason());
                    oameetingman.setUserid(jlr[i]);
                    oameetingman.setAae011(dto.getAae011());
                    oameetingman.setMeetingmantype("1");
                    oameetingman.setHavereadflag("0");
                    oameetingman.setReceivedflag("0");
                    oameetingman.setMeetingsignflag("0");
                    oameetingman.setCompletestate("0");
                    oameetingman.setAae036(currTime);
                    dao.insert(oameetingman);
                    dto.setUserid(jlr[i]);
                    dto.setOameetingmanid(oameetingmanid);
                    oaNoticeManagerApiService.OaNotice(request, dto, "2");
                }
            }
        }
        sjbService.jpushNotice(request);
    }

    /**
     * delOameet  删除会议
     *
     * @param request
     * @param dto
     * @return
     */
    public String delOameet(HttpServletRequest request, OameetingDTO dto) {
        try {
            if (null != dto.getOameetingid() && !"".equals(dto.getOameetingid())) {
                delOameetImp(request, dto);
            } else {
                return "没有接收到要删除的会议ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * delOameetImp    删除会议的实现
     *
     * @param request
     * @param dto
     */
    private void delOameetImp(HttpServletRequest request, OameetingDTO dto) {
        Oameeting oameeting = new Oameeting();
        oameeting = dao.fetch(Oameeting.class, Cnd.where("oameetingid", "=", dto.getOameetingid()));
        oameeting.setSfyx("0");
        oameeting.setMeetingstate("60");
        dao.update(oameeting);
    }

    /**
     * queryOameet    查询会议
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryOameet(OameetingDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT o.*,om.meetingmantype,om.meetingsignflag,om.havereadflag,om.receivedflag,om.completestate,om.cannotreason,om.remark, ");
        sb.append(" (SELECT a.AAA103 FROM aa10 a WHERE a.AAA100 = 'meetingremindtime' AND a.AAA102 = o.meetingremindtime) txsj, ");
        if (!"".equals(dto.getOameetingid()) && null != dto.getOameetingid()) {
            sb.append(" (SELECT count(oataskid) FROM oameetingtask omt WHERE omt.oameetingid= '" + dto.getOameetingid() + "') hyrwgs, ");
        }
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=o.aae011) username ");
        sb.append(" FROM oameeting o, oameetingman om ");
        sb.append(" WHERE o.oameetingid = om.oameetingid  ");
        if (!"".equals(dto.getAae011()) && null != dto.getAae011()) {
            sb.append(" and (o.aae011 = '" + dto.getAae011() + "' or om.userid = '" + dto.getAae011() + "')");
        }
        if (!"".equals(dto.getOameetingid()) && null != dto.getOameetingid()) {
            sb.append("     and o.oameetingid = '" + dto.getOameetingid() + "'");
        }
        if (!"".equals(dto.getCompletestate()) && null != dto.getCompletestate()) {
            sb.append(" and om.completestate = '" + dto.getCompletestate() + "'");
        }
        if (!"".equals(dto.getMeetingstate()) && null != dto.getMeetingstate()) {
            sb.append(" and o.meetingstate = '" + dto.getMeetingstate() + "'");
        }
        sb.append(" and o.sfyx = '1' ");
        sb.append("  GROUP BY o.oameetingid ");
        sb.append(" ORDER BY  o.oameetingid  DESC ");
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("sqlsqlsqlsql++++++++++++++++++++++++" + sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OameetingDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        // 查询会议任务
        List hyrw = null;
        if (!"".equals(dto.getOameetingid()) && null != dto.getOameetingid()) {
            if (ls != null && ls.size() > 0) {
                OameetingDTO oa = (OameetingDTO) ls.get(0);
                if (oa.getHyrwgs() > 0) {
                    StringBuffer sb1 = new StringBuffer();
                    sb1.append(" SELECT oa.taskcontent,oa.oataskid FROM oatask oa ");
                    sb1.append(" WHERE oa.oataskid in (SELECT o.oataskid FROM oameetingtask o WHERE o.oameetingid = :oameetingid ) ");
                    String[] ParaName2 = new String[]{"oameetingid"};
                    int[] ParaType2 = new int[]{Types.VARCHAR};
                    String sql2 = sb1.toString();
                    sql2 = QueryFactory.getSQL(sql2, ParaName2, ParaType2, dto, pd);
                    Map m2 = DbUtils.DataQuery(GlobalNames.sql, sql2, null, OataskDTO.class, pd.getPage(), pd.getRows());
                    hyrw = (List) m2.get(GlobalNames.SI_RESULTSET);
                }
            }
        }
        // 查询参会人和会议记录人（记录人为1，参会人为2）
        List rylx = null;
        if (!"".equals(dto.getOameetingid()) && null != dto.getOameetingid()) {
            StringBuffer str = new StringBuffer();
            str.append(" SELECT  o.userid,o.meetingmantype,o.meetingsignflag,");
            str.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=o.userid) username ");
            str.append(" FROM oameetingman o,oameeting oa WHERE oa.oameetingid = o.oameetingid ");
            str.append(" AND oa.oameetingid = :oameetingid");
            String[] ParaName3 = new String[]{"oameetingid"};
            int[] ParaType3 = new int[]{Types.VARCHAR};
            String sql3 = str.toString();
            sql3 = QueryFactory.getSQL(sql3, ParaName3, ParaType3, dto, pd);
            Map m3 = DbUtils.DataQuery(GlobalNames.sql, sql3, null, OameetingDTO.class, pd.getPage(), pd.getRows());
            rylx = (List) m3.get(GlobalNames.SI_RESULTSET);
        }
        Map map = new HashMap<Object, Object>();
        map.put("rows", ls);
        map.put("hyrw", hyrw);
        map.put("rylx", rylx);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * quxiaohuiyi   取消会议
     *
     * @param request
     * @param dto
     * @return
     */
    public String quxiaohuiyi(HttpServletRequest request, OameetingDTO dto) {
        try {
            quxiaohuiyiImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    public void quxiaohuiyiImp(HttpServletRequest request, OameetingDTO dto) throws Exception {
        Oameeting oameeting = new Oameeting();
        oameeting = dao.fetch(Oameeting.class, Cnd.where("oameetingid", "=", dto.getOameetingid()).
                and("aae011", "=", dto.getAae011()));
        oameeting.setMeetingstate(dto.getMeetingstate());
        oameeting.setMeetingcancelreason("会议取消："+dto.getMeetingcancelreason());
        dao.update(oameeting);
        Oamatterdynamic oamatterdynamic = new Oamatterdynamic();
        oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
        oamatterdynamic.setOthertableid(oameeting.getOameetingid());
        oamatterdynamic.setReplytype("0");
        oamatterdynamic.setAae011("系统回复");
        oamatterdynamic.setReplycontent("会议取消："+dto.getMeetingcancelreason());
        oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
        dao.insert(oamatterdynamic);
    }


}
