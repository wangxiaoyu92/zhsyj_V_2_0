package com.askj.oa.service;

import com.askj.oa.dto.OaemailDTO;
import com.askj.oa.dto.OaemailmanDTO;
import com.askj.oa.dto.OareportDTO;
import com.askj.oa.dto.OareportmanDTO;
import com.askj.oa.entity.Oaemail;
import com.askj.oa.entity.Oaemailman;
import com.askj.oa.entity.Oareport;
import com.askj.oa.entity.Oareportman;
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
 *
 *  OaemailService的中文名称：站内信
 *
 *
 *  Written  by  : zk
 */
public class OaemailService extends BaseService {

    protected final Logger logger = Logger.getLogger(OaemailService .class);
    @Inject
    private Dao dao;


    /**
     * queryOaemail的中文名称：站内信发件箱查询
     * <p>
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryOaemailSend(HttpServletRequest request, OaemailDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oaemailid,a.emailcontent,DATE_FORMAT(a.aae036,'%Y-%m-%d %h:%i:%s') aae036,(select c.description from sysuser c where c.userid=a.aae011) aae011");
        sb.append(" from oaemail a  ");
        sb.append(" where 1=1  ");
        sb.append("  and a.oaemailid = :oaemailid ");
        sb.append("  and a.emailcontent like :emailcontent ");
        sb.append("  and a.sfyx = '1' ");
        sb.append(" and a.aae011 = '" +vSysUser.getUserid() + "'");
        sb.append(" order by a.aae036 desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oaemailid","emailcontent"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OaemailDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++) {
                OaemailDTO o = new OaemailDTO();
                o = (OaemailDTO)list.get(i);
                List list2=queryOaemailman(o);
                String s1="";
                String s2="";
                String s3="";
                for(int j=0;j<list2.size();j++){
                    OaemailmanDTO oa = new OaemailmanDTO();
                    oa=(OaemailmanDTO)list2.get(j);
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
                        if("0".equals(oa.getSfyd())) {
                            s3 = oa.getAae011()+"未读";
                        }else{
                            s3 = oa.getAae011()+"已读";
                        }
                    }else{
                        if("0".equals(oa.getSfyd())) {
                            s3 = s3+","+oa.getAae011()+"未读";
                        }else{
                            s3 = s3+","+oa.getAae011()+"已读";
                        }
                    }

                }
                o.setTxr(s3);
                o.setZxrUserid(s1);
                o.setZxr(s2);
            }
        }
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryOaemail的中文名称：站内信发件箱查询
     * <p>
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryOaemailGet(HttpServletRequest request, OaemailDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oaemailid,a.emailcontent,DATE_FORMAT(a.aae036,'%Y-%m-%d %h:%i:%s') aae036,(select c.description from sysuser c where c.userid=a.aae011) aae011,");
        sb.append(" b.oaemailmanid  ");
        sb.append(" from oaemail a  ");
        sb.append(" left join oaemailman b on b.oaemailid=a.oaemailid ");
        sb.append(" where 1=1  ");
        sb.append("  and a.oaemailid = :oaemailid ");
        sb.append("  and a.emailcontent like :emailcontent ");
        sb.append("  and a.sfyx = '1' ");
        sb.append("  and b.sfyd = :sfyd ");
        sb.append(" and b.userid = '" +vSysUser.getUserid() + "'");
        sb.append(" order by a.aae036 desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oaemailid","emailcontent","sfyd"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OaemailDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++) {
                OaemailDTO o = new OaemailDTO();
                o = (OaemailDTO)list.get(i);
                List list2=queryOaemailman(o);
                String s1="";
                String s2="";
                String s3="";
                for(int j=0;j<list2.size();j++){
                    OaemailmanDTO oa = new OaemailmanDTO();
                    oa=(OaemailmanDTO)list2.get(j);
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
                        if("0".equals(oa.getSfyd())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "未读";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "已读";
                            }
                        }
                    }else{
                        if("0".equals(oa.getSfyd())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "未读";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "已读";
                            }
                        }
                    }

                }
                o.setTxr(s3);
                o.setZxrUserid(s1);
                o.setZxr(s2);
            }
        }
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryOaemailman的中文名称：站内信发件箱查询
     * <p>
     *
     * @param dto
     * @return
     * @throws Exception
     */
    public List queryOaemailman( OaemailDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.userid,a.sfyd,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.userid) aae011 ");
        sb.append(" from oaemailman a  ");
        sb.append(" where 1=1  ");
        sb.append(" and a.oaemailid= :oaemailid ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oaemailid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OaemailmanDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        return list;
    }

    /**
     * addOaemail     添加站内信的方法
     *
     * @param request
     * @param dto
     * @return
     */
    public String addOaemail(HttpServletRequest request, OaemailDTO dto) {
        try {
            addOaemailImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void addOaemailImp(HttpServletRequest request, OaemailDTO dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oaemailid = "";
        if (null != dto.getOaemailid() && !"".equals(dto.getOaemailid())) {
            Oaemail oaemail = dao.fetch(Oaemail.class, dto.getOaemailid());
            Oaemailman oaemailman = new Oaemailman();
            oaemail.setEmailcontent(dto.getEmailcontent());
            dao.update(oaemail);

            // 添加执行人
            String zxrUserid = dto.getZxrUserid();
            String[] zxr = zxrUserid.split(",");
            String currTime = SysmanageUtil.getDbtimeYmdHns();
            dao.clear(Oaemailman.class, Cnd.where("oaemailid", "=", oaemail.getOaemailid()));
            for (int i = 0; i < zxr.length; i++) {
                String oaemailmanid = DbUtils.getSequenceStr();
                oaemailman.setUserid(zxr[i]);
                oaemailman.setAae011(v_user.getUserid());
                oaemailman.setAae036(currTime);
                oaemailman.setOaemailmanid(oaemailmanid);
                oaemailman.setOaemailid(oaemail.getOaemailid());
                oaemailman.setSfyd("0");
                dao.insert(oaemailman);
               /* dto.setTxr(zxr[i]);
                dto.setOataskmanid(oataskmanid);
                dto.setAae011(v_user.getUserid());
                dto.setAae036(currTime);
                oaNoticeManagerApiService.OaNotice(request, dto, "1");*/
            }

        } else {
            // 添加任务
            String currTime = SysmanageUtil.getDbtimeYmdHns();
            // 任务表
            Oaemail v_oaemail = new Oaemail();
            // 任务关联人表
            Oaemailman v_oaemailman = new Oaemailman();
            v_oaemail.setOaemailid(dto.getId());
            v_oaemail.setEmailcontent(dto.getEmailcontent());
            v_oaemail.setAae011(v_user.getUserid());
            v_oaemail.setAae036(currTime);
            v_oaemail.setSfyx("1");
            dao.insert(v_oaemail);



            // 添加执行人
            String zxrUserid = dto.getZxrUserid();
            if (null != zxrUserid && !"".equals(zxrUserid)) {
                String[] zxr = zxrUserid.split(",");
                for (int i = 0; i < zxr.length; i++) {
                    String oaemailmanid = DbUtils.getSequenceStr();
                    v_oaemailman.setUserid(zxr[i]);
                    v_oaemailman.setAae011(v_user.getUserid());
                    v_oaemailman.setAae036(currTime);
                    v_oaemailman.setOaemailmanid(oaemailmanid);
                    v_oaemailman.setOaemailid(v_oaemail.getOaemailid());
                    v_oaemailman.setSfyd("0");
                    dao.insert(v_oaemailman);
                   /* dto.setTxr(zxr[i]);
                    dto.setOataskmanid(oataskmanid);
                    dto.setAae011(v_user.getUserid());
                    dto.setAae036(currTime);
                    oaNoticeManagerApiService.OaNotice(request, dto, "1");*/
                }
            }
        }
       /* sjbService.jpushNotice(request);*/
    }


    /**
     * backOaemail     回复站内信的方法
     *
     * @param request
     * @param dto
     * @return
     */
    public String backOaemail(HttpServletRequest request, OaemailDTO dto) {
        try {
            backOaemailImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void backOaemailImp(HttpServletRequest request, OaemailDTO dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oaemailid = "";
        // 添加任务
        String currTime = SysmanageUtil.getDbtimeYmdHns();
        // 任务表
        Oaemail v_oaemail = new Oaemail();
        // 任务关联人表
        Oaemailman v_oaemailman = new Oaemailman();
        v_oaemail.setOaemailid(dto.getId());
        v_oaemail.setEmailcontent(dto.getEmailcontent());
        v_oaemail.setAae011(v_user.getUserid());
        v_oaemail.setAae036(currTime);
        v_oaemail.setSfyx("1");
        dao.insert(v_oaemail);
        Oaemail oaemail = dao.fetch(Oaemail.class, dto.getOaemailid());
        String oaemailmanid = DbUtils.getSequenceStr();
        v_oaemailman.setUserid(oaemail.getAae011());
        v_oaemailman.setAae011(v_user.getUserid());
        v_oaemailman.setAae036(currTime);
        v_oaemailman.setOaemailmanid(oaemailmanid);
        v_oaemailman.setOaemailid(v_oaemail.getOaemailid());
        v_oaemailman.setSfyd("0");
        dao.insert(v_oaemailman);



                   /* dto.setTxr(zxr[i]);
                    dto.setOataskmanid(oataskmanid);
                    dto.setAae011(v_user.getUserid());
                    dto.setAae036(currTime);
                    oaNoticeManagerApiService.OaNotice(request, dto, "1");*/

        /* sjbService.jpushNotice(request);*/
    }

    /**
     * updateoaemailman     站内信标记为已读的方法
     *
     * @param request
     * @param dto
     * @return
     */
    public String updateoaemailman(HttpServletRequest request, OaemailmanDTO dto) {
        try {
            updateoaemailmanImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void updateoaemailmanImp(HttpServletRequest request,  OaemailmanDTO  dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        Oaemailman oaemailman = dao.fetch(Oaemailman.class, dto.getOaemailmanid());
        oaemailman.setSfyd("1");
        dao.update(oaemailman);
    }

    /**
     * delOaemail    删除站内信
     *
     * @param request
     * @param dto
     * @return
     */
    public String delOaemail(HttpServletRequest request, OaemailDTO dto) {
        try {
            if (null != dto.getOaemailid()) {
                delOaemailImp(request, dto);
            } else {
                return "没有接收到要删除的站内信id！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    private void delOaemailImp(HttpServletRequest request, OaemailDTO dto) {
        Oaemail oaemail = new Oaemail();
        oaemail = dao.fetch(Oaemail.class, Cnd.where("oaemailid", "=", dto.getOaemailid()));
        oaemail.setSfyx("0");
        dao.update(oaemail);
    }

    /**
     * queryOareportsend的中文名称：工作上报查询
     * <p>
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryOareportSend(HttpServletRequest request, OareportDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oareportid,a.reportcontent,DATE_FORMAT(a.aae036,'%Y-%m-%d %h:%i:%s') aae036,(select c.description from sysuser c where c.userid=a.aae011) aae011");
        sb.append(" from oareport a  ");
        sb.append(" where 1=1  ");
        sb.append("  and a.oareportid = :oareportid ");
        sb.append("  and a.reportcontent like :reportcontent ");
        sb.append("  and a.sfyx = '1' ");
        sb.append(" and a.aae011 = '" +vSysUser.getUserid() + "'");
        sb.append(" order by a.aae036 desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oareportid","reportcontent"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OareportDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++) {
                OareportDTO o = new OareportDTO();
                o = (OareportDTO)list.get(i);
                List list2=queryOareportman(o);
                String s1="";
                String s2="";
                String s3="";
                for(int j=0;j<list2.size();j++){
                    OareportmanDTO oa = new OareportmanDTO();
                    oa=(OareportmanDTO)list2.get(j);
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
                        if("0".equals(oa.getSfyd())) {
                            s3 = oa.getAae011()+"未读";
                        }else{
                            s3 = oa.getAae011()+"已读";
                        }
                    }else{
                        if("0".equals(oa.getSfyd())) {
                            s3 = s3+","+oa.getAae011()+"未读";
                        }else{
                            s3 = s3+","+oa.getAae011()+"已读";
                        }
                    }

                }
                o.setTxr(s3);
                o.setZxrUserid(s1);
                o.setZxr(s2);
            }
        }
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryOaemail的中文名称：工作上报发件箱查询
     * <p>
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     */
    public Map queryOareportGet(HttpServletRequest request, OareportDTO dto, PagesDTO pd) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.oareportid,a.reportcontent,DATE_FORMAT(a.aae036,'%Y-%m-%d %h:%i:%s') aae036,(select c.description from sysuser c where c.userid=a.aae011) aae011,");
        sb.append(" b.oareportmanid  ");
        sb.append(" from oareport a  ");
        sb.append(" left join oareportman b on b.oareportid=a.oareportid ");
        sb.append(" where 1=1  ");
        sb.append("  and a.oareportid = :oareportid ");
        sb.append("  and b.sfyd = :sfyd ");
        sb.append("  and a.reportcontent like :reportcontent ");
        sb.append("  and a.sfyx = '1' ");
        sb.append(" and b.userid = '" +vSysUser.getUserid() + "'");
        sb.append(" order by a.aae036 desc");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oareportid","reportcontent","sfyd"};
        int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OareportDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        if(list!=null&&list.size()>0){
            for(int i=0;i<list.size();i++) {
                OareportDTO o = new OareportDTO();
                o = (OareportDTO)list.get(i);
                List list2=queryOareportman(o);
                String s1="";
                String s2="";
                String s3="";
                for(int j=0;j<list2.size();j++){
                    OareportmanDTO oa = new OareportmanDTO();
                    oa=(OareportmanDTO)list2.get(j);
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
                        if("0".equals(oa.getSfyd())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "未读";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "已读";
                            }
                        }
                    }else{
                        if("0".equals(oa.getSfyd())) {
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "未读";
                            }
                        }else{
                            if(oa.getUserid().equals(vSysUser.getUserid())) {
                                s3 = "已读";
                            }
                        }
                    }

                }
                o.setTxr(s3);
                o.setZxrUserid(s1);
                o.setZxr(s2);
            }
        }
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryOareportman的中文名称：工作上报发件箱查询
     * <p>
     *
     * @param dto
     * @return
     * @throws Exception
     */
    public List queryOareportman( OareportDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.userid,a.sfyd,");
        sb.append(" (SELECT s.DESCRIPTION from sysuser s where s.USERID=a.userid) aae011 ");
        sb.append(" from oareportman a  ");
        sb.append(" where 1=1  ");
        sb.append(" and a.oareportid= :oareportid ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"oareportid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, OareportmanDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        return list;
    }

    /**
     * addOaemail     添加站内信的方法
     *
     * @param request
     * @param dto
     * @return
     */
    public String addOareport(HttpServletRequest request, OareportDTO dto) {
        try {
            addOareportImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void addOareportImp(HttpServletRequest request, OareportDTO dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oareportid = "";
        if (null != dto.getOareportid() && !"".equals(dto.getOareportid())) {
            Oareport oareport = dao.fetch(Oareport.class, dto.getOareportid());
            Oareportman oareportman = new Oareportman();
            oareport.setReportcontent(dto.getReportcontent());
            dao.update(oareport);

            // 添加执行人
            String zxrUserid = dto.getZxrUserid();
            String[] zxr = zxrUserid.split(",");
            String currTime = SysmanageUtil.getDbtimeYmdHns();
            dao.clear(Oareportman.class, Cnd.where("oareportid", "=", oareport.getOareportid()));
            for (int i = 0; i < zxr.length; i++) {
                String oaemailmanid = DbUtils.getSequenceStr();
                oareportman.setUserid(zxr[i]);
                oareportman.setAae011(v_user.getUserid());
                oareportman.setAae036(currTime);
                oareportman.setOareportmanid(oaemailmanid);
                oareportman.setOareportid(oareport.getOareportid());
                oareportman.setSfyd("0");
                dao.insert(oareportman);
               /* dto.setTxr(zxr[i]);
                dto.setOataskmanid(oataskmanid);
                dto.setAae011(v_user.getUserid());
                dto.setAae036(currTime);
                oaNoticeManagerApiService.OaNotice(request, dto, "1");*/
            }

        } else {
            // 添加任务
            String currTime = SysmanageUtil.getDbtimeYmdHns();
            // 任务表
            Oareport v_oareport = new Oareport();
            // 任务关联人表
            Oareportman v_oareportman = new Oareportman();
            v_oareport.setOareportid(dto.getId());
            v_oareport.setReportcontent(dto.getReportcontent());
            v_oareport.setAae011(v_user.getUserid());
            v_oareport.setAae036(currTime);
            v_oareport.setSfyx("1");
            dao.insert(v_oareport);



            // 添加执行人
            String zxrUserid = dto.getZxrUserid();
            if (null != zxrUserid && !"".equals(zxrUserid)) {
                String[] zxr = zxrUserid.split(",");
                for (int i = 0; i < zxr.length; i++) {
                    String oareportmanid = DbUtils.getSequenceStr();
                    v_oareportman.setUserid(zxr[i]);
                    v_oareportman.setAae011(v_user.getUserid());
                    v_oareportman.setAae036(currTime);
                    v_oareportman.setOareportmanid(oareportmanid);
                    v_oareportman.setOareportid(v_oareport.getOareportid());
                    v_oareportman.setSfyd("0");
                    dao.insert(v_oareportman);
                   /* dto.setTxr(zxr[i]);
                    dto.setOataskmanid(oataskmanid);
                    dto.setAae011(v_user.getUserid());
                    dto.setAae036(currTime);
                    oaNoticeManagerApiService.OaNotice(request, dto, "1");*/
                }
            }
        }
        /* sjbService.jpushNotice(request);*/
    }


    /**
     * backOaemail     回复站内信的方法
     *
     * @param request
     * @param dto
     * @return
     */
    public String backOareport(HttpServletRequest request, OareportDTO dto) {
        try {
            backOareportImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void backOareportImp(HttpServletRequest request, OareportDTO dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        String oareportid = "";
        // 添加任务
        String currTime = SysmanageUtil.getDbtimeYmdHns();
        // 任务表
        Oareport v_oareport = new Oareport();
        // 任务关联人表
        Oareportman v_oareportman = new Oareportman();
        v_oareport.setOareportid(dto.getId());
        v_oareport.setReportcontent(dto.getReportcontent());
        v_oareport.setAae011(v_user.getUserid());
        v_oareport.setAae036(currTime);
        v_oareport.setSfyx("1");
        dao.insert(v_oareport);
        Oareport oareport = dao.fetch(Oareport.class, dto.getOareportid());
        String oareportmanid = DbUtils.getSequenceStr();
        v_oareportman.setUserid(oareport.getAae011());
        v_oareportman.setAae011(v_user.getUserid());
        v_oareportman.setAae036(currTime);
        v_oareportman.setOareportmanid(oareportmanid);
        v_oareportman.setOareportid(v_oareport.getOareportid());
        v_oareportman.setSfyd("0");
        dao.insert(v_oareportman);



                   /* dto.setTxr(zxr[i]);
                    dto.setOataskmanid(oataskmanid);
                    dto.setAae011(v_user.getUserid());
                    dto.setAae036(currTime);
                    oaNoticeManagerApiService.OaNotice(request, dto, "1");*/

        /* sjbService.jpushNotice(request);*/
    }

    /**
     * updateoaemailman     站内信标记为已读的方法
     *
     * @param request
     * @param dto
     * @return
     */
    public String updateoareportman(HttpServletRequest request, OareportmanDTO dto) {
        try {
            updateoareportmanImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    private void updateoareportmanImp(HttpServletRequest request,  OareportmanDTO  dto) throws Exception {
        Sysuser v_user = SysmanageUtil.getSysuser();
        Oareportman oareportman = dao.fetch(Oareportman.class, dto.getOareportmanid());
        oareportman.setSfyd("1");
        dao.update(oareportman);
    }

    /**
     * delOareport    删除站内信
     *
     * @param request
     * @param dto
     * @return
     */
    public String delOareport(HttpServletRequest request, OareportDTO dto) {
        try {
            if (null != dto.getOareportid()) {
                delOareportImp(request, dto);
            } else {
                return "没有接收到要删除的工作上报id！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    private void delOareportImp(HttpServletRequest request, OareportDTO dto) {
        Oareport oareport = new Oareport();
        oareport = dao.fetch(Oareport.class, Cnd.where("oareportid", "=", dto.getOareportid()));
        oareport.setSfyx("0");
        dao.update(oareport);
    }


}
