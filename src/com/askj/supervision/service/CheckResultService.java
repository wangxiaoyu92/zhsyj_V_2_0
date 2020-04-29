package com.askj.supervision.service;

import com.askj.supervision.dto.BsCheckMasterDTO;
import com.askj.supervision.dto.BsTbodyInfoDTo;
import com.askj.supervision.entity.BsCheckMaster;
import com.lbs.util.StringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * CheckResultService的中文名称：检查结果查询
 *
 * CheckResultService的中文描述：
 *
 * Written by:syf on 2017/9/18.
 */
public class CheckResultService {

    protected final Logger logger = Logger.getLogger(CheckInfoService.class);

    @Inject
    private Dao dao;
    /**
     * 查询出结果列表并分页
     * @param
     * @return
     * @throws Exception
     */
    public Map queryResultList(HttpServletRequest request, BsCheckMasterDTO dto, PagesDTO pd) throws Exception {
        //
        if(StringUtils.isNotEmpty(dto.getCommc())){
            dto.setCommc(new String(dto.getCommc().getBytes("ISO-8859-1"),"utf-8"));
        }
        String v_resultstate="";
        if (dto.getResultstate()!=null && !"".equals(dto.getResultstate())){
            if ("1".equals(dto.getResultstate())){
                v_resultstate=" and a.resultstate in ('0','1') ";
            }else if ("2".equals(dto.getResultstate())){
                v_resultstate=" and a.resultstate='2' ";
            }else if ("3".equals(dto.getResultstate())){
                v_resultstate=" and a.resultstate not in ('0','1','2') ";
            }
        }
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        //根据企业，、或是聚餐名称查询列表
        sb.append(" select a.resultid ,a.comid,c.commc ,c.comdalei,b.planid,b.plantype,b.plantitle , a.location, ");
        sb.append("a.resultdecision,(select getAa10_aaa103('resultdecision',a.resultdecision)) as resultdecisionaaa103,");
        sb.append("(select CONCAT(c.username,'(',c.DESCRIPTION,')') from sysuser c where c.userid=a.operateperson )  as operateperson , ");
        sb.append(" fun_getcomdalei('1',a.comid) as comdaleiname ,");
        sb.append(" a.operatedate,a.resultstate,(select getAa10_aaa103('resultstate',a.resultstate)) as resultstateaaa103,");
        sb.append(" b.planeddate,a.resultdate ,b.planchecktype,IFNULL(a.aaa027,c.aaa027) as aaa027 ,a.orgid,");
        sb.append(" ( select count(*) from bscheckpicset e where  e.planid = a.planid) as checknum, ");
        sb.append(" ( select count(*) from bscheckdetail d where d.resultid = a.resultid) as checkednum ");
        sb.append(" from bscheckmaster a , bscheckplan b ,pcompany c ");
        sb.append(" where a.planid = b.planid and a.comid=c.comid    ");
        sb.append(v_resultstate);//gu20161227
        sb.append(" and b.plantitle like :plantitle ");
        sb.append(" and (c.commc like :commc or c.commcjc like :commc)");
        sb.append(" and a.operatedate >= :operatedate ");
        sb.append(" and a.operatedate <= :operateenddate ");
        sb.append(" and a.resultid = :resultid ");
//		sb.append(" and (a.aaa027 like :aaa027 or c.aaa027 like :aaa027) ");
        sb.append(" order by a.operatedate desc");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"plantitle","commc","operatedate","operateenddate","resultid"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
        System.out.println(sql);
        Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, Map.class,pd.getPage(),
                                       pd.getRows(),dto.getUserid(),"aaa027,aae140,orgid");
//		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class,pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * 查询出结果列表并分页
     * @param
     * @return
     * @throws Exception
     */
    public Map queryResultReportList(HttpServletRequest request, BsCheckMasterDTO dto, PagesDTO pd) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        //根据企业，、或是聚餐名称查询列表
        sb.append(" select a.resultid ,a.comid,c.commc ,c.comdalei,b.planid,b.plantype,b.plantitle , a.location, ");
        sb.append("(select CONCAT(c.username,'(',c.DESCRIPTION,')') from sysuser c where c.userid=a.operateperson )  as operateperson , ");
        sb.append(" a.operatedate,a.resultstate,b.planeddate,a.resultdate ,b.planchecktype,IFNULL(a.aaa027,c.aaa027) as aaa027 ,a.orgid,");
        sb.append(" ( select count(*) from bscheckpicset e where  e.planid = a.planid) as checknum, ");
        sb.append(" ( select count(*) from bscheckdetail d where d.resultid = a.resultid) as checkednum ");
        sb.append(" from bscheckmaster a , bscheckplan b ,pcompany c ,aa13 d ,aa10 e ");
        sb.append(" where a.planid = b.planid and a.comid=c.comid  and c.aaa027=d.aaa027 and e.aaa102=c.comdalei ");
        sb.append(" and b.plantitle like :plantitle ");
        sb.append(" and c.commc like :commc ");
        sb.append(" and a.operatedate >= :operatedate ");
        sb.append(" and a.operatedate <= :operateenddate ");
        sb.append(" and a.resultid = :resultid ");
        sb.append(" and d.aaa129 = :aaa027 ");
        sb.append(" and e.aaa103 = :comdalei ");
        sb.append(" and a.operatedate like :year ");
        if(dto.getResultstate()!=null && !"".equals(dto.getResultstate())){
            if("4".equals(dto.getResultstate())){//已经完成
                sb.append(" and a.resultstate =4  ");
            }else if("2".equals(dto.getResultstate())){//完成并不合格
                sb.append(" and a.resultstate =4 and a.resultdecision <> 101");
            }
            else {//未完成
                sb.append(" and a.resultstate <>4  ");
            }
        }
        sb.append(" order by a.operatedate desc");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"plantitle","commc","operatedate","operateenddate","resultid","aaa027","comdalei","year"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
        System.out.println(sql);
        Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, Map.class,pd.getPage(), pd.getRows(),dto.getUserid(),"aaa027,aae140,orgid");
//		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class,pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * 根据结果id 查询检查明细结果
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    public Map getDetailByid(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select b.contentcode,b.contentimpt ,b.contentsortid,b.contentscore ,c.itemsortid*1000 sortid,  ");
        sb.append("  a.resultid , b.contentid  , b.content  ,c.itemname ,c.itemid,c.itempid ,   ");
        sb.append("  a.detaildecide , a.detailscore ,a.detailng ,a.detailremark, ");
        sb.append("  (select COUNT(*) from bscheckdetail d ,omcheckcontent e  ");
        sb.append("  where d.contentid=e.contentid and e.itemid=c.itemid and d.resultid = :resultid ) count, ");
        sb.append("  a.detaildecide , a.detailscore ,a.detailng ,a.detailremark ");
        sb.append("  from bscheckdetail a , omcheckcontent b , omcheckgroup c ");
        sb.append("  where a.contentid = b.contentid and b.itemid = c.itemid ");
        sb.append(" and a.resultid= :resultid ");
        sb.append(" ORDER BY  sortid");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"resultid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("data", list);
        return map;
    }

    /**
     * 查询企业信息通过结果id，
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    public Map getQiyeInfoByid(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select  DISTINCT (select e.itemname from omcheckgroup e where e.itemid=d.itempid) itemname, b.*,a.operatedate,a.resultdate");
        sb.append("  from bscheckmaster a ,pcompany b ,bscheckpicset c ,omcheckgroup d ");
        sb.append("  where a.comid=b.comid and c.planid= a.planid and c.itemid = d.itemid  ");
        sb.append(" and a.resultid= :resultid ");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"resultid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("data", list.get(0));
        return map;
    }
    /**
     * 得到表头信息，
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    public Map getTbodyInfo(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        Sysuser user = SysmanageUtil.getSysuser();
        String result = SysmanageUtil.getAA027Str(user.getAaa027(), user.getAae383());
        dto.setAaa027(result);
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.tbodyinfo,a.tfootinfo,a.tbody from bstbodyinfo a ");
        sb.append("  where 1=1 ");
        sb.append("   and a.tbodytype = :tbodytype  and a.tbodycode= :tbodycode and a.aaa027 like :aaa027 ");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"tbodytype","tbodycode","aaa027"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsTbodyInfoDTo.class);
        List<BsTbodyInfoDTo> list = (List<BsTbodyInfoDTo>) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("data", list.get(0));
        return map;
    }

    /**
     * 得到表头信息，
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    public  BsTbodyInfoDTo getTbodyInfoHtml(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.tbodyinfo,a.tfootinfo ,a.tbody from bstbodyinfo a ");
        sb.append("  where 1=1 ");
        sb.append("   and a.tbodytype = :tbodytype  and a.tbodycode= :tbodycode ");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"tbodytype","tbodycode"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsTbodyInfoDTo.class);
        List<BsTbodyInfoDTo> list = (List<BsTbodyInfoDTo>) m.get(GlobalNames.SI_RESULTSET);
//		Map map = new HashMap();
//		map.put("data", list.get(0));
        return list.get(0);
    }

    /**
     * 通过计划id查询结果个数
     * @param
     * @return
     * @throws Exception
     */
    public Map getResultNumByPlanid(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        Cnd wh = null;
        wh = wh.where("planid", "=", dto.getPlanid().trim()).and("resultstate", "<>", "4");
        //转化sql语句
        int li_count= dao.count(BsCheckMaster.class, wh);
        Map map = new HashMap();
        map.put("total",li_count);
        return map;
    }

    /**
     *  查询检查结果
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    public List queryCheckResut(HttpServletRequest request,BsCheckMaster dto) throws Exception{

        StringBuffer sb = new StringBuffer();
        sb.append(" select g.itemname ,c.contentid,c.content,c.contentsortid,c.contentimpt,c.contentscore,c.contentsortid");
        sb.append(" 	from bscheckpicset s,bscheckplan p, omcheckcontent c,omcheckgroup g      ");
        sb.append("  where s.planid = p.planid                                                   ");
        sb.append("    and s.contentid = c.contentid                                             ");
        sb.append(" 	 and s.itemid = g.itemid                                                 ");
        sb.append(" 	 and p.planid = :planid order by c.contentsortid asc                     ");

        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"planid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);

        return list;

    }

    /***********************************************聚餐申报*********************************** ST  *************************/
    /**
     * (聚餐申报)查询出结果列表并分页
     * @param
     * @return
     * @throws Exception
     */
    public Map jcsbqueryResultList(HttpServletRequest request, BsCheckMasterDTO dto, PagesDTO pd) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        //根据企业，、或是聚餐名称查询列表
        sb.append(" select a.resultid ,a.comid,c.jcsbjbrxm,a.checkgroupstate,b.planid,b.plantype,b.plantitle , ");
        sb.append(" a.operatedate,a.resultstate,b.planeddate,a.resultdate ,b.planchecktype,b.planmobankind, ");
        sb.append(" ( select count(*) from bscheckpicset e where  e.planid = a.planid) as checknum, ");
        sb.append(" ( select count(*) from bscheckdetail d where d.resultid = a.resultid) as checkednum ");
        sb.append(" from Bscheckmaster a , Bscheckplan b ,Jcsb c ");
        sb.append(" where a.planid = b.planid and a.comid=c.jcsbid    ");
        sb.append(" and b.plantitle like :plantitle ");
        sb.append(" and c.jcsbjbrxm like :jcsbjbrxm ");
        sb.append(" and a.operatedate >= :operatedate ");
        sb.append(" and a.operatedate <= :operateenddate ");
        sb.append(" and a.resultid = :resultid ");
        sb.append(" order by a.operatedate desc");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"plantitle","jcsbjbrxm","operatedate","operateenddate","resultid"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class,pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /***********************************************聚餐申报*********************************** ED  *************************/

    /**
     *
     * getResultInfoForHtml的中文名称：根据结果id获取检查结果信息 以html形式返回
     *
     * getResultInfoForHtml的概要说明：传入resultid
     *
     * @param dto
     * @return Written by : tmm
     *
     */
    public BsCheckMaster getResultInfoForHTML(HttpServletRequest request,
                                         BsCheckMasterDTO dto) throws Exception {
        BsCheckMaster master = dao
                .fetch(BsCheckMaster.class, dto.getResultid());
        StringBuffer sb = new StringBuffer();
        sb.append("<!DOCTYPE html>");
        sb.append("<html><head>");
        sb.append("<meta http-equiv='content-type' content='text/html; charset=UTF-8'>");
        sb.append("<meta name='Author' content=''>");
        sb.append("<meta name='Keywords' content=''>");
        sb.append("<meta name='Description' content=''>");
        sb.append("</head><body>");
        if (master != null) {
            if (StringUtils.isNotEmpty(master.getCheckresultinfo())){
                sb.append(master.getCheckresultinfo());
            };
            if (StringUtils.isNotEmpty(master.getDetailinfo())){
                sb.append(master.getDetailinfo());
            }

        }else{
            sb.append("暂无数据");
        }
        sb.append("</body></html>");
        master.setDetailinfo(sb.toString());
        return master;
    }
}
