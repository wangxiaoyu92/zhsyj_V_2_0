package com.askj.zfba.service.pub;

import com.askj.app.service.SjbService;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.dto.PfjcsDTO;
import com.askj.baseinfo.dto.ViewzfajzfwsDTO;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.baseinfo.entity.Pfjcsorder;
import com.askj.baseinfo.service.PcompanyService;
import com.askj.baseinfo.service.pub.PubService;
import com.askj.zfba.dto.*;
import com.askj.zfba.entity.*;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.util.StringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * NewsService的中文名称：新闻管理service
 * <p/>
 * NewsService的描述：
 * <p/>
 * Written by : gjf
 */
@IocBean
public class WsgldyService extends BaseService {
    protected final Logger logger = Logger.getLogger(WsgldyService.class);
    @Inject
    private Dao dao;
    @Inject
    private PubService pubService;
    @Inject
    private PcompanyService pcompanyService;


    /**
     * queryAjwslist的中文名称：查询案件文书列表
     * <p/>
     * queryAjwslist的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : gjf
     * @throws Exception
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public Map queryAjwslist(ZfajzfwsDTO dto, PagesDTO pd) throws Exception {

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,b.fjcsdmmc,b.zfwsurl,(select count(t.fjid) from fj t where t.fjcsdmz=a.zfwsdmz and t.fjwid=:ajdjid) as zfwsycfjzs,b.fjcszfwstitle, ");
        sb.append(" (select count(t3.pdbsxjsrid) from pdbsx t2,pdbsxjsr t3 where t2.pdbsxid=t3.pdbsxid and t3.jsbz='1' and t2.qtbid=a.ajzfwsid) as baoqingyiyuebz ");
        sb.append(" from Zfajzfws a,Viewzfajzfws b ");
        sb.append(" where a.zfwsdmz=b.fjcsdmz ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.nodeid = :nodeid");

        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "nodeid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.LONGVARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ZfajzfwsDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * queryAjwslistHis的中文名称：查询案件文书列表历史环节用到的文书
     * <p/>
     * queryAjwslistHis的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : gjf
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryAjwslistHis(ZfajzfwsDTO dto, PagesDTO pd) throws Exception {

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,b.fjcsdmmc,b.zfwsurl,(select count(t.fjid) from fj t where t.fjcsdmz=a.zfwsdmz and t.fjwid=:ajdjid) as zfwsycfjzs,b.fjcszfwstitle ");
        sb.append(" from Zfajzfws a,Viewzfajzfws b ");
        sb.append(" where a.zfwsdmz=b.fjcsdmz ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.nodeid <> :nodeid");

        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "nodeid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.LONGVARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ZfajzfwsDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * queryAjwslist的中文名称：查询案件文书列表
     * <p/>
     * queryAjwslist的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : gjf
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryAjwsParamlist(ViewzfajzfwsDTO dto, PagesDTO pd)
            throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        ViewzfajzfwsDTO viewzfajzfws = dto;
        if (vSysUser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
            vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
        }
        String v_userid = vSysUser.getUserid();
        boolean v_have = userHaveSetZfwsorder(viewzfajzfws);

        StringBuffer sb = new StringBuffer();
        if (!v_have) {
            sb.append(" select a.* ");
            if ("2".equals(dto.getOperatetype())) {
                sb.append(" from viewzfwsmobile a ");
            } else {
                sb.append(" from viewZfajzfws a ");
            }
            sb.append(" where not exists (select 1 from Zfajzfws b where b.zfwsdmz=a.fjcsdmz and a.fjcssfdx='0' ");
            sb.append("and b.ajdjid=:ajdjid ");
            sb.append(" and 1=1 ) order by fjcsorder ");
        } else {
            sb.append(" select a.* ");
            if ("2".equals(dto.getOperatetype())) {
                sb.append(" from viewzfwsmobile a,pfjcsorder c ");
            } else {
                sb.append(" from viewZfajzfws a,pfjcsorder c ");
            }
            sb.append(" where a.fjcsid=c.fjcsid ");
            sb.append(" and c.userid='" + v_userid + "' ");
            sb.append(" and not exists (select 1 from Zfajzfws b where b.zfwsdmz=a.fjcsdmz and a.fjcssfdx='0' ");
            sb.append(" and b.ajdjid=:ajdjid ");
            sb.append(" and 1=1 ) order by c.fjcspx ");
        }

        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid"};
        int[] ParaType = new int[]{Types.VARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("queryAjwsParamlistqueryAjwsParamlist " + sql);

        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ViewzfajzfwsDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * queryAjwsParamlistOrder的中文名称：
     * <p/>
     * queryAjwsParamlistOrder的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : gjf
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryAjwsParamlistOrder(ViewzfajzfwsDTO dto, PagesDTO pd)
            throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        String v_userid = vSysUser.getUserid();
//		String v_sql="select a.* from pfjcsorder a where a.userid='"+
//		       v_userid+"'";
        //List

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,b.fjcspx ");
        sb.append(" from viewZfajzfws a left join Pfjcsorder b ");
        sb.append(" on a.fjcsid=b.fjcsid ");
        sb.append(" and b.userid='" + v_userid + "' ");
        sb.append(" where 1=1 ");
        sb.append(" order by b.fjcspx ");

        String sql = sb.toString();
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ViewzfajzfwsDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * saveAjdj的中文名称：保存案件登记
     * <p/>
     * saveAjdj的概要说明：
     *
     * @param dto
     * @return Written by : gjf
     */

    public String saveZfwsadd(HttpServletRequest request, ZfajzfwsDTO dto) throws Exception {
        try {
            saveZfwsaddImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void saveZfwsaddImp(HttpServletRequest request, ZfajzfwsDTO dto)
            throws Exception {

        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        if (vSysUser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
            vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
        }
        SjbService v_SjbService = new SjbService();
        if (vSysUser == null) {
            List<?> userList = v_SjbService.queryUser(dto.getUserid().toString());
            if (userList != null) {
                vSysUser = (Sysuser) userList.get(0);
            }
        }

        String[] v_fjcsdmzlist = dto.getFjcsdmzlist().split(",");
        String v_ajzfwsid = "";

        String v_dbtime = SysmanageUtil.getDbtimeYmdHns();

        for (int i = 0; i < v_fjcsdmzlist.length; i++) {
            v_ajzfwsid = DbUtils.getSequenceStr();
            Zfajzfws v_zfajzfws = new Zfajzfws();
            v_zfajzfws.setZfwsqtbid(dto.getZfwsqtbid());//gu201806011
            v_zfajzfws.setAjzfwsid(v_ajzfwsid);
            v_zfajzfws.setAjdjid(dto.getAjdjid());
            v_zfajzfws.setZfwsdmz(v_fjcsdmzlist[i]);
            v_zfajzfws.setZfwstzbz("0");
            v_zfajzfws.setZfwsuserid(vSysUser.getUserid());
            v_zfajzfws.setZfwsczyxm(vSysUser.getDescription());
            v_zfajzfws.setZfwsczsj(v_dbtime);
            v_zfajzfws.setPsbh(dto.getPsbh());
            v_zfajzfws.setNodeid(dto.getNodeid());
            v_zfajzfws.setNodename(dto.getNodename());

            // v_zfajzfws.setZfwsid(dto.getZfwsid());
            dao.insert(v_zfajzfws);
        }
    }

    /**
     * saveZfwsaddFromZfwsnode的中文名称：根据执法案件执法文书和流程节点对照表 来增加文书
     * <p/>
     * saveZfwsaddFromZfwsnode的概要说明：
     *
     * @param dto
     * @return Written by : gjf
     */

    public String saveZfwsaddFromZfwsnode(HttpServletRequest request,
                                          ZfajzfwsDTO dto) {
        try {
            saveZfwsaddFromZfwsnodeImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @SuppressWarnings("unchecked")
    @Aop({"trans"})
    public void saveZfwsaddFromZfwsnodeImp(HttpServletRequest request,
                                           ZfajzfwsDTO dto) throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        String v_sql = "select a.* from zfajzfwsnode a where a.psbh='"
                + dto.getPsbh() + "' and a.nodeid='" + dto.getNodeid() + "'";
        List<Zfajzfwsnode> v_zfajzfwsnode = DbUtils.getDataList(v_sql,
                Zfajzfwsnode.class);
        String v_ajzfwsid = "";
        String v_dbtime = SysmanageUtil.getDbtimeYmdHns();

        for (Zfajzfwsnode mynode : v_zfajzfwsnode) {
            v_ajzfwsid = DbUtils.getSequenceStr();
            Zfajzfws v_zfajzfws = new Zfajzfws();
            v_zfajzfws.setAjzfwsid(v_ajzfwsid);
            v_zfajzfws.setAjdjid(dto.getAjdjid());
            v_zfajzfws.setZfwsdmz(mynode.getZfwsdmz());
            v_zfajzfws.setZfwstzbz("0");
            v_zfajzfws.setZfwsuserid(vSysUser.getUserid());
            v_zfajzfws.setZfwsczyxm(vSysUser.getDescription());
            v_zfajzfws.setZfwsczsj(v_dbtime);
            v_zfajzfws.setPsbh(dto.getPsbh());
            v_zfajzfws.setNodeid(dto.getNodeid());
            v_zfajzfws.setNodename(dto.getNodename());

            // v_zfajzfws.setZfwsid(dto.getZfwsid());
            dao.insert(v_zfajzfws);
        }

    }

    /**
     * delZfws的中文名称：删除案件登记执法文书
     * <p/>
     * delZfws的概要说明：
     *
     * @param dto
     * @return Written by : gjf
     */
    public String delZfws(HttpServletRequest request, ZfajzfwsDTO dto) {
        try {
            if (null != dto.getAjzfwsid()) {
                // // 检查是否可删除
                // List sysuserList = dao.query(Zfajdj.class, Cnd.wrap(dto
                // .getAjdjid()
                // + " in ('0','1','2','3','4')"));
                // if (sysuserList != null && sysuserList.size() > 0) {
                // return "不允许删除系统预置标准用户！";
                // }
                delZfwsImp(request, dto);
            } else {
                return "没有接收到要删除的案件执法文书ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    @SuppressWarnings({"unchecked"})
    public void delZfwsImp(HttpServletRequest request, ZfajzfwsDTO dto) throws Exception {
        // 删除对应的表中数据
        Zfajzfws v_zfajzfws = dao.fetch(Zfajzfws.class, Cnd.where("ajzfwsid",
                "=", dto.getAjzfwsid()));
        if (v_zfajzfws == null) {
            throw new BusinessException("根据" + dto.getAjzfwsid()
                    + "没获取执法文书数据 ！");
        }
        String v_zfwsdmz = v_zfajzfws.getZfwsdmz();
        String v_zfwsqtbid = v_zfajzfws.getZfwsqtbid();
        if(v_zfwsqtbid!=null){
            // 还要删除模板表
            dao.clear(Zfajzfwsmb.class, Cnd.where("zfwsqtbid", "=", v_zfwsqtbid));

            String v_sql = "select * from pfjcs where fjcsdmlb='ZFAJZFWS' and fjcsdmz='" +
                    v_zfwsdmz + "'";
            List<PfjcsDTO> v_PfjcsList = (List<PfjcsDTO>) DbUtils.getDataList(v_sql, PfjcsDTO.class);
            PfjcsDTO v_PfjcsDTO = v_PfjcsList.get(0);
            if (v_PfjcsDTO != null) {
                v_sql = "delete from " + v_PfjcsDTO.getZfwstabname() +
                        " where " + v_PfjcsDTO.getZfwstabid() +
                        " = '" + v_zfwsqtbid + "'";
            }

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
        }



//		if ("ZFAJZFWS01".equalsIgnoreCase(v_zfwsdmz)) {// 案件来源登记表
//			dao.clear(Zfwsajlydjb.class, Cnd.where("zfwslydjid", "=",
//					v_zfwsqtbid));
//		}else if ("ZFAJZFWS02".equalsIgnoreCase(v_zfwsdmz)){
//			dao.clear(Zfwslaspb2.class, Cnd.where("zfwslydjid", "=",
//					v_zfwsqtbid));
//		}
        // 删除执法文书
        dao.clear(Zfajzfws.class, Cnd.where("ajzfwsid", "=", dto
                .getAjzfwsid()));

    }
    public String delZfws_MOBILEZFWS(HttpServletRequest request, ZfajzfwsDTO dto) {
        try {
            if (null != dto.getAjzfwsid()) {
                delZfwsImp_delZfws_MOBILEZFWS(request, dto);
            } else {
                return "没有接收到要删除的案件执法文书ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop({"trans"})
    @SuppressWarnings({"unchecked"})
    public void delZfwsImp_delZfws_MOBILEZFWS(HttpServletRequest request, ZfajzfwsDTO dto) throws Exception {
        // 删除对应的表中数据
        Zfajzfws v_zfajzfws = dao.fetch(Zfajzfws.class, Cnd.where("ajzfwsid",
                "=", dto.getAjzfwsid()));
        if (v_zfajzfws == null) {
            throw new BusinessException("根据" + dto.getAjzfwsid()
                    + "没获取执法文书数据 ！");
        }
        String v_zfwsdmz = v_zfajzfws.getZfwsdmz();
        String v_zfwsqtbid = v_zfajzfws.getZfwsqtbid();
        if(v_zfwsqtbid!=null){
            // 还要删除模板表
            dao.clear(Zfajzfwsmb.class, Cnd.where("zfwsqtbid", "=", v_zfwsqtbid));

            String v_sql = "select * from pfjcs where fjcsdmlb='MOBILEZFWS' and fjcsdmz='" +
                    v_zfwsdmz + "'";
            List<PfjcsDTO> v_PfjcsList = (List<PfjcsDTO>) DbUtils.getDataList(v_sql, PfjcsDTO.class);
            PfjcsDTO v_PfjcsDTO = v_PfjcsList.get(0);
            if (v_PfjcsDTO != null) {
                v_sql = "delete from " + v_PfjcsDTO.getZfwstabname() +
                        " where " + v_PfjcsDTO.getZfwstabid() +
                        " = '" + v_zfwsqtbid + "'";
            }

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
        }
        dao.clear(Zfajzfws.class, Cnd.where("ajzfwsid", "=", dto
                .getAjzfwsid()));

    }
    /**
     * queryZfwsajlydjbList的中文名称：执法文书：案件来源登记表
     * <p/>
     * queryZfwsajlydjbList的概要说明：执法文书：案件来源登记表
     *
     * @param dto
     * @return
     * @throws Exception Written by : gjf
     */
    @SuppressWarnings({"rawtypes", "unused"})
    public Object queryZfwsajlydjbObj(HttpServletRequest request,
                                      ZfwsajlydjbDTO dto) throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

        if (!StringHelper.strisnull(dto.getZfwsqtbid())) {
            dto.setZfwslydjid(dto.getZfwsqtbid());
        }

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwsajlydjb a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("   and zfwslydjid = :zfwslydjid ");

        String[] ParaName = new String[]{"ajdjid", "zfwslydjid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils
                .DataQuery(GlobalNames.sql, sql, null, Zfwsajlydjb.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        ZfajdjDTO v_zfajdjdto = new ZfajdjDTO();
        // String v_dbtime=SysmanageUtil.getDbtime();
        if (queryZfajdj(dto.getAjdjid().toString()) == null) {
            v_zfajdjdto = null;
        } else {
            v_zfajdjdto = (ZfajdjDTO) queryZfajdj(
                    dto.getAjdjid().toString()).get(0);
        }

        ZfwsajlydjbDTO v_ZfwsajlydjbDTO = new ZfwsajlydjbDTO();

        if (ls != null && ls.size() > 0) {
            Zfwsajlydjb v_Zfwsajlydjb = (Zfwsajlydjb) ls.get(0);
            BeanHelper.copyProperties(v_Zfwsajlydjb, v_ZfwsajlydjbDTO);
        }

        if (v_zfajdjdto != null && (dto.getZfwslydjid() == null
                || "".equals(dto.getZfwslydjid()) || "null".equalsIgnoreCase(dto.getZfwslydjid()))) {// 默认值
            // v_ZfwsajlydjbDTO=(ZfwsajlydjbDTO) ls.get(k);
            v_ZfwsajlydjbDTO.setAjdjid(v_zfajdjdto.getAjdjid());// 案件登记ID
            v_ZfwsajlydjbDTO.setAjlywsbh(v_zfajdjdto.getAjdjbh());// 案件登记编号，手工填写
            v_ZfwsajlydjbDTO.setAjdjajly(v_zfajdjdto.getAjdjajly());// 案件来源
            v_ZfwsajlydjbDTO.setAjlydsr(v_zfajdjdto.getCommc());// 当事人
            v_ZfwsajlydjbDTO.setAjlydz(v_zfajdjdto.getComdz());// 地址
            v_ZfwsajlydjbDTO.setAjlyyb(v_zfajdjdto.getComyzbm());// 邮编
            v_ZfwsajlydjbDTO.setAjlyfddbr(v_zfajdjdto.getComfrhyz());// '法定代表人（负责人）/自然人,
            v_ZfwsajlydjbDTO.setAjlylxdh(v_zfajdjdto.getComyddh());// 联系电话,
            v_ZfwsajlydjbDTO.setAjlyfddbrsfzh(v_zfajdjdto.getComfrsfzh());// 法定代表人（负责人）/自然人身份证号,
            v_ZfwsajlydjbDTO.setAjlydjsj(v_zfajdjdto.getAjdjafsj());// 登记时间
            v_ZfwsajlydjbDTO.setAjlyjbqkjs(v_zfajdjdto.getAjdjjbqk());// 基本情况介绍,
            v_ZfwsajlydjbDTO.setAjlyjlrqz(v_zfajdjdto.getAjdjczy());// 记录人',
            v_ZfwsajlydjbDTO.setAjlyjlrqzrq(v_zfajdjdto.getAjdjczsj());// 记录时间
            v_ZfwsajlydjbDTO.setAjdjajlystr(v_zfajdjdto.getAjdjajlystr());
            v_ZfwsajlydjbDTO.setAjlyfj("（现场检查笔录、投诉举报材料、检测（检验）报告、相关部门移送材料等）");
//			  ajlyclyj varchar(500) DEFAULT NULL COMMENT '处理意见',
//			  ajlyfzr varchar(20) DEFAULT NULL COMMENT '负责人',
//			  ajlyfzrqzsj datetime DEFAULT NULL COMMENT '负责人签字时间',
        }

        return v_ZfwsajlydjbDTO;
    }

    /**
     * queryZfwsajlydjbList的中文名称：执法文书：案件来源登记表
     * <p/>
     * queryZfwsajlydjbList的概要说明：执法文书：案件来源登记表
     *
     * @param dto
     * @return
     * @throws Exception Written by : gjf
     */
    @SuppressWarnings({"unused", "rawtypes"})
    public Object queryZfwsajlydjbObjForPrint(HttpServletRequest request,
                                              ZfwsajlydjbDTO dto) throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwsajlydjb a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and zfwslydjid = :zfwslydjid ");

        String[] ParaName = new String[]{"zfwslydjid"};
        int[] ParaType = new int[]{Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils
                .DataQuery(GlobalNames.sql, sql, null, Zfwsajlydjb.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        ZfwsajlydjbDTO v_ZfwsajlydjbDTO = new ZfwsajlydjbDTO();
        if (ls != null && ls.size() > 0) {
            Zfwsajlydjb v_Zfwsajlydjb = (Zfwsajlydjb) ls.get(0);
            BeanHelper.copyProperties(v_Zfwsajlydjb, v_ZfwsajlydjbDTO);
        }
        return v_ZfwsajlydjbDTO;
    }

    /**
     * queryZfwsajlydjbPrintDataList的中文名称：执法文书：案件来源登记表打印数据
     * <p/>
     * queryZfwsajlydjbPrintDataList的概要说明：执法文书：案件来源登记表打印数据
     *
     * @param dto
     * @return
     * @throws Exception Written by : gjf
     */
    @SuppressWarnings({"rawtypes", "unused"})
    public List queryZfwsajlydjbPrintDataList(HttpServletRequest request,
                                              ZfwsajlydjbDTO dto) throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwsajlydjb a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");

        String[] ParaName = new String[]{"ajdjid"};
        int[] ParaType = new int[]{Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ZfwsajlydjbDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        return ls;
    }

    /**
     * queryZfwsajlydjbDTO的中文名称：查询执法文书案件来源登记表
     * <p/>
     * queryZfwsajlydjbDTO的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : gjf
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryZfwsajlydjbDTO(ZfwsajlydjbDTO dto, PagesDTO pd)
            throws Exception {

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwsajlydjb a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");

        String[] ParaName = new String[]{"ajdjid"};
        int[] ParaType = new int[]{Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ZfwsajlydjbDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        ZfwsajlydjbDTO v_ZfwsajlydjbDTO = new ZfwsajlydjbDTO();
        if (ls != null && ls.size() > 0) {
            v_ZfwsajlydjbDTO = (ZfwsajlydjbDTO) ls.get(0);
        } else {
            ZfajdjDTO v_zfajdjdto = (ZfajdjDTO) queryZfajdj(
                    dto.getAjdjid().toString()).get(0);
            if (v_zfajdjdto != null) {
                v_ZfwsajlydjbDTO.setAjdjid(v_zfajdjdto.getAjdjid());// 案件登记ID
                v_ZfwsajlydjbDTO.setAjlywsbh(v_zfajdjdto.getAjdjbh());// 案件登记编号，手工填写
                v_ZfwsajlydjbDTO.setAjdjajly(v_zfajdjdto.getAjdjajly());// 案件来源
                v_ZfwsajlydjbDTO.setAjlydsr(v_zfajdjdto.getCommc());// 当事人
                v_ZfwsajlydjbDTO.setAjlydz(v_zfajdjdto.getComdz());// 地址
                v_ZfwsajlydjbDTO.setAjlyyb(v_zfajdjdto.getComyzbm());// 邮编
                v_ZfwsajlydjbDTO.setAjlyfddbr(v_zfajdjdto.getComfrhyz());// '法定代表人（负责人）/自然人,
                v_ZfwsajlydjbDTO.setAjlylxdh(v_zfajdjdto.getComyddh());// 联系电话,
                v_ZfwsajlydjbDTO.setAjlyfddbrsfzh(v_zfajdjdto.getComfrsfzh());// 法定代表人（负责人）/自然人身份证号,
                v_ZfwsajlydjbDTO.setAjlydjsj(v_zfajdjdto.getAjdjafsj());// 登记时间
                v_ZfwsajlydjbDTO.setAjlyjbqkjs(v_zfajdjdto.getAjdjjbqk());// 基本情况介绍,
                v_ZfwsajlydjbDTO.setAjlyjlrqz(v_zfajdjdto.getAjdjczy());// 记录人',
                v_ZfwsajlydjbDTO.setAjlyjlrqzrq(v_zfajdjdto.getAjdjczsj());// 记录时间
                v_ZfwsajlydjbDTO.setAjdjajlystr(v_zfajdjdto.getAjdjajlystr());

//				  ajlyclyj varchar(500) DEFAULT NULL COMMENT '处理意见',
//				  ajlyfzr varchar(20) DEFAULT NULL COMMENT '负责人',
//				  ajlyfzrqzsj datetime DEFAULT NULL COMMENT '负责人签字时间',
            }

            ls.add(v_ZfwsajlydjbDTO);
        }

        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * saveZfwsajlydjb的中文名称：保存执法文书案件来源登记表
     * <p/>
     * saveZfwsajlydjb的概要说明：
     *
     * @param dto
     * @return Written by : gjf
     */

    public String saveZfwsajlydjb(HttpServletRequest request, ZfwsajlydjbDTO dto) {
        try {
            saveZfwsajlydjbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void saveZfwsajlydjbImp(HttpServletRequest request,
                                   ZfwsajlydjbDTO dto) throws Exception {
        if ("".equals(dto.getAjlyjlrqzrq())) {
            dto.setAjlyjlrqzrq(null);
        }
        if ("".equals(dto.getAjlyfzrqzsj())) {
            dto.setAjlyfzrqzsj(null);
        }
        if ("".equals(dto.getAjlydjsj())) {
            dto.setAjlydjsj(null);
        }
        if (null != dto.getZfwslydjid() && !"".equals(dto.getZfwslydjid())) {
            Zfwsajlydjb se = dao.fetch(Zfwsajlydjb.class, dto.getZfwslydjid());
            se.setAjlywsbh(dto.getAjlywsbh()); //ajlywsbh varchar(100) DEFAULT NULL COMMENT '文书编号',
            se.setAjdjajly(dto.getAjdjajly()); //ajdjajly varchar(2) DEFAULT NULL COMMENT '案件来源',
            se.setAjlydsr(dto.getAjlydsr()); //ajlydsr varchar(200) DEFAULT NULL COMMENT '当事人',
            se.setAjlydz(dto.getAjlydz());//ajlydz varchar(200) DEFAULT NULL COMMENT '地址',
            se.setAjlyyb(dto.getAjlyyb());//ajlyyb varchar(6) DEFAULT NULL COMMENT '邮编',
            se.setAjlyfddbr(dto.getAjlyfddbr());//ajlyfddbr varchar(20) DEFAULT NULL COMMENT '法定代表人（负责人）自然人',
            se.setAjlylxdh(dto.getAjlylxdh());//ajlylxdh varchar(20) DEFAULT NULL COMMENT '联系电话',
            se.setAjlyfddbrsfzh(dto.getAjlyfddbrsfzh());//ajlyfddbrsfzh varchar(18) DEFAULT NULL COMMENT '法定代表人（负责人）自然人身份证号码',
            se.setAjlydjsj(dto.getAjlydjsj());//ajlydjsj datetime DEFAULT NULL COMMENT '登记时间',
            se.setAjlyjbqkjs(dto.getAjlyjbqkjs());//ajlyjbqkjs longtext DEFAULT NULL COMMENT '基本情况介绍',
            se.setAjlyfj(dto.getAjlyfj());//ajlyfj varchar(200) DEFAULT NULL COMMENT '附件',
            se.setAjlyjlrqz(dto.getAjlyjlrqz());//ajlyjlrqz varchar(20) DEFAULT NULL COMMENT '记录人签字',
            se.setAjlyjlrqzrq(dto.getAjlyjlrqzrq());//ajlyjlrqzrq datetime DEFAULT NULL COMMENT '记录人签字日期',
            se.setAjlyclyj(dto.getAjlyclyj());///ajlyclyj varchar(500) DEFAULT NULL COMMENT '处理意见',
            se.setAjlyfzr(dto.getAjlyfzr());//ajlyfzr varchar(20) DEFAULT NULL COMMENT '负责人',
            se.setAjlyfzrqzsj(dto.getAjlyfzrqzsj());//ajlyfzrqzsj datetime DEFAULT NULL COMMENT '负责人签字时间',

            dao.update(se);
        } else {
            // 判断案件文书对应关系表是否存在，不存在增加一条
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                ZfajzfwsDTO v_ZfajzfwsDTO = new ZfajzfwsDTO();
                v_ZfajzfwsDTO.setUserid(dto.getUserid());
                v_ZfajzfwsDTO.setAjdjid(dto.getAjdjid());
                v_ZfajzfwsDTO.setFjcsdmzlist("ZFAJZFWS01");
                dto.setZfwsdmz("ZFAJZFWS01");
                saveZfwsadd(request, v_ZfajzfwsDTO);
            }
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwsajlydjb v_Zfwsajlydjb = new Zfwsajlydjb();
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            v_Zfwsajlydjb.setZfwslydjid(vZfwslydjid);

            dao.insert(v_Zfwsajlydjb);

            dto.setZfwslydjid(vZfwslydjid);

            // 更新执法文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(vZfwslydjid)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajzfwsid='").append(dto.getAjzfwsid()).append("'");

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
        }
    }
    /**
     *
     * @param request
     * @param userid  用户ID
     * @param ajdjid 案件ID
     * @param zfajzfws 文书编号
     * @param sjordn 手机或电脑  2：手机  空:其他
     * @throws Exception
     */
    /*dto.setZfwsdmz("ZFAJZFWS01");
    addZfajzfws(request,dto.getUserid(),dto.getAjdjid(),dto.getZfwsdmz(),dto.getSjordn());					*/
  /* public void  addZfajzfws(HttpServletRequest request,String userid,String ajdjid,String zfajzfws,String sjordn)
               throws Exception{

	   if( Strin3tils.isEmpty(userid)
		 ||StringUtils.isEmpty(ajdjid)
		 ||StringUtils.isEmpty(zfajzfws)
	   ){
		   StringBuffer message = new StringBuffer("");
		   if(StringUtils.isEmpty(userid)){
			   message.append("用户ID【userid】不能为空!");
		   }
		   if(StringUtils.isEmpty(ajdjid)){
			   message.append("案件ID【ajdjid】不能为空!");
		   }
		   if(StringUtils.isEmpty(zfajzfws)){
			   message.append("文书编号【zfajzfws】不能为空!");
		   }
		   throw new BusinessException("保存案件文书对应信息时:"+message.toString());

       }else{
    	   if (sjordn!=null || "2".endsWith(sjordn)){
   			ZfajzfwsDTO v_ZfajzfwsDTO=new ZfajzfwsDTO();
   			v_ZfajzfwsDTO.setUserid(userid);
   			v_ZfajzfwsDTO.setAjdjid(ajdjid);
   			v_ZfajzfwsDTO.setFjcsdmzlist(zfajzfws);
   			saveZfwsadd(request,v_ZfajzfwsDTO);
   			}
   		   }
       }*/

    /**
     * queryZfwssxfzlaysspbObj的中文名称：执法文书：4案件涉嫌犯罪案件移送审批表
     * <p/>
     * queryZfwssxfzlaysspbObj的概要说明：执法文书：4查询涉嫌犯罪案件移送审批表中的内容
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings("rawtypes")
    //TODO 文书4
    public Object queryZfwssxfzlaysspbObj(HttpServletRequest request,
                                          Zfwssxfzajysspb4DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        };
        // 案件涉嫌犯罪案件移送审批表id
        String fzysspid = request.getParameter("zfwsqtbid");
        if (fzysspid != null && !"".equals(fzysspid) && !"undefined".equals(fzysspid)) {
            dto.setFzysspid(fzysspid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" ,(select getAa10_aaa103('AJDJAJLY',a.ajdjajly)) as ajdjajlystr ");
        sb.append("  from zfwssxfzajysspb4 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("  and a.fzysspid = :fzysspid");
        String[] ParaName = new String[]{"ajdjid", "fzysspid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwssxfzajysspb4DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        // 查询执法案件登记信息
//		ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
        ZfajdjDTO v_zfajdj = new ZfajdjDTO();
        Zfwssxfzajysspb4DTO zfwssxfzajysspb4DTO = new Zfwssxfzajysspb4DTO();

        if (ls != null && ls.size() > 0) {
            zfwssxfzajysspb4DTO = (Zfwssxfzajysspb4DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                zfwssxfzajysspb4DTO.setAjdjay(v_zfajdj.getAjdjay());
                zfwssxfzajysspb4DTO.setAjdjajly(v_zfajdj.getAjdjajly());

            } else {
                v_zfajdj = null;
            }
        }
        return zfwssxfzajysspb4DTO;
    }

    /**
     * queryZfajdj的中文名称：4案件涉嫌犯罪案件移送审批表提交
     * <p/>
     * queryZfajdj的概要说明：4案件涉嫌犯罪案件移送审批表提交
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwssxfzlaysspb(HttpServletRequest request,
                                      Zfwssxfzajysspb4DTO dto) {
        String fzysspid = null;
        try {
            fzysspid = saveZfwssxfzlaysspbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return fzysspid;
    }

    @Aop({"trans"})
    public String saveZfwssxfzlaysspbImp(HttpServletRequest request,
                                         Zfwssxfzajysspb4DTO dto) throws Exception {
        if ("".equals(dto.getJbrqzrq())) {
            dto.setJbrqzrq(null);
        }
        if ("".equals(dto.getCbbmfzrqzrq())) {
            dto.setCbbmfzrqzrq(null);
        }
        if ("".equals(dto.getSpfzrqzrq())) {
            dto.setSpfzrqzrq(null);
        }
        if ("".equals(dto.getFgfzrqzrq())) {
            dto.setFgfzrqzrq(null);
        }
        if ("" != dto.getFzysspid() && dto.getFzysspid() != null) {
            Zfwssxfzajysspb4 se = dao.fetch(Zfwssxfzajysspb4.class, dto
                    .getFzysspid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getFzysspid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwssxfzajysspb4 v_Zfwsajlydjb = new Zfwssxfzajysspb4();
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            v_Zfwsajlydjb.setFzysspid(vZfwslydjid);
            dao.insert(v_Zfwsajlydjb);

            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return vZfwslydjid;

        }
    }

    /**
     * queryZfwssxfzlaysspbObj的中文名称：执法文书：5涉嫌犯罪案件移送书
     * <p/>
     * queryZfwssxfzlaysspbObj的概要说明：执法文书：5查询涉嫌犯罪案件移送书中的内容
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings({"rawtypes", "unused"})
    //TODO 文书5
    public Object queryZfwssxfzajyssObj(HttpServletRequest request,
                                        Zfwssxfzajyss5DTO dto) throws Exception {

        String sxfzysid = request.getParameter("zfwsqtbid");
        if (sxfzysid != null && !"".equals(sxfzysid) && !"undefined".equals(sxfzysid)) {
            dto.setSxfzysid(sxfzysid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwssxfzajyss5 a ");
        sb.append(" where 1 = 1 ");
        if(!"".equals(dto.getAjdjid())){
            sb.append("   and ajdjid = :ajdjid ");
        }
        sb.append("  and a.sxfzysid = :sxfzysid");

        String[] ParaName = new String[]{"ajdjid","sxfzysid"};
        int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwssxfzajyss5.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        // 执法案件查询
//		ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
        ZfajdjDTO v_zfajdj = new ZfajdjDTO();
        if (queryZfajdj(dto.getAjdjid()) == null) {
            v_zfajdj = null;
        } else {
            v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
        }
        Zfwssxfzajyss5DTO zfwssxfzajyss5DTO = new Zfwssxfzajyss5DTO();

        if (ls != null && ls.size() > 0) {
            Zfwssxfzajyss5 zfwssxfzajyss5 = (Zfwssxfzajyss5) ls.get(0);
            BeanHelper.copyProperties(zfwssxfzajyss5, zfwssxfzajyss5DTO);
        } else {
            zfwssxfzajyss5DTO
                    .setWsbh("（&times;&times;）食药监&times;罪移〔年份〕&times;号");
            zfwssxfzajyss5DTO.setSysbmmc("（×××）");
        }
        return zfwssxfzajyss5DTO;
    }

    /**
     * queryZfajdj的中文名称：5案件涉嫌犯罪案件移送审批表提交
     * <p/>
     * queryZfajdj的概要说明：5案件涉嫌犯罪案件移送审批表提交
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwssxfzajyss(HttpServletRequest request,
                                    Zfwssxfzajyss5DTO dto) {
        String sxfzysid = null;
        try {
            sxfzysid = saveZfwssxfzajyssImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return sxfzysid;
    }

    @Aop({"trans"})
    public String saveZfwssxfzajyssImp(HttpServletRequest request,
                                       Zfwssxfzajyss5DTO dto) throws Exception {
        if ("".equals(dto.getYsrq())) {
            dto.setYsrq(null);
        }
        if (null != dto.getSxfzysid() && !"".equals(dto.getSxfzysid())) {
            Zfwssxfzajyss5 se = dao.fetch(Zfwssxfzajyss5.class, dto
                    .getSxfzysid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getSxfzysid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwssxfzajyss5 v_Zfwsajlydjb = new Zfwssxfzajyss5();
            dto.setSxfzysid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * queryZfwssxfzlaysspbObj的中文名称：执法文书：9案件调查终结报告
     * <p/>
     * queryZfwssxfzlaysspbObj的概要说明：执法文书：9查询案件调查终结报告的内容
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings({"rawtypes", "unused"})
    //TODO  文书9
    public Object queryZfwsajdczjbg9Obj(HttpServletRequest request,
                                        Zfwsajdczjbg9DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        String ajdczjbgid = request.getParameter("zfwsqtbid");

        if (ajdczjbgid != null && !"".equals(ajdczjbgid) && !"undefined".equals(ajdczjbgid)) {
            dto.setAjdczjbgid(ajdczjbgid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwsajdczjbg9 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("  and a.ajdczjbgid = :ajdczjbgid");
        String[] ParaName = new String[]{"ajdjid", "ajdczjbgid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsajdczjbg9.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        // 案件登记查询
        ZfajdjDTO v_zfajdj = new ZfajdjDTO();

        Zfwsajdczjbg9DTO zfwsajdczjbg9DTO = new Zfwsajdczjbg9DTO();
        //list集合
        if (ls != null && ls.size() > 0) {
            Zfwsajdczjbg9 zfwsajdczjbg9 = (Zfwsajdczjbg9) ls.get(0);
            BeanHelper.copyProperties(zfwsajdczjbg9, zfwsajdczjbg9DTO);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                //违法事实
                if (null != dto.getAjdjid() && "".equals(dto.getAjdjid())) {//如果案件登记id不为空  判断违法事实有没有内容
                    if (null != v_zfajdj.getAjdjwfss() && "".equals(v_zfajdj.getAjdjwfss())) {
                        if (dto.getDczjwfss() == null || dto.getDczjwfss() == "") {//判断dto在查询的时候是不是有值
                            zfwsajdczjbg9DTO.setDczjwfss(v_zfajdj.getAjdjwfss());//案件登记违法事实     已有内容进行获取
                        }
                    }
                }
                zfwsajdczjbg9DTO.setAjdjay(v_zfajdj.getAjdjay());
            }
        }
        return zfwsajdczjbg9DTO;
    }

    /**
     * queryZfajdj的中文名称：9案件调查终结报告
     * <p/>
     * queryZfajdj的概要说明：9案件调查终结报告表提交
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwsajdczjbg9(HttpServletRequest request,
                                    Zfwsajdczjbg9DTO dto) {
        String zjbgid = null;
        try {
            zjbgid = saveZfwsajdczjbg9Imp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return zjbgid;
    }

    /**
     * saveZfwsajdczjbg9Imp的中文名称：
     * saveZfwsajdczjbg9Imp的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : lfy
     */
    @Aop({"trans"})
    public String saveZfwsajdczjbg9Imp(HttpServletRequest request, Zfwsajdczjbg9DTO dto) throws Exception {
        if ("".equals(dto.getDczjajcbrqzrq())) {
            dto.setDczjajcbrqzrq(null);
        }
        if (null != dto.getAjdczjbgid() && !"".equals(dto.getAjdczjbgid())) {
            Zfwsajdczjbg9 se = dao.fetch(Zfwsajdczjbg9.class, dto.getAjdczjbgid());
            //BeanHelper.copyProperties(dto, se);
            se.setAjdjid(dto.getAjdjid());//案件登记id
            se.setAjdjay(dto.getAjdjay());//案件登记案由
            se.setDczjdsrjbqk(dto.getDczjdsrjbqk());//当事人基本情况
            se.setDczjwfss(dto.getDczjwfss());//违法事实
            se.setDczjzjcl(dto.getDczjzjcl());//证据材料
            se.setDczjcfyj(dto.getDczjcfyj());//处罚依据
            se.setDczjcfjy(dto.getDczjcfjy());//处罚建议
            se.setDczjajcbrqz(dto.getDczjajcbrqz());//案件承办人签字
            se.setDczjwfflfgtk(dto.getDczjwfflfgtk());//违反法律法规条款
            se.setDczjwfxwdc(dto.getDczjwfxwdc());//违法行为等次
            se.setDczjysxzcfdyjhzl(dto.getDczjysxzcfdyjhzl());//应受行政处罚的依据和种类
            se.setAjdjay(dto.getAjdjay());//案由dczjajcbrqz2
            se.setDczjajcbrqz2(dto.getDczjajcbrqz2());//案件承办人2
            se.setAjdjay(dto.getAjdjay());
            se.setDczjajcbrqz2(dto.getDczjajcbrqz2());
            se.setDczjysxzcfdyjhzl(dto.getDczjysxzcfdyjhzl());
            se.setDczjwfxwdc(dto.getDczjwfxwdc());
            se.setDczjwfflfgtk(dto.getDczjwfflfgtk());
            se.setDczjajcbrqzrq(dto.getDczjajcbrqzrq());
            dao.update(se);
            return dto.getAjdczjbgid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwsajdczjbg9 v_Zfwsajlydjb = new Zfwsajdczjbg9();
            dto.setAjdczjbgid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            System.out.println(dto.getDczjwfss());//违法事实
            if (null != dto.getDczjwfss() && !"".equals(dto.getDczjwfss())) {//判断dto在查询的时候是不是有值
                // 案件登记查询

                ZfajdjDTO v_zfajdj = new ZfajdjDTO();
                if (queryZfajdj(dto.getAjdjid()) != null) {
                    v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                    if (v_zfajdj.getAjdjwfss() == null || "".equals(v_zfajdj.getAjdjwfss())) {//如果案件登记中的违法事实为空则更新违法事实内容
                        //根据案件登记id更新案件违法事实字段信息
                        String sbwfss = "update zfajdj a set a.ajdjwfss='" + dto.getDczjwfss()
                                + "' where a.ajdjid='" + dto.getAjdjid() + "'";
                        Sql sqlwfss = Sqls.create(sbwfss.toString());
                        dao.execute(sqlwfss);
                    }
                }
//				Zfajdj zfajdj=new Zfajdj();
//				zfajdj.setAjdjid(dto.getAjdjid());//获取案件登记id
//				zfajdj.setAjdjwfss(dto.getDczjwfss());//获取到终结报告的违法事实信息
//				dao.update(zfajdj);//根据案件登记id更新信息

            }
            dao.insert(v_Zfwsajlydjb);
            //更新为已填写信息
            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }

    }

    /**
     * queryZfwssxfzlaysspbObj的中文名称：执法文书：先行登记保存物品通知书10
     * <p/>
     * queryZfwssxfzlaysspbObj的概要说明：执法文书：查询先行登记保存物品通知书10
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    //TODO 文书10
    @SuppressWarnings("rawtypes")
    public Object queryZfwsxxdjbcwptzs10Obj(HttpServletRequest request,
                                            Zfwsxxdjbcwptzs10DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        String xxdjbcwptzsid = request.getParameter("zfwsqtbid");
        if (xxdjbcwptzsid != null && !"".equals(xxdjbcwptzsid) && !"undefined".equals(xxdjbcwptzsid)) {
            dto.setXxdjbcwptzsid(xxdjbcwptzsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append("  from Zfwsxxdjbcwptzs10 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and xxdjbcwptzsid = :xxdjbcwptzsid ");
        sb.append("   and ajdjid = :ajdjid ");
        String[] ParaName = new String[]{"xxdjbcwptzsid", "ajdjid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zfwsxxdjbcwptzs10DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwsxxdjbcwptzs10DTO zfwsxxdjbcwptzs10DTO = new Zfwsxxdjbcwptzs10DTO();

        if (ls != null && ls.size() > 0) {
            zfwsxxdjbcwptzs10DTO = (Zfwsxxdjbcwptzs10DTO) ls.get(0);
        } else {

            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                if (queryZfajdj(dto.getAjdjid()) != null) {
                    ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                    if (v_zfajdj != null) {
                        // 文书编号，默认从案件登记表中取案件登记编号
                        zfwsxxdjbcwptzs10DTO.setXztzwsbh(v_zfajdj.getAjdjbh());
                        // 当事人，默认从案件登记表中取公司名称
                        zfwsxxdjbcwptzs10DTO.setXztzdsr(v_zfajdj.getCommc());
                    }
                }
                // 查询先行登记保存物品清单
                Zfwswpqd37 v_qd = queryZfwswpqd(dto.getAjdjid(), "ZFAJZFWS3701");
                if (v_qd != null) {
                    // 先行登记保存物品清单文书编号，默认从先行登记保存物品清单表中取文书编号
                    zfwsxxdjbcwptzs10DTO.setXztzwpqdwsbh(v_qd.getWpqdwsbh());
                    // 附件信息，默认为先行登记保存物品清单文书
                    zfwsxxdjbcwptzs10DTO.setXztzfjxx(v_qd.getWpqdwsbh() + "《先行登记保存物品清单》");
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                zfwsxxdjbcwptzs10DTO.setXztzdsr(v_pcom.getCommc());
                Zfwswpqd37 v_qd = queryZfwswpqd(dto.getAjdjid(), "ZFAJZFWS3701");
                if (v_qd != null) {
                    // 先行登记保存物品清单文书编号，默认从先行登记保存物品清单表中取文书编号
                    zfwsxxdjbcwptzs10DTO.setXztzwpqdwsbh(v_qd.getWpqdwsbh());
                    // 附件信息，默认为先行登记保存物品清单文书
                    zfwsxxdjbcwptzs10DTO.setXztzfjxx(v_qd.getWpqdwsbh() + "《先行登记保存物品清单》");
                }
            }
        }
        if("1".equals(dto.getPrint())){
            zfwsxxdjbcwptzs10DTO.setCheckqm(request.getContextPath()+zfwsxxdjbcwptzs10DTO.getCheckqm());
        }
        return zfwsxxdjbcwptzs10DTO;
    }

    /**
     * queryZfwswpqd的中文名称：查询物品清单
     * <p/>
     * queryZfwswpqd的概要说明：
     *
     * @param parAjdjid
     * @param zfwsdmz
     * @return Written by : zy
     */
    public Zfwswpqd37 queryZfwswpqd(String parAjdjid, String zfwsdmz) {
        List<Zfwswpqd37> wpqdList = dao.query(Zfwswpqd37.class,
                Cnd.where("ajdjid", "=", parAjdjid).and("zfwsdmz", "=", zfwsdmz));
        Zfwswpqd37 wpqd = null;
        if (wpqdList != null && wpqdList.size() > 0) {
            wpqd = wpqdList.get(0);
        }
        return wpqd;
    }

    /**
     * queryZfajdj的中文名称：先行登记保存物品通知书10
     * <p/>
     * queryZfajdj的概要说明：先行登记保存物品通知书10提交
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwsxxdjbcwptzs10(HttpServletRequest request,
                                        Zfwsxxdjbcwptzs10DTO dto) {
        String xxdjbcwptzsid = null;
        try {
            xxdjbcwptzsid = saveZfwsxxdjbcwptzs10Imp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xxdjbcwptzsid;
    }

    @Aop({"trans"})
    public String saveZfwsxxdjbcwptzs10Imp(HttpServletRequest request,
                                           Zfwsxxdjbcwptzs10DTO dto) throws Exception {
        if ("".equals(dto.getXztzgzrq())) {
            dto.setXztzgzrq(null); // 盖章日期
        }
        if ("".equals(dto.getXztzdsrqzrq())) {
            dto.setXztzdsrqzrq(null); // 盖章日期
        }
        if ("".equals(dto.getXztzzfryqzrq())) {
            dto.setXztzzfryqzrq(null); // 盖章日期
        }
        if ("".equals(dto.getXztzbcqxksrq())) {
            dto.setXztzbcqxksrq(null); // 盖章日期
        }
        if ("".equals(dto.getXztzbcqxjsrq())) {
            dto.setXztzbcqxjsrq(null); // 盖章日期
        }
        if (null != dto.getXxdjbcwptzsid()
                && !"".equals(dto.getXxdjbcwptzsid())) {
            Zfwsxxdjbcwptzs10 se = dao.fetch(Zfwsxxdjbcwptzs10.class, dto.getXxdjbcwptzsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getXxdjbcwptzsid();
        } else {
            String v_id = DbUtils.getSequenceStr();
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS10");
                    v_Zfajzfws.setZfwsqtbid(v_id);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
            }
            Zfwsxxdjbcwptzs10 v_zfwsxxdjbcwptzs10 = new Zfwsxxdjbcwptzs10();
            BeanHelper.copyProperties(dto, v_zfwsxxdjbcwptzs10);
            v_zfwsxxdjbcwptzs10.setXxdjbcwptzsid(v_id);
            dao.insert(v_zfwsxxdjbcwptzs10);
            String sb = "update zfajzfws a set a.zfwsqtbid='" + v_id
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwssxfzlaysspbObj的中文名称：执法文书：先行登记保存物品通知书11
     * <p/>
     * queryZfwssxfzlaysspbObj的概要说明：执法文书：先行登记保存物品处理决定书11
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    //TODO 文书11
    public Object queryZfwsxxdjbcwpcljds11Obj(HttpServletRequest request,
                                              Zfwsxxdjbcwpcljds11DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 先行处理决定书id
        String xxcljdsid = request.getParameter("zfwsqtbid");
        if (xxcljdsid != null && !"".equals(xxcljdsid) && !"undefined".equals(xxcljdsid)) {
            dto.setXxcljdsid(xxcljdsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwsxxdjbcwpcljds11 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("   and xxcljdsid = :xxcljdsid ");
        String[] ParaName = new String[]{"ajdjid", "xxcljdsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxxdjbcwpcljds11DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwsxxdjbcwpcljds11DTO v_zfwsxxdjbcwpcljds11DTO = new Zfwsxxdjbcwpcljds11DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwsxxdjbcwpcljds11DTO = (Zfwsxxdjbcwpcljds11DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记表
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 文书编号，默认从案件登记表中取案件登记编号
                    v_zfwsxxdjbcwpcljds11DTO.setXxclwsbh(v_zfajdj.getAjdjbh());
                    // 当事人，默认从案件登记表中取案件登记编号
                    v_zfwsxxdjbcwpcljds11DTO.setXxcldsr(v_zfajdj.getCommc());
                }
                // 查询食药监 登保处
                Zfwsxxdjbcwptzs10DTO z10 = new Zfwsxxdjbcwptzs10DTO();
                z10.setAjdjid(dto.getAjdjid());
                z10 = (Zfwsxxdjbcwptzs10DTO) queryZfwsxxdjbcwptzs10Obj(request, z10);
                if (z10 != null) {
                    // 通知书年月日，默认从先行登记保存物品通知书中取盖章日期
                    v_zfwsxxdjbcwpcljds11DTO.setXxcltzsnyr(z10.getXztzgzrq());
                    // 先行登记保存物品通知书文书编号，默认从先行登记保存物品通知书中取文书编号
                    v_zfwsxxdjbcwpcljds11DTO.setXxcltzswsbh(z10.getXztzwsbh());
                    // 附件信息，默认取先行登记保存物品通知书中记载的先行登记保存物品处理清单
                    v_zfwsxxdjbcwpcljds11DTO.setXxclfjxx(z10.getXztzwpqdwsbh() + "《先行登记保存物品处理清单》");
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                v_zfwsxxdjbcwpcljds11DTO.setXxcldsr(v_pcom.getCommc());
                // 查询食药监 登保处
                Zfwsxxdjbcwptzs10DTO z10 = new Zfwsxxdjbcwptzs10DTO();
                z10.setAjdjid(dto.getAjdjid());
//                z10.setOperatetype(dto.getOperatetype());
                if (queryZfwsxxdjbcwptzs10Obj(request, z10) != null) {
                    z10 = (Zfwsxxdjbcwptzs10DTO) queryZfwsxxdjbcwptzs10Obj(request, z10);
                    // 通知书年月日，默认从先行登记保存物品通知书中取盖章日期
                    v_zfwsxxdjbcwpcljds11DTO.setXxcltzsnyr(z10.getXztzgzrq());
                    // 先行登记保存物品通知书文书编号，默认从先行登记保存物品通知书中取文书编号
                    v_zfwsxxdjbcwpcljds11DTO.setXxcltzswsbh(z10.getXztzwsbh());
                    // 附件信息，默认取先行登记保存物品通知书中记载的先行登记保存物品处理清单
                    v_zfwsxxdjbcwpcljds11DTO.setXxclfjxx(z10.getXztzwpqdwsbh() + "《先行登记保存物品处理清单》");
                }
            }
        }

        return v_zfwsxxdjbcwpcljds11DTO;
    }

    /**
     * queryZfajdj的中文名称：先行登记保存物品处理决定书11
     * <p/>
     * queryZfajdj的概要说明：先行登记保存物品处理决定书11 修改或者新增
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwsxxdjbcwpcljds11(HttpServletRequest request,
                                          Zfwsxxdjbcwpcljds11DTO dto) {
        String xxcljdsid = null;
        try {
            xxcljdsid = saveZfwsxxdjbcwpcljds11Imp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xxcljdsid;
    }

    @Aop({"trans"})
    public String saveZfwsxxdjbcwpcljds11Imp(HttpServletRequest request,
                                             Zfwsxxdjbcwpcljds11DTO dto) throws Exception {
        // 盖章日期
        if ("".equals(dto.getXxclgzrq())) {
            dto.setXxclgzrq(null);
        }
        if ("".equals(dto.getXxclzfryqzrq())) {
            dto.setXxclzfryqzrq(null);
        }
        if ("".equals(dto.getXxcldsrqzrq())) {
            dto.setXxcldsrqzrq(null);
        }
        if (null != dto.getXxcljdsid() && !"".equals(dto.getXxcljdsid())) {
            Zfwsxxdjbcwpcljds11 se = dao.fetch(Zfwsxxdjbcwpcljds11.class, dto.getXxcljdsid());
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setXxcldsr(dto.getXxcldsr()); // 当事人
            se.setXxclfjxx(dto.getXxclfjxx()); // 附件信息
            se.setXxclgzrq(dto.getXxclgzrq()); // 盖章日期
            se.setXxcltzsnyr(dto.getXxcltzsnyr()); // 通知书年月日
            se.setXxcltzswsbh(dto.getXxcltzswsbh()); // 先行处理通知书文书编号
            se.setXxclwsbh(dto.getXxclwsbh()); // 文书编号
            se.setXxclwbnr(dto.getXxclwbnr()); // 文本内容
            se.setXxcldsrqz(dto.getXxcldsrqz()); // 当事人签字
            se.setXxcldsrqzrq(dto.getXxcldsrqzrq());// 当事人签字日期
            se.setXxclzfry1(dto.getXxclzfry1()); // 执法人员1
            se.setXxclzfry2(dto.getXxclzfry2()); // 执法人员2
            se.setXxclzfzh1(dto.getXxclzfzh1());  // 执法证号1
            se.setXxclzfzh2(dto.getXxclzfzh2());  // 执法证号2
            se.setXxclzfryqzrq(dto.getXxclzfryqzrq()); // 执法人员签字
            dao.update(se);
            return dto.getXxcljdsid();
        } else {
            String v_id = DbUtils.getSequenceStr();
            Zfwsxxdjbcwpcljds11 v_Zfwsajlydjb = new Zfwsxxdjbcwpcljds11();
            dto.setXxcljdsid(v_id);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + v_id
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * Zfwsft13Obj的中文名称：执法文书：封条13
     * <p/>
     * Zfwsft13Obj的概要说明：执法文书：查询封条信息
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings("rawtypes")
    public Object queryZfwsft13Obj(HttpServletRequest request, Zfwsft13DTO dto)
            throws Exception {

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwsft13 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");

        String[] ParaName = new String[]{"ajdjid"};
        int[] ParaType = new int[]{Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zfwsft13.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwsft13DTO zfwsft13DTO = new Zfwsft13DTO();

        if (ls != null && ls.size() > 0) {
            Zfwsft13 zfwsft13 = (Zfwsft13) ls.get(0);
            BeanHelper.copyProperties(zfwsft13, zfwsft13DTO);
        } else {
            Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMC");
            String fdq = v_aa01.getAaa005();
            zfwsft13DTO.setSpypjdgljmc(fdq);
        }

        return zfwsft13DTO;
    }

    /**
     * queryZfajdj的中文名称：保存封条信息 13
     * <p/>
     * queryZfajdj的概要说明：保存或者修改封条信息
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwsft13(HttpServletRequest request, Zfwsft13DTO dto) {
        try {
            saveZfwsft13Imp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void saveZfwsft13Imp(HttpServletRequest request, Zfwsft13DTO dto)
            throws Exception {
        if ("".equals(dto.getFtyzrq())) {
            dto.setFtyzrq(null);
        }
        if (null != dto.getFtid() && !"".equals(dto.getFtid())) {
            Zfwsft13 se = dao.fetch(Zfwsft13.class, dto.getFtid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwsft13 v_Zfwsajlydjb = new Zfwsft13();
            dto.setFtid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);

            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);

        }
    }

    /**
     * Zfwsft13Obj的中文名称：：解除查封（扣押）决定书17
     * <p/>
     * Zfwsft13Obj的概要说明：查询解除查封（扣押）决定书 17
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings({"unused", "rawtypes"})
    //TODO  文书17
    public Object queryZfwsjccfkyjds17bj(HttpServletRequest request,
                                         Zfwsjccfkyjds17DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }

        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        String jccfkyjdsid = request.getParameter("zfwsqtbid");

        if (jccfkyjdsid != null && !"".equals(jccfkyjdsid) && !"undefined".equals(jccfkyjdsid)) {
            dto.setJccfkyjdsid(jccfkyjdsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwsjccfkyjds17 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("  and a.jccfkyjdsid = :jccfkyjdsid");
        String[] ParaName = new String[]{"ajdjid", "jccfkyjdsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsjccfkyjds17.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Zfwsjccfkyjds17DTO zfwsjccfkyjds17DTO = new Zfwsjccfkyjds17DTO();
        // 执法文书查询


        // 查封（扣押）决定书查询
        if (ls != null && ls.size() > 0) {
            Zfwsjccfkyjds17 zfwsjccfkyjds17 = (Zfwsjccfkyjds17) ls.get(0);
            BeanHelper.copyProperties(zfwsjccfkyjds17, zfwsjccfkyjds17DTO);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                zfwsjccfkyjds17DTO.setJckydsr(v_zfajdj.getCommc());

            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                zfwsjccfkyjds17DTO.setJckydsr(v_pcom.getCommc());
            }
            //Zfwscfkyjds12 z12 = (Zfwscfkyjds12) queryZfwscfkyjds(dto.getAjdjid());
            if (queryZfwscfkyjds(dto.getAjdjid()) != null) {
                Zfwscfkyjds12 z12 = (Zfwscfkyjds12) queryZfwscfkyjds(dto.getAjdjid()).get(0);
                zfwsjccfkyjds17DTO.setJckykyrq(z12.getCfkyksrq());
                zfwsjccfkyjds17DTO.setJckykybh(z12.getCfkywsbh());
            }

            // 物品清单查询
            Zfwswpqd37 z37 = queryZfwswpqd37(dto.getAjdjid(), dto.getZfwsdmz());
            if (z37 != null) {
                zfwsjccfkyjds17DTO.setJckywpqdbh(z37.getWpqdwsbh());
                zfwsjccfkyjds17DTO.setJckyfj(z37.getWpqdwsbh());
            } else {
                //设置默认
                zfwsjccfkyjds17DTO.setJckywpqdbh("（××）食药监×解查扣〔年份〕×号");
                zfwsjccfkyjds17DTO.setJckyfj("（××）食药监×解查扣〔年份〕×号");
            }
            zfwsjccfkyjds17DTO.setJckydjx("《中华人民共和国行政强制法》第二十八条第一款第×项");
            zfwsjccfkyjds17DTO.setJckywsbh("（&times;&times;）食药监&times;解查扣〔年份〕&times;号");
        }
        return zfwsjccfkyjds17DTO;
    }

    /**
     * queryZfajdj的中文名称：解除查封（扣押）决定书 17
     * <p/>
     * queryZfajdj的概要说明：保存或者修改解除查封（扣押）决定书
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwsjccfkyjds17(HttpServletRequest request,
                                      Zfwsjccfkyjds17DTO dto) {
        String jccfkyjdsid = null;
        try {
            jccfkyjdsid = saveZfwsjccfkyjds17DTOImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return jccfkyjdsid;
    }

    @Aop({"trans"})
    public String saveZfwsjccfkyjds17DTOImp(HttpServletRequest request,
                                            Zfwsjccfkyjds17DTO dto) throws Exception {
        if ("".equals(dto.getJckygzrq())) {
            dto.setJckygzrq(null);
        }
        if ("".equals(dto.getJckykyrq())) {
            dto.setJckykyrq(null);
        }
        if ("".equals(dto.getJckydsrqzrq())) {
            dto.setJckydsrqzrq(null);
        }
        if (null != dto.getJccfkyjdsid() && !"".equals(dto.getJccfkyjdsid())) {
            Zfwsjccfkyjds17 se = dao.fetch(Zfwsjccfkyjds17.class, dto.getJccfkyjdsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getJccfkyjdsid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwsjccfkyjds17 v_Zfwsajlydjb = new Zfwsjccfkyjds17();
            dto.setJccfkyjdsid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * Zfwsft13Obj的中文名称：听证告知书 22
     * <p/>
     * Zfwsft13Obj的概要说明：：查询听证告知书
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings({"rawtypes"})
    //TODO  文书22
    public Object queryZfwstzgzs22Obj(HttpServletRequest request,
                                      Zfwstzgzs22DTO dto) throws Exception {

        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 听证告知书id
        String tzgzsid = request.getParameter("zfwsqtbid");
        if (tzgzsid != null && !"".equals(tzgzsid) && !"undefined".equals(tzgzsid)) {
            dto.setTzgzsid(tzgzsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" ,(select getAa10_aaa103('WFXWDC',a.tzgzwfxwdc)) as tzgzwfxwdcstr ");
        sb.append("  from Zfwstzgzs22 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("   and tzgzsid = :tzgzsid ");

        String[] ParaName = new String[]{"ajdjid", "tzgzsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils
                .DataQuery(GlobalNames.sql, sql, null, Zfwstzgzs22DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwstzgzs22DTO z22DTO = new Zfwstzgzs22DTO();
        if (ls != null && ls.size() > 0) {
            z22DTO = (Zfwstzgzs22DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 案件登记表查询
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 文书编号，默认从案件登记表中取案件登记编号
                    z22DTO.setTzgzwsbh(v_zfajdj.getAjdjbh());
                    // 当事人，默认从案件登记表中取企业名称
                    z22DTO.setTzgzdsr(v_zfajdj.getCommc());
                    // 立案时间，默认从案件登记表中取立案时间
                    z22DTO.setTzgzslasj(v_zfajdj.getLiansj());
                    // 案由，默认从案件登记表中取案由
                    z22DTO.setTzgzsay(v_zfajdj.getAjdjay());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 当事人，默认从案件登记表中取企业名称
                z22DTO.setTzgzdsr(v_pcom.getCommc());
            }
            // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
            Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
            z22DTO.setXzjgmc(v_aa01.getAaa005());
        }
        return z22DTO;
    }

    /**
     * queryZfajdj的中文名称：听证告知书 22
     * <p/>
     * queryZfajdj的概要说明：保存或者修改听证告知书
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwstzgzs22(HttpServletRequest request, Zfwstzgzs22DTO dto) {
        String tzgzsid = null;
        try {
            tzgzsid = saveZfwstzgzs22DTOImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return tzgzsid;
    }

    @Aop({"trans"})
    public String saveZfwstzgzs22DTOImp(HttpServletRequest request,
                                        Zfwstzgzs22DTO dto) throws Exception {
        if ("".equals(dto.getGzgzgzrq())) {
            dto.setGzgzgzrq(null);
        }
        if ("".equals(dto.getTzgzjsrq())) {
            dto.setTzgzjsrq(null);
        }
        if ("".equals(dto.getTzgzqsrq())) {
            dto.setTzgzqsrq(null);
        }
        if ("".equals(dto.getTzgzslasj())) {
            dto.setTzgzslasj(null);
        }
        if (null != dto.getTzgzsid() && !"".equals(dto.getTzgzsid())) {
            Zfwstzgzs22 se = dao.fetch(Zfwstzgzs22.class, dto.getTzgzsid());
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setGzgzdz(dto.getGzgzdz()); // 地址
            se.setGzgzgzrq(dto.getGzgzgzrq()); // 盖章日期
            se.setGzgzlxdh(dto.getGzgzlxdh()); // 联系电话
            se.setGzgzlxr(dto.getGzgzlxr()); // 联系人
            se.setGzgzyzbm(dto.getGzgzyzbm()); // 邮政编码
            se.setTzgzcfyjyzgd(dto.getTzgzcfyjyzgd()); // 处罚依据按照什么规定
            se.setTzgzdsr(dto.getTzgzdsr()); // 当事人
            se.setTzgzjsrq(dto.getTzgzjsrq()); // 结束日期（汤阴）
            se.setTzgzqsrq(dto.getTzgzqsrq()); // 开始日期（汤阴）
            se.setTzgzwfflfg(dto.getTzgzwfflfg()); // 违反的法律法规
            se.setTzgzwfxwdc(dto.getTzgzwfxwdc()); // 违法行为等次
            se.setTzgzwfxwms(dto.getTzgzwfxwms()); // 违法行为描述
            se.setTzgzwsbh(dto.getTzgzwsbh()); // 文书编号
            se.setTzgzxzcf(dto.getTzgzxzcf()); // 行政处罚
            se.setTzgzyjflfg(dto.getTzgzyjflfg()); // 依据法律法规
            se.setTzgzsay(dto.getTzgzsay()); // 案由
            se.setTzgzslasj(dto.getTzgzslasj()); // 立案时间
            se.setTzgzszmnr(dto.getTzgzszmnr()); // 证据所要证明内容
            se.setXzjgmc(dto.getXzjgmc()); // 行政机关名称
            se.setCzxzcfclbz(dto.getCzxzcfclbz()); // 参照行政处罚裁量标准
            dao.update(se);
            return dto.getTzgzsid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwstzgzs22 v_Zfwsajlydjb = new Zfwstzgzs22();
            dto.setTzgzsid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * Zfwsft13Obj的中文名称：听证意见书 25
     * <p/>
     * Zfwsft13Obj的概要说明：听证意见书 查询
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings({"rawtypes"})
    //TODO 文书25
    public Object queryZfwstzyjs25Obj(HttpServletRequest request,
                                      Zfwstzyjs25DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 听证意见书id
        String tzyjsid = request.getParameter("zfwsqtbid");
        if (tzyjsid != null && !"".equals(tzyjsid) && !"undefined".equals(tzyjsid)) {
            dto.setTzyjsid(tzyjsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwstzyjs25 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("   and tzyjsid = :tzyjsid ");

        String[] ParaName = new String[]{"ajdjid", "tzyjsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zfwstzyjs25DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwstzyjs25DTO z25DTO = new Zfwstzyjs25DTO();

        if (ls != null && ls.size() > 0) {
            z25DTO = (Zfwstzyjs25DTO) ls.get(0);
        } else { // 添加默认数据
            if ("ajdj".equals(v_operatetype)) {
                // 执法案件查询
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 案由，默认从案件登记表中取案由
                    z25DTO.setAjdjay(v_zfajdj.getAjdjay());
                    // 当事人，默认从案件登记表中取企业名称
                    z25DTO.setTzyjdsr(v_zfajdj.getCommc());
                    // 法定代表人，默认从案件登记表中取企业法人
                    z25DTO.setTzyjfddbr(v_zfajdj.getComfrhyz());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 当事人，默认从案件登记表中取企业名称
                z25DTO.setTzyjdsr(v_pcom.getCommc());
                // 法定代表人，默认从案件登记表中取企业法人
                z25DTO.setTzyjfddbr(v_pcom.getComfrhyz());
            }
        }
        return z25DTO;
    }

    /**
     * queryZfajdj的中文名称：听证意见书 25
     * <p/>
     * queryZfajdj的概要说明：保存或者修改听证意见书 25
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwstzyjs25(HttpServletRequest request, Zfwstzyjs25DTO dto) {
        String tzyjsid = null;
        try {
            tzyjsid = saveZfwstzyjs25DTOImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return tzyjsid;
    }

    @Aop({"trans"})
    public String saveZfwstzyjs25DTOImp(HttpServletRequest request,
                                        Zfwstzyjs25DTO dto) throws Exception {
        if ("".equals(dto.getTzyjtzjssj())) {
            dto.setTzyjtzjssj(null);
        }
        if ("".equals(dto.getTzyjtzkssj())) {
            dto.setTzyjtzkssj(null);
        }
        if ("".equals(dto.getTzyjzcrqzrq())) {
            dto.setTzyjzcrqzrq(null);
        }
        if (null != dto.getTzyjsid() && !"".equals(dto.getTzyjsid())) {
            Zfwstzyjs25 se = dao.fetch(Zfwstzyjs25.class, dto.getTzyjsid());
            se.setAjdjay(dto.getAjdjay()); // 案由
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setTzyj(dto.getTzyj()); // 听证意见
            se.setTzyjajjbqk(dto.getTzyjajjbqk()); // 案件基本情况
            se.setTzyjdsr(dto.getTzyjdsr()); // 当事人
            se.setTzyjfddbr(dto.getTzyjfddbr()); // 法定代表人
            se.setTzyjsqrzyly(dto.getTzyjsqrzyly()); // 申请人主要理由
            se.setTzyjtzfs(dto.getTzyjtzfs()); // 听证方式
            se.setTzyjtzjssj(dto.getTzyjtzjssj()); // 听证结束时间
            se.setTzyjtzkssj(dto.getTzyjtzkssj()); // 听证开始时间
            se.setTzyjtzzcr(dto.getTzyjtzzcr()); // 听证主持人
            se.setTzyjzcrqz(dto.getTzyjzcrqz()); // 听证主持人签字
            se.setTzyjzcrqzrq(dto.getTzyjzcrqzrq()); // 听证主持人签字日期
            dao.update(se);
            return dto.getTzyjsid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwstzyjs25 v_Zfwsajlydjb = new Zfwstzyjs25();
            dto.setTzyjsid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * queryZfwsxzcfsxgzs26Obj的中文名称：行政处罚事先告知书 26
     * <p/>
     * queryZfwsxzcfsxgzs26Obj的概要说明：行政处罚事先告知书 查询
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings({"rawtypes"})
    //TODO 文书26
    public Object queryZfwsxzcfsxgzs26Obj(HttpServletRequest request,
                                          Zfwsxzcfsxgzs26DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 行政处罚事先告知书id
        String xzcfsxgzsid = request.getParameter("zfwsqtbid");
        if (xzcfsxgzsid != null && !"".equals(xzcfsxgzsid) && !"undefined".equals(xzcfsxgzsid)) {
            dto.setXzcfsxgzsid(xzcfsxgzsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" ,(select getAa10_aaa103('WFXWDC',a.wfxwdc)) as wfxwdcstr ");
        sb.append("  from Zfwsxzcfsxgzs26 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("   and xzcfsxgzsid = :xzcfsxgzsid ");

        String[] ParaName = new String[]{"ajdjid", "xzcfsxgzsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfsxgzs26DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwsxzcfsxgzs26DTO z26DTO = new Zfwsxzcfsxgzs26DTO();

        if (ls != null && ls.size() > 0) {
            z26DTO = (Zfwsxzcfsxgzs26DTO) ls.get(0);
        } else { // 添加默认数据
            if ("ajdj".equals(v_operatetype)) {
                // 执法办案信息查询
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 立案时间，默认从案件登记表中取立案时间
                    z26DTO.setSxgzlasj(v_zfajdj.getLiansj());
                    // 案由，默认从案件登记表中取案由
                    z26DTO.setSxgzay(v_zfajdj.getAjdjay());
                    // 文书编号，默认从案件登记表中取案件登记编号
                    z26DTO.setSxgzwsbh(v_zfajdj.getAjdjbh());
                    // 当事人，默认从案件登记表中取企业名称
                    z26DTO.setSxgzdsr(v_zfajdj.getCommc());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 当事人，默认从案件登记表中取企业名称
                z26DTO.setSxgzdsr(v_pcom.getCommc());
            }
            // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
            Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
            z26DTO.setXzjgmc(v_aa01.getAaa005());
        }
        return z26DTO;
    }

    /**
     * saveZfwsxzcfsxgzs26的中文名称：行政处罚事先告知书 26
     * <p/>
     * saveZfwsxzcfsxgzs26的概要说明：保存或者修改行政处罚事先告知书 26
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwsxzcfsxgzs26(HttpServletRequest request,
                                      Zfwsxzcfsxgzs26DTO dto) {
        String xzcfsxgzsid = null;
        try {
            xzcfsxgzsid = saveZfwsxzcfsxgzs26DTOImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xzcfsxgzsid;
    }

    @Aop({"trans"})
    public String saveZfwsxzcfsxgzs26DTOImp(HttpServletRequest request,
                                            Zfwsxzcfsxgzs26DTO dto) throws Exception {
        if ("".equals(dto.getSxgzgzrq())) {
            dto.setSxgzgzrq(null);
        }
        if ("".equals(dto.getSxgzlasj())) {
            dto.setSxgzlasj(null);
        }
        if (null != dto.getXzcfsxgzsid() && !("").equals(dto.getXzcfsxgzsid())) {
            Zfwsxzcfsxgzs26 se = dao.fetch(Zfwsxzcfsxgzs26.class, dto.getXzcfsxgzsid());
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setSxgzcxdd(dto.getSxgzcxdd()); // 陈述地点
            se.setSxgzdsr(dto.getSxgzdsr()); // 当事人
            se.setSxgzgzrq(dto.getSxgzgzrq()); // 盖章日期
            se.setSxgzwfgd(dto.getSxgzwfgd()); // 依据规定
            se.setSxgzwfxw(dto.getSxgzwfxw()); // 违法行为
            se.setSxgzwsbh(dto.getSxgzwsbh()); // 事先告知文书编号
            se.setSxgzxzcf(dto.getSxgzxzcf()); // 行政处罚
            se.setSxgzyjgd(dto.getSxgzyjgd()); // 依据规定
            se.setWfxwdc(dto.getWfxwdc()); // 违法行为等次
            se.setSxgzay(dto.getSxgzay()); // 案由
            se.setSxgzlasj(dto.getSxgzlasj()); // 立案时间
            se.setSxgzlxdh(dto.getSxgzlxdh()); // 联系电话
            se.setSxgzxzcfclbz(dto.getSxgzxzcfclbz()); // 行政处罚裁量标准
            se.setSxgzxzjgdz(dto.getSxgzxzjgdz()); // 行政机关地址
            se.setSxgzxzjglxr(dto.getSxgzxzjglxr()); // 行政机关联系人
            se.setSxgzyzbm(dto.getSxgzyzbm()); // 邮政编码
            se.setSxgzzmnr(dto.getSxgzzmnr()); // 证据所要证明内容
            dao.update(se);
            return dto.getXzcfsxgzsid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwsxzcfsxgzs26 v_Zfwsajlydjb = new Zfwsxzcfsxgzs26();
            dto.setXzcfsxgzsid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);

            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * queryZfwsdcxzcfjds29Obj的中文名称：当场行政处罚决定书 29
     * <p/>
     * queryZfwsdcxzcfjds29Obj的概要说明：当场行政处罚决定书 查询
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings("rawtypes")
    //TODO 文书29
    public Object queryZfwsdcxzcfjds29Obj(HttpServletRequest request,
                                          Zfwsdcxzcfjds29DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }

        // 当场行政处罚决定书id
        String dcxzcfjdsid = request.getParameter("zfwsqtbid");
        if (dcxzcfjdsid != null && !"".equals(dcxzcfjdsid) && !"undefined".equals(dcxzcfjdsid)) {
            dto.setDcxzcfjdsid(dcxzcfjdsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" ,(select getAa10_aaa103('RYXB',a.dccffddbrxb)) as dccffddbrxbstr ");
        sb.append(" ,(select getAa10_aaa103('COMZZZM',a.dccfyyzz)) as dccfyyzzstr ,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append("  from Zfwsdcxzcfjds29 a ");
        sb.append("  where 1 = 1 ");
        sb.append("  and ajdjid = :ajdjid ");
        sb.append("  and dcxzcfjdsid = :dcxzcfjdsid ");
//		if(request.getParameter("zfwsqtbid")!=null&&!"".equals(request.getParameter("zfwsqtbid"))){
//		sb.append("  and dcxzcfjdsid = '").append(request.getParameter("zfwsqtbid")).append("'");
//		}
        String[] ParaName = new String[]{"ajdjid", "dcxzcfjdsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsdcxzcfjds29DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwsdcxzcfjds29DTO z29DTO = new Zfwsdcxzcfjds29DTO();
        if (ls != null && ls.size() > 0) {
            z29DTO = (Zfwsdcxzcfjds29DTO) ls.get(0);
        } else { // 默认数据添加
            // 执法文书查询
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 文书编号，默认从案件登记表中取文书编号
                    z29DTO.setDccfwsbh(v_zfajdj.getAjdjbh());
                    // 当事人，默认从案件登记表中取企业名称
                    z29DTO.setDccfdsr(v_zfajdj.getCommc());
                    // 营业执照或资质证明，默认从案件登记表中取资质证明
                    z29DTO.setDccfyyzz(v_zfajdj.getComzzzm());
                    // 营业执照或资质证明编号，默认从案件登记表中取资质证明编号
                    z29DTO.setDccfyyzzbh(v_zfajdj.getComzzzmbh());
                    // 组织结构代码号，默认从案件登记表中取组织结构代码号
                    z29DTO.setDccfzzjgdm(v_zfajdj.getComzzjgdm());
                    // 法定代表人，默认从案件登记表中取企业法人
                    z29DTO.setDccffddbr(v_zfajdj.getComfrhyz());
                    // 法定代表人性别，默认从案件登记表中取企业法人性别
                    z29DTO.setDccffddbrxb(v_zfajdj.getComfrxb());
                    // 法定代表人职务，默认从案件登记表中取企业法人职务
                    z29DTO.setDccffddbrzw(v_zfajdj.getComfrzw());
                    // 地址，默认从案件登记表中取企业地址
                    z29DTO.setDccfdz(v_zfajdj.getComdz());
                    // 邮编，默认从案件登记表中取企业邮政编码
                    z29DTO.setDccfyb(v_zfajdj.getComyzbm());
                    // 电话，默认从案件登记表中取企业联系电话
                    z29DTO.setDccfdh(v_zfajdj.getComyddh());
                }
            } else {
                PcompanyDTO pcom = new PcompanyDTO();
                PagesDTO v_pagesdto = new PagesDTO();
                pcom.setComid(dto.getComid());
                pcom.setUserid(dto.getUserid());
                List<PcompanyDTO> v_pcomlist = (List<PcompanyDTO>) pcompanyService.queryCompany(request, pcom, v_pagesdto).get("rows");
                pcom = v_pcomlist.get(0);

                // 文书编号，默认从案件登记表中取文书编号
                //z29DTO.setDccfwsbh(v_zfajdj.getAjdjbh());
                // 当事人，默认从案件登记表中取企业名称
                z29DTO.setDccfdsr(pcom.getCommc());
                // 营业执照或资质证明，默认从案件登记表中取资质证明
                //z29DTO.setDccfyyzz(pcom.getComzzzm());
                // 营业执照或资质证明编号，默认从案件登记表中取资质证明编号
                z29DTO.setDccfyyzzbh(pcom.getComxkzbhall());
                // 组织结构代码号，默认从案件登记表中取组织结构代码号
                z29DTO.setDccfzzjgdm(pcom.getComzzjgdm());
                // 法定代表人，默认从案件登记表中取企业法人
                z29DTO.setDccffddbr(pcom.getComfrhyz());
                // 法定代表人性别，默认从案件登记表中取企业法人性别
                z29DTO.setDccffddbrxb(pcom.getComfrxb());
                // 法定代表人职务，默认从案件登记表中取企业法人职务
                z29DTO.setDccffddbrzw(pcom.getComfrzw());
                // 地址，默认从案件登记表中取企业地址
                z29DTO.setDccfdz(pcom.getComdz());
                // 邮编，默认从案件登记表中取企业邮政编码
                z29DTO.setDccfyb(pcom.getComyzbm());
                // 电话，默认从案件登记表中取企业联系电话
                z29DTO.setDccfdh(pcom.getComyddh());
            }

            // 缴款银行，默认从aa01表中去缴款银行
            /*Aa01 jkyh = SysmanageUtil.getAa01Fdq("FMKJKYH");
			z29DTO.setFmkjkyh(jkyh.getAaa005());*/
            // 上级食药局，默认从aa01表中取上一级食药局
			/*Aa01 sjsyj = SysmanageUtil.getAa01Fdq("SJSPYPJDGLJ");
			z29DTO.setSjspypjdglj(sjsyj.getAaa005());
			// 上级人民政府，默认从aa01表中取上级人民政府
			Aa01 sjrmzf = SysmanageUtil.getAa01Fdq("SJRMZF");
			z29DTO.setSjrmzf(sjrmzf.getAaa005());
			// 上级人民法院，默认从aa01表中取上级人民法院
			Aa01 sjrmfy = SysmanageUtil.getAa01Fdq("SJRMFY");
			z29DTO.setSjrmfy(sjrmfy.getAaa005());
			// 强制执行人民法院，默认从aa01表中取强制执行人民法院
			Aa01 qzzzrmfy = SysmanageUtil.getAa01Fdq("QZZZRMFY");
			z29DTO.setQzzzrmfy(qzzzrmfy.getAaa005());
			// 行政机关名称，默认从aa01表中取食品药品监督管理局全称
			Aa01 xzjgmc = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
			z29DTO.setXzjgmc(xzjgmc.getAaa005());*/
        }
        if("1".equals(dto.getPrint())){
            //手机端文书打印电子签名路径  wxy20180803
            z29DTO.setCheckedqm(request.getContextPath()+z29DTO.getCheckedqm());
            z29DTO.setApplyqm(request.getContextPath()+z29DTO.getApplyqm());
            z29DTO.setCheckqm(request.getContextPath()+z29DTO.getCheckqm());
            z29DTO.setWitnessqm(request.getAuthType() + z29DTO.getWitnessqm());
            z29DTO.setNoticeqm(request.getContextPath()+z29DTO.getNoticeqm());
            z29DTO.setRecordqm(request.getContextPath()+z29DTO.getRecordqm());
        }
        return z29DTO;
    }

    /**
     * saveZfwsdcxzcfjds29的中文名称：当场行政处罚决定书 29
     * <p/>
     * saveZfwsdcxzcfjds29的概要说明：保存或者修改当场行政处罚决定书 29
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwsdcxzcfjds29(HttpServletRequest request,
                                      Zfwsdcxzcfjds29DTO dto) {
        String dcxzcfjdsid = null;
        try {
            dcxzcfjdsid = saveZfwsdcxzcfjds29DTOImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return dcxzcfjdsid;
    }

    @Aop({"trans"})
    public String saveZfwsdcxzcfjds29DTOImp(HttpServletRequest request,
                                            Zfwsdcxzcfjds29DTO dto) throws Exception {
        if ("".equals(dto.getDccfdsrqzrq())) {
            dto.setDccfdsrqzrq(null);
        }
        if ("".equals(dto.getDccfgzrq())) {
            dto.setDccfgzrq(null);
        }
        if (null != dto.getDcxzcfjdsid() && !"".equals(dto.getDcxzcfjdsid())) {
            Zfwsdcxzcfjds29 se = dao.fetch(Zfwsdcxzcfjds29.class, dto.getDcxzcfjdsid());
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setDccfdd(dto.getDccfdd()); // 处罚地点
            se.setDccfdh(dto.getDccfdh()); // 电话
            se.setDccfdsr(dto.getDccfdsr()); // 当事人
            se.setDccfdsrqz(dto.getDccfdsrqz()); // 当事人签字
            se.setDccfdsrqzrq(dto.getDccfdsrqzrq()); // 当事人签字日期
            se.setDccfdz(dto.getDccfdz()); // 地址
            se.setDccffddbr(dto.getDccffddbr()); // 法定代表人
            se.setDccffddbrxb(dto.getDccffddbrxb()); // 法定代表人性别
            se.setDccffddbrzw(dto.getDccffddbrzw()); // 法定代表人职务
            se.setDccfgzrq(dto.getDccfgzrq()); // 盖章日期
            se.setDccfwfgd(dto.getDccfwfgd()); // 违反的法律法规规定
            se.setDccfwfxw(dto.getDccfwfxw()); // 违法行为
            se.setDccfwsbh(dto.getDccfwsbh()); // 文书编号
            se.setDccfxzcf1(dto.getDccfxzcf1()); // 行政处罚
            se.setDccfyb(dto.getDccfyb()); // 邮编
            se.setDccfyjgd(dto.getDccfyjgd()); // 依据规定
            se.setDccfyyzz(dto.getDccfyyzz()); // 营业执照或其他资质证明
            se.setDccfyyzzbh(dto.getDccfyyzzbh()); // 营业执照或其他资质证明编号
            se.setDccfzfryqz(dto.getDccfzfryqz()); // 执法人员签字
            se.setDccfzfryqz2(dto.getDccfzfryqz2()); // 执法人员签字2
            se.setDccfzzjgdm(dto.getDccfzzjgdm()); // 组织结构代码号
            se.setFmkjkyh(dto.getFmkjkyh()); // 缴款银行
            se.setQzzzrmfy(dto.getQzzzrmfy()); // 强制执行人民法院
            se.setSjrmfy(dto.getSjrmfy()); // 上级人民法院
            se.setSjrmzf(dto.getSjrmzf()); // 上级人民政府
            se.setSjspypjdglj(dto.getSjspypjdglj()); // 上级食药监局
            se.setXzjgmc(dto.getXzjgmc()); // 行政机关名称
            se.setGmsfhm(dto.getGmsfhm()); // 公民省份号码
            se.setFkrmbdxqian(dto.getFkrmbdxqian()); // 罚款人民币大写千
            se.setFkrmbdxbai(dto.getFkrmbdxbai()); // 罚款人民币大写百
            se.setFkrmbdxshi(dto.getFkrmbdxshi()); // 罚款人民币大写拾
            se.setFkrmbdxyuan(dto.getFkrmbdxyuan()); // 罚款人民币大写元
            se.setFkrmbxx(dto.getFkrmbxx()); // 罚款人民币小写
            se.setYhzh(dto.getYhzh()); // 银行账户
            se.setYhhm(dto.getYhhm()); // 银行户名
            dao.update(se);
            return dto.getDcxzcfjdsid();
        } else {
            //判断案件文书对应关系表是否存在，不存在增加一条
            String vZfwslydjid = DbUtils.getSequenceStr();
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS29");
                    v_Zfajzfws.setZfwsqtbid(vZfwslydjid);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
//				ZfajzfwsDTO v_ZfajzfwsDTO=new ZfajzfwsDTO();
//				v_ZfajzfwsDTO.setUserid(dto.getUserid());
//				v_ZfajzfwsDTO.setAjdjid(dto.getAjdjid());
//				v_ZfajzfwsDTO.setFjcsdmzlist("ZFAJZFWS29");
//				v_ZfajzfwsDTO.setZfwsqtbid(vZfwslydjid);
//				dto.setZfwsdmz("ZFAJZFWS29");
//				saveZfwsadd(request,v_ZfajzfwsDTO);
            }

            Zfwsdcxzcfjds29 v_Zfwsajlydjb = new Zfwsdcxzcfjds29();
            dto.setDcxzcfjdsid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * dyZfwsdcxzcfjds29的中文名称：第32个文书调用第29文书获取相应的签字日期等
     * dyZfwsdcxzcfjds29的概要说明：
     *
     * @param dto
     * @return
     * @throws Exception Written by:ly
     */
    @SuppressWarnings({"rawtypes"})
    public Object dyZfwsdcxzcfjds29(Zfwsdcxzcfjds29DTO dto) throws Exception {
        // 当场行政处罚决定书id
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" ,(select getAa10_aaa103('RYXB',a.dccffddbrxb)) as dccffddbrxbstr ");
        sb.append(" ,(select getAa10_aaa103('COMZZZM',a.dccfyyzz)) as dccfyyzzstr ");
        sb.append("  from Zfwsdcxzcfjds29 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");

        String[] ParaName = new String[]{"ajdjid"};
        int[] ParaType = new int[]{Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsdcxzcfjds29DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Zfwsdcxzcfjds29DTO z29DTO = new Zfwsdcxzcfjds29DTO();
        if (ls != null && ls.size() > 0) {
            z29DTO = (Zfwsdcxzcfjds29DTO) ls.get(0);
        }
        return z29DTO;
    }

    /**
     * queryZfwslxxzcfjdcgs32Obj的中文名称：履行行政处罚决定催告书32
     * <p/>
     * queryZfwslxxzcfjdcgs32Obj的概要说明：履行行政处罚决定催告书32 查询
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings("rawtypes")
    //TODO 文书32
    public Object queryZfwslxxzcfjdcgs32Obj(HttpServletRequest request,
                                            Zfwslxxzcfjdcgs32DTO dto) throws Exception {

        // 履行行政处罚决定催告书ID
        String lxxzcfjdcgsid = request.getParameter("zfwsqtbid");
        if (lxxzcfjdcgsid != null && !"".equals(lxxzcfjdcgsid) && !"undefined".equals(lxxzcfjdcgsid)) {
            dto.setLxxzcfjdcgsid(lxxzcfjdcgsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwslxxzcfjdcgs32 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("  and a.lxxzcfjdcgsid = :lxxzcfjdcgsid");
        String[] ParaName = new String[]{"ajdjid", "lxxzcfjdcgsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwslxxzcfjdcgs32DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        // 执法文书查询
        Zfwslxxzcfjdcgs32DTO z32DTO = new Zfwslxxzcfjdcgs32DTO();

        if (ls != null && ls.size() > 0) {
            z32DTO = (Zfwslxxzcfjdcgs32DTO) ls.get(0);
        } else {
            // 行政处罚决定书查询
            Zfwsdcxzcfjds29DTO z29 = new Zfwsdcxzcfjds29DTO();
            z29.setAjdjid(dto.getAjdjid());
            z29 = (Zfwsdcxzcfjds29DTO) dyZfwsdcxzcfjds29(z29);
            z32DTO.setLxcgwsbh("（&times;&times;）食药监 &times;罚催〔年份〕&times;号 ");

            if (z29 != null) {
                z32DTO.setLxcgdsr(z29.getDccfdsr()); // 当事人（企业名称）
                z32DTO.setLxcgxzcfjdsrq(z29.getDccfdsrqzrq()); // 行政处罚决定书（当事人签字日期）
                z32DTO.setLxcgxzcfjdsbh(z29.getDccfwsbh()); // 行政处罚决定书编号（文书编号）
                z32DTO.setLxcgxzcfnr(z29.getDccfxzcf1()); // 行政处罚内容
            }
            // 计算截止日期
            if (z29.getDccfdsrqzrq() != null && !"".equals(z29.getDccfdsrqzrq())) {
                DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String curDatetime = z29.getDccfdsrqzrq();
                Date date = formatter.parse(curDatetime);
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                calendar.add(Calendar.DAY_OF_MONTH, 7);
                String datetime = formatter.format(calendar.getTime());
                calendar.add(Calendar.DAY_OF_MONTH, 8);
                String datetime2 = formatter.format(calendar.getTime());
                z32DTO.setLxcgjfkjzrq(datetime); // 缴罚款截止日   当事人签字日期+7天
                z32DTO.setLxcgjcfksrq(datetime); // 加处罚开始日期  当事人签字日期+7天
                z32DTO.setLxcgcssbrq(datetime2); // 陈述申辩日期   加处罚开始日期+8天
            }
        }
        return z32DTO;
    }

    /**
     * saveZfwslxxzcfjdcgs32的中文名称：履行行政处罚决定催告书32
     * <p/>
     * saveZfwslxxzcfjdcgs32的概要说明：保存或者修改履行行政处罚决定催告书 32
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwslxxzcfjdcgs32(HttpServletRequest request,
                                        Zfwslxxzcfjdcgs32DTO dto) {
        String lxxzcfjdcgsid = null;
        try {
            lxxzcfjdcgsid = saveZfwslxxzcfjdcgs32Imp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return lxxzcfjdcgsid;
    }

    @Aop({"trans"})
    public String saveZfwslxxzcfjdcgs32Imp(HttpServletRequest request,
                                           Zfwslxxzcfjdcgs32DTO dto) throws Exception {
        if ("".equals(dto.getLxcgcssbrq())) {
            dto.setLxcgcssbrq(null);
        }
        if ("".equals(dto.getLxcggzrq())) {
            dto.setLxcggzrq(null);
        }
        if ("".equals(dto.getLxcgjcfksrq())) {
            dto.setLxcgjcfksrq(null);
        }
        if ("".equals(dto.getLxcgjfkjzrq())) {
            dto.setLxcgjfkjzrq(null);
        }
        if ("".equals(dto.getLxcgxzcfjdsrq())) {
            dto.setLxcgxzcfjdsrq(null);
        }
        if ("".equals(dto.getDsrqzrq())) {
            dto.setDsrqzrq(null);
        }
        if (null != dto.getLxxzcfjdcgsid()
                && !"".equals(dto.getLxxzcfjdcgsid())) {
            Zfwslxxzcfjdcgs32 se = dao.fetch(Zfwslxxzcfjdcgs32.class, dto.getLxxzcfjdcgsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getLxxzcfjdcgsid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwslxxzcfjdcgs32 v_Zfwsajlydjb = new Zfwslxxzcfjdcgs32();
            dto.setLxxzcfjdcgsid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * queryZfwscssbbl34Obj的中文名称：陈述申辩笔录 34
     * <p/>
     * queryZfwscssbbl34Obj的概要说明：陈述申辩笔录 34 查询
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书34
    public Object queryZfwscssbbl34Obj(HttpServletRequest request,
                                       Zfwscssbbl34DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 陈述申辩笔录id
        String cssbblid = request.getParameter("zfwsqtbid");
        if (cssbblid != null && !"".equals(cssbblid) && !"undefined".equals(cssbblid)) {
            dto.setCssbblid(cssbblid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from Zfwscssbbl34 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid ");
        sb.append("  and a.cssbblid = :cssbblid");
        String[] ParaName = new String[]{"ajdjid", "cssbblid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwscssbbl34DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwscssbbl34DTO z34DTO = new Zfwscssbbl34DTO();

        if (ls != null && ls.size() > 0) {
            z34DTO = (Zfwscssbbl34DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                z34DTO.setCssbdsr(v_zfajdj.getCommc());
                z34DTO.setAjdjay(v_zfajdj.getAjdjay());
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                z34DTO.setCssbdsr(v_pcom.getCommc());
            }
        }
        return z34DTO;
    }

    /**
     * saveZfwscssbbl34的中文名称：陈述申辩笔录 34
     * <p/>
     * saveZfwscssbbl34的概要说明：保存或者修改陈述申辩笔录 34
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwscssbbl34(HttpServletRequest request,
                                   Zfwscssbbl34DTO dto) {
        String cssbblid = null;
        try {
            cssbblid = saveZfwscssbbl34Imp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return cssbblid;
    }

    @Aop({"trans"})
    public String saveZfwscssbbl34Imp(HttpServletRequest request,
                                      Zfwscssbbl34DTO dto) throws Exception {
        if ("".equals(dto.getCssbrqzrq())) {
            dto.setCssbrqzrq(null);
        }
        if ("".equals(dto.getCssbcbrqzrq())) {
            dto.setCssbcbrqzrq(null);
        }
        if ("".equals(dto.getCssbjlrqzrq())) {
            dto.setCssbjlrqzrq(null);
        }
        if ("".equals(dto.getCssbjzsj())) {
            dto.setCssbjzsj(null);
        }
        if ("".equals(dto.getCssbsj())) {
            dto.setCssbsj(null);
        }
        if (null != dto.getCssbblid() && !"".equals(dto.getCssbblid())) {
            Zfwscssbbl34 se = dao.fetch(Zfwscssbbl34.class, dto.getCssbblid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getCssbblid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwscssbbl34 v_Zfwsajlydjb = new Zfwscssbbl34();
            dto.setCssbblid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);
            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * queryZfwsdshz38的中文名称：送达回执 38
     * <p/>
     * queryZfwsdshz38的概要说明：送达回执 38 查询
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书38
    public Object queryZfwsdshz38(HttpServletRequest request, Zfwsdshz38DTO dto)
            throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 送达回执书id
        String sdhzid = request.getParameter("zfwsqtbid");
        if (sdhzid != null && !"".equals(sdhzid) && !"undefined".equals(sdhzid)) {
            dto.setSdhzid(sdhzid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.* , ");
        sb.append(" (SELECT aaa103 FROM aa10 WHERE  AAA100='sdhzsdfs' AND aaa102= a.sdhzsdfs) sdhzsdfsstr ");
        sb.append("  FROM zfwsdshz38 a ");
        sb.append(" WHERE 1 = 1 ");
        sb.append("   AND ajdjid = :ajdjid ");
        sb.append("  and a.sdhzid = :sdhzid ");
        String[] ParaName = new String[]{"ajdjid", "sdhzid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zfwsdshz38DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        // 新建陈述申辩笔录 DTO
        Zfwsdshz38DTO z38DTO = new Zfwsdshz38DTO();

        if (ls != null && ls.size() > 0) {
            z38DTO = (Zfwsdshz38DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 案件登记表查询
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                z38DTO.setSdhzssddw(v_zfajdj.getCommc());
                // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
                Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
                z38DTO.setXzjgmc(v_aa01.getAaa005());
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                z38DTO.setSdhzssddw(v_pcom.getCommc());
                // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
                Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
                z38DTO.setXzjgmc(v_aa01.getAaa005());
            }
        }
        return z38DTO;
    }

    /**
     * Zfwsdshz38的中文名称：送达回执 38
     * <p/>
     * Zfwsdshz38的概要说明：保存或者修改送达回执 38
     *
     * @param dto
     * @return
     * @throws Exception Written by : wanghao
     */
    public String saveZfwsdshz38(HttpServletRequest request, Zfwsdshz38DTO dto) {
        String sdhzid = null;
        try {
            sdhzid = saveZfwsdshz38Imp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return sdhzid;
    }

    @Aop({"trans"})
    public String saveZfwsdshz38Imp(HttpServletRequest request, Zfwsdshz38DTO dto)
            throws Exception {
        if ("".equals(dto.getSdhzsdqzrq())) {
            dto.setSdhzsdqzrq(null);
        }
        if ("".equals(dto.getSdhzssddwqzrq())) {
            dto.setSdhzssddwqzrq(null);
        }
        if ("".equals(dto.getSdhzgzrq())) {
            dto.setSdhzgzrq(null);
        }
        if (null != dto.getSdhzid() && !"".equals(dto.getSdhzid())) {
            Zfwsdshz38 se = dao.fetch(Zfwsdshz38.class, dto.getSdhzid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getSdhzid();
        } else {
            String vZfwslydjid = DbUtils.getSequenceStr();
            Zfwsdshz38 v_Zfwsajlydjb = new Zfwsdshz38();
            dto.setSdhzid(vZfwslydjid);
            BeanHelper.copyProperties(dto, v_Zfwsajlydjb);
            dao.insert(v_Zfwsajlydjb);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + vZfwslydjid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vZfwslydjid;
        }
    }

    /**
     * caseDateForFtrq的中文名称：日期转换成封条日期的格式
     * <p/>
     * caseDateForFtrq概要说明：
     *
     * @param rq
     * @return Written by:wanghao
     */
    public String caseDateForFtrq(String rq) {
        String[] arr = rq.split("-");
        String[] arry = arr[0].split("");
        String[] arrm = arr[1].split("");
        String[] arrd = arr[2].split("");
        String date = caseNum(arry[1]) + "<br/>" + caseNum(arry[2]) + "<br/>"
                + caseNum(arry[3]) + "<br/>" + caseNum(arry[4]) + "<br/>年<br/>"
                + caseNum(arrm[1]) + "<br/>" + caseNum(arrm[2]) + "<br/>月<br/>"
                + caseNum(arrd[1]) + "<br/>" + caseNum(arrd[2]) + "<br/>日";
        return date;
    }

    public String caseNum(String n) {
        if (n.equals("1")) {
            return "一";
        }
        if (n.equals("2")) {
            return "二";
        }
        if (n.equals("3")) {
            return "三";
        }
        if (n.equals("4")) {
            return "四";
        }
        if (n.equals("5")) {
            return "五";
        }
        if (n.equals("6")) {
            return "六";
        }
        if (n.equals("7")) {
            return "七";
        }
        if (n.equals("8")) {
            return "八";
        }
        if (n.equals("9")) {
            return "九";
        }
        if (n.equals("0")) {
            return "零";
        }
        return "";
    }

    /**
     * queryZfwsajyssObj的中文名称：查询案件移送书
     * <p/>
     * queryZfwsajyssObj的概要说明：查询文书内容
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO 文书3
    public Object queryZfwsajyssObj(HttpServletRequest request,
                                    Zfwsajyss3DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsajyss3 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid "); // 案件登记id
        sb.append("   and ajysid = :ajysid "); // 案件登记id
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "ajysid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsajyss3.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 执法文书案件来源移送书
        Zfwsajyss3DTO v_zfwsajyss3DTO = new Zfwsajyss3DTO();
        if (ls != null && ls.size() > 0) {
            Zfwsajyss3 v_zfwsajyss3 = (Zfwsajyss3) ls.get(0);
            BeanHelper.copyProperties(v_zfwsajyss3, v_zfwsajyss3DTO);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj1(dto.getAjdjid()).get(0);
                v_zfwsajyss3DTO.setZfwsbh(v_zfajdj.getAjdjbh());//执法文书案件登记编号
            }
        }

        return v_zfwsajyss3DTO;
    }

    /**
     * saveZfwsajyss的中文名称：保存执法文书案件移送书
     * <p/>
     * saveZfwsajyss的概要说明：对文书内容进行保存
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsajyss(HttpServletRequest request, Zfwsajyss3DTO dto) {
        try {
            saveZfwsajyssImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveZfwsajyssImp的中文名称：保存案件移送书实现方法
     * <p/>
     * saveZfwsajyssImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public void saveZfwsajyssImp(HttpServletRequest request, Zfwsajyss3DTO dto)
            throws Exception {
        if ("".equals(dto.getAjysrq())) {
            dto.setAjysrq(null);
        }
        // 判断id是否为空 不为空则更新信息，为空插入信息
        if ((null != dto.getAjysid()) && (!"".equals(dto.getAjysid()))) {
            Zfwsajyss3 se = dao.fetch(Zfwsajyss3.class, dto.getAjysid());
            //BeanHelper.copyProperties(dto, se);
            se.setZfwsbh(dto.getZfwsbh());
            se.setAjysbmmc(dto.getAjysbmmc());
            se.setAjysms(dto.getAjysms());
            se.setAjysclzs(dto.getAjysclzs());
            se.setAjysrq(dto.getAjysrq());
            se.setAjysysyy(dto.getAjysysyy());
            se.setAjysdjt(dto.getAjysdjt());
            dao.update(se);
        } else {
            // 获取系统时间
            String v_dbtime = SysmanageUtil.getDbtimeYmdHns();
            if ((dto.getAjysrq() == null) || ("".equals(dto.getAjysrq()))) {
                dto.setAjysrq(v_dbtime);
            }
            // 案件移送id
            String v_id = DbUtils.getSequenceStr();
            Zfwsajyss3 v_zfwsajyss3 = new Zfwsajyss3();
            BeanHelper.copyProperties(dto, v_zfwsajyss3);
            v_zfwsajyss3.setAjysid(v_id);
            // 插入信息
            dao.insert(v_zfwsajyss3);

            //主键返回到前台
            dto.setAjysid(v_id);

            // 更新执法文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajzfwsid='").append(dto.getAjzfwsid()).append("'");

//			sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
//					"' and zfwsdmz = '");
//			sb.append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
        }
    }

    /**
     * queryZfwscfkywpyjtzsObj的中文名称：查封扣押物品移交通知书
     * <p/>
     * queryZfwscfkywpyjtzsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书6
    public Object queryZfwscfkywpyjtzsObj(HttpServletRequest request,
                                          Zfwscfkywpyjtzs6DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwscfkywpyjtzs6 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid "); // 案件登记id
        sb.append("   and cfkyyjid = :cfkyyjid "); // 案件登记id
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "cfkyyjid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwscfkywpyjtzs6.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 查封扣押物品通知书
        Zfwscfkywpyjtzs6DTO v_zfwscfkywpyjtzs6DTO = new Zfwscfkywpyjtzs6DTO();
        if (ls != null && ls.size() > 0) {
            Zfwscfkywpyjtzs6 v_zfwscfkywpyjtzs6 = (Zfwscfkywpyjtzs6) ls.get(0);
            BeanHelper.copyProperties(v_zfwscfkywpyjtzs6, v_zfwscfkywpyjtzs6DTO);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj1(dto.getAjdjid()).get(0);
                v_zfwscfkywpyjtzs6DTO.setWsbh(v_zfajdj.getAjdjbh());//执法文书案件登记编号
                v_zfwscfkywpyjtzs6DTO.setCfkytitle("查封(扣押)物品移交通知书");//执法文书案件登记编号
            } else {
                v_zfwscfkywpyjtzs6DTO.setCfkytitle("查封(扣押)物品移交通知书");//执法文书案件登记编号
            }
        }

        return v_zfwscfkywpyjtzs6DTO;
    }

    /**
     * saveZfwscfkywpyjtzs的中文名称：保存执法文书查封扣押物品移交通知书
     * <p/>
     * saveZfwscfkywpyjtzs的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwscfkywpyjtzs(HttpServletRequest request,
                                      Zfwscfkywpyjtzs6DTO dto) {
        String cfkyyjid = null;
        try {
            cfkyyjid = saveZfwscfkywpyjtzsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return cfkyyjid;
    }

    /**
     * saveZfwscfkywpyjtzsImp的中文名称：保存执法文书实现
     * <p/>
     * saveZfwscfkywpyjtzsImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwscfkywpyjtzsImp(HttpServletRequest request,
                                         Zfwscfkywpyjtzs6DTO dto) throws Exception {
        if ("".equals(dto.getCfkyyjrq())) {
            dto.setCfkyyjrq(null);
        }
        // 判断移送书id是否为空
        if ((null != dto.getCfkyyjid()) && (!"".equals(dto.getCfkyyjid()))) {
            Zfwscfkywpyjtzs6 se = dao.fetch(Zfwscfkywpyjtzs6.class, dto
                    .getCfkyyjid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getCfkyyjid();
        } else {
            // 获取id
            String vCfkyysid = DbUtils.getSequenceStr();
            Zfwscfkywpyjtzs6 v_zfwscfkywpyjtzs6 = new Zfwscfkywpyjtzs6();
            BeanHelper.copyProperties(dto, v_zfwscfkywpyjtzs6);
            v_zfwscfkywpyjtzs6.setCfkyyjid(vCfkyysid);
            dao.insert(v_zfwscfkywpyjtzs6);
            dto.setCfkyyjid(vCfkyysid);//返回前台用
            // 更新执法文书填写标志
            // 更新执法文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(vCfkyysid)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajzfwsid='").append(dto.getAjzfwsid()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return vCfkyysid;
        }
    }

    /**
     * queryZfwsxcjcblObj的中文名称：查询现场检查笔录
     * <p/>
     * queryZfwsxcjcblObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO 文书8
    public Object queryZfwsxcjcblObj(HttpServletRequest request,
                                     Zfwsxcjcbl8DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        String xcjcblid = request.getParameter("zfwsqtbid");
        if (xcjcblid != null && !"".equals(xcjcblid) && !"undefined".equals(xcjcblid)) {
            dto.setXcjcblid(xcjcblid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,(select getAa10_aaa103('DCBLJDJCLB',a.dcbljdjclb)) as dcbljdjclbstr,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append("  from zfwsxcjcbl8 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // 案件登记id
        sb.append("   and a.xcjcblid = :xcjcblid "); // 案件登记id
//		if(request.getParameter("zfwsqtbid")!=null&&!"".equals(request.getParameter("zfwsqtbid"))){
//		sb.append("  and a.xcjcblid = '").append(request.getParameter("zfwsqtbid")).append("'");
//		}
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "xcjcblid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxcjcbl8DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 执法文书现场检查笔录
        Zfwsxcjcbl8DTO v_zfwsxcjcbl8DTO = new Zfwsxcjcbl8DTO();
        if (ls != null && ls.size() > 0) {
            // 执法文书现场检查笔录
            v_zfwsxcjcbl8DTO = (Zfwsxcjcbl8DTO) ls.get(0);
        } else {

            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_zfwsxcjcbl8DTO.setAjdjay(v_zfajdj.getAjdjay()); // 案由
                    v_zfwsxcjcbl8DTO.setCommc(v_zfajdj.getCommc()); // 企业名称
                    v_zfwsxcjcbl8DTO.setComdz(v_zfajdj.getComdz()); // 企业地址
                    v_zfwsxcjcbl8DTO.setComfrhyz(v_zfajdj.getComfrhyz()); // 企业法人业主
                    v_zfwsxcjcbl8DTO.setComyddh(v_zfajdj.getComyddh()); // 联系电话
                }
            } else {
                v_zfwsxcjcbl8DTO.setXcjcbl(queryAjdjBhgx(dto.getAjdjid()));//获取检查不合格项
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                //v_zfwsxcjcbl8DTO.setAjdjay(v_zfajdj.getAjdjay()); // 案由
                v_zfwsxcjcbl8DTO.setCommc(v_pcom.getCommc()); // 企业名称
                v_zfwsxcjcbl8DTO.setComdz(v_pcom.getComdz()); // 企业地址
                v_zfwsxcjcbl8DTO.setComfrhyz(v_pcom.getComfrhyz()); // 企业法人业主
                v_zfwsxcjcbl8DTO.setComyddh(v_pcom.getComyddh()); // 联系电话
            }
            // 查询食药局全称
            Aa01 v_syjqc = SysmanageUtil.getAa01("SPYPJDGLJMCQC");
            if (v_syjqc != null && !"".equals(v_syjqc.getAaa005())) {
                v_zfwsxcjcbl8DTO.setSpypjdgljmcqc(v_syjqc.getAaa005()); // 食药局全称
            }
            // 执法证件名称
            Aa01 v_zfzjmc = SysmanageUtil.getAa01("ZFZJMC");
            if (v_zfzjmc != null && !"".equals(v_zfzjmc.getAaa005())) {
                v_zfwsxcjcbl8DTO.setZfzjmc(v_zfzjmc.getAaa005()); // 执法证件名称
            }
            // 获取执法人员信息
            boolean flag = false;
            if (v_zfwsxcjcbl8DTO.getCxjcjlr() == null) {
                flag = true;
            }
            List<?> cbrs = queryZfajcbr(dto.getAjdjid());
            if (cbrs != null && cbrs.size() > 0) {
                // 执法人员
                StringBuffer zfry = new StringBuffer();
                // 执法人员1姓名
                v_zfwsxcjcbl8DTO.setXcjczfry1(((Zfajcbr) cbrs.get(0)).getZfryxm());
                // 执法人员1证件号码
                v_zfwsxcjcbl8DTO.setXcjczfryzjbh1(((Zfajcbr) cbrs.get(0))
                        .getZfryzjhm());
                zfry.append(((Zfajcbr) cbrs.get(0)).getZfryxm());
                if (flag) {
                    v_zfwsxcjcbl8DTO.setCxjcjlr(((Zfajcbr) cbrs.get(0)).getZfryxm()); // 记录人
                }
                if (cbrs.size() > 1) {
                    // 执法人员2姓名
                    v_zfwsxcjcbl8DTO.setXcjczfry2(((Zfajcbr) cbrs.get(1))
                            .getZfryxm());
                    // 执法人员2证件号码
                    v_zfwsxcjcbl8DTO.setXcjczfryzjbh2(((Zfajcbr) cbrs.get(1))
                            .getZfryzjhm());
                    zfry.append(",")
                            .append(((Zfajcbr) cbrs.get(1)).getZfryxm());
                    if (flag) {
                        v_zfwsxcjcbl8DTO
                                .setCxjcjlr(((Zfajcbr) cbrs.get(1)).getZfryxm()); // 记录人
                    }
                }
                if (v_zfwsxcjcbl8DTO.getXcjcjcr() == null) {
                    v_zfwsxcjcbl8DTO.setXcjcjcr(zfry.toString()); // 检查人
                }
            }
        }
        if("1".equals(dto.getPrint())){
            //手机端文书打印电子签名路径  wxy20180803
            v_zfwsxcjcbl8DTO.setCheckedqm(request.getContextPath()+v_zfwsxcjcbl8DTO.getCheckedqm());
            v_zfwsxcjcbl8DTO.setApplyqm(request.getContextPath()+v_zfwsxcjcbl8DTO.getApplyqm());
            v_zfwsxcjcbl8DTO.setCheckqm(request.getContextPath()+v_zfwsxcjcbl8DTO.getCheckqm());
            v_zfwsxcjcbl8DTO.setWitnessqm(request.getContextPath() + v_zfwsxcjcbl8DTO.getWitnessqm());
            v_zfwsxcjcbl8DTO.setNoticeqm(request.getContextPath()+v_zfwsxcjcbl8DTO.getNoticeqm());
            v_zfwsxcjcbl8DTO.setRecordqm(request.getContextPath()+v_zfwsxcjcbl8DTO.getRecordqm());
        }
        return v_zfwsxcjcbl8DTO;
    }

    /**
     * 获取检查不合格项
     * @param ajdjid
     * @return
     * @throws Exception
     */
    public String queryAjdjBhgx(String ajdjid ) throws Exception{

        StringBuffer sb = new StringBuffer();

        sb.append("SELECT group_concat(o.content SEPARATOR '/') AS bhgx FROM bscheckmaster b ");
        sb.append(" RIGHT JOIN bscheckdetail bs ON b.resultid=bs.resultid LEFT JOIN omcheckcontent o ON bs.contentid=o.contentid");
        sb.append(" WHERE b.resultid='"+ajdjid+"' AND bs.detaildecide='2' GROUP BY b.resultid");


        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ZfajdjDTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        ZfajdjDTO v_ZfajdjDTO = new ZfajdjDTO();
        if (ls != null && ls.size() > 0) {
            v_ZfajdjDTO = (ZfajdjDTO) ls.get(0);
        }
        String[] s=v_ZfajdjDTO.getBhgx().split("/");
        String xcjcbl="不合格项:\n";
        for(int i=1;i<=s.length;i++){
            xcjcbl+=i+"、"+s[i-1]+"\n";
        }
        return xcjcbl;
    }

    /**
     * saveZfwsxcjcbl的中文名称：保存现场检查笔录
     * <p/>
     * saveZfwsxcjcbl的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsxcjcbl(HttpServletRequest request, Zfwsxcjcbl8DTO dto) {
        String xcjcblid = null;
        try {
            xcjcblid = saveZfwsxcjcblImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xcjcblid;
    }

    /**
     * saveZfwsxcjcblImp的中文名称：保存执法文书实现方法
     * <p/>
     * saveZfwsxcjcblImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsxcjcblImp(HttpServletRequest request, Zfwsxcjcbl8DTO dto)
            throws Exception {
        String v_Xcjcblid = "";
        String v_ajzfwsid = dto.getAjzfwsid();
        // 被检查人签字日期
        if ("".equals(dto.getXcjcbjcrqzrq())) {
            dto.setXcjcbjcrqzrq(null);
        }
        if ("".equals(dto.getXcjcjcsjksrq())) {
            dto.setXcjcjcsjksrq(null);
        }
        if ("".equals(dto.getXcjcjcsjjsrq())) {
            dto.setXcjcjcsjjsrq(null);
        }
        // 执法人员签字日期
        if ("".equals(dto.getXcjczfryqzrq())) {
            dto.setXcjczfryqzrq(null);
        }
        //记录人员签字日期
        if ("".equals(dto.getXcjcjlrqzrq())) {
            dto.setXcjcjlrqzrq(null);
        }
        // 见证人签字日期
        if ("".equals(dto.getXcjcjzrqzrq())) {
            dto.setXcjcjzrqzrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getXcjcblid()) && (!"".equals(dto.getXcjcblid()))) {
            //Zfwsxcjcbl8 se = dao.fetch(Zfwsxcjcbl8.class, dto.getXcjcblid());
            Zfwsxcjcbl8 se = new Zfwsxcjcbl8();
            BeanHelper.copyProperties(dto, se);
            v_Xcjcblid = se.getXcjcblid();
            dao.update(se);
            //return dto.getXcjcblid();
        } else {
            // 获取id
            v_Xcjcblid = DbUtils.getSequenceStr();

            //判断案件文书对应关系表是否存在，不存在增加一条
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {//2手机特殊处理下
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS08");
                    v_Zfajzfws.setZfwsqtbid(v_Xcjcblid);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
            }
            Zfwsxcjcbl8 v_zfwsxcjcbl8 = new Zfwsxcjcbl8();
            BeanHelper.copyProperties(dto, v_zfwsxcjcbl8);
            v_zfwsxcjcbl8.setXcjcblid(v_Xcjcblid);

            dao.insert(v_zfwsxcjcbl8);

            // 更新执法文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(
                    v_Xcjcblid).append("',zfwstzbz='1'");
            sb.append(" where a.ajzfwsid='" + v_ajzfwsid + "'");
//			sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
//					"' and zfwsdmz = '");
//			sb.append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);

        }
        //gu20180230add
        //gu20180319生成供手机端打印的pdf文件
        if ("1".equals(SysmanageUtil.g_WSPRINTTYPE)) {
            Map<String, String> map = new HashMap<String, String>();
            map.put("$ajdjay", dto.getAjdjay());//案由
            map.put("$commc", dto.getCommc());
            map.put("$comdz", dto.getComdz());
            map.put("$page", "1");
            map.put("$pages", "1");
            map.put("$comfrhyz", dto.getComfrhyz());//法定代表人
            map.put("$comyddh", dto.getComyddh());//电话
            map.put("$xcjcjcr", dto.getXcjcjcr());//检查人
            map.put("$cxjcjlr", dto.getCxjcjlr());//记录人
            map.put("$dcbljdjclb", dto.getDcbljdjclb());//监督检查类别对应aa10中aaa100=DCBLJDJCLB
            String v_xcjcjcsjksrq = dto.getXcjcjcsjksrq();  //检查开始时间
            if (v_xcjcjcsjksrq != null && !"".equals(v_xcjcjcsjksrq)) {
                map.put("$sy", v_xcjcjcsjksrq.substring(0, 4));//检查开始时间 年
                map.put("$sue", v_xcjcjcsjksrq.substring(5, 7));//检查开始时间 月
                map.put("$sd", v_xcjcjcsjksrq.substring(8, 10));//检查开始时间 日
                map.put("$sh", v_xcjcjcsjksrq.substring(11, 13));//检查开始时间 小时
                map.put("$sm", v_xcjcjcsjksrq.substring(14, 16));//检查开始时间 分钟
            } else {
                map.put("$sy", "");//检查开始时间 年
                map.put("$sue", "");//检查开始时间 月
                map.put("$sd", "");//检查开始时间 日
                map.put("$sh", "");//检查开始时间 小时
                map.put("$sm", "");//检查开始时间 分钟
            }
            if (dto.getXcjcjcsjjsrq() != null && !"".equals(dto.getXcjcjcsjjsrq())) {
                map.put("$eh", dto.getXcjcjcsjjsrq().substring(11, 13));//检查结束时间 小时
                map.put("$em", dto.getXcjcjcsjjsrq().substring(14, 16));//检查结束时间 分钟
            } else {
                map.put("$eh", "");//检查结束时间 小时
                map.put("$em", "");//检查结束时间 分钟
            }
            map.put("$spypjdgljmcqc", dto.getSpypjdgljmcqc());//食品药品监督管理局名称全称见aa01表aaa001=SPYPJDGLJMCQC
            map.put("$zfry1", dto.getXcjczfry1());//执法人员1
            map.put("$zfry2", dto.getXcjczfry2());//执法人员2
            map.put("$zjbh1", dto.getXcjczfryzjbh1());//执法人员证件编号1
            map.put("$zjbh2", dto.getXcjczfryzjbh2());//执法人员证件编号2
            map.put("$cxjcptrxm", dto.getCxjcptrxm());//陪同人姓名
            map.put("$cxjcptrzw", dto.getCxjcptrzw());//陪同人职务
            if (dto.getXcjcsfsqhb() != null && !"".equals(dto.getXcjcsfsqhb())) {
                if (dto.getXcjcsfsqhb().equals("1")) {  //是否申请调查人员回避
                    map.put("$si", "√");//是
                    map.put("$fo", "");//否
                } else {
                    map.put("$si", "");//是
                    map.put("$fo", "√");//否
                }
            } else {
                map.put("$si", "");//是
                map.put("$fo", "");//否
            }
            map.put("$xcjcsfsqhbqz", dto.getXcjcsfsqhbqz());//是否申请调查人员回避签字
            map.put("${xcjcbl}", dto.getXcjcbl());//现场检查笔录
            map.put("$xcjcbjcr", dto.getXcjcbjcr());//被检查人
            if (dto.getXcjcbjcrqzrq() != null && !"".equals(dto.getXcjcbjcrqzrq())) {
                map.put("$bjy", dto.getXcjcbjcrqzrq().substring(0, 4));//被检查人 年
                map.put("$m1", dto.getXcjcbjcrqzrq().substring(5, 7));//被检查人 月
                map.put("$bjd", dto.getXcjcbjcrqzrq().substring(8, 10));//被检查人 日
            } else {
                map.put("$bjy", "");//被检查人 年
                map.put("$m1", "");//被检查人 月
                map.put("$bjd", "");//被检查人 日
            }
            map.put("$xcjcjcr", dto.getXcjcbjcr());//检查人
            if (dto.getXcjczfryqzrq() != null && !"".equals(dto.getXcjczfryqzrq())) {
                map.put("$jcy", dto.getXcjczfryqzrq().substring(0, 4));//检查人 年
                map.put("$m2", dto.getXcjczfryqzrq().substring(5, 7));//检查人 月
                map.put("$jcd", dto.getXcjczfryqzrq().substring(8, 10));//检查人 日
            } else {
                map.put("$jcy", "");//检查人 年
                map.put("$m2", "");//检查人 月
                map.put("$jcd", "");//检查人 日
            }
            map.put("$xcjcjzr", dto.getXcjcjzr());//见证人
            if (dto.getXcjcjzrqzrq() != null && !"".equals(dto.getXcjcjzrqzrq())) {
                map.put("$jzy", dto.getXcjcjzrqzrq().substring(0, 4));//见证人 年
                map.put("$m3", dto.getXcjcjzrqzrq().substring(5, 7));//见证人 月
                map.put("$jzd", dto.getXcjcjzrqzrq().substring(8, 10));//见证人 日
            } else {
                map.put("$jzy", "");//见证人 年
                map.put("$m3", "");//见证人 月
                map.put("$jzd", "");//见证人 日
            }
            map.put("$cxjcjlr", dto.getCxjcjlr());//记录人
            if (dto.getXcjcjlrqzrq() != null && !"".equals(dto.getXcjcjlrqz())) {
                map.put("$jly", dto.getXcjcjlrqzrq().substring(0, 4));//记录人 年
                map.put("$m4", dto.getXcjcjlrqzrq().substring(5, 7));//记录人 月
                map.put("$jld", dto.getXcjcjlrqzrq().substring(8, 10));//记录人 日
            } else {
                map.put("$jly", "");//记录人 年
                map.put("$m4", "");//记录人 月
                map.put("$jld", "");//记录人 日
            }
            //map.put("$checkedPersonImg", "E:/other/poi/src/main/s.jpg");

            pubService.createPrintfile(request, "现场检查笔录.docx", v_Xcjcblid, map);
        }
        return v_Xcjcblid;
    }


    /**
     * queryZfwsjygzsObj的中文名称：查询检验（检测、检疫、鉴定）告知书
     * <p/>
     * queryZfwsjygzsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO 文书14
    public Object queryZfwsjygzsObj(HttpServletRequest request,
                                    Zfwsjyjcjyjdgzs14DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsjyjcjyjdgzs14 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // 案件登记id
        // 查询参数
        String[] ParaName = new String[]{"ajdjid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsjyjcjyjdgzs14.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 检验告知书
        Zfwsjyjcjyjdgzs14DTO v_zfwsjyjcjyjdgzs14DTO = new Zfwsjyjcjyjdgzs14DTO();

        if (ls != null && ls.size() > 0) {
            Zfwsjyjcjyjdgzs14 v_zfwsjyjcjyjdgzs14 = (Zfwsjyjcjyjdgzs14) ls.get(0);
            BeanHelper.copyProperties(v_zfwsjyjcjyjdgzs14, v_zfwsjyjcjyjdgzs14DTO);
        } else {

            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = new ZfajdjDTO();
                v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                // 企业名称
                v_zfwsjyjcjyjdgzs14DTO.setCommc(v_zfajdj.getCommc());
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                v_zfwsjyjcjyjdgzs14DTO.setJygzdsr(v_pcom.getCommc());
            }
        }

        return v_zfwsjyjcjyjdgzs14DTO;
    }

    /**
     * saveZfwsjygzs的中文名称：保存检验（检测、检疫、鉴定）告知书
     * <p/>
     * saveZfwsjygzs的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsjygzs(HttpServletRequest request,
                                Zfwsjyjcjyjdgzs14DTO dto) {
        try {
            saveZfwsjygzslImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveZfwsjygzslImp的中文名称：保存执法文书实现方法
     * <p/>
     * saveZfwsjygzslImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public void saveZfwsjygzslImp(HttpServletRequest request,
                                  Zfwsjyjcjyjdgzs14DTO dto) throws Exception {
        if ("".equals(dto.getJygzdsrqzrq())) {
            dto.setJygzdsrqzrq(null);
        }
        if ("".equals(dto.getJygzgzrq())) {
            dto.setJygzgzrq(null);
        }
        if ("".equals(dto.getJygzksrq())) {
            dto.setJygzksrq(null);
        }
        if ("".equals(dto.getJygzjsrq())) {
            dto.setJygzjsrq(null);
        }
        if ("".equals(dto.getJygzqzcsqxsyrq())) {
            dto.setJygzqzcsqxsyrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getJygzsid()) && (!"".equals(dto.getJygzsid()))) {
            Zfwsjyjcjyjdgzs14 se = dao.fetch(Zfwsjyjcjyjdgzs14.class, dto
                    .getJygzsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
        } else {
            // 获取系统时间
//			String v_dbtime = SysmanageUtil.getDbtimeYmdHns();
//			// 盖章日期
//			if ((dto.getJygzgzrq() == null) || ("".equals(dto.getJygzgzrq()))) {
//				dto.setJygzgzrq(v_dbtime);
//			}
            // 获取id
            String vJygzsid = DbUtils.getSequenceStr();
            Zfwsjyjcjyjdgzs14 v_zfwsjyjcjyjdgzs14 = new Zfwsjyjcjyjdgzs14();
            BeanHelper.copyProperties(dto, v_zfwsjyjcjyjdgzs14);
            v_zfwsjyjcjyjdgzs14.setJygzsid(vJygzsid);
            dao.insert(v_zfwsjyjcjyjdgzs14);
            // 更新执法文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '")
                    .append(vJygzsid).append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '");
            sb.append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
        }
    }

    /**
     * queryZfwsxxclwptzsObj的中文名称：查询先行处理物品通知书
     * <p/>
     * queryZfwsxxclwptzsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书16
    public Object queryZfwsxxclwptzsObj(HttpServletRequest request,
                                        Zfwsxxclwptzs16DTO dto) throws Exception {

        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 先行处理物品通知书id
        String xxclwptzsid = request.getParameter("zfwsqtbid");
        if (xxclwptzsid != null && !"".equals(xxclwptzsid) && !"undefined".equals(xxclwptzsid)) {
            dto.setXxclwptzsid(xxclwptzsid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsxxclwptzs16 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // 案件登记id
        sb.append("   and a.xxclwptzsid = :xxclwptzsid "); //
//		if(request.getParameter("zfwsqtbid")!=null&&!"".equals(request.getParameter("zfwsqtbid"))){
//		sb.append("   and a.xxclwptzsid = '").append(request.getParameter("zfwsqtbid")).append("'"); //
//		}
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "xxclwptzsid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxxclwptzs16DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 先行处理物品通知书
        Zfwsxxclwptzs16DTO v_zfwsxxclwptzs16DTO = new Zfwsxxclwptzs16DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwsxxclwptzs16DTO = (Zfwsxxclwptzs16DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 文书编号，默认从案件登记表中获取案件登记编号
                    v_zfwsxxclwptzs16DTO.setXxclwsbh(v_zfajdj.getAjdjbh());
                    // 当事人，默认从案件登记表中获取企业名称
                    v_zfwsxxclwptzs16DTO.setXxcldsr(v_zfajdj.getCommc());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                v_zfwsxxclwptzs16DTO.setXxcldsr(v_pcom.getCommc());
            }
            // 获取查封扣押决定书
            if (queryZfwscfkyjds(dto.getAjdjid()) != null) {
                Zfwscfkyjds12 v_zfwscfkyjds = (Zfwscfkyjds12) queryZfwscfkyjds(dto.getAjdjid()).get(0);
                // 查封扣押日期，默认从查封扣押表中获取盖章日期
                v_zfwsxxclwptzs16DTO.setXxclcfkyrq(v_zfwscfkyjds.getCfkygzrq());
                // 查封扣押文书编号，默认从查封扣押表中获取查封扣押文书编号
                v_zfwsxxclwptzs16DTO.setXxclcfkyjdsbh(v_zfwscfkyjds.getCfkywsbh());
            }
            // 查询先行处理物品清单
            Zfwswpqd37 z37 = queryZfwswpqd37(dto.getAjdjid(), "ZFAJZFWS3706");
            if (z37 != null) {
                // 附件信息，默认取先行处理物品清单
                v_zfwsxxclwptzs16DTO.setXxclfj(z37.getWpqdwsbh() + "《先行处理物品清单》");
            }
        }

        return v_zfwsxxclwptzs16DTO;
    }

    /**
     * saveZfwsxxclwptzs的中文名称：保存先行处理物品通知书
     * <p/>
     * saveZfwsxxclwptzs的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsxxclwptzs(HttpServletRequest request,
                                    Zfwsxxclwptzs16DTO dto) {
        String xxclwptzsid = null;
        try {
            xxclwptzsid = saveZfwsxxclwptzsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xxclwptzsid;
    }

    /**
     * saveZfwsxxclwptzsImp的中文名称：保存执法文书实现方法
     * <p/>
     * saveZfwsxxclwptzsImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsxxclwptzsImp(HttpServletRequest request,
                                       Zfwsxxclwptzs16DTO dto) throws Exception {
        // 过滤为空字符的日期
        if ("".equals(dto.getXxcldsrqzrq())) {
            dto.setXxcldsrqzrq(null);
        }
        if ("".equals(dto.getXxclcfkyrq())) {
            dto.setXxclcfkyrq(null);
        }
        if ("".equals(dto.getXxclgzrq())) {
            dto.setXxclgzrq(null);
        }
        // 判断id为空，不为空更新，为空添加
        if ((null != dto.getXxclwptzsid())
                && (!"".equals(dto.getXxclwptzsid()))) {
            Zfwsxxclwptzs16 se = dao.fetch(Zfwsxxclwptzs16.class, dto
                    .getXxclwptzsid());
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setXxclcfkyjdsbh(dto.getXxclcfkyjdsbh()); // 查封扣押决定书编号
            se.setXxclcfkyrq(dto.getXxclcfkyrq()); // 查封扣押日期
            se.setXxclclfs(dto.getXxclclfs()); // 处理方式
            se.setXxcldsr(dto.getXxcldsr()); // 当事人
            se.setXxclfj(dto.getXxclfj()); // 附件
            se.setXxclgzrq(dto.getXxclgzrq()); // 盖章日期
            se.setXxclwplb(dto.getXxclwplb()); // 物品类别
            se.setXxclwsbh(dto.getXxclwsbh()); // 文书编号
            se.setXxcldsrqz(dto.getXxcldsrqz()); // 当事人签字
            se.setXxcldsrqzrq(dto.getXxcldsrqzrq()); // 当事人签字日期
            dao.update(se);
            return dto.getXxclwptzsid();
        } else {
            // 先行处理物品通知书
            String v_id = DbUtils.getSequenceStr();
            Zfwsxxclwptzs16 v_zfwsxxclwptzs16 = new Zfwsxxclwptzs16();
            BeanHelper.copyProperties(dto, v_zfwsxxclwptzs16);
            v_zfwsxxclwptzs16.setXxclwptzsid(v_id);
            dao.insert(v_zfwsxxclwptzs16);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '");
            sb.append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwscaspbObj的中文名称：撤案审批表
     * <p/>
     * queryZfwscaspbObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书21
    public Object queryZfwscaspbObj(HttpServletRequest request,
                                    Zfwscaspb21DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 撤案审批表id
        String caspbid = request.getParameter("zfwsqtbid");
        if (caspbid != null && !"".equals(caspbid) && !"undefined".equals(caspbid)) {
            dto.setCaspbid(caspbid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,(select getAa10_aaa103('AJDJAJLY',a.ajdjajly)) as ajdjajlystr ");
        sb.append("  from zfwscaspb21 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // 案件登记id
        sb.append("  and a.caspbid = :caspbid");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "caspbid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwscaspb21DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 撤案审批表内容
        Zfwscaspb21DTO v_zfwscaspb21DTO = new Zfwscaspb21DTO();

        if (ls != null && ls.size() > 0) {
            v_zfwscaspb21DTO = (Zfwscaspb21DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_zfwscaspb21DTO.setAjdjay(v_zfajdj.getAjdjay()); // 案由
                    v_zfwscaspb21DTO.setCaspdsr(v_zfajdj.getCommc()); // 企业名称
                    v_zfwscaspb21DTO.setCaspfddbr(v_zfajdj.getComfrhyz()); // 企业法人业主
                    v_zfwscaspb21DTO.setCaspdz(v_zfajdj.getComdz()); // 企业地址
                    v_zfwscaspb21DTO.setCasplxfs(v_zfajdj.getComyddh()); // 联系电话
                    v_zfwscaspb21DTO.setAjdjajly(v_zfajdj.getAjdjajly()); // 案件来源
                    v_zfwscaspb21DTO.setAjdjajlystr(v_zfajdj.getAjdjajlystr()); // 案件来源对应汉字
                    v_zfwscaspb21DTO.setCasplasj(v_zfajdj.getLiansj()); // 立案时间
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                v_zfwscaspb21DTO.setCaspdsr(v_pcom.getCommc()); // 企业名称
                v_zfwscaspb21DTO.setCaspfddbr(v_pcom.getComfrhyz()); // 企业法人业主
                v_zfwscaspb21DTO.setCaspdz(v_pcom.getComdz()); // 企业地址
                v_zfwscaspb21DTO.setCasplxfs(v_pcom.getComyddh()); // 联系电话
            }
        }
        return v_zfwscaspb21DTO;
    }

    /**
     * saveZfwscaspb的中文名称：保存撤案审批表
     * <p/>
     * saveZfwscaspb的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwscaspb(HttpServletRequest request, Zfwscaspb21DTO dto) {
        String caspbid = null;
        try {
            caspbid = saveZfwscaspbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return caspbid;
    }

    /**
     * saveZfwscaspbImp的中文名称：保存撤案审批表实现方法
     * <p/>
     * saveZfwscaspbImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwscaspbImp(HttpServletRequest request, Zfwscaspb21DTO dto)
            throws Exception {
        if ("".equals(dto.getCaspcbrqzrq())) {
            dto.setCaspcbrqzrq(null);
        }
        if ("".equals(dto.getCaspcbbmfzrrq())) {
            dto.setCaspcbbmfzrrq(null);
        }
        if ("".equals(dto.getCaspshfzrrq())) {
            dto.setCaspshfzrrq(null);
        }
        if ("".equals(dto.getCasplasj())) {
            dto.setCasplasj(null);
        }
        if ("".equals(dto.getCaspfzfzrrq())) {
            dto.setCaspfzfzrrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getCaspbid()) && (!"".equals(dto.getCaspbid()))) {
            Zfwscaspb21 se = dao.fetch(Zfwscaspb21.class, dto.getCaspbid());
            se.setAjdjajly(dto.getAjdjajly()); // 案件来源
            se.setAjdjay(dto.getAjdjay()); // 案由
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setCaspaqdczy(dto.getCaspaqdczy()); // 案情调查摘要
            se.setCaspcaly(dto.getCaspcaly()); // 撤案理由
            se.setCaspcbbmfzr(dto.getCaspcbbmfzr()); // 承办部门负责人签字
            se.setCaspcbbmfzrrq(dto.getCaspcbbmfzrrq()); // 承办部门负责人签字日期
            se.setCaspcbrqz(dto.getCaspcbrqz()); // 承办人签字1
            se.setCaspcbrqz2(dto.getCaspcbrqz2()); // 承办人签章2
            se.setCaspcbrqzrq(dto.getCaspcbrqzrq()); // 承办人签字日期
            se.setCaspdsr(dto.getCaspdsr()); // 当事人
            se.setCaspdz(dto.getCaspdz()); // 地址
            se.setCaspfddbr(dto.getCaspfddbr()); // 法定代表人
            se.setCaspfzfzr(dto.getCaspfzfzr()); // 分管分责人
            se.setCaspfzfzrrq(dto.getCaspfzfzrrq()); // 分管负责人签字日期
            se.setCasplasj(dto.getCasplasj()); // 立案时间
            se.setCasplxfs(dto.getCasplxfs()); // 联系方式
            se.setCaspshbmyj(dto.getCaspshbmyj()); // 审核部门意见
            se.setCaspshfzr(dto.getCaspshfzr()); // 审核部门负责人
            se.setCaspshfzrrq(dto.getCaspshfzrrq()); // 审核部门分责任签字日期
            se.setCaspspyj(dto.getCaspspyj()); // 审批意见
            dao.update(se);
            return dto.getCaspbid();
        } else {
            // 获取系统时间
            // 撤案审批表
            String v_id = DbUtils.getSequenceStr();
            Zfwscaspb21 v_zfwscaspb21 = new Zfwscaspb21();
            BeanHelper.copyProperties(dto, v_zfwscaspb21);
            v_zfwscaspb21.setCaspbid(v_id);
            dao.insert(v_zfwscaspb21);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwstzblObj的中文名称：听证笔录
     * <p/>
     * queryZfwstzblObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书24
    public Object queryZfwstzblObj(HttpServletRequest request, Zfwstzbl24DTO dto)
            throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }

        // 听证笔录id
        String tzblid = request.getParameter("zfwsqtbid");
        if (tzblid != null && !"".equals(tzblid) && !"undefined".equals(tzblid)) {
            dto.setTzblid(tzblid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,(select getAa10_aaa103('AAC004',a.tzblfddbrxb)) as tzblfddbrxbstr,");
        sb.append("(select getAa10_aaa103('AAC004',a.tzblwtdlrxb)) as tzblwtdlrxbstr ");
        sb.append("  from zfwstzbl24 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // id
        sb.append("  and a.tzblid = :tzblid ");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "tzblid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwstzbl24DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 听证笔录
        Zfwstzbl24DTO v_zfwstzbl24DTO = new Zfwstzbl24DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwstzbl24DTO = (Zfwstzbl24DTO) ls.get(0);
        } else { // 添加默认数据
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_zfwstzbl24DTO.setAjdjay(v_zfajdj.getAjdjay()); // 案由
                    v_zfwstzbl24DTO.setTzbldsr(v_zfajdj.getCommc()); // 当事人（企业名称）
                    v_zfwstzbl24DTO.setTzblfddbr(v_zfajdj.getComfrhyz()); // 企业法人业主
                    v_zfwstzbl24DTO.setTzblfddbrxb(v_zfajdj.getComfrxb()); // 企业法人性别
                    v_zfwstzbl24DTO.setTzblfddbrnl(v_zfajdj.getComfrnl() == null ? "" : v_zfajdj.getComfrnl().toString()); // 企业法人年龄
                    v_zfwstzbl24DTO.setTzblfddbrlxfs(v_zfajdj.getComyddh()); // 联系方式
                    v_zfwstzbl24DTO.setTzbldz(v_zfajdj.getComdz()); // 企业地址
                }
                // 获取执法人员信息
                List<?> cbrs = queryZfajcbr(dto.getAjdjid());
                if (cbrs != null && cbrs.size() > 0) {
                    v_zfwstzbl24DTO.setTzblajcbr1(((Zfajcbr) cbrs.get(0)).getZfryxm()); // 执法人员1姓名
                    v_zfwstzbl24DTO.setTzblajcbr1bm(((Zfajcbr) cbrs.get(0)).getZfrybmmc()); // 执法人员1部门
                    v_zfwstzbl24DTO.setTzblajcbr1zw(((Zfajcbr) cbrs.get(0)).getZfryzw()); // 执法人员1职务
                    if (cbrs.size() > 1) {
                        v_zfwstzbl24DTO.setTzblajcbr2(((Zfajcbr) cbrs.get(1)).getZfryxm()); // 执法人员2姓名
                        v_zfwstzbl24DTO.setTzblajcbr2bm(((Zfajcbr) cbrs.get(1)).getZfrybmmc()); // 执法人员2部门
                        v_zfwstzbl24DTO.setTzblajcbr2zw(((Zfajcbr) cbrs.get(1)).getZfryzw()); // 执法人员2职务
                    }
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                v_zfwstzbl24DTO.setTzbldsr(v_pcom.getCommc()); // 当事人（企业名称）
                v_zfwstzbl24DTO.setTzblfddbr(v_pcom.getComfrhyz()); // 企业法人业主
                v_zfwstzbl24DTO.setTzblfddbrxb(v_pcom.getComfrxb()); // 企业法人性别
//				v_zfwstzbl24DTO.setTzblfddbrnl(v_pcom.getComfrnl()==null?"":v_zfajdj.getComfrnl().toString()); // 企业法人年龄
                v_zfwstzbl24DTO.setTzblfddbrlxfs(v_pcom.getComyddh()); // 联系方式
                v_zfwstzbl24DTO.setTzbldz(v_pcom.getComdz()); // 企业地址
            }
        }
        return v_zfwstzbl24DTO;
    }

    /**
     * saveZfwstzbl的中文名称：保存听证笔录
     * <p/>
     * saveZfwstzbl的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwstzbl(HttpServletRequest request, Zfwstzbl24DTO dto) {
        String tzblid = null;
        try {
            tzblid = saveZfwstzblImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return tzblid;
    }

    /**
     * saveZfwstzblImp的中文名称：保存听证笔录实现方法
     * <p/>
     * saveZfwstzblImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwstzblImp(HttpServletRequest request, Zfwstzbl24DTO dto)
            throws Exception {
        if ("".equals(dto.getTzblajcbrrq())) {
            dto.setTzblajcbrrq(null);
        }
        if ("".equals(dto.getTzbldsrqzrq())) {
            dto.setTzbldsrqzrq(null);
        }
        if ("".equals(dto.getTzbltzkssj())) {
            dto.setTzbltzkssj(null);
        }
        if ("".equals(dto.getTzbltzjssj())) {
            dto.setTzbltzjssj(null);
        }
        if ("".equals(dto.getTzbltzzcrqzrq())) {
            dto.setTzbltzzcrqzrq(null);
        }
        if ("".equals(dto.getTzbljlrqzrq())) {
            dto.setTzbljlrqzrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getTzblid()) && (!"".equals(dto.getTzblid()))) {
            Zfwstzbl24 se = dao.fetch(Zfwstzbl24.class, dto.getTzblid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getTzblid();
        } else {
            // 获取id
            String v_id = DbUtils.getSequenceStr();
            Zfwstzbl24 v_zfwstzbl24 = new Zfwstzbl24();
            BeanHelper.copyProperties(dto, v_zfwstzbl24);
            v_zfwstzbl24.setTzblid(v_id);
            dao.insert(v_zfwstzbl24);
            // 更新执法文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajzfwsid='").append(dto.getAjzfwsid()).append("'");

//			StringBuffer sb = new StringBuffer();
//			sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
//					.append("',zfwstzbz='1'");
//			sb.append(" where a.ajdjid=").append(dto.getAjdjid()).append(
//					" and zfwsdmz = '").append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwsxzcfjdsObj的中文名称：行政处罚决定书
     * <p/>
     * queryZfwsxzcfjdsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    public Object queryZfwsxzcfjdsObj(HttpServletRequest request,
                                      Zfwsxzcfjds28DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 行政处罚决定书id
        String xzcfjdsid = request.getParameter("zfwsqtbid");
        if (xzcfjdsid != null && !"".equals(xzcfjdsid) && !"undefined".equals(xzcfjdsid)) {
            dto.setXzcfjdsid(xzcfjdsid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append("  select a.* ,");
        sb.append("  (select getAa10_aaa103('AAC004',a.cfjdfddbrxb)) as cfjdfddbrxbstr, ");
        sb.append("  (select getAa10_aaa103('AAC004',a.cfjdbcfrzrrxb)) as cfjdbcfrzrrxbstr, ");
        sb.append("  (select getAa10_aaa103('AAC004',a.cfjdbcfrdwfddbrxb)) as cfjdbcfrdwfddbrxbstr, ");
        sb.append("  (select getAa10_aaa103('COMZZZM',a.cfjdyyzz)) as cfjdyyzzstr ,");
        sb.append("  (select getAa10_aaa103('COMZZZM',a.cfjdbcfrdwyyzz)) as cfjdbcfrdwyyzzstr");
        sb.append(" ,(select getAa10_aaa103('WFXWDC',a.wfxwdc)) as wfxwdcstr ");
        sb.append("  from zfwsxzcfjds28 a ");
        sb.append("  where 1 = 1 ");
        sb.append("  and a.ajdjid = :ajdjid ");
        sb.append("  and a.xzcfjdsid = :xzcfjdsid");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "xzcfjdsid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfjds28DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 行政处罚决定书
        Zfwsxzcfjds28DTO v_zfwsxzcfjds28DTO = new Zfwsxzcfjds28DTO();
        // 查询案件登记信息
        if (ls != null && ls.size() > 0) {
            v_zfwsxzcfjds28DTO = (Zfwsxzcfjds28DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdjdto = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdjdto != null) {
                    v_zfwsxzcfjds28DTO.setCfjdbcfrdwfddbr(v_zfajdjdto.getComfrhyz()); // 被处罚人（单位）法定代表人
                    v_zfwsxzcfjds28DTO.setCfjdlarq(v_zfajdjdto.getLiansj()); // 立案日期
                    v_zfwsxzcfjds28DTO.setCfjdajmc(v_zfajdjdto.getAjdjay()); // 案件名称
                    v_zfwsxzcfjds28DTO.setCfjdbcfrdwmc(v_zfajdjdto.getCommc()); // 企业名称
                    v_zfwsxzcfjds28DTO.setCfjdwfxw(v_zfajdjdto.getAjdjay()); // 违法行为
                    // 获取食药局名称
                    Aa01 v_syjmc = SysmanageUtil.getAa01Fdq("SJSPYPJDGLJ");
                    if (v_syjmc != null && !"".equals(v_syjmc)) {
                        v_zfwsxzcfjds28DTO.setSjspypjdglj(v_syjmc.getAaa005());
                    }
                    // 上级人民政府aaa100=SJRMZF
                    Aa01 v_sjrmzf = SysmanageUtil.getAa01Fdq("SJRMZF");
                    if (v_sjrmzf != null && !"".equals(v_sjrmzf)) {
                        v_zfwsxzcfjds28DTO.setSjrmzf(v_sjrmzf.getAaa005());
                    }
                    // 上级人民法院aaa100=SJRMFY
                    Aa01 v_sjrmfy = SysmanageUtil.getAa01Fdq("SJRMFY");
                    if (v_sjrmfy != null && !"".equals(v_sjrmfy)) {
                        v_zfwsxzcfjds28DTO.setSjrmfy(v_sjrmfy.getAaa005());
                    }
                    // 强制执行人员法院aaa100=QZZZRMFY
                    Aa01 v_qzzzrmfy = SysmanageUtil.getAa01Fdq("QZZZRMFY");
                    if (v_qzzzrmfy != null && !"".equals(v_qzzzrmfy)) {
                        v_zfwsxzcfjds28DTO.setQzzzrmfy(v_qzzzrmfy.getAaa005());
                    }
                    // 罚没款缴款银行
                    Aa01 v_jkyh = SysmanageUtil.getAa01Fdq("FMKJKYH");
                    if (v_jkyh != null && !"".equals(v_jkyh)) {
                        v_zfwsxzcfjds28DTO.setCfjdjkyh(v_jkyh.getAaa005());
                    }
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                v_zfwsxzcfjds28DTO.setCfjdbcfrdwfddbr(v_pcom.getComfrhyz()); // 被处罚人（单位）法定代表人
                v_zfwsxzcfjds28DTO.setCfjdbcfrdwmc(v_pcom.getCommc()); // 企业名称
                // 获取食药局名称
                Aa01 v_syjmc = SysmanageUtil.getAa01Fdq("SJSPYPJDGLJ");
                if (v_syjmc != null && !"".equals(v_syjmc)) {
                    v_zfwsxzcfjds28DTO.setSjspypjdglj(v_syjmc.getAaa005());
                }
                // 上级人民政府aaa100=SJRMZF
                Aa01 v_sjrmzf = SysmanageUtil.getAa01Fdq("SJRMZF");
                if (v_sjrmzf != null && !"".equals(v_sjrmzf)) {
                    v_zfwsxzcfjds28DTO.setSjrmzf(v_sjrmzf.getAaa005());
                }
                // 上级人民法院aaa100=SJRMFY
                Aa01 v_sjrmfy = SysmanageUtil.getAa01Fdq("SJRMFY");
                if (v_sjrmfy != null && !"".equals(v_sjrmfy)) {
                    v_zfwsxzcfjds28DTO.setSjrmfy(v_sjrmfy.getAaa005());
                }
                // 强制执行人员法院aaa100=QZZZRMFY
                Aa01 v_qzzzrmfy = SysmanageUtil.getAa01Fdq("QZZZRMFY");
                if (v_qzzzrmfy != null && !"".equals(v_qzzzrmfy)) {
                    v_zfwsxzcfjds28DTO.setQzzzrmfy(v_qzzzrmfy.getAaa005());
                }
                // 罚没款缴款银行
                Aa01 v_jkyh = SysmanageUtil.getAa01Fdq("FMKJKYH");
                if (v_jkyh != null && !"".equals(v_jkyh)) {
                    v_zfwsxzcfjds28DTO.setCfjdjkyh(v_jkyh.getAaa005());
                }
            }
            // 若行政机关名称为空，默认从aa01表中取食品药品监督管理局全称
            Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
            v_zfwsxzcfjds28DTO.setZxjgmc(v_aa01.getAaa005());
        }
        return v_zfwsxzcfjds28DTO;
    }

    /**
     * saveZfwsxzcfjds的中文名称：保存行政处罚决定书
     * <p/>
     * saveZfwsxzcfjds的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsxzcfjds(HttpServletRequest request,
                                  Zfwsxzcfjds28DTO dto) {
        String xzcfjdsid = null;
        try {
            xzcfjdsid = saveZfwsxzcfjdsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xzcfjdsid;
    }

    /**
     * saveZfwsxzcfjdsImp的中文名称：保存行政处罚决定书实现方法
     * <p/>
     * saveZfwsxzcfjdsImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsxzcfjdsImp(HttpServletRequest request,
                                     Zfwsxzcfjds28DTO dto) throws Exception {
        if ("".equals(dto.getCfjdgzrq())) {
            dto.setCfjdgzrq(null);
        }
        if ("".equals(dto.getCfjdwfxwksrq())) {
            dto.setCfjdwfxwksrq(null);
        }
        if ("".equals(dto.getCfjdwfxwjsrq())) {
            dto.setCfjdwfxwjsrq(null);
        }
        if ("".equals(dto.getCfjdlarq())) {
            dto.setCfjdlarq(null);
        }
        if ("".equals(dto.getCfjdbcfrzrrnl())) {
            dto.setCfjdbcfrzrrnl(null);
        }
        // 判断id是否为空
        if ((null != dto.getXzcfjdsid()) && (!"".equals(dto.getXzcfjdsid()))) {
            Zfwsxzcfjds28 se = dao.fetch(Zfwsxzcfjds28.class, dto
                    .getXzcfjdsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getXzcfjdsid();
        } else {
            // 获取id
            String v_id = DbUtils.getSequenceStr();
            Zfwsxzcfjds28 v_zfwsxzcfjds28 = new Zfwsxzcfjds28();
            BeanHelper.copyProperties(dto, v_zfwsxzcfjds28);
            v_zfwsxzcfjds28.setXzcfjdsid(v_id);
            dao.insert(v_zfwsxzcfjds28);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwsmswpclqdObj的中文名称：没收物品处理清单
     * <p/>
     * queryZfwsmswpclqdObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书31
    public Object queryZfwsmswpclqdObj(HttpServletRequest request,
                                       Zfwsmswpclqd31DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 没收物品处理清单id
        String mswpclqdid = request.getParameter("zfwsqtbid");
        if (mswpclqdid != null && !"".equals(mswpclqdid) && !"undefined".equals(mswpclqdid)) {
            dto.setMswpclqdid(mswpclqdid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsmswpclqd31 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // id
        sb.append("  and a.mswpclqdid = :mswpclqdid");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "mswpclqdid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsmswpclqd31DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 没收物品处理清单
        Zfwsmswpclqd31DTO v_zfwsmswpclqd31DTO = new Zfwsmswpclqd31DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwsmswpclqd31DTO = (Zfwsmswpclqd31DTO) ls.get(0);
        } else {
            Zfwsxzcfjds28 v_zfwsxzcfjds28 = new Zfwsxzcfjds28();
            // 填第31章文书时若28不填可能报错，在这里判断
            if (queryZfwsxzcfjds(dto.getAjdjid()) != null) {
                // 获取行政处罚决定书信息
                v_zfwsxzcfjds28 = (Zfwsxzcfjds28) queryZfwsxzcfjds(
                        dto.getAjdjid()).get(0);
            }

            if (v_zfwsxzcfjds28 != null) {
                v_zfwsmswpclqd31DTO.setMsclxzcfjdsbh(v_zfwsxzcfjds28.getCfjdwsbh()); // 文书编号
            }
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_zfwsmswpclqd31DTO.setMscldsr(v_zfajdj.getCommc()); // 当事人(企业名称)
                    v_zfwsmswpclqd31DTO.setMscldsrdz(v_zfajdj.getComdz()); // 地址
                    v_zfwsmswpclqd31DTO.setMscldsrdh(v_zfajdj.getComyddh()); // 电话
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                if (v_pcom != null) {
                    v_zfwsmswpclqd31DTO.setMscldsr(v_pcom.getCommc()); // 当事人(企业名称)
                    v_zfwsmswpclqd31DTO.setMscldsrdz(v_pcom.getComdz()); // 地址
                    v_zfwsmswpclqd31DTO.setMscldsrdh(v_pcom.getComyddh()); // 电话
                }
            }
            // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
            Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
            v_zfwsmswpclqd31DTO.setXzjgmc(v_aa01.getAaa005());
        }
        return v_zfwsmswpclqd31DTO;
    }

    /**
     * saveZfwsmswpclqd的中文名称：保存没收物品处理清单
     * <p/>
     * saveZfwsmswpclqd的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsmswpclqd(HttpServletRequest request,
                                   Zfwsmswpclqd31DTO dto) {
        String mswpclqdid = null;
        try {
            mswpclqdid = saveZfwsmswpclqdImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return mswpclqdid;
    }

    /**
     * saveZfwsmswpclqdImp的中文名称：保存没收物品处理清单实现方法
     * <p/>
     * saveZfwsmswpclqdImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsmswpclqdImp(HttpServletRequest request,
                                      Zfwsmswpclqd31DTO dto) throws Exception {
        String v_mswpclqdid = "";
        String mswpclqdid = null;
        if ("".equals(dto.getMscltycjrrq())) {
            dto.setMscltycjrrq(null);
        }
        if ("".equals(dto.getMsclcbrrq())) {
            dto.setMsclcbrrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getMswpclqdid()) && (!"".equals(dto.getMswpclqdid()))) {
            Zfwsmswpclqd31 se = dao.fetch(Zfwsmswpclqd31.class, dto
                    .getMswpclqdid());
            BeanHelper.copyProperties(dto, se);
            v_mswpclqdid = dto.getMswpclqdid();
            dao.update(se);
            // 保存明细，思路，先删除重新插入
            String v_sql = "delete from Zfwsmswpclqkmxb31 where mswpclqdid='"
                    + dto.getMswpclqdid() + "'";
            Sql sql2 = Sqls.create(v_sql);
            dao.execute(sql2);
            mswpclqdid = dto.getMswpclqdid();
        } else {
            // 获取id
            String v_id = DbUtils.getSequenceStr();
            v_mswpclqdid = v_id;
            // 没收物品处理清单
            Zfwsmswpclqd31 v_zfwsmswpclqd31 = new Zfwsmswpclqd31();
            BeanHelper.copyProperties(dto, v_zfwsmswpclqd31);
            v_zfwsmswpclqd31.setMswpclqdid(v_id);
            dao.insert(v_zfwsmswpclqd31);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            mswpclqdid = v_id;
        }

        JSONArray v_array = null;
        Object[] v_objArray = null;
        // 申请人生产加工场所有关情况
        v_array = JSONArray.fromObject(dto.getMswpclqkmxb_table_rows());
        v_objArray = v_array.toArray();
        String v_mswpmxbid = "";
        for (int i = 0; i <= v_objArray.length - 1; i++) {
            JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
            Zfwsmswpclqkmxb31 v_Zfwsmswpclqkmxb31 = (Zfwsmswpclqkmxb31) JSONObject
                    .toBean(v_obj, Zfwsmswpclqkmxb31.class);
            // 获取没收物品明细id
            v_mswpmxbid = DbUtils.getSequenceStr();
            v_Zfwsmswpclqkmxb31.setMswpmxbid(v_mswpmxbid);
            v_Zfwsmswpclqkmxb31.setMswpclqdid(v_mswpclqdid);
            dao.insert(v_Zfwsmswpclqkmxb31);
        }
        return mswpclqdid;
    }

    /**
     * queryZfwsmswpclqdmx的中文名称：查询没收物品处理清单明细
     * <p/>
     * queryZfwsmswpclqdmx的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : gjf
     * @throws Exception
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public Map queryZfwsmswpclqdmx(Zfwsmswpclqd31DTO dto, PagesDTO pd)
            throws Exception {

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from zfwsmswpclqkmxb31 a,zfwsmswpclqd31 b ");
        sb.append(" where a.mswpclqdid=b.mswpclqdid ");
        sb.append("  and b.ajdjid = :ajdjid");

        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid"};
        int[] ParaType = new int[]{Types.VARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("zfwsmswpclqkmxb31 zfwsmswpclqkmxb31 " + sql);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsmswpclqd31DTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * queryZfwsxzcfqzzxsqsObj的中文名称：行政处罚强制执行申请书
     * <p/>
     * queryZfwsxzcfqzzxsqsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书33
    public Object queryZfwsxzcfqzzxsqsObj(HttpServletRequest request,
                                          Zfwsxzcfqzzxsqs33DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 行政处罚强制执行申请书ID
        String xzcfqzzxsqsid = request.getParameter("zfwsqtbid");
        if (xzcfqzzxsqsid != null && !"".equals(xzcfqzzxsqsid) && !"undefined".equals(xzcfqzzxsqsid)) {
            dto.setXzcfqzzxsqsid(xzcfqzzxsqsid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsxzcfqzzxsqs33 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // id
        sb.append("  and a.xzcfqzzxsqsid = :xzcfqzzxsqsid");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "xzcfqzzxsqsid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfqzzxsqs33DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 行政处罚强制执行申请书
        Zfwsxzcfqzzxsqs33DTO v_zfwsxzcfqzzxsqs33DTO = new Zfwsxzcfqzzxsqs33DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwsxzcfqzzxsqs33DTO = (Zfwsxzcfqzzxsqs33DTO) ls.get(0);
        } else {

            Zfwsxzcfjds28 v_zfwsxzcfjds28 = new Zfwsxzcfjds28();
            //用到了之前的文书，但还没有填写，添加判断，增强系统容错性
            if (queryZfwsxzcfjds(dto.getAjdjid()) != null) {
                // 获取行政处罚决定书信息
                v_zfwsxzcfjds28 = (Zfwsxzcfjds28) queryZfwsxzcfjds(
                        dto.getAjdjid()).get(0);
            }
            if (v_zfwsxzcfjds28 != null) {
                v_zfwsxzcfqzzxsqs33DTO.setQzsqxzcfjdbh(v_zfwsxzcfjds28.getCfjdwsbh()); // 文书编号
                v_zfwsxzcfqzzxsqs33DTO.setQzsqsdbsqrrq(v_zfwsxzcfjds28.getCfjdgzrq()); // 行政处罚决定日期（行政处罚决定书盖章日期）
            }
            Zfwsxzcfsxgzs26 v_zfwsxzcfsxgzs26 = new Zfwsxzcfsxgzs26();
            if (queryZfwsxzcfsxgzs(dto.getAjdjid()) != null) {
                // 获取行政处罚事先告知书信息
                v_zfwsxzcfsxgzs26 = (Zfwsxzcfsxgzs26) queryZfwsxzcfsxgzs(dto.getAjdjid()).get(0);
            }

            if (v_zfwsxzcfsxgzs26 != null) {
                v_zfwsxzcfqzzxsqs33DTO.setQzsqsqrzcxzcfrq(v_zfwsxzcfsxgzs26.getSxgzgzrq()); // 行政处罚告知日期（行政处罚告知书盖章日期）
            }
            // 获取所在统筹地区
            Aa01 v_syjmc = SysmanageUtil.getAa01Fdq("SPYPJDGLJMC");
            v_zfwsxzcfqzzxsqs33DTO.setQzsqrmfymc(v_syjmc.getAaa005());
            // 获取申请人名称
            Aa01 v_sqr = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
            v_zfwsxzcfqzzxsqs33DTO.setQzsqsqr(v_sqr.getAaa005());
            // 行政机关名称
            v_zfwsxzcfqzzxsqs33DTO.setXzjgmc(v_sqr.getAaa005());
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_zfwsxzcfqzzxsqs33DTO.setQzsqbsqr(v_zfajdj.getCommc()); // 被申请人(企业名称)
                    v_zfwsxzcfqzzxsqs33DTO.setQzsqbsqrfddbr(v_zfajdj.getComfrhyz()); // 被申请人法定代表人
                    v_zfwsxzcfqzzxsqs33DTO.setQzsqbsqrzw(v_zfajdj.getComfrzw()); // 被申请人职务
                    v_zfwsxzcfqzzxsqs33DTO.setQzsqbsqrlxdh(v_zfajdj.getComyddh()); // 被申请人联系电话（电话）
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                if (v_pcom != null) {
                    v_zfwsxzcfqzzxsqs33DTO.setQzsqbsqr(v_pcom.getCommc()); // 被申请人(企业名称)
                    v_zfwsxzcfqzzxsqs33DTO.setQzsqbsqrfddbr(v_pcom.getComfrhyz()); // 被申请人法定代表人
                    v_zfwsxzcfqzzxsqs33DTO.setQzsqbsqrzw(v_pcom.getComfrzw()); // 被申请人职务
                    v_zfwsxzcfqzzxsqs33DTO.setQzsqbsqrlxdh(v_pcom.getComyddh()); // 被申请人联系电话（电话）
                }
            }
        }
        return v_zfwsxzcfqzzxsqs33DTO;
    }

    /**
     * saveZfwsxzcfqzzxsqs的中文名称：保存行政处罚强制执行申请书
     * <p/>
     * saveZfwsxzcfqzzxsqs的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsxzcfqzzxsqs(HttpServletRequest request,
                                      Zfwsxzcfqzzxsqs33DTO dto) {
        String xzcfqzzxsqsid = null;
        try {
            xzcfqzzxsqsid = saveZfwsxzcfqzzxsqsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xzcfqzzxsqsid;
    }

    /**
     * saveZfwsxzcfqzzxsqsImp的中文名称：保存行政处罚强制执行申请书实现方法
     * <p/>
     * saveZfwsxzcfqzzxsqsImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsxzcfqzzxsqsImp(HttpServletRequest request,
                                         Zfwsxzcfqzzxsqs33DTO dto) throws Exception {
        if ("".equals(dto.getQzsqsqrcgrq())) {
            dto.setQzsqsqrcgrq(null);
        }
        if ("".equals(dto.getQzsqsdbsqrrq())) {
            dto.setQzsqsdbsqrrq(null);
        }
        if ("".equals(dto.getQzsqsqrzcxzcfrq())) {
            dto.setQzsqsqrzcxzcfrq(null);
        }
        if ("".equals(dto.getQzsqgzrq())) {
            dto.setQzsqgzrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getXzcfqzzxsqsid())
                && (!"".equals(dto.getXzcfqzzxsqsid()))) {
            Zfwsxzcfqzzxsqs33 se = dao.fetch(Zfwsxzcfqzzxsqs33.class, dto.getXzcfqzzxsqsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getXzcfqzzxsqsid();
        } else {
            // 获取id
            String v_id = DbUtils.getSequenceStr();
            Zfwsxzcfqzzxsqs33 v_zfwsxzcfqzzxsqs33 = new Zfwsxzcfqzzxsqs33();
            BeanHelper.copyProperties(dto, v_zfwsxzcfqzzxsqs33);
            v_zfwsxzcfqzzxsqs33.setXzcfqzzxsqsid(v_id);
            dao.insert(v_zfwsxzcfqzzxsqs33);
            // 更新执法文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwscssbfhyjsObj的中文名称：陈述申辩复核意见书
     * <p/>
     * queryZfwscssbfhyjsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO 文书35
    public Object queryZfwscssbfhyjsObj(HttpServletRequest request,
                                        Zfwscssbfhyjs35DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 陈述申辩复核意见书id
        String cssbfhyjsid = request.getParameter("zfwsqtbid");
        if (cssbfhyjsid != null && !"".equals(cssbfhyjsid) && !"undefined".equals(cssbfhyjsid)) {
            dto.setCssbfhyjsid(cssbfhyjsid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwscssbfhyjs35 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and ajdjid = :ajdjid "); // 案件登记id
        sb.append("  and a.cssbfhyjsid = :cssbfhyjsid ");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "cssbfhyjsid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwscssbfhyjs35DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 陈述申辩复核意见书
        Zfwscssbfhyjs35DTO v_zfwscssbfhyjs35DTO = new Zfwscssbfhyjs35DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwscssbfhyjs35DTO = (Zfwscssbfhyjs35DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_zfwscssbfhyjs35DTO.setAjdjay(v_zfajdj.getAjdjay()); // 案由
                    v_zfwscssbfhyjs35DTO.setSbfhdsr(v_zfajdj.getCommc()); // 当事人（企业名称）
                    v_zfwscssbfhyjs35DTO.setSbfhfddbr(v_zfajdj.getComfrhyz()); // 法定代表人(负责人)
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                if (v_pcom != null) {
                    v_zfwscssbfhyjs35DTO.setSbfhdsr(v_pcom.getCommc()); // 当事人（企业名称）
                    v_zfwscssbfhyjs35DTO.setSbfhfddbr(v_pcom.getComfrhyz()); // 法定代表人(负责人)
                }
            }
        }
        return v_zfwscssbfhyjs35DTO;
    }

    /**
     * saveZfwscssbfhyjs的中文名称：保存陈述申辩复核意见书
     * <p/>
     * saveZfwscssbfhyjs的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwscssbfhyjs(HttpServletRequest request,
                                    Zfwscssbfhyjs35DTO dto) {
        String cssbfhyjsid = null;
        try {
            cssbfhyjsid = saveZfwscssbfhyjsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return cssbfhyjsid;
    }

    /**
     * saveZfwscssbfhyjsImp的中文名称：保存陈述申辩复核意见实现方法
     * <p/>
     * saveZfwscssbfhyjsImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwscssbfhyjsImp(HttpServletRequest request,
                                       Zfwscssbfhyjs35DTO dto) throws Exception {
        // 判断id是否为空
        if ((null != dto.getCssbfhyjsid())
                && (!"".equals(dto.getCssbfhyjsid()))) {
            Zfwscssbfhyjs35 se = dao.fetch(Zfwscssbfhyjs35.class, dto
                    .getCssbfhyjsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getCssbfhyjsid();
        } else {
            // 获取系统时间
            String v_dbtime = SysmanageUtil.getDbtimeYmdHns();
            // 负责人签字日期
            if ((dto.getSbfhfzrqzrq() == null)
                    || ("".equals(dto.getSbfhfzrqzrq()))) {
                dto.setSbfhfzrqzrq(v_dbtime);
            }
            // id
            String v_id = DbUtils.getSequenceStr();
            Zfwscssbfhyjs35 v_zfwscssbfhyjs35 = new Zfwscssbfhyjs35();
            BeanHelper.copyProperties(dto, v_zfwscssbfhyjs35);
            v_zfwscssbfhyjs35.setCssbfhyjsid(v_id);
            dao.insert(v_zfwscssbfhyjs35);

            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append("'");

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwsspbObj的中文名称：通用审批表
     * <p/>
     * queryZfwsspbObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO 文书39
    public Object queryZfwsspbObj(HttpServletRequest request, Zfwsspb39DTO dto)
            throws Exception {

        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsspb39 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and tyspbid = :tyspbid "); // 审批表id
        sb.append("   and ajdjid = :ajdjid "); // 案件登记id
        sb.append("   and zfwsdmz = :zfwsdmz "); // 执法文书代码值
        // 查询参数
        String[] ParaName = new String[]{"tyspbid", "ajdjid", "zfwsdmz"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsspb39DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 通用审批表
        Zfwsspb39DTO v_zfwsspb39DTO = new Zfwsspb39DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwsspb39DTO = (Zfwsspb39DTO) ls.get(0);
        }
        return v_zfwsspb39DTO;
    }

    /**
     * saveZfwsspb的中文名称： 保存通用审批表
     * <p/>
     * saveZfwsspb的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsspb(HttpServletRequest request, Zfwsspb39DTO dto) {
        String tyspbid = null;
        try {
            tyspbid = saveZfwsspbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return tyspbid;
    }

    /**
     * saveZfwsspbImp的中文名称：保存通用审批表
     * <p/>
     * saveZfwsspbImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsspbImp(HttpServletRequest request, Zfwsspb39DTO dto)
            throws Exception {
        if ("".equals(dto.getSpajcbrqzrq())) {
            dto.setSpajcbrqzrq(null);
        }
        if ("".equals(dto.getSpbmfzrqzrq())) {
            dto.setSpbmfzrqzrq(null);
        }
        if ("".equals(dto.getSpfgfzrqzrq())) {
            dto.setSpfgfzrqzrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getTyspbid()) && (!"".equals(dto.getTyspbid()))) {
            Zfwsspb39 se = dao.fetch(Zfwsspb39.class, dto.getTyspbid());
            //BeanHelper.copyProperties(dto, se);
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setSpajcbr1qz(dto.getSpajcbr1qz()); // 案件承办人1签字
            se.setSpajcbr2qz(dto.getSpajcbr2qz()); // 案件承办人2签字
            se.setSpajcbrqzrq(dto.getSpajcbrqzrq()); // 案件承办人签字日期
            se.setSpajmc(dto.getSpajmc()); // 案件名称
            se.setSpbmfzrqz(dto.getSpbmfzrqz()); // 部门负责人签字
            se.setSpbmfzrqzrq(dto.getSpbmfzrqzrq()); // 部门负责人签字日期
            se.setSpcbbmyj(dto.getSpcbbmyj()); // 承办部门意见
            se.setSpfgfzrqz(dto.getSpfgfzrqz()); // 分管负责人签字
            se.setSpfgfzrqzrq(dto.getSpfgfzrqzrq()); // 分管负责人签字日期
            se.setSpfj(dto.getSpfj()); // 附件
            se.setSplyyj(dto.getSplyyj()); // 报请的理由及依据
            se.setSpsx(dto.getSpsx()); // 审批事项
            se.setSpyj(dto.getSpyj()); // 审批意见
            se.setZfwsdmz(dto.getZfwsdmz()); // 执法文书代码值
            dao.update(se);
            return dto.getTyspbid();
        } else {
            // id
            String v_id = DbUtils.getSequenceStr();
            Zfwsspb39 v_zfwsspb39 = new Zfwsspb39();
            BeanHelper.copyProperties(dto, v_zfwsspb39);
            v_zfwsspb39.setTyspbid(v_id);
            dao.insert(v_zfwsspb39);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwsxzcfsxgzs的中文名称：查询行政处罚事先告知书信息
     * <p/>
     * queryZfwsxzcfsxgzs的概要说明：
     *
     * @param prm_ajdjid
     * @return
     * @throws Exception Written by : zy
     */
    public List<?> queryZfwsxzcfsxgzs(String prm_ajdjid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsxzcfsxgzs26 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid='").append(prm_ajdjid).append("'");

        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfsxgzs26.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        if (ls != null && ls.size() > 0) {
            return ls;
        } else {
            return null;
        }
    }

    /**
     * queryZfwsxzcfjds的中文名称：查询行政处罚决定书
     * <p/>
     * queryZfwsxzcfjds的概要说明：
     *
     * @param ajdjid
     * @return
     * @throws Exception Written by : zy
     */
    public List<?> queryZfwsxzcfjds(String ajdjid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsxzcfjds28 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid='").append(ajdjid).append("'");

        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfjds28.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        if (ls != null && ls.size() > 0) {
            return ls;
        } else {
            return null;
        }
    }

    /**
     * queryZfwscfkyjds的中文名称：查询查封扣押决定书内容
     * <p/>
     * queryZfwscfkyjds的概要说明：
     *
     * @param ajdjid
     * @return
     * @throws Exception Written by : zy
     */
    public List<?> queryZfwscfkyjds(String ajdjid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwscfkyjds12 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid='").append(ajdjid).append("'");

        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwscfkyjds12.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        if (ls != null && ls.size() > 0) {
            return ls;
        } else {
            return null;
        }
    }

    /**
     * queryZfwswpqd37的中文名称：查询物品处理清单信息
     * <p/>
     * queryZfwswpqd37的概要说明：
     *
     * @param ajdjid
     * @param zfwsdmz
     * @return
     * @throws Exception Written by : zy
     */
    public Zfwswpqd37 queryZfwswpqd37(String ajdjid, String zfwsdmz)
            throws Exception {

        List<Zfwswpqd37> ls = dao.query(Zfwswpqd37.class,
                Cnd.where("ajdjid", "=", ajdjid).and("zfwsdmz", "=", zfwsdmz));

//		StringBuffer sb = new StringBuffer();
//		Zfwswpqd37DTO z37dto = new Zfwswpqd37DTO();
//		z37dto.setAjdjid(ajdjid);
//		z37dto.setZfwsdmz(zfwsdmz);
//		sb.append(" select a.* ");
//		sb.append("  from Zfwswpqd37 a ");
//		sb.append(" where 1 = 1 ");
//		sb.append("and ajdjid = :ajdjid ");
//		sb.append("and zfwsdmz = :zfwsdmz ");
//		String[] ParaName = new String[] { "ajdjid", "zfwsdmz" };
//		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
//		String sql = sb.toString();
//		sql = QueryFactory.getSQL(sql, ParaName, ParaType, z37dto);
//		Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
//				Zfwswpqd37.class);
//		List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        Zfwswpqd37 z37 = new Zfwswpqd37();
        if (ls != null && ls.size() > 0) {
            z37 = ls.get(0);
            return z37;
        } else {
            return null;
        }
    }

    /**
     * queryZfajdj的中文名称：查询案件登记信息
     * <p/>
     * queryZfajdj的概要说明：
     *
     * @param prm_ajdjid
     * @return
     * @throws Exception Written by : zy
     */
    public List<ZfajdjDTO> queryZfajdj(String prm_ajdjid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,(select getAa10_aaa103('COMZZZM',a.comzzzm)) as comzzzmstr, ");
        sb.append("(select getAa10_aaa103('AAC004',a.comfrxb)) as comfrxbstr, ");
        sb.append("(select getAa10_aaa103('AJDJAJLY',a.ajdjajly)) as ajdjajlystr ");
        sb.append("  from Zfajdj a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid='").append(prm_ajdjid).append("'");

        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ZfajdjDTO.class);
        List<ZfajdjDTO> ls = (List<ZfajdjDTO>) m.get(GlobalNames.SI_RESULTSET);
        if (ls != null && ls.size() > 0) {
            return ls;
        } else {
            return null;
        }
    }

    /**
     * ajhyjl的中文名称：案件合议记录 ajhyjl的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by:ly
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书18
    public Object ajhyjl(HttpServletRequest request, Zfwsajhyjl18DTO dto)
            throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 案件合议记录id
        String ajhyjlid = request.getParameter("zfwsqtbid");
        if (ajhyjlid != null && !"".equals(ajhyjlid) && !"undefined".equals(ajhyjlid)) {
            dto.setAjhyjlid(ajhyjlid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from zfwsajhyjl18 a ");
        sb.append(" where 1=1  ");
        sb.append(" and ajdjid=:ajdjid ");
        sb.append(" and ajhyjlid=:ajhyjlid ");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "ajhyjlid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsajhyjl18DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Zfwsajhyjl18DTO v_zfwsajhyjl18DTO = new Zfwsajhyjl18DTO();

        if (ls != null && ls.size() > 0) {
            v_zfwsajhyjl18DTO = (Zfwsajhyjl18DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 案由，默认从案件登记表中取案由
                    v_zfwsajhyjl18DTO.setAjdjay(v_zfajdj.getAjdjay());
                    // 当事人，默认从案件登记表中企业名称
                    v_zfwsajhyjl18DTO.setHydsr(v_zfajdj.getCommc());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 当事人，默认从案件登记表中企业名称
                v_zfwsajhyjl18DTO.setHydsr(v_pcom.getCommc());
            }
        }

        return v_zfwsajhyjl18DTO;
    }

    /**
     * saveAjhyjl的中文名称：保存 更新案件合议记录 saveAjhyjl的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by:ly
     */
    public String saveAjhyjl(HttpServletRequest request, Zfwsajhyjl18DTO dto) {
        String ajhyjlid = null;
        try {
            ajhyjlid = saveAjhyjlImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return ajhyjlid;
    }

    @Aop({"trans"})
    public String saveAjhyjlImpl(HttpServletRequest request, Zfwsajhyjl18DTO dto)
            throws Exception {
        if ("".equals(dto.getHysj())) {
            dto.setHysj(null);
        }
        if ((dto.getAjhyjlid() != null) && (!"".equals(dto.getAjhyjlid()))) {
            Zfwsajhyjl18 zfws = dao.fetch(Zfwsajhyjl18.class, dto.getAjhyjlid());
            zfws.setAjdjay(dto.getAjdjay()); // 案由
            zfws.setAjdjid(dto.getAjdjid()); // 案件登记id
            zfws.setHyaqjs(dto.getHyaqjs()); // 案情介绍
            zfws.setHydd(dto.getHydd()); // 合议地点
            zfws.setHydsr(dto.getHydsr()); // 当事人
            zfws.setHyjlr(dto.getHyjlr()); // 记录人
            zfws.setHyjlrqz(dto.getHyjlrqz()); // 记录人签字
            zfws.setHyry(dto.getHyry()); // 合议人员
            zfws.setHyryqz(dto.getHyryqz()); // 合议人员签字
            zfws.setHysj(dto.getHysj()); // 合议时间
            zfws.setHytljl(dto.getHytljl()); // 讨论记录
            zfws.setHywfxwdc(dto.getHywfxwdc()); // 违法行为等次
            zfws.setHyyj(dto.getHyyj()); // 合议意见
            zfws.setHyzcr(dto.getHyzcr()); // 合议主持人
            zfws.setHyzcrqz(dto.getHyzcrqz()); // 主持人签字
            zfws.setHyzjcl(dto.getHyzjcl()); // 证据材料
            zfws.setJytk(dto.getJytk()); // 条款
            dao.update(zfws);
            return dto.getAjhyjlid();
        } else {
            Zfwsajhyjl18 zf = new Zfwsajhyjl18();
            String id = DbUtils.getSequenceStr();// 产生消息id
            BeanHelper.copyProperties(dto, zf);
            zf.setAjhyjlid(id);
            dao.insert(zf);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + id
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return id;
        }
    }

    /*************************************************************************/

    /**
     * xzcfjabg的中文名称：行政处罚结案报告 xzcfjabg的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by:ly
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书40
    public Object xzcfjabg(HttpServletRequest request, Zfwsxzcfjabg40DTO dto)
            throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 行政处罚结案报告id
        String xzcfjabgid = request.getParameter("zfwsqtbid");
        if (xzcfjabgid != null && !"".equals(xzcfjabgid) && !"undefined".equals(xzcfjabgid)) {
            dto.setXzcfjabgid(xzcfjabgid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*, ");
        sb.append("(select getAa10_aaa103('JAGDDAGL',a.jagddagl)) as jagddaglstr, ");
        sb.append("(select getAa10_aaa103('AJDJAJLY',a.ajdjajly)) as ajdjajlystr, ");
        sb.append("(select getAa10_aaa103('JAFS',a.jagdjafs)) as jagdjafsstr ");
        sb.append(" from zfwsxzcfjabg40 a ");
        sb.append(" where 1=1  ");
        sb.append(" and ajdjid=:ajdjid ");
        sb.append(" and xzcfjabgid=:xzcfjabgid ");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "xzcfjabgid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfjabg40DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwsxzcfjabg40DTO v_dto = new Zfwsxzcfjabg40DTO();
        if (ls != null && ls.size() > 0) {
            v_dto = (Zfwsxzcfjabg40DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 案由，默认从案件登记表中取案由
                    v_dto.setAjdjay(v_zfajdj.getAjdjay());
                    // 案件来源，默认从案件登记表中取案件来源
                    v_dto.setAjdjajly(v_zfajdj.getAjdjajly());
                    // 处罚单位，默认从案件登记表中取企业名称
                    v_dto.setJabgbcfdwr(v_zfajdj.getCommc());
                    // 法定代表人，默认从案件登记表中取企业法人或业主
                    v_dto.setJabgfddbr(v_zfajdj.getComfrhyz());
                    // 立案日期，默认从案件登记表中立案时间
                    v_dto.setJabglarq(v_zfajdj.getLiansj());
                    // 处罚日期，默认从案件登记表中取处罚决定时间
                    v_dto.setJabgcfrq(v_zfajdj.getCfjdsj());
                    // 处罚文书号，默认从案件登记表中取案件登记编号
                    v_dto.setJabgcfwsh(v_zfajdj.getAjdjbh());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                if (v_pcom != null) {
                    // 处罚单位，默认从案件登记表中取企业名称
                    v_dto.setJabgbcfdwr(v_pcom.getCommc());
                    // 法定代表人，默认从案件登记表中取企业法人或业主
                    v_dto.setJabgfddbr(v_pcom.getComfrhyz());
                }
            }
        }
        return v_dto;
    }

    /**
     * saveXzcfjabg的中文名称：保存行政处罚结案报告 saveXzcfjabg的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by:ly
     */
    public String saveXzcfjabg(HttpServletRequest request, Zfwsxzcfjabg40DTO dto) {
        String xzcfjabgid = null;
        try {
            xzcfjabgid = saveXzcfjabgImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xzcfjabgid;
    }

    @Aop({"trans"})
    public String saveXzcfjabgImpl(HttpServletRequest request,
                                   Zfwsxzcfjabg40DTO dto) throws Exception {
        if ("".equals(dto.getJabgajcbrqzrq())) {
            dto.setJabgajcbrqzrq(null);
        }
        if ("".equals(dto.getJabgcbjgfzrqzrq())) {
            dto.setJabgcbjgfzrqzrq(null);
        }
        if ("".equals(dto.getJabgcfrq())) {
            dto.setJabgcfrq(null);
        }
        if ("".equals(dto.getJabgjarq())) {
            dto.setJabgjarq(null);
        }
        if ("".equals(dto.getJabglarq())) {
            dto.setJabglarq(null);
        }
        if ("".equals(dto.getJagdfgfzrqzrq())) {
            dto.setJagdfgfzrqzrq(null);
        }
        if ("".equals(dto.getJagdrq())) {
            dto.setJagdrq(null);
        }
        if (null != dto.getXzcfjabgid() && !"".equals(dto.getXzcfjabgid())) {
            Zfwsxzcfjabg40 zfws = dao.fetch(Zfwsxzcfjabg40.class, dto.getXzcfjabgid());
            zfws.setAjdjajly(dto.getAjdjajly()); // 案件来源
            zfws.setAjdjay(dto.getAjdjay()); // 案由
            zfws.setAjdjid(dto.getAjdjid()); // 案件登记id
            zfws.setJabgajcbrqz1(dto.getJabgajcbrqz1()); // 案件承办人签字1
            zfws.setJabgajcbrqz2(dto.getJabgajcbrqz2()); // 案件承办人签字2
            zfws.setJabgajcbrqzrq(dto.getJabgajcbrqzrq()); // 案件承办人签字日期
            zfws.setJabgaqjyqk(dto.getJabgaqjyqk()); // 案情简要情况
            zfws.setJabgbcfdwr(dto.getJabgbcfdwr()); // 被处罚单位
            zfws.setJabgcbjgfzrqz(dto.getJabgcbjgfzrqz()); // 承办机构负责人签字
            zfws.setJabgcbjgfzrqzrq(dto.getJabgcbjgfzrqzrq()); // 承办机构负责人签字日期
            zfws.setJabgcbjgshyj(dto.getJabgcbjgshyj()); // 承办机构审核意见
            zfws.setJabgcbr(dto.getJabgcbr()); // 承办人
            zfws.setJabgcfrq(dto.getJabgcfrq()); // 处罚日期
            zfws.setJabgcfwsh(dto.getJabgcfwsh()); // 处罚文书号
            zfws.setJabgcfzlhfd(dto.getJabgcfzlhfd()); // 处罚种类和幅度
            zfws.setJabgfddbr(dto.getJabgfddbr()); // 法定代表人
            zfws.setJabgjarq(dto.getJabgjarq()); // 结案日期
            zfws.setJabglarq(dto.getJabglarq()); // 立案日期
            zfws.setJabgtxr(dto.getJabgtxr()); // 填写人
            zfws.setJagdbcqx(dto.getJagdbcqx()); // 保存期限
            zfws.setJagddagl(dto.getJagddagl()); // 档案归类
            zfws.setJagdfgfzrqz(dto.getJagdfgfzrqz()); // 分管负责人签字
            zfws.setJagdfgfzrqzrq(dto.getJagdfgfzrqzrq()); // 分管负责人签字日期
            zfws.setJagdjafs(dto.getJagdjafs()); // 结案方式
            zfws.setJagdrq(dto.getJagdrq()); // 归档日期
            zfws.setJagdspyj(dto.getJagdspyj()); // 领到审批意见
            zfws.setJagdzxjg(dto.getJagdzxjg()); // 执行结果
            dao.update(zfws);
            return dto.getXzcfjabgid();
        } else {
            Zfwsxzcfjabg40 zf = new Zfwsxzcfjabg40();
            String id = DbUtils.getSequenceStr();
            BeanHelper.copyProperties(dto, zf);
            zf.setXzcfjabgid(id);
            dao.insert(zf);

            String sb = "update zfajzfws a set a.zfwsqtbid='" + id
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return id;
        }
    }

    /**
     * **** 物品清单(第37张文书)***********Created by CatchU on 3716/3/30. ************
     */

    //TODO 查询物品清单 文书37
    public Object queryZfwswpqdObj(HttpServletRequest request, Zfwswpqd37DTO dto)
            throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 物品清单id
        String wpqdid = request.getParameter("zfwsqtbid");
        if (wpqdid != null && !"".equals(wpqdid) && !"undefined".equals(wpqdid)) {

            dto.setWpqdid(wpqdid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*, ");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append("  from zfwswpqd37 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // id
        sb.append("   and a.wpqdid = :wpqdid "); // id
        sb.append("   and a.zfwsdmz = :zfwsdmz "); // 执法文书代码值
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "wpqdid", "zfwsdmz"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwswpqd37DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 物品清单
        Zfwswpqd37DTO v_zfwswpqd37DTO = new Zfwswpqd37DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwswpqd37DTO = (Zfwswpqd37DTO) ls.get(0);
        } else { // 默认数据
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdjDTO = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdjDTO != null) {
                    // 文书编号，默认从案件登记表中取案件登记编号
                    v_zfwswpqd37DTO.setWpqdwsbh(v_zfajdjDTO.getAjdjbh()); // 文书编号
                    // 当事人，默认从案件登记表中取公司名称
                    v_zfwswpqd37DTO.setWppddsr(v_zfajdjDTO.getCommc()); // 当事人(企业名称)
                    // 地址，默认从案件登记表中取公司地址
                    v_zfwswpqd37DTO.setWppddz(v_zfajdjDTO.getComdz()); // 地址
                }
            } else {
                Pcompany pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 当事人，默认从案件登记表中取公司名称
                v_zfwswpqd37DTO.setWppddsr(pcom.getCommc()); // 当事人(企业名称)
                // 地址，默认从案件登记表中取公司地址
                v_zfwswpqd37DTO.setWppddz(pcom.getComdz()); // 地址
            }

            // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
			/*Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
			v_zfwswpqd37DTO.setXzjgmc(v_aa01.getAaa005());*/
        }if("1".equals(dto.getPrint())){
            //手机端文书打印电子签名路径  wxy20180803
            v_zfwswpqd37DTO.setCheckedqm(request.getContextPath()+v_zfwswpqd37DTO.getCheckedqm());
            v_zfwswpqd37DTO.setApplyqm(request.getContextPath()+v_zfwswpqd37DTO.getApplyqm());
            v_zfwswpqd37DTO.setCheckqm(request.getContextPath()+v_zfwswpqd37DTO.getCheckqm());
            v_zfwswpqd37DTO.setWitnessqm(request.getAuthType() + v_zfwswpqd37DTO.getWitnessqm());
            v_zfwswpqd37DTO.setNoticeqm(request.getContextPath()+v_zfwswpqd37DTO.getNoticeqm());
            v_zfwswpqd37DTO.setRecordqm(request.getContextPath()+v_zfwswpqd37DTO.getRecordqm());
        }
        return v_zfwswpqd37DTO;
    }

    /**
     * saveZfwswpqd的中文名称：保存物品清单
     * <p/>
     * saveZfwswpqd的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwswpqd(HttpServletRequest request, Zfwswpqd37DTO dto) {
        String wpqdid = null;
        try {
            wpqdid = saveZfwswpqdImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return wpqdid;
    }

    /**
     * @param request
     * @param dto
     * @throws Exception
     * @Description: 保存物品清单实现方法
     * @author CatchU
     */
    @Aop({"trans"})
    public String saveZfwswpqdImp(HttpServletRequest request, Zfwswpqd37DTO dto)
            throws Exception {
        String v_wpqdid = "";
        if ("".equals(dto.getWpqddsrqzrq())) {
            dto.setWpqddsrqzrq(null);
        }
        if ("".equals(dto.getWpqdzfryqzrq())) {
            dto.setWpqdzfryqzrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getWpqdid()) && (!"".equals(dto.getWpqdid()))) {
            Zfwswpqd37 se = dao.fetch(Zfwswpqd37.class, dto.getWpqdid());
            v_wpqdid = dto.getWpqdid();
            se.setAjdjid(dto.getAjdjid()); // 案件登记id
            se.setWppddsr(dto.getWppddsr()); // 当事人
            se.setWppddz(dto.getWppddz()); // 地址
            se.setWpqddsrqz(dto.getWpqddsrqz()); // 当事人签字
            se.setWpqddsrqzrq(dto.getWpqddsrqzrq()); // 当事人签字日期
            se.setWpqdqtwp(dto.getWpqdqtwp()); // 其他物品
            se.setWpqdwsbh(dto.getWpqdwsbh()); // 文书编号
            se.setWpqdzfry1qz(dto.getWpqdzfry1qz()); // 执法人员签字
            se.setWpqdzfry2qz(dto.getWpqdzfry2qz()); // 执法人员2签字
            se.setWpqdzfryqzrq(dto.getWpqdzfryqzrq()); // 执法人员签字日期
            se.setZfwsdmz(dto.getZfwsdmz()); // 执法文书代码值
            se.setXzjgmc(dto.getXzjgmc()); // 行政机关名称
            dao.update(se);

            // 保存物品清单明细（思路：先删除重新插入）
            String v_sql = "delete from zfwswpqdmx37 where wpqdid='"
                    + dto.getWpqdid() + "'";
            Sql sql2 = Sqls.create(v_sql);
            dao.execute(sql2);
        } else {
            //判断案件文书对应关系表是否存在，不存在增加一条
            v_wpqdid = DbUtils.getSequenceStr();
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS37");
                    v_Zfajzfws.setZfwsqtbid(v_wpqdid);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
//				ZfajzfwsDTO v_ZfajzfwsDTO=new ZfajzfwsDTO();
//				v_ZfajzfwsDTO.setUserid(dto.getUserid());
//				v_ZfajzfwsDTO.setAjdjid(dto.getAjdjid());
//				v_ZfajzfwsDTO.setFjcsdmzlist("ZFAJZFWS37");
//				v_ZfajzfwsDTO.setZfwsqtbid(v_wpqdid);
//				dto.setZfwsdmz("ZFAJZFWS37");
//				saveZfwsadd(request,v_ZfajzfwsDTO);
            }

            // 物品清单
            Zfwswpqd37 v_zfwswpqd37 = new Zfwswpqd37();
            BeanHelper.copyProperties(dto, v_zfwswpqd37);
            v_zfwswpqd37.setWpqdid(v_wpqdid);
            dao.insert(v_zfwswpqd37);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '")
                    .append(v_wpqdid).append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
        }

        JSONArray v_array = null;
        Object[] v_objArray = null;
        // 物品明细情况
        v_array = JSONArray.fromObject(dto.getWpqdmx_table_rows());
        v_objArray = v_array.toArray();
        String v_wpqdmxid = "";
        for (int i = 0; i <= v_objArray.length - 1; i++) {
            JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
            Zfwswpqdmx37 v_Zfwswpqdmx37 = (Zfwswpqdmx37) JSONObject.toBean(
                    v_obj, Zfwswpqdmx37.class);
            // 获取物品明细id
            v_wpqdmxid = DbUtils.getSequenceStr();
            v_Zfwswpqdmx37.setWpqdmxid(v_wpqdmxid);
            v_Zfwswpqdmx37.setWpqdid(v_wpqdid);
            dao.insert(v_Zfwswpqdmx37);
        }
        return v_wpqdid;
    }

    /**
     * 查询物品清单明细
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryZfwswpqdmx(Zfwswpqd37DTO dto, PagesDTO pd) throws Exception {

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*");
        sb.append(" from zfwswpqdmx37 a,zfwswpqd37 b ");
        sb.append(" where a.wpqdid=b.wpqdid ");
        sb.append(" and b.wpqdid = :wpqdid ");
        sb.append("  and b.ajdjid = :ajdjid");
        sb.append("  and b.zfwsdmz = :zfwsdmz");

        String sql = sb.toString();
        String[] ParaName = new String[]{"wpqdid", "ajdjid", "zfwsdmz"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwswpqd37DTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /******* 没收物品凭证(第30张文书)***********Created by CatchU on 2016/3/26. *************/

    /**
     * queryZfwsmswppz:查询执法文书没收物品凭证
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书30
    public Object queryZfwsmswppzObj(HttpServletRequest request,
                                     Zfwsmswppz30DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 没收物品凭证id
        String mswppzid = request.getParameter("zfwsqtbid");
        if (mswppzid != null && !"".equals(mswppzid) && !"undefined".equals(mswppzid)) {
            dto.setMswppzid(mswppzid);
        }
        // 构建sql语句
        StringBuffer sb = new StringBuffer();
        sb.append("select a.*,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append(" from zfwsmswppz30 a");
        sb.append(" where 1=1");
        sb.append(" and a.ajdjid=:ajdjid");
        sb.append(" and a.mswppzid=:mswppzid");
        String sql = sb.toString();
        String[] paraName = new String[]{"ajdjid", "mswppzid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paraName, ParaType, dto);
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsmswppz30DTO.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        Zfwsmswppz30DTO zfwsmswppz30dto = new Zfwsmswppz30DTO();
        if (ls != null && ls.size() > 0) {
            zfwsmswppz30dto = (Zfwsmswppz30DTO) ls.get(0);
        } else { // 默认信息
            if ("ajdj".equals(v_operatetype)) {
                // 2.查询案件登记信息
                ZfajdjDTO zfajdjDTO = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                // 3.将查询出的案件登记信息 比如违规企业名称等设置到dto中
                if (zfajdjDTO != null) {
                    // 文书编号，默认从案件登记表中取案件登记编号
                    zfwsmswppz30dto.setMspzwsbh(zfajdjDTO.getAjdjbh());
                    // 案由，默认从案件登记表中取案由
                    zfwsmswppz30dto.setAjdjay(zfajdjDTO.getAjdjay());
                    // 当事人，默认从案件登记表中取企业名称
                    zfwsmswppz30dto.setMswpdsr(zfajdjDTO.getCommc());
                    // 地址，默认从案件登记表中取企业地址
                    zfwsmswppz30dto.setMswpdz(zfajdjDTO.getComdz());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                if (v_pcom != null) {
                    // 当事人，默认从案件登记表中取企业名称
                    zfwsmswppz30dto.setMswpdsr(v_pcom.getCommc());
                    // 地址，默认从案件登记表中取企业地址
                    zfwsmswppz30dto.setMswpdz(v_pcom.getComdz());
                }
            }
            // 强制执行人民法院，默认从aa01表中取强制执行法院
            Aa01 aa01 = SysmanageUtil.getAa01("QZZZRMFY");
            zfwsmswppz30dto.setQzzzrmfy(aa01.getAaa005());

            // 查询行政处罚决定书的文书编号cfjdwsbh
            List list = queryZfwsxzcfjds28(dto.getAjdjid());
            if (list != null && list.size() > 0) {
                Zfwsxzcfjds28 zfwsxzcfjds28 = (Zfwsxzcfjds28) list.get(0);
                // 处罚决定文书编号，默认从处罚决定文书中取文书编号
                zfwsmswppz30dto.setCfjdwsbh(zfwsxzcfjds28.getCfjdwsbh());
            }
            // 附件，默认取没收物品清单文书
            Zfwswpqd37 wpqd = queryZfwswpqd(dto.getAjdjid(), "ZFAJZFWS3705");
            if (wpqd != null) {
                zfwsmswppz30dto.setMswpfj(wpqd.getWpqdwsbh() + "《没收物品清单》");
            }
            // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
            Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
            zfwsmswppz30dto.setXzjgmc(v_aa01.getAaa005());
        }
        return zfwsmswppz30dto;
    }

    /**
     * 根据案件id查询行政处罚决定书表（第28号表），获取处罚号等处罚信息
     */
    @SuppressWarnings("rawtypes")
    public List queryZfwsxzcfjds28(String ajdjid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append("select a.*");
        sb.append(" from zfwsxzcfjds28 a");
        sb.append(" where 1=1");
        sb.append("   and a.ajdjid='").append(ajdjid).append("'");
        String sql = sb.toString();
        String[] paraName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, paraName, ParaType, null);
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfjds28.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        if (ls != null && ls.size() > 0) {
            return ls;
        } else {
            return null;
        }
    }

    /**
     * 保存执法文书没收物品凭证
     *
     * @param request
     * @param dto
     * @return
     */
    public String saveZfwsmswppz(HttpServletRequest request, Zfwsmswppz30DTO dto) {
        String mswppzid = null;
        try {
            mswppzid = saveZfwsmswppzImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return mswppzid;
    }

    /**
     * 保存的实现方法
     *
     * @param request
     * @param dto
     * @throws Exception
     */
    @Aop({"trans"})
    public String saveZfwsmswppzImp(HttpServletRequest request,
                                    Zfwsmswppz30DTO dto) throws Exception {
        if ("".equals(dto.getMspzgzrq())) {
            dto.setMspzgzrq(null);
        }
        if (null != dto.getMswppzid() && !"".equals(dto.getMswppzid())) {
            Zfwsmswppz30 zfwsmswspz = dao.fetch(Zfwsmswppz30.class, dto.getMswppzid());
            BeanHelper.copyProperties(dto, zfwsmswspz);
            dao.update(zfwsmswspz);
            return dto.getMswppzid();
        } else {
            String mswppzid = DbUtils.getSequenceStr();
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS30");
                    v_Zfajzfws.setZfwsqtbid(mswppzid);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
            }
            Zfwsmswppz30 zfws = new Zfwsmswppz30();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setMswppzid(mswppzid);
            dao.insert(zfws);
            // 更新zfajzfws表，设置为已经填写文书和 更新执法文书所在表ID
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + mswppzid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return mswppzid;
        }

    }

    /******* 责令改正通知书(第20张文书)***********Created by CatchU on 2016/3/20. *************/

    /**
     * 功能：查询执法文书责令改正通知书列表
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    //TODO 文书20
    public Object queryZfwszlgztzsObj(HttpServletRequest request,
                                      Zfwszlgztzs20DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 责令改正通知书id
        String zlgztzsid = request.getParameter("zfwsqtbid");
        if (zlgztzsid != null && !"".equals(zlgztzsid) && !"undefined".equals(zlgztzsid)) {
            dto.setZlgztzsid(zlgztzsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select *,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append(" from  zfwszlgztzs20 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.zlgztzsid = :zlgztzsid");
//		if(request.getParameter("zfwsqtbid")!=null&&!"".equals(request.getParameter("zfwsqtbid"))){
//		sb.append("  and a.zlgztzsid ='").append(request.getParameter("zfwsqtbid")).append("'");
//		}
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "zlgztzsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwszlgztzs20DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        // 查询责令改正通知书信息
        Zfwszlgztzs20DTO zfwszlgztzs20DTO = new Zfwszlgztzs20DTO();
        if (ls != null && ls.size() > 0) {
            zfwszlgztzs20DTO = (Zfwszlgztzs20DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息回显到前端页面
                ZfajdjDTO zfajdjDTO = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (zfajdjDTO != null) {
                    // 文书编号，默认从案件等级表中去案件登记编号
                    zfwszlgztzs20DTO.setZlgzwsbh(zfajdjDTO.getAjdjbh());
                    // 当事人，默认从案件等级表中取企业名称
                    zfwszlgztzs20DTO.setZlgzdsr(zfajdjDTO.getCommc());
                }
            } else {
                Pcompany pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 文书编号，默认从案件等级表中去案件登记编号
                //zfwszlgztzs20DTO.setZlgzwsbh(zfajdjDTO.getAjdjbh());
                // 当事人，默认从案件等级表中取企业名称
                zfwszlgztzs20DTO.setZlgzdsr(pcom.getCommc());
            }

        }
        if("1".equals(dto.getPrint())){
            //手机端文书打印电子签名路径  wxy20180803
            zfwszlgztzs20DTO.setCheckedqm(request.getContextPath()+zfwszlgztzs20DTO.getCheckedqm());
            zfwszlgztzs20DTO.setApplyqm(request.getContextPath()+zfwszlgztzs20DTO.getApplyqm());
            zfwszlgztzs20DTO.setCheckqm(request.getContextPath()+zfwszlgztzs20DTO.getCheckqm());
            zfwszlgztzs20DTO.setWitnessqm(request.getAuthType() + zfwszlgztzs20DTO.getWitnessqm());
            zfwszlgztzs20DTO.setNoticeqm(request.getContextPath()+zfwszlgztzs20DTO.getNoticeqm());
            zfwszlgztzs20DTO.setRecordqm(request.getContextPath()+zfwszlgztzs20DTO.getRecordqm());
        }
        return zfwszlgztzs20DTO;
    }

    /**
     * 功能：查询执法文书副页
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */

    public Object queryZfwsfyObj(HttpServletRequest request,
                                 Zfwsspypxzcfwsfy36DTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from  Zfwsspypxzcfwsfy36 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.spypxzcfwsfyid = :spypxzcfwsfyid");

        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "spypxzcfwsfyid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsspypxzcfwsfy36DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        // 查询责令改正通知书信息
        Zfwsspypxzcfwsfy36DTO v_zfwsspypxzcfwsfy36DTO = new Zfwsspypxzcfwsfy36DTO();
        if (ls != null && ls.size() > 0) {
            v_zfwsspypxzcfwsfy36DTO = (Zfwsspypxzcfwsfy36DTO) ls.get(0);
        };
        return v_zfwsspypxzcfwsfy36DTO;
    }
    /**
     * saveZfwszlgztzs：保存责令改正通知书文书信息
     *
     * @param request
     * @param dto
     * @return
     */
    public String saveZfwszlgztzs(HttpServletRequest request,
                                  Zfwszlgztzs20DTO dto) {
        String zlgztzsid = null;
        try {
            zlgztzsid = saveZfwszlgztzsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return zlgztzsid;
    }

    /**
     * 保存的实现方法
     *
     * @param request
     * @param dto
     * @throws Exception
     */
    @Aop({"trans"})
    public String saveZfwszlgztzsImp(HttpServletRequest request,
                                     Zfwszlgztzs20DTO dto) throws Exception {
        if ("".equals(dto.getZlgzgzrq())) {
            dto.setZlgzgzrq(null);
        }
        if ("".equals(dto.getZlgzdsrqzrq())) {
            dto.setZlgzdsrqzrq(null);
        }
        if ("".equals(dto.getZlgzwfxwjzrq())) {
            dto.setZlgzwfxwjzrq(null);
        }
        if (null != dto.getZlgztzsid() && !"".equals(dto.getZlgztzsid())) {
            Zfwszlgztzs20 zfwszlgztzs = dao.fetch(Zfwszlgztzs20.class, dto
                    .getZlgztzsid());
            zfwszlgztzs.setAjdjid(dto.getAjdjid()); // 案件等级id
            zfwszlgztzs.setZlgzcfgj(dto.getZlgzcfgj()); // 处罚依据
            zfwszlgztzs.setZlgzcfgjk(dto.getZlgzcfgjk()); // 处罚根据款
            zfwszlgztzs.setZlgzcfgjt(dto.getZlgzcfgjt()); // 处罚根据条
            zfwszlgztzs.setZlgzcfgjx(dto.getZlgzcfgjx()); // 处罚根据项
            zfwszlgztzs.setZlgzdsr(dto.getZlgzdsr()); // 当事人
            zfwszlgztzs.setZlgzgznr(dto.getZlgzgznr()); // 改正内容
            zfwszlgztzs.setZlgzgzrq(dto.getZlgzgzrq()); // 盖章日期
            zfwszlgztzs.setZlgzwfgd(dto.getZlgzwfgd()); // 违反规定
            zfwszlgztzs.setZlgzwfxw(dto.getZlgzwfxw()); // 违反行为
            zfwszlgztzs.setZlgzwsbh(dto.getZlgzwsbh()); // 文书编号
            zfwszlgztzs.setZlgzdsrqz(dto.getZlgzdsrqz());//当事人签字
            zfwszlgztzs.setZlgzdsrqzrq(dto.getZlgzdsrqzrq());//当事人签字日期
            zfwszlgztzs.setZlgzwfxwjzrq(dto.getZlgzwfxwjzrq());//当事人签字日期
            dao.update(zfwszlgztzs);
            return dto.getZlgztzsid();
        } else {
            String zlgztzsid = DbUtils.getSequenceStr();
            //判断案件文书对应关系表是否存在，不存在增加一条
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS20");
                    v_Zfajzfws.setZfwsqtbid(zlgztzsid);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
//				ZfajzfwsDTO v_ZfajzfwsDTO=new ZfajzfwsDTO();
//				v_ZfajzfwsDTO.setUserid(dto.getUserid());
//				v_ZfajzfwsDTO.setAjdjid(dto.getAjdjid());
//				v_ZfajzfwsDTO.setFjcsdmzlist("ZFAJZFWS20");
//				v_ZfajzfwsDTO.setZfwsqtbid(zlgztzsid);
//				dto.setZfwsdmz("ZFAJZFWS20");
//				saveZfwsadd(request,v_ZfajzfwsDTO);
            }


            Zfwszlgztzs20 zfws = new Zfwszlgztzs20();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setZlgztzsid(zlgztzsid);
            dao.insert(zfws);

            // 更新zfajzfws表，设置为已经填写文书和 更新执法文书所在表ID
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + zlgztzsid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return zlgztzsid;
        }

    }

    /**
     * delZfws : 删除责令整改通知书
     *
     * @param request
     * @param dto
     * @return
     */
    public String delZfws2(HttpServletRequest request, ZfajzfwsDTO dto) {
        try {
            if (null != dto.getAjzfwsid()) {
                delZfwsImp(request, dto);
            } else {
                return "没有接收到要删除的案件执法文书ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void delZfws2Imp(HttpServletRequest request, ZfajzfwsDTO dto) {
        // 删除案件登记
        dao.clear(Zfajzfws.class, Cnd.where("ajzfwsid", "=", dto
                .getAjzfwsid()));
    }

    /**
     * queryZfwxwdcblObj的中文名称：查询询问调查表信息 queryZfwxwdcbllist的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     *                   update by : zy
     */
    @SuppressWarnings("rawtypes")
    //TODO 文书7
    public Object queryZfwxwdcblObj(HttpServletRequest request,
                                    Zfwsxwdcbl7DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }

        String xwdcblid = request.getParameter("zfwsqtbid");
        if (xwdcblid != null && !"".equals(xwdcblid) && !"undefined".equals(xwdcblid)) {
            dto.setXwdcblid(xwdcblid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,(select getAa10_aaa103('AAC005',a.dcblmz)) as dcblmzstr ");
        sb.append(" ,(select getAa10_aaa103('DCBLJDJCLB',a.dcbljdjclb)) as dcbljdjclbstr ");
        sb.append(" ,(select getAa10_aaa103('YBAGX',a.dcblbxwzrrybagx)) as dcblbxwzrrybagxstr ");
        sb.append(" ,(select getAa10_aaa103('RYXB',a.dcblbxwrxb)) as dcblbxwrxbstr ");
        sb.append(" ,(select getAa10_aaa103('RYXB',a.dcblbxwzrrxb)) as dcblbxwzrrxbstr,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append(" from zfwsxwdcbl7 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.xwdcblid = :xwdcblid");
        sb.append("  and a.ajdjid = :ajdjid");
        String sql = sb.toString();
        String[] ParaName = new String[]{"xwdcblid", "ajdjid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxwdcbl7DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        // 询问调查笔录
        Zfwsxwdcbl7DTO v_Zfwsxwdcbl7dto = new Zfwsxwdcbl7DTO();
        if (ls != null && ls.size() > 0) {
            v_Zfwsxwdcbl7dto = (Zfwsxwdcbl7DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 案由，从案件登记表中取
                    v_Zfwsxwdcbl7dto.setAjdjay(v_zfajdj.getAjdjay()); // 案由
                    // 被询问单位法定代表人，从案件登记表中取
                    v_Zfwsxwdcbl7dto.setDcblbxwdwfddbr(v_zfajdj.getComfrhyz()); // 企业法人或业主
                    // 被询问单位，从案件登记表中取
                    v_Zfwsxwdcbl7dto.setDcblbxwdwmc(v_zfajdj.getCommc()); // 企业名称
                    // 被询问单位电话，从案件登记表中取
                    v_Zfwsxwdcbl7dto.setDcblbxwdwdh(v_zfajdj.getComyddh()); // 联系电话
                    // 调查地点，从案件登记表中取
                    v_Zfwsxwdcbl7dto.setDcbldcdd(v_zfajdj.getComdz()); // 调查地点,公司地址
                    // 获取执法案件承办人信息
                    List<?> cbrs = queryZfajcbr(dto.getAjdjid());
                    if (cbrs != null && cbrs.size() > 0) {
                        // 调查人1姓名
                        v_Zfwsxwdcbl7dto.setDcbldcr1(((Zfajcbr) cbrs.get(0)).getZfryxm());
                        // 调查人1证件号码
                        v_Zfwsxwdcbl7dto.setDcbldcr1zjbh(((Zfajcbr) cbrs.get(0)).getZfryzjhm());
                        // 执法人员1姓名
                        v_Zfwsxwdcbl7dto.setDcblzfry1(((Zfajcbr) cbrs.get(0)).getZfryxm());
                        // 执法人员1证件号码
                        v_Zfwsxwdcbl7dto.setDcbldcr1zjbh(((Zfajcbr) cbrs.get(0)).getZfryzjhm());
                        if (cbrs.size() > 1) {
                            // 当调查人2为空时，默认选择为执法人员2
                            v_Zfwsxwdcbl7dto.setDcbldcr2(((Zfajcbr) cbrs.get(1)).getZfryxm());
                            // 调查人1姓名
                            v_Zfwsxwdcbl7dto.setDcblzfry2(((Zfajcbr) cbrs.get(1)).getZfryxm());
                            // 执法人员2证件号码
                            v_Zfwsxwdcbl7dto.setDcbldcr2zjbh(((Zfajcbr) cbrs.get(1)).getZfryzjhm());
                        }
                    }
                }
            } else {
                v_Zfwsxwdcbl7dto.setDcbldcjl(queryAjdjBhgx(dto.getAjdjid()));//获取检查不合格项
                Pcompany pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 被询问单位法定代表人，从案件登记表中取
                v_Zfwsxwdcbl7dto.setDcblbxwdwfddbr(pcom.getComfrhyz()); // 企业法人或业主
                // 被询问单位，从案件登记表中取
                v_Zfwsxwdcbl7dto.setDcblbxwdwmc(pcom.getCommc()); // 企业名称
                // 被询问单位电话，从案件登记表中取
                v_Zfwsxwdcbl7dto.setDcblbxwdwdh(pcom.getComyddh()); // 联系电话
                // 调查地点，从案件登记表中取
                v_Zfwsxwdcbl7dto.setDcbldcdd(pcom.getComdz()); // 调查地点,公司地址
            }


            // 执法证件名称，从aa01表中查
            Aa01 v_aa01 = SysmanageUtil.getAa01("ZFZJMC");
            v_Zfwsxwdcbl7dto.setZfzjmc(v_aa01.getAaa005()); // 执法证件名称
            // 食品药品监督管理局名称全称(分地区)，从aa01表中查
            Aa01 v_aa011 = SysmanageUtil.getAa01("SPYPJDGLJMCQC");
            v_Zfwsxwdcbl7dto.setSpypjdgljmcqc(v_aa011.getAaa005()); // 食品药品监督管理局名称全称(分地区)
        }
        if("1".equals(dto.getPrint())){
            //手机端文书打印电子签名路径  wxy20180803
            v_Zfwsxwdcbl7dto.setCheckedqm(request.getContextPath()+v_Zfwsxwdcbl7dto.getCheckedqm());
            v_Zfwsxwdcbl7dto.setApplyqm(request.getContextPath()+v_Zfwsxwdcbl7dto.getApplyqm());
            v_Zfwsxwdcbl7dto.setCheckqm(request.getContextPath()+v_Zfwsxwdcbl7dto.getCheckqm());
            v_Zfwsxwdcbl7dto.setWitnessqm(request.getAuthType() + v_Zfwsxwdcbl7dto.getWitnessqm());
            v_Zfwsxwdcbl7dto.setNoticeqm(request.getContextPath()+v_Zfwsxwdcbl7dto.getNoticeqm());
            v_Zfwsxwdcbl7dto.setRecordqm(request.getContextPath()+v_Zfwsxwdcbl7dto.getRecordqm());
        }
        return v_Zfwsxwdcbl7dto;
    }

    /**
     * queryZfwxfylist的中文名称：查询附页信息 queryZfwxfylist的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书36
    public Object queryZfwxfylist(HttpServletRequest request,
                                  Zfwsspypxzcfwsfy36DTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select * from ");
        sb.append("  zfwsspypxzcfwsfy36 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.zybid = :zybid");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid","zybid"};
        int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsspypxzcfwsfy36.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        if (ls != null && ls.size() > 0) {
            Zfwsspypxzcfwsfy36 v_Zfwsspypxzcfwsfy36 = (Zfwsspypxzcfwsfy36) ls.get(0);
            BeanHelper.copyProperties(v_Zfwsspypxzcfwsfy36, dto);
        }
        return dto;
    }

    /**
     * queryZfcbrlist的中文名称：根据id查询承办人信息 queryZfcbrlist的概要描述：
     *
     * @param ajdjid
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("rawtypes")
    public String[] queryZfcbrlist(String ajdjid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT z.zfryxm FROM zfajcbr z ");
        sb.append("  where 1=1 ");
        sb.append("  and z.ajdjid = '").append(ajdjid).append("'");
        String sql = sb.toString();
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zfajcbr.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        // List list = new ArrayList();
        final int size = ls.size();
        String[] arr = new String[size];
        Zfajcbr v_Zfajcbr = new Zfajcbr();
        for (int i = 0; i < size; i++) {
            v_Zfajcbr = (Zfajcbr) ls.get(i);
            arr[i] = v_Zfajcbr.getZfryxm();
        }
        return arr;
    }

    /**
     * saveZfwsfy的中文名称：保存执法文书附页信息 saveZfwsfy的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */

    public String saveZfwsfy(HttpServletRequest request,
                             Zfwsspypxzcfwsfy36DTO dto) {
        try {
            saveZfwsfyImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveZfwsfyImp的中文名称：查询或者更新执法文书附页信息 saveZfwsfyImp的概要描述：
     *
     * @param request
     * @param dto
     * @throws Exception written by ： lfy
     */
    @Aop({"trans"})
    public void saveZfwsfyImp(HttpServletRequest request,
                              Zfwsspypxzcfwsfy36DTO dto) throws Exception {
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        if (sysuser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
            sysuser = dao.fetch(Sysuser.class, dto.getUserid());
        }
        if ("".equals(dto.getFybdcrqzrq())) {
            dto.setFybdcrqzrq(null);
        }
        if ("".equals(dto.getFyzfryqzrq())) {
            dto.setFyzfryqzrq(null);
        }
        if ("" != dto.getSpypxzcfwsfyid() && null != dto.getSpypxzcfwsfyid()) {
            Zfwsspypxzcfwsfy36 Zfws = dao.fetch(Zfwsspypxzcfwsfy36.class, dto
                    .getSpypxzcfwsfyid());
            Zfws.setAjdjid(dto.getAjdjid());
            BeanHelper.copyProperties(dto, Zfws);
            dao.update(Zfws);
        } else {
            String fyid = DbUtils.getSequenceStr();
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getZybid() != null) {
                    //dao.fetch(Hjyjcmxb.class,Cnd.where("hjyjczbid","=",hjyjczbid).and("jcxmmc","=",jcxm.getJcxmmc()));
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, Cnd.where("ajdjid", "=", dto.getAjdjid()).and("zfwsqtbid", "=", dto.getZybid()));
                    v_Zfajzfws.setFytzbz("1");
                    dao.update(v_Zfajzfws);
                }
            }
            String zybid = dto.getZybid();
            Zfwsspypxzcfwsfy36 fy = new Zfwsspypxzcfwsfy36();
            BeanHelper.copyProperties(dto, fy);
            fy.setAae011(sysuser.getDescription());
            fy.setAae036(SysmanageUtil.currentTime().toString());
            fy.setSpypxzcfwsfyid(fyid);
            dao.insert(fy);

            // 更新文书标志
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + fyid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);

        }
    }

    /**
     * saveZfwsxwdcbl的中文名称：保存询问登记表信息 saveZfwsxwdcbl的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */

    public String saveZfwsxwdcbl(HttpServletRequest request, Zfwsxwdcbl7DTO dto) {
        String xwdcblid = null;
        try {
            xwdcblid = saveZfwsxwdcblImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xwdcblid;
    }

    /**
     * saveZfwsxwdcblImp的中文名称：保存或者更新询问登记表信息 saveZfwsxwdcblImp的概要描述：
     *
     * @param request
     * @param dto
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("unused")
    @Aop({"trans"})
    public String saveZfwsxwdcblImp(HttpServletRequest request, Zfwsxwdcbl7DTO dto)
            throws Exception {
        // 调查结束时间
        if ("".equals(dto.getDcbldcjssj())) {
            dto.setDcbldcjssj(null);
        }
        // 调查开始时间
        if ("".equals(dto.getDcbldckssj())) {
            dto.setDcbldckssj(null);
        }
        // 记录人签字日期
        if ("".equals(dto.getDcbljlrqzrq())) {
            dto.setDcbljlrqzrq(null);
        }
        // 调查人签字日期
        if ("".equals(dto.getDcbldcrqzrq())) {
            dto.setDcbldcrqzrq(null);
        }
        // 被调查人签字日期
        if ("".equals(dto.getDcblbdcrqzrq())) {
            dto.setDcblbdcrqzrq(null);
        }
        if ("" != dto.getXwdcblid() && null != dto.getXwdcblid()) {
            Zfwsxwdcbl7 zfws = dao.fetch(Zfwsxwdcbl7.class, dto.getXwdcblid());
            zfws.setAjdjid(dto.getAjdjid());  // 案件登记id
            zfws.setAjdjay(dto.getAjdjay()); // 案由
            zfws.setDcblbdcr(dto.getDcblbdcr()); // 被调查人（被询问人姓名）
            zfws.setDcblbdcrqz(dto.getDcblbdcrqz()); // 被调查人（被询问人姓名）签字
            zfws.setDcblbdcrqzrq(dto.getDcblbdcrqzrq()); // 被调查人（被询问人姓名）签字日期
            zfws.setDcblbxwdwdh(dto.getDcblbxwdwdh()); // 被询问单位电话
            zfws.setDcblbxwdwfddbr(dto.getDcblbxwdwfddbr()); // 被询问单位法定代表人
            zfws.setDcblbxwdwmc(dto.getDcblbxwdwmc()); // 被询问单位名称
            zfws.setDcblbxwrnl(dto.getDcblbxwrnl());
//			zfws.setDcblbxwrnl(("".equals(dto.getDcblbxwrnl())||dto.getDcblbxwrnl()==null)?
//					null:Integer.parseInt(dto.getDcblbxwrnl())); // 被询问人年龄
            zfws.setDcblbxwrxb(dto.getDcblbxwrxb()); // 被询问人性别
            zfws.setDcblbxwzrrdh(dto.getDcblbxwzrrdh()); // 被询问自然人电话
            zfws.setDcblbxwzrrszdw(dto.getDcblbxwzrrszdw()); // 被询问自然人所在单位
            zfws.setDcblbxwzrrxb(dto.getDcblbxwzrrxb()); // 被询问自然人性别
            zfws.setDcblbxwzrrxm(dto.getDcblbxwzrrxm()); // 被询问自然人姓名
            zfws.setDcblbxwzrrybagx(dto.getDcblbxwzrrybagx()); // 被询问自然人与本案关系
            zfws.setDcblbxwzrrzz(dto.getDcblbxwzrrzz()); // 被询问自然人住址
            zfws.setDcbldcdd(dto.getDcbldcdd()); // 调查地点
            zfws.setDcbldcjl(dto.getDcbldcjl()); // 调查记录
            zfws.setDcbldcjssj(dto.getDcbldcjssj()); // 调查结束时间
            zfws.setDcbldckssj(dto.getDcbldckssj()); // 调查开始时间
            zfws.setDcbldcr1(dto.getDcbldcr1()); // 调查人1
            zfws.setDcbldcr2(dto.getDcbldcr2()); // 调查人2
            zfws.setDcbldcr1zjbh(dto.getDcbldcr1zjbh()); // 执法人员1证件编号
            zfws.setDcbldcr2zjbh(dto.getDcbldcr2zjbh()); // 执法人员2证件编号
            zfws.setDcbldcrqz1(dto.getDcbldcrqz1()); // 调查人1签字
            zfws.setDcbldcrqz2(dto.getDcbldcrqz2()); // 调查人2签字
            zfws.setDcbldcrqzrq(dto.getDcbldcrqzrq()); // 调查人签字日期
            zfws.setDcbldz(dto.getDcbldz()); // 被调查人地址
            zfws.setDcblgzdw(dto.getDcblgzdw()); // 被调查人工作单位
            zfws.setDcbljdjclb(dto.getDcbljdjclb()); // 监督检查类别
            zfws.setDcbljlr(dto.getDcbljlr()); // 记录人
            zfws.setDcbllxfs(dto.getDcbllxfs()); // 被调查人联系方式
            zfws.setDcblmz(dto.getDcblmz()); // 被调查人民族
            zfws.setDcblsfkqc(dto.getDcblsfkqc()); // 是否看清楚
            zfws.setDcblsfmbbnzwz(dto.getDcblsfmbbnzwz()); // 是否明白不能做为证
            zfws.setDcblsfsqdcryhb(dto.getDcblsfsqdcryhb()); // 是否申请调查人员回避
            zfws.setDcblsfzh(dto.getDcblsfzh()); // 被调查人身份证号
            zfws.setDcblygwt(dto.getDcblygwt()); // 有关问题
            zfws.setDcblzfry1(dto.getDcblzfry1()); // 执法人员1
            zfws.setDcblzfry2(dto.getDcblzfry2()); // 执法人员2
            zfws.setDcblzw(dto.getDcblzw()); // 被调查人职务
            zfws.setSpypjdgljmcqc(dto.getSpypjdgljmcqc()); // 食药监名称全称
            zfws.setZfzjmc(dto.getZfzjmc()); // 执法证件名称
            zfws.setDcblbdcryb(dto.getDcblbdcryb()); //被调查人邮编
            zfws.setDcbljlrqz(dto.getDcbljlrqz()); //记录人签字
            zfws.setDcbljlrqzrq(dto.getDcbljlrqzrq()); //记录人签字日期
            dao.update(zfws);
            return dto.getXwdcblid();
        } else {
            //判断案件文书对应关系表是否存在，不存在增加一条
            String xwdcid = DbUtils.getSequenceStr();

            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS07");
                    v_Zfajzfws.setZfwsqtbid(xwdcid);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
//				ZfajzfwsDTO v_ZfajzfwsDTO=new ZfajzfwsDTO();
//				v_ZfajzfwsDTO.setUserid(dto.getUserid());
//				v_ZfajzfwsDTO.setAjdjid(dto.getAjdjid());
//				v_ZfajzfwsDTO.setFjcsdmzlist("ZFAJZFWS07");
//				v_ZfajzfwsDTO.setZfwsqtbid(xwdcid);
//				dto.setZfwsdmz("ZFAJZFWS07");
//				saveZfwsadd(request,v_ZfajzfwsDTO);
            }

            Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

            Zfwsxwdcbl7 zfws = new Zfwsxwdcbl7();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setXwdcblid(xwdcid);
            dao.insert(zfws);
            // 更新文书标志
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + xwdcid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and a.ajzfwsid='" + dto.getAjzfwsid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "' and zfwsqtbid is null";

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return xwdcid;
        }
    }

    /**
     * queryZfajcbr的中文名称：查询执法案件承办人信息
     * <p/>
     * queryZfajcbr的概要说明：
     *
     * @param prm_ajdjid
     * @return
     * @throws Exception Written by : zy
     */
    public List<?> queryZfajcbr(String prm_ajdjid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.ajcbrid,a.ajdjid,a.userid,a.zfrysflx,a.zfryzjhm,a.zfrybmmc,a.zfryzw, s.description as zfryxm ");
        sb.append("  from zfajcbr a ,sysuser s  ");
        sb.append(" where 1 = 1 ");
        sb.append("  and a.userid=s.USERID ");
        sb.append("   and a.ajdjid='").append(prm_ajdjid).append("'");

        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfajcbr.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        if (ls != null && ls.size() > 0) {
            return ls;
        } else {
            return null;
        }
    }

    /**
     * queryZfwsxzcfjdspblist的中文名称：查询行政处罚决定审批表信息 queryZfwsxzcfjdspblist的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings({"rawtypes"})
    //TODO  文书27
    public Object queryZfwsxzcfjdspblist(HttpServletRequest request,
                                         Zfwsxzcfjdspb27DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 行政处罚决定审批表id
        String xzcfjdspbid = request.getParameter("zfwsqtbid");
        if (xzcfjdspbid != null && !"".equals(xzcfjdspbid) && !"undefined".equals(xzcfjdspbid)) {
            dto.setXzcfjdspbid(xzcfjdspbid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select * from ");
        sb.append("  zfwsxzcfjdspb27 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.xzcfjdspbid = :xzcfjdspbid");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "xzcfjdspbid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfjdspb27DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwsxzcfjdspb27DTO s27dto = new Zfwsxzcfjdspb27DTO();
        if (ls != null && ls.size() > 0) {
            s27dto = (Zfwsxzcfjdspb27DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    s27dto.setAjdjay(v_zfajdj.getAjdjay()); // 案由
                    s27dto.setCfspdsr(v_zfajdj.getCommc()); // 当事人
                    s27dto.setAjdjid(v_zfajdj.getAjdjid());// 案件登记ID
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                s27dto.setCfspdsr(v_pcom.getCommc()); // 当事人
            }
        }
        return s27dto;
    }

    /**
     * saveZfwsxzcfjdspb的中文名称：保存行政处罚决定审批表信息 saveZfwsxzcfjdspb的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */
    public String saveZfwsxzcfjdspb(HttpServletRequest request,
                                    Zfwsxzcfjdspb27DTO dto) {
        String xzcfjdspbid = null;
        try {
            xzcfjdspbid = saveZfwsxzcfjdspbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xzcfjdspbid;
    }

    /**
     * saveZfwsxzcfjdspbImp的中文名称：保存或者更新行政处罚决定审批表信息 saveZfwsxzcfjdspbImp的概要描述：
     *
     * @param request
     * @param dto
     * @throws Exception written by ： lfy
     */
    @Aop({"trans"})
    public String saveZfwsxzcfjdspbImp(HttpServletRequest request,
                                       Zfwsxzcfjdspb27DTO dto) throws Exception {
        if ("".equals(dto.getCfspcbfzrqzrq())) {
            dto.setCfspcbfzrqzrq(null);
        }
        if ("".equals(dto.getCfspcbrqzrq())) {
            dto.setCfspcbrqzrq(null);
        }
        if ("".equals(dto.getCfspshbmfzrrq())) {
            dto.setCfspshbmfzrrq(null);
        }
        if ("".equals(dto.getCfspspyjfzrrq())) {
            dto.setCfspspyjfzrrq(null);
        }
        if (null != dto.getXzcfjdspbid() && "" != dto.getXzcfjdspbid()) {
            Zfwsxzcfjdspb27 zfwsxzcfjdspb = dao.fetch(Zfwsxzcfjdspb27.class,
                    dto.getXzcfjdspbid());
            zfwsxzcfjdspb.setAjdjid(dto.getAjdjid()); // 案件登记id
            zfwsxzcfjdspb.setAjdjay(dto.getAjdjay()); // 案由
            zfwsxzcfjdspb.setCbbmscyj(dto.getCbbmscyj()); // 承办部门审查意见
            zfwsxzcfjdspb.setCfspcbbmfzr(dto.getCfspcbbmfzr()); // 承办部门负责人
            zfwsxzcfjdspb.setCfspcbfzrqzrq(dto.getCfspcbfzrqzrq()); // 承办部门负责人签字日期
            zfwsxzcfjdspb.setCfspcbrqz(dto.getCfspcbrqz()); // 承办人签字1
            zfwsxzcfjdspb.setCfspcbrqz2(dto.getCfspcbrqz2()); // 承办人签字2
            zfwsxzcfjdspb.setCfspcbrqzrq(dto.getCfspcbrqzrq()); // 承办人签章日期
            zfwsxzcfjdspb.setCfspcfjd(dto.getCfspcfjd()); // 处罚决定
            zfwsxzcfjdspb.setCfspdsr(dto.getCfspdsr()); // 当事人
            zfwsxzcfjdspb.setCfspfj(dto.getCfspfj()); // 附件
            zfwsxzcfjdspb.setCfspshbmfzr(dto.getCfspshbmfzr()); // 审核部门负责人
            zfwsxzcfjdspb.setCfspshbmfzrrq(dto.getCfspshbmfzrrq()); // 审核部门负责人签字日期
            zfwsxzcfjdspb.setCfspshbmyj(dto.getCfspshbmyj()); // 审核部门意见
            zfwsxzcfjdspb.setCfspspyj(dto.getCfspspyj()); // 审批意见
            zfwsxzcfjdspb.setCfspspyjfzr(dto.getCfspspyjfzr()); // 审批意见负责人
            zfwsxzcfjdspb.setCfspspyjfzrrq(dto.getCfspspyjfzrrq()); // 审批意见负责人签字日期
            zfwsxzcfjdspb.setCfspwfss(dto.getCfspwfss()); // 主要违法事实
            zfwsxzcfjdspb.setCssbjtzqk(dto.getCssbjtzqk()); // 陈述申辩情况
            zfwsxzcfjdspb.setDsrcssbqk(dto.getDsrcssbqk()); // 当事人陈述申辩或听证意见复核及采纳情况

            dao.update(zfwsxzcfjdspb);
            return dto.getXzcfjdspbid();
        } else {
            String xzcfid = DbUtils.getSequenceStr();
            Zfwsxzcfjdspb27 zfws = new Zfwsxzcfjdspb27();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setXzcfjdspbid(xzcfid);
            dao.insert(zfws);

            // 更新文书标志
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + xzcfid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return xzcfid;
        }

    }

    /**
     * queryZfwstztzslist的中文名称：查询听证通知书信息 queryZfwstztzslist的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书23
    public Object queryZfwstztzslist(HttpServletRequest request,
                                     Zfwstztzs23DTO dto) throws Exception {

        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 听证通知书id
        String tztzsid = request.getParameter("zfwsqtbid");
        if (tztzsid != null && !"".equals(tztzsid) && !"undefined".equals(tztzsid)) {
            dto.setTztzsid(tztzsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select * from ");
        sb.append("  zfwstztzs23 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.tztzsid = :tztzsid");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "tztzsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zfwstztzs23DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwstztzs23DTO tztzs = new Zfwstztzs23DTO();
        if (ls != null && ls.size() > 0) {
            tztzs = (Zfwstztzs23DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 文书编号，默认从案件登记表中取案件登记编号
                    tztzs.setTztzwsbh(v_zfajdj.getAjdjbh());
                    // 当事人，默认从案件登记表中取企业名称
                    tztzs.setTztzdsr(v_zfajdj.getCommc());
                    // 案由，默认从案件登记表中取案由
                    tztzs.setTztzsay(v_zfajdj.getAjdjay());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 当事人，默认从案件登记表中取企业名称
                tztzs.setTztzdsr(v_pcom.getCommc());
            }
            // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
            Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
            tztzs.setXzjgmc(v_aa01.getAaa005());
        }
        return tztzs;
    }

    /**
     * saveZfwstztzs的中文名称：保存听证通知书信息 saveZfwstztzs的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */

    public String saveZfwstztzs(HttpServletRequest request, Zfwstztzs23DTO dto) {
        String tztzsid = null;
        try {
            tztzsid = saveZfwstztzsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return tztzsid;
    }

    /**
     * saveZfwstztzsImp的中文名称：保存或者更新听证通知书信息 saveZfwstztzsImp的概要描述：
     *
     * @param request
     * @param dto
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("unused")
    @Aop({"trans"})
    public String saveZfwstztzsImp(HttpServletRequest request, Zfwstztzs23DTO dto)
            throws Exception {
        if ("".equals(dto.getTztzgzrq())) {
            dto.setTztzgzrq(null);
        }
        if ("".equals(dto.getTztzjxrq())) {
            dto.setTztzjxrq(null);
        }
        if ("".equals(dto.getTztzsqrq())) {
            dto.setTztzsqrq(null);
        }
        if ("".equals(dto.getTztzsyqrq())) {
            dto.setTztzsyqrq(null);
        }
        if ("".equals(dto.getTztzstzsqrrq())) {
            dto.setTztzstzsqrrq(null);
        }
        if (null != dto.getTztzsid() && "" != dto.getTztzsid()) {
            Zfwstztzs23 s23 = dao.fetch(Zfwstztzs23.class, dto.getTztzsid());
            s23.setAjdjid(dto.getAjdjid()); // 案件登记id
            s23.setTztzdd(dto.getTztzdd()); // 举行听证地点
            s23.setTztzdsr(dto.getTztzdsr()); // 当事人
            s23.setTztzdz(dto.getTztzdz()); // 地址
            s23.setTztzgzrq(dto.getTztzgzrq()); // 盖章日期
            s23.setTztzjly(dto.getTztzjly()); // 记录员
            s23.setTztzjxrq(dto.getTztzjxrq()); // 举行听证日期
            s23.setTztzlxdh(dto.getTztzlxdh()); // 联系电话
            s23.setTztzlxr(dto.getTztzlxr()); // 联系人
            s23.setTztzsay(dto.getTztzsay()); // 案由
            s23.setTztzsqrq(dto.getTztzsqrq()); // 听证申请日期
            s23.setTztzstzsqr(dto.getTztzstzsqr()); // 听证申请人
            s23.setTztzstzsqrrq(dto.getTztzstzsqrrq()); // 听证申请人签字或盖章日期
            s23.setTztzsyqrq(dto.getTztzsyqrq()); // 申请听证延期日期
            s23.setTztzwsbh(dto.getTztzwsbh()); // 文书编号
            s23.setTztzyzbm(dto.getTztzyzbm()); // 邮政编码
            s23.setTztzzcr(dto.getTztzzcr()); // 听证主持人
            s23.setXzjgmc(dto.getXzjgmc()); // 行政机关名称
            dao.update(s23);
            return s23.getTztzsid();
        } else {
            Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
            String tztzsid = DbUtils.getSequenceStr();
            Zfwstztzs23 zfws = new Zfwstztzs23();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setTztzsid(tztzsid);
            dao.insert(zfws);

            // 更新文书标志
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + tztzsid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return tztzsid;
        }
    }

    /**
     * queryZfwslaspblist的中文名称：查询立案审批表信息 queryZfwslaspblist的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     */

    @SuppressWarnings({"rawtypes", "unused"})
    //TODO  文书2
    public Object queryZfwslaspblist(HttpServletRequest request,
                                     Zfwslaspb2DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        String laspid = request.getParameter("zfwsqtbid");
        if (laspid != null && !"".equals(laspid) && !"undefined".equals(laspid)) {
            dto.setLaspid(laspid);
        }
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,(select getAa10_aaa103('AJDJAJLY',a.ajdjajly)) as ajdjajlystr from ");
        sb.append("  zfwslaspb2 a ");
        sb.append("  where 1=1 ");
        if(!"".equals(dto.getAjdjid())){
            sb.append("  and a.ajdjid = :ajdjid");
        }
        sb.append("  and a.laspid = :laspid");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid","laspid"};
        int[] ParaType = new int[]{Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zfwslaspb2DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Zfwslaspb2DTO v_Zfwslaspb2 = new Zfwslaspb2DTO();
        if (ls != null && ls.size() > 0) {
            v_Zfwslaspb2 = (Zfwslaspb2DTO) ls.get(0);
            //dto.setAjdjid(v_zfajdj.getAjdjid());// 案件登记ID
            BeanHelper.copyProperties(v_Zfwslaspb2, dto);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj1(dto.getAjdjid()).get(0);
                String[] cbrs = (String[]) this.queryZfcbrlist(v_zfajdj.getAjdjid());
                String laspajcbr = PubFunc.unsplit(cbrs, "、");
                dto.setLaspzbr(cbrs.length < 1 ? "" : cbrs[0]);
                dto.setLaspcbr(cbrs.length < 2 ? "" : cbrs[1]);
                //dto.setLaspajcbr(laspajcbr);
                dto.setLaspjyzb(cbrs.length < 1 ? "" : cbrs[0]);
                dto.setLaspjyxb(cbrs.length < 2 ? "" : cbrs[1]);
                dto.setLaspspzb(cbrs.length < 1 ? "" : cbrs[0]);
                dto.setLaspspxb(cbrs.length < 2 ? "" : cbrs[1]);
                dto.setLaspsplarq(SysmanageUtil.getDbtimeYmd());

                dto.setAjdjid(v_zfajdj.getAjdjid());// 案件登记ID
                dto.setAjdjay(v_zfajdj.getAjdjay());// 案由
                dto.setAjdjajly(v_zfajdj.getAjdjajly());// 案件来源
                dto.setAjdjajlystr(v_zfajdj.getAjdjajlystr());// 打印页面需要的案件来源信息
                dto.setLaspdsr(v_zfajdj.getCommc());// 当事人
                dto.setLaspdz(v_zfajdj.getComdz());// 地址
                dto.setLaspfddbr(v_zfajdj.getComfrhyz());// '法定代表人（负责人）/自然人,
                dto.setLasplxfs(v_zfajdj.getComyddh());// 联系电话,
                dto.setLaspwsbh(v_zfajdj.getAjdjbh());//案件登记编号
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                String[] cbrs = (String[]) this.queryZfcbrlist(v_pcom.getComid());
                String laspajcbr = PubFunc.unsplit(cbrs, "、");
                dto.setLaspzbr(cbrs.length < 1 ? "" : cbrs[0]);
                dto.setLaspcbr(cbrs.length < 2 ? "" : cbrs[1]);
                //dto.setLaspajcbr(laspajcbr);
                dto.setLaspjyzb(cbrs.length < 1 ? "" : cbrs[0]);
                dto.setLaspjyxb(cbrs.length < 2 ? "" : cbrs[1]);
                dto.setLaspspzb(cbrs.length < 1 ? "" : cbrs[0]);
                dto.setLaspspxb(cbrs.length < 2 ? "" : cbrs[1]);
                dto.setLaspsplarq(SysmanageUtil.getDbtimeYmd());

//				dto.setAjdjid(v_pcom.getAjdjid());// 案件登记ID
//				dto.setAjdjay(v_pcom.getAjdjay());// 案由
//				dto.setAjdjajly(v_pcom.getAjdjajly());// 案件来源
//				dto.setAjdjajlystr(v_pcom.getAjdjajlystr());// 打印页面需要的案件来源信息
                dto.setLaspdsr(v_pcom.getCommc());// 当事人
                dto.setLaspdz(v_pcom.getComdz());// 地址
                dto.setLaspfddbr(v_pcom.getComfrhyz());// '法定代表人（负责人）/自然人,
                dto.setLasplxfs(v_pcom.getComyddh());// 联系电话,
//				dto.setLaspwsbh(v_pcom.getAjdjbh());//案件登记编号
            }

        }

        return dto;
    }

    /**
     * saveZfwslaspb的中文名称：保存立案审批表信息 saveZfwslaspb的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */
    public String saveZfwslaspb(HttpServletRequest request, Zfwslaspb2DTO dto) {
        String laspid = null;
        try {
            laspid = saveZfwslaspbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return laspid;
    }

    /**
     * saveZfwslaspbImp的中文名称：保存或者更新立案审批表信息 saveZfwslaspbImp的概要描述：
     *
     * @param request
     * @param dto
     * @throws Exception written by ： lfy
     */
    @Aop({"trans"})
    public String saveZfwslaspbImp(HttpServletRequest request, Zfwslaspb2DTO dto)
            throws Exception {
        if ("".equals(dto.getLaspjbrqzrq())) {
            dto.setLaspjbrqzrq(null);
        }
        if ("".equals(dto.getLaspfgfzrqzrq())) {
            dto.setLaspfgfzrqzrq(null);
        }
        if ("".equals(dto.getLaspcbbmfzrqzrq())) {
            dto.setLaspcbbmfzrqzrq(null);
        }
        if ("".equals(dto.getLaspsplarq())) {
            dto.setLaspsplarq(null);
        }
        if (null != dto.getLaspid() && "" != dto.getLaspid()) {
            Zfwslaspb2 zfwslaspb = dao.fetch(Zfwslaspb2.class, dto.getLaspid());
            zfwslaspb.setAjdjid(dto.getAjdjid());
            BeanHelper.copyProperties(dto, zfwslaspb);
            dao.update(zfwslaspb);
            return dto.getLaspid();
        } else {
            String laspid = DbUtils.getSequenceStr();
            Zfwslaspb2 zfws = new Zfwslaspb2();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setLaspid(laspid);
            dao.insert(zfws);

            // 更新文书标志
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + laspid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";

            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return laspid;
        }

    }

    /**
     * queryZfwscfkyyqtzslist的中文名称：查询延期信息 queryZfwscfkyyqtzslist的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("rawtypes")
    //TODO 文书15
    public Object queryZfwscfkyyqtzslist(HttpServletRequest request,
                                         Zfwscfkyyqtzs15DTO dto) throws Exception {

        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 查封扣押延期通知书id
        String cfkyyqtzsid = request.getParameter("zfwsqtbid");
        if (cfkyyqtzsid != null && !"".equals(cfkyyqtzsid) && !"undefined".equals(cfkyyqtzsid)) {
            dto.setCfkyyqtzsid(cfkyyqtzsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select * from ");
        sb.append("   zfwscfkyyqtzs15 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.cfkyyqtzsid = :cfkyyqtzsid");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "cfkyyqtzsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwscfkyyqtzs15DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwscfkyyqtzs15DTO tzs = new Zfwscfkyyqtzs15DTO();
        if (ls != null && ls.size() > 0) {
            tzs = (Zfwscfkyyqtzs15DTO) ls.get(0);
        } else {

            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 文书编号，默认从案件登记标志取案件登记编号
                    tzs.setCfyqwsbh(v_zfajdj.getAjdjbh());
                    // 当事人，默认从案件登记标志取企业名称
                    tzs.setCfyqdsr(v_zfajdj.getCommc());
                    // 法定代表人，默认从案件登记标志取企业法人或业主
                    tzs.setCfyqfddbr(v_zfajdj.getComfrhyz());
                    // 地址，默认从案件登记标志取企业地址
                    tzs.setCfyqdz(v_zfajdj.getComdz());
                    // 联系方式，默认从案件登记标志取联系方式
                    tzs.setCfyqlxfs(v_zfajdj.getComyddh());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                if (v_pcom != null) {
                    // 当事人，默认从案件登记标志取企业名称
                    tzs.setCfyqdsr(v_pcom.getCommc());
                    // 法定代表人，默认从案件登记标志取企业法人或业主
                    tzs.setCfyqfddbr(v_pcom.getComfrhyz());
                    // 地址，默认从案件登记标志取企业地址
                    tzs.setCfyqdz(v_pcom.getComdz());
                    // 联系方式，默认从案件登记标志取联系方式
                    tzs.setCfyqlxfs(v_pcom.getComyddh());
                }
            }
            // 上一级食药局，默认从aa01表中取上一级食药局
            Aa01 v_syj = SysmanageUtil.getAa01("SJSPYPJDGLJ");
            tzs.setCfyqsyjsjy(v_syj.getAaa005());
            // 上一级人民政府，默认从aa01表中取上一级人民政府
            Aa01 v_rmzf = SysmanageUtil.getAa01("SJRMZF");
            tzs.setCfyqrmzf(v_rmzf.getAaa005());
            // 上一级人民法院，默认从aa01表中取上一级人民法院
            Aa01 v_rmfy = SysmanageUtil.getAa01("SJRMFY");
            tzs.setCfyqrmfy(v_rmfy.getAaa005());
            // 查询查封扣押决定书
            Zfwscfkyjds12DTO z12 = new Zfwscfkyjds12DTO();
            z12.setAjdjid(dto.getAjdjid());
//			z12.setOperatetype("mobilecheck");
            z12 = (Zfwscfkyjds12DTO) queryZfwscfkyjdslist(request, z12);
            if (z12 != null) {
                // 查封扣押决定书编号，默认取查封扣押绝对书中文书编号
                tzs.setCfyqcfkyjdsbh(z12.getCfkywsbh());
            }
        }
        return tzs;
    }

    /**
     * saveZfwscfkyyqtzs的中文名称：保存延期文书信息 saveZfwscfkyyqtzs的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */
    public String saveZfwscfkyyqtzs(HttpServletRequest request,
                                    Zfwscfkyyqtzs15DTO dto) {
        String cfkyyqtzsid = null;
        try {
            cfkyyqtzsid = saveZfwscfkyyqtzsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return cfkyyqtzsid;
    }

    /**
     * saveZfwscfkyyqtzsImp的中文名称：保存或者更新延期通知书信息 saveZfwscfkyyqtzsImp的概要描述：
     *
     * @param request
     * @param dto
     * @throws Exception written by ： lfy
     */
    @Aop({"trans"})
    public String saveZfwscfkyyqtzsImp(HttpServletRequest request,
                                       Zfwscfkyyqtzs15DTO dto) throws Exception {
        // 过滤空日期字符串
        if ("".equals(dto.getCfyqgzrq())) {
            dto.setCfyqgzrq(null);
        }
        if ("".equals(dto.getCfyqjsrq())) {
            dto.setCfyqjsrq(null);
        }
        if ("".equals(dto.getCfyqksrq())) {
            dto.setCfyqksrq(null);
        }
        if ("".equals(dto.getCfyqdsrqzrq())) {
            dto.setCfyqdsrqzrq(null);
        }
        if (null != dto.getCfkyyqtzsid() && "" != dto.getCfkyyqtzsid()) {
            Zfwscfkyyqtzs15 Zfwscfkyyqtzs = dao.fetch(Zfwscfkyyqtzs15.class,
                    dto.getCfkyyqtzsid());
            Zfwscfkyyqtzs.setAjdjid(dto.getAjdjid()); // 案件登记id
            Zfwscfkyyqtzs.setCfyqcfkyjdsbh(dto.getCfyqcfkyjdsbh()); // 查封扣押决定书编号
            Zfwscfkyyqtzs.setCfyqdsr(dto.getCfyqdsr()); // 当事人
            Zfwscfkyyqtzs.setCfyqdz(dto.getCfyqdz()); // 地址
            Zfwscfkyyqtzs.setCfyqfddbr(dto.getCfyqfddbr()); // 法定代表人
            Zfwscfkyyqtzs.setCfyqgzrq(dto.getCfyqgzrq()); // 盖章日期
            Zfwscfkyyqtzs.setCfyqjsrq(dto.getCfyqjsrq()); // 结束日期
            Zfwscfkyyqtzs.setCfyqksrq(dto.getCfyqksrq()); // 开始日期
            Zfwscfkyyqtzs.setCfyqlxfs(dto.getCfyqlxfs()); // 联系方式
            Zfwscfkyyqtzs.setCfyqrmfy(dto.getCfyqrmfy()); // 人民法院
            Zfwscfkyyqtzs.setCfyqrmzf(dto.getCfyqrmzf()); // 人民政府
            Zfwscfkyyqtzs.setCfyqsyjsjy(dto.getCfyqsyjsjy()); // 上一级食药局
            Zfwscfkyyqtzs.setCfyqwsbh(dto.getCfyqwsbh()); // 文书编号
            Zfwscfkyyqtzs.setCfyqyy(dto.getCfyqyy()); // 原因
            Zfwscfkyyqtzs.setCfyqdsrqz(dto.getCfyqdsrqz()); // 当事人签字
            Zfwscfkyyqtzs.setCfyqdsrqzrq(dto.getCfyqdsrqzrq()); // 当事人签字日期
            Zfwscfkyyqtzs.setCfyqqx(dto.getCfyqqx()); // 查封延期期限
            dao.update(Zfwscfkyyqtzs);
            return dto.getCfkyyqtzsid();
        } else {
            String yqid = DbUtils.getSequenceStr();
            Zfwscfkyyqtzs15 zfws = new Zfwscfkyyqtzs15();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setCfkyyqtzsid(yqid);
            dao.insert(zfws);
            // 更新文书标志
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + yqid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return yqid;
        }
    }

    /**
     * queryZfwscfkyjdslist的中文名称：查询查封（扣押）决定书表的信息 queryZfwscfkyjdslist的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书12
    public Object queryZfwscfkyjdslist(HttpServletRequest request,
                                       Zfwscfkyjds12DTO dto) throws Exception {

        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }

        // 查封扣押决定书id
        String cfkyjdsid = request.getParameter("zfwsqtbid");
        if (cfkyjdsid != null && !"".equals(cfkyjdsid) && !"undefined".equals(cfkyjdsid)) {
            dto.setCfkyjdsid(cfkyjdsid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select *,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append(" from  zfwscfkyjds12 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.cfkyjdsid = :cfkyjdsid");
//		if(request.getParameter("zfwsqtbid")!=null&&!"".equals(request.getParameter("zfwsqtbid"))){
//			sb.append("  and a.cfkyjdsid = '").append(request.getParameter("zfwsqtbid")).append("'");
//			}
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "cfkyjdsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwscfkyjds12DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwscfkyjds12DTO v_cfkyjds = new Zfwscfkyjds12DTO();
        if (ls != null && ls.size() > 0) {
            v_cfkyjds = (Zfwscfkyjds12DTO) ls.get(0);
            v_cfkyjds.setAjdjid(dto.getAjdjid());// 案件登记ID
        } else {//只有第一次才走这一步
            if ("ajdj".equals(v_operatetype)) {
                List<ZfajdjDTO> list = queryZfajdj(dto.getAjdjid());
                ZfajdjDTO v_zfajdj = null;
                if (list != null) {
                    v_zfajdj = (ZfajdjDTO) list.get(0);
                }
                if (v_zfajdj != null) {
                    // 文书编号，默认从案件登记表中去案件登记编号
                    v_cfkyjds.setCfkywsbh(v_zfajdj.getAjdjbh());
                    // 当事人，默认从案件登记表中取公司名称
                    v_cfkyjds.setCfkydsr(v_zfajdj.getCommc());
                    // 法定代表人，默认从案件登记表中去企业法人
                    v_cfkyjds.setCfkyfddbr(v_zfajdj.getComfrhyz());
                    // 地址，默认从案件登记表中取企业地址
                    v_cfkyjds.setCfkydz(v_zfajdj.getComdz());
                    // 联系方式，默认从案件登记表中取联系方式
                    v_cfkyjds.setCfkylxfs(v_zfajdj.getComyddh());
                }
            } else {
                Pcompany pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 文书编号，默认从案件登记表中去案件登记编号
                //v_cfkyjds.setCfkywsbh(pcom.getAjdjbh());
                // 当事人，默认从案件登记表中取公司名称
                v_cfkyjds.setCfkydsr(pcom.getCommc());
                // 法定代表人，默认从案件登记表中去企业法人
                v_cfkyjds.setCfkyfddbr(pcom.getComfrhyz());
                // 地址，默认从案件登记表中取企业地址
                v_cfkyjds.setCfkydz(pcom.getComdz());
                // 联系方式，默认从案件登记表中取联系方式
                v_cfkyjds.setCfkylxfs(pcom.getComyddh());
            }

            // 依法向食药局名称，默认从aa01表中取上级食品药品监督管理局名称
            Aa01 v_syj = SysmanageUtil.getAa01Fdq("SJSPYPJDGLJ");
            v_cfkyjds.setCfkyyfxsyj(v_syj.getAaa005());
            // 依法向人民政府，默认从aa01表中取上级人民政府
            Aa01 v_rmzf = SysmanageUtil.getAa01Fdq("SJRMZF");
            v_cfkyjds.setCfkyyfxrmzf(v_rmzf.getAaa005());
            // 依法向上级人民法院，默认从aa01表中取上级人民法院
            Aa01 v_rmfy = SysmanageUtil.getAa01Fdq("SJRMFY");
            v_cfkyjds.setCfkyyfxrmfy(v_rmfy.getAaa005());
        }
        return v_cfkyjds;
    }

    /**
     * saveZfwscfkyjds的中文名称：保存查封（扣押）决定书信息 saveZfwscfkyjds的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */

    public String saveZfwscfkyjds(HttpServletRequest request,
                                  Zfwscfkyjds12DTO dto) {
        String cfkyjdsid = null;
        try {
            cfkyjdsid = saveZfwscfkyjdsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return cfkyjdsid;
    }

    /**
     * saveZfwscfkyjdsImp的中文名称：保存查封（扣押）处罚决定信息 saveZfwscfkyjdsImp的概要描述：
     *
     * @param request
     * @param dto
     * @throws Exception written by ： lfy
     */
    @Aop({"trans"})
    public String saveZfwscfkyjdsImp(HttpServletRequest request,
                                     Zfwscfkyjds12DTO dto) throws Exception {
        if ("".equals(dto.getCfkygzrq())) { // 盖章日期
            dto.setCfkygzrq(null);
        }
        if ("".equals(dto.getCfkyjsrq())) { // 查封扣押结束日期
            dto.setCfkyjsrq(null);
        }
        if ("".equals(dto.getCfkyksrq())) { // 查封扣押开始日期
            dto.setCfkyksrq(null);
        }
        if (null != dto.getCfkyjdsid() && "" != dto.getCfkyjdsid()) {
            Zfwscfkyjds12 zfwscfkyjds = dao.fetch(Zfwscfkyjds12.class, dto.getCfkyjdsid());
            zfwscfkyjds.setCfkybcdd(dto.getCfkybcdd()); // 保存地点
            zfwscfkyjds.setAjdjid(dto.getAjdjid()); // 案件登记id
            zfwscfkyjds.setCfkybctj(dto.getCfkybctj()); // 保存条件
            zfwscfkyjds.setCfkydsr(dto.getCfkydsr()); // 当事人
            zfwscfkyjds.setCfkydz(dto.getCfkydz()); // 地址
            zfwscfkyjds.setCfkyfddbr(dto.getCfkyfddbr()); // 法定代表人
            zfwscfkyjds.setCfkyflk(dto.getCfkyflk()); // 款
            zfwscfkyjds.setCfkyflmc(dto.getCfkyflmc()); // 查封扣押物品法律名称
            zfwscfkyjds.setCfkyflt(dto.getCfkyflt()); // 条
            zfwscfkyjds.setCfkyflx(dto.getCfkyflx()); // 项
            zfwscfkyjds.setCfkygzrq(dto.getCfkygzrq()); // 盖章日期
            zfwscfkyjds.setCfkyjsrq(dto.getCfkyjsrq()); // 查封扣押结束日期
            zfwscfkyjds.setCfkyksrq(dto.getCfkyksrq()); // 查封扣押开始日期
            zfwscfkyjds.setCfkylxfs(dto.getCfkylxfs()); // 联系方式
            zfwscfkyjds.setCfkyndwhr(dto.getCfkyndwhr()); // 你单位（人）
            zfwscfkyjds.setCfkysxczwt(dto.getCfkysxczwt()); // 涉嫌存在问题
            zfwscfkyjds.setCfkywpqdwsbh(dto.getCfkywpqdwsbh()); // 查封扣押物品清单文书编号
            zfwscfkyjds.setCfkywsbh(dto.getCfkywsbh()); // 文书编号
            zfwscfkyjds.setCfkyyfxrmfy(dto.getCfkyyfxrmfy()); // 依法向人民法院
            zfwscfkyjds.setCfkyyfxrmzf(dto.getCfkyyfxrmzf()); // 依法向人民政府
            zfwscfkyjds.setCfkyyfxsyj(dto.getCfkyyfxsyj()); // 依法向食药局
            dao.update(zfwscfkyjds);
            return dto.getCfkyjdsid();
        } else {
            String cfkyid = DbUtils.getSequenceStr();
            //判断案件文书对应关系表是否存在，不存在增加一条
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS12");
                    v_Zfajzfws.setZfwsqtbid(cfkyid);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
//				ZfajzfwsDTO v_ZfajzfwsDTO=new ZfajzfwsDTO();
//				v_ZfajzfwsDTO.setUserid(dto.getUserid());
//				v_ZfajzfwsDTO.setAjdjid(dto.getAjdjid());
//				v_ZfajzfwsDTO.setFjcsdmzlist("ZFAJZFWS12");
//				v_ZfajzfwsDTO.setZfwsqtbid(cfkyid);
//				dto.setZfwsdmz("ZFAJZFWS12");
//				saveZfwsadd(request,v_ZfajzfwsDTO);
            }

            Zfwscfkyjds12 zfws = new Zfwscfkyjds12();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setCfkyjdsid(cfkyid);
            dao.insert(zfws);

            // 更新文书标志
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + cfkyid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return cfkyid;
        }
    }

    /**
     * queryZfwsajjttljllist的中文名称：查询案件集体讨论记录 queryZfwsajjttljllist的概要描述：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书19
    public Object queryZfwsajjttljlObj(HttpServletRequest request,
                                       Zfwsajjttljl19DTO dto) throws Exception {

        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 案件集体讨论记录id
        String ajjttljlid = request.getParameter("zfwsqtbid");
        if (ajjttljlid != null && !"".equals(ajjttljlid) && !"undefined".equals(ajjttljlid)) {
            dto.setAjjttljlid(ajjttljlid);
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select * from ");
        sb.append("  zfwsajjttljl19 a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.ajjttljlid = :ajjttljlid");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "ajjttljlid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsajjttljl19DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Zfwsajjttljl19DTO v_zfwsajjttljl19DTO = new Zfwsajjttljl19DTO();

        if (ls != null && ls.size() > 0) {
            v_zfwsajjttljl19DTO = (Zfwsajjttljl19DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    // 案由，默认从案件登记表中取案由
                    v_zfwsajjttljl19DTO.setAjdjay(v_zfajdj.getAjdjay());
                    // 当事人，默认从案件登记表中取企业名称
                    v_zfwsajjttljl19DTO.setJttldsr(v_zfajdj.getCommc());
                    // 违法事实，默认从案件登记表中取违法事实
                    v_zfwsajjttljl19DTO.setJttlzywfss(v_zfajdj.getAjdjwfss());
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                // 当事人，默认从案件登记表中取企业名称
                v_zfwsajjttljl19DTO.setJttldsr(v_pcom.getCommc());
            }
        }


        return v_zfwsajjttljl19DTO;
    }

    /**
     * saveZfwsajjttljl的中文名称：保存案件集体讨论记录信息 saveZfwsajjttljl的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */
    public String saveZfwsajjttljl(HttpServletRequest request,
                                   Zfwsajjttljl19DTO dto) {
        String ajjttljlid = null;
        try {
            ajjttljlid = saveZfwsajjttljlImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return ajjttljlid;
    }

    /**
     * saveZfwsajjttljlImp的中文名称：保存或者更新案件集体讨论记录信息 saveZfwsajjttljlImp的概要描述：
     *
     * @param request
     * @param dto
     * @throws Exception written by ： lfy
     */
    @Aop({"trans"})
    public String saveZfwsajjttljlImp(HttpServletRequest request,
                                      Zfwsajjttljl19DTO dto) throws Exception {
        if ("".equals(dto.getJttlsj())) {
            dto.setJttlsj(null);
        }
        if ("".equals(dto.getJttljssj())) {
            dto.setJttljssj(null);
        }
        if (null != dto.getAjjttljlid() && "" != dto.getAjjttljlid()) {
            Zfwsajjttljl19 zfwsajjttljl19 = dao.fetch(Zfwsajjttljl19.class, dto
                    .getAjjttljlid());
            zfwsajjttljl19.setAjdjid(dto.getAjdjid()); // 案件登记id
            zfwsajjttljl19.setAjdjay(dto.getAjdjay()); // 案由
            zfwsajjttljl19.setJttlcjr(dto.getJttlcjr()); // 参加人
            zfwsajjttljl19.setJttlcjryqz(dto.getJttlcjryqz()); // 参加人员签字
            zfwsajjttljl19.setJttldd(dto.getJttldd()); // 地点
            zfwsajjttljl19.setJttldsr(dto.getJttldsr()); // 当事人
            zfwsajjttljl19.setJttlhbr(dto.getJttlhbr()); // 汇报人
            zfwsajjttljl19.setJttljdyj(dto.getJttljdyj()); // 决定意见
            zfwsajjttljl19.setJttljl(dto.getJttljl()); // 讨论记录
            zfwsajjttljl19.setJttljlr(dto.getJttljlr()); // 记录人
            zfwsajjttljl19.setJttljlrzw(dto.getJttljlrzw()); // 记录人
            zfwsajjttljl19.setJttljlrqz(dto.getJttljlrqz()); // 记录人签字
            zfwsajjttljl19.setJttlsj(dto.getJttlsj()); // 讨论时间
            zfwsajjttljl19.setJttljssj(dto.getJttljssj()); // 讨论结束时间
            zfwsajjttljl19.setJttlzcr(dto.getJttlzcr()); // 主持人
            zfwsajjttljl19.setJttlzcrzw(dto.getJttlzcrzw()); // 主持人职务
            zfwsajjttljl19.setJttlzcrqz(dto.getJttlzcrqz()); // 主持人签字
            zfwsajjttljl19.setJttlzywfss(dto.getJttlzywfss()); // 主要违法事实
            dao.update(zfwsajjttljl19);
            return dto.getAjjttljlid();
        } else {
            String tljlid = DbUtils.getSequenceStr();
            Zfwsajjttljl19 zfws = new Zfwsajjttljl19();
            BeanHelper.copyProperties(dto, zfws);
            zfws.setAjjttljlid(tljlid);
            dao.insert(zfws);

            // 更新文书标志
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + tljlid
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return tljlid;
        }
    }

    @SuppressWarnings("rawtypes")
    //TODO 文书44
    public Object queryZfwsxwdctzsObj(HttpServletRequest request,
                                      ZfwsxwdctzsDTO dto) throws Exception {
//		String v_operatetype="ajdj";
//		if (StringUtils.isNotEmpty(dto.getOperatetype())&&"mobilecheck".equals(dto.getOperatetype())){
//			v_operatetype=dto.getOperatetype();
//		}
        String xwdctzsid = request.getParameter("zfwsqtbid");
        if (xwdctzsid != null && !"".equals(xwdctzsid) && !"undefined".equals(xwdctzsid)) {
            dto.setXwdctzsid(xwdctzsid);
        }

        StringBuffer sb = new StringBuffer();
        sb.append(" select *,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC06' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS applyqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC02' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkedqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC01' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS checkqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC03' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS witnessqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC04' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS recordqm,");
        sb.append("(SELECT max(case when a.FJCSDMZ='RCJCQZPIC05' then a.fjpath else '' end) " +
                "FROM fj a WHERE a.fjwid = '"+dto.getAjzfwsid() + "') AS noticeqm ");
        sb.append(" from zfwsxwdctzs a ");
        sb.append("  where 1=1 ");
        sb.append("  and a.ajdjid = :ajdjid");
        sb.append("  and a.xwdctzsid = :xwdctzsid");
// 		if(request.getParameter("zfwsqtbid")!=null&&!"".equals(request.getParameter("zfwsqtbid"))){
// 		sb.append("  and a.xwdctzsid = '").append(request.getParameter("zfwsqtbid")).append("'");
// 		}
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "xwdctzsid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ZfwsxwdctzsDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        ZfwsxwdctzsDTO v_ZfwsxwdctzsDTO = new ZfwsxwdctzsDTO();

        if (ls != null && ls.size() > 0) {
            v_ZfwsxwdctzsDTO = (ZfwsxwdctzsDTO) ls.get(0);
        } else {
            v_ZfwsxwdctzsDTO.setXwdcsbh("（&times;&times;）食药监&times;解查扣〔年份〕&times;号");

        }if("1".equals(dto.getPrint())){
            //手机端文书打印电子签名路径  wxy20180803
            v_ZfwsxwdctzsDTO.setCheckedqm(request.getContextPath()+v_ZfwsxwdctzsDTO.getCheckedqm());
            v_ZfwsxwdctzsDTO.setApplyqm(request.getContextPath()+v_ZfwsxwdctzsDTO.getApplyqm());
            v_ZfwsxwdctzsDTO.setCheckqm(request.getContextPath()+v_ZfwsxwdctzsDTO.getCheckqm());
            v_ZfwsxwdctzsDTO.setWitnessqm(request.getAuthType() + v_ZfwsxwdctzsDTO.getWitnessqm());
            v_ZfwsxwdctzsDTO.setNoticeqm(request.getContextPath()+v_ZfwsxwdctzsDTO.getNoticeqm());
            v_ZfwsxwdctzsDTO.setRecordqm(request.getContextPath()+v_ZfwsxwdctzsDTO.getRecordqm());
        }
        return v_ZfwsxwdctzsDTO;
    }

    /**
     * saveXwdctzs的中文名称：保存询问调查通知书
     * saveXwdctzs的概要描述：
     *
     * @param request
     * @param dto
     * @return written by ： lfy
     */
    public String saveXwdctzs(HttpServletRequest request,
                              ZfwsxwdctzsDTO dto) {
        String xwdctzsid = null;
        try {
            xwdctzsid = saveXwdctzsImp(request, dto);
        } catch (Exception e) {
            return null;
        }
        return xwdctzsid;
    }

    @Aop({"trans"})
    public String saveXwdctzsImp(HttpServletRequest request,
                                 ZfwsxwdctzsDTO dto) throws Exception {
        if ("".equals(dto.getXwdcjzrq())) {
            dto.setXwdcjzrq(null);
        }
        if ("".equals(dto.getXwdcqzrq())) {
            dto.setXwdcqzrq(null);
        }
        if ("".equals(dto.getXwdcdsrqzrq())) {
            dto.setXwdcdsrqzrq(null);
        }
        if (!"".equals(dto.getXwdctzsid()) && null != dto.getXwdctzsid()) {
            Zfwsxwdctzs dctzs = dao.fetch(Zfwsxwdctzs.class, dto.getXwdctzsid());
            //ZfwsxwdctzsDTO dctzs=new ZfwsxwdctzsDTO();
            BeanHelper.copyProperties(dto, dctzs);
            dao.update(dctzs);
            return dto.getXwdctzsid();
        } else {
            //判断案件文书对应关系表是否存在，不存在增加一条
            String id = DbUtils.getSequenceStr();
            if (dto.getSjordn() != null && "2".endsWith(dto.getSjordn())) {
                if (dto.getAjzfwsid() != null) {
                    Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class, dto.getAjzfwsid());
                    Sysuser vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
                    String zfwsczsj = SysmanageUtil.getDbtimeYmdHns();
                    v_Zfajzfws.setZfwsuserid(dto.getUserid());
                    v_Zfajzfws.setZfwsczyxm(vSysUser.getUsername());
                    v_Zfajzfws.setZfwsczsj(zfwsczsj);
                    v_Zfajzfws.setAjdjid(dto.getAjdjid());
                    v_Zfajzfws.setZfwsdmz("ZFAJZFWS44");
                    v_Zfajzfws.setZfwsqtbid(id);
                    v_Zfajzfws.setZfwstzbz("1");
                    dao.update(v_Zfajzfws);
                }
//				ZfajzfwsDTO v_ZfajzfwsDTO=new ZfajzfwsDTO();
//				v_ZfajzfwsDTO.setUserid(dto.getUserid());
//				v_ZfajzfwsDTO.setAjdjid(dto.getAjdjid());
//				v_ZfajzfwsDTO.setFjcsdmzlist("ZFAJZFWS44");
//				v_ZfajzfwsDTO.setZfwsqtbid(id);
//				dto.setZfwsdmz("ZFAJZFWS44");
//				saveZfwsadd(request,v_ZfajzfwsDTO);
            }


            Zfwsxwdctzs dctzsin = new Zfwsxwdctzs();
            BeanHelper.copyProperties(dto, dctzsin);
            dctzsin.setXwdctzsid(id);
            dao.insert(dctzsin);
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + id
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz() + "'" +
                    " and ajzfwsid='" + dto.getAjzfwsid() + "'";
            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return id;
        }
    }

    /**
     * queryzfwsjbdjb45Obj  查询举报登记表
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */

    @SuppressWarnings({"rawtypes"})
    //TODO 文书45
    public Object queryzfwsjbdjb45Obj(HttpServletRequest request, @Param("..") zfwsjbdjb45DTO dto) throws Exception {

        String jbdjbid = request.getParameter("zfwsqtbid");
        if (jbdjbid != null && !"".equals(jbdjbid) && !"undefined".equals(jbdjbid)) {
            dto.setJbdjbid(jbdjbid);
        }

        StringBuffer sb = new StringBuffer();
        sb.append("SELECT * FROM zfwsjbdjb45 jb WHERE 1=1");
        sb.append(" AND jb.ajdjid=:ajdjid ");
        sb.append(" AND jb.jbdjbid=:jbdjbid ");
//		if(request.getParameter("zfwsqtbid")!=null&&!"".equals(request.getParameter("zfwsqtbid"))){
//	 		sb.append("  and jb.jbdjbid = '").append(request.getParameter("zfwsqtbid")).append("'");
//	 		}
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "jbdjbid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                zfwsjbdjb45DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        zfwsjbdjb45DTO jbdjb45 = new zfwsjbdjb45DTO();
        if (ls.size() > 0 && ls != null) {
            jbdjb45 = (zfwsjbdjb45DTO) ls.get(0);
        } else {
            jbdjb45.setJbdjbh("（汤）X举登〔2016〕X号");
        }
        return jbdjb45;
    }

    /**
     * savejbdjb45：保存举报登记表
     *
     * @param request
     * @param dto
     * @return
     */
    public String savejbdjb45(HttpServletRequest request, @Param("..") zfwsjbdjb45DTO dto) {
        String jbdjbid = null;
        try {
            jbdjbid = savejbdjb45Impl(request, dto);
        } catch (Exception e) {
            return null;
        }
        return jbdjbid;
    }

    /**
     * savejbdjb45Impl：实现举报登记表保存
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    @Aop({"trans"})
    public String savejbdjb45Impl(HttpServletRequest request, @Param("..") zfwsjbdjb45DTO dto) {
        if ("".equals(dto.getJbdjfzrqzrq())) {
            dto.setJbdjfzrqzrq(null);
        }
        if ("".equals(dto.getJbdjjlrqzrq())) {
            dto.setJbdjjlrqzrq(null);
        }
        if ("".equals(dto.getJbdjjbsj())) {
            dto.setJbdjjbsj(null);
        }
        if (dto.getJbdjbid() != null && !"".equals(dto.getJbdjbid())) {
            Zfwsjbdjb45 zfwsjbdjb45 = dao.fetch(Zfwsjbdjb45.class, dto.getJbdjbid());
            BeanHelper.copyProperties(dto, zfwsjbdjb45);
            dao.update(zfwsjbdjb45);
            return dto.getJbdjbid();
        } else {
            Zfwsjbdjb45 jbdj = new Zfwsjbdjb45();
            String id = DbUtils.getSequenceStr();
            BeanHelper.copyProperties(dto, jbdj);
            jbdj.setJbdjbid(id);
            dao.insert(jbdj);
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + id
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz()
                    + "' and ajzfwsid='" + dto.getAjzfwsid() + "'";
            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return id;
        }
    }

    /**
     * queryZfwsjcdwjclj46Obj  查询稽查队文件处理笺（jian）
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */

    @SuppressWarnings("rawtypes")
    //TODO  文书46
    public Object queryZfwsjcdwjclj46Obj(HttpServletRequest request, @Param("..") Zfwsjcdwjclj46DTO dto) throws Exception {

        String jcwjclid = request.getParameter("zfwsqtbid");
        if (jcwjclid != null && !"".equals(jcwjclid) && !"undefined".equals(jcwjclid)) {
            dto.setJcwjclid(jcwjclid);
        }

        StringBuffer sb = new StringBuffer();
        sb.append("SELECT * FROM zfwsjcdwjclj46 jl WHERE 1=1");
        sb.append(" AND jl.ajdjid=:ajdjid ");
        sb.append(" AND jl.jcwjclid=:jcwjclid ");
//		if(request.getParameter("zfwsqtbid")!=null&&!"".equals(request.getParameter("zfwsqtbid"))){
//	 		sb.append("  and jl.jcwjclid = '").append(request.getParameter("zfwsqtbid")).append("'");
//	 		}
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "jcwjclid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsjcdwjclj46DTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Zfwsjcdwjclj46DTO jcwjcl = new Zfwsjcdwjclj46DTO();
        if (ls.size() > 0 && ls != null) {
            jcwjcl = (Zfwsjcdwjclj46DTO) ls.get(0);
        }
        return jcwjcl;
    }

    /**
     * savejbdjb46：保存稽查队文件处理笺（jian）
     *
     * @param request
     * @param dto
     * @return
     */
    public String savejcdwjcl46(HttpServletRequest request, @Param("..") Zfwsjcdwjclj46DTO dto) {
        String jcdwjclid = null;
        try {
            jcdwjclid = savejcdwjcl46Impl(request, dto);
        } catch (Exception e) {
            return null;
        }
        return jcdwjclid;
    }

    @Aop({"trans"})
    public String savejcdwjcl46Impl(HttpServletRequest request, @Param("..") Zfwsjcdwjclj46DTO dto) {
        if ("".equals(dto.getJcwjclwjsdrq())) {
            dto.setJcwjclwjsdrq(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq1())) {
            dto.setJcwjclyzqmrq1(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq2())) {
            dto.setJcwjclyzqmrq2(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq3())) {
            dto.setJcwjclyzqmrq3(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq4())) {
            dto.setJcwjclyzqmrq4(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq5())) {
            dto.setJcwjclyzqmrq5(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq6())) {
            dto.setJcwjclyzqmrq6(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq7())) {
            dto.setJcwjclyzqmrq7(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq8())) {
            dto.setJcwjclyzqmrq8(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq9())) {
            dto.setJcwjclyzqmrq9(null);
        }
        if ("".equals(dto.getJcwjclyzqmrq10())) {
            dto.setJcwjclyzqmrq10(null);
        }
        if (dto.getJcwjclid() != null && !"".equals(dto.getJcwjclid())) {
            Zfwsjcdwjclj46 jcdwjcl = dao.fetch(Zfwsjcdwjclj46.class, dto.getJcwjclid());
            BeanHelper.copyProperties(dto, jcdwjcl);
            dao.update(jcdwjcl);
            return dto.getJcwjclid();
        } else {
            Zfwsjcdwjclj46 jcd = new Zfwsjcdwjclj46();
            String id = DbUtils.getSequenceStr();
            BeanHelper.copyProperties(dto, jcd);
            jcd.setJcwjclid(id);
            dao.insert(jcd);
            String v_sql = "update zfajzfws a set a.zfwsqtbid='" + id
                    + "',zfwstzbz='1' where a.ajdjid='" + dto.getAjdjid()
                    + "' and zfwsdmz='" + dto.getZfwsdmz()
                    + "' and ajzfwsid='" + dto.getAjzfwsid() + "'";
            Sql sql = Sqls.create(v_sql);
            dao.execute(sql);
            return id;
        }
    }

    /**
     * queryZfwssxgzspbObj的中文名称：行政处罚事先（听证）告知审批表
     * <p/>
     * queryZfwssxgzspbObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书41
    public Object queryZfwssxgzspbObj(HttpServletRequest request,
                                      Zfwsxzcfsxtzgzspb41DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 事先（听证）告知审批表id
        String sxtzgzspbid = request.getParameter("zfwsqtbid");
        if (sxtzgzspbid != null && !"".equals(sxtzgzspbid) && !"undefined".equals(sxtzgzspbid)) {
            dto.setSxtzgzspbid(sxtzgzspbid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsxzcfsxtzgzspb41 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // 案件登记id
        sb.append("  and a.sxtzgzspbid = :sxtzgzspbid");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "sxtzgzspbid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfsxtzgzspb41DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 事先（听证）告知审批表内容
        Zfwsxzcfsxtzgzspb41DTO v_dto = new Zfwsxzcfsxtzgzspb41DTO();

        if (ls != null && ls.size() > 0) {
            v_dto = (Zfwsxzcfsxtzgzspb41DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_dto.setZywfss(v_zfajdj.getAjdjwfss()); // 违法事实
                    v_dto.setSxtzgzay(v_zfajdj.getAjdjay()); // 案由
                    v_dto.setSxtzgzdsr(v_zfajdj.getCommc()); // 当事人
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                if (v_pcom != null) {
                    v_dto.setSxtzgzdsr(v_pcom.getCommc()); // 当事人
                }
            }
        }
        return v_dto;
    }

    /**
     * saveZfwsxzcfsxtzgzspb的中文名称：保存事先（听证）告知审批表
     * <p/>
     * saveZfwsxzcfsxtzgzspb的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsxzcfsxtzgzspb(HttpServletRequest request, Zfwsxzcfsxtzgzspb41DTO dto) {
        String sxtzgzspbid = null;
        try {
            sxtzgzspbid = saveZfwsxzcfsxtzgzspbImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return sxtzgzspbid;
    }

    /**
     * saveZfwsxzcfsxtzgzspbImp的中文名称：保存事先（听证）告知审批表实现方法
     * <p/>
     * saveZfwsxzcfsxtzgzspbImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsxzcfsxtzgzspbImp(HttpServletRequest request, Zfwsxzcfsxtzgzspb41DTO dto)
            throws Exception {
        if ("".equals(dto.getCbrqzrq())) {
            dto.setCbrqzrq(null);
        }
        if ("".equals(dto.getCbbmfzrqzrq())) {
            dto.setCbbmfzrqzrq(null);
        }
        if ("".equals(dto.getFzjgfzrqzrq())) {
            dto.setFzjgfzrqzrq(null);
        }
        if ("".equals(dto.getSpbmfzrqzrq())) {
            dto.setSpbmfzrqzrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getSxtzgzspbid()) && (!"".equals(dto.getSxtzgzspbid()))) {
            Zfwsxzcfsxtzgzspb41 se = dao.fetch(Zfwsxzcfsxtzgzspb41.class, dto.getSxtzgzspbid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getSxtzgzspbid();
        } else {
            // 撤案审批表
            String v_id = DbUtils.getSequenceStr();
            Zfwsxzcfsxtzgzspb41 se = new Zfwsxzcfsxtzgzspb41();
            BeanHelper.copyProperties(dto, se);
            se.setSxtzgzspbid(v_id);
            dao.insert(se);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append(
                    "' and ajzfwsid = '").append(dto.getAjzfwsid())
                    .append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwszdgxtzsObj的中文名称：指定管辖通知书
     * <p/>
     * queryZfwszdgxtzsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书43
    public Object queryZfwszdgxtzsObj(HttpServletRequest request,
                                      Zfwszdgxtzs43DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 指定管辖通知书id
        String zdgxtzsid = request.getParameter("zfwsqtbid");
        if (zdgxtzsid != null && !"".equals(zdgxtzsid) && !"undefined".equals(zdgxtzsid)) {
            dto.setZdgxtzsid(zdgxtzsid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwszdgxtzs43 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // 案件登记id
        sb.append("  and a.zdgxtzsid = :zdgxtzsid");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "zdgxtzsid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwszdgxtzs43DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 指定管辖通知书内容
        Zfwszdgxtzs43DTO v_dto = new Zfwszdgxtzs43DTO();

        if (ls != null && ls.size() > 0) {
            v_dto = (Zfwszdgxtzs43DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_dto.setZfwsbh(v_zfajdj.getWfxwbh()); // 文书编号
                    v_dto.setGyaj(v_zfajdj.getAjdjay()); // 案由
                }
            }
            // 行政机关名称，默认从aa01表中取食品药品监督管理局全称
            Aa01 v_aa01 = SysmanageUtil.getAa01Fdq("SPYPJDGLJMCQC");
            v_dto.setXzjgmc(v_aa01.getAaa005());
        }
        return v_dto;
    }

    /**
     * saveZfwszdgxtzs的中文名称：保存指定管辖通知书
     * <p/>
     * saveZfwszdgxtzs的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwszdgxtzs(HttpServletRequest request, Zfwszdgxtzs43DTO dto) {
        String zdgxtzsid = null;
        try {
            zdgxtzsid = saveZfwszdgxtzsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return zdgxtzsid;
    }

    /**
     * saveZfwszdgxtzsImp的中文名称：保存指定管辖通知书实现方法
     * <p/>
     * saveZfwszdgxtzsImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwszdgxtzsImp(HttpServletRequest request, Zfwszdgxtzs43DTO dto)
            throws Exception {
        if ("".equals(dto.getGzrq())) {
            dto.setGzrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getZdgxtzsid()) && (!"".equals(dto.getZdgxtzsid()))) {
            Zfwszdgxtzs43 se = dao.fetch(Zfwszdgxtzs43.class, dto.getZdgxtzsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getZdgxtzsid();
        } else {
            // 撤案审批表
            String v_id = DbUtils.getSequenceStr();
            Zfwszdgxtzs43 se = new Zfwszdgxtzs43();
            BeanHelper.copyProperties(dto, se);
            se.setZdgxtzsid(v_id);
            dao.insert(se);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append(
                    "' and ajzfwsid = '").append(dto.getAjzfwsid())
                    .append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwsxzcfwtsObj的中文名称：行政处罚委托书
     * <p/>
     * queryZfwsxzcfwtsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO  文书42
    public Object queryZfwsxzcfwtsObj(HttpServletRequest request,
                                      Zfwsxzcfwts42DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 行政处罚委托书id
        String xzcfwtsid = request.getParameter("zfwsqtbid");
        if (xzcfwtsid != null && !"".equals(xzcfwtsid) && !"undefined".equals(xzcfwtsid)) {
            dto.setXzcfwtsid(xzcfwtsid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsxzcfwts42 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // 案件登记id
        sb.append("  and a.xzcfwtsid = :xzcfwtsid");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "xzcfwtsid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsxzcfwts42DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 行政处罚委托书内容
        Zfwsxzcfwts42DTO v_dto = new Zfwsxzcfwts42DTO();

        if (ls != null && ls.size() > 0) {
            v_dto = (Zfwsxzcfwts42DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_dto.setZfwsbh(v_zfajdj.getWfxwbh()); // 文书编号
                }
            }
        }
        return v_dto;
    }

    /**
     * saveZfwsxzcfwts的中文名称：保存行政处罚委托书
     * <p/>
     * saveZfwsxzcfwts的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsxzcfwts(HttpServletRequest request, Zfwsxzcfwts42DTO dto) {
        String xzcfwtsid = null;
        try {
            xzcfwtsid = saveZfwsxzcfwtsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return xzcfwtsid;
    }

    /**
     * saveZfwsxzcfwtsImp的中文名称：保存行政处罚委托书实现方法
     * <p/>
     * saveZfwsxzcfwtsImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsxzcfwtsImp(HttpServletRequest request, Zfwsxzcfwts42DTO dto)
            throws Exception {
        if ("".equals(dto.getWtksrq())) {
            dto.setWtksrq(null);
        }
        if ("".equals(dto.getWtjsrq())) {
            dto.setWtjsrq(null);
        }
        if ("".equals(dto.getWtjgdbrqzrq())) {
            dto.setWtjgdbrqzrq(null);
        }
        if ("".equals(dto.getSwtjgdbrqzrq())) {
            dto.setSwtjgdbrqzrq(null);
        }
        // 判断id是否为空
        if ((null != dto.getXzcfwtsid()) && (!"".equals(dto.getXzcfwtsid()))) {
            Zfwsxzcfwts42 se = dao.fetch(Zfwsxzcfwts42.class, dto.getXzcfwtsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getXzcfwtsid();
        } else {
            // 行政处罚委托书
            String v_id = DbUtils.getSequenceStr();
            Zfwsxzcfwts42 se = new Zfwsxzcfwts42();
            BeanHelper.copyProperties(dto, se);
            se.setXzcfwtsid(v_id);
            dao.insert(se);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append(
                    "' and ajzfwsid = '").append(dto.getAjzfwsid())
                    .append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfwsfzjgshyjsObj的中文名称：法制机构审核意见书
     * <p/>
     * queryZfwsfzjgshyjsObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    //TODO 文书47
    public Object queryZfwsfzjgshyjsObj(HttpServletRequest request,
                                        Zfwsfzjgshyjs47DTO dto) throws Exception {
        String v_operatetype = "ajdj";
        if (StringUtils.isNotEmpty(dto.getOperatetype()) && "mobilecheck".equals(dto.getOperatetype())) {
            v_operatetype = dto.getOperatetype();
        }
        // 法制机构审核意见书id
        String fzjgshyjsid = request.getParameter("zfwsqtbid");
        if (fzjgshyjsid != null && !"".equals(fzjgshyjsid) && !"undefined".equals(fzjgshyjsid)) {
            dto.setFzjgshyjsid(fzjgshyjsid);
        }
        // 查询sql语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from zfwsfzjgshyjs47 a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid = :ajdjid "); // 案件登记id
        sb.append("  and a.fzjgshyjsid = :fzjgshyjsid");
        // 查询参数
        String[] ParaName = new String[]{"ajdjid", "fzjgshyjsid"};
        // 参数类型
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                Zfwsfzjgshyjs47DTO.class);
        List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
        // 法制机构审核意见书
        Zfwsfzjgshyjs47DTO v_dto = new Zfwsfzjgshyjs47DTO();

        if (ls != null && ls.size() > 0) {
            v_dto = (Zfwsfzjgshyjs47DTO) ls.get(0);
        } else {
            if ("ajdj".equals(v_operatetype)) {
                // 查询案件登记信息
                ZfajdjDTO v_zfajdj = (ZfajdjDTO) queryZfajdj(dto.getAjdjid()).get(0);
                if (v_zfajdj != null) {
                    v_dto.setShyjsay(v_zfajdj.getAjdjay()); // 案由
                    v_dto.setShyjsdsr(v_zfajdj.getCommc()); // 当事人
                }
            } else {
                Pcompany v_pcom = dao.fetch(Pcompany.class, dto.getComid());
                if (v_pcom != null) {
                    v_dto.setShyjsdsr(v_pcom.getCommc()); // 当事人
                }
            }
        }
        return v_dto;
    }

    /**
     * saveZfwsfzjgshyjs的中文名称：保存法制机构审核意见书
     * <p/>
     * saveZfwsfzjgshyjs的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveZfwsfzjgshyjs(HttpServletRequest request, Zfwsfzjgshyjs47DTO dto) {
        String fzjgshyjsid = null;
        try {
            fzjgshyjsid = saveZfwsfzjgshyjsImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return fzjgshyjsid;
    }

    /**
     * saveZfwsfzjgshyjsImp的中文名称：保存法制机构审核意见书实现方法
     * <p/>
     * saveZfwsfzjgshyjsImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveZfwsfzjgshyjsImp(HttpServletRequest request, Zfwsfzjgshyjs47DTO dto)
            throws Exception {
        if ("".equals(dto.getShyjssssj())) {
            dto.setShyjssssj(null);
        }
        // 判断id是否为空
        if ((null != dto.getFzjgshyjsid()) && (!"".equals(dto.getFzjgshyjsid()))) {
            Zfwsfzjgshyjs47 se = dao.fetch(Zfwsfzjgshyjs47.class, dto.getFzjgshyjsid());
            BeanHelper.copyProperties(dto, se);
            dao.update(se);
            return dto.getFzjgshyjsid();
        } else {
            // 法制机构审核意见书
            String v_id = DbUtils.getSequenceStr();
            Zfwsfzjgshyjs47 se = new Zfwsfzjgshyjs47();
            BeanHelper.copyProperties(dto, se);
            se.setFzjgshyjsid(v_id);
            dao.insert(se);
            // 更新文书填写标志
            StringBuffer sb = new StringBuffer();
            sb.append(" update zfajzfws a set a.zfwsqtbid = '").append(v_id)
                    .append("',zfwstzbz='1'");
            sb.append(" where a.ajdjid='").append(dto.getAjdjid()).append(
                    "' and zfwsdmz = '").append(dto.getZfwsdmz()).append("' and ajzfwsid='").append(
                    dto.getAjzfwsid()).append("'");
            Sql sql = Sqls.create(sb.toString());
            dao.execute(sql);
            return v_id;
        }
    }

    /**
     * queryZfajdj的中文名称：根据id查询案件登记信息 queryZfajdj的概要描述：
     *
     * @param prm_ajdjid
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("rawtypes")
    public List queryZfajdj1(String prm_ajdjid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ,(select getAa10_aaa103('AJDJAJLY',a.ajdjajly)) as ajdjajlystr");
        sb.append("  from Zfajdj a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.ajdjid='").append(prm_ajdjid).append("'");

        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZfajdjDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        return ls;
    }

    /**
     * saveZfwsmoban的中文名称：保存执法文书案件来源登记表
     * <p/>
     * saveZfwsmoban的概要说明：
     *
     * @param dto
     * @return Written by : gjf
     */
    public String saveZfwsmoban(HttpServletRequest request, ZfajzfwsmbDTO dto) {
        try {
            saveZfwsmobanImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void saveZfwsmobanImp(HttpServletRequest request, ZfajzfwsmbDTO dto)
            throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        // 存在先删除
        String v_sql = "delete from zfajzfwsmb where ajdjid='"
                + dto.getAjdjid() + "' and zfwsdmz='" + dto.getZfwsdmz() + "'";
        Sql v_exesql = Sqls.create(v_sql);
        dao.execute(v_exesql);

        Zfajzfwsmb v_Zfajzfwsmb = new Zfajzfwsmb();
        String vzfwsmbid = DbUtils.getSequenceStr();
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();

        // 获取zfajzfws的值

        List<Zfajzfws> v_ZfajzfwsList = (List<Zfajzfws>) dao.query(
                Zfajzfws.class, Cnd.where("ajdjid", "=", dto.getAjdjid()).and(
                        "zfwsdmz", "=", dto.getZfwsdmz()));
        Zfajzfws v_Zfajzfws = new Zfajzfws();
        if (v_ZfajzfwsList != null && v_ZfajzfwsList.size() > 0) {
            v_Zfajzfws = v_ZfajzfwsList.get(0);
        }

        v_Zfajzfwsmb.setZfwsmbid(vzfwsmbid);
        v_Zfajzfwsmb.setAjdjid(dto.getAjdjid());
        v_Zfajzfwsmb.setZfwsdmz(dto.getZfwsdmz());
        v_Zfajzfwsmb.setZfwsqtbid(v_Zfajzfws.getZfwsqtbid());
        v_Zfajzfwsmb.setZfwsmbmc(dto.getZfwsmbmc());
        v_Zfajzfwsmb.setZfwsmbczy(vSysUser.getDescription());
        v_Zfajzfwsmb.setZfwsmbczsj(v_dbDatetime);
        v_Zfajzfwsmb.setAaa027(vSysUser.getAaa027());
        v_Zfajzfwsmb.setUserid(vSysUser.getUserid().toString());
        v_Zfajzfwsmb.setAaa146(vSysUser.getAaa027name());

        dao.insert(v_Zfajzfwsmb);

    }

    /**
     * queryZfwsmobanlist的中文名称：查询执法文书模板列表
     * <p/>
     * queryZfwsmobanlist的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : gjf
     * @throws Exception
     */
    @SuppressWarnings({"unchecked", "rawtypes", "unused"})
    public Map queryZfwsmobanlist(ZfajzfwsmbDTO dto, PagesDTO pd)
            throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from zfajzfwsmb a ");
        //gu20160514 不再过滤 sb.append(" where a.aaa027='" + vSysUser.getAaa027() + "'");
        sb.append(" where 1=1 ");
        sb.append("  and a.zfwsdmz=:zfwsdmz ");
        String sql = sb.toString();
        String[] ParaName = new String[]{"zfwsdmz"};
        int[] ParaType = new int[]{Types.VARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);

        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                ZfajzfwsmbDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     *
     * queryZfwsmobanmclist的中文名称：查询同一地区的模板名称 queryZfwsmobanmclist的概要说明： Written
     * by : lfy
     */
    /**
     * public Map queryZfwsmobanmclist(ZfajzfwsmbDTO dto, PagesDto pd) throws
     * Exception { Sysuser vSysUser=(Sysuser)SysmanageUtil.getSysuser();
     * StringBuffer sb = new StringBuffer(); sb.append(" select a.* ");
     * sb.append(" from zfajzfwsmb a ");
     * sb.append(" where a.aaa027='"+vSysUser.getAaa027()+"'");
     * sb.append("  and a.zfwsmbmc=:zfwsmbmc "); String sql = sb.toString();
     * String[] ParaName = new String[] {"zfwsmbmc"}; int[] ParaType = new int[]
     * {Types.VARCHAR}; sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto,
     * pd); Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
     * ZfajzfwsmbDTO.class, pd .getPage(), pd.getRows()); List ls = (List)
     * m.get(GlobalNames.SI_RESULTSET); Map r = new HashMap(); r.put("rows",
     * ls); r.put("total", m.get(GlobalNames.SI_TOTALROWNUM)); return r; }
     */
    public String queryZfwsmobanmclist(ZfajzfwsmbDTO dto, PagesDTO pd)
            throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        Cnd cnd = Cnd.where("aaa027", "=", vSysUser.getAaa027()).and(
                "zfwsmbmc", "=", dto.getZfwsmbmc());
        Zfajzfwsmb ss = dao.fetch(Zfajzfwsmb.class, cnd);
        if (null != ss) {
            return "已经存在";
        } else {
            return "ok";
        }
    }

    /**
     * uploadFjdel的中文名称：删除附件
     * <p/>
     * delFj的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    public String wsgldyDel(HttpServletRequest request, final ZfajzfwsDTO dto) {
        try {
            wsgldyDelImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @SuppressWarnings("unused")
    @Aop({"trans"})
    public void wsgldyDelImp(HttpServletRequest request, final ZfajzfwsDTO dto) {
        String v_zfwsmbid = dto.getZfwsmbid().toString();
        dao.clear(Zfajzfwsmb.class, Cnd.where("zfwsmbid", "=", dto.getZfwsmbid()));
    }

    /**
     * saveZfwsOrder的中文名称：保存执法文书排序
     * <p/>
     * saveZfwsOrder的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     * @throws Exception
     */
    public void saveZfwsOrder(HttpServletRequest request,
                              ViewzfajzfwsDTO dto) throws Exception {
        saveZfwsOrderImp(request, dto);
    }

    /**
     * @param request
     * @param dto
     * @throws Exception
     * @Description: 保存执法文书排序
     * @author CatchU
     */
    @Aop({"trans"})
    public void saveZfwsOrderImp(HttpServletRequest request,
                                 ViewzfajzfwsDTO dto)
            throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        String v_userid = vSysUser.getUserid();
        // 先删除
        String v_sql = "delete from pfjcsorder where userid='"
                + v_userid + "'";
        Sql sql2 = Sqls.create(v_sql);
        dao.execute(sql2);

        JSONArray v_array = null;
        Object[] v_objArray = null;
        // 物品明细情况
        v_array = JSONArray.fromObject(dto.getAjzfwsorderlist());
        v_objArray = v_array.toArray();
        String v_pfjcsorderid = "";
        for (int i = 0; i <= v_objArray.length - 1; i++) {
            JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
            Pfjcsorder v_Pfjcsorder = (Pfjcsorder) JSONObject.toBean(
                    v_obj, Pfjcsorder.class);
            // 获取物品明细id
            v_pfjcsorderid = DbUtils.getSequenceStr();
            v_Pfjcsorder.setPfjcsorderid(v_pfjcsorderid);
            v_Pfjcsorder.setUserid(v_userid);
            String v_fjcspx = (v_Pfjcsorder.getFjcspx() == null ? "9999" : v_Pfjcsorder.getFjcspx().toString());
            v_Pfjcsorder.setFjcspx(v_fjcspx);
            dao.insert(v_Pfjcsorder);
        }
    }


    /**
     * @throws Exception
     * @Description: 当前操作员是否设置了执法文书排序
     * @author CatchU
     */
    @Aop({"trans"})
    public boolean userHaveSetZfwsorder(ViewzfajzfwsDTO dto)
            throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        if (vSysUser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
            vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
        }
        String v_userid = vSysUser.getUserid();
        boolean v_have = false;

        String v_sql = " select count(*) from pfjcsorder where userid='"
                + v_userid + "'";
        String v_count = DbUtils.getOneValue(dao, v_sql);
        if (Integer.parseInt(v_count) > 0) {
            v_have = true;
        }
        return v_have;
    }

    public boolean dzqm(String userpwd) throws Exception {
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        //String userid = sysuser.getUserid();
        boolean v_ret = false;
        //Dzqm dq = dao.fetch(Dzqm.class,Cnd.where("dzqmuser='"+userid+"' and dzqmpwd ", "=",userpwd));
        //Sysuser v_newSysuser=dao.fetch(Sysuser.class,Cnd.where("userid", "=", userid).and("passwd", "=", userpwd));
        if (userpwd.equalsIgnoreCase(sysuser.getPasswd())) {
            v_ret = true;
        }
        return v_ret;

    }
    public String delZfwsfy(HttpServletRequest request,Zfwsspypxzcfwsfy36DTO dto) {
        try{
            delZfwsfyImpl(request,dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    public String delZfwsfyImpl(HttpServletRequest request, Zfwsspypxzcfwsfy36DTO dto) {
        dao.clear(Zfwsspypxzcfwsfy36DTO.class, Cnd.where("spypxzcfwsfyid", "=", dto.getSpypxzcfwsfyid()));
        Zfajzfws v_Zfajzfws = dao.fetch(Zfajzfws.class,Cnd.where("ajdjid", "=", dto.getAjdjid()).and("zfwsqtbid", "=", dto.getZybid()));
        v_Zfajzfws.setFytzbz("0");
        dao.update(v_Zfajzfws);
        return null;
    }
}
