package com.askj.oa.service;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

import java.io.*;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/9/26.
 */
public class KqglService extends BaseService {
    protected final Logger logger = Logger.getLogger(KqglService.class);
    @Inject
    private Dao dao;

    public List  Qdtj(String startDate ,String endDate)throws Exception{
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT '姓名ID' userid, '姓名' username, '正常' normal, '迟到' late, '缺卡' miss, f_workday_day('").append( startDate+ "' , '"+ endDate +"',false) stat ,0 odb UNION ALL ");//:startDate,:endDate,false) stat ,0 odb UNION ALL ");
        sb.append(" SELECT '' userid, '' username, '' normal, '' late, '' miss, f_workday_day('").append( startDate+ "' , '"+ endDate +"',true) stat ,0 odb UNION ALL ");//:startDate,:endDate,true) stat ,0 odb UNION ALL ");
        sb.append(" SELECT ssbd.userid userid,   ssbd.DESCRIPTION username,  ");
        sb.append(" (SELECT COUNT(status) FROM stat_signin_by_day WHERE userid = ssbd.userid AND STATUS='1' AND signtime BETWEEN  '").append( startDate+ "' and '"+ endDate +"' )  normal, ");//"  :startDate and :endDate )  normal, ");
        sb.append(" (SELECT COUNT(status) FROM stat_signin_by_day WHERE userid = ssbd.userid AND STATUS='2' AND signtime BETWEEN  '").append( startDate+ "' and '"+ endDate +"' )  late,  ");//:startDate and :endDate)  late, ");
        sb.append(" (SELECT COUNT(status) FROM stat_signin_by_day WHERE userid = ssbd.userid AND STATUS='3' AND signtime BETWEEN '").append( startDate+ "' and '"+ endDate +"' )  miss, ");//:startDate and :endDate)  miss, ");
        sb.append(" GROUP_CONCAT(case ssbd.statusdesc when '迟到' then CONCAT_WS('-',ssbd.statusdesc,DATE_FORMAT(ssbd.dwsj,'%H:%i')) ELSE ssbd.statusdesc end) stat,odb  ");
        sb.append(" FROM stat_signin_by_day ssbd  ,tjuser t ");
        sb.append(" WHERE ssbd.signtime BETWEEN '").append( startDate+ "' and '"+ endDate +"' AND t.id =ssbd.userid ");//:startDate and :endDate AND t.id =ssbd.userid ");
        sb.append(" GROUP BY ssbd.DESCRIPTION,ssbd.userid ORDER BY  odb  ");
        String sql = sb.toString();
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }


}
