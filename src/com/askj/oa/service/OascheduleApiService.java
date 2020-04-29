package com.askj.oa.service;

import com.askj.app.service.SjbService;
import com.askj.oa.dto.OameetingDTO;
import com.askj.oa.dto.OascheduleDTO;
import com.askj.oa.dto.OataskDTO;
import com.askj.oa.entity.Oaschedule;
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
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 日程
 */
public class OascheduleApiService extends BaseService {

    protected final Logger logger = Logger.getLogger(OascheduleApiService.class);

    @Inject
    private Dao dao;
    @Inject
    private SjbService sjbService;
    @Inject
    private OaNoticeManagerApiService oaNoticeManagerApiService ;

    /**
     * 添加日程
     * @param request
     * @param dto
     * @return
     */
    public String addOaschedule(HttpServletRequest request, OascheduleDTO dto) {
        try {
            addOascheduleImp(request,dto);
        }catch (Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    public void addOascheduleImp(HttpServletRequest request,OascheduleDTO dto) throws Exception{
        String oascheduleid = "";
        Oaschedule oaschedule = new Oaschedule();
        String currTime = SysmanageUtil.getDbtimeYmdHns();
        if (null != dto.getOascheduleid() && !"".equals(dto.getOascheduleid())){
            Oaschedule os = dao.fetch(Oaschedule.class,dto.getOascheduleid());
            os.setSchedulecontent(dto.getSchedulecontent());// 日程内容
            os.setStarttime(dto.getStarttime());// 开始时间
            os.setEndtime(dto.getEndtime());// 结束时间
            os.setRemarks(dto.getRemarks());// 备注
            os.setNeedremindflag(dto.getNeedremindflag());// 到期是否提醒
            os.setRemindtype(dto.getRemindtype());// 到期提醒方式
            os.setScheduleremindtime(dto.getScheduleremindtime());// 日程到期提前提醒时间
            dao.update(os);
            oaNoticeManagerApiService.OaNotice(request,dto,"3");
        }else {
            Sysuser user = SysmanageUtil.getSysuser();
            oascheduleid = DbUtils.getSequenceStr();
            BeanHelper.copyProperties(dto, oaschedule);
            oaschedule.setOascheduleid(oascheduleid); // 日程id
            oaschedule.setAae036(currTime);// 创建时间
            oaschedule.setAae011(dto.getAae011());// 创建人
            oaschedule.setSfyx("1");
            dao.insert(oaschedule);
            dto.setOascheduleid(oascheduleid);
            oaNoticeManagerApiService.OaNotice(request,dto,"3");
        }
        sjbService.jpushNotice(request);
    }

    /**
     * 删除日程
     * @param request
     * @param dto
     * @return
     */
    public String delOaschedule(HttpServletRequest request, OascheduleDTO dto) {
        try {
            if (null != dto.getOascheduleid()){
            delOascheduleImp(request,dto);
            }else {
                return "没有接收到要删除的日程id！";
            }
        }catch (Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    public void delOascheduleImp(HttpServletRequest request,OascheduleDTO dto) throws Exception{
        Oaschedule oaschedule = new Oaschedule();
        oaschedule = dao.fetch(Oaschedule.class,Cnd.where("oascheduleid","=",dto.getOascheduleid()));
        oaschedule.setSfyx("0");
        dao.update(oaschedule);
    }



    /**
     * queryOascheduleList    查询日程(当前包含查询任务和会议)
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryOascheduleList(OascheduleDTO dto, PagesDTO pd) throws Exception {
        // 查询日程
        StringBuffer sb = new StringBuffer();
        sb.append(" select  oa.oascheduleid, oa.schedulecontent  from oaschedule oa");
        sb.append(" where 1 = 1 ");
        sb.append(" and oa.aae011 = :aae011");
//        sb.append(" and oa.endtime like '%"+dto.getRcsj()+"%' ");
        sb.append(" and (SELECT DATE_FORMAT(oa.starttime,'%Y-%m-%d')) <= '"+dto.getRcsj()+"'");
        sb.append(" and oa.endtime >= '"+dto.getRcsj()+"'");
        sb.append(" and oa.sfyx = '1' ");
        sb.append(" ORDER BY  oascheduleid  DESC ");
        String[] ParaName = new String[] { "aae011"};
        int[] ParaType = new int[] { Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("sqlsqlsqlsql++++++++++++++++++++++++"+sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OascheduleDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        // 查询会议
        StringBuffer sb1 = new StringBuffer();
        sb1.append(" select o.oameetingid, oa.mettingcontent  from oameeting oa,oameetingman o");
        sb1.append(" where 1 = 1");
        if (null != dto.getAae011() && !"".equals(dto.getAae011())){
            sb1.append(" and (oa.aae011 = '" + dto.getAae011() + "' or o.userid = '" + dto.getAae011() + "') ");
        }
        sb1.append(" and oa.starttime like '%"+dto.getRcsj()+"%' ");
        sb1.append(" AND o.oameetingid = oa.oameetingid ");
        sb1.append(" and oa.sfyx = '1' ");
        sb1.append(" GROUP BY o.oameetingid");
        String[] ParaName1 = new String[] {};
        int[] ParaType1 = new int[] {};
        String sql1 = sb1.toString();
        sql1 = QueryFactory.getSQL(sql1, ParaName1, ParaType1, dto, pd);
        System.out.println("sqlsqlsqlsql++++++++++++++++++++++++"+sql1);
        Map m1 = DbUtils.DataQuery(GlobalNames.sql, sql1, null, OameetingDTO.class, pd.getPage(), pd.getRows());
        List ls1 = (List) m1.get(GlobalNames.SI_RESULTSET);
        // 查询任务
        StringBuffer sb2 = new StringBuffer();
        sb2.append(" SELECT o.oataskid,oa.taskcontent FROM oataskman o ,oatask oa ");
        sb2.append(" where 1 = 1");
        if (null != dto.getAae011() && !"".equals(dto.getAae011())){
            sb2.append(" and (oa.aae011 = '" + dto.getAae011() + "' or o.userid = '" + dto.getAae011() + "') ");
        }
        sb2.append(" and oa.endtime like '%"+dto.getRcsj()+"%' ");
        sb2.append(" AND o.oataskid = oa.oataskid ");
        sb2.append(" and oa.sfyx = '1' ");
        sb2.append(" GROUP BY o.oataskid");
        String[] ParaName2 = new String[] {};
        int[] ParaType2 = new int[] {};
        String sql2 = sb2.toString();
        sql2 = QueryFactory.getSQL(sql2, ParaName2, ParaType2, dto, pd);
        System.out.println("sqlsqlsqlsql++++++++++++++++++++++++"+sql2);
        Map m2 = DbUtils.DataQuery(GlobalNames.sql, sql2, null, OataskDTO.class, pd.getPage(), pd.getRows());
        List ls2 = (List) m2.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap<Object, Object>();
        map.put("rows", ls);
        map.put("dthy",ls1);
        map.put("dtrw",ls2);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     *
     * @param dto
     * @param pd
     * @return
     */
    public Map queryOaschedule(OascheduleDTO dto, PagesDTO pd) throws Exception{
        StringBuffer sb = new StringBuffer();
        sb.append(" select oa.*,");
        sb.append(" (SELECT a.AAA103 FROM aa10 a WHERE a.AAA100 = 'scheduleremindtime' AND a.AAA102 = oa.scheduleremindtime) remindtime");
        sb.append("  from oaschedule oa ");
        sb.append(" where 1 = 1 ");
        sb.append(" and oa.aae011 = :aae011");
        sb.append(" and oa.oascheduleid = :oascheduleid ");
        sb.append(" and oa.sfyx = '1' ");
        sb.append(" ORDER BY  oascheduleid  DESC ");
        String[] ParaName = new String[] { "aae011","oascheduleid"};
        int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("sqlsqlsqlsql++++++++++++++++++++++++"+sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OascheduleDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap<Object, Object>();
        map.put("rows", ls);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
}
