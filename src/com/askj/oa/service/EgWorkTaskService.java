package com.askj.oa.service;

import com.askj.app.service.SjbService;
import com.askj.baseinfo.service.pub.PubService;
import com.askj.oa.dto.*;
import com.askj.oa.entity.*;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysorg;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 *  EgWorkTaskService的中文名称：工作进度表
 *
 *  EgWorkTaskService的描述：
 *
 *  Written  by  : wcl
 */
public class EgWorkTaskService extends BaseService {
    protected final Logger logger = Logger.getLogger(EgWorkTaskService.class);

    @Inject
    private Dao dao;

    @Inject
    private PubService pubService;

    @Inject
    private OaNoticeManagerApiService oaNoticeManagerApiService;

    @Inject
    private SjbService sjbService;


    /**
     * queryWokeInfos的中文名称：工作台账表查询
     * <p>
     * queryWokeInfos的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryYearWorkTask(HttpServletRequest request, EgWorkTaskDTO dto, PagesDTO pd) throws Exception {
        // 获取用户id
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.orgid,a.work_task_no,a.work_task_content ");
        sb.append(" ,a.work_task_weight,a.work_task_step,DATE_FORMAT(a.work_task_st_date,'%m-%d-%Y') work_task_st_date,DATE_FORMAT(a.work_task_ed_date,'%m-%d-%Y') work_task_ed_date ");
        sb.append(" ,(select group_concat(description) from sysuser s where s.userid in (a.work_task_duty_person)) work_task_duty_person,(select group_concat(description) from sysuser s where s.userid in (a.work_task_duty_leader)) work_task_duty_leader, ");
        sb.append(" c.ORGNAME,us.* FROM eg_work_task a inner join sysorg c on a.orgid=c.ORGID   ");
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" and c.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        sb.append("left join (SELECT  e.work_task_id, \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"01\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms1\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"02\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms2\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"03\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms3\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"04\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms4\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"05\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms5\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"06\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms6\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"07\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms7\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"08\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms8\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"09\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms9\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"10\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms10\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"11\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms11\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"12\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms12\", " +
                "\n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"01\",e.work_schedule_percent,0)),'%') AS \"jd1\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"02\",e.work_schedule_percent,0)),'%') AS \"jd2\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"03\",e.work_schedule_percent,0)),'%') AS \"jd3\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"04\",e.work_schedule_percent,0)),'%') AS \"jd4\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"05\",e.work_schedule_percent,0)),'%') AS \"jd5\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"06\",e.work_schedule_percent,0)),'%') AS \"jd6\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"07\",e.work_schedule_percent,0)),'%') AS \"jd7\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"08\",e.work_schedule_percent,0)),'%') AS \"jd8\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"09\",e.work_schedule_percent,0)),'%') AS \"jd9\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"10\",e.work_schedule_percent,0)),'%') AS \"jd10\",  \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"11\",e.work_schedule_percent,0)),'%') AS \"jd11\", \n" +
                "CONCAT(SUM(IF(date_format(e.work_schedule_month,'%m')=\"12\",e.work_schedule_percent,0)),'%') AS \"jd12\"\n" +
                "FROM eg_work_schedule e   \n" +
                "GROUP BY e.work_task_id) us on a.work_task_id = us.work_task_id ");

        sb.append("  order by a.orgid desc ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
//        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgWorkTaskDTO.class, pd.getPage(), pd.getRows());


        Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, EgWorkTaskDTO.class,
                pd.getPage(), pd.getRows(), userid, "orgid");

        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryWorkTaskStat的中文名称：月度科室分任务统计图
     * <p>
     * queryWorkTaskStat的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryYearWorkTaskStat(HttpServletRequest request, EgWorkTaskDTO dto, PagesDTO pd) throws Exception {
        // 获取用户id
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.orgid,a.work_task_no,a.work_task_content,a.wcsx, ");
        sb.append(" a.work_task_weight,a.work_task_step,DATE_FORMAT(a.work_task_st_date,'%m-%d-%Y') work_task_st_date,DATE_FORMAT(a.work_task_ed_date,'%m-%d-%Y') work_task_ed_date ");
        sb.append(" ,(select group_concat(description) from sysuser s where s.userid in (a.work_task_duty_person)) work_task_duty_person,(select group_concat(description) from sysuser s where s.userid in (a.work_task_duty_leader)) work_task_duty_leader, ");
        sb.append(" c.ORGNAME,us.* FROM eg_work_task a inner join sysorg c on a.orgid=c.ORGID   ");
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" and c.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        sb.append("left join (SELECT  e.work_task_id, \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"01\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms1\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"02\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms2\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"03\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms3\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"04\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms4\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"05\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms5\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"06\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms6\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"07\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms7\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"08\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms8\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"09\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms9\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"10\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms10\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"11\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms11\", \n" +
                "GROUP_CONCAT(case when date_format(e.work_schedule_month,'%m')=\"12\" then e.work_schedule_describe else '' end SEPARATOR '') AS \"ms12\", " +
                "\n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"01\",e.work_schedule_percent,0)) AS \"jd1\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"02\",e.work_schedule_percent,0)) AS \"jd2\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"03\",e.work_schedule_percent,0)) AS \"jd3\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"04\",e.work_schedule_percent,0)) AS \"jd4\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"05\",e.work_schedule_percent,0)) AS \"jd5\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"06\",e.work_schedule_percent,0)) AS \"jd6\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"07\",e.work_schedule_percent,0)) AS \"jd7\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"08\",e.work_schedule_percent,0)) AS \"jd8\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"09\",e.work_schedule_percent,0)) AS \"jd9\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"10\",e.work_schedule_percent,0)) AS \"jd10\",  \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"11\",e.work_schedule_percent,0)) AS \"jd11\", \n" +
                "SUM(IF(date_format(e.work_schedule_month,'%m')=\"12\",e.work_schedule_percent,0)) AS \"jd12\"\n" +
                "FROM eg_work_schedule e   \n" +
                "GROUP BY e.work_task_id) us on a.work_task_id = us.work_task_id ");

        sb.append("  order by a.orgid desc ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
//        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgWorkTaskDTO.class, pd.getPage(), pd.getRows());


        Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, EgWorkTaskDTO.class,
                pd.getPage(), pd.getRows(), userid, "orgid");

        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    /**
     * queryMonthlyWorkTask的中文名称：年度工作台账表查询
     * <p>
     * queryMonthlyWorkTask的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryMonthlyWorkTask(HttpServletRequest request, EgWorkTaskDTO dto, PagesDTO pd) throws Exception {
        // 获取用户id
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sql = new StringBuffer();
       sql.append("SELECT a.work_task_id, a.orgid,a.work_task_no,a.work_task_content ");
        sql.append(" ,a.work_task_weight,a.work_task_step,a.wcsx, ");
        sql.append(" DATE_FORMAT(a.work_task_st_date,'%Y-%m-%d') work_task_st_date,   ");
        sql.append(" DATE_FORMAT(a.work_task_ed_date,'%Y-%m-%d') work_task_ed_date,   ");
        sql.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.work_task_duty_person)) work_task_duty_person,  ");
        sql.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.work_task_duty_leader)) work_task_duty_leader   ");
        sql.append(" ");
        sql.append(" ,c.ORGNAME,b.work_schedule_id,DATE_FORMAT(b.work_schedule_month,'%c') work_schedule_month,b.work_schedule_describe,concat(b.work_schedule_percent,'%') jd1,work_schedule_confirm ");
        sql.append(" FROM eg_work_task a inner join sysorg c on a.orgid=c.ORGID ");
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sql.append(" and c.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        sql.append("left join eg_work_schedule b on a.work_task_id=b.work_task_id  ");
        sql.append("where 1=1 ");
        if (dto.getStart() != null && !"".equals(dto.getStart())) {
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
        }

        /*sql.append("SELECT a.work_task_id, a.orgid,a.work_task_no,a.work_task_content ");
        sql.append(" ,a.work_task_weight,a.work_task_step,a.wcsx, ");
        sql.append(" DATE_FORMAT(a.work_task_st_date,'%Y-%m-%d') work_task_st_date,   ");
        sql.append(" DATE_FORMAT(a.work_task_ed_date,'%Y-%m-%d') work_task_ed_date,   ");
        sql.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.work_task_duty_person)) work_task_duty_person,  ");
        sql.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.work_task_duty_leader)) work_task_duty_leader   ");
        sql.append(" ");
        sql.append(" ,c.ORGNAME,");
        if (dto.getStart() != null && !"".equals(dto.getStart())) {
            sql.append(" (select b.work_schedule_id from eg_work_schedule b where a.work_task_id = b.work_task_id ");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
            sql.append("  ) work_schedule_id ,");
            sql.append(" (select DATE_FORMAT( b.work_schedule_month, '%c' ) from eg_work_schedule b where a.work_task_id = b.work_task_id ");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
            sql.append("  ) work_schedule_month,");
            sql.append(" (select b.work_schedule_describe from eg_work_schedule b where a.work_task_id = b.work_task_id");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
            sql.append("  ) work_schedule_describe,");
            sql.append(" (select concat( b.work_schedule_percent, '%' ) from eg_work_schedule b where a.work_task_id = b.work_task_id ");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
            sql.append("  ) jd1,");
            sql.append(" (select b.work_schedule_confirm from eg_work_schedule b where a.work_task_id = b.work_task_id ");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sql.append(" and DATE_FORMAT( b.work_schedule_month, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
            sql.append("  ) work_schedule_confirm");
        }else {
            sql.append(" (select b.work_schedule_id from eg_work_schedule b where a.work_task_id = b.work_task_id AND DATE_FORMAT( b.work_schedule_month, '%Y%m' ) = DATE_FORMAT( CURDATE( ), '%Y%m' ) ) work_schedule_id,");
            sql.append(" (select DATE_FORMAT( b.work_schedule_month, '%c' ) from eg_work_schedule b where a.work_task_id = b.work_task_id AND DATE_FORMAT( b.work_schedule_month, '%Y%m' ) = DATE_FORMAT( CURDATE( ), '%Y%m' ) ) work_schedule_month,");
            sql.append(" (select b.work_schedule_describe from eg_work_schedule b where a.work_task_id = b.work_task_id AND DATE_FORMAT( b.work_schedule_month, '%Y%m' ) = DATE_FORMAT( CURDATE( ), '%Y%m' ) ) work_schedule_describe,");
            sql.append(" (select concat( b.work_schedule_percent, '%' ) from eg_work_schedule b where a.work_task_id = b.work_task_id AND DATE_FORMAT( b.work_schedule_month, '%Y%m' ) = DATE_FORMAT( CURDATE( ), '%Y%m' ) ) jd1,");
            sql.append(" (select b.work_schedule_confirm from eg_work_schedule b where a.work_task_id = b.work_task_id AND DATE_FORMAT( b.work_schedule_month, '%Y%m' ) = DATE_FORMAT( CURDATE( ), '%Y%m' ) ) work_schedule_confirm");
        }
        sql.append(" FROM eg_work_task a inner join sysorg c on a.orgid=c.ORGID ");
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sql.append(" and c.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }

        sql.append("where 1=1 ");*/
        String sql1 = sql.toString();
        // 转化sql语句
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql1 = QueryFactory.getSQL(sql1, paramName, paramType, dto, pd);
//        Map m = DbUtils.DataQuery(GlobalNames.sql, sql1, null, EgWorkTaskDTO.class, pd.getPage(), pd.getRows());

        Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql1, null, EgWorkTaskDTO.class,
                pd.getPage(), pd.getRows(), userid, "orgid");
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    /**
     * saveTask的中文名称：工作台账表单保存
     * <p>
     * saveTask的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    public String saveTask(HttpServletRequest request, EgWorkTaskDTO dto) {
        try {
            saveTaskImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveSchedule的中文名称：工作进度表单保存
     * <p>
     * saveSchedule的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    public String saveSchedule(HttpServletRequest request, EgWorkScheduleDTO dto) {
        try {
            saveScheduleImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
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
    public String cxsbTask(HttpServletRequest request, EgWorkTaskDTO dto) {
        try {
            cxsbTaskImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * cxsbTaskImp的中文名称：重新上报工作台账
     * <p>
     * cxsbTaskImp的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop({"trans"})
    public void cxsbTaskImp(HttpServletRequest request, EgWorkTaskDTO dto)
            throws Exception {
        if (null != dto.getWorkScheduleId() && !"".equals(dto.getWorkScheduleId())) {
            EgWorkSchedule se = dao.fetch(EgWorkSchedule.class, dto.getWorkScheduleId());
            String confirm=se.getWorkScheduleConfirm();
            String s=confirm.substring(0,1);
            int a=Integer.valueOf(s);
            a=(a-1)*10+1;
            s=String.valueOf(a);
            se.setWorkScheduleConfirm(s);
            dao.update(se);
        }
    }
    /**
     * saveTaskImp的中文名称：工作台账表单保存
     * <p>
     * saveTaskImp的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop({"trans"})
    public void saveTaskImp(HttpServletRequest request, EgWorkTaskDTO dto)
            throws Exception {
        if (null != dto.getWorkTaskId() && !"".equals(dto.getWorkTaskId())) {
            //修改
            EgWorkTask se = dao.fetch(EgWorkTask.class, dto.getWorkTaskId());
            se.setWorkTaskNo(dto.getWorkTaskNo());
            se.setWorkTaskContent(dto.getWorkTaskContent());
            se.setWorkTaskWeight(dto.getWorkTaskWeight());
            se.setWorkTaskStep(dto.getWorkTaskStep());
            se.setWorkTaskStDate(dto.getWorkTaskStDate());
            se.setWorkTaskEdDate(dto.getWorkTaskEdDate());
            se.setWorkTaskDutyPerson((dto.getWorkTaskDutyPerson()).replaceAll(",", "\",\""));
            se.setWorkTaskDutyLeader(dto.getWorkTaskDutyLeader());
            se.setWcsx(dto.getWcsx());
            dao.update(se);
        } else {
            //新增
            Sysuser vSysUser = SysmanageUtil.getSysuser();
            EgWorkTask se = new EgWorkTask();
            BeanHelper.copyProperties(dto, se);
            se.setWorkTaskId(DbUtils.getSequenceStr());
            se.setOrgid(vSysUser.getOrgid());
            se.setWorkTaskNo(dto.getWorkTaskNo());
            se.setWorkTaskContent(dto.getWorkTaskContent());
            se.setWorkTaskWeight(dto.getWorkTaskWeight());
            se.setWorkTaskStep(dto.getWorkTaskStep());
            se.setWorkTaskStDate(dto.getWorkTaskStDate());
            se.setWorkTaskEdDate(dto.getWorkTaskEdDate());
            se.setWorkTaskDutyPerson(dto.getWorkTaskDutyPerson());
            se.setWorkTaskDutyLeader(dto.getWorkTaskDutyLeader());
            se.setWcsx(dto.getWcsx());
            dao.insert(se);
        }
    }

    /**
     * saveScheduleImp的中文名称：工作进度表单保存
     * <p>
     * saveScheduleImp的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop({"trans"})
    public void saveScheduleImp(HttpServletRequest request, EgWorkScheduleDTO dto)
            throws Exception {
        if (null != dto.getWorkScheduleId() && !"".equals(dto.getWorkScheduleId())) {
            //修改
            EgWorkSchedule se = dao.fetch(EgWorkSchedule.class, dto.getWorkScheduleId());
            if("view".equals(dto.getOp())) {
                se.setWorkScheduleDescribe(dto.getWorkScheduleDescribe());
                se.setWorkSchedulePercent(dto.getWorkSchedulePercent());
            }else if("shenhe".equals(dto.getOp())){
                se.setWorkScheduleDescribe(dto.getWorkScheduleDescribe());
                se.setWorkSchedulePercent(dto.getWorkSchedulePercent());
                Sysuser vSysUser = SysmanageUtil.getSysuser();
                Sysuser s = dao.fetch(Sysuser.class, vSysUser.getUserid());
                if("0".equals(dto.getWorkScheduleConfirm())){
                    se.setWorkScheduleConfirm(s.getUserposition() + "0");
                }else {
                    se.setWorkScheduleConfirm(s.getUserposition() + "1");
                }
            }else{
                se.setWorkScheduleDescribe(dto.getWorkScheduleDescribe());
                se.setWorkSchedulePercent(dto.getWorkSchedulePercent());
                if("0".equals(dto.getWorkScheduleConfirm())){
                    se.setWorkScheduleConfirm("60");
                }else {
                    se.setWorkScheduleConfirm("61");
                }
            }

            dao.update(se);
        } else {
            //新增
            Sysuser vSysUser = SysmanageUtil.getSysuser();
            Sysuser s = dao.fetch(Sysuser.class, vSysUser.getUserid());
            EgWorkSchedule se = new EgWorkSchedule();
            BeanHelper.copyProperties(dto, se);
            se.setWorkScheduleId(DbUtils.getSequenceStr());
            se.setWorkTaskId(dto.getWorkTaskId());
            se.setWorkSchedulePercent(dto.getWorkSchedulePercent());
            se.setWorkScheduleDescribe(dto.getWorkScheduleDescribe());
            if(s.getUserposition()==null){
                se.setWorkScheduleConfirm("11");
            }else {
                se.setWorkScheduleConfirm(s.getUserposition() + "1");
            }
            se.setWorkScheduleMonth(new Date());
            dao.insert(se);
        }
    }

    /**
     * queryWorkTask的中文名称：查询单个工作台账
     * <p>
     * queryWorkTask的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings("rawtypes")
    public Map queryWorkTask(HttpServletRequest request, EgWorkTaskDTO dto)
            throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.work_task_id,a.work_task_no,a.work_task_content,a.work_task_weight,a.work_task_step,a.work_task_duty_person,a.work_task_duty_leader,a.wcsx, ");
        sb.append(" DATE_FORMAT(a.work_task_st_date,'%Y-%m-%d %h:%i:%s') work_task_st_date,   ");
        sb.append(" DATE_FORMAT(a.work_task_ed_date,'%Y-%m-%d %h:%i:%s') work_task_ed_date,   ");
        sb.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.work_task_duty_person)) orgid, ");
        sb.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.work_task_duty_leader)) orgname ");
        sb.append("  from eg_work_task a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.work_task_id = :workTaskId ");
        String sql = sb.toString();
        String[] ParaName = new String[]{"workTaskId"};
        int[] ParaType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgWorkTaskDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        return r;
    }

    /**
     * queryWorkSchedule的中文名称：查询当月工作进度
     * <p>
     * queryWorkSchedule的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings("rawtypes")
    public Map queryWorkSchedule(HttpServletRequest request, EgWorkScheduleDTO dto)
            throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select * from ");
        sb.append("  eg_work_schedule a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.work_task_id = :workTaskId ");
        sb.append("  and date_format(work_schedule_month,'%Y-%m')=date_format(now(),'%Y-%m')  ");
        /*sb.append("  order by work_schedule_month asc limit 1");*/
        String sql = sb.toString();
        String[] ParaName = new String[]{"workTaskId"};
        int[] ParaType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgWorkScheduleDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        Sysuser vSysUser = SysmanageUtil.getSysuser();
        Sysuser s = dao.fetch(Sysuser.class, vSysUser.getUserid());
        if(s.getUserposition()==null){
            r.put("userposition", "1");
        }else {
            r.put("userposition", s.getUserposition());
        }
        return r;
    }

    /**
     * delTask的中文名称：删除工作台账
     * <p>
     * delTask的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    public String delTask(HttpServletRequest request, EgWorkTaskDTO dto) {
        try {
            if (null != dto.getWorkTaskId()) {
                delTaskImp(request, dto);
            } else {
                return "没有接收到要删除的工作台账ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * delTaskImp的中文名称：删除工作台账
     * <p>
     * delTaskImp的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop({"trans"})
    public void delTaskImp(HttpServletRequest request, EgWorkTaskDTO dto) {
        // 删除工作台账
        dao.clear(EgWorkTask.class, Cnd.where("workTaskId", "=", dto.getWorkTaskId()));
        dao.clear(EgWorkSchedule.class, Cnd.where("workTaskId", "=", dto.getWorkTaskId()));
    }


    /**
     * queryWokeInfos的中文名称：工作台账表查询
     * <p>
     * queryWokeInfos的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryYearWorkTaskbar(HttpServletRequest request, EgWorkTaskDTO dto, PagesDTO pd) throws Exception {
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append("select s.ORGID, s.ORGNAME,DATE_FORMAT(es.work_schedule_month,'%c') work_schedule_month,\n" +
                "round(sum(IFNULL(es.work_schedule_percent,0)*e.work_task_weight/(select sum(work_task_weight) from eg_work_task where orgid = e.orgid))) work_schedule_percent\n" +
                "from eg_work_task e\n" +
                "inner join sysorg s on e.orgid = s.ORGID  \n" +
                "inner join eg_work_schedule es on e.work_task_id = es.work_task_id \n" +
                "group by e.orgid,DATE_FORMAT(es.work_schedule_month,'%Y-%m');");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgWorkTaskDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    /**
     * queryWokeInfos的中文名称：工作台账表查询
     * <p>
     * queryWokeInfos的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryDepartment(HttpServletRequest request, Sysorg dto, PagesDTO pd) throws Exception {

        // 获取用户id
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        StringBuffer sb = new StringBuffer();


        sb.append(" SELECT a.ORGID,a.ORGNAME,a.ORGDESC,a.PARENT,a.ADDRESS  FROM sysorg a where 1=1");
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" and a.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
//        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgWorkTaskDTO.class, pd.getPage(), pd.getRows());
        Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, EgWorkTaskDTO.class,
                pd.getPage(), pd.getRows(), userid, "orgid");

        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    /**
     * queryInfo中文名称:查询信息管理
     * queryInfo概要描述:
     * written by  :  wcl
     *
     * @throws Exception
     */
    public Map queryInfo(HttpServletRequest request, InformationDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT  ");
        sb.append(" b.orgname,i.infoid ,i.linkaddress,i.content,i.orgid,i.adopt FROM information i,sysorg b  ");
        sb.append(" where 1=1 and i.orgid=b.ORGID ");
        if (dto.getOrgid() != null && !"".equals(dto.getOrgid())) {
            sb.append(" and i.orgid = '").append(dto.getOrgid()).append("' "); // 所属科室
        }
        if ("2018041116595219871214327".equals(vSysUser.getOrgid())) {

        }else{
            sb.append(" and i.orgid = '").append(vSysUser.getOrgid()).append("' ");
        }
        sb.append(" order by i.infoid desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, InformationDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    public Map queryW(HttpServletRequest request, WorksbDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.worksbid,a.content,DATE_FORMAT(a.time,'%Y-%m-%d %h:%i:%s') time,a.fzr,(select c.description from sysuser c where c.userid=a.userid) name,");
        sb.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.fzr)) cyry ");
        sb.append(" from worksb a  ");
        sb.append(" where 1=1  ");
        sb.append(" and a.userid = '").append(vSysUser.getUserid()).append("' ");
        sb.append("  and a.worksbid = :worksbid ");
        sb.append(" order by a.time desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"worksbid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, WorksbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    public Map queryW1(HttpServletRequest request, WorksbDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.worksbid,a.content,DATE_FORMAT(a.time,'%Y-%m-%d %h:%i:%s') time,a.fzr,(select c.description from sysuser c where c.userid=a.userid) name,");
        sb.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.fzr)) cyry ");
        sb.append(" from worksb a  ");
        sb.append(" where 1=1  ");
        sb.append("  and a.worksbid = :worksbid ");
        sb.append("  and a.userid is null ");
        sb.append(" order by a.time desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"worksbid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, WorksbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    public Map queryWa(HttpServletRequest request, WorksbDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.worksbid,a.content,DATE_FORMAT(a.time,'%Y-%m-%d %h:%i:%s') time,a.fzr,(select c.description from sysuser c where c.userid=a.userid) name,a.userid userid,");
        sb.append(" (select group_concat(description) from sysuser s where FIND_IN_SET(s.userid ,a.fzr)) cyry ");
        sb.append(" from worksb a  ");
        sb.append(" where 1=1  ");
        sb.append("  and a.worksbid = :worksbid ");
        sb.append(" order by a.time desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"worksbid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, WorksbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryInfoObj的中文名称：查询信息
     * <p>
     * queryInfoObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : wcl
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryInfoObj(HttpServletRequest request, InformationDTO dto) throws Exception {
        String id = dto.getInfoid();
        Information info = dao.fetch(Information.class, dto.getInfoid());
        Map map = new HashMap();
        map.put("Info", info); // 详情信息
        return map;
    }

    /**
     * saveInfo的中文名称：保存信息
     * <p>
     * saveInfo的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : wcl
     */
    public String saveInfo(HttpServletRequest request, InformationDTO dto) {
        try {
            saveInfoImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    public String saveSb(HttpServletRequest request, WorksbDTO dto) {
        try {
            saveSbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }


    @Aop({"trans"})
    public void saveSbImp(HttpServletRequest request,WorksbDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
        // 对信息保存
        // 如果id存在，更新
        if (dto.getWorksbid() != null && !"".equals(dto.getWorksbid())) {
            Worksb v_info = dao.fetch(Worksb.class, dto.getWorksbid());
            v_info.setContent(dto.getContent());
            v_info.setTime(dto.getTime());
            v_info.setFzr(dto.getFzr());
            dao.update(v_info);
        } else {
            Worksb v_info = new Worksb();
            v_info.setWorksbid(dto.getId());
            v_info.setContent(dto.getContent());
            v_info.setTime(dto.getTime());
            v_info.setFzr(dto.getFzr());
            v_info.setUserid(vSysUser.getUserid());
            dao.insert(v_info);
        }

    }

    public String saveSbnew(HttpServletRequest request, WorksbDTO dto) {
        try {
            saveSbImpnew(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }


    @Aop({"trans"})
    public void saveSbImpnew(HttpServletRequest request,WorksbDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
        // 对信息保存
        // 如果id存在，更新
        if (dto.getWorksbid() != null && !"".equals(dto.getWorksbid())) {
            Worksb v_info = dao.fetch(Worksb.class, dto.getWorksbid());
            v_info.setContent(dto.getContent());
            v_info.setTime(dto.getTime());
            v_info.setFzr(dto.getFzr());
            dao.update(v_info);
        } else {
            Worksb v_info = new Worksb();
            v_info.setWorksbid(dto.getId());
            v_info.setContent(dto.getContent());
            v_info.setTime(dto.getTime());
            v_info.setFzr(dto.getFzr());
            dao.insert(v_info);
        }

    }

    /**
     * saveInfoImp的中文名称：保存信息方法实现
     * <p>
     * saveInfoImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : wcl
     */
    @Aop({"trans"})
    public void saveInfoImp(HttpServletRequest request, InformationDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
        // 对信息保存
        // 如果id存在，更新
        if (dto.getInfoid() != null && !"".equals(dto.getInfoid())) {
            Information v_info = dao.fetch(Information.class, dto.getInfoid());
            v_info.setOrgid(dto.getOrgid());
            v_info.setAdopt(dto.getAdopt());
            v_info.setContent(dto.getContent());
            v_info.setOrgname(dto.getOrgname());
            v_info.setLinkaddress(dto.getLinkaddress());
            dao.update(v_info);
        } else {
            Information v_info = new Information();
            v_info.setInfoid(dto.getId());
            v_info.setOrgid(dto.getOrgid());
            v_info.setAdopt(dto.getAdopt());
            v_info.setContent(dto.getContent());
            v_info.setOrgname(dto.getOrgname());
            v_info.setLinkaddress(dto.getLinkaddress());
            v_info.setReportTime(v_dbDatetime);
            dao.insert(v_info);
        }

    }


    /**
     * delInfo的中文名称：删除信息
     * <p>
     * delInfo的概要说明：
     *
     * @param request
     * @return Written by : wcl
     */
    public String delInfo(HttpServletRequest request, InformationDTO dto) {
        try {
            delInfoImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }


    public String delW(HttpServletRequest request, WorksbDTO dto) {
        try {
            delWImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * delInfoImp的中文名称：删除信息方法实现
     * <p>
     * delInfoImp的概要说明：
     *
     * @param request
     * @throws Exception Written by : wcl
     */
    @Aop({"trans"})
    public void delInfoImp(HttpServletRequest request, InformationDTO dto) throws Exception {
        String id = dto.getInfoid();
        if (dto.getInfoid() != null && !"".equals(dto.getInfoid())) {
            //删除信息附件
            pubService.delFjFromFjwid(request, dto.getInfoid());
            dao.clear(Information.class, Cnd.where("infoid", "=", dto.getInfoid()));
        }
    }

    @Aop({"trans"})
    public void delWImp(HttpServletRequest request, WorksbDTO dto) throws Exception {
        String id = dto.getWorksbid();

            dao.clear(Worksb.class, Cnd.where("worksbid", "=", id));

    }

    /**
     * delInfo的中文名称：采纳
     * <p>
     * delInfo的概要说明：
     *
     * @param request
     * @return Written by : wcl
     */
    public String adoptInfo(HttpServletRequest request, InformationDTO dto) {
        try {
            adoptInfoImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * adoptInfoImp的中文名称：采纳
     * <p>
     * adoptInfoImp的概要说明：
     *
     * @param request
     * @throws Exception Written by : wcl
     */
    @Aop({"trans"})
    public void adoptInfoImp(HttpServletRequest request, InformationDTO dto) throws Exception {
        Information v_info = dao.fetch(Information.class, dto.getInfoid());
        v_info.setAdopt("2");
        dao.update(v_info);
    }


    /**
     * linkInfo的中文名称：采纳地址
     * <p>
     * linkInfo的概要说明：
     *
     * @param request
     * @return Written by : wcl
     */
    public String linkInfo(HttpServletRequest request, InformationDTO dto) {
        try {
            linkInfoImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * linkInfoImp的中文名称：采纳链接
     * <p>
     * linkInfoImp的概要说明：
     *
     * @param request
     * @throws Exception Written by : wcl
     */
    @Aop({"trans"})
    public void linkInfoImp(HttpServletRequest request, InformationDTO dto) throws Exception {
        Information v_info = dao.fetch(Information.class, dto.getInfoid());
        v_info.setLinkaddress(dto.getLinkaddress());
        dao.update(v_info);
    }


    /**
     * queryinfoStatistics的中文名称：查询报表
     * <p>
     * queryinfoStatistics的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryinfoStatistics(HttpServletRequest request, InformationDTO dto, PagesDTO pd) throws Exception {
        // 获取用户id
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT b.orgname,b.orgid, IFNULL(a.yearNumber,0) yearnumber,IFNULL(a.monthNumber,0) monthnumber,(SELECT COUNT(*) FROM information where orgid = b.orgid) as ljsb, ");
        sb.append(" (SELECT COUNT(*) FROM information where orgid = b.orgid AND date_format(b.reportTime,'%Y-%m')=date_format(now(),'%Y-%m')) benyue,\n ");
        sb.append(" (SELECT COUNT(*) FROM inforegulations,information WHERE inforegulations.orgid=information.orgid and localdistinction='1' AND\n ");
        sb.append(" information.adopt='2' and information.orgid = b.orgid) juliang,\n ");
        sb.append(" (SELECT COUNT(*) FROM inforegulations,information WHERE inforegulations.orgid=information.orgid and localdistinction='1' \n ");
        sb.append(" and information.adopt='2' and date_format(information.reportTime,'%Y-%m')=date_format(now(),'%Y-%m') and information.orgid = b.orgid) yueliang,\n ");
        sb.append(" (SELECT COUNT(*) FROM inforegulations,information WHERE inforegulations.orgid=information.orgid and localdistinction='2' AND\n ");
        sb.append(" information.adopt='2' and information.orgid = b.orgid) shengliang,\n ");
        sb.append(" (SELECT COUNT(*) FROM inforegulations,information WHERE inforegulations.orgid=information.orgid and localdistinction='2' \n ");
        sb.append(" and information.adopt='2' and date_format(information.reportTime,'%Y-%m')=date_format(now(),'%Y-%m') and information.orgid = b.orgid) yueshengliang\n ");
        sb.append(" FROM information  b LEFT JOIN  inforegulations a ON  a.orgid=b.orgid ");
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" where b.orgname like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        sb.append(" GROUP  BY a.orgid;\n ");

        String[] ParaName = new String[] { };
        int[] ParaType = new int[] {};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, InformationDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryInfoExcel( HttpServletRequest request,InformationDTO dto) throws Exception {
        // 获取用户id
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT b.orgname,b.orgid, IFNULL(a.yearNumber,0) yearnumber,IFNULL(a.monthNumber,0) monthnumber,(SELECT COUNT(*) FROM information where orgid = b.orgid) as ljsb, ");
        sb.append(" (SELECT COUNT(*) FROM information where orgid = b.orgid AND date_format(b.reportTime,'%Y-%m')=date_format(now(),'%Y-%m')) benyue,\n ");
        sb.append(" (SELECT COUNT(*) FROM inforegulations,information WHERE inforegulations.orgid=information.orgid and localdistinction='1' AND\n ");
        sb.append(" information.adopt='2' and information.orgid = b.orgid) juliang,\n ");
        sb.append(" (SELECT COUNT(*) FROM inforegulations,information WHERE inforegulations.orgid=information.orgid and localdistinction='1' \n ");
        sb.append(" and information.adopt='2' and date_format(information.reportTime,'%Y-%m')=date_format(now(),'%Y-%m') and information.orgid = b.orgid) yueliang,\n ");
        sb.append(" (SELECT COUNT(*) FROM inforegulations,information WHERE inforegulations.orgid=information.orgid and localdistinction='2' AND\n ");
        sb.append(" information.adopt='2' and information.orgid = b.orgid) shengliang,\n ");
        sb.append(" (SELECT COUNT(*) FROM inforegulations,information WHERE inforegulations.orgid=information.orgid and localdistinction='2' \n ");
        sb.append(" and information.adopt='2' and date_format(information.reportTime,'%Y-%m')=date_format(now(),'%Y-%m') and information.orgid = b.orgid) yueshengliang\n ");
        sb.append(" FROM information  b LEFT JOIN  inforegulations a ON  a.orgid=b.orgid ");
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" where b.orgname like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        sb.append(" GROUP  BY a.orgid;\n ");

        String[] ParaName = new String[] { };
        int[] ParaType = new int[] {};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);

        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, InformationDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryTaskZJ(HttpServletRequest request, OataskDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oataskid,a.taskcontent,a.aae036,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.aae011) aae011, ");
        sb.append(" DATE_FORMAT(a.endtime,'%Y-%m-%d %h:%i:%s') endtime ");
        sb.append(" from oatask a  ");
        sb.append(" where 1=1  ");
        sb.append("  and a.oataskid= :oataskid ");
        sb.append("  and a.taskcontent like :taskcontent ");
        sb.append(" and a.endtime <= :endtime ");
        sb.append("  and a.sfyx= '1' ");
        sb.append(" and a.aae011 = '" +vSysUser.getUserid() + "'");
        sb.append(" order by a.aae036 desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oataskid","taskcontent","endtime"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OataskDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++) {
                OataskDTO o = new OataskDTO();
                o = (OataskDTO)list.get(i);
                List list2=queryOataskman(o);
                String s1="";
                String s2="";
                String s3="";
                String s4="";
                String s5="";
                for(int j=0;j<list2.size();j++){
                    OataskmanDTO oa = new OataskmanDTO();
                    oa=(OataskmanDTO)list2.get(j);
                    if("".equals(s1)){
                        s1=oa.getUserid();
                    }else{
                        s1=s1+","+oa.getUserid();
                    }
                    if("".equals(s2)){
                        s2=oa.getAae011();
                    }else{
                        s2=s2+","+oa.getAae011();
                    }
                    if("".equals(s3)){
                        if("0".equals(oa.getHavereadflag())) {
                            s3 = oa.getAae011()+"未读";
                        }else{
                            s3 = oa.getAae011()+"已读";
                        }
                    }else{
                        if("0".equals(oa.getHavereadflag())) {
                            s3 = s3+","+oa.getAae011()+"未读";
                        }else{
                            s3 = s3+","+oa.getAae011()+"已读";
                        }
                    }
                    if("".equals(s4)){
                        if("0".equals(oa.getCompletestate())) {
                            s4 = oa.getAae011()+"未完成";
                        }else if("1".equals(oa.getCompletestate())){
                            s4 = oa.getAae011()+"已完成";
                        }else{
                            s4 = oa.getAae011()+"不能完成";
                        }
                    }else{
                        if("0".equals(oa.getCompletestate())) {
                            s4 = s4+","+oa.getAae011()+"未完成";
                        }else if("1".equals(oa.getCompletestate())){
                            s4 = s4+","+oa.getAae011()+"已完成";
                        }else{
                            s4 = s4+","+oa.getAae011()+"不能完成";
                        }
                    }
                    if("".equals(s5)){
                        if(!StringUtils.isEmpty(oa.getCannotreason())) {
                            s5 = oa.getCannotreason() + "-" + oa.getAae011();
                        }

                    }else{
                        if(!StringUtils.isEmpty(oa.getCannotreason())) {
                            s5 = s5 + "," + oa.getCannotreason() + "-" + oa.getAae011();
                        }
                    }


                }
                o.setTxr(s3);
                o.setZxrUserid(s1);
                o.setZxr(s2);
                o.setCompletestate(s4);
                o.setCannotreason(s5);
            }
        }
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        // 查询抄送人和执行人

        return map;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map querysdTaskZJ(HttpServletRequest request, OataskDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oataskid,a.taskcontent,a.aae036,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.aae011) aae011, ");
        sb.append(" DATE_FORMAT(a.endtime,'%Y-%m-%d %T') endtime, ");
        sb.append(" b.oataskmanid ");
        sb.append(" from oatask a  ");
        sb.append(" left join oataskman b on b.oataskid=a.oataskid ");
        sb.append(" where 1=1  ");
        sb.append("  and a.oataskid= :oataskid ");
        sb.append("  and a.taskcontent like :taskcontent ");
        sb.append(" and a.endtime <= :endtime ");
        sb.append(" and b.userid = '" +vSysUser.getUserid() + "'");
        sb.append("  and a.sfyx= '1' ");
        sb.append("  and b.havereadflag= :havereadflag ");
        sb.append("  and b.completestate= :completestate ");
        sb.append(" order by a.endtime asc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oataskid","taskcontent","endtime","havereadflag","completestate"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OataskDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++) {
                OataskDTO o = new OataskDTO();
                o = (OataskDTO)list.get(i);
                List list2=queryOataskman(o);
                String s1="";
                String s2="";
                String s3="";
                String s4="";
                String s5="0";
                String endtime=o.getEndtime();
                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
                String dateString = formatter.format(currentTime);
                String dateString2 = formatter2.format(currentTime);
                Calendar c1=Calendar.getInstance();
                Calendar c2=Calendar.getInstance();
                Calendar c3=Calendar.getInstance();
                Calendar c4=Calendar.getInstance();
                c1.setTime(formatter.parse(endtime));
                c2.setTime(formatter.parse(dateString));
                int result=c1.compareTo(c2);
                c3.setTime(formatter2.parse(endtime));
                c4.setTime(formatter2.parse(dateString2));
                int result2=c3.compareTo(c4);
                for(int j=0;j<list2.size();j++){
                    OataskmanDTO oa = new OataskmanDTO();
                    oa=(OataskmanDTO)list2.get(j);
                    if("".equals(s1)){
                        s1=oa.getUserid();
                    }else{
                        s1=s1+","+oa.getUserid();
                    }
                    if("".equals(s2)){
                        s2=oa.getAae011();
                    }else{
                        s2=s2+","+oa.getAae011();
                    }
                    if("".equals(s3)){
                        if("0".equals(oa.getHavereadflag())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "未读";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "已读";
                            }
                        }
                    }else{
                        if("0".equals(oa.getHavereadflag())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "未读";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "已读";
                            }
                        }
                    }
                    if("".equals(s4)){
                        if("0".equals(oa.getCompletestate())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "未完成";
                                if(result<0){
                                    s4="1";
                                }else{
                                    if(result2==0){
                                        s4="2";
                                    }
                                }

                            }
                        }else if("1".equals(oa.getCompletestate())){
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "已完成";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "不能完成";
                            }
                        }
                    }else{
                        if("0".equals(oa.getCompletestate())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "未完成";
                                if(result<0){
                                    s4="1";
                                }else{
                                    if(result2==0){
                                        s4="2";
                                    }
                                }
                            }
                        }else if("1".equals(oa.getCompletestate())){
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "已完成";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "不能完成";
                            }
                        }
                    }

                }
                o.setTxr(s3);
                o.setZxrUserid(s1);
                o.setZxr(s2);
                o.setCompletestate(s4);
                o.setSfcc(s5);
            }
        }

        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        // 查询抄送人和执行人

        return map;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map querysdTaskZJDB(HttpServletRequest request, OataskDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oataskid,a.taskcontent,a.aae036,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.aae011) aae011, ");
        sb.append(" DATE_FORMAT(a.endtime,'%Y-%m-%d %T') endtime, ");
        sb.append(" b.oataskmanid ");
        sb.append(" from oatask a  ");
        sb.append(" left join oataskman b on b.oataskid=a.oataskid ");
        sb.append(" where 1=1  ");
        sb.append("  and a.oataskid= :oataskid ");
        sb.append("  and a.taskcontent like :taskcontent ");
        sb.append(" and a.endtime <= :endtime ");
        sb.append(" and b.userid = '" +vSysUser.getUserid() + "'");
        sb.append("  and a.sfyx= '1' ");
        sb.append("  and b.completestate= '0' ");
        sb.append(" order by a.endtime asc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oataskid","taskcontent","endtime"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OataskDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++) {
                OataskDTO o = new OataskDTO();
                o = (OataskDTO)list.get(i);
                List list2=queryOataskman(o);
                String s1="";
                String s2="";
                String s3="";
                String s4="";
                String s5="0";
                String endtime=o.getEndtime();
                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
                String dateString = formatter.format(currentTime);
                String dateString2 = formatter2.format(currentTime);
                Calendar c1=Calendar.getInstance();
                Calendar c2=Calendar.getInstance();
                Calendar c3=Calendar.getInstance();
                Calendar c4=Calendar.getInstance();
                c1.setTime(formatter.parse(endtime));
                c2.setTime(formatter.parse(dateString));
                int result=c1.compareTo(c2);
                c3.setTime(formatter2.parse(endtime));
                c4.setTime(formatter2.parse(dateString2));
                int result2=c3.compareTo(c4);
                for(int j=0;j<list2.size();j++){
                    OataskmanDTO oa = new OataskmanDTO();
                    oa=(OataskmanDTO)list2.get(j);
                    if("".equals(s1)){
                        s1=oa.getUserid();
                    }else{
                        s1=s1+","+oa.getUserid();
                    }
                    if("".equals(s2)){
                        s2=oa.getAae011();
                    }else{
                        s2=s2+","+oa.getAae011();
                    }
                    if("".equals(s3)){
                        if("0".equals(oa.getHavereadflag())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "未读";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "已读";
                            }
                        }
                    }else{
                        if("0".equals(oa.getHavereadflag())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "未读";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "已读";
                            }
                        }
                    }
                    if("".equals(s4)){
                        if("0".equals(oa.getCompletestate())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "未完成";
                                if(result<0){
                                    s4="1";
                                }else{
                                    if(result2==0){
                                        s4="2";
                                    }
                                }

                            }
                        }else if("1".equals(oa.getCompletestate())){
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "已完成";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "不能完成";
                            }
                        }
                    }else{
                        if("0".equals(oa.getCompletestate())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "未完成";
                                if(result<0){
                                    s4="1";
                                }else{
                                    if(result2==0){
                                        s4="2";
                                    }
                                }
                            }
                        }else if("1".equals(oa.getCompletestate())){
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "已完成";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s4 = "不能完成";
                            }
                        }
                    }

                }
                o.setTxr(s3);
                o.setZxrUserid(s1);
                o.setZxr(s2);
                o.setCompletestate(s4);
                o.setSfcc(s5);
            }
        }

        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        // 查询抄送人和执行人

        return map;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryhfTaskZJ(HttpServletRequest request, OamatterdynamicDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oamatterdynamicid,a.othertableid,a.replytype,a.replycontent,a.aae036,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.aae011) aae011 ");
        sb.append(" from oamatterdynamic a  ");
        sb.append(" left join oatask b  on b.oataskid=a.othertableid");
        sb.append(" where 1=1  ");
        sb.append("  and a.othertableid= :othertableid ");
        sb.append(" and b.aae011 = '" +vSysUser.getUserid() + "'");
        sb.append(" order by a.aae036 desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"othertableid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OamatterdynamicDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        // 查询抄送人和执行人

        return map;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryhfsTaskZJ(HttpServletRequest request, OamatterdynamicDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oamatterdynamicid,a.othertableid,a.replytype,a.replycontent,a.aae036,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.aae011) aae011 ");
        sb.append(" from oamatterdynamic a  ");;
        sb.append(" where 1=1  ");
        sb.append("  and a.othertableid= :othertableid ");
        sb.append(" and a.aae011 = '" +vSysUser.getUserid() + "'");
        sb.append(" order by a.aae036 desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"othertableid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OamatterdynamicDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        // 查询抄送人和执行人

        return map;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryhfsTaskZ(HttpServletRequest request, OamatterdynamicDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oamatterdynamicid,a.othertableid,a.replytype,a.replycontent,a.aae036,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.aae011) aae011 ");
        sb.append(" from oamatterdynamic a  ");;
        sb.append(" where 1=1  ");
        sb.append("  and a.othertableid= :othertableid ");
        sb.append(" order by a.aae036 desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"othertableid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OamatterdynamicDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        // 查询抄送人和执行人

        return map;
    }

    public List queryOataskman( OataskDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.userid,a.havereadflag,a.completestate,a.cannotreason,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.userid) aae011 ");
        sb.append(" from oataskman a  ");
        sb.append(" where 1=1  ");
        sb.append("  and a.oataskid= :oataskid ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oataskid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OataskmanDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        return list;
    }


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
            oatask.setTaskcontent(dto.getTaskcontent()); // 任务内容
            oatask.setEndtime(dto.getEndtime()); // 结束时间
            dao.update(oatask);

            // 添加执行人
            String zxrUserid = dto.getZxrUserid();
            String[] zxr = zxrUserid.split(",");
            String currTime = SysmanageUtil.getDbtimeYmdHns();
            dao.clear(Oataskman.class, Cnd.where("oataskid", "=", oatask.getOataskid()));
            for (int i = 0; i < zxr.length; i++) {

                String oataskmanid = DbUtils.getSequenceStr();
                oataskman.setUserid(zxr[i]);
                oataskman.setTaskmantype("0");
                oataskman.setOataskmanid(oataskmanid);
                oataskman.setOataskid(oatask.getOataskid());
                oataskman.setAae011(v_user.getUserid());
                oataskman.setAae036(currTime);
                oataskman.setHavereadflag("0");
                oataskman.setReceivedflag("0");
                oataskman.setCompletestate("0");
                dao.insert(oataskman);
                dto.setTxr(zxr[i]);
                dto.setOataskmanid(oataskmanid);
                dto.setAae011(v_user.getUserid());
                dto.setAae036(currTime);
                oaNoticeManagerApiService.OaNotice(request, dto, "1");
            }

        } else {
            // 添加任务
            String currTime = SysmanageUtil.getDbtimeYmdHns();
            // 任务表
            Oatask v_oatask = new Oatask();
            // 任务关联人表
            Oataskman v_oataskman = new Oataskman();
            BeanHelper.copyProperties(dto, v_oatask);
            v_oatask.setOataskid(dto.getUserid());
            v_oatask.setAae036(currTime);
            v_oatask.setSendtype("1");
            v_oatask.setAae011(v_user.getUserid());
            v_oatask.setTasktype("0");//0文字，1语音
            v_oatask.setSfyx("1");//0wu 1you
            v_oatask.setNeedremindflag("1");
            v_oatask.setRemindtype("1");
            v_oatask.setTaskremindtime("15"); // 到期提前提醒时间
            dao.insert(v_oatask);



            // 添加执行人
            String zxrUserid = dto.getZxrUserid();
            if (null != zxrUserid && !"".equals(zxrUserid)) {
                String[] zxr = zxrUserid.split(",");
                for (int i = 0; i < zxr.length; i++) {
                    String oataskmanid = DbUtils.getSequenceStr();
                    v_oataskman.setUserid(zxr[i]);
                    v_oataskman.setTaskmantype("0");
                    v_oataskman.setOataskmanid(oataskmanid);
                    v_oataskman.setOataskid(v_oatask.getOataskid());
                    v_oataskman.setAae011(v_user.getUserid());
                    v_oataskman.setAae036(currTime);
                    v_oataskman.setHavereadflag("0");
                    v_oataskman.setReceivedflag("0");
                    v_oataskman.setCompletestate("0");
                    dao.insert(v_oataskman);
                    dto.setTxr(zxr[i]);
                    dto.setOataskmanid(oataskmanid);
                    dto.setAae011(v_user.getUserid());
                    dto.setAae036(currTime);
                    oaNoticeManagerApiService.OaNotice(request, dto, "1");
                }
            }
        }
        sjbService.jpushNotice(request);
    }

    public String addOamatterdynamic(HttpServletRequest request, OamatterdynamicDTO dto) {
        try {
            addOamatterdynamicImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void addOamatterdynamicImp(HttpServletRequest request, OamatterdynamicDTO dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oataskid = "";
        // 添加任务
        String currTime = SysmanageUtil.getDbtimeYmdHns();
        Oamatterdynamic oa = new Oamatterdynamic();
        Oatask oatask = dao.fetch(Oatask.class, dto.getOthertableid());
        oa.setOamatterdynamicid(dto.getOamatterdynamicid());
        oa.setReplycontent(dto.getReplycontent());
        oa.setAae011(v_user.getUserid());
        oa.setAae036(currTime);
        oa.setReplytype("1");
        oa.setOthertableid(dto.getOthertableid());
        dao.insert(oa);
    }

    public String updateoatsakman(HttpServletRequest request, OataskmanDTO dto) {
        try {
            updateoatsakmanImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void updateoatsakmanImp(HttpServletRequest request,  OataskmanDTO  dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oataskid = "";
        // 添加任务

        Oataskman oatask = dao.fetch(Oataskman.class, dto.getOataskmanid());
      oatask.setHavereadflag("1");
      oatask.setReceivedflag("1");
        dao.update(oatask);
    }

    public String wcoatsakman(HttpServletRequest request, OataskmanDTO dto) {
        try {
            wctsakmanImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void wctsakmanImp(HttpServletRequest request,  OataskmanDTO  dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oataskid = "";
        // 完成任务

        Oataskman oatask = dao.fetch(Oataskman.class, dto.getOataskmanid());
        oatask.setCompletestate("1");
        dao.update(oatask);
    }

    public String bnwcoatsakman(HttpServletRequest request, OataskmanDTO dto) {
        try {
            bnwctsakmanImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void bnwctsakmanImp(HttpServletRequest request,  OataskmanDTO  dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oataskid = "";
        // 完成任务

        Oataskman oatask = dao.fetch(Oataskman.class, dto.getOataskmanid());
        oatask.setCompletestate("2");
        oatask.setCannotreason(dto.getCannotreason());
        dao.update(oatask);
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
}