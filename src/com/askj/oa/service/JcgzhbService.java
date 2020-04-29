package com.askj.oa.service;

import com.askj.oa.dto.EgWorkTaskDTO;
import com.askj.oa.dto.JcgzhbDTO;
import com.askj.oa.entity.EgWorkTask;
import com.askj.oa.entity.Jcgzhb;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
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
import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 *  JcgzhbService的中文名称：稽查工作汇报表
 *
 *
 *  Written  by  : zk
 */
public class JcgzhbService extends BaseService {
    protected final Logger logger = Logger.getLogger(JcgzhbService .class);
    @Inject
    private Dao dao;

    /**
     *
     * queryMonthlyWorkTask的中文名称：年度工作台账表查询
     *
     * queryMonthlyWorkTask的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJcgzhb(HttpServletRequest request, JcgzhbDTO dto, PagesDTO pd) throws Exception {
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,c.orgname orgname from jcgzhb a  ");
        sb.append(" left join sysorg c on a.orgid=c.orgid  ");
        sb.append(" where 1 = 1 ");
        if (dto.getStart() != null && !"".equals(dto.getStart())) {
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
        }else {
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y%m' ) = DATE_FORMAT( CURDATE( ) , '%Y%m' )");
        }
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" and c.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        sb.append(" union all ");
        sb.append("select 'heji' as jcgzhbid,'0' as orgid,sum(laby) laby,sum(lalj) lalj,sum(jaby) jaby,sum(jalj) jalj,sum(yssfby) yssfby,sum(yssflj) yssflj, ");
        sb.append("FORMAT(sum(zxfkby),2) zxfkby,FORMAT(sum(zxfklj),2) zxfklj,sum(ajxxgsrw) ajxxgsrw,sum(ajxxgsby) ajxxgsby,sum(ajxxgslj) ajxxgslj,sum(cyjjrw) cyjjrw, ");
        sb.append("sum(cyjjby) cyjjby,sum(cyjjlj) cyjjlj,sum(cjxxgsrw) cjxxgsrw,sum(cjxxgsby) cjxxgsby,sum(cjxxgslj) cjxxgslj,sum(bdwsltsjbby) bdwsltsjbby, ");
        sb.append("sum(bdwsltsjblj) bdwsltsjblj,sum(sjjbtsjbby) sjjbtsjbby,sum(sjjbtsjblj) sjjbtsjblj,sum(sjjbwthcczby) sjjbwthcczby, ");
        sb.append("sum(sjjbwthcczlj) sjjbwthcczlj,sum(sjjbwthcczrw) sjjbwthcczrw, ");
        sb.append("sum(xcblrw) xcblrw,sum(xcblby) xcblby,sum(xcbllj) xcbllj,'0' as aaa011,now() as aaa036, ");
        sb.append("'合计' orgname from jcgzhb a  ");
        sb.append(" left join sysorg c on a.orgid=c.orgid  ");
        sb.append(" where 1 = 1 ");
        if (dto.getStart() != null && !"".equals(dto.getStart())) {
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
        }else {
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y%m' ) = DATE_FORMAT( CURDATE( ) , '%Y%m' )");
        }
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" and c.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        String[] ParaName = new String[] {"orgname" ,"start","end"};
        int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JcgzhbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     *
     * saveTask的中文名称：工作台账表单保存
     *
     * saveTask的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    public String saveJcgzhb(HttpServletRequest request, JcgzhbDTO dto) {
        try {
            saveJcgzhbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * saveTaskImp的中文名称：工作台账表单保存
     *
     * saveTaskImp的概要说明：
     *
     * @param request
     * @param dto
     * @param
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop({ "trans" })
    public void saveJcgzhbImp(HttpServletRequest request, JcgzhbDTO dto)
            throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser();
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        if (null != dto.getJcgzhbid() && !"".equals(dto.getJcgzhbid())) {
            //修改
            Jcgzhb se = dao.fetch(Jcgzhb.class,dto.getJcgzhbid());
            String orgid=se.getOrgid();
            datetime=se.getAaa036();
            BeanHelper.copyProperties(dto, se);
            se.setAaa011(vSysUser.getUsername());
            se.setAaa036(datetime);
            se.setOrgid(orgid);
            dao.update(se);
        } else {
            //新增
            Jcgzhb se = new  Jcgzhb();
            BeanHelper.copyProperties(dto, se);
            se.setJcgzhbid(DbUtils.getSequenceStr());
            se.setOrgid(vSysUser.getOrgid());
            se.setAaa036(datetime);
            se.setAaa011(vSysUser.getUsername());
            dao.insert(se);
        }
    }


    /**
     *
     * queryWorkTask的中文名称：查询单个工作台账
     *
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
    public Map queryJcgzhbDTO(HttpServletRequest request, JcgzhbDTO dto)
            throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from jcgzhb a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.jcgzhbid = :jcgzhbid ");
        String sql = sb.toString();
        String[] ParaName = new String[] { "jcgzhbid" };
        int[] ParaType = new int[] { Types.VARCHAR };
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JcgzhbDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        return r;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJcgzhbExcel( HttpServletRequest request,JcgzhbDTO dto) throws Exception {
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,c.orgname orgname from jcgzhb a  ");
        sb.append(" left join sysorg c on a.orgid=c.orgid  ");
        sb.append(" where 1 = 1 ");
        if (dto.getStart() != null && !"".equals(dto.getStart())) {
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
        }else {
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y%m' ) = DATE_FORMAT( CURDATE( ) , '%Y%m' )");
        }
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" and c.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        sb.append(" union all ");
        sb.append("select 'heji' as jcgzhbid,'0' as orgid,sum(laby) laby,sum(lalj) lalj,sum(jaby) jaby,sum(jalj) jalj,sum(yssfby) yssfby,sum(yssflj) yssflj, ");
        sb.append("FORMAT(sum(zxfkby),2) zxfkby,FORMAT(sum(zxfklj),2) zxfklj,sum(ajxxgsrw) ajxxgsrw,sum(ajxxgsby) ajxxgsby,sum(ajxxgslj) ajxxgslj,sum(cyjjrw) cyjjrw, ");
        sb.append("sum(cyjjby) cyjjby,sum(cyjjlj) cyjjlj,sum(cjxxgsrw) cjxxgsrw,sum(cjxxgsby) cjxxgsby,sum(cjxxgslj) cjxxgslj,sum(bdwsltsjbby) bdwsltsjbby, ");
        sb.append("sum(bdwsltsjblj) bdwsltsjblj,sum(sjjbtsjbby) sjjbtsjbby,sum(sjjbtsjblj) sjjbtsjblj,sum(sjjbwthcczby) sjjbwthcczby, ");
        sb.append("sum(sjjbwthcczlj) sjjbwthcczlj,sum(sjjbwthcczrw) sjjbwthcczrw, ");
        sb.append("sum(xcblrw) xcblrw,sum(xcblby) xcblby,sum(xcbllj) xcbllj,'0' as aaa011,now() as aaa036, ");
        sb.append("'合计' orgname from jcgzhb a  ");
        sb.append(" left join sysorg c on a.orgid=c.orgid  ");
        sb.append(" where 1 = 1 ");
        if (dto.getStart() != null && !"".equals(dto.getStart())) {
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y-%m' ) >='"+dto.getStart().trim()+"'");
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y-%m' ) <='"+dto.getEnd().trim()+"'");
        }else {
            sb.append(" and DATE_FORMAT( a.aaa036, '%Y%m' ) = DATE_FORMAT( CURDATE( ) , '%Y%m' )");
        }
        if (dto.getOrgname() != null && !"".equals(dto.getOrgname())) {
            sb.append(" and c.ORGNAME like '%").append(dto.getOrgname()).append("%' "); // 机构名称
        }
        String[] ParaName = new String[] {"orgname" };
        int[] ParaType = new int[] {Types.VARCHAR };
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JcgzhbDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        return map;
    }

    public String delJcgzhb(HttpServletRequest request,JcgzhbDTO dto) {
        try {
            if (null != dto.getJcgzhbid()) {
                delJcgzhbImp(request, dto);
            } else {
                return "没有接收到要删除的稽查工作汇报ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({ "trans" })
    public void delJcgzhbImp(HttpServletRequest request, JcgzhbDTO dto) {
        // 删除工作台账
        dao.clear(Jcgzhb.class, Cnd.where("jcgzhbid", "=", dto.getJcgzhbid()));
    }

    public Map queryJcgzhbORG(JcgzhbDTO dto)
            throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from jcgzhb a ");
        sb.append("  where 1=1 ");
        sb.append(" and DATE_FORMAT( a.aaa036, '%Y%m' ) = DATE_FORMAT( CURDATE( ) , '%Y%m' )");
        sb.append("  and a.orgid = :orgid ");
        String sql = sb.toString();
        String[] ParaName = new String[] { "orgid" };
        int[] ParaType = new int[] { Types.VARCHAR };
        Sysuser vSysUser = SysmanageUtil.getSysuser();
        dto.setOrgid(vSysUser.getOrgid());
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JcgzhbDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        return r;
    }

    public Map queryJcgzhbZuiJing(JcgzhbDTO dto)
            throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from jcgzhb a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.orgid = :orgid ");
        sb.append(" order by a.aaa036 desc limit 1");
        String sql = sb.toString();
        String[] ParaName = new String[] {"orgid"};
        int[] ParaType = new int[] {Types.VARCHAR};
        Sysuser vSysUser = SysmanageUtil.getSysuser();
        dto.setOrgid(vSysUser.getOrgid());
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JcgzhbDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        return r;
    }


}
