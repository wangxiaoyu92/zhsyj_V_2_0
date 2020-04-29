package com.askj.oa.service;

import com.askj.app.service.SjbService;
import com.askj.oa.dto.OamatterdynamicDTO;
import com.askj.oa.dto.OataskDTO;
import com.askj.oa.dto.OataskmanDTO;
import com.askj.oa.entity.*;
import com.lbs.leaf.util.BeanHelper;
import com.sun.org.apache.regexp.internal.RE;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.BaiduUtil;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * OataskApiService：【OA任务】api接口service
 * OataskApiService：【OA任务】的方法集成
 *
 * @author ：syh
 */
@IocBean
public class OataskApiService extends BaseService {
    protected final Logger logger = Logger.getLogger(OataskApiService.class);

    @Inject
    private Dao dao;

    @Inject
    private SjbService sjbService;

    @Inject
    private OaNoticeManagerApiService oaNoticeManagerApiService;


    /**
     * addOatask     添加任务的方法
     *
     * @param request
     * @param dto
     * @return
     */
    public String addOatask(HttpServletRequest request, OataskDTO dto) {
        try {
            addOataskImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void addOataskImp(HttpServletRequest request, OataskDTO dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oataskid = "";
        if (null != dto.getOataskid() && !"".equals(dto.getOataskid())) {
            Oatask oatask = dao.fetch(Oatask.class, dto.getOataskid());
            Oataskman oataskman = new Oataskman();
            BeanHelper.copyProperties(dto, oatask);
            oatask.setTaskcontent(dto.getTaskcontent()); // 任务内容
            oatask.setEndtime(dto.getEndtime()); // 结束时间
            oatask.setNeedremindflag(dto.getNeedremindflag()); // 到期是否提醒
            oatask.setRemindtype(dto.getRemindtype()); // 到期提醒方式
            oatask.setTaskremindtime(dto.getTaskremindtime()); // 到期提前提醒时间
            dao.update(oatask);

            // 添加执行人
            String zxrUserid = request.getParameter("zxrUserid");
            String[] zxr = zxrUserid.split(",");
            for (int i = 0; i < zxr.length; i++) {
                String oataskmanid = DbUtils.getSequenceStr();
                oataskman.setUserid(zxr[i]);
                oataskman.setTaskmantype(dto.getZxr());
                oataskman.setOataskmanid(oataskmanid);
                oataskman.setAae011(dto.getUserid());
                oataskman.setHavereadflag("0");
                oataskman.setReceivedflag("0");
                oataskman.setCompletestate("0");
                oataskman.setCannotreason(dto.getCannotreason());
                dao.insert(oataskman);
                dto.setTxr(zxr[i]);
                dto.setOataskmanid(oataskmanid);
                oaNoticeManagerApiService.OaNotice(request, dto, "1");
            }
            // 添加抄送人
            String csrUserid = request.getParameter("csrUserid");
            if (StringUtils.isNotBlank(csrUserid)) {
                String[] csr = csrUserid.split(",");
                for (int i = 0; i < csr.length; i++) {
                    String oataskmanid = DbUtils.getSequenceStr();
                    oataskman.setUserid(csr[i]);
                    oataskman.setTaskmantype(dto.getCsr());
                    oataskman.setOataskmanid(oataskmanid);
                    oataskman.setAae011(dto.getUserid());
                    oataskman.setHavereadflag("0");
                    oataskman.setReceivedflag("0");
                    oataskman.setCompletestate("0");
                    oataskman.setCannotreason(dto.getCannotreason());
                    dao.insert(oataskman);
                    dto.setTxr(csr[i]);
                    dto.setOataskmanid(oataskmanid);
                    oaNoticeManagerApiService.OaNotice(request, dto, "1");
                }
            }
        } else {
            // 添加任务
            String currTime = SysmanageUtil.getDbtimeYmdHns();
            // 任务表
            Oatask v_oatask = new Oatask();
            // 任务关联人表
            Oataskman v_oataskman = new Oataskman();
            // 会议表
            Oameeting v_oameeting = new Oameeting();
            // 会议纪要任务表
            Oameetingtask v_oameetingtask = new Oameetingtask();
            oataskid = DbUtils.getSequenceStr();
            BeanHelper.copyProperties(dto, v_oatask);
            v_oatask.setOataskid(oataskid);
            v_oatask.setParenttaskid(dto.getParenttaskid());
            v_oatask.setAae036(currTime);
            v_oatask.setAae011(dto.getAae011());
            v_oatask.setTasktype("0");//0文字，1语音
            v_oatask.setSfyx("1");//0wu 1you
            v_oatask.setTaskremindtime(dto.getTaskremindtime()); // 到期提前提醒时间
            dao.insert(v_oatask);

            // 添加会议纪要任务
            if (null != dto.getOameetingid() && !"".equals(dto.getOameetingid())) {
                v_oameetingtask.setOameetingtaskid(DbUtils.getSequenceStr());
                v_oameetingtask.setOameetingid(dto.getOameetingid());
                v_oameetingtask.setAae011(dto.getAae011());
                v_oameetingtask.setAae036(currTime);
                v_oameetingtask.setOataskid(oataskid);
                dao.insert(v_oameetingtask);
            }

            // 添加执行人
            String zxrUserid = request.getParameter("zxrUserid");
            if (null != zxrUserid && !"".equals(zxrUserid)) {
                String[] zxr = zxrUserid.split(",");
                for (int i = 0; i < zxr.length; i++) {
                    String oataskmanid = DbUtils.getSequenceStr();
                    v_oataskman.setUserid(zxr[i]);
                    v_oataskman.setTaskmantype(dto.getZxr());
                    v_oataskman.setOataskmanid(oataskmanid);
                    v_oataskman.setOataskid(oataskid);
                    v_oataskman.setAae011(dto.getUserid());
                    v_oataskman.setAae036(currTime);
                    v_oataskman.setHavereadflag("0");
                    v_oataskman.setReceivedflag("0");
                    v_oataskman.setCompletestate("0");
                    v_oataskman.setCannotreason(dto.getCannotreason());
                    dao.insert(v_oataskman);
                    dto.setTxr(zxr[i]);
                    dto.setOataskmanid(oataskmanid);
                    oaNoticeManagerApiService.OaNotice(request, dto, "1");
                }
            }
            // 添加抄送人
            String csrUserid = request.getParameter("csrUserid");
            if (StringUtils.isNotBlank(csrUserid)) {
                String[] csr = csrUserid.split(",");
                for (int i = 0; i < csr.length; i++) {
                    String oataskmanid = DbUtils.getSequenceStr();
                    v_oataskman.setUserid(csr[i]);
                    v_oataskman.setTaskmantype(dto.getCsr());
                    v_oataskman.setOataskmanid(oataskmanid);
                    v_oataskman.setOataskid(oataskid);
                    v_oataskman.setAae011(dto.getUserid());
                    v_oataskman.setAae036(currTime);
                    v_oataskman.setHavereadflag("0");
                    v_oataskman.setReceivedflag("0");
                    v_oataskman.setCompletestate("0");
                    v_oataskman.setCannotreason(dto.getCannotreason());
                    dao.insert(v_oataskman);
                    dto.setTxr(csr[i]);
                    dto.setOataskmanid(oataskmanid);
                    oaNoticeManagerApiService.OaNotice(request, dto, "1");
                }
            }
        }
        sjbService.jpushNotice(request);
    }

    /**
     * delOatask     删除任务
     *
     * @param request
     * @param dto
     * @return
     */
    public String delOatask(HttpServletRequest request, OataskDTO dto) {
        try {
            if (null != dto.getOataskid()) {
                delOataskImp(request, dto);
            } else {
                return "没有接收到要删除的任务id！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    private void delOataskImp(HttpServletRequest request, OataskDTO dto) {
        Oatask oatask = new Oatask();
        oatask = dao.fetch(Oatask.class, Cnd.where("oataskid", "=", dto.getOataskid()));
        oatask.setSfyx("0");
        dao.update(oatask);
    }

    /**
     * queryOatask    查询任务
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryOatask(OataskDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT oa.*, ");
        sb.append(" o.taskmantype,o.userid,o.havereadflag,o.receivedflag,o.tasktransferflag,o.cannotreason,o.remark,  ");
        sb.append(" (SELECT a.aaa103 FROM aa10 a WHERE a.AAA100 = 'COMPLETESTATE' AND a.AAA102 = o.completestate ) completestate, ");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=oa.aae011) username, ");
        sb.append(" (SELECT a.aaa103 FROM aa10 a WHERE a.AAA100 = 'TASKREMINDTIME' AND a.AAA102 = oa.taskremindtime )remindtime,");
        sb.append(" (SELECT count(oataskid) FROM oatask WHERE parenttaskid=oa.oataskid) zrwgs,");
        sb.append(" (SELECT count(oameetingid) FROM oameetingtask t WHERE t.oataskid= '" + dto.getOataskid() + "') hygs,");
        sb.append(" (SELECT oatask.taskcontent FROM oatask WHERE oataskid=oa.parenttaskid) parentcontent");
        sb.append("  FROM oatask oa,oataskman o ");
        sb.append("  WHERE oa.oataskid=o.oataskid ");
        if (!"".equals(dto.getAae011()) && null != dto.getAae011()) {
            sb.append(" and (oa.aae011 = '" + dto.getAae011() + "' or o.userid = '" + dto.getAae011() + "')");
        }
        if (!"".equals(dto.getOataskid()) && null != dto.getOataskid()) {
            sb.append("     and oa.oataskid = '" + dto.getOataskid() + "'");
        }
        if (!"".equals(dto.getCompletestate()) && null != dto.getCompletestate()) {
            sb.append(" and o.completestate = '" + dto.getCompletestate() + "'");
        }
        sb.append(" and oa.sfyx = '1' ");
        sb.append("  and 1=1 GROUP BY oa.oataskid ");
        sb.append(" ORDER BY  oa.oataskid  DESC ");

        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

        System.out.println("sqlsqlsqlsql++++++++++++++++++++++++" + sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OataskDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        // 查询子任务
        List ls2 = null;
        if (!"".equals(dto.getOataskid()) && null != dto.getOataskid()) {
            if (ls != null && ls.size() > 0) {
                OataskDTO oa = (OataskDTO) ls.get(0);
                if (oa.getZrwgs() > 0) {
                    StringBuffer str = new StringBuffer();
                    str.append(" SELECT oatask.taskcontent,oatask.oataskid FROM oatask  ");
                    str.append(" WHERE oataskid in (SELECT oataskid FROM oatask WHERE parenttaskid = :oataskid ) ");
                    String[] ParaName2 = new String[]{"oataskid"};
                    int[] ParaType2 = new int[]{Types.VARCHAR};
                    String sql2 = str.toString();
                    sql2 = QueryFactory.getSQL(sql2, ParaName2, ParaType2, dto, pd);
                    Map m2 = DbUtils.DataQuery(GlobalNames.sql, sql2, null, OataskDTO.class, pd.getPage(), pd.getRows());
                    ls2 = (List) m2.get(GlobalNames.SI_RESULTSET);
                }
            }
        }
        List ls3 = null;
        // 查询抄送人和执行人
        if (!"".equals(dto.getOataskid()) && null != dto.getOataskid()) {
            StringBuffer sb1 = new StringBuffer();
            sb1.append(" SELECT o.taskmantype, o.userid,o.completestate,");
            sb1.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=o.userid) username  ");
            sb1.append(" FROM oataskman o,oatask oa WHERE oa.oataskid = o.oataskid");
            sb1.append(" AND oa.oataskid = :oataskid");
            String[] ParaName3 = new String[]{"oataskid"};
            int[] ParaType3 = new int[]{Types.VARCHAR};
            String sql3 = sb1.toString();
            sql3 = QueryFactory.getSQL(sql3, ParaName3, ParaType3, dto, pd);
            Map m3 = DbUtils.DataQuery(GlobalNames.sql, sql3, null, OataskDTO.class, pd.getPage(), pd.getRows());
            ls3 = (List) m3.get(GlobalNames.SI_RESULTSET);
        }
        // 查询会议内容
        List ls4 = null;
        if (!"".equals(dto.getOataskid()) && null != dto.getOataskid()) {
            if (ls != null && ls.size() > 0) {
                OataskDTO oa = (OataskDTO) ls.get(0);
                if (oa.getHygs() > 0) {
                    StringBuffer sb4 = new StringBuffer();
                    sb4.append(" SELECT oa.oameetingid,oa.mettingcontent  ");
                    sb4.append(" FROM oameeting oa ");
                    sb4.append("  WHERE oameetingid IN (SELECT o.oameetingid FROM oameetingtask o WHERE o.oataskid = :oataskid )");
                    String[] ParaName4 = new String[]{"oataskid"};
                    int[] ParaType4 = new int[]{Types.VARCHAR};
                    String sql4 = sb4.toString();
                    sql4 = QueryFactory.getSQL(sql4, ParaName4, ParaType4, dto, pd);
                    Map m4 = DbUtils.DataQuery(GlobalNames.sql, sql4, null, OataskDTO.class, pd.getPage(), pd.getRows());
                    ls4 = (List) m4.get(GlobalNames.SI_RESULTSET);
                }
            }
        }
        Map map = new HashMap<Object, Object>();
        map.put("rows", ls);
        map.put("zrw", ls2);
        map.put("zxr", ls3);
        map.put("hynr", ls4);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    /**
     * TransferOatask  转交任务
     *
     * @param request
     * @param dto
     * @return
     */
    public String TransferOatask(HttpServletRequest request, OataskmanDTO dto) {
        try {
            TransferOataskImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    public void TransferOataskImp(HttpServletRequest request, OataskmanDTO dto) throws Exception {
        if (null != dto.getOataskid() && !"".equals(dto.getOataskid())) {
            // 将执行人修改为抄送人
            Oataskman taskman = dao.fetch(Oataskman.class, Cnd.where("oataskid", "=", dto.getOataskid()).
                    and("userid", "=", dto.getUserid()));
            taskman.setTaskmantype("1");
            taskman.setTasktransferflag("1");
            dao.update(taskman);
            // 添加执行人
            Oataskman oataskman = new Oataskman();
            String zxrUserid = request.getParameter("zxrUserid");
            String[] str = zxrUserid.split(",");
            for (int i = 0; i < str.length; i++) {
                BeanHelper.copyProperties(dto, oataskman);
                String oataskmanid = DbUtils.getSequenceStr();
                oataskman.setOataskmanid(oataskmanid);
                oataskman.setHavereadflag("0");
                oataskman.setReceivedflag("0");
                oataskman.setCompletestate("0");
                oataskman.setUserid(str[i]);
                oataskman.setTaskmantype("0");
                oataskman.setAae011(dto.getUserid());
                oataskman.setAae036(SysmanageUtil.getDbtimeYmdHns());
                dao.insert(oataskman);
                dto.setUserid(str[i]);
                dto.setOataskmanid(oataskmanid);
                oaNoticeManagerApiService.OaNotice(request, dto, "5");
            }

        }
    }

    /**
     * OataskDynamic  添加任务/会议动态
     *
     * @param request
     * @param dto
     * @return
     */
    public String OataskDynamic(HttpServletRequest request, OamatterdynamicDTO dto) {
        try {
            OataskDynamicImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    public void OataskDynamicImp(HttpServletRequest request, OamatterdynamicDTO dto) throws Exception {
        // 查询当前操作人
        String sql = " SELECT s.DESCRIPTION FROM sysuser s WHERE s.USERID = '" + dto.getAae011() + "' ";
        String v_name = DbUtils.getOneValue(dao, sql);
        String currTime = SysmanageUtil.getDbtimeYmdHns();
        Oamatterdynamic dynamic = new Oamatterdynamic();
        dynamic.setOthertableid(dto.getOthertableid());
        dynamic.setAae036(currTime);
        dynamic.setAae011(dto.getAae011());
        if (null != dto.getReplycontent() && !"".equals(dto.getReplycontent())) {
            dynamic.setReplycontent(v_name + "：" + dto.getReplycontent());
        } else {
            dynamic.setReplycontent(v_name + " 添加备注：" + dto.getRemark());
        }
        dynamic.setReplytype(dto.getReplytype());
        dynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
        dao.insert(dynamic);
        if (null != dto.getOataskid() && !"".equals(dto.getOataskid())){
            Oataskman oataskman = dao.fetch(Oataskman.class,Cnd.where("oataskid","=",dto.getOataskid())
                    .and("userid","=",dto.getAae011()));
            oataskman.setRemark(oataskman.getRemark()+";;"+dto.getRemark());
            dao.update(oataskman);
        }else {
            Oameetingman oameetingman = dao.fetch(Oameetingman.class,Cnd.where("oameetingid","=",dto.getOameetingid())
                    .and("userid","=",dto.getAae011()));
            oameetingman.setRemark(oameetingman.getRemark()+";;"+dto.getRemark());
            dao.update(oameetingman);
        }
    }

    /**
     * delOataskDynamic   删除任务/会议回复
     *
     * @param request
     * @param dto
     * @return
     */
    public String delOataskDynamic(HttpServletRequest request, OamatterdynamicDTO dto) {
        try {
            if (null != dto.getOthertableid()) {
                delOataskDynamicImp(request, dto);
            } else {
                return "没有接收到要删除的任务id！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    public void delOataskDynamicImp(HttpServletRequest request, OamatterdynamicDTO dto) {
        dao.clear(Oamatterdynamic.class, Cnd.where("oamatterdynamicid", "=", dto.getOamatterdynamicid()).
                and("othertableid", "=", dto.getOthertableid()).
                and("aae011", "=", dto.getAae011()));
    }

    /**
     * queryOataskDynamic   查询任务/会议回复
     *
     * @param dto
     * @param pd
     * @return
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryOataskDynamic(OamatterdynamicDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT o.* FROM oamatterdynamic o");
        sb.append(" WHERE o.replytype = :replytype");
        sb.append(" AND o.othertableid = :othertableid");
        sb.append(" ORDER BY o.aae036 DESC");
        String[] ParaName = new String[]{"replytype", "othertableid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("sqlsqlsqlsql++++++++++++++++++++++++" + sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OamatterdynamicDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap<Object, Object>();
        map.put("rows", ls);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * updateBZ       修改任务状态及其他
     *
     * @param request
     * @param dto
     * @return
     */
    public String updatezhuangtai(HttpServletRequest request, OataskmanDTO dto) {
        try {
            updatezhuangtaiImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @SuppressWarnings({"rawtypes"})
    @Aop({"trans"})
    public void updatezhuangtaiImpl(HttpServletRequest request, OataskmanDTO dto) throws Exception {
        Oataskman oataskman = new Oataskman();
        Oatask oatask = new Oatask();
        Oamatterdynamic oamatterdynamic = null;
        String v_sql = "select a.* from oataskman a where a.oataskid='" + dto.getOataskid() + "' and userid='" + dto.getAae011() +
                "' and taskmantype='" + dto.getTaskmantype() + "'";
        List<Oataskman> listman = (List<Oataskman>) DbUtils.getDataList(v_sql, Oataskman.class);
        if (listman != null && listman.size() > 0) {
            oataskman = listman.get(0);
        }

        // 查询出来当前操作人的姓名
        String sql = " SELECT s.DESCRIPTION FROM sysuser s WHERE s.USERID = '" + dto.getAae011() + "' ";
        String v_name = DbUtils.getOneValue(dao, sql);
        // 修改状态
        if (StringUtils.isNotEmpty(dto.getOataskid())) {
            // 已读标志
            if ("0".equals(oataskman.getHavereadflag())) {
                oamatterdynamic = new Oamatterdynamic();
                oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                oamatterdynamic.setOthertableid(dto.getOataskid());
                oamatterdynamic.setReplytype("0");
                oamatterdynamic.setAae011("系统回复");
                oamatterdynamic.setReplycontent(v_name + "已读");
                oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                dao.insert(oamatterdynamic);
                oataskman.setHavereadflag("1");
            }
            // 确认收到标志
            if ("0".equals(oataskman.getReceivedflag())) {
                oamatterdynamic = new Oamatterdynamic();
                oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                oamatterdynamic.setOthertableid(dto.getOataskid());
                oamatterdynamic.setReplytype("0");
                oamatterdynamic.setAae011("系统回复");
                oamatterdynamic.setReplycontent(v_name + "已收到");
                oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                dao.insert(oamatterdynamic);
                oataskman.setReceivedflag("1");
            }
            // 完成状态
            if (StringUtils.isNotEmpty(dto.getCompletestate())) {
                if ("1".equals(dto.getCompletestate())) {
                    if ("0".equals(oataskman.getCompletestate())) {
                        oamatterdynamic = new Oamatterdynamic();
                        oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                        oamatterdynamic.setOthertableid(dto.getOataskid());
                        oamatterdynamic.setReplytype("0");
                        oamatterdynamic.setAae011("系统回复");
                        oamatterdynamic.setReplycontent(v_name + "已完成");
                        oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                        dao.insert(oamatterdynamic);
                        oataskman.setCompletestate("1");
                    }
                } else {
                    if (null != dto.getCannotreason() && !"".equals(dto.getCannotreason())) {
                        if ("0".equals(oataskman.getCompletestate())) {
                            oamatterdynamic = new Oamatterdynamic();
                            oamatterdynamic.setOamatterdynamicid(DbUtils.getSequenceStr());
                            oamatterdynamic.setOthertableid(dto.getOataskid());
                            oamatterdynamic.setReplytype("0");
                            oamatterdynamic.setAae011("系统回复");
                            oamatterdynamic.setReplycontent(v_name + "不能完成：" + dto.getCannotreason());
                            oamatterdynamic.setAae036(SysmanageUtil.getDbtimeYmdHns());
                            dao.insert(oamatterdynamic);
                            oataskman.setCompletestate("2");
                            oataskman.setCannotreason(dto.getCannotreason());
                        }
                    }
                }
            }
            dao.update(oataskman);
        }
    }
}
