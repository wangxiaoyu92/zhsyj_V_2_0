package com.askj.supervision.service;


import com.askj.supervision.dto.BsCheckMasterDTO;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.Map;

/**
 *
 * CheckForNcjtjcService的中文名称：检查结果查询
 *
 * CheckForNcjtjcService的中文描述：
 *
 * Written by:syf on 2017/9/18.
 */
public class CheckForNcjtjcService {

    protected final Logger logger = Logger.getLogger(CheckForNcjtjcService.class);

    @Inject
    private Dao dao;
    /**
     *
     * getJdjcResultList的中文名称：获取监督检查结果列表
     *
     * getJdjcResultList的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author ：zjf
     */
    @SuppressWarnings("rawtypes")
    public Map getJdjcResultList(HttpServletRequest request, BsCheckMasterDTO dto, PagesDTO pd)throws Exception {
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select c.commc,a.comid,a.resultid, a.operatedate,a.resultdate, a.resultstate, a.resultremark,b.plancode,b.plantitle, ");
        sb.append(" b.plantype,getAa10_aaa103('plantype',b.plantype) as plantypeinfo, ");
        sb.append(" b.planchecktype,getAa10_aaa103('ITEMTYPE',b.plantype) as planchecktypeinfo, ");
        sb.append(" (select concat(c.username,'(',c.description,')') from sysuser c where c.userid=a.operateperson )  as operateperson ");
        sb.append(" from Bscheckmaster a, Bscheckplan b,Pcompany c ");
        sb.append("where a.planid = b.planid   ");
        sb.append("  and a.comid = c.comid ");
        sb.append("  and a.resultstate = '4' ");
        sb.append("  and a.operatedate like :year  ");
        sb.append("  and a.comid  = :comid  ");
        sb.append("  and a.planid = :planid  ");
        sb.append("  and a.qtbwid = :qtbwid  ");
        sb.append("  and b.planchecktype = :planchecktype ");
        sb.append("  order by a.operatedate desc,a.resultstate");
        String sql = sb.toString();
        String[] paramName = new String[] { "year", "comid","planid","qtbwid","planchecktype"};
        int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
        return m;
    }

}
