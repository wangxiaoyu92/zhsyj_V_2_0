package com.askj.jyjc.service;

import com.alibaba.fastjson.JSON;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.baseinfo.service.pub.PubService;
import com.askj.jyjc.dto.*;
import com.askj.jyjc.entity.*;
import com.askj.supervision.dto.BsTbodyInfoDTo;
import com.askj.supervision.dto.pubkeyDTO;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.leaf.validate.ValidateData;
import com.lbs.util.StringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysoperatelogDTO;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.PubParentChild;
import com.zzhdsoft.siweb.entity.sysmanager.Sysoperatelog;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.*;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * JyjcService的中文名称：检验检测业务逻辑层
 *
 * JyjcService的描述
 *
 * Written by CatchU 2016年5月5日上午9:56:52
 */
@IocBean
public class JyjcService extends BaseService {

    protected final Logger logger = Logger.getLogger(JyjcService.class);

    //注入dao
    @Inject
    protected Dao dao;
    @Inject
    private PubService pubService;

    /**
     *
     * queryJyjcxm的中文名称:查询检验检测项目并分页
     *
     * queryJyjcxm的概要说明:
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * Written by CatchU 2016年5月5日下午1:32:38
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjcxm(JyjcxmDTO dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select jyjcxmid,jcxmbh,jcxmmc,jcxmbzz,jcxmczy,jcxmczsj ");
        sb.append(" from jyjcxm jcxm");
        sb.append(" where 1=1");
        sb.append(" and jcxm.jcxmbh = :jcxmbh");
        sb.append(" and jcxm.jcxmmc like :jcxmmc");
        sb.append(" and jcxm.jcxmczy = :jcxmczy");
        sb.append(" and jcxm.jyjcxmid = :jyjcxmid");
        sb.append(" order by jyjcxmid");
        String sql = sb.toString();
        String[] paramName = new String[]{"jcxmbh","jcxmmc","jcxmczy","jyjcxmid"};
        int[] paramType = new int[]{ Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcxmDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     *
     * queryJyjcjcbzb的中文名称:查询检验检测抽检任务并分页
     *
     * queryJyjcjcbzb的概要说明:
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * Written by wxy
     */
    public Map queryCjrw(HttpServletRequest request,JyjccjrwbDTO dto, PagesDTO pd) throws Exception {
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        String v_userdalei=sysuser.getUserdalei();
        String v_userkind="";
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select cjrw.*,");
        sb.append(" (select p.commc from pcompany p where p.comid=cjrw.comid ) as commc,");
        sb.append(" (select p.commc from pcompany p where p.comid=cjrw.cjjgcomid ) as cjcommc ");
        sb.append(" from jyjccjrwb cjrw");
        sb.append(" where 1=1");
       // sb.append(" and cjrw.aae011='"+sysuser.getUsername()+"' ");

/*gu20180601        if (sysuser!=null && ("6".equals(sysuser.getUserkind())||"7".equals(sysuser.getUserkind())
                ||"8".equals(sysuser.getUserkind()))){
            sb.append(" and cjrw.cjjgcomid='"+sysuser.getUsercomid()+"' ");
        }else if(!"6".equals(sysuser.getUserkind())&&!"7".equals(sysuser.getUserkind())
                &&!"8".equals(sysuser.getUserkind())&&!"30".equals(sysuser.getUserkind())){
            sb.append(" and cjrw.aae011='"+sysuser.getUsername()+"' ");
        }*/
        v_userkind=sysuser.getUserkind();
        if ("20".equals(v_userkind)||"21".equals(v_userkind)){//20检测机构21检测机构人员
            sb.append(" and cjrw.cjjgcomid='"+sysuser.getUsercomid()+"' ");
        }

        sb.append(" and cjrw.comid like :comid");
        sb.append(" and cjrw.cjjgrwjsbz = :cjjgrwjsbz");
        sb.append(" and cjrw.jcrwmc = :jcrwmc ");
        sb.append(" and cjrw.jcrwzxzt = :jcrwzxzt");
        sb.append(" and cjrw.cjjgrwjsbz = :cjjgrwjsbz");
        sb.append(" and cjrw.jyjccjrwbid = :jyjccjrwbid");

        if ("2".equals(v_userdalei)){//非企业用户
            sb.append(" and cjrw.cjjgcomid='"+sysuser.getUsercomid()+"' ");
        }

        sb.append(" order by jyjccjrwbid desc");
        String sql = sb.toString();
        String[] jcbzName = new String[]{"comid","cjjgrwjsbz","jcrwzxzt","jcrwmc","cjjgrwjsbz","jyjccjrwbid"};
        int[] jcbzType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, jcbzName, jcbzType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjccjrwbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

        return map;
    }
    /**
     * 保存抽检任务
     * @param request
     * @param dto
     * @return
     * Written by Wxy
     */
    public String saveCjrw(HttpServletRequest request,final JyjccjrwbDTO dto) {
        try{
            saveCjrwImpl(request, dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop( { "trans" })
    public void saveCjrwImpl(HttpServletRequest request, JyjccjrwbDTO dto) throws Exception {
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        if (Strings.isNotBlank(dto.getJyjccjrwbid())) {
            Jyjccjrwb cjrw = dao.fetch(Jyjccjrwb.class, dto.getJyjccjrwbid());
            BeanHelper.copyProperties(dto, cjrw);
            cjrw.setAae011(sysuser.getDescription());
            cjrw.setAae036(datetime);
            dao.update(cjrw);
        } else {
            Jyjccjrwb cjrw = new Jyjccjrwb();
            String jyjccjrwbid = DbUtils.getSequenceStr();
            dto.setJyjccjrwbid(jyjccjrwbid);
            BeanHelper.copyProperties(dto, cjrw);
            cjrw.setAae011(sysuser.getDescription());
            cjrw.setAae036(datetime);
            dao.insert(cjrw);
        }
    }
    /**
     * 处理抽检任务
     * @param request
     * @param dto
     * @return
     * Written by Wxy
     */
    public String handleCjrw(HttpServletRequest request,final JyjccjrwbDTO dto) {
        try{
            handleCjrwImpl(request, dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop( { "trans" })
    public void handleCjrwImpl(HttpServletRequest request, JyjccjrwbDTO dto) throws Exception {
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        if(!(dto.getJyjccjrwbid() == null||"".equals(dto.getJyjccjrwbid()))) {
            Jyjccjrwb cjrw = dao.fetch(Jyjccjrwb.class, dto.getJyjccjrwbid());
            BeanHelper.copyProperties(dto, cjrw);
            cjrw.setAae011(sysuser.getUsername());
            cjrw.setAae036(datetime);
            dao.update(cjrw);
        }
    }
    public String delCjrw(HttpServletRequest request, JyjccjrwbDTO dto) {
        try{
            delCjrwImpl(request, dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop({"trans"})
    private void delCjrwImpl(HttpServletRequest request, JyjccjrwbDTO dto) {
        if(!(dto.getJyjccjrwbid() == null||"".equals(dto.getJyjccjrwbid()))){
            //删除信息
            dao.clear(Jyjccjrwb.class, Cnd.where("jyjccjrwbid", "=", dto.getJyjccjrwbid()));
        }
    }
    /**
     *
     * queryJyjcjcbzb的中文名称:查询检验检测标准并分页
     *
     * queryJyjcjcbzb的概要说明:
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * Written by wxy
     */
    public Map queryJyjcjcbzb(HttpServletRequest request,JyjcjcbzbDTO dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select * from jyjcjcbzb jcbz");
        sb.append(" where 1=1");
        sb.append(" and (jcbz.bzbh like :bzbh or jcbz.jyjcjcbzbid like :bzbh or jcbz.chinaname like :bzbh)");
        sb.append(" and (jcbz.chinaname like :chinaname or jcbz.engname like :chinaname)");
        sb.append(" and jcbz.jyjcjcbzbid = :jyjcjcbzbid");
        sb.append(" order by jyjcjcbzbid desc");
        String sql = sb.toString();
        String[] jcbzName = new String[]{"bzbh","chinaname","jyjcjcbzbid"};
        int[] jcbzType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, jcbzName, jcbzType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcjcbzbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

        return map;
    }

    /**
     * 保存检验检测标准
     * @param request
     * @param dto
     * @return
     * Written by Wxy
     */
    public String saveJyjcbz(HttpServletRequest request,final JyjcjcbzbDTO dto) {
        try{
            saveJyjcbzImpl(request,dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop( { "trans" })
    public void saveJyjcbzImpl(HttpServletRequest request, JyjcjcbzbDTO dto) throws Exception {
        Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        if (Strings.isNotBlank(dto.getJyjcjcbzbid())) {
            Jyjcjcbzb jcbz=dao.fetch(Jyjcjcbzb.class,dto.getJyjcjcbzbid());
            BeanHelper.copyProperties(dto, jcbz);
            jcbz.setAae011(sysuser.getDescription());
            jcbz.setAae036(datetime);
            dao.update(jcbz);
        }else {
            Jyjcjcbzb jcbz=new Jyjcjcbzb();
            String jyjcjcbzbid = DbUtils.getSequenceStr();
            dto.setJyjcjcbzbid(jyjcjcbzbid);
            BeanHelper.copyProperties(dto, jcbz);
            jcbz.setAae011(sysuser.getDescription());
            jcbz.setAae036(datetime);
            dao.insert(jcbz);
        }
    }
    /**
     *
     * delJyjcxm的中文名称:删除检验检测项目
     *
     * delJyjcxm的概要说明:
     *
     * @param request
     * @param dto
     * @return
     * Written by CatchU 2016年5月5日下午1:22:04
     */
    public String delJyjcbz(HttpServletRequest request, JyjcjcbzbDTO dto) {
        try{
            delJyjcbzImpl(request, dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    /**
     *
     * delJyjcbzImpl的中文名称:删除检验检测实现方法
     *
     * delJyjcxmImpl的概要说明:
     *
     * @param request
     * @param dto
     * Written by wxy
     */
    @Aop({"trans"})
    private void delJyjcbzImpl(HttpServletRequest request, JyjcjcbzbDTO dto) {
        if(!(dto.getJyjcjcbzbid() == null||"".equals(dto.getJyjcjcbzbid()))){
            //删除信息
            dao.clear(Jyjcjcbzb.class, Cnd.where("jyjcjcbzbid", "=", dto.getJyjcjcbzbid()));
        }
    }
    /*
     *queryJyjcxmZTree:检验检测项目树的生成.
     * Written by wxy
     */
    public List queryJyjcxmZTree(HttpServletRequest request,JyjcxmDTO dto) throws Exception {
//		String jcxmid = StringHelper.showNull2Empty(request.getParameter("jcxmid"));
//		String jcxmparentid = "0";
//		if ("".equals(jcxmid) || jcxmid == null) {
//			jcxmparentid = "1044";
//		}else{
//			jcxmparentid = jcxmid;
//		}
        String sb = "";
        sb += "SELECT h.jyjcxmid,(SELECT jcxmmc FROM jyjcxm j where j.jyjcxmid=h.jcxmparentid) as parentname,h.jcxmparentid,h.jcxmbh,h.jcxmmc,h.jcxmmcjc,h.jcxmbzz,h.jcxmczy,h.jcxmczsj,h.sfyx,h.childnum,h.jyjcxmlx,h.sfmulu,a.bzbh,a.jyjcjcbzbid,b.jcffbzbh,b.jyjcffbzbid,";
        sb += "(case when childnum > 0 then 'true' else 'false' end) AS isparent,";
        sb += "(case when childnum > 0 then 'true' else 'false' end) AS isopen ";
        sb += "FROM ( ";
        sb += "SELECT t.jyjcxmid,t.jcxmparentid,t.jcxmbh,t.jcxmmc,t.jcxmbzz,t.jcxmczy,t.jcxmczsj,t.sfyx,t.jcxmmcjc,t.jyjcxmlx,t.sfmulu,";
        sb += "(select count(t1.jyjcxmid) from jyjcxm t1 where t1.jcxmparentid = t.jyjcxmid "+") childnum ";
        sb += "FROM jyjcxm t ";
        sb += "WHERE 1=1 ) h left join ";
        sb +="(SELECT xmbz.jyjcxmid,group_concat(bz.bzbh) bzbh,group_concat(bz.jyjcjcbzbid) jyjcjcbzbid " +
                "FROM jyjcxmjcbz xmbz, jyjcjcbzb bz where  xmbz.jyjcjcbzbid=bz.jyjcjcbzbid " +
                "GROUP BY xmbz.jyjcxmid) a on h.jyjcxmid=a.jyjcxmid ";
        sb +="left join (SELECT xmff.jyjcxmid,group_concat(ff.jcffbzbh) jcffbzbh,group_concat(ff.jyjcffbzbid) jyjcffbzbid " +
                "FROM jyjcxmjcffbz xmff,jyjcffbzb ff where  xmff.jyjcffbzbid=ff.jyjcffbzbid " +
                "GROUP BY xmff.jyjcxmid) b on h.jyjcxmid=b.jyjcxmid ";
       // sb +="where  h.jyjcxmid=a.jyjcxmid and a.jyjcxmid=b.jyjcxmid";
        Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
                JyjcxmDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }

    /*
     *querySystcqZTree:抽检产品分类项目树的生成.
     * Written by wxy
     */
    public List querySystcqZTree(HttpServletRequest request) throws Exception {
        String sb = "";
        sb += "SELECT *";
        sb += "from parentchild a";
        sb += " where a.parentchildlb='choujiancpfl'";
        sb += " and a.sfyx='1' ";
        Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
                PubParentChild.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }

    /*
     *querySystcqJxmZTree:检测项目树的生成.
     * Written by wxy
     */
    public List querySystcqJxmZTree(HttpServletRequest request) throws Exception {
        String sb = "";
        sb += "SELECT *";
        sb += "from jyjcxm a";
        sb += " where 1=1";
        sb += " and a.sfyx='1' ";
        Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
                Jyjcxm.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }
    /**
     *
     * queryJyjcxmTree的中文名称：按easyui tree格式构造机构树
     *
     * queryJyjcxmTree的概要说明:
     *
     * @return Written by : wxy
     * @throws Exception
     *
     */
    public List queryJyjcxmTree(HttpServletRequest request,@Param("..") JyjcxmDTO dto) throws Exception {
        List resLs = new ArrayList();
        List ls = queryJyjcxmZTree(request, dto);
        for (int i = 0; i < ls.size(); i++) {
            JyjcxmDTO s = (JyjcxmDTO) ls.get(i);
            if (s.getJcxmparentid() == null || "".equals(s.getJcxmparentid())) {
                Map cm = new HashMap();
                cm.put("id", s.getJyjcxmid());
                cm.put("text", s.getJcxmmc());
                cm.put("children", getOrgChild(ls, s.getJyjcxmid().toString()));
                resLs.add(cm);
            }
        }
        return resLs;
    }
    private List getOrgChild(List ls, final String jcxmparentid) {
        List resLs = new ArrayList();
        for (int i = 0; i < ls.size(); i++) {
            JyjcxmDTO s = (JyjcxmDTO) ls.get(i);
            if (s.getJcxmparentid() != null
                    && jcxmparentid.equals(s.getJcxmparentid().toString())) {
                Map cm = new HashMap();
                cm.put("id", s.getJyjcxmid());
                cm.put("text", s.getJcxmmc());
                if (s.getChildnum() > 0) {
                    cm.put("children",
                            getOrgChild(ls, s.getJyjcxmid().toString()));
                }
                resLs.add(cm);

            }
        }
        return resLs;
    }
    /**
     *
     * saveJyjcxm2的中文名称：保存检验检测项目
     *
     * saveJyjcxm2的概要说明：
     *
     * @param dto
     * @return Written by : wxy
     *
     */
    public String saveJyjcxm2(HttpServletRequest request, final JyjcxmDTO dto) {
        try {
            String v_sql="";

            if (!Strings.isBlank(dto.getJyjcxmid())) {
                //判断级别编码是否存在
                v_sql="select jcxmbh from Jyjcxm where jcxmbh='"+dto.getJcxmbh()+"' and jyjcxmid<>'"+dto.getJyjcxmid()+"'";
                List<JyjcxmDTO> jyjcxm=(List<JyjcxmDTO>)DbUtils.getDataList(v_sql, JyjcxmDTO.class);
                if (jyjcxm!=null && jyjcxm.size()>0){
                    throw new BusinessException("检验检测项目编码已经存在");
                }
                //判断级别参数名称是否存在
                v_sql="select jcxmmc from Jyjcxm where jcxmmc='"+dto.getJcxmmc()+"' and jyjcxmid<>'"+dto.getJyjcxmid()+"'";
                List<JyjcxmDTO> jyjcxm2=(List<JyjcxmDTO>)DbUtils.getDataList(v_sql, JyjcxmDTO.class);
                if (jyjcxm2!=null && jyjcxm2.size()>0){
                    throw new BusinessException("检验检测项目名称已经存在");
                }
            }
            saveJyjcxm2Imp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop( { "trans" })
    public void saveJyjcxm2Imp(HttpServletRequest request, JyjcxmDTO dto) throws Exception {
        Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        // 特殊处理一级菜单的父菜单ID
        if ("0".equals(dto.getJcxmparentid())) {
            dto.setJcxmparentid(null);
        }
        if (Strings.isNotBlank(dto.getJyjcxmid())) {
            Jyjcxm jyjcxm = dao.fetch(Jyjcxm.class, dto.getJyjcxmid());
            BeanHelper.copyProperties(dto, jyjcxm);
            jyjcxm.setJcxmczy(sysuser.getUsername());
            jyjcxm.setJcxmczsj(datetime);
            dao.update(jyjcxm);
        } else {
            Jyjcxm jyjcxm = new Jyjcxm();
            String jyjcxmid = DbUtils.getSequenceStr();
            dto.setJyjcxmid(jyjcxmid);
            BeanHelper.copyProperties(dto, jyjcxm);
            jyjcxm.setJcxmczy(sysuser.getUsername());
            jyjcxm.setJcxmczsj(datetime);
            dao.insert(jyjcxm);
        }
        //增加检验检测项目和标准对照
        addJyjcxmjcbz(dto.getJyjcjcbzbid(),dto.getJyjcxmid(),sysuser,datetime);
        //增加检验检测项目和方法对照
        addJyjcxmjcffbz(dto.getJyjcffbzbid(),dto.getJyjcxmid(),sysuser,datetime);
    }
    public void addJyjcxmjcbz(String jyjcjcbzbid,String jyjcxmid,Sysuser sysuser,String datetime){
        if (!StringUtils.isEmpty(jyjcjcbzbid)){
            dao.clear(Jyjcxmjcbz.class,Cnd.where("jyjcxmid", "=", jyjcxmid));
            String[] v_jyjcjcbzbid=jyjcjcbzbid.split(",");
            String v_jyjcxmjcbzid ="";
            for (int i=0;i<v_jyjcjcbzbid.length;i++){
                Jyjcxmjcbz v_newJyjcxmjcbz=new Jyjcxmjcbz();
                v_jyjcxmjcbzid =DbUtils.getSequenceStr();
                v_newJyjcxmjcbz.setJyjcxmjcbzid(v_jyjcxmjcbzid);
                v_newJyjcxmjcbz.setJyjcxmid(jyjcxmid);
                v_newJyjcxmjcbz.setJyjcjcbzbid(v_jyjcjcbzbid[i]);
                v_newJyjcxmjcbz.setAae011(sysuser.getUsername());
                v_newJyjcxmjcbz.setAae036(datetime);
                dao.insert(v_newJyjcxmjcbz);
            }
        }
    }
    public void addJyjcxmjcffbz(String jyjcffbzbid,String jyjcxmid,Sysuser sysuser,String datetime){
        if (!StringUtils.isEmpty(jyjcffbzbid)){
            dao.clear(Jyjcxmjcffbz.class,Cnd.where("jyjcxmid", "=", jyjcxmid));
            String[] v_jyjcffbzbid=jyjcffbzbid.split(",");
            String v_jyjcxmjcffbzid ="";
            for (int i=0;i<v_jyjcffbzbid.length;i++){
                Jyjcxmjcffbz v_newJyjcxmjcffbz=new Jyjcxmjcffbz();
                v_jyjcxmjcffbzid =DbUtils.getSequenceStr();
                v_newJyjcxmjcffbz.setJyjcxmjcffbz(v_jyjcxmjcffbzid);
                v_newJyjcxmjcffbz.setJyjcxmid(jyjcxmid);
                v_newJyjcxmjcffbz.setJyjcffbzbid(v_jyjcffbzbid[i]);
                v_newJyjcxmjcffbz.setAae011(sysuser.getUsername());
                v_newJyjcxmjcffbz.setAae036(datetime);
                dao.insert(v_newJyjcxmjcffbz);
            }
        }
    }
    /**
     *
     * delJyjcxm2的中文名称：删除检验检测项目
     *
     * delJyjcxm2的概要说明：
     *
     * @param dto
     * @return Written by : wxy
     *
     */
    public String delJyjcxm2(final JyjcxmDTO dto) {
        try {
            if (!Strings.isBlank(dto.getJyjcxmid())) {
                // 检查是否可删除
                List jyjcxmList = null;
                jyjcxmList = dao.query(Jyjcxm.class, Cnd.where("jcxmparentid", "=", dto
                        .getJyjcxmid()));
                if (jyjcxmList != null && jyjcxmList.size() > 0) {
                    return "该分类下存在【" + jyjcxmList.size() + "】条项目，不能删除！";
                }
                delJyjcxm2Imp(dto);
            } else {
                return "没有接收到要删除的项目ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop( { "trans" })
    public void delJyjcxm2Imp(final JyjcxmDTO dto) {
        // 删除检验检测项目
        dao.clear(Jyjcxm.class, Cnd.where("jyjcxmid", "=", dto.getJyjcxmid()));
        //删除检验检测项目与标准对照表
        dao.clear(Jyjcxmjcbz.class,Cnd.where("jyjcxmid", "=", dto.getJyjcxmid()));
        //删除检验检测项目与方法对照表
        dao.clear(Jyjcxmjcffbz.class,Cnd.where("jyjcxmid", "=", dto.getJyjcxmid()));
    }
    /**
     *
     * saveJyjcxm的中文名称:保存检验检测项目
     *
     * saveJyjcxm的概要说明:
     *
     * @param request
     * @param dto
     * @return
     * Written by CatchU 2016年5月5日下午1:21:31
     */
    public String saveJyjcxm(HttpServletRequest request,final JyjcxmDTO dto) {
        try{
            saveJyjcxmImpl(request,dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * saveJyjcxmImpl的中文名称:保存检验检测实现方法
     *
     * saveJyjcxmImpl的概要说明:
     *
     * @param request
     * @param dto
     * @throws Exception
     * Written by CatchU 2016年5月5日下午1:45:02
     */
    @Aop({"trans"})
    private void saveJyjcxmImpl(HttpServletRequest request, JyjcxmDTO dto) throws Exception {
        //获得登录系统用户，即操作员姓名
        Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();

        //首先判断是更新还是添加
        if(dto.getJyjcxmid()!=null && !"".equals(dto.getJyjcxmid())){// 更新操作
            Jyjcxm jcxm = dao.fetch(Jyjcxm.class, dto.getJyjcxmid());
            String v_sql="select jcxmbh from Jyjcxm where jcxmbh='"+
                    dto.getJcxmbh() +"'";
            List jyj=DbUtils.getDataList(v_sql,null);
            //jyj的数据样式是：{[jyj=**]} 判断他是否和老的值一样 如果不一样 说明更新了数据 如果size>0则表示已经存在的编码
            if(jyj.size() > 0 && jyj.toString().split("=")[1].split("}")[0].equals(jcxm.getJcxmbh())==false){
                throw new BusinessException("该检测项目编码已经存在！");
            }
            //判断项目名称是否存在
            String vsql="select jcxmmc from Jyjcxm where jcxmmc='"+
                    dto.getJcxmmc() +"'";
            List jcxmmc=DbUtils.getDataList(vsql,null);
            if(jcxmmc.size() > 0 && jcxmmc.toString().split("=")[1].split("}")[0].equals(jcxm.getJcxmmc())==false){
                throw new BusinessException("该检测项目名称已经存在！");
            }
            jcxm.setJyjcxmid(dto.getJyjcxmid());  //修正id
            jcxm.setJcxmbh(dto.getJcxmbh());
            jcxm.setJcxmmc(dto.getJcxmmc());
            jcxm.setJcxmbzz(dto.getJcxmbzz());
            jcxm.setJcxmczy(sysuser.getUsername());
            jcxm.setJcxmczsj(datetime);
            dao.update(jcxm);
        }else{  //添加操作
            //判断项目编码是否存在
            String v_sql="select jcxmbh from Jyjcxm where jcxmbh='"+
                    dto.getJcxmbh() +"'";
            List jyj=DbUtils.getDataList(v_sql,Jyjcxm.class);
            if(jyj!=null && jyj.size() > 0){
                throw new BusinessException("该检测项目编码已经存在！");
            }
            //判断项目名称是否存在
            String vsql="select jcxmmc from Jyjcxm where jcxmmc='"+
                    dto.getJcxmmc() +"'";
            List jcxmmc=DbUtils.getDataList(vsql,Jyjcxm.class);
            if(jcxmmc!=null && jcxmmc.size() > 0){
                throw new BusinessException("该检测项目名称已经存在！");
            }
            String jcxmid = DbUtils.getSequenceStr();
            Jyjcxm jcxm = new Jyjcxm();
            BeanHelper.copyProperties(dto, jcxm);
            jcxm.setJyjcxmid(jcxmid);
            jcxm.setJcxmczy(sysuser.getUsername());
            jcxm.setJcxmczsj(datetime);
            dao.insert(jcxm);
        }
    }
    /**
     *
     * delJyjcxm的中文名称:删除检验检测项目
     *
     * delJyjcxm的概要说明:
     *
     * @param request
     * @param dto
     * @return
     * Written by CatchU 2016年5月5日下午1:22:04
     */
    public String delJyjcxm(HttpServletRequest request, JyjcxmDTO dto) {
        try{
            delJyjcxmImpl(request,dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * delJyjcxmImpl的中文名称:删除检验检测实现方法
     *
     * delJyjcxmImpl的概要说明:
     *
     * @param request
     * @param dto
     * Written by CatchU 2016年5月5日下午1:46:32
     */
    @Aop({"trans"})
    private void delJyjcxmImpl(HttpServletRequest request, JyjcxmDTO dto) {
        if(!(dto.getJyjcxmid() == null||"".equals(dto.getJyjcxmid()))){
            //删除信息
            dao.clear(Jyjcxm.class, Cnd.where("jyjcxmid", "=", dto.getJyjcxmid()));
        }
    }

    /************************检验检测项目end****************************/



    /************************检验检测样品start****************************/

    /**
     *
     * queryJyjcyp的中文名称:查询检验检测样品并分页
     *
     * queryJyjcyp的概要说明:
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * Written by CatchU 2016年5月5日下午1:32:38
     */
    @SuppressWarnings({ "rawtypes" })
    public Map queryJyjcyp(HttpServletRequest request,JyjcypDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        // 配合手机端接口使用
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        if (!"".equals(userid)) {
            vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
        } else {
            if (vSysUser == null) {
                throw new BusinessException("操作员id不能为空");
            }
        }
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select jcyp.*,");
        sb.append(" getAa10_aaa103('jcyplb', jcyp.jcyplb) jcyplbmc, "); // 商品类别名称
        sb.append(" getAa10_aaa103('jcypgl', jcyp.jcypgl) jcypglmc, "); // 商品归类名称
        sb.append(" getAa10_aaa103('spfenlei', jcyp.spfenlei) spfenleimc, "); // 商品分类名称
        sb.append(" (select t.fjpath from fj t where t.fjwid=jcyp.jcypid and fjtype='8' limit 1) as sppicpath  ");
        sb.append(" from jyjcyp jcyp");
        sb.append(" where 1=1");
        sb.append(" and jcyp.jcyplb = :jcyplb");
        sb.append(" and (jcyp.jcypmc like :jcypmc or jcyp.jcypjc like :jcypmc)");
        sb.append(" and jcyp.jcypczy = :jcypczy");
        sb.append(" and jcyp.jcypid = :jcypid");
        if (!StringUtils.isEmpty(dto.getSpsjlx())
                && ("1".equals(dto.getSpsjlx())||"2".equals(dto.getSpsjlx()))){
            sb.append(" and jcyp.spsjlx = '"+dto.getSpsjlx()+"'");
            sb.append(" and jcyp.hviewjgztid = '"+vSysUser.getAaz001()+"'");
        }
        //sb.append(" and jcyp.spsjlx = :spsjlx");
        sb.append(" order by jcypid desc");
        String sql = sb.toString();
        String[] paramName = new String[]{"jcyplb","jcypmc","jcypczy","jcypid","spsjlx"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,
                Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		/*List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));*/
        return SysmanageUtil.execAjaxResult(m, null);
    }

    /**
     *
     * saveJyjcyp的中文名称:保存检验检测样品
     *
     * saveJyjcyp的概要说明:
     *
     * @param request
     * @param dto
     * @return
     * Written by CatchU 2016年5月5日下午1:21:31
     */
    public String saveJyjcyp(HttpServletRequest request, JyjcypDTO dto) {
        try{
            saveJyjcypImpl(request,dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    /**
     *
     * saveJyjcypImpl的中文名称:保存商品实现方法
     *
     * saveJyjcypImpl的概要说明:
     *
     * @param request
     * @param dto
     * @throws Exception
     * Written by CatchU 2016年5月5日下午1:45:02 TODO
     */
    @SuppressWarnings("rawtypes")
    @Aop({"trans"})
    private void saveJyjcypImpl(HttpServletRequest request, JyjcypDTO dto) throws Exception {
        //获得登录系统用户，即操作员姓名
        Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
        // 配合手机端接口使用
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        if (!"".equals(userid)) {
            sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
        } else {
            if (sysuser == null) {
                throw new BusinessException("操作员id不能为空");
            }
        }
        //获取操作时间
        Timestamp datetime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
        //首先判断是更新还是添加
        if(dto.getJcypid()!=null && !"".equals(dto.getJcypid())){// 更新操作
            //商品名称不能重复
            //如果是产品或原材料需要区别判断
            String v_sql="";
            if ("1".equals(dto.getSpsjlx())||"2".equals(dto.getSpsjlx())){
                v_sql="select jcypmc from jyjcyp where jcypmc='"+
                        dto.getJcypmc() +"' and jcypid <>'"+dto.getJcypid()+
                        "' and hviewjgztid='"+sysuser.getAaz001()+"'";
            }else{
                v_sql="select jcypmc from jyjcyp where jcypmc='"+
                        dto.getJcypmc() +"' and jcypid <>'"+dto.getJcypid()+
                        "' and (hviewjgztid='' or hviewjgztid is null)";
            }


            List v_jyjcyplist=DbUtils.getDataList(v_sql,Jyjcyp.class);
            if (v_jyjcyplist!=null && v_jyjcyplist.size()>0){
                throw new BusinessException("该商品名称已经存在！");
            }

            Jyjcyp jcxm = dao.fetch(Jyjcyp.class, dto.getJcypid());
            BeanHelper.copyProperties(dto, jcxm);
            jcxm.setJcypjc(PinYinUtil.GetChineseSpell(dto.getJcypmc()));
            dao.update(jcxm);
        }else{  //添加操作
            //商品名称不能重复
            String v_sql="";

            if ("1".equals(dto.getSpsjlx())||"2".equals(dto.getSpsjlx())){
                v_sql="select jcypmc from jyjcyp where jcypmc='"+
                        dto.getJcypmc() +"'  and hviewjgztid='"+sysuser.getAaz001()+"'";
            }else{
                v_sql="select jcypmc from jyjcyp where jcypmc='"+
                        dto.getJcypmc() +"'  and (hviewjgztid='' or hviewjgztid is null)";
            }

            List v_jyjcyplist=DbUtils.getDataList(v_sql,Jyjcyp.class);
            if (v_jyjcyplist!=null && v_jyjcyplist.size()>0){
                throw new BusinessException("该商品名称已经存在！");
            }

            String jcxmid = DbUtils.getSequenceStr();
            Jyjcyp jcxm = new Jyjcyp();
            BeanHelper.copyProperties(dto, jcxm);
            jcxm.setJcypid(jcxmid);
            jcxm.setJcypczy(sysuser.getDescription());
            jcxm.setJcypczsj(datetime);
            //如果是 产品或原材料 写入主体信息表
            if ("1".equals(dto.getSpsjlx())||"2".equals(dto.getSpsjlx())){
                jcxm.setHviewjgztid(sysuser.getAaz001());
            };
            jcxm.setUserid(sysuser.getUserid());
            jcxm.setJcypjc(PinYinUtil.GetChineseSpell(dto.getJcypmc()));
            dao.insert(jcxm);

            //保存商品 图片
            FjDTO v_fjdto = new FjDTO();
            v_fjdto.setFjwid(jcxmid);
            v_fjdto.setFolderName("shangpin");

            v_fjdto.setFjpath(dto.getSppicpath());
            v_fjdto.setFjname(dto.getSppicname());
            v_fjdto.setFjtype("8");
            pubService.saveFjWuzhuti(request, v_fjdto);
        }
    }

    /**
     *
     * uploadJyjcypTp的中文名称：上传检验检测样品图片
     *
     * uploadJyjcypTp的概要说明：
     *
     * @param request
     * @return Written by : zy
     */
    public String uploadJyjcypTp(HttpServletRequest request) {
        try {
            uploadJyjcypTpImp(request);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * uploadJyjcypTpImp的中文名称：上传检验检测样品图片实现
     *
     * uploadJyjcypTpImp的概要说明：
     *
     * @param request
     * @throws Exception
     *             Written by : zy
     */
    @Aop( { "trans" })
    public void uploadJyjcypTpImp(HttpServletRequest request) throws Exception {
        // 上传文件路径
        String uploadPath = request.getSession().getServletContext()
                .getRealPath("/upload/jyjc");
        // 读取上传附件
        String fileName = null; // 文件名
        BufferedOutputStream outputStream = null;
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setHeaderEncoding("UTF-8");
                List<FileItem> items = upload.parseRequest(request);
                // 区分表单域
                for (int i = 0; i < items.size(); i++) {
                    FileItem fi = items.get(i);
                    // 获取文件名
                    fileName = fi.getName();
                    if (fileName != null) {
                        File savedFile = new File(uploadPath, fileName);
                        fi.write(savedFile);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (outputStream != null)
                        outputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    /**
     *
     * delJyjcyp的中文名称:删除检验检测样品
     *
     * delJyjcyp的概要说明:
     *
     * @param request
     * @param dto
     * @return
     * Written by CatchU 2016年5月5日下午1:22:04
     */
    public String delJyjcyp(HttpServletRequest request, JyjcypDTO dto) {
        try{
            delJyjcypImpl(request,dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * delJyjcypImpl的中文名称:删除检验检测样品实现方法
     *
     * delJyjcypImpl的概要说明:
     *
     * @param request
     * @param dto
     * Written by CatchU 2016年5月5日下午1:46:32
     * @throws Exception
     */
    @Aop({"trans"})
    private void delJyjcypImpl(HttpServletRequest request, JyjcypDTO dto) throws Exception {
        if(!(dto.getJcypid() == null||"".equals(dto.getJcypid()))){
            //删除图片
            pubService.delFjFromFjwid(request, dto.getJcypid());
            //删除信息
            dao.clear(Jyjcyp.class, Cnd.where("jcypid", "=", dto.getJcypid()));
        }
    }

    /************************检验检测样品end****************************/
    /************************检验检测结果start****************************/
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjcjg(JyjcjgDTO dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT j.jcjgid,j.jcypid,j.jcjylb,j.comid,j.jcxmid,Y.jcypmc,p.commc ,x.jcxmmc,j.jcxmbzz,j.imphl,j.fjjg,j.impjcjg,j.impjcsj,j.impjcry,j.jcjycljg,j.jcjyshbz  ");
        sb.append(" FROM jyjcjg j ,jyjcxm x,jyjcyp Y,pcompany p ");
        sb.append(" where 1=1");
        sb.append(" and j.jcypid=y.jcypid  AND j.jcxmid=x.jcxmid AND j.comid=p.comid");
        sb.append(" and j.comid = :comid");
        sb.append(" and j.impjcry like :impjcry");
        sb.append(" and j.jcjylb = :jcjylb");
        if(null != dto.getKssj() && "" != dto.getKssj()){
            sb.append(" and j.impjcsj >='"+dto.getKssj().toString()+"'");
        }
        if(null != dto.getJcjgid() && "" != dto.getJcjgid()){
            sb.append(" and j.jcjgid ='"+dto.getJcjgid()+"'");
        }
        if(null != dto.getJzsj() && "" != dto.getJzsj()){
            sb.append(" and j.impjcsj <'"+dto.getJzsj().toString()+"'");
        }
        if(null != dto.getJcypid() && "" != dto.getJcypid()){
            sb.append(" and Y.jcypid = '"+dto.getJcypid()+"'");
        }
        String sql = sb.toString();
        String[] paramName = new String[]{"comid","impjcry","jcjylb","jcjgid"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        System.out.println("kkkkkkkkkk  "+sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcjgDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
    /**
     *
     * delJyjcjg的中文名称：删除检验检测结果
     * delJyjcjg的概要描述：
     * @param request
     * @param dto
     * @return
     * Written by : lfy
     */
    public String delJyjcjg(HttpServletRequest request, JyjcjgDTO dto) {
        try{
            delJyjcjgImpl(request,dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * saveJyjcjg的中文名称：保存检验检测结果
     * saveJyjcjg的概要描述：
     * @param request
     * @param dto
     * @return
     * Written by : lfy
     */
    public String saveJyjcjg(HttpServletRequest request, JyjcjgDTO dto) {
        try {
            saveJyjcjgImpl(request,dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop({"trans"})
    private void saveJyjcjgImpl(HttpServletRequest request, JyjcjgDTO dto) throws Exception {
        //获得登录系统用户，即操作员姓名
        Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        //首先判断是更新还是添加
        if(dto.getJcjgid()!=null && !"".equals(dto.getJcjgid())){// 更新操作
            Jyjcjg jcjg = dao.fetch(Jyjcjg.class, dto.getJcjgid());
            jcjg.setJcjgid(dto.getJcjgid());//检查结果表ID.
            jcjg.setJcjylb(dto.getJcjylb());//检测检验类别
            jcjg.setJcypid(dto.getJcypid());//检测样品id
            jcjg.setJcxmid(dto.getJcxmid());//检测项目编号
            jcjg.setJcxmbzz(dto.getJcxmbzz());//标准值
            //jcjg.setJcjgz(dto.getJcjgz());//检测结果值
            jcjg.setImphl(dto.getImphl());//检测结果值
            //jcjg.setJyjcjl(dto.getJyjcjl());//检验检测结论
            jcjg.setImpjcjg(dto.getImpjcjg());//检验检测结论
            //jcjg.setJcrq(dto.getJcrq());//检测日期
            jcjg.setImpjcsj(dto.getImpjcsj());//检测日期
            //jcjg.setJyy(sysuser.getUsername());//检验员
            jcjg.setImpjcry(sysuser.getUsername());//检验员
            jcjg.setJcczsj(dto.getJcczsj());//检查操作时间
            jcjg.setFjjg(dto.getFjjg());//复检结果
            jcjg.setJcjyshbz(dto.getJcjyshbz());//jcjyshbz审核标志
            jcjg.setJcjycljg(dto.getJcjycljg());//检测检验处理结果
            jcjg.setComid(dto.getComid());//企业代码
            jcjg.setJcztbzjid("1");
            dao.update(jcjg);
        }else{  //添加操作
            String jcjgid = DbUtils.getSequenceStr();
            String v_impbatchno = DbUtils.getSequenceStr();
            Jyjcjg jyjg = new Jyjcjg();
            BeanHelper.copyProperties(dto, jyjg);
            jyjg.setImpjcry(sysuser.getUsername());//检验员
            jyjg.setImpjcjg(dto.getImpjcjg());
            jyjg.setJcypid(dto.getJcypid());
            jyjg.setJcjgid(jcjgid);//主键
            jyjg.setJcczsj(datetime);//操作时间
            jyjg.setJcjyshbz("0");//审核标志
            jyjg.setJcztbzjid("1");//暂时无用
            jyjg.setJcjycljg(dto.getJcjycljg());
            jyjg.setImpbatchno(v_impbatchno);
            dao.insert(jyjg);
        }
    }
    private void delJyjcjgImpl(HttpServletRequest request, JyjcjgDTO dto) {
        if(!(dto.getJcjgid() == null||"".equals(dto.getJcjgid()))){
            //删除信息
            dao.clear(Jyjcjg.class, Cnd.where("jcjgid", "=", dto.getJcjgid()));
        }
    }

    /************************检验检测统计图表start****************************/
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjctjtb(HttpServletRequest request, JyjctjtbDTO dto) throws Exception {
        //如果统计时未输入开始时间和结束时间，则系统默认统计半年内的合格率
        Format f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar c = Calendar.getInstance();
        String dqsj = f.format(c.getTime());
        System.out.println("当前时间:" + dqsj);
        c.add(Calendar.MONTH, -6);
        String bnqsj = f.format(c.getTime());
        System.out.println("半年前时间:" + bnqsj);

        //拼接查询语句
        //hgl合格率,jyjcsc时长（包括月报表、季报表）,bzzTotal标准值合计,jgzTotal结果值合计
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT SUM(a.imphl)/SUM(a.jcxmbzz) hgl,SUM(a.jcxmbzz) bzzTotal,SUM(a.imphl) jgzTotal,month(a.impjcsj) jyjcsc FROM ");
        sb.append(" (select SUBSTRING(jcxmbzz,2) jcxmbzz,imphl,impjcsj,jcjylb FROM jyjcjg j WHERE imphl < jcxmbzz) a ");
        sb.append(" WHERE 1=1 ");
        if(null != dto.getJcjylb() && "" !=dto.getJcjylb()){
            sb.append(" and a.jcjylb=:jcjylb ");
        }

        if(null != dto.getStartTime() && "" !=dto.getStartTime()){
            sb.append(" and a.impjcsj >=:startTime ");
        }else{
            sb.append(" and a.impjcsj >='"+bnqsj+"'");
        }

        if(null != dto.getEndTime() && "" != dto.getEndTime()){
            sb.append(" and a.impjcsj <=:endTime ");
        }else{
            sb.append(" and a.impjcsj <= '"+dqsj+"'");
        }
        sb.append(" GROUP BY month(a.impjcsj) ");
        String sql = sb.toString();
        String[] paramName = new String[]{"jcjylb","startTime","endTime"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjctjtbDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
    /************************检验检测统计图表end****************************/
    /************************检验检测统计分析start****************************/
    /**
     *
     *  queryJyjctjfx的中文名称：查询统计分析
     *  queryJyjctjfx的概要说明：
     *  @param dto
     *  @param pd
     *  @return
     *  @throws Exception
     *  Written by:ly
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjctjfx(JyjctjfxDTO dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT yp.jcypmc ypmc,xm.jcxmmc, ");
        sb.append("  SUM(case WHEN jg.impjcjg='1' then 1 else 0 end ) hgcs,");
        sb.append(" SUM(case WHEN jg.impjcjg='2' then 1 else 0 end ) cbcs, ");
        sb.append("  COUNT(1) jccs ,concat(FORMAT( SUM(case WHEN jg.impjcjg='1' then 1 else 0 end )/COUNT(1)*100,0),'%') hgl , " );
        sb.append(" concat(FORMAT( SUM(case WHEN jg.impjcjg='2' then 1 else 0 end )/COUNT(1)*100,0),'%') cbl  " );
        sb.append(" FROM jyjcjg jg ,jyjcxm xm,jyjcyp yp WHERE 1=1  AND jg.jcczsj> :kssj AND jg.jcczsj < :jssj  ");
        sb.append(" AND jg.comid=:comid AND jg.jcypid=yp.jcypid AND jg.jcxmid=xm.jcxmid " );
        sb.append(" GROUP BY  "+ dto.getJcjylb());
        String sql = sb.toString();
        String[] paramName = new String[]{"jcjylb","comid","kssj","jssj"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjctjfxDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /************************检验检测企业信息分析start****************************/
    /**
     * 查询出检验检测企业信息，并分页显示
     * @param dto 企业实体类
     * @param pd 分页
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjcCompany(HttpServletRequest request,PcompanyDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
        dto.setAaa027(vSysUser.getAaa027());
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select pcom.comid, pcom.comdm,pcom.commc, fj.comfjfile, fj.comfjpath ");
        sb.append(" from pcompany pcom left join pcompanyfj fj ");
        sb.append("  on pcom.comdm = fj.comdm ");
        sb.append(" where 1=1 ");
        sb.append(" and pcom.commc like :commc ");
        sb.append(" and pcom.aaa027 = :aaa027 ");
        sb.append(" order by comdzcsj desc ");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{ "commc","aaa027"};
        int[] paramType = new int[]{ Types.VARCHAR,Types.VARCHAR };
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto,pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        // 判断应用服务器上是否存在附件副本
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                PcompanyDTO pdto = (PcompanyDTO) list.get(i);
                String rootPath = request.getSession().getServletContext()
                        .getRealPath("/");
                String fjpath = rootPath + File.separator + pdto.getComfjpath();
                if (!FileUtil.checkFile(fjpath)) {
                    String fjcontent = pdto.getComfjfile();
                    if (!Strings.isBlank(fjcontent)) {
                        byte b[] = Base64.base64ToByteArray(fjcontent);
                        File file = new File(fjpath);
                        FileOutputStream fos = new FileOutputStream(file);
                        fos.write(b);
                        fos.close();
                    }
                }
            }
        }
        return map;
    }
    /************************检验检测企业信息分析end
     * @throws Exception ****************************/
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjccydj(JyjccydjDTO dto,PagesDTO pd) throws Exception{
        StringBuffer sb=new StringBuffer();
        sb.append(" SELECT jc.cydjid,jc.cybh,jc.cyfl,jc.bcydwcomid,jc.bcydw,jc.bcydwfl,jc.bcydwdz,  ");
        sb.append(" jc.tel,jc.ypbh,jc.ypmc,jc.countcy,jc.scdwcomid,jc.scdw,jc.cyjsr,jc.cysj, ");
        sb.append(" jc.aae036,jc.aae011 FROM jyjccydj jc WHERE 1=1   ");
        sb.append(" AND jc.bcydw=:bcydw ");
        sb.append(" AND jc.cybh=:cybh ");
        sb.append(" AND jc.cydjid=:cydjid "	);
        String sql = sb.toString();
        String[] paramName = new String[]{"bcydw","cybh","cydjid"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjccydjDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
    public String saveJyjccydj(HttpServletRequest request,@Param("..") JyjccydjDTO dto){
        String id=null;
        try {
            id= saveJyjccydjImpl(request,dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return id;
    }
    @Aop({"trans"})
    public String saveJyjccydjImpl(HttpServletRequest request,@Param("..") JyjccydjDTO dto) throws Exception{
        if("".equals(dto.getCysj())){
            dto.setCysj(null);
        }
        if(dto.getCydjid()!=null && !"".equals(dto.getCydjid())){
            Jyjccydj cydj=dao.fetch(Jyjccydj.class, dto.getCydjid());
            BeanHelper.copyProperties(dto, cydj);
            if("2".equals(dto.getQyyyrz())){
                //q企业异议日志
                Sysoperatelog v_newSysoperatelog=new Sysoperatelog();
                v_newSysoperatelog.setUrl(dto.getCydjid());
                v_newSysoperatelog.setDescription("企业异议");
                SysmanageUtil.g_writeSysoperatelog(request,v_newSysoperatelog);
            }
            dao.update(cydj);
            return dto.getCydjid();
        }else{
            Jyjccydj cy=new Jyjccydj();
            Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
            String id = DbUtils.getSequenceStr();
            String tim=SysmanageUtil.getDbtimeYmd();
            BeanHelper.copyProperties(dto, cy);
            cy.setCydjid(id);//主键
            cy.setAae036(tim);
            cy.setAae011(vSysUser.getDescription());
            dao.insert(cy);
            //写日志
            Sysoperatelog v_newSysoperatelog=new Sysoperatelog();
            v_newSysoperatelog.setUrl(id);
            v_newSysoperatelog.setDescription("抽样登记新增");
            SysmanageUtil.g_writeSysoperatelog(request,v_newSysoperatelog);
            return id;
        }
    }
    @Aop({"trans"})
    public String deljyjccydj(String id){
        try {
            dao.delete(Jyjccydj.class, id);
            dao.clear(Jyjccybgxmb.class, Cnd.where("cydjid", "=", id));
            dao.clear(Jyjccybgb.class, Cnd.where("cydjid", "=", id));
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }


    /**
     *
     *  checkJyjcUpLoadXls的中文名称：检验检测信息导入上传验证
     *
     *  checkJyjcUpLoadXls的概要说明：
     *
     *  @param request
     *  @param vali
     *  @param dto
     *  @return
     *  @throws Exception
     *  Written  by  : gjf
     *
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ValidateData checkJyjcUpLoadXls(HttpServletRequest request, ValidateData vali, JyjcjgDTO dto) throws Exception {
        // 处理正确数据
        if (vali.getCorrectData().size() > 0) {
            int i = 0;
            // 遍历文件记录
            while ((!vali.getCorrectData().isEmpty()) && i < vali.getCorrectData().size()) {
                final JyjcjgDTO wdto = (JyjcjgDTO) vali.getCorrectData().get(i);
                // 校验代码
                BeanHelper.copyProperties(wdto, dto);
                String errorMsg ="";//gu20161020暂不检测 //isExistsPc(dto);
                if (errorMsg != null) {
                    ValidateData.ErrorItem item = new ValidateData.ErrorItem();
                    item.setErrorData(wdto);
                    item.addErrorMsg("commc", errorMsg);
                    vali.addErrorItem(item);
                    vali.getCorrectData().remove(i);// 移除不匹配的记录
//				} else {
//					i++;
                    // 校验是否有重复记录
//					for (int j = i; j < vali.getCorrectData().size(); j++) {
//						final PcompanyDTO wdto2 = (PcompanyDTO) vali.getCorrectData().get(j);
//						if (wdto2.getComfrsfzh().equals(wdto.getComfrsfzh())) {
//							throw new BusinessException("上传文件记录中存在重复的企业信息，重复的企业名称为【" + wdto2.getCommc() + "】");
//						}
//					}
                }
            }
        }

        // 处理错误数据
        if (vali.getErrData().size() > 0) {
            final List errorList = new ArrayList();
            for (final Iterator it = vali.getErrData().iterator(); it.hasNext();) {
                final ValidateData.ErrorItem itm = (ValidateData.ErrorItem) it.next();
                final JyjcjgDTO wdto = (JyjcjgDTO) itm.getErrorData();
                //wdto.setMessage(itm.getErrs() != null ? itm.getErrs().values().toString() : null);
                errorList.add(wdto);
            }
            vali.setErrData(errorList);
        }
        return vali;
    }

    /**
     *
     * @param request    检验检测上传数据的保存
     * @return
     */
    public String saveJyjcUploadExcel(HttpServletRequest request, JyjcjgDTO prm_dto) {
        try {
            saveJyjcUploadExcelImp(request, prm_dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @SuppressWarnings({"unchecked" })
    @Aop( { "trans" })
    public void saveJyjcUploadExcelImp(HttpServletRequest request, JyjcjgDTO prm_dto) throws Exception {
//		Timestamp startTime = SysmanageUtil.currentTime();
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        if (prm_dto.getSuccJyjcUploadExcelJsonStr()==null || "".equals(prm_dto.getSuccJyjcUploadExcelJsonStr())){
            throw new BusinessException("没有获取到上传的数据信息");
        }
        //根据userid获取comid
        String v_sql="select comid from pcompany a where a.comdm=(select b.username from sysuser b where b.userid='"+vSysUser.getUserid()+"')";
        List<Pcompany> v_pcomlist=(List<Pcompany>)DbUtils.getDataList(v_sql, Pcompany.class);
        Pcompany v_pcompany=null;
        if (v_pcomlist==null ||v_pcomlist.size()==0){
            throw new BusinessException("根据操作员信息没有获取到企业信息");
        }else{
            v_pcompany=(Pcompany)v_pcomlist.get(0);
        }
        List<JyjcjgDTO> lst = Json.fromJsonAsList(JyjcjgDTO.class, prm_dto.getSuccJyjcUploadExcelJsonStr());
        String v_impbatchno = DbUtils.getSequenceStr();
        String v_impczsj = SysmanageUtil.getDbtimeYmdHns();
        //插入主表
        if (lst.size()>0){
            Jyjcjgmain v_Jyjcjgmain=new Jyjcjgmain();
            v_Jyjcjgmain.setImpbatchno(v_impbatchno);
            v_Jyjcjgmain.setUserid(vSysUser.getUserid());
            v_Jyjcjgmain.setImpczy(vSysUser.getDescription());
            v_Jyjcjgmain.setImpczsj(v_impczsj);
            v_Jyjcjgmain.setComid(v_pcompany.getComid());
            dao.insert(v_Jyjcjgmain);
        }

        for (int i = 0; i < lst.size(); i++) {
            // 插入企业
            JyjcjgDTO dto = (JyjcjgDTO) lst.get(i);
            Jyjcjg v_Jyjcjg = new Jyjcjg();
            BeanHelper.copyProperties(dto, v_Jyjcjg);

            String v_jcjgid = DbUtils.getSequenceStr();
            v_Jyjcjg.setJcjgid(v_jcjgid);
            v_Jyjcjg.setImpbatchno(v_impbatchno);
//			v_Jyjcjg.setImpczy(vSysUser.getDescription());
//			v_Jyjcjg.setImpczsj(v_impczsj);
//			v_Jyjcjg.setUserid(vSysUser.getUserid());
//			v_Jyjcjg.setComid(v_pcompany.getComid());
            dao.insert(v_Jyjcjg);
        }
    }

    /**
     * queryJyjcUploadData 查询出上传的检验检测数据，并分页显示
     *
     * @param dto 企业实体类
     * @param pd 分页
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjcUploadData(HttpServletRequest request, JyjcjgDTO dto, PagesDTO pd) throws Exception {
//		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*  ");
        sb.append(" from Jyjcjg a  ");
        sb.append(" where 1=1 ");
        //sb.append(" and a.userid = '"+vSysUser.getUserid()+"' ");
        //sb.append(" and a.impczsj >= :startimpczsj ");
        //sb.append(" and a.impczsj <= :endimpczsj ");
        sb.append(" and a.impbatchno <= :impbatchno ");
        sb.append(" order by a.jcjgid asc");

        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] { "impbatchno"};
        int[] paramType = new int[] { Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcjgDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }




    /**
     *
     *  checkUpLoadXls的中文名称：抽样登记信息导入上传验证
     *
     *  checkUpLoadXls的概要说明：
     *
     *  @param request
     *  @param vali
     *  @param dto
     *  @return
     *  @throws Exception
     *  Written  by  : ly
     *
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ValidateData checkUpLoadXls(HttpServletRequest request, ValidateData vali, JyjccydjDTO dto) throws Exception {
        // 处理正确数据
        if (vali.getCorrectData().size() > 0) {
            int i = 0;
            // 遍历文件记录
            while ((!vali.getCorrectData().isEmpty()) && i < vali.getCorrectData().size()) {
                final JyjccydjDTO wdto = (JyjccydjDTO) vali.getCorrectData().get(i);
                // 校验代码
                BeanHelper.copyProperties(wdto, dto);
                String errorMsg = isExistsPc(dto);
                if (errorMsg != null) {
                    ValidateData.ErrorItem item = new ValidateData.ErrorItem();
                    item.setErrorData(wdto);
                    item.addErrorMsg("jyjc", errorMsg);
                    vali.addErrorItem(item);
                    vali.getCorrectData().remove(i);// 移除不匹配的记录
                } else {
                    i++;
                    // 校验是否有重复记录
//					for (int j = i; j < vali.getCorrectData().size(); j++) {
//						final PcompanyDTO wdto2 = (PcompanyDTO) vali.getCorrectData().get(j);
//						if (wdto2.getComfrsfzh().equals(wdto.getComfrsfzh())) {
//							throw new BusinessException("上传文件记录中存在重复的企业信息，重复的企业名称为【" + wdto2.getCommc() + "】");
//						}
//					}
                }
            }
        }

        // 处理错误数据
        if (vali.getErrData().size() > 0) {
            final List errorList = new ArrayList();
            for (final Iterator it = vali.getErrData().iterator(); it.hasNext();) {
                final ValidateData.ErrorItem itm = (ValidateData.ErrorItem) it.next();
                final JyjccydjDTO wdto = (JyjccydjDTO) itm.getErrorData();
                //wdto.setMessage(itm.getErrs() != null ? itm.getErrs().values().toString() : null);
                errorList.add(wdto);
            }
            vali.setErrData(errorList);
        }
        return vali;
    }
    /**
     *  校验企业信息编号是否已经存在   保证维一性
     * @param dto
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes"})
    public String isExistsPc(JyjccydjDTO dto) throws Exception {
        // 校验抽样编号是否已经存在
        PagesDTO pd = new PagesDTO();
//		JyjccydjDTO cydj = new JyjccydjDTO();
//		PcompanyDTO.setCommc(dto.getCommc());//企业名称
//		PcompanyDTO.setComdalei(dto.getComdalei()); // 企业大类
//		PcompanyDTO.setComxkzbh(dto.getComxkzbh()); // 许可证编号
        Map m = queryJyjccydj(dto,pd);
        List ls = (List) m.get("rows");
        if (ls != null && ls.size() > 0) {
            JyjccydjDTO pdto = (JyjccydjDTO) ls.get(0);
            final StringBuffer sb = new StringBuffer();
            sb.append("您登记的抽样信息：抽样编号【");
            sb.append(pdto.getCybh());
            sb.append(" 】已登记过，请勿重复登记！");
            return sb.toString();
        }
        return null;
    }
    /**
     * savecydjdr  ：保存抽样登记导入
     * @param request
     * @param succJsonStr
     * @return
     */
    public String savecydjdr(HttpServletRequest request, String succJsonStr) {
        try {
            savecydjdrImp(request, succJsonStr);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop( { "trans" })
    public void savecydjdrImp(HttpServletRequest request, String succJsonStr) throws Exception{
        List<JyjccydjDTO> lst = Json.fromJsonAsList(JyjccydjDTO.class, succJsonStr);
        for (int i = 0; i < lst.size(); i++) {
            // 插入企业
            JyjccydjDTO dto = (JyjccydjDTO) lst.get(i);
            Jyjccydj jyjc = new Jyjccydj();
            BeanHelper.copyProperties(dto, jyjc);
            //根据企业名称 判断企业是否存在
//			Sql sql = Sqls.create("SELECT * FROM jyjccydj  WHERE cybh="+dto.getCybh());
//			sql.setCallback(Sqls.callback.entities());
//			sql.setEntity(dao.getEntity(JyjccydjDTO.class));
//			dao.execute(sql);
//			List<JyjccydjDTO> v_jyjclist = sql.getList(JyjccydjDTO.class);

            List<Jyjccydj> v_jyjclist = dao.query(Jyjccydj.class, Cnd.where("cybh", "=", dto.getCybh()));
            // 如果抽样信息不存在，插入
            if (v_jyjclist == null || v_jyjclist.size() == 0) {
                // saveJyjccydj(request,dto);
                Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
                jyjc.setAae036(SysmanageUtil.getDbtimeYmd());
                jyjc.setAae011(vSysUser.getUsername());
                jyjc.setCydjid(DbUtils.getSequenceStr());
                dao.insert(jyjc);
            } else {
                Jyjccydj cydj= new Jyjccydj();
                cydj = v_jyjclist.get(0);
                BeanHelper.copyProperties(dto, cydj);
                dao.update(cydj);
            }
        }
    }

    /**
     * queryJyjcUploadData 查询出上传的检验检测数据，并分页显示
     *
     * @param dto 企业实体类
     * @param pd 分页
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjcUploadDataMain(HttpServletRequest request, JyjcjgDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from Jyjcjgmain a  ");
        sb.append(" where 1=1 ");
        sb.append(" and a.userid = '"+vSysUser.getUserid()+"' ");
        sb.append(" and a.impczsj >= :startimpczsj ");
        sb.append(" and a.impczsj <= :endimpczsj ");
        sb.append(" order by a.impbatchno asc");

        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] { "startimpczsj", "endimpczsj"};
        int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcjgDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryJyjcUploadData 查询出上传的检验检测数据，并分页显示
     *
     * @param dto 企业实体类
     * @param pd 分页
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryJyjcUploadCom(HttpServletRequest request, JyjcjgDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" Select b.impbatchno,a.comid,a.commc,a.comdz,a.comfrhyz,a.comfzr,a.comgddh,a.comyddh ");
        sb.append(" FROM pcompany a,jyjcjgmain b  ");
        sb.append(" where a.comid=b.comid ");
        sb.append(" and a.comid=:comid ");
        sb.append(" and b.impczsj >= :startimpczsj ");
        sb.append(" and b.impczsj <= :endimpczsj ");
        sb.append(" order by a.comid,b.impbatchno ");

        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {"comid","startimpczsj", "endimpczsj"};
        int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcjgDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
    /**
     * queryjcxm : 查出检验检测抽样检测项目
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryjcxm(HttpServletRequest request ,JyjccybgxmbDTO dto,PagesDTO pd) throws Exception{
        StringBuffer sb= new StringBuffer();
        sb.append(" SELECT * FROM jyjccybgxmb j WHERE 1=1 ");
        sb.append(" AND  j.cydjid= :cydjid ");
        String sql = sb.toString();
        String[] paramName = new String[] {"cydjid"};
        int[] paramType = new int[] { Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjccybgxmbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
    /**
     * savejcxm : 保存检验检测项目
     * @param succJsonStr
     * @param cydjid
     * @return
     * @written by: ly
     */
    public String savejcxm(String succJsonStr, String cydjid){
        try{
            savexmImpl(succJsonStr,cydjid);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    /**
     * savexmImpl : 有事物控制实现检验检测保存
     * @param succJsonStr
     * @param cydjid
     * @throws Exception
     */
    @Aop({"trans"})
    public void savexmImpl(String succJsonStr, String cydjid) throws Exception{
        if("".equals(cydjid)){
            throw new BusinessException("抽样登记ID不能为空！");
        }
        List<Jyjccybgxmb> lst = Json.fromJsonAsList(Jyjccybgxmb.class, succJsonStr);//解析json数据为对象
        for(int i=0;i<lst.size();i++){
            Jyjccybgxmb xmb =lst.get(i);//获取相应的第i条对象
            if(StringUtils.isEmpty(xmb.getDw())&&
                    StringUtils.isEmpty(xmb.getJxjcxmmc())&&
                    StringUtils.isEmpty(xmb.getBzz())){
                continue;
            }
            if("".equals(xmb.getJyjcbgxmid())||xmb.getJyjcbgxmid() == null){
                Jyjccybgxmb xmbx = new Jyjccybgxmb();
                BeanHelper.copyProperties(xmb, xmbx);
                xmbx.setJyjcbgxmid(DbUtils.getSequenceStr()); //id
                xmbx.setAae011(SysmanageUtil.getSysuser().getUsername());//用户名称
                xmbx.setAae036(SysmanageUtil.getDbtimeYmd());//日期
                xmbx.setCydjid(cydjid);//抽样id
                dao.insert(xmbx);
            }else{
                Jyjccybgxmb xmbs=dao.fetch(Jyjccybgxmb.class,Cnd.where("jyjcbgxmid", "=", xmb.getJyjcbgxmid()));
                BeanHelper.copyProperties(xmb, xmbs);
                xmbs.setAae011(SysmanageUtil.getSysuser().getUsername());//用户名称
                xmbs.setAae036(SysmanageUtil.getDbtimeYmd());//日期
                xmbs.setCydjid(cydjid);//抽样id
                dao.update(xmbs);
            }
        }
    }
    /**
     * deljyjcxm 删除检验检测项目
     * @param dto
     * @return
     *  Written by : ly
     */
    public String deljcxm(JyjccybgxmbDTO dto) {
        try{
            deljcxmImpl(dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    /**
     * deljyjcxmImpl 删除数据
     *  Written by : ly
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @Aop({"trans"})
    public void deljcxmImpl(JyjccybgxmbDTO dto) throws Exception{
        if(dto.getJyjcbgxmid() != null && !"".equals(dto.getJyjcbgxmid())){
            String sql="SELECT j.jyjcbgxmid,j.bgid FROM jyjccybgxmb j1, jyjccybgxmb j WHERE j.bgid=j1.bgid AND j.jyjcbgxmid=:jyjcbgxmid";
            String[] paramName = new String[] {"jyjcbgxmid"};
            int[] paramType = new int[] { Types.VARCHAR};
            sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
            Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjccybgxmbDTO.class );
            List list = (List) m.get(GlobalNames.SI_RESULTSET);
            if(list.size() == 1){
                JyjccybgxmbDTO xmb = (JyjccybgxmbDTO)list.get(0);
                Sql sql1 = Sqls.create("DELETE FROM jyjccybgb WHERE bgid="+xmb.getBgid());
                dao.execute(sql1);
            }
            dao.clear(Jyjccybgxmb.class,Cnd.where("jyjcbgxmid", "=", dto.getJyjcbgxmid()));
        }
    }
    /**
     * querybg : 查询检查报告
     * @param dto
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map querybg(JyjccybgbDTO dto) throws Exception{
        String sql="SELECT * FROM jyjccybgb j WHERE 1=1 AND j.cydjid= :cydjid ";
        String[] paramName = new String[] {"cydjid"};
        int[] paramType = new int[] { Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto );
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjccybgbDTO.class );
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     *
     * checkUpLoadJyjcXls
     *
     * checkUpLoadJyjcXls
     * @param vali
     * @param dto
     * @return
     * @throws Exception
     *        Written by : zy
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ValidateData checkUpLoadJyjcXls(ValidateData vali, JyjccybgDTO dto) throws Exception {
        if (vali.getCorrectData().size() > 0) {
            int i = 0;
            while ((!vali.getCorrectData().isEmpty()) && i < vali.getCorrectData().size()) {
                final JyjccybgDTO wdto = (JyjccybgDTO) vali.getCorrectData().get(i);
                String errorMsg = isJyjcbgExists(wdto);
                if (errorMsg != null) {
                    ValidateData.ErrorItem item = new ValidateData.ErrorItem();
                    item.setErrorData(wdto);
                    item.addErrorMsg("jyjc", errorMsg);
                    vali.addErrorItem(item);
                    vali.getCorrectData().remove(i);
                } else {
                    i++;
                }
            }
        }

        if (vali.getErrData().size() > 0) {
            final List errorList = new ArrayList();
            for (final Iterator it = vali.getErrData().iterator(); it.hasNext();) {
                final ValidateData.ErrorItem itm = (ValidateData.ErrorItem) it.next();
                final JyjccybgDTO wdto = (JyjccybgDTO) itm.getErrorData();
                wdto.setMessage(itm.getErrs() != null ? itm.getErrs().values().toString() : null);
                errorList.add(wdto);
            }
            vali.setErrData(errorList);
        }
        return vali;
    }
    /**
     *  savejcbg :
     * @param dto
     * @return
     */
    public String savejcbg(HttpServletRequest request,JyjccybgbDTO dto){
        try{
            savejcbgImpl(request,dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    /**
     * savejcbgImpl ：保存检验检测报告有事物控制实现
     * @param dto
     * @throws Exception
     */
    @Aop({"trans"})
    public void savejcbgImpl(HttpServletRequest request,JyjccybgbDTO dto) throws Exception{
        //多条检查项出一张报告
        if(dto.getCydjid() == null||"".equals(dto.getCydjid())){
            throw new BusinessException("抽样登记ID不能为空！");
        }
        if("".equals(dto.getBgsdrq())){//报告送达日期
            dto.setBgsdrq(null);
        }
        if("".equals(dto.getJsbgrq())){//收到报告日期
            dto.setJsbgrq(null);
        }
        if("".equals(dto.getJcrqjs())){//检测日期结束
            dto.setJcrqjs(null);
        }
        if("".equals(dto.getJcrqks())){//检测日期开始
            dto.setJcrqks(null);
        }
        if(dto.getBgid() == null || "".equals(dto.getBgid())){
            Jyjccybgb bg = new Jyjccybgb();
            BeanHelper.copyProperties(dto, bg);
            String id = DbUtils.getSequenceStr();
            bg.setAae011(SysmanageUtil.getSysuser().getUsername());
            bg.setAae036(SysmanageUtil.getDbtimeYmd());
            bg.setBgid(id);
            dao.insert(bg);
            //如果是新插入的报告要把报告ID更新到 所有 检查项目表
            List<Jyjccybgxmb> xm = dao.query(Jyjccybgxmb.class, Cnd.where("cydjid","=",dto.getCydjid()));
            if(xm != null && xm.size()>0){
                for(int i=0;i < xm.size();i++){
                    Jyjccybgxmb xmb = xm.get(i);
                    xmb.setBgid(id);
                    dao.update(xmb);
                }
            }
            //写日志
            Sysoperatelog v_newSysoperatelog=new Sysoperatelog();
            v_newSysoperatelog.setUrl(dto.getCydjid());
            v_newSysoperatelog.setDescription("抽样单新增");
            SysmanageUtil.g_writeSysoperatelog(request,v_newSysoperatelog);
        }else{
            Jyjccybgb bgb = dao.fetch(Jyjccybgb.class, Cnd.where("bgid","=",dto.getBgid()));
            BeanHelper.copyProperties(dto, bgb);
            bgb.setAae011(SysmanageUtil.getSysuser().getUsername());
            bgb.setAae036(SysmanageUtil.getDbtimeYmd());
            dao.update(bgb);
        }
    }

    /**
     *
     * isJyjccydjExists
     *
     * isJyjccydjExists
     * @param dto
     * @return
     * @throws Exception
     *        Written by : zy
     */
    @SuppressWarnings({ "rawtypes"})
    public String isJyjcbgExists(JyjccybgDTO dto) throws Exception {
        List ls = queryJyjcbg(dto);
        if (ls == null || ls.size() == 0) {
            final StringBuffer sb = new StringBuffer();
            sb.append("您登记的抽样报告信息：抽样编号【");
            sb.append(dto.getCybh());
            sb.append("】还未进行登记，请先进行登记！");
            return sb.toString();
        } else {
            JyjccybgDTO pdto = (JyjccybgDTO) ls.get(0);
            if (pdto.getBgbh() != null && !pdto.getBgbh().equals(dto.getBgbh())) {
                final StringBuffer sb = new StringBuffer();
                sb.append("您登记的抽样报告信息：报告编号【");
                sb.append(pdto.getBgbh());
                sb.append("】有误，请核对后再进行登记！");
                return sb.toString();
            }
        }
        return null;
    }

    /**
     *
     * queryJyjcbg
     *
     * queryJyjcbg
     * @param dto
     * @return
     * @throws Exception
     *        Written by : zy
     */
    @SuppressWarnings({ "rawtypes" })
    public List queryJyjcbg(JyjccybgDTO dto) throws Exception{
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.cybh, a.bcydw, a.bcydwdz, a.scdw, a.ypmc, a.countcy, ");
        sb.append(" b.bgbh, b.jsbgrq, b.bgsdrq, b.lah, b.jcdwmc  ");
        sb.append(" FROM jyjccydj a LEFT JOIN jyjccybgb b ON a.cydjid = b.cydjid ");
        sb.append(" WHERE 1=1 ");
        sb.append(" AND a.cybh =:cybh ");
        String sql = sb.toString();
        String[] paramName = new String[]{ "cybh" };
        int[] paramType = new int[]{ Types.VARCHAR };
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjccybgDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        return list;
    }

    /**
     * saveJyjcbgDr
     * saveJyjcbgDr
     * @param request
     * @param succJsonStr
     * @return
     *        Written by : zy
     */
    public String saveJyjcbgDr(HttpServletRequest request, String succJsonStr) {
        try {
            saveJyjcbgDrImp(request, succJsonStr);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * saveJyjcbgDrImp
     * saveJyjcbgDrImp
     * @param request
     * @param succJsonStr
     * @throws Exception
     *        Written by : zy
     */
    @Aop({"trans"})
    public void saveJyjcbgDrImp(HttpServletRequest request, String succJsonStr) throws Exception{
        Sysuser v_user = SysmanageUtil.getSysuser();
        List<JyjccybgDTO> lst = Json.fromJsonAsList(JyjccybgDTO.class, succJsonStr);
        for (int i = 0; i < lst.size(); i++) {
            JyjccybgDTO dto = (JyjccybgDTO) lst.get(i);
            Jyjccydj jcdj = dao.query(Jyjccydj.class, Cnd.where("cybh", "=", dto.getCybh())).get(0);
            List<Jyjccybgb> jcbgList = dao.query(Jyjccybgb.class, Cnd.where("bgbh", "=", dto.getBgbh()));
            Jyjccybgb jcbg = null;
            if (jcbgList != null && jcbgList.size() > 0) {
                jcbg = jcbgList.get(0);
            }
            String v_bgid = DbUtils.getSequenceStr();
            if (jcbg == null) {
                jcbg = new Jyjccybgb();
                jcbg.setBgid(v_bgid);
                jcbg.setCydjid(jcdj.getCydjid());
                jcbg.setBgbh(dto.getBgbh());
                jcbg.setJsbgrq(dto.getJsbgrq());
                jcbg.setBgsdrq(dto.getBgsdrq());
                String[] jcrqs;
                if (dto.getJcrq() != null && !"".equals(dto.getJcrq())) {
                    jcrqs = dto.getJcrq().split("-");
                    if (jcrqs.length == 2) {
                        jcbg.setJcrqks(formatDate(jcrqs[0]));
                        jcbg.setJcrqjs(formatDate(jcrqs[1]));
                    }
                }
                jcbg.setJcdwmc(dto.getJcdwmc());
                jcbg.setLah(dto.getLah());
                jcbg.setAae011(v_user.getDescription());
                jcbg.setAae036(SysmanageUtil.getDbtimeYmd());
                dao.insert(jcbg);
            } else {
                jcbg.setCydjid(jcdj.getCydjid());
                dao.update(jcbg);
            }
            Jyjccybgxmb jcxm = new Jyjccybgxmb();
            jcxm.setJyjcbgxmid(DbUtils.getSequenceStr()); // 报告id
            jcxm.setBgid(jcbg.getBgid()); // 报告id
            jcxm.setCydjid(jcdj.getCydjid()); // 抽样登记id
            jcxm.setJxjcxmmc(dto.getJxjcxmmc()); // 抽样项目名称
            jcxm.setSfhg(dto.getSfhg()); // 是否合格
            jcxm.setDw(dto.getDw()); // 单位
            jcxm.setJyjcjg(dto.getJyjcjg()); // 抽样检测结果
            jcxm.setBzz(dto.getBzz()); // 标准值
            jcxm.setAae011(v_user.getDescription()); // 经办人
            jcxm.setAae036(SysmanageUtil.getDbtimeYmd()); // 经办时间
            jcxm.setYjqk(dto.getYjqk()); // 移交情况
            dao.insert(jcxm);
        }
    }

    /**
     *
     * formatDate
     * formatDate
     * @param date
     * @return
     *        Written by : zy
     * @throws Exception
     */
    public String formatDate(String date) throws Exception{
        String myDate = "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String[] nyr = date.split("/");
        if (nyr.length == 2) {
            myDate = DateUtil.getCurrentYear() + "-" + nyr[0] + "-" + nyr[1];
        }
        Date d = sdf.parse(myDate);
        return sdf.format(d);
    }

    /**
     *
     * 检测方法分页查询
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryJcffgl(JyjcffbzbDTO dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select jcff.* ");
        sb.append(" from jyjcffbzb jcff , sysuser user");
        sb.append(" where 1=1");
        sb.append(" and jcff.userid = user.userid");
        sb.append(" and jcff.jcffbzmc like :jcffbzmc or jcff.jcffbzbh like :jcffbzmc");
        sb.append(" and jcff.sfyx = :sfyx");
        sb.append(" and jcff.jcffbzbh like :jcffbzbh");
        sb.append(" order by jcff.jyjcffbzbid desc");
        String sql = sb.toString();
        String[] paramName = new String[]{"jcffbzmc","sfyx","jcffbzbh"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcffbzbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

        return map;
    }

    /**
     * 添加检测方法
     * @param request
     * @param dto
     * @throws Exception
     */
    public void jcffglForm(HttpServletRequest request, final JyjcffbzbDTO dto) throws Exception {
        jcffglFormImpl(request, dto);
    }

    /**
     * 删除检测方法
     * @param request
     * @param dto
     * @return
     */
    public String delJyjcffbzb(HttpServletRequest request, final JyjcffbzbDTO dto) {

        try {
            delJyjcffbzbImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * 检测方法添加
     *
     * @param dto
     * @return
     */
    public void jcffglFormImpl(HttpServletRequest request, JyjcffbzbDTO dto) throws Exception {
        //获得登录系统用户，即操作员姓名
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        if (dto.getJyjcffbzbid() != null && !"".equals(dto.getJyjcffbzbid())) {// 更新操作

            Jyjcffbzb jcff = new Jyjcffbzb();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            jcff.setJyjcffbzbid(dto.getJyjcffbzbid());
            jcff.setJcffbzbh(dto.getJcffbzbh());
            jcff.setJcffbzmc(dto.getJcffbzmc());
            jcff.setJcffbzlb(dto.getJcffbzlb());
            jcff.setFbrq(dto.getFbrq());
            jcff.setJyjcbzstate(dto.getJyjcbzstate());
            jcff.setSsrq(dto.getSsrq());
            jcff.setBfbm(dto.getBfbm());
            jcff.setFzrq(dto.getFzrq());
            jcff.setBztdqk(dto.getBztdqk());
            jcff.setBznr(dto.getBznr());
            jcff.setUserid(sysuser.getUserid());
            jcff.setUsername(sysuser.getDescription());
            jcff.setCzsj(sdf.format(new Date()));
            jcff.setSfyx(dto.getSfyx());

            dao.update(jcff);

        } else {
            String jyjcffbzbid = DbUtils.getSequenceStr();//生成Id
            Jyjcffbzb jcff = new Jyjcffbzb();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            jcff.setJyjcffbzbid(jyjcffbzbid);
            jcff.setJcffbzbh(dto.getJcffbzbh());
            jcff.setJcffbzmc(dto.getJcffbzmc());
            jcff.setJcffbzlb(dto.getJcffbzlb());
            jcff.setFbrq(dto.getFbrq());
            jcff.setJyjcbzstate(dto.getJyjcbzstate());
            jcff.setSsrq(dto.getSsrq());
            jcff.setBfbm(dto.getBfbm());
            jcff.setFzrq(dto.getFzrq());
            jcff.setBztdqk(dto.getBztdqk());
            jcff.setBznr(dto.getBznr());
            jcff.setUserid(sysuser.getUserid());
            jcff.setUsername(sysuser.getDescription());
            jcff.setCzsj(sdf.format(new Date()));
            jcff.setSfyx(dto.getSfyx());

            dao.insert(jcff);

            dto.setJyjcffbzbid(jyjcffbzbid);
        }
    }

    /**
     * 查询一条数据
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryJyjcffbzbDto(HttpServletRequest request, JyjcffbzbDTO dto, PagesDTO pd) throws Exception {

        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT j.*");
        sb.append(" FROM jyjcffbzb j ,sysuser s ");
        sb.append(" where 1=1");
        sb.append(" and j.userid = s.userid  ");
        sb.append(" and j.jyjcffbzbid = :jyjcffbzbid");

        String sql = sb.toString();
        String[] paramName = new String[]{"jyjcffbzbid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcffbzbDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;

    }

    /**
     * 查询安全监督抽检实施细则
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryjycjssxz (HttpServletRequest request, JycjssxzDTO dto, PagesDTO pd) throws Exception {

        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT j.*,v.cjcpmc as cjcpamc,c.jcxmmc jcxmmc");
        sb.append(" FROM jycjssxz j  ");
        sb.append(" left join viewjycjcpfl v on j.viewjycjcpflid=v.viewjycjcpflid   ");
        sb.append(" left join jycjssxzjcxm m on j.jyxmdesc=m.jycjssxzjcxmid  ");
        sb.append("  left join jyjcxm c on c.jyjcxmid=m.jyjcxmid   ");
        sb.append(" where 1=1");
        sb.append(" and j.viewjycjcpflid = :viewjycjcpflid");
        sb.append(" and j.jycjssxzid = :jycjssxzid");
        sb.append(" and j.cpzl like :cpzl");
        sb.append(" and j.syfw like :syfw");
        sb.append(" order by j.jycjssxzid ");
        String sql = sb.toString();
        String[] paramName = new String[]{"viewjycjcpflid","jycjssxzid","cpzl","syfw"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JycjssxzDTO.class,pd.getPage(), pd.getRows());//wxy20180619 查询数据分页.
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;

    }

    public String queryjycjssxzDesc(HttpServletRequest request, JycjssxzDTO dto) throws Exception {

       String s=dto.getJyxmdesc();
        String[] strArray = null;
        strArray = s.split(",");
        String jcxmdesc="";
        String jcxmmc="";
        for(int i=0;i<strArray.length;i++){
            String desc=strArray[i];
            Jycjssxzjcxm cydj=dao.fetch(Jycjssxzjcxm.class, desc);
            Jyjcxm jcxm=dao.fetch(Jyjcxm.class, cydj.getJyjcxmid());
            if("".equals(jcxmdesc)){
                jcxmdesc=jcxm.getJcxmmc();
                jcxmmc=jcxm.getJyjcxmid();
            }else{
                jcxmdesc+="|"+jcxm.getJcxmmc();
                jcxmmc+=","+jcxm.getJyjcxmid();
            }
        }
        return jcxmdesc;

    }

    public String queryjycjssxzDescnew(HttpServletRequest request, JycjssxzDTO dto) throws Exception {

        String s=dto.getJyxmdesc();
        String[] strArray = null;
        strArray = s.split(",");
        String jcxmdesc="";
        String jcxmmc="";
        for(int i=0;i<strArray.length;i++){
            String desc=strArray[i];
            Jycjssxzjcxm cydj=dao.fetch(Jycjssxzjcxm.class, desc);
            Jyjcxm jcxm=dao.fetch(Jyjcxm.class, cydj.getJyjcxmid());
            if("".equals(jcxmdesc)){
                jcxmdesc=jcxm.getJcxmmc();
                jcxmmc=jcxm.getJyjcxmid();
            }else{
                jcxmdesc+="|"+jcxm.getJcxmmc();
                jcxmmc+=","+jcxm.getJyjcxmid();
            }
        }
        return jcxmmc;

    }
    /**
     * 删除
     *
     * @param request
     * @param dto
     * @return
     */
    public String delJyjcffbzbImpl(HttpServletRequest request, JyjcffbzbDTO dto) {
        dao.clear(Jyjcffbzb.class, Cnd.where("jyjcffbzbid", "=", dto.getJyjcffbzbid()));
        return null;
    }

    /**
     *
     * 查询抽样登记
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryJyjccydj_zm(JyjccydjDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb=new StringBuffer();
        sb.append(" SELECT dj.cydjid,dj.jyjccjrwbid,dj.bcydwcomid,dj.bcydw,dj.bcydwdz,dj.tel, dj.bcydwfl, ");
        sb.append(" dj.aae011,dj.aae036,dj.cydjrwly,dj.cydjrwlb,dj.cydjqylx,dj.comfrhyz, ");
        sb.append(" dj.nsxe,dj.yyzhh,dj.xlr,dj.comcz,dj.comyzbm,dj.comsfyy,dj.qiyezylx, ");
        sb.append(" dj.comyydesc,dj.comyycljg,dj.sfxyfj,dj.fjcomid,dj.fjcommc,dj.cjresult, ");
        sb.append("(case when dj.jyjccjrwbid is not null and dj.jyjccjrwbid<>'' then (select t.jcrwmc from jyjccjrwb t where t.jyjccjrwbid=dj.jyjccjrwbid) else '' end) as jcrwmc ");
        sb.append("  FROM jyjccydj dj ");
        sb.append("  WHERE 1=1");
        sb.append(" AND dj.cydjrwlb=:cydjrwlb ");
        sb.append(" AND dj.bcydwcomid=:bcydwcomid ");
        sb.append(" AND dj.cydjid=:cydjid "	);
        sb.append(" order by dj.cydjid desc "	);
        String sql = sb.toString();
        String[] paramName = new String[]{"cydjrwlb","bcydwcomid","cydjid"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjccydjDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     *
     * 抽样登记添加\修改
     *
     * @param request
     * @param dto
     * @return
     */
    public String saveJyjccydj_zm(HttpServletRequest request,@Param("..") JyjccydjDTO dto){
        String id=null;
        try {
            id= saveJyjccydjImpl_zm(request,dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return id;
    }

    /**
     * 抽样登记添加\修改
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    @Aop({"trans"})
    public String saveJyjccydjImpl_zm(HttpServletRequest request,@Param("..") JyjccydjDTO dto) throws Exception{
        if("".equals(dto.getCysj())){
            dto.setCysj(null);
        }
        if(dto.getCydjid()!=null && !"".equals(dto.getCydjid())){
            Jyjccydj cydj=dao.fetch(Jyjccydj.class, dto.getCydjid());
            BeanHelper.copyProperties(dto, cydj);
            dao.update(cydj);
            return dto.getCydjid();
        }else{
            Jyjccydj cy=new Jyjccydj();
            Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
            String id = DbUtils.getSequenceStr();
            String tim=SysmanageUtil.getDbtimeYmd();
            BeanHelper.copyProperties(dto, cy);
            cy.setCydjid(id);//主键
            cy.setAae036(tim);
            cy.setAae011(vSysUser.getUsername());
            dao.insert(cy);
            return id;
        }
    }

    /**
     * 抽样登记删除
     * @param id
     * @return
     */
    @Aop({"trans"})
    public String deljyjccydj_zm(String id){
        try {
            dao.delete(Jyjccydj.class, id);
            dao.clear(Jyjccyd.class, Cnd.where("cydjid", "=", id));
            Hjyjczb hjyjczb=dao.fetch(Hjyjczb.class, Cnd.where("cydjid", "=", id));
            dao.clear(Hjyjczb.class, Cnd.where("cydjid", "=", id));
            dao.clear(Hjyjcmxb.class, Cnd.where("hjyjczbid", "=", hjyjczb.getHjyjczbid()));
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * 查询抽样单
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryJyjccyd_zm(JyjccydDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb=new StringBuffer();
//        sb.append(" SELECT d.jyjccydid,d.cydjid,d.cydbh,d.cydjrwly ,d.cydjrwlb,d.cydjqylx,  ");
//        sb.append(" d.commc,d.jcypmc,d.zxbzjswj,d.cyypbz,d.cyfs,d.cydwmc, ");
//        sb.append(" d.beizhu,d.cydwgzrq,d.aae011,d.aae036 ");
        sb.append("  SELECT * ");
        sb.append("  FROM jyjccyd d ");
        sb.append("  WHERE 1=1");
        sb.append(" AND d.cydjid=:cydjid ");
        sb.append(" AND d.cydbh=:cydbh ");
        sb.append(" AND d.jyjccydid=:jyjccydid ");
        String sql = sb.toString();
        String[] paramName = new String[]{"cydjid","cydbh","jyjccydid"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjccydDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * 保存抽检实施细则
     *
     */
    public String savejycjssxz(HttpServletRequest request,@Param("..") JycjssxzDTO dto){
        String id=null;
        try {
            savejycjssxzImpl(request,dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return id;
    }

    /**
     * 保存抽检实施细则
     *
     */
    @Aop({"trans"})
    public void savejycjssxzImpl(HttpServletRequest request,@Param("..") JycjssxzDTO dto) throws Exception{
        Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        if(dto.getJycjssxzid()!=null && !"".equals(dto.getJycjssxzid())){
            Jycjssxz jssz=dao.fetch(Jycjssxz.class, dto.getJycjssxzid());
            String s=jssz.getJyxmdesc();
            if(s!=null&&!"".equals(s)) {
                String[] strArray = null;
                strArray = s.split(",");
                for (int i = 0; i < strArray.length; i++) {
                    String desc = strArray[i];
                    Jycjssxzjcxm cydj = dao.fetch(Jycjssxzjcxm.class, desc);
                    dao.clear(Jycjssxzjcxm.class, Cnd.where("jycjssxzjcxmid", "=", desc));
                }
            }
            String jyxmdesc=dto.getJyxmdesc();
            String sc="";
            if(dto.getJyxmdesc()!=null&&!"".equals(dto.getJyxmdesc())){
                String[] strArray = null;
                strArray = jyxmdesc.split(",");
                for(int i=0;i<strArray.length;i++){
                    String desc=strArray[i];
                    String jjid = DbUtils.getSequenceStr();
                    Jycjssxzjcxm jsszjcxm=new Jycjssxzjcxm();
                    jsszjcxm.setJycjssxzjcxmid(jjid);
                    jsszjcxm.setJyjcxmid(desc);
                    jsszjcxm.setJycjssxzid(jssz.getJycjssxzid());
                    jsszjcxm.setAae011(vSysUser.getDescription());
                    jsszjcxm.setAae036(datetime);
                    dao.insert(jsszjcxm);
                    if("".equals(sc)){
                        sc=jjid;
                    }else{
                        sc+=","+jjid;
                    }
                }
            }
            BeanHelper.copyProperties(dto, jssz);
            jssz.setJyxmdesc(sc);
            jssz.setAae011(vSysUser.getDescription());
            jssz.setAae036(datetime);
            dao.update(jssz);
        }else{
            Jycjssxz jssz=new Jycjssxz();
            String id = DbUtils.getSequenceStr();
            BeanHelper.copyProperties(dto, jssz);
            jssz.setJycjssxzid(id);

            String s=dto.getJyxmdesc();
            String[] strArray = null;
            strArray = s.split(",");
            String jcxmdesc="";
            for(int i=0;i<strArray.length;i++){
                String desc=strArray[i];
                String jjid = DbUtils.getSequenceStr();
                Jycjssxzjcxm jsszjcxm=new Jycjssxzjcxm();
                jsszjcxm.setJycjssxzjcxmid(jjid);
                jsszjcxm.setJyjcxmid(desc);
                jsszjcxm.setJycjssxzid(id);
                jsszjcxm.setAae011(vSysUser.getDescription());
                jsszjcxm.setAae036(datetime);
                dao.insert(jsszjcxm);
                if("".equals(jcxmdesc)){
                    jcxmdesc=jjid;
                }else{
                    jcxmdesc+=","+jjid;
                }
            }

            jssz.setAae011(vSysUser.getDescription());
            jssz.setAae036(datetime);
            jssz.setJyxmdesc(jcxmdesc);
            dao.insert(jssz);

        }
    }

    /**
     * 删除抽检实施细则
     *
     */
    public String delJycjssxz(HttpServletRequest request,JycjssxzDTO dto) {
        try {
            if (null != dto.getJycjssxzid()) {
                delJycjssxzImp(request, dto);
            } else {
                return "没有接收到要删除的抽检实施细则ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * 删除抽检实施细则
     */
    @Aop({"trans"})
    public void delJycjssxzImp(HttpServletRequest request, JycjssxzDTO dto) {
        Jycjssxz jssz = dao.fetch(Jycjssxz.class, dto.getJycjssxzid());
        dao.clear(Jycjssxz.class, Cnd.where("jycjssxzid", "=", dto.getJycjssxzid()));
        String s=jssz.getJyxmdesc();
        if(s!=null&&!"".equals(s)) {
            String[] strArray = null;
            strArray = s.split(",");
            for (int i = 0; i < strArray.length; i++) {
                String desc = strArray[i];
                Jycjssxzjcxm cydj = dao.fetch(Jycjssxzjcxm.class, desc);
                dao.clear(Jycjssxzjcxm.class, Cnd.where("jycjssxzjcxmid", "=", desc));
            }
        }
    }

    /**
     * 检验检测主表查询
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryHjyjczb_zm(HjyjczbDTO dto, PagesDTO pd) throws Exception {
        if(StringUtils.isNotEmpty(dto.getHviewjgztmc())){
            dto.setHviewjgztmc(new String(dto.getHviewjgztmc().getBytes("ISO-8859-1"),"utf-8"));
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT h.hjyjczbid,h.hviewjgztid,h.hviewjgztmc,h.jyjcbgbh,h.eptbh,h.jyjcrq,h.fjjg,h.jycjssxzid, ");
        sb.append(" h.cydjid,h.jsbgrq,h.bgsdrq,h.jcksrq,h.jcjsrq,h.cybgsfla, ");
        sb.append(" h.jcypid,h.jcypmc,h.jcjylb,h.jcorgid,h.jcorgmc,h.jcryid, ");
        sb.append(" h.jcrymc,h.jcjyshbz,h.jcjyshwtgyy,h.aae011,h.aae036,h.sbxh,h.sbxlh, ");
        sb.append("  h.ajdjid,h.ajdjbh FROM hjyjczb h");
        sb.append("  WHERE 1=1");
        sb.append(" AND  h.cydjid = :cydjid ");
        sb.append(" AND h.hjyjczbid=:hjyjczbid ");
        sb.append(" AND h.hviewjgztmc like :hviewjgztmc ");
        sb.append(" AND h.jcypmc=:jcypmc ");
        sb.append(" AND h.jcorgmc=:jcorgmc ");
        sb.append(" AND h.detectiondatatype=:detectiondatatype ");
        sb.append(" order by hjyjczbid desc");
        String sql = sb.toString();
        String[] paramName = new String[]{"cydjid", "hjyjczbid","hviewjgztmc","jcypmc","detectiondatatype","jcorgmc"};
        int[] paramType = new int[]{Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjyjczbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * 检验检测明细表查询
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryHjyjcmxb_zm(HjyjcmxbDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT h.hjyjcmxbid,h.hjyjczbid,h.jcxmid,h.jcxmmc,h.jcz,h.szdw,  ");
        sb.append("h.jyjcjl,h.xlbz,h.bzz,h.jcff,h.cydjid,h.yjqk,h.aae011,h.aae036 ");
        sb.append("   FROM hjyjcmxb h ");
        sb.append("  WHERE 1=1");
        sb.append(" AND h.hjyjczbid=:hjyjczbid ");
        sb.append(" AND h.hjyjcmxbid=:hjyjcmxbid ");
        sb.append(" order by hjyjcmxbid desc");
        String sql = sb.toString();
        String[] paramName = new String[]{"hjyjczbid", "hjyjcmxbid"};
        int[] paramType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjyjcmxbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * 检验检测主表添加\修改
     * @param request
     * @param dto
     * @return
     */
    public String saveHjyjczb_zm(HttpServletRequest request, HjyjczbDTO dto) {
        try {
            hjyjczbFormImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return dto.getHjyjczbid();

    }

    /**
     *
     * @param jycjssxzid
     * @param hjyjczbid
     * @throws Exception
     * Written by : wxy
     */
    public void insertHjyjcmxb(String jycjssxzid,String hjyjczbid,String userid) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //获得登录系统用户，即操作员姓名
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        if (sysuser == null) {//wxy 20180705手机端直接使用dto中的userid获取Sysuser
            sysuser = dao.fetch(Sysuser.class, userid);
        }
        String sb = "";
        sb +="SELECT h.*,a.bzbh,b.jcffbzbh ";
        sb += "From (SELECT j1.jyjcxmid,jcxm.jcxmmc,jcxm.jcxmbzz ";
        sb += " FROM jycjssxz j LEFT JOIN jycjssxzjcxm j1 ON j.jycjssxzid=j1.jycjssxzid";
        sb += " LEFT JOIN jyjcxm jcxm ON j1.jyjcxmid=jcxm.jyjcxmid";
        sb += " WHERE j.jycjssxzid='" +jycjssxzid+"') h,";
        sb += "(SELECT xmbz.jyjcxmid,group_concat(bz.bzbh) bzbh,group_concat(bz.jyjcjcbzbid) jyjcjcbzbid " +
                "FROM jyjcxmjcbz xmbz, jyjcjcbzb bz ";
        sb += "where xmbz.jyjcjcbzbid=bz.jyjcjcbzbid GROUP BY xmbz.jyjcxmid) a,";
        sb += "(SELECT xmff.jyjcxmid,group_concat(ff.jcffbzbh) jcffbzbh,group_concat(ff.jyjcffbzbid) jyjcffbzbid " +
                "FROM jyjcxmjcffbz xmff, jyjcffbzb ff ";
        sb += "where  xmff.jyjcffbzbid=ff.jyjcffbzbid GROUP BY xmff.jyjcxmid) b ";
        sb += "where  h.jyjcxmid=a.jyjcxmid and a.jyjcxmid=b.jyjcxmid";
        String sql=sb.toString();
        Map m = DbUtils.DataQuery(GlobalNames.sql,sql , null, JyjcxmDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
//        //先清空明细表
//        dao.clear(Hjyjcmxb.class, Cnd.where("hjyjczbid", "=", hjyjczbid));
        Hjyjcmxb v_hjyjcmxb=new Hjyjcmxb();
        if(list != null && list.size() > 0){
            for(int i=0;i<list.size();i++){
                JyjcxmDTO jcxm=(JyjcxmDTO)list.get(i);
                v_hjyjcmxb=dao.fetch(Hjyjcmxb.class,Cnd.where("hjyjczbid","=",hjyjczbid).and("jcxmmc","=",jcxm.getJcxmmc()));
                if(v_hjyjcmxb==null){
                    Hjyjcmxb hjyjcmxb=new Hjyjcmxb();
                    hjyjcmxb.setHjyjcmxbid(DbUtils.getSequenceStr());
                    hjyjcmxb.setHjyjczbid(hjyjczbid);
                    hjyjcmxb.setJcxmid(jcxm.getJyjcxmid());
                    //数值单位默认为：mg/kg
                    hjyjcmxb.setSzdw("mg/kg");
                    hjyjcmxb.setXlbz(jcxm.getBzbh());
                    hjyjcmxb.setJcff(jcxm.getJcffbzbh());
                    hjyjcmxb.setJyjcjl("");
                    hjyjcmxb.setJcxmmc(jcxm.getJcxmmc());
                    hjyjcmxb.setBzz(jcxm.getJcxmbzz());
                    hjyjcmxb.setAae011(sysuser.getUsername());
                    hjyjcmxb.setAae036(sdf.format(new Date()));
                    dao.insert(hjyjcmxb);
                }
            }
        }
    }
    /**
     * 检验检测主表添加\修改
     * @param request
     * @param dto
     * @throws Exception
     */
    public void hjyjczbFormImpl(HttpServletRequest request, HjyjczbDTO dto) throws Exception {
        //获得登录系统用户，即操作员姓名
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        //dto.setAaa027(vSysUser.getAaa027());
        if (sysuser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
            sysuser = dao.fetch(Sysuser.class, dto.getUserid());
        }
        if (dto.getHjyjczbid() != null && !"".equals(dto.getHjyjczbid())) {// 更新操作

            Hjyjczb jczb = new Hjyjczb();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            BeanHelper.copyProperties(dto, jczb);
            jczb.setJyjcrq(sdf.format(new Date()));
            jczb.setAae011(sysuser.getDescription());
            jczb.setAae036(sdf.format(new Date()));
            if("".equals(jczb.getJsbgrq())){
                jczb.setJsbgrq(null);
            }
            if("".equals(jczb.getJyjcrq())){
                jczb.setJsbgrq(null);
            }
            if("".equals(jczb.getBgsdrq())){
                jczb.setBgsdrq(null);
            }
            if("".equals(jczb.getJcjsrq())){
                jczb.setJcjsrq(null);
            }
            if("".equals(jczb.getJcksrq())){
                jczb.setJcksrq(null);
            }
            if(dto.getJycjssxzid()!=null && !"".equals(dto.getJycjssxzid())) {
                //通过抽检实施细则是否改变来决定明细表是否重新生成.  wxy
                Hjyjczb zb1 = dao.fetch(Hjyjczb.class, dto.getHjyjczbid());
                String Jycjssxzid1 = zb1.getJycjssxzid();
                String Jycjssxzid2 = dto.getJycjssxzid();
                if (Jycjssxzid1==null ||!Jycjssxzid1.equals(Jycjssxzid2)) {
                    insertHjyjcmxb(dto.getJycjssxzid(), dto.getHjyjczbid(),dto.getUserid());
                }
            }
            dao.update(jczb);
        } else {//添加
            String hjyjczbid = DbUtils.getSequenceStr();//生成Id
            Hjyjczb jczb = new Hjyjczb();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            BeanHelper.copyProperties(dto, jczb);
            jczb.setHjyjczbid(hjyjczbid);
            jczb.setJyjcrq(sdf.format(new Date()));
            jczb.setAae011(sysuser.getDescription());
            jczb.setAae036(sdf.format(new Date()));
            if("".equals(jczb.getJsbgrq())){
                jczb.setJsbgrq(null);
            }
            if("".equals(jczb.getJyjcrq())){
                jczb.setJsbgrq(null);
            }
            if("".equals(jczb.getBgsdrq())){
                jczb.setBgsdrq(null);
            }
            if("".equals(jczb.getJcjsrq())){
                jczb.setJcjsrq(null);
            }
            if("".equals(jczb.getJcksrq())){
                jczb.setJcksrq(null);
            }
            dao.insert(jczb);
            dto.setHjyjczbid(hjyjczbid);
            if(dto.getJycjssxzid()!=null && !"".equals(dto.getJycjssxzid())){
                //根据抽检实施细则自动插入相关明细表
                insertHjyjcmxb(dto.getJycjssxzid(),hjyjczbid,dto.getUserid());
            }
            if("2".equals(dto.getJcbgrz())){
                //q企业异议日志
                Sysoperatelog v_newSysoperatelog=new Sysoperatelog();
                v_newSysoperatelog.setUrl(dto.getCydjid());
                v_newSysoperatelog.setDescription("检测报告");
                SysmanageUtil.g_writeSysoperatelog(request,v_newSysoperatelog);
            }
        }
    }

    /**
     * 检验检测主表删除
     */
    @Aop({"trans"})
    public String delHjyjczb_zm(HttpServletRequest request, HjyjczbDTO dto) {
        try {
            if (null != dto.getHjyjczbid()) {
                delHjyjczbImp(request, dto);
            } else {
                return "没有接收到要删除的检验检测主表ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * 检验检测主表删除
     *
     * @param request
     * @param dto
     * @return
     */
    @Aop({"trans"})
    public void delHjyjczbImp(HttpServletRequest request, @Param("..") HjyjczbDTO dto) {
        dao.delete(Hjyjczb.class, dto.getHjyjczbid());//删除主表
        dao.clear(Hjyjcmxb.class, Cnd.where("hjyjczbid", "=", dto.getHjyjczbid()));//删除明细表
    }
    /**
     * 检验检测明细表添加\修改
     * @param request
     * @param dto
     * @return
     */
    public String saveHjyjcxb(HttpServletRequest request, HjyjcmxbDTO dto) {
        try {
            HjyjcxbFormImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;

    }
    /**
     * 检验检测明细表添加\修改
     * @param request
     * @param dto
     * @throws Exception
     */
    public void HjyjcxbFormImpl(HttpServletRequest request, HjyjcmxbDTO dto) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //获得登录系统用户，即操作员姓名
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        if (sysuser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
            sysuser = dao.fetch(Sysuser.class, dto.getUserid());
        }
        if(!"".equals(dto.getHjyjcmxbid())&&null!=dto.getHjyjcmxbid()){
            Hjyjcmxb hjyjcmxb=new Hjyjcmxb();
            BeanHelper.copyProperties(dto, hjyjcmxb);
            hjyjcmxb.setAae011(sysuser.getDescription());
            hjyjcmxb.setAae036(sdf.format(new Date()));
            dao.update(hjyjcmxb);
        }else{
            Hjyjcmxb v_hjyjcmxb=dao.fetch(Hjyjcmxb.class,Cnd.where("hjyjczbid", "=", dto.getHjyjczbid()).and("jcxmmc", "=", dto.getJcxmmc()));
            if(v_hjyjcmxb==null){
                Hjyjcmxb hjyjcmxb=new Hjyjcmxb();
                BeanHelper.copyProperties(dto, hjyjcmxb);
                hjyjcmxb.setHjyjcmxbid(DbUtils.getSequenceStr());
                hjyjcmxb.setAae011(sysuser.getDescription());
                hjyjcmxb.setAae036(sdf.format(new Date()));
                dao.insert(hjyjcmxb);
            }
        }
    }
    /**
     * 检验检测明细表查询
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryHjyjcmxb(HjyjcmxbDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT h.hjyjcmxbid,h.hjyjczbid,h.jcxmid,h.jcxmmc,  ");
        sb.append(" h.jcz,h.szdw,h.jyjcjl,h.xlbz,h.bzz,h.jcff, ");
        sb.append(" h.cydjid,h.yjqk,h.aae011,h.aae036 FROM hjyjcmxb h");
        sb.append("  WHERE 1=1");
        sb.append(" AND h.hjyjcmxbid=:hjyjcmxbid ");
        String sql = sb.toString();
        String[] paramName = new String[]{ "hjyjcmxbid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjyjcmxbDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
    /**
     * 检验检测明细表删除
     */
    @Aop({"trans"})
    public String delHjyjcmxb(HttpServletRequest request, HjyjcmxbDTO dto) {
        try {
            if (null != dto.getHjyjcmxbid()) {
                delHjyjcmx(request, dto);
            } else {
                return "没有接收到要删除的检验检测明细表ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    /**
     * 检验检测删除明细表
     *
     * @param request
     * @param dto
     * @return
     */
    @Aop({"trans"})
    public void delHjyjcmx(HttpServletRequest request, @Param("..") HjyjcmxbDTO dto) {
        dao.delete(Hjyjcmxb.class, dto.getHjyjcmxbid());//删除明细表
    }

    /**
     *
     * 抽样单添加\修改
     *
     * @param request
     * @param dto
     * @return
     */
    public String saveJyjccyd_zm(HttpServletRequest request, JyjccydDTO dto) {
        String id=null;
        try {
            id= saveJyjccyd_zmImpl(request,dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return id;
    }

    /**
     *
     * 抽样单添加\修改
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    @Aop({"trans"})
    public String saveJyjccyd_zmImpl(HttpServletRequest request,@Param("..") JyjccydDTO dto) throws Exception{
        if(dto.getJyjccydid()!=null && !"".equals(dto.getJyjccydid())){
            Jyjccyd cyd=dao.fetch(Jyjccyd.class, dto.getJyjccydid());
            BeanHelper.copyProperties(dto, cyd);
            if("".equals(cyd.getYpxxscjggjrq())){
                cyd.setYpxxscjggjrq(null);
            }
            if("".equals(cyd.getJsypjzrq())){
                cyd.setJsypjzrq(null);
            }
            if("".equals(cyd.getBcydwqmrq())){
                cyd.setBcydwqmrq(null);
            }
            if("".equals(cyd.getSczqmrq())){
                cyd.setSczqmrq(null);
            }
            if("".equals(cyd.getCydwgzrq())) {
                cyd.setCydwgzrq(null);
            }
            dao.update(cyd);
            return dto.getJyjccydid();
        } else{
            Jyjccyd cyd=new Jyjccyd();
            String id = DbUtils.getSequenceStr();
            BeanHelper.copyProperties(dto, cyd);
            cyd.setJyjccydid(id);//主键
            if("".equals(cyd.getYpxxscjggjrq())){
                cyd.setYpxxscjggjrq(null);
            }
            if("".equals(cyd.getJsypjzrq())){
                cyd.setJsypjzrq(null);
            }
            if("".equals(cyd.getBcydwqmrq())){
                cyd.setBcydwqmrq(null);
            }
            if("".equals(cyd.getSczqmrq())){
                cyd.setSczqmrq(null);
            }
            if("".equals(cyd.getCydwgzrq())) {
                cyd.setCydwgzrq(null);
            }
            dao.insert(cyd);
            //写日志
            Sysoperatelog v_newSysoperatelog=new Sysoperatelog();
            v_newSysoperatelog.setUrl(dto.getCydjid());
            v_newSysoperatelog.setDescription("抽样单新增");
            SysmanageUtil.g_writeSysoperatelog(request,v_newSysoperatelog);
            return id;
        }
    }

    /**
     * 抽样单删除
     * @param request
     * @param dto
     * @return
     */
    @Aop({"trans"})
    public String delJyjccyd_zm(HttpServletRequest request, JyjccydDTO dto) {
        try{
            delJyjccyd_zmImpl(request, dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * 抽样单删除
     * @param request
     * @param dto
     */
    @Aop({"trans"})
    private void delJyjccyd_zmImpl(HttpServletRequest request, JyjccydDTO dto) {
        if(!(dto.getJyjccydid() == null||"".equals(dto.getJyjccydid()))){
            //删除信息
            dao.clear(Jyjccyd.class, Cnd.where("jyjccydid", "=", dto.getJyjccydid()));
        }
    }
    /**
     * 查询网上送检
     * Written by : wxy
     */
    public Map queryWssj(HttpServletRequest request,JyjcwssjDTO dto, PagesDTO pd) throws Exception {
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        String v_userkind=sysuser.getUserkind();
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select wssj.*");
        sb.append(" from jyjcwssj wssj");
        sb.append(" where 1=1");
        sb.append(" and wssj.jyjcwssjid = :jyjcwssjid");
        sb.append(" and wssj.commc = :commc");
        if ("30".equals(v_userkind)){//网上送检人员
            sb.append(" and wssj.sqczyid='"+sysuser.getUserid()+"' ");
        }else if ("20".equals(v_userkind)||"21".equals(v_userkind)){//检测机构  检测机构人员
            sb.append(" and wssj.jcorgid='"+sysuser.getUsercomid()+"' and wssj.shbz='1' ");
        };
//        if (sysuser!=null && ("6".equals(sysuser.getUserkind())||"7".equals(sysuser.getUserkind())
//                ||"8".equals(sysuser.getUserkind()))){
//            sb.append(" and wssj.jcorgid='"+sysuser.getUsercomid()+"' ");
//        }else if(sysuser!=null && ("30".equals(sysuser.getUserkind()))){
//            sb.append(" and wssj.sqczyid='"+sysuser.getUserid()+"' ");
//        }else if(!"6".equals(sysuser.getUserkind())&&!"7".equals(sysuser.getUserkind())
//                &&!"8".equals(sysuser.getUserkind())&&!"30".equals(sysuser.getUserkind())){
//            sb.append(" and wssj.shczyname='"+sysuser.getUsername()+"' ");
//        }
        sb.append(" order by jyjcwssjid desc");
        String sql = sb.toString();
        String[] paramName = new String[]{"jyjcwssjid","commc"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcwssjDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

        return map;
    }
    /**
     * 保存网上送检
     * Written by : wxy
     */
    public String saveWssj(HttpServletRequest request,final JyjcwssjDTO dto) {
        try{
            saveWssjImpl(request, dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop( { "trans" })
    public void saveWssjImpl(HttpServletRequest request, JyjcwssjDTO dto) throws Exception {
        Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        if (Strings.isNotBlank(dto.getJyjcwssjid())) {
            Jyjcwssj wssj=dao.fetch(Jyjcwssj.class,dto.getJyjcwssjid());
            BeanHelper.copyProperties(dto, wssj);
            if("30".equals(sysuser.getUserkind())){
                wssj.setSqczyid(sysuser.getUserid());
                wssj.setSqczyname(sysuser.getDescription());
//                wssj.setSqsj(dto.getSqsj());
                if("".equals(wssj.getShsj())){
                    wssj.setShsj(null);
                }
            }else if("6".equals(sysuser.getUserkind())||"7".equals(sysuser.getUserkind())
                    ||"8".equals(sysuser.getUserkind())||"20".equals(sysuser.getUserkind())||"21".equals(sysuser.getUserkind())){
                wssj.setJcorgid(sysuser.getUsercomid());
                wssj.setJcorgmc(sysuser.getUsercommc());
            }else{
                wssj.setShczyid(sysuser.getUserid());
                wssj.setShczyname(sysuser.getDescription());
                if("".equals(wssj.getShsj())){
                    wssj.setShsj(SysmanageUtil.currentTime().toString());
                }
            }
            dao.update(wssj);
        }else {
            Jyjcwssj wssj=new Jyjcwssj();
            String jyjcwssjid = DbUtils.getSequenceStr();
            dto.setJyjcwssjid(jyjcwssjid);
            BeanHelper.copyProperties(dto, wssj);
            if("30".equals(sysuser.getUserkind())){
                wssj.setSqczyid(sysuser.getUserid());
                wssj.setSqczyname(sysuser.getDescription());
               wssj.setSqsj(SysmanageUtil.currentTime().toString());
                if("".equals(wssj.getShsj())){
                    wssj.setShsj(null);
                }
            }else if("6".equals(sysuser.getUserkind())||"7".equals(sysuser.getUserkind())
                    ||"8".equals(sysuser.getUserkind())||"20".equals(sysuser.getUserkind())||"21".equals(sysuser.getUserkind())){
                wssj.setJcorgid(sysuser.getUsercomid());
                wssj.setJcorgmc(sysuser.getUsercommc());
            }else {
                wssj.setShczyid(sysuser.getUserid());
                wssj.setShczyname(sysuser.getDescription());
                wssj.setShsj(SysmanageUtil.currentTime().toString());
                //wssj.setShsj(dto.getShsj());
            }
            dao.insert(wssj);
        }
    }
    /**
     * 删除网上送检
     * Written by : wxy
     */
    public String delWssj(HttpServletRequest request, JyjcwssjDTO dto) {
        try{
            delWssjImpl(request, dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }
    @Aop({"trans"})
    private void delWssjImpl(HttpServletRequest request, JyjcwssjDTO dto) {
        if(!(dto.getJyjcwssjid() == null||"".equals(dto.getJyjcwssjid()))){
            //删除信息
            dao.clear(Jyjcwssj.class, Cnd.where("jyjcwssjid", "=", dto.getJyjcwssjid()));
        }
    }
    public Map checkCode(HttpServletRequest request, JyjcffbzbDTO dto ) throws Exception {
        //使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
        //转化sql语句
        int li_count= dao.count(Jyjcffbzb.class, Cnd.where("jcffbzbh", "=", dto.getJcffbzbh().trim()));
        Map map = new HashMap();
        map.put("total",li_count);
        return map;
    }
    public Map checkBzbh(HttpServletRequest request, JyjcjcbzbDTO dto ) throws Exception {
        //使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
        //转化sql语句
        int li_count= dao.count(Jyjcjcbzb.class, Cnd.where("bzbh", "=", dto.getBzbh().trim()));
        Map map = new HashMap();
        map.put("total",li_count);
        return map;
    }
    public Map checkJcxmmc(HttpServletRequest request, JyjcxmDTO dto ) throws Exception {
        //使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
        //转化sql语句
        int li_count= dao.count(Jyjcxm.class, Cnd.where("jcxmmc", "=", dto.getJcxmmc().trim()));
        Map map = new HashMap();
        map.put("total",li_count);
        return map;
    }

    /**
     * 你点我检分页查询
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map querySqjccx(HttpServletRequest request,JyjcndwjDTO dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT (SELECT p.mc FROM parentchild p WHERE p.bh=jm.ndwjjcyp) mc, j.* ");
        sb.append(" FROM jyjcndwj j LEFT JOIN jyjcndwjmx jm on j.jyjcndwjid=jm.jyjcndwjid ");
        sb.append(" LEFT JOIN parentchild pa on jm.ndwjjcyp=pa.bh");
        sb.append(" where j.sfgk=:sfgk");
        sb.append(" and pa.mc=:mc");
        sb.append(" and j.sqsj >= :sqstdate ");
        sb.append(" and j.sqsj <= :sqeddate ");
        sb.append("ORDER BY j.jyjcndwjid DESC");
        String sql = sb.toString();
        String[] paramName = new String[]{"sqstdate","sqeddate","mc","sfgk"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcndwjDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
    /**
     *
     * queryxxzttjfxCount中文名称:查询你点我检样品统计数量
     * queryxxzttjfxCount概要描述:查询你点我检样品统计数量
     *
     * written by  :  wxy
     * @throws Exception
     */
    public Map ndwjypCount(HttpServletRequest request,
                                  pubkeyDTO dto) throws Exception {
        // TODO Auto-generated method stub
        StringBuffer sb = new StringBuffer();
        sb.append(" select count(t1.mc) as value,t1.mc as name");
        sb.append(" FROM (select u1.*,u2.mc from jyjcndwjmx u1,parentchild u2 where u1.ndwjjcyp=u2.bh");
        sb.append(" and u2.parentchildlb='ndwjjcyp' and parentid<>'0')  t1,jyjcndwj t2 ");
        sb.append(" where t1.jyjcndwjid=t2.jyjcndwjid");
        if (dto.getSqjctjstdate() != null && !"".equals(dto.getSqjctjstdate())) {
            sb.append(" and t2.sqsj >= '" + dto.getSqjctjstdate() + "' ");
        }
        if (dto.getSqjctjeddate() != null && !"".equals(dto.getSqjctjeddate())) {
            sb.append(" and t2.sqsj <= '" + dto.getSqjctjeddate() + "' ");
        }
        sb.append(" GROUP BY t1.ndwjjcyp");
        String sql = sb.toString();
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql = QueryFactory.getSQL(sql, paramName, paramType,dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, pubkeyDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }
    public Map querySysuser(Sysuser dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select userid, username, description,userkind,a.usercomid,lockstate,");
        sb.append(" mobile, mobile2,telephone,aaa027, aaz010,b.orgname,");
        sb.append(" (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,selfcomflag ");
        sb.append(" from Sysuser a,Sysorg b");
        sb.append(" where 1=1");
        sb.append("  and a.orgid = b.orgid");
        sb.append(" and a.usercomid=:usercomid ");
        if (!com.alibaba.druid.util.StringUtils.isEmpty(dto.getUsername())){
            sb.append("  and (username like '%"+dto.getUsername()+"%' or description like '%"+dto.getUsername()+"%' or mobile like '%"+dto.getUsername()+"%' or mobile2 like '"+dto.getUsername()+"')");
        }
        sb.append("  and description like :description ");
        sb.append("  and userjc like :userjc ");
        sb.append("  and userkind = :userkind");
        sb.append("  and lockstate = :lockstate");
        sb.append("  and aac002 = :aac002");
        sb.append("  and aac003 = :aac003");
        sb.append("  and aac154 = :aac154");
        sb.append("  and aaz010 = :aaz010");
        sb.append("  and mobile = :mobile");
        sb.append("  and aaa027 = :aaa027");
        sb.append("  order by b.orgname");
        String sql = sb.toString();
        String[] ParaName = new String[] {"userid", "username", "description",
                "userjc","userkind", "lockstate", "aac002", "aac003", "aac154",
                "aaz010", "mobile", "aaa027","orgid","usercomid" };
        int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,
                Types.VARCHAR,Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
                Types.VARCHAR, Types.VARCHAR,Types.VARCHAR, Types.VARCHAR,
                Types.VARCHAR, Types.VARCHAR,Types.VARCHAR };
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("kdkkdkdk "+sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysuser.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }
    public Map queryQyyyrz(HttpServletRequest request, @Param("..") SysoperatelogDTO dto,
                           @Param("..") PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.*,b.username ");
        sb.append(" FROM sysoperatelog a,sysuser b");
        sb.append(" where 1=1");
        sb.append(" and a.userid=b.userid");
        sb.append(" and a.url= :url");
        sb.append(" ORDER BY a.starttime");
        String sql = sb.toString();
        String[] paramName = new String[]{"url"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, SysoperatelogDTO.class,
                pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
    public String getPY(@Param("..") JyjcxmDTO dto){
        String str=PinYinUtil.GetChineseSpell(dto.getJcxmmc());
        return str;
    }

    /**
     * 快检报告保存
     * @param request
     * @param dto
     * @return
     * Written by Wxy
     */
    public String saveHkjbgd(HttpServletRequest request,final HjyjczbDTO dto) {
        try{
            saveHkjbgdImpl(request, dto);
        }catch(Exception e){
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * 快检报告保存
     * @param request
     * @param dto
     * @throws Exception
     */
    @Aop( { "trans" })
    public void saveHkjbgdImpl(HttpServletRequest request, HjyjczbDTO dto) throws Exception {
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();

        if (sysuser == null) { //手机端登录获取登录用户
            sysuser = dao.fetch(Sysuser.class, dto.getUserid());
        }
        Hjyjczb hjyjczb = new Hjyjczb();
        Hjyjcmxb hjyjcmxb = new Hjyjcmxb();
        Hkjbgd hkjbgd = new Hkjbgd();

        String json = dto.getKjdata();
        Map map = JSON.parseObject(json);

        String tbodyinfo = "";
        String kuozhan1 = "";
        String tbodyval = "";
        String kuozhan = "";
        BsTbodyInfoDTo tbodybean = new BsTbodyInfoDTo();
        tbodybean.setTbodytype("kaijianbaogaodan");
        tbodybean.setTbodycode("1");
        tbodybean.setAaa027(dto.getAaa027());
        tbodybean = getTbodyInfo(null, tbodybean);
        if (tbodybean != null) {
            tbodyinfo = tbodybean.getTbodyinfo();
            kuozhan1 = tbodybean.getKuozhan1();
        }
        Fj fj1=null;
        Fj fj2=null;
        fj1 = dao.fetch(Fj.class, Cnd.where("fjtype", "=", "RCJCQZPIC01").and("fjwid", "=", map.get("hkjbgdid").toString()));
        fj2 = dao.fetch(Fj.class, Cnd.where("fjtype", "=", "RCJCQZPIC02").and("fjwid", "=", map.get("hkjbgdid").toString()));
        String contextPath =request.getContextPath();

        if (dto.getKjbgdpch() == null || "".equals(dto.getKjbgdpch())) { //添加
            int kjbgdxh = 0;

            //获取报告单信息
            hkjbgd.setHkjbgdid((map.get("hkjbgdid") == null ? "" : map.get("hkjbgdid")).toString()); //Id
            hkjbgd.setKjbgdpch(DbUtils.getSequenceStr()); //批次号
            hkjbgd.setKjbgdjcr((map.get("kjbgdjcr") == null ? "" : map.get("kjbgdjcr")).toString()); //检测人签字
            hkjbgd.setJcdwfzrqzpic((fj1 == null ? "" : fj1.getFjpath())); //检测单位负责人签字
            hkjbgd.setJcdwfzrqzrq((map.get("jcdwfzrqzrq") == null ? "" : map.get("jcdwfzrqzrq")).toString());  //检测单位签字日期
            hkjbgd.setBjcdwfzrqzpic((fj2 == null ? "" : fj2.getFjpath())); //被检单位签字
            hkjbgd.setBjcdwfzrqzrq((map.get("bjcdwfzrqzrq") == null ? "" : map.get("bjcdwfzrqzrq")).toString());  //被检单位签字日期
            hkjbgd.setCzyxm(sysuser.getDescription()); //操作员名称
            hkjbgd.setCzyid(sysuser.getUserid()); //操作员Id
            hkjbgd.setAae036(datetime); //操作时间
            hkjbgd = dao.insert(hkjbgd); //保存报告单

            List sp = (List) map.get("sp"); //获取主表部分信息
            if (sp != null) {
                for (int i = 0; i < sp.size(); i++) {
                    Map jyjcmxb = (Map) sp.get(i);

                    //获取最大序号
                    StringBuffer sb = new StringBuffer();
                    sb.append("SELECT MAX(kjbgdxh) kjbgdxh FROM hjyjczb zb");
                    String sql = sb.toString();
                    String[] paramName = new String[]{};
                    int[] paramType = new int[]{};
                    sql = QueryFactory.getSQL(sql, paramName, paramType, null);
                    Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
                    List list = (List) m.get(GlobalNames.SI_RESULTSET);
                    m = (Map) list.get(0);
                    //判断序号是否存在
                    if (m.size() <= 0) {
                        //如果不存在则默认为0
                        m.put("kjbgdxh", "0");
                    }

                    //获取检测主表信息
                    BeanHelper.copyProperties(dto, hjyjczb);
                    hjyjczb.setHjyjczbid(DbUtils.getSequenceStr());//id
                    hjyjczb.setKjbgdpch(hkjbgd.getKjbgdpch());  //检测批次号
                    hjyjczb.setKjbgdxh(Integer.parseInt((m.get("kjbgdxh") == null ? "" : m.get("kjbgdxh")).toString()) + 1); //报告单内容序号
                    hjyjczb.setJcypid((jyjcmxb.get("jcypid") == null ? "" : jyjcmxb.get("jcypid")).toString()); //样品Id
                    hjyjczb.setJcypmc((jyjcmxb.get("jcypmc") == null ? "" : jyjcmxb.get("jcypmc")).toString()); //样品名称
                    hjyjczb.setSbxh((jyjcmxb.get("sbxh") == null ? "" : jyjcmxb.get("sbxh")).toString()); //设备型号
                    hjyjczb.setSbxlh((jyjcmxb.get("sbxlh") == null ? "" : jyjcmxb.get("sbxlh")).toString()); //设备序列号
                    hjyjczb.setKjbgdjcjg((jyjcmxb.get("kjbgdjcjg") == null ? "" : jyjcmxb.get("kjbgdjcjg")).toString()); //检测结果
                    hjyjczb.setJcztbzjid(dto.getHviewjgztid()); //检测主体表主键id
                    hjyjczb.setAae011(sysuser.getDescription()); //操作人员
                    hjyjczb.setAae036(datetime); //操作时间
                    hjyjczb.setJyjcrq(datetime); //操作时间
                    hjyjczb = dao.insert(hjyjczb);//保存主表

                    List mxb = (List) jyjcmxb.get("hjyjcmxb"); //获取明细表 列表
                    if (mxb != null) {
                        for (int j = 0; j < mxb.size(); j++) {
                            jyjcmxb = (Map) mxb.get(j);

                            //获取明细表信息
                            hjyjcmxb.setHjyjcmxbid(DbUtils.getSequenceStr()); //明细表Id
                            hjyjcmxb.setHjyjczbid(hjyjczb.getHjyjczbid());  //关联主表Id
                            hjyjcmxb.setJcxmid((jyjcmxb.get("jcxmid") == null ? "" : jyjcmxb.get("jcxmid")).toString()); //检测项目Id
                            hjyjcmxb.setJcxmmc((jyjcmxb.get("jcxmmc") == null ? "" : jyjcmxb.get("jcxmmc")).toString()); //检测项目名称
                            hjyjcmxb.setJyjcjl((jyjcmxb.get("jyjcjl") == null ? "" : jyjcmxb.get("jyjcjl")).toString()); //检测结论
                            hjyjcmxb.setAae011(sysuser.getDescription()); //经办人
                            hjyjcmxb.setAae036(datetime);  //经办时间
                            hjyjcmxb = dao.insert(hjyjcmxb);//保存明细表
                            kjbgdxh+=1;
                            //替换表格字段
                            kuozhan += kuozhan1.replace("kjbgdxh", kjbgdxh+"")
                                    .replace("jcypmc", hjyjczb.getJcypmc() == null ? "" : hjyjczb.getJcypmc())
                                    .replace("hviewjgztmc", hjyjczb.getHviewjgztmc() == null ? "" : hjyjczb.getHviewjgztmc())
                                    .replace("comdz", hjyjczb.getComdz() == null ? "" : hjyjczb.getComdz())
                                    .replace("jiancexiangmu", hjyjcmxb.getJcxmmc() == null ? "" : hjyjcmxb.getJcxmmc())
                                    .replace("sbxh", hjyjczb.getSbxh() == null ? "" : hjyjczb.getSbxh())
                                    .replace("kjbgdjcjg", hjyjcmxb.getJyjcjl() == null ? "" : ("1".equals(hjyjcmxb.getJyjcjl()) ? "合格" : "不合格"));
                        }
                    }
                }
            }
        } else {//修改
            int kjbgdxh = 0;
            delHkjbgdImp(request, dto,"qc");//清除原数据
            //获取报告单信息
            hkjbgd.setHkjbgdid((map.get("hkjbgdid") == null ? "" : map.get("hkjbgdid")).toString()); //Id
            hkjbgd.setKjbgdpch(dto.getKjbgdpch()); //批次号
            hkjbgd.setKjbgdjcr((map.get("kjbgdjcr") == null ? "" : map.get("kjbgdjcr")).toString()); //检测人签字
            hkjbgd.setJcdwfzrqzpic((fj1 == null ? "" : fj1.getFjpath())); //检测单位负责人签字
            hkjbgd.setJcdwfzrqzrq((map.get("jcdwfzrqzrq") == null ? "" : map.get("jcdwfzrqzrq")).toString());  //检测单位签字日期
            hkjbgd.setBjcdwfzrqzpic((fj2 == null ? "" : fj2.getFjpath())); //被检单位签字
            hkjbgd.setBjcdwfzrqzrq((map.get("bjcdwfzrqzrq") == null ? "" : map.get("bjcdwfzrqzrq")).toString());  //被检单位签字日期
            hkjbgd.setCzyxm(sysuser.getDescription()); //操作员名称
            hkjbgd.setCzyid(sysuser.getUserid()); //操作员Id
            hkjbgd.setAae036(datetime); //操作时间
            dao.insert(hkjbgd); //修改报告单

            List sp = (List) map.get("sp"); //获取主表部分信息
            if (sp != null) {
                for (int i = 0; i < sp.size(); i++) {
                    Map jyjcmxb = (Map) sp.get(i);
                    //获取检测主表信息
                    BeanHelper.copyProperties(dto, hjyjczb);
                    hjyjczb.setHjyjczbid((jyjcmxb.get("hjyjczbid") == null ? "" : jyjcmxb.get("hjyjczbid")).toString()); //主表Id
                    hjyjczb.setJcypid((jyjcmxb.get("jcypid") == null ? "" : jyjcmxb.get("jcypid")).toString()); //样品Id
                    hjyjczb.setJcypmc((jyjcmxb.get("jcypmc") == null ? "" : jyjcmxb.get("jcypmc")).toString()); //样品名称
                    hjyjczb.setSbxh((jyjcmxb.get("sbxh") == null ? "" : jyjcmxb.get("sbxh")).toString()); //设备型号
                    hjyjczb.setSbxlh((jyjcmxb.get("sbxlh") == null ? "" : jyjcmxb.get("sbxlh")).toString()); //设备序列号
                    hjyjczb.setKjbgdjcjg((jyjcmxb.get("kjbgdjcjg") == null ? "" : jyjcmxb.get("kjbgdjcjg")).toString()); //检测结果
                    hjyjczb.setJcztbzjid(dto.getHviewjgztid()); //检测主体表主键id
                    hjyjczb.setAae011(sysuser.getDescription()); //操作人员
                    hjyjczb.setAae036(datetime); //操作时间
                    dao.insert(hjyjczb);//修改主表

                    List mxb = (List) jyjcmxb.get("hjyjcmxb"); //获取明细表 列表
                    if (mxb != null) {
                        for (int j = 0; j < mxb.size(); j++) {
                            jyjcmxb = (Map) mxb.get(j);


                            //获取明细表信息
                            hjyjcmxb.setHjyjcmxbid((jyjcmxb.get("hjyjcmxbid") == null ? "" : jyjcmxb.get("hjyjcmxbid")).toString()); //明细表Id
                            hjyjcmxb.setHjyjczbid(hjyjczb.getHjyjczbid());  //关联主表Id
                            hjyjcmxb.setJcxmid((jyjcmxb.get("jcxmid") == null ? "" : jyjcmxb.get("jcxmid")).toString()); //检测项目Id
                            hjyjcmxb.setJcxmmc((jyjcmxb.get("jcxmmc") == null ? "" : jyjcmxb.get("jcxmmc")).toString()); //检测项目名称
                            hjyjcmxb.setJyjcjl((jyjcmxb.get("jyjcjl") == null ? "" : jyjcmxb.get("jyjcjl")).toString()); //检测结论
                            hjyjcmxb.setAae011(sysuser.getDescription()); //经办人
                            hjyjcmxb.setAae036(datetime);  //经办时间
                            dao.insert(hjyjcmxb);//修改明细表

                            kjbgdxh+=1;
                            //替换表格字段
                            kuozhan += kuozhan1.replace("kjbgdxh", kjbgdxh+"")
                                    .replace("jcypmc", hjyjczb.getJcypmc() == null ? "" : hjyjczb.getJcypmc())
                                    .replace("hviewjgztmc", hjyjczb.getHviewjgztmc() == null ? "" : hjyjczb.getHviewjgztmc())
                                    .replace("comdz", hjyjczb.getComdz() == null ? "" : hjyjczb.getComdz())
                                    .replace("jiancexiangmu", hjyjcmxb.getJcxmmc() == null ? "" : hjyjcmxb.getJcxmmc())
                                    .replace("sbxh", hjyjczb.getSbxh() == null ? "" : hjyjczb.getSbxh())
                                    .replace("kjbgdjcjg", hjyjcmxb.getJyjcjl() == null ? "" : ("1".equals(hjyjcmxb.getJyjcjl()) ? "合格" : "不合格"));
                        }
                    }
                }
            }
        }
        String jcdwfzrqzrqyear = "";
        String jcdwfzrqzrqmonth = "";
        String jcdwfzrqzrqday = "";
        if (hkjbgd.getJcdwfzrqzrq() != null && !"".equals(hkjbgd.getJcdwfzrqzrq())) {
            jcdwfzrqzrqyear = hkjbgd.getJcdwfzrqzrq().substring(0, 4);
            jcdwfzrqzrqmonth = hkjbgd.getJcdwfzrqzrq().substring(5, 7);
            jcdwfzrqzrqday = hkjbgd.getJcdwfzrqzrq().substring(8, 10);
        }
        String bjcdwfzrqzrqyear = "";
        String bjcdwfzrqzrqmonth = "";
        String bjcdwfzrqzrqday = "";
        if (hkjbgd.getBjcdwfzrqzrq() != null && !"".equals(hkjbgd.getBjcdwfzrqzrq())) {
            bjcdwfzrqzrqyear = hkjbgd.getBjcdwfzrqzrq().substring(0, 4);
            bjcdwfzrqzrqmonth = hkjbgd.getBjcdwfzrqzrq().substring(5, 7);
            bjcdwfzrqzrqday = hkjbgd.getBjcdwfzrqzrq().substring(8, 10);
        }

        //替换表头字段
        tbodyval = tbodyinfo.replace("griddata", kuozhan)
                .replace("jcjgfzrqzpic", hkjbgd.getJcdwfzrqzpic() == null || "".equals(hkjbgd.getBjcdwfzrqzpic()) ? "" : contextPath + hkjbgd.getJcdwfzrqzpic())
                .replace("jcjgfzrqzrqyear", jcdwfzrqzrqyear == null ? "" : jcdwfzrqzrqyear)
                .replace("jcjgfzrqzrqmonth", jcdwfzrqzrqmonth == null ? "" : jcdwfzrqzrqmonth)
                .replace("jcjgfzrqzrqday", jcdwfzrqzrqday == null ? "" : jcdwfzrqzrqday)
                .replace("kjbgdjcr", hkjbgd.getKjbgdjcr() == null ? "" : hkjbgd.getKjbgdjcr())
                .replace("bjcdwfzrqzpic", hkjbgd.getBjcdwfzrqzpic() == null || "".equals(hkjbgd.getBjcdwfzrqzpic()) ? "" : contextPath + hkjbgd.getBjcdwfzrqzpic())
                .replace("bjcdwfzrqzrqyear", bjcdwfzrqzrqyear == null ? "" : bjcdwfzrqzrqyear)
                .replace("bjcdwfzrqzrqmonth", bjcdwfzrqzrqmonth == null ? "" : bjcdwfzrqzrqmonth)
                .replace("bjcdwfzrqzrqday", bjcdwfzrqzrqday == null ? "" : bjcdwfzrqzrqday);

        hkjbgd.setKjbgdprint(tbodyval);
        dao.update(hkjbgd); //修改报告单
    }

    /**
     * 删除快检报告
     *
     * @param request
     * @param dto
     * @return
     */
    public String delHkjbgd(HttpServletRequest request, HjyjczbDTO dto) {
        try {
            if (null != dto.getKjbgdpch()) {
                delHkjbgdImp(request, dto,"");
            } else {
                return "没有接收到要删除的快检批次号！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * 删除快检报告
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    @Aop({"trans"})
    public void delHkjbgdImp(HttpServletRequest request, HjyjczbDTO dto,String str) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.hkjbgdid,b.hjyjczbid, c.hjyjcmxbid");
        sb.append(" FROM hkjbgd a LEFT JOIN hjyjczb b ON a.kjbgdpch = b.kjbgdpch  ");
        sb.append(" LEFT JOIN hjyjcmxb c ON b.hjyjczbid = c.hjyjczbid ");
        sb.append(" WHERE a.kjbgdpch=:kjbgdpch");
        String sql = sb.toString();
        String[] paramName = new String[]{"kjbgdpch"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        for (int i = 0; i < list.size(); i++) {
            Map mp1 = (Map) list.get(i);
            if (i > 0) {
                Map mp2 = (Map) list.get(i - 1);
                if (!mp1.get("hkjbgdid").equals(mp2.get("hkjbgdid"))) {
                    dao.clear(Hkjbgd.class, Cnd.where("hkjbgdid", "=", mp1.get("hkjbgdid")));
                }
                if (!mp1.get("hjyjczbid").equals(mp2.get("hjyjczbid"))) {
                    dao.clear(Hjyjczb.class, Cnd.where("hjyjczbid", "=", mp1.get("hjyjczbid")));
                }
            } else {
                dao.clear(Hkjbgd.class, Cnd.where("hkjbgdid", "=", mp1.get("hkjbgdid")));
                dao.clear(Hjyjczb.class, Cnd.where("hjyjczbid", "=", mp1.get("hjyjczbid")));
                if(!"qc".equals(str)){
                    dao.clear(Fj.class, Cnd.where("fjwid", "=", mp1.get("hkjbgdid")));
                }
            }
            dao.clear(Hjyjcmxb.class, Cnd.where("hjyjcmxbid", "=", mp1.get("hjyjcmxbid")));
        }
    }

    /**
     * 查询快检报告数据
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryHkjbgd(HjyjczbDTO dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        HjyjczbDTO jyjczb = new HjyjczbDTO();
        Map map = new HashMap();
        Map m = new HashMap();
        if(dto==null || dto.getKjbgdpch()==null || "".equals(dto.getKjbgdpch())){//查询列表
            sb.append(" select a.hkjbgdid, b.hviewjgztmc,a.kjbgdpch,a.aae036,a.kjbgdjcr from hkjbgd a LEFT JOIN hjyjczb b ");
            sb.append(" on a.kjbgdpch = b.kjbgdpch GROUP BY a.kjbgdpch ORDER BY a.hkjbgdid desc");

            String sql = sb.toString();
            String[] paramName = new String[]{"kjbgdpch"};
            int[] paramType = new int[]{Types.VARCHAR};
            sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
            m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null,
                    pd.getPage(), pd.getRows());
            List list = (List) m.get(GlobalNames.SI_RESULTSET);

            map.put("rows", list);
            map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        }else {     //查询单个
            //查询快检报告单表
            sb = new StringBuffer();
            sb.append(" select hkjbgdid,kjbgdpch,jcdwfzrqzpic,jcdwfzrqzrq,kjbgdjcr,bjcdwfzrqzpic,bjcdwfzrqzrq from hkjbgd where 1=1 ");
            sb.append(" and  kjbgdpch= :kjbgdpch");

            String sql = sb.toString();
            String[] paramName = new String[]{"kjbgdpch"};
            int[] paramType = new int[]{Types.VARCHAR};
            sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
            m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Hkjbgd.class,
                    pd.getPage(), pd.getRows());
            List<Hkjbgd> list1 = (List) m.get(GlobalNames.SI_RESULTSET);
            map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));

            Map m1 = new HashMap();
            if (list1 != null) {
                //写入map中
                Hkjbgd hkjbgd = list1.get(0);

                m1.put("hkjbgdid", hkjbgd.getHkjbgdid());
                m1.put("kjbgdpch", hkjbgd.getKjbgdpch());
                m1.put("jcdwfzrqzpic", hkjbgd.getJcdwfzrqzpic());
                m1.put("jcdwfzrqzrq", hkjbgd.getJcdwfzrqzrq());
                m1.put("kjbgdjcr", hkjbgd.getKjbgdjcr());
                m1.put("bjcdwfzrqzpic", hkjbgd.getBjcdwfzrqzpic());
                m1.put("bjcdwfzrqzrq", hkjbgd.getBjcdwfzrqzrq());

                //查询检测主表
                sb = new StringBuffer();
                sb.append("select hjyjczbid,hviewjgztid,hviewjgztmc,jcypid,jcypmc,sbxh, ");
                sb.append(" sbxlh,comdz,kjbgdjcjg,kjbgdxh,aaa027 ");
                sb.append(" from hjyjczb where kjbgdpch=:kjbgdpch");
                sql = sb.toString();
                paramName = new String[]{"kjbgdpch"};
                paramType = new int[]{Types.VARCHAR};
                sql = QueryFactory.getSQL(sql, paramName, paramType, hkjbgd, pd);
                m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Hjyjczb.class,
                        pd.getPage(), pd.getRows());
                List<Hjyjczb> list2 = (List) m.get(GlobalNames.SI_RESULTSET);

                List lis1 = new ArrayList();
                if (list2 != null) {
                    for (int i = 0; i < list2.size(); i++) {
                        Map m2 = new HashMap();
                        Hjyjczb hjyjczb = list2.get(i);

                        jyjczb.setHviewjgztid(hjyjczb.getHviewjgztid());
                        jyjczb.setHviewjgztmc(hjyjczb.getHviewjgztmc());
                        jyjczb.setComdz(hjyjczb.getComdz());
                        jyjczb.setAaa027(hjyjczb.getAaa027());

                        m2.put("hjyjczbid", hjyjczb.getHjyjczbid());
                        m2.put("jcypid", hjyjczb.getJcypid());
                        m2.put("jcypmc", hjyjczb.getJcypmc());
                        m2.put("sbxh", hjyjczb.getSbxh());
                        m2.put("sbxlh", hjyjczb.getSbxlh());
                        m2.put("kjbgdjcjg", hjyjczb.getKjbgdjcjg());
                        m2.put("kjbgdxh", hjyjczb.getKjbgdxh());

                        //查询检测明细表
                        sb = new StringBuffer();
                        sb.append("select hjyjcmxbid,jcxmid,jcxmmc,jyjcjl ");
                        sb.append(" from hjyjcmxb where 1=1 ");
                        sb.append("  and hjyjczbid=:hjyjczbid");
                        sql = sb.toString();
                        paramName = new String[]{"hjyjczbid"};
                        paramType = new int[]{Types.VARCHAR};
                        sql = QueryFactory.getSQL(sql, paramName, paramType, hjyjczb, pd);
                        m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Hjyjcmxb.class,
                                pd.getPage(), pd.getRows());
                        List<Hjyjcmxb> list3 = (List) m.get(GlobalNames.SI_RESULTSET);

                        List lis2 = new ArrayList();
                        if (list3 != null) {
                            for (int j = 0; j < list3.size(); j++) {
                                Map m3 = new HashMap();
                                Hjyjcmxb hjyjcmxb = list3.get(j);

                                m3.put("hjyjcmxbid", hjyjcmxb.getHjyjcmxbid());
                                m3.put("jcxmid", hjyjcmxb.getJcxmid());
                                m3.put("jcxmmc", hjyjcmxb.getJcxmmc());
                                m3.put("jyjcjl", hjyjcmxb.getJyjcjl());
                                lis2.add(j, m3);
                            }
                        }
                        m2.put("hjyjcmxb", lis2);
                        lis1.add(i, m2);
                    }
                }
                m1.put("sp", lis1);
            }
            String jsonString =JSON.toJSONString(m1);
//            JSONObject jsonObject = JSONObject.fromObject(m1);
            jyjczb.setKjdata(jsonString);
            map.put("rows", jyjczb);
        }
        return map;
    }

    /**
     * 查询快检报告单
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public String queryKjbgdprint(Hkjbgd dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT kjbgdprint FROM hkjbgd WHERE hkjbgdid= :hkjbgdid");
        String sql = sb.toString();
        String[] paramName = new String[]{"hkjbgdid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null,
                pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = (Map) list.get(0);
        return map.get("kjbgdprint").toString();
    }

    /**
     * 生成打印HTML页面
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    private BsTbodyInfoDTo getTbodyInfo(HttpServletRequest request, BsTbodyInfoDTo dto) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* from bstbodyinfo a ");
        sb.append("  where 1=1 ");
        sb.append("   and a.tbodytype = :tbodytype  and a.tbodycode= :tbodycode and a.aaa027 like :aaa027 ");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"tbodytype", "tbodycode", "aaa027"};
        int[] paramType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsTbodyInfoDTo.class);
        List<BsTbodyInfoDTo> list = (List<BsTbodyInfoDTo>) m.get(GlobalNames.SI_RESULTSET);
        if (list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    /**
     * 查询快检检测项目
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryKjjcxm(JyjcxmDTO dto, PagesDTO pd) throws Exception {
        //拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT jyjcxmid,jcxmmc FROM jyjcxm WHERE jyjcxmlx='2' AND sfmulu='0' ");
        String sql = sb.toString();
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcxmDTO.class,
                pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }
}
