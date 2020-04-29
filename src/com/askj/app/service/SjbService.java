package com.askj.app.service;

import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.dto.PfjcsDTO;
import com.askj.baseinfo.dto.PwfxwcsDTO;
import com.askj.baseinfo.entity.Viewzfry;
import com.askj.emergency.dto.EmeventcheckinDTO;
import com.askj.jk.dto.JkDTO;
import com.askj.ncjtjc.dto.CsDTO;
import com.askj.ncjtjc.dto.ZyDTO;
import com.askj.oa.dto.OanoticemanagerDTO;
import com.askj.oa.entity.Oanoticemanager;
import com.askj.spsy.dto.PcomsymurlDTO;
import com.askj.spsy.dto.QproductDTO;
import com.askj.spsy.dto.QsymqrylogDTO;
import com.askj.spsy.entity.Qproductjc;
import com.askj.spsy.entity.Qproductszgcxx;
import com.askj.spsy.entity.Qsymqrylog;
import com.askj.spsy.entity.Qsymscmxb;
import com.askj.supervision.dto.*;
import com.askj.supervision.entity.Pzfposition;
import com.askj.zfba.dto.ZfajdjDTO;
import com.askj.zfba.dto.Zfwswpqd37DTO;
import com.askj.zfba.entity.Zfajcbr;
import com.askj.zfba.entity.Zfajdj;
import com.askj.zfba.entity.Zfwsxcjcbl8;
import com.askj.zfba.service.pub.WsgldyService;
import com.askj.zx.entity.Zxpdxmcs;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.util.StringUtils;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.Sys;
import com.zzhdsoft.siweb.dto.Aa10DTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.UploadfjDTO;
import com.zzhdsoft.siweb.dto.news.NewsDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Bord;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.sysmanager.*;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.siweb.service.sysmanager.SysEasemobService;
import com.zzhdsoft.utils.*;
import com.zzhdsoft.utils.Base64;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;
import com.zzhdsoft.utils.push.JPushAllUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Condition;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.beans.PropertyDescriptor;
import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * SjbService的中文名称：司机宝Service
 * <p>
 * SjbService的描述：
 * <p>
 * Written by : zjf
 */
public class SjbService extends BaseService {
    protected final Logger logger = Logger.getLogger(SjbService.class);

    @Inject
    private Dao dao;

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * getAa10List的中文名称：查询系统代码表AA10
     * <p>
     * getAa10List的概要说明：
     *
     * @return
     * @throws Exception Written by : zy
     */
    public List getAa10List(String aaa100) throws Exception {
        // sql查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from Aa10 a ");
        sb.append(" WHERE a.AAA100 = '").append(aaa100.toUpperCase())
                .append("'");
        sb.append(" order by a.AAA102 ASC ");
        String sql = sb.toString();
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa10.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        Iterator<Aa10> it = ls.iterator();
        List list = new ArrayList();
        while (it.hasNext()) {
            Aa10 aa10 = it.next();
            Map m = new TreeMap();
            m.put("id", aa10.getAaa102());
            m.put("text", aa10.getAaa103());
            list.add(m);
        }
        return list;
    }

    public List getAa10Liststr(String aaa100, String aaa104, String planid) throws Exception {
        // sql查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from Aa10 a ");
        sb.append(" WHERE a.AAA100 = '").append(aaa100.toUpperCase())
                .append("'");
        if (!"".equals(aaa104) && aaa104 != null) {
            sb.append(" and aaa104= ").append(aaa104);
        }
        //gu20180425
        if (StringUtils.isNotEmpty(planid)) {
            sb.append(" and exists ( select 1 from bscheckplan t1 where t1.planid='" + planid + "' and find_in_set(a.aaz093,t1.plantypearea)) ");
        }
        ;
        sb.append(" and a.yxbz='1' ");//gu20180520
        sb.append(" order by a.AAA102 ASC ");
        String sql = sb.toString();
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa10.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        Iterator<Aa10> it = ls.iterator();
        List list = new ArrayList();
        while (it.hasNext()) {
            Aa10 aa10 = it.next();
            Map m = new TreeMap();
            m.put("id", aa10.getAaa102());
            m.put("text", aa10.getAaa103());
            list.add(m);
        }
        return list;
    }

    /**
     * queryAjdjZxpd征信评定
     * <p>
     * queryAjdjZxpd征信评定
     *
     * @return Written by : zy
     * @throws Exception
     */
    public List queryAjdjZxpd(HttpServletRequest request) throws Exception {

        //
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from zxpdxmcs a ");
        sb.append(" order by a.xmcsid desc ");
        String sql = sb.toString();
        //
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, Zxpdxmcs.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        Iterator<Zxpdxmcs> it = ls.iterator();
        List list = new ArrayList();
        while (it.hasNext()) {
            Zxpdxmcs zx = it.next();
            Map m = new TreeMap();
            m.put("id", zx.getXmcsbm());
            m.put("text", zx.getXmcsmc());
            list.add(m);
        }
        return list;
    }

    /**
     * getAa10List的中文名称：查询系统代码表AA10
     * <p>
     * getAa10List的概要说明：
     *
     * @return
     * @throws Exception Written by : tmm ,String userid
     */
    public List getAa10ListByaaa101(Aa10DTO dto) throws Exception {
        // sql查询语句
        StringBuffer sb = new StringBuffer();
        sb.append("  select   a.aaa102 comdalei , a.*  ");
        if (dto.getUserid() != null && !"".equals(dto.getUserid())) {
            sb.append(" , (select b.ORGID  from sysuser b where b.USERID= '")
                    .append(dto.getUserid()).append("') ORGID   ");
            sb.append(" , (select c.AAA027  from sysuser c where c.USERID= '")
                    .append(dto.getUserid()).append("') AAA027   ");
        }
        sb.append(" from Aa10 a WHERE a.AAA100 = '")
                .append(dto.getAaa100().toUpperCase()).append("'");
        sb.append(" and a.AAA101 = '").append(dto.getAaa101().toUpperCase())
                .append("'");
        sb.append(" order by a.AAA105 , a.AAA102,a.aaa104 asc  ");
        String sql = sb.toString();
        Map map = new HashMap();
        if (dto.getUserid() != null && !"".equals(dto.getUserid())) {
            map = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, Aa10DTO.class, 0, 0, dto.getUserid(), "'',comdalei,''");
        } else {
            map = DbUtils.DataQuery(GlobalNames.sql, sql, null, Aa10DTO.class);
        }

        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        List list = new ArrayList();
        if (ls.size() > 0) {
            Iterator<Aa10DTO> it = ls.iterator();
            while (it.hasNext()) {
                Aa10DTO aa10 = it.next();
                Map m = new TreeMap();
                m.put("id", aa10.getAaa102());
                m.put("text", aa10.getAaa103());
                m.put("aaz093", aa10.getAaz093());
                list.add(m);
            }
            return list;
        }
        return list;
    }

    /**
     * querySysuser的中文名称：查询系统用户
     * <p>
     * querySysuser的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    public Map querySysuser(SysuserDTO dto, PagesDTO pd) throws Exception {
        //查询登陆类别
        Aa01 aa01 = SysmanageUtil.getAa01("LOGIN");
        //按照机构暂时区分登陆功能权限
        StringBuffer sb = new StringBuffer();
        sb.append(" select userid, username, passwd, description,userkind, ");
        sb.append(" lockstate,locktime, unlocktime, lockreason, ");
        sb.append(" createtime,remark,reprole, orgid, aac002,aac154, ");
        sb.append(" mobile,mobile2,aac003, aaa027, aaz010,aaz001, ");
        sb.append(" (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name, ");
        sb.append(" (select aae007 from Aa13 where aaa027 = a.aaa027) aae007, ");
        sb.append(" (select aae383 from Aa13 where aaa027 = a.aaa027) aae383, ");
        sb.append(" (select orgname from Sysorg where orgid = a.orgid) orgname,");
        //gu20170607begin
        sb.append("(select GROUP_CONCAT(t1.comdalei) from pcompanycomdalei t1 where t1.comid=a.aaz001) as comdalei ");
        //gu20170607end
        sb.append("  from Sysuser a ");
        sb.append(" where 1=1 ");
        String a = aa01.getAaa005();
        String b = dto.getUsername();
        if (aa01.getAaa005() == null || "".equals(aa01.getAaa005())) {//默认登陆方式
            sb.append("   and (username = :username ");
            sb.append("    or mobile = :username ");
            sb.append("    or mobile2 = :username)");
        } else {
            if (dto.getUsername().startsWith(aa01.getAaa005()) || "admin".equals(dto.getUsername())) {
                sb.append("   and (username = :username ");
                sb.append("    or mobile = :username ");
                sb.append("    or mobile2 = :username)");
            } else {
                sb.append("   and (username = :username ");
                sb.append("    or mobile = :username ");
                sb.append("    or mobile2 = :username)");
            }
        }
        String sql = sb.toString();
        String[] ParaName = new String[]{"username"};
        int[] ParaType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, SysuserDTO.class,
                pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * querySysuserzp的中文名称：查询系统用户照片
     * <p>
     * querySysuserzp的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zjf
     */
    public Sysuserzp querySysuserzp(HttpServletRequest request, SysuserDTO dto) {
        Condition cnd = Cnd.where("userid", "=", dto.getUserid());
        List<Sysuserzp> ls = dao.query(Sysuserzp.class, cnd);
        if (ls != null && ls.size() > 0) {
            return ls.get(0);
        } else {
            return null;
        }
    }

    /**
     * queryOnlineSysuser的中文名称：查询系统用户登录日志
     * <p>
     * queryOnlineSysuser的概要说明：1、手机端在线；2、平台端在线；
     *
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    public Map querySyslogonlog(SysuserDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select userid, username, description,userkind,");
        sb.append(" lockstate,locktime, unlocktime, lockreason,");
        sb.append(" createtime,remark,reprole, orgid, aac002,aac154, ");
        sb.append(" mobile, mobile2,aac003, aaa027, aaz010,");
        sb.append(" (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,");
        sb.append(" (select aae007 from Aa13 where aaa027 = a.aaa027) aae007,");
        sb.append(" (select aae383 from Aa13 where aaa027 = a.aaa027) aae383");
        sb.append("  from Sysuser a");
        sb.append(" where 1=1");
        sb.append("   and (username = :username ");
        sb.append("    or mobile = :username ");
        sb.append("    or mobile2 = :username)");

        String sql = sb.toString();
        String[] ParaName = new String[]{"username"};
        int[] ParaType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, SysuserDTO.class,
                pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * loginSjb的中文名称：APP用户登录
     * <p>
     * loginSjb的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zjf
     * @throws Exception
     * @throws Exception
     */
    public SysuserDTO loginSjb(HttpServletRequest request, SysuserDTO dto)
            throws Exception {
        PagesDTO pd = new PagesDTO();
        Map map = querySysuser(dto, pd);
        List ls = (List) map.get("rows");
        SysuserDTO sysuser;
        if (ls != null && ls.size() > 0) {
            sysuser = (SysuserDTO) ls.get(0);
            String passwd = MD5Util.MD5(dto.getPasswd()).toLowerCase();
            if (!passwd.equals(sysuser.getPasswd())) {
                throw new BusinessException("密码错误，请重新输入！");
            }
            //插入登录日志
            Timestamp logontime = new Timestamp(System.currentTimeMillis());
            Syslogonlog syslogonlog = new Syslogonlog();
            syslogonlog.setLogonlogid(DbUtils.getSequenceStr());
            syslogonlog.setUserid(sysuser.getUserid());
            syslogonlog.setLogontime(logontime);
            syslogonlog.setLogonflag("0");
            syslogonlog.setLogonappvision(dto.getLogonappvision());
            dao.insert(syslogonlog);
        } else {
            throw new BusinessException("用户不存在，请联系系统管理员！");
        }
        return sysuser;
    }

    /**
     * modifyPwd的中文名称：APP用户修改密码
     * <p>
     * modifyPwd的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zjf
     */
    public String modifyPwd(HttpServletRequest request, SysuserDTO dto) throws Exception {
        try {
            // 操作员id
            if (dto.getUserid() == null || "".equals(dto.getUserid())) {
                throw new BusinessException("用户ID不能为空！");
            }
            String userpwd_old = request.getParameter("passwd");
            userpwd_old = MD5Util.MD5(userpwd_old).toLowerCase();
            String userpwd_new = request.getParameter("passwd2");
            userpwd_new = MD5Util.MD5(userpwd_new).toLowerCase();

            Sysuser v_user = dao.fetch(Sysuser.class, dto.getUserid());
            if (v_user != null) {
                String passwd = v_user.getPasswd();

                if (passwd.equals(userpwd_old)) {
                    v_user.setPasswd(userpwd_new);
                    dao.update(v_user);
                } else {
                    return "用户原密码不正确，无法修改密码！";
                }
            } else {
                throw new BusinessException("用户不存在，请联系系统管理员！");
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;

    }

    /**
     * setUserPhoto的中文名称：设置系统用户照片
     * <p>
     * setUserPhoto的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zjf
     * @throws Exception
     */
    public String setUserPhoto(HttpServletRequest request,
                               @Param("..") SysuserDTO dto) throws Exception {
        String rootPath = request.getSession().getServletContext()
                .getRealPath(GlobalNameS.CAMERA_UPLOAD_FILE_PATH);
        FileUtil.createFolder(rootPath);
        String tempFileName = null;// 旧文件名
        String newFileName = null;// 新文件名
        String fileType = null;// 文件类型（后缀）
        String filePath = null;

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(1024);
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setHeaderEncoding("UTF-8");
        upload.setSizeMax(5 * 1024 * 1024);// 设置附件最大大小，超过这个大小上传会不成功
        List<FileItem> items = upload.parseRequest(request);
        for (FileItem item : items) {
            if (item.getName() != null && !item.getName().equals("")) {
                tempFileName = item.getName();
                fileType = FilenameUtils.getExtension(tempFileName);
                // newFileName = UUID.randomUUID().toString().replace("-", "")
                // .concat(".").concat(fileType);
                newFileName = (dto.getUsername() + "["
                        + dto.getUserid().toString() + "]").concat(".").concat(
                        fileType);

                // 上传文件的保存路径
                filePath = rootPath + File.separator + newFileName;
                File file = new File(filePath);
                item.write(file);

                // 将照片保存至数据库
                PagesDTO pd = new PagesDTO();
                Map map = querySysuser(dto, pd);
                List ls = (List) map.get("rows");
                if (ls != null && ls.size() > 0) {
                    // 将图片读进输入流
                    InputStream fis = new FileInputStream(file);

                    Sysuserzp sysuserzp = querySysuserzp(request, dto);
                    if (sysuserzp == null) {
                        sysuserzp = new Sysuserzp();
                        sysuserzp.setUserid(dto.getUserid());
                        sysuserzp.setSysuserzp(fis);
                        dao.insert(sysuserzp);
                    } else {
                        sysuserzp.setSysuserzp(fis);
                        dao.update(sysuserzp);
                    }

                    fis.close();
                } else {
                    throw new BusinessException("未查询到该登录用户信息，请联系管理员！");
                }
            }
        }
        return filePath;
    }

    /**
     * getUserPhoto的中文名称：获取系统用户照片
     * <p>
     * getUserPhoto的概要说明: 创建照片，并返回服务器端路径
     *
     * @param dto
     * @return
     * @throws Exception Written by : zjf
     */
    public String getUserPhoto(HttpServletRequest request, SysuserDTO dto)
            throws Exception {
        String rootPath = request.getSession().getServletContext()
                .getRealPath(GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH);
        FileUtil.createFolder(rootPath);
        String newFileName = null;// 新文件名
        String filePath = null;
        try {
            String sql = "select sysuserzp from Sysuserzp where userid = :userid";
            String[] ParaName = new String[]{"userid"};
            int[] ParaType = new int[]{Types.LONGVARCHAR};
            sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
            Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, CsDTO.class);
            List ls = (List) m.get(GlobalNames.SI_RESULTSET);
            if (ls != null && ls.size() > 0) {
                SysuserDTO pdto = (SysuserDTO) ls.get(0);
                String sysuserzp = pdto.getSysuserzp();
                if (!Strings.isBlank(sysuserzp)) {
                    byte b[] = Base64.base64ToByteArray(sysuserzp);

                    // newFileName = UUID.randomUUID().toString().replace("-",
                    // "")
                    // .concat(".").concat("jpg");
                    newFileName = (dto.getUsername() + "["
                            + dto.getUserid().toString() + "]").concat(".")
                            .concat("jpg");
                    // 下载文件的保存路径
                    filePath = rootPath + File.separator + newFileName;

                    File file = new File(filePath);
                    FileOutputStream fos = new FileOutputStream(file);
                    fos.write(b);
                    fos.close();
                }
            }

            return filePath;
        } catch (Exception e) {
            throw new BusinessException("获取照片信息失败：" + e.getMessage());
        }
    }

    /**
     * getSysFunctionByUserId的中文名称：获取手机用户的菜单权限
     * <p>
     * getSysFunctionByUserId的概要说明：手机APP专用
     *
     * @param request
     * @param userid
     * @return
     * @throws Exception Written by : zjf
     */
    public Map getSysFunctionByUserId(HttpServletRequest request, String userid, String parentid)
            throws Exception {
        String haveBtn = "";
        String haveBtn1 = "";
        //haveBtn = " and (t.type !='2' or t.type is null) ";
        //haveBtn1 = " and (t1.type !='2' or t1.type is null) ";

        String sb = "";
        sb += " select functionid,title,location,parent,orderno,type,visible,description,bizid,childnum,target,systemcode,parentname,";
        sb += " case when childnum > 0 then 'true' else 'false' end isparent,";
        sb += " case when childnum > 0 then 'true' else 'false' end isopen ";
        sb += " from(";
        sb += " select t.functionid,t.title,t.location,t.parent,t.orderno,t.type,t.visible,t.description,t.bizid,";
        sb += " (select count(t1.functionid) from Sysfunction t1 where t1.parent=t.functionid ";
        sb += " and (t1.visible !='0' or t1.visible is null) " + haveBtn1
                + ") childnum,target,systemcode, ";
        sb += " (select t2.title from Sysfunction t2 where t2.functionid = t.parent) parentname ";
        sb += " from Sysfunction t ";
        sb += " where (t.visible !='0' or t.visible is null) " + haveBtn;

        //sb += " and t.bizid ='app' ";// 手机APP权限标识
        sb += " and exists";
        sb += " (select 1 from (";
        sb += " select distinct parent as functionid ";
        sb += "   from Sysfunction s4,Sysrolefunction s1,Sysuserrole s2 ";
        sb += "  where s4.functionid = s1.functionid ";
        sb += "    and s1.roleid = s2.roleid ";
        sb += "    and s2.userid ='" + userid;
        sb += "' union all";
        sb += " select functionid";
        sb += "   from Sysrolefunction s1,Sysuserrole s2 ";
        sb += "  where s1.roleid = s2.roleid ";
        sb += "    and s2.userid = '" + userid;
        sb += "' ) u";
        sb += " where u.functionid = t.functionid)";
        sb += " order by t.orderno";

        sb += " ) h";// mysql

        if ("".equals(StringHelper.showNull2Empty(parentid))) {
            sb += " where bizid = 'app1' ";// 手机APP权限标识
        } else {
            sb += " where bizid = 'app2' ";// 手机APP权限标识
            sb += "   and parent = '" + parentid + "'";
        }
        System.out.println("sql" + sb.toString());
        // sb +=
        // " start with  t.parent is null connect by prior t.functionid=t.parent) h";//oracle
        Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
                Sysfunction.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * addSysuserLocation的中文名称：APP用户上报GPS位置
     * <p>
     * addSysuserLocation的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zjf
     */
    public String addSysuserLocation(HttpServletRequest request, ZyDTO dto) {
        try {
            addSysuserLocationImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void addSysuserLocationImp(HttpServletRequest request, ZyDTO dto)
            throws Exception {
        Timestamp startTime = SysmanageUtil.currentTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String curdate = sdf.format(startTime);
        String qdjz = curdate.substring(0, 10) + " 08:01:00";//签到截止时间
        Sysuserdw sysuserdw = new Sysuserdw();
        sysuserdw.setDwid(DbUtils.getSequenceStr());
        sysuserdw.setUserid(dto.getUserid());
        sysuserdw.setDwjdzb(dto.getDwjdzb());
        sysuserdw.setDwwdzb(dto.getDwwdzb());
        sysuserdw.setDwdd(dto.getDwdd());
        sysuserdw.setDwsj(startTime);
        sysuserdw.setQddszid(dto.getQddszid());
        if (curdate.compareTo(qdjz) > 0) {
            sysuserdw.setStatus("2");//curdate>qdjz    故为迟到
        } else {
            sysuserdw.setStatus("1");//curdate<qdjz     故为正常
        }
        sysuserdw.setDwfs(dto.getDwfs());//1：手工签到
        dao.insert(sysuserdw);
    }

    /**
     * getSysUserHisLocation的中文名称：获取APP用户历史轨迹
     * <p>
     * getSysUserHisLocation的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    public Map getSysUserHisLocation(ZyDTO dto, PagesDTO pd) throws Exception {
        Timestamp startTime = SysmanageUtil.currentTime();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        String todayStr = sf.format(startTime);

        StringBuffer sb = new StringBuffer();
        sb.append(" select dwid,dwjdzb,dwwdzb,dwsj,dwdd,");
        sb.append("  b.userid,b.username,b.description,b.mobile,b.mobile2");
        sb.append("  from Sysuserdw a,Sysuser b,(select max(dwid) dwid2 from Sysuserdw group by userid) c");
        sb.append(" where a.userid = b.userid ");
        sb.append("  and  a.dwid = c.dwid2 ");
        sb.append("  and  a.userid = :userid ");
        sb.append("  and  b.orgid = :orgid ");
        sb.append("  and  to_char(a.dwsj,'yyyy-MM-dd') = '").append(todayStr).append("'");
        // 按定位日期-时间段查询
        if (StringUtils.isNotEmpty(dto.getStartDate())) {
            sb.append("  and  to_char(a.dwsj,'yyyy-MM-dd') >= '")
                    .append(dto.getStartDate()).append("'");
        }
        if (StringUtils.isNotEmpty(dto.getEndDate())) {
            sb.append("  and  to_char(a.dwsj,'yyyy-MM-dd') <= '")
                    .append(dto.getEndDate()).append("'");
        }
        sb.append("  order by dwsj desc ");
        String[] ParaName = new String[]{"userid", "orgid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
                ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
                null, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * checkSysuserqd的中文名称：校验APP用户是否符合签到条件(一天签到一次)
     * <p>
     * checkSysuserqd的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    public String checkSysuserqd(HttpServletRequest request, ZyDTO dto, PagesDTO pd)
            throws Exception {
        String aaa027;
        if ("".equals(dto.getAaa027()) || dto.getAaa027() == null) {
            aaa027 = "111111";
        } else {
            aaa027 = dto.getAaa027().substring(0, 6);
        }
        int flg = 0;
        String qddszid = "";
        Timestamp startTime = SysmanageUtil.currentTime();
        String dwsj = DateUtil.convertDateToYearMonthDay(startTime);
        dto.setDwsj(dwsj);//当天
        dto.setDwfs("1");//1：手工签到
        Map sjqdMap = querySysuserdw(dto, pd);
        List sjqdList = (List) sjqdMap.get("rows");
        if (sjqdList != null && sjqdList.size() > 0) {
            //throw new BusinessException("用户当天已签到!");
            return "4";//用户当天已签到!
        }

        if ("410523".equals(aaa027)) {
            //查到执法人员绑定的所有有效签到点
            Map maps = Queryqddczybd(dto.getUserid());
            List ls = (List) maps.get("rows");
            if (ls != null && ls.size() > 0) {
                //计算并比较 执法人员到每个绑定的实际距离和有效距离
                for (int i = 0; i < ls.size(); i++) {
                    Qddsz dd = (Qddsz) ls.get(i);
                    //有效距离
                    Integer yxju = Integer.valueOf(dd.getQddyxjl());
                    //实际距离
                    Integer distance = (PubFunc.parseInt(BaiduUtil.getDistance(
                            dto.getJcsbjdzb(), dto.getJcsbwdzb(),
                            StringHelper.showNull2Empty(dd.getQddjdzb()),
                            StringHelper.showNull2Empty(dd.getQddwdzb())
                    ))) * 1000;
                    //比较
                    if (distance < yxju) {
                        flg++;
                        qddszid = dd.getQddszid();
                    }
                }
            }

            //判断执法人员到绑定点的距离小于有效距离的个数   只有一个表示可以签到
            if (flg != 1) {
                //throw new BusinessException("用户不在签到范围!");
                return "5";//用户不在签到范围!
            }
            return qddszid; //若返回签到点id 可以继续签到
        } else {
            return "6"; //返回6 表示不检测签到点
        }
    }

    /**
     * Queryqddczybd的中文名称：查询执法人员绑定的签到点
     * <p>
     * Queryqddczybd的概要说明：
     *
     * @param userid 用户ID
     * @return
     * @throws Exception Written  by  : ly
     */
    public Map Queryqddczybd(String userid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT sz.qddszid, sz.qddmc,sz.qddyxjl,sz.qdddz,sz.qddwdzb,sz.qddjdzb FROM qddczybd bd ,qddsz sz ");
        sb.append(" where bd.qddszid=sz.qddszid  ");
        sb.append(" and sz.aae100= '1'");
        sb.append(" and bd.userid='").append(userid).append("'");
        String sql = sb.toString();
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Qddsz.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * querySysuserdw的中文名称：查询APP用户定位记录
     * <p>
     * querySysuserdw的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    public Map querySysuserdw(ZyDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select dwid,dwjdzb,dwwdzb,dwsj,dwdd,dwfs,");
        sb.append("  b.userid,b.username,b.description,b.mobile,b.mobile2");
        sb.append("  from Sysuserdw a,Sysuser b");
        sb.append(" where a.userid = b.userid ");
        sb.append("  and  a.userid = :userid ");
        sb.append("  and  b.orgid = :orgid ");
        sb.append("  and  a.dwfs = :dwfs ");
        // 按定位日期查询
        if (StringUtils.isNotEmpty(dto.getDwsj())) {
            sb.append("  and  to_char(dwsj,'yyyyMMdd') = '").append(
                    dto.getDwsj()).append("'");
        }

        if (StringUtils.isNotEmpty(dto.getQddszid())) {
            sb.append(" and a.qddszid=6");
        }
        // 按定位日期-时间段查询
        if (StringUtils.isNotEmpty(dto.getStartDate())) {
            sb.append("  and  to_char(a.dwsj,'yyyy-MM-dd') >= '")
                    .append(dto.getStartDate()).append("'");
        }
        if (StringUtils.isNotEmpty(dto.getEndDate())) {
            sb.append("  and  to_char(a.dwsj,'yyyy-MM-dd') <= '")
                    .append(dto.getEndDate()).append("'");
        }
        sb.append("  order by dwsj desc ");
        String[] ParaName = new String[]{"userid", "orgid", "dwfs"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
        String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
                ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
                null, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

//		List lss= ls.subList(0,0);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * jpushInfo的中文名称：极光推送消息
     * <p>
     * jpushInfo的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    public String jpushInfo(HttpServletRequest request, EmeventcheckinDTO dto) {
        try {
            jpushInfoImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void jpushInfoImpl(HttpServletRequest request, EmeventcheckinDTO dto)
            throws Exception {
        List sysuserList = new ArrayList();
        // 先判断电子围栏
        Integer QDYXJL = PubFunc.parseInt(SysmanageUtil.getAa01("QDYXJL")
                .getAaa005());
        String lng1Str = dto.getEventjdzb();// 中心点经度坐标
        String lat1Str = dto.getEventwdzb();// 中心点维度坐标

        // 获取用户位置信息
        ZyDTO zyDTO = new ZyDTO();
        PagesDTO pd = new PagesDTO();
        zyDTO.setUserid(dto.getOperateperson());//定人发送
        Map maps = getSysUserHisLocation(zyDTO, pd);
        List ls = (List) maps.get("rows");
        if (ls != null && ls.size() > 0) {
            for (int i = 0; i < ls.size(); i++) {
                Map mapdto = (HashMap) ls.get(i);
                String lng = StringHelper.showNull2Empty(mapdto.get("dwjdzb"));
                String lat = StringHelper.showNull2Empty(mapdto.get("dwwdzb"));
                String userid = StringHelper.showNull2Empty(mapdto.get("userid"));

                //Integer distance = PubFunc.parseInt(BaiduUtil.getDistance(lng1Str, lat1Str, lng, lat));
                //if (distance < QDYXJL) {
                sysuserList.add(userid);
                //}

            }

            String pushinfo = dto.getEventcontent();
            JPushAllUtil.androidSendPushByalias(sysuserList, "1", pushinfo, "应急调度通知");
        } else {
            throw new BusinessException("【" + QDYXJL + "】范围内无人员可以调动，请处理！");
        }
    }


    public String jpushMinglingMsg(HttpServletRequest request, EmeventcheckinDTO dto)
            throws Exception {
        //给手机端推送的消息，格式定位 mingling=yingjidiaodu,title=应急调度,content= 已读
        //应急视频，格式定位 mingling=yingjishipin,title=应急视频,content=
        List sysuserList = new ArrayList();
        sysuserList.add(dto.getOperateperson());
        String v_msg="mingling="+dto.getJpushmingling()+"&title="+dto.getJpushtitle()+"&content="+dto.getJpushcontent();
        Boolean v_success= JPushAllUtil.androidSendMsgPushByalias(sysuserList, "1",v_msg );
        if (v_success) {
            return "";
        }else{
            return "推送失败";
        }
    }

    /**
     * yingjidiaodu的中文名称：极光推送消息
     * <p>
     * yingjidiaodu的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    public String yingjidiaodu(HttpServletRequest request, EmeventcheckinDTO dto) {
        try {
            yingjidiaoduImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }



    @Aop({"trans"})
    public void yingjidiaoduImpl(HttpServletRequest request, EmeventcheckinDTO dto)
            throws Exception {
        Sysuser sysuser = (Sysuser) SysmanageUtil.getSysuser();
        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        Oanoticemanager oan=new Oanoticemanager();
        String v_oanoticemanagerid=DbUtils.getSequenceStr();
        oan.setOanoticemanagerid(v_oanoticemanagerid);
        oan.setNoticetype("10");//应急调度发送消息
        oan.setOthertableid(v_oanoticemanagerid);
        oan.setReceivemanid(dto.getOperateperson());
        oan.setNoticecontent(dto.getTexts());
        oan.setHavereadflag("0");
        oan.setSendflag("1");
        oan.setSendokflag("1");
        oan.setCzyid(sysuser.getUserid());
        oan.setCzyname(sysuser.getUsername());
        oan.setAae036(datetime);
        oan.setNoticetitle("应急调度");
        dao.insert(oan);

        //给手机端推送的消息，格式定位 mingling=yingjidiaodu,title=应急调度,content= 已读
        //应急视频，格式定位 mingling=yingjishipin,title=应急视频,content=
        List sysuserList = new ArrayList();
        sysuserList.add(dto.getOperateperson());
        String v_msg="mingling=yingjidiaodu&title=应急调度&content="+dto.getEventcontent()+"&parentoanoticemanagerid="+v_oanoticemanagerid;
        JPushAllUtil.androidSendMsgPushByalias(sysuserList, "1",v_msg );
    }


    /**
     * yingjidiaodu的中文名称：极光推送消息
     * <p>
     * yingjidiaodu的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    public String yingjidiaoduAll(HttpServletRequest request, EmeventcheckinDTO dto) {
        try {
            yingjidiaoduAllImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void yingjidiaoduAllImpl(HttpServletRequest request, EmeventcheckinDTO dto)
            throws Exception {
        List<Sysuser> v_listuser=new ArrayList<Sysuser>();
        if (!com.alibaba.druid.util.StringUtils.isEmpty(dto.getUsergridstr())){
            v_listuser= Json.fromJsonAsList(Sysuser.class, dto.getUsergridstr());
        }

        //String v_sql="select a.* from sysuser a where a.userkind not in ('6','7','8','20','21','30')";
      //  List<Sysuser> v_listsysuser=(List<Sysuser>)DbUtils.getDataList(v_sql,Sysuser.class);
        for (Sysuser v_tempsysuser:v_listuser ){
            dto.setOperateperson(v_tempsysuser.getUserid());
            yingjidiaodu(request,dto);
        }
    }

    /**
     * yingjidiaoduHuifu的中文名称：极光推送消息
     * <p>
     * yingjidiaoduHuifu的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    public String yingjidiaoduHuifu(HttpServletRequest request, OanoticemanagerDTO dto) {
        try {
            yingjidiaoduHuifuImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({"trans"})
    public void yingjidiaoduHuifuImpl(HttpServletRequest request, OanoticemanagerDTO dto)
            throws Exception {
        //将发起的那一条改为一读
        Oanoticemanager v_oldOanoticemanager=dao.fetch(Oanoticemanager.class,dto.getParentoanoticemanagerid());
        v_oldOanoticemanager.setHavereadflag("1");
        dao.update(v_oldOanoticemanager);

        Sysuser sysuser = (Sysuser) dao.fetch(Sysuser.class,dto.getUserid());

        //获取操作时间
        String datetime = SysmanageUtil.getDbtimeYmdHns();
        Oanoticemanager oan=new Oanoticemanager();
        String v_oanoticemanagerid=DbUtils.getSequenceStr();
        oan.setOanoticemanagerid(v_oanoticemanagerid);
        oan.setNoticetype("11");//应急调度发送消息
        oan.setOthertableid(dto.getParentoanoticemanagerid());
        oan.setReceivemanid(dto.getUserid());
        oan.setNoticecontent(dto.getNoticecontent());
        oan.setHavereadflag("0");
        oan.setSendflag("1");
        oan.setSendokflag("1");
        oan.setCzyid(sysuser.getUserid());
        oan.setCzyname(sysuser.getUsername());
        oan.setAae036(datetime);
        oan.setNoticetitle("应急调度回复");
        dao.insert(oan);
    }


    /**
     * queryCsjkzdqtx的中文名称：健康证到期提醒
     * <p>
     * queryCsjkzdqtx的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    public Map queryCsjkzdqtx(ZyDTO dto, PagesDTO pd) throws Exception {
        // 默认提前一个月提醒
        StringBuffer sb = new StringBuffer();
        sb.append(" select sjid,sjname,sjcph,sjsjh,sjsf,sjjszyxq");
        sb.append(" from sj ");
        sb.append(" where f_datediff('month',now(),sjjszyxq) <= 1");
        sb.append("   and sjsf = '1' ");
        sb.append("   and sjcph = :sjcph");
        sb.append("   and sjname = :sjname");

        String[] ParaName = new String[]{"sjcph", "sjname"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
                ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
                ZyDTO.class, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * queryAjdj的中文名称：查询案件详细信息
     * <p>
     * queryAjdj的概要说明：
     *
     * @param ajdjid
     * @return
     * @throws Exception Written by : zy
     */
    public ZfajdjDTO queryAjdjObj(String ajdjid,String v_operatetype,String v_comid) throws Exception {

        StringBuffer sb = new StringBuffer();
        if (StringUtils.isNotEmpty(v_operatetype)&&"mobilecheck".equals(v_operatetype)){
            sb.append(" select a.* ");
          //  sb.append("(select getAa10_aaa103('AAC004',a.comfrxb)) as comfrxbstr, ");
           // sb.append("(select getAa10_aaa103('AJDJAJLY',a.ajdjajly)) as ajdjajlystr ");
            sb.append("  from pcompany a ");
            sb.append(" where 1 = 1 ");
            sb.append("   and a.comid='").append(v_comid).append("'");
        }else{
            sb.append(" select a.*,(select getAa10_aaa103('COMZZZM',a.comzzzm)) as comzzzmstr, ");
            sb.append("(select getAa10_aaa103('AAC004',a.comfrxb)) as comfrxbstr, ");
            sb.append("(select getAa10_aaa103('AJDJAJLY',a.ajdjajly)) as ajdjajlystr ");
            sb.append("  from Zfajdj a ");
            sb.append(" where 1 = 1 ");
            sb.append("   and a.ajdjid='").append(ajdjid).append("'");
        }


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
        v_ZfajdjDTO.setBhgx(queryAjdjBhgx(ajdjid));
        return v_ZfajdjDTO;
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
        return v_ZfajdjDTO.getBhgx();
    }

    /**
     * queryAjdj的中文名称：查询案件登记
     * <p>
     * queryAjdj的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : zy
     * @throws Exception
     */
    public Map queryAjdjList(ZfajdjDTO dto, PagesDTO pd) throws Exception {

        List userList = queryUser(dto.getUserid().toString());
        Sysuser vSysUser = new Sysuser();
        if (userList != null) {
            vSysUser = (Sysuser) userList.get(0);
            // 统筹区编码
            dto.setAaa027(vSysUser.getAaa027());
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from zfajdj a ");
        sb.append(" where 1=1 ");
        sb.append("  and ajdjid = :ajdjid"); // 案件登记id
        sb.append("  and aaa027 like :aaa027 "); // 统筹区
        sb.append("  and comdm = :comdm"); // 企业代码
        sb.append("  and commc like :commc"); // 企业名称
        sb.append("  and slbz = :slbz"); // 受理标志
        sb.append("  and ajjsbz = :ajjsbz"); // 案件结束标志
        sb.append(" order by a.ajdjid desc ");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjid", "aaa027", "comdm",
                "commc", "slbz", "ajjsbz"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR,
                Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("sqlsqlsqlsql " + sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZfajdjDTO.class,
                pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * saveAjdj的中文名称：案件登记保存
     * <p>
     * saveAjdj的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveAjdj(HttpServletRequest request, ZfajdjDTO dto) {
        String ajdjid = null;
        try {
            ajdjid = saveAjdjImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return ajdjid;
    }

    /**
     * saveAjdjImp的中文名称：案件登记保存实现
     * <p>
     * saveAjdjImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public String saveAjdjImp(HttpServletRequest request, ZfajdjDTO dto)
            throws Exception {
        //gu20161226 String v_sql="select a.* from pcompany a where a.comdm='"+dto.getComdm()+"'";
        //String v_sql="select a.* from pcompany a where a.comid='"+dto.getComid()+"'";
        //Pcompany v_pcompany=(Pcompany)DbUtils.getDataList(v_sql, Pcompany.class).get(0);

        String ajdjid = "";
        if ((null != dto.getAjdjid()) && (!"".equals(dto.getAjdjid()))) {
            ajdjid = dto.getAjdjid();
            Zfajdj se = dao.fetch(Zfajdj.class, dto.getAjdjid());
            se.setAjdjbh(dto.getAjdjbh());
            se.setComdm(dto.getComdm());
            se.setCommc(dto.getCommc());
            se.setComdz(dto.getComdz());
            se.setComfrhyz(dto.getComfrhyz());
            se.setComfrsfzh(dto.getComfrsfzh());
            se.setComyddh(dto.getComyddh());
            se.setComyzbm(dto.getComyzbm());
            se.setAjdjafsj(dto.getAjdjafsj());
            se.setAjdjay(dto.getAjdjay());
            se.setAjdjajly(dto.getAjdjajly());
            se.setAjdjjbqk(dto.getAjdjjbqk());
            dao.update(se);
        } else {
            // 获取系统时间
            String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
            // 获取案件登记id
            String vAjdjid = DbUtils.getSequenceStr();
            ajdjid = vAjdjid;
            Zfajdj v_Zfajjd = new Zfajdj();
            BeanHelper.copyProperties(dto, v_Zfajjd);
            List userList = queryUser(dto.getUserid().toString());
            Sysuser vSysUser = new Sysuser();
            if (userList != null) {
                vSysUser = (Sysuser) userList.get(0);
            }
            if (vSysUser != null) {
                // 案件登记操作员
                v_Zfajjd.setAjdjczy(vSysUser.getUsername());
                // 统筹区编码
                v_Zfajjd.setAaa027(vSysUser.getAaa027());
            }
            // 案件登记id
            v_Zfajjd.setAjdjid(vAjdjid);
            // 案件登记操作时间
            v_Zfajjd.setAjdjczsj(v_dbDatetime);
            // 受理标志
            v_Zfajjd.setSlbz("0");
            v_Zfajjd.setAjjsbz("0");
            v_Zfajjd.setOrgid(vSysUser.getOrgid());
            //gu20161018 v_Zfajjd.setComdalei(v_pcompany.getComdalei());
            //v_Zfajjd.setComid(v_pcompany.getComid());

            dao.insert(v_Zfajjd);
            //20161231 新增时同时把当前操作员，设定为案件承办人
            Zfajcbr v_zfajcbr=new Zfajcbr();
            String v_ajcbrid=DbUtils.getSequenceStr();
            v_zfajcbr.setAjcbrid(v_ajcbrid);
            v_zfajcbr.setAjdjid(vAjdjid);
            v_zfajcbr.setUserid(dto.getUserid());
            v_zfajcbr.setZfryxm(vSysUser.getDescription());
            v_zfajcbr.setZfrysflx("4");//4 案件登记人员
            v_zfajcbr.setZfrybmmc(vSysUser.getOrgname());
            dao.insert(v_zfajcbr);
        }
        return ajdjid;
    }

    /**
     * queryUser的中文名称：查询用户信息
     * <p>
     * queryUser的概要说明：
     *
     * @param userid
     * @return
     * @throws Exception Written by : zy
     */
    public List queryUser(String userid) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append("  from sysuser a ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.userid='").append(userid).append("'");

        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Sysuser.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        if ((ls != null) && (ls.size() > 0)) {
            return ls;
        }
        return null;
    }

    /**
     * getNewsList的中文名称：获取新闻列表
     * <p>
     * getNewsList的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author ：zjf
     */
    @SuppressWarnings("rawtypes")
    public Map getNewsList(HttpServletRequest request, NewsDTO dto,
                           PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select newsid,newstitle");
        sb.append(" from News a,Newscate b ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.cateid = b.cateid ");
        sb.append("   and a.newstitle like :newstitle ");
        sb.append("   order by a.newstjsj desc");
        String sql = sb.toString();
        String[] ParaName = new String[]{"newstitle"};
        int[] ParaType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return m;
    }

	/**
	 *
	 * queryCompanyList的中文名称：查询公司列表
	 *
	 * queryCompanyList的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 *
	 */
	public Map queryCompanyList(HttpServletRequest request, PcompanyDTO dto,PagesDTO pd)
			throws Exception {
		String sql = "";
        String planYear = String.valueOf(DateUtil.getCurrentYear());
		// 获取用户id
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if ("".equals(userid)) {
			throw new BusinessException("用户登陆ID不能为空！");
		}
		List userList = queryUser(userid);
		Sysuser vSysUser = new Sysuser();
		if (userList != null) {
			vSysUser = (Sysuser) userList.get(0);
			// 统筹区编码
//			dto.setAaa027(vSysUser.getAaa027().replaceAll("0*$", ""));
		}
		boolean v_mapcom=false;
		if (StringUtils.isNotEmpty(dto.getQuerytype())&&"mapcom".equals(dto.getQuerytype())){
			v_mapcom=true;
		}
		int v_LatLonScope=500;
		if (v_mapcom){
          Aa01 v_aa01=dao.fetch(Aa01.class,Cnd.where("aaa001","=","LatLonScope"));
          if (v_aa01!=null) {
          	   v_LatLonScope=Integer.parseInt(v_aa01.getAaa005());
			}
			//不加分页
            pd.setPage(0);
            pd.setRows(0);
		};
	    //当前年份时间
	    dto.setYear(String.valueOf(DateUtil.convertDateToYear(new Date())));
		if(dto.getItemid()!= null &&  !"".equals(dto.getItemid())){
			StringBuffer sb = new StringBuffer();
			sb.append(" select DISTINCT a.comid,a.comzzjgdm,a.comdz, a.comdm,a.commc,a.orgid,a.comjdzb,a.comwdzb,");
			sb.append(" a.comgddh,(select count(*) from bscheckmaster f  , bscheckplan g  where f.planid=g.planid and  f.operatedate like :year");
 		    sb.append("  and f.resultstate =4  and f.comid=a.comid) as resultcount, ");
            sb.append(" (select ifnull(max(t.operatedate),a.comdzcsj)  from bscheckmaster t where t.comid=a.comid) as operatedate, ");//gu20180806
			sb.append(" a.comfrhyz ,a.comfrsfzh,a.comyddh,a.aaa027,");
			sb.append("(select GROUP_CONCAT(t1.comxkfw)  from pcompanyxkz t1 where t1.comid=a.comid group by t1.comid) as  comxkfw,"); //gu20170421add
			sb.append("(select GROUP_CONCAT(t1.comxkzbh)  from pcompanyxkz t1 where t1.comid=a.comid group by t1.comid) as  comxkzbh, "); //gu20170421add
			sb.append("(select max(t1.fjpath)  from fj t1 where t1.fjwid=a.comid and t1.fjtype='4') as  qymtzpath, "); //gu20170421add
            sb.append("t8.lhfjndpddj,t8.jingtaifen,t8.dongtaifen,t8.defen,(case when t8.lhfjndpddj is not null or t8.lhfjndpddj <>'' then '1' else '0' end) as havepdlevel ");
			sb.append(" from pcompany a left join (select t7.* from pcompanynddtpj t7 where  t7.pdyear = '2018') t8 on a.comid=t8.comid ,pcompanycomdalei cd ");
			sb.append(" (select DISTINCT b.AAA102  from aa10 b, ombasetype o,omcheckgroup c where AAA100 ='COMDALEI' and b.AAZ093 = o.basetype ");
			sb.append(" and c.itemid=o.itemtype and c.itempid= :itemid  and b.AAZ093=:aaz093 and 1=1");
            sb.append("  ) e ");
            sb.append(" where cd.comdalei = e.AAA102 AND a.comid = cd.comid and 1=1   ");
			if (!StringUtils.isEmpty(dto.getCommc())&&!StringUtils.isEmpty(dto.getComxkzbh())){
				sb.append(" and (a.commc like '%"+dto.getCommc()+"%' or a.commcjc like '%"+dto.getCommc()+"%' or exists (select 1 from pcompanyxkz t where t.comid=a.comid and t.comxkzbh='"+dto.getComxkzbh()+"') )");
			}else{
				if (!StringUtils.isEmpty(dto.getCommc())){
                    sb.append(" and (a.commc like '%"+dto.getCommc()+"%' or a.commcjc like '%"+dto.getCommc()+"%' or a.comfrhyz like '%"+dto.getCommc()+"%' or a.comfzr like '%"+dto.getCommc()+"%')");
				};				
			}

			//gu20180428有无许可证证0无证1有证 其他全部
			if ("0".equals(dto.getIshavezzzm())){
                sb.append(" and not exists (select 1 from pcompanyxkz pp where pp.comid=a.comid and pp.comxkzlx<>'1') ");
			}else if ("1".equals(dto.getIshavezzzm())){
				sb.append(" and exists (select 1 from pcompanyxkz pp where pp.comid=a.comid and pp.comxkzlx<>'1') ");
			}
           //gu20180529
			if (v_mapcom){
				sb.append(" and f_getLonLatDistance("+dto.getComjdzb()+","+dto.getComwdzb()+",a.comjdzb,a.comwdzb,"+v_LatLonScope+")=1  and a.comjdzb is not null and a.comjdzb<>'' ");
			}
			//gu20180 sb.append("  order by resultcount desc ");
            sb.append("  order by operatedate desc ");
			sql = sb.toString();
			String[] ParaName = new String[] { "year","itemid", "aaz093","commc"};
			int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR};
			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
			System.out.println("sqlsqlsqlsql itemid " + sql);
		} else {//食品类
			// 是否启用安全监管任务分派功能
			Aa01 aa01 = SysmanageUtil.getAa01("SFQYAQJGRWFP");
			StringBuffer sb = new StringBuffer();
			sb.append(" select a.comzzjgdm ,a.comdz,a.comid,a.comdm ,a.commc ,a.orgid , a.comfrhyz ,cd.comdalei,a.comjdzb,a.comwdzb,");
			sb.append(" (select getAa10_aaa103('COMDALEI',cd.comdalei)) as comdaleistr, ");
			sb.append("  a.comgddh,(select count(*) from bscheckmaster f  , bscheckplan g  where f.planid=g.planid and  f.operatedate like :year");
 		    sb.append("  and f.resultstate =4  and f.comid=a.comid) as resultcount, ");
            sb.append(" (select ifnull(max(t.operatedate),a.comdzcsj)  from bscheckmaster t where t.comid=a.comid) as operatedate, ");//gu20180806
			sb.append(" a.comfrsfzh,a.comyddh,a.aaa027,a.comxiaolei, ");
			sb.append("(select GROUP_CONCAT(t1.comxkfw)  from pcompanyxkz t1 where t1.comid=a.comid group by t1.comid) as comxkfw,"); //gu20170421add
			sb.append("(select GROUP_CONCAT(t1.comxkzbh)  from pcompanyxkz t1 where t1.comid=a.comid group by t1.comid) as comxkzbh,"); //gu20170421add
			sb.append("(select max(t1.fjpath)  from fj t1 where t1.fjwid=a.comid and t1.fjtype='4') as  qymtzpath, ");
            sb.append("t8.lhfjndpddj,t8.jingtaifen,t8.dongtaifen,t8.defen,(case when t8.lhfjndpddj is not null or t8.lhfjndpddj <>'' then '1' else '0' end) as havepdlevel ");
			sb.append("  from pcompany a left join (select t7.* from pcompanynddtpj t7 where  t7.pdyear = '"+planYear+"') t8 on a.comid=t8.comid, aa10 b, pcompanycomdalei cd ");
			if (aa01.getAaa005() != null && "1".equals(aa01.getAaa005())) {
				sb.append(" , bschecktaskdetail detail, bschecktaskperson per ");
			}
			sb.append(" where cd.comid = a.comid ");
			sb.append(" and cd.comdalei = b.AAA102 ");
			sb.append(" and b.aaa100='comdalei' ");
			sb.append(" and b.AAZ093 =:aaz093 ");
			//sb.append(" and a.commc like :commc");
			sb.append(" and a.comid =:comid ");
			
			//gu20180105
			if (!StringUtils.isEmpty(dto.getCommc())&&!StringUtils.isEmpty(dto.getComxkzbh())){
				sb.append(" and (a.commc like '%"+dto.getCommc()+"%' or a.commcjc like '%"+dto.getCommc()+"%' or exists (select 1 from pcompanyxkz t where t.comid=a.comid and t.comxkzbh='"+dto.getComxkzbh()+"') )");
			}else{
				if (!StringUtils.isEmpty(dto.getCommc())){
					sb.append(" and (a.commc like '%"+dto.getCommc()+"%' or a.commcjc like '%"+dto.getCommc()+"%' or a.comfrhyz like '%"+dto.getCommc()+"%' or a.comfzr like '%"+dto.getCommc()+"%')");
				};				
			}

			//gu20180428有无许可证证0无证1有证 其他全部
			if ("0".equals(dto.getIshavezzzm())){
				sb.append(" and not exists (select 1 from pcompanyxkz pp where pp.comid=a.comid and pp.comxkzlx<>'1') ");
			}else if ("1".equals(dto.getIshavezzzm())){
				sb.append(" and exists (select 1 from pcompanyxkz pp where pp.comid=a.comid and pp.comxkzlx<>'1') ");
			}
			
			if (aa01.getAaa005() != null && "1".equals(aa01.getAaa005())) {
				sb.append(" and a.comid = detail.comid and per.userid =:userid  GROUP BY a.comid ");
			}

			//gu20180529
			if (v_mapcom){
				sb.append(" and f_getLonLatDistance("+dto.getComjdzb()+","+dto.getComwdzb()+",a.comjdzb,a.comwdzb,"+v_LatLonScope+")=1 and a.comjdzb is not null and a.comjdzb<>'' ");
			}
            //gu20161209 sb.append(" order by resultcount, a.comid desc ");
            sb.append(" order by operatedate ");

			if(Sys.District.ZhengDongXinQu.equals(SysmanageUtil.SYSAAA027)){
				sb.append(" asc ");
			}else{
				sb.append(" desc ");
			}

			sql = sb.toString();
			String[] ParaName = new String[] { "year", "aaz093", "commc", "userid","comid"};
			int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR, Types.VARCHAR,Types.VARCHAR };

			sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
			System.out.println("sqlsqlsqlsql aaz093" + sql);
		}
		Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, PcompanyDTO.class,
						pd.getPage(),pd.getRows(),userid,"aaa027,aae140,orgid,usercom");

		List<PcompanyDTO> ls = (List<PcompanyDTO>) m.get(GlobalNames.SI_RESULTSET);

		//获取完成的计划类别个数，
		if(ls.size()>0){
		for(PcompanyDTO bean:ls){
			dto.setComid(bean.getComid());
			String result = getPlanTypeList(request, dto);
			if(!"".equals(result)&&result!=null){
				bean.setPlanresult(result);
			}
			//防止手机报错
			if("".equals(bean.getResultcount()) || bean.getResultcount() ==null){
				bean.setResultcount(" ");
			}
		}
		}

		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total",m.get(GlobalNames.SI_TOTALROWNUM));
		r.put("page", pd.getPage()+1);//下一页
		return r;
	}

    /**
     * queryLawdocList：查询手机执法文书列表
     * <p>
     * queryLawdocList：
     *
     * @param dto
     * @param pd
     * @return Written by : zy
     * @throws Exception
     */
    public Map queryLawdocList(HttpServletRequest request, PfjcsDTO dto, PagesDTO pd)
            throws Exception {
        String v_ajdjid = "a";
        if (StringUtils.isNotEmpty(dto.getAjdjid())) {
            v_ajdjid = dto.getAjdjid();
        }
/*        String sql = "select a.*," +
                "  (case when (select count(*) from zfajzfws t where t.ajdjid='" + v_ajdjid + "' and t.zfwsdmz=a.fjcsdmz)>0 then '已填写' else '' end) as havefill " +
                "from pfjcs a where fjcsdmlb='MOBILEZFWS' order by fjcsorder ";*/

       String sql="select a.*,(case when b.ajzfwsid is not null and length(b.ajzfwsid)>0 then '已填写' else '' end) as havefill," +
               "  b.ajzfwsid,b.ajdjid,b.zfwsqtbid,b.zfwstzbz,b.zfwsczyxm,b.zfwsczsj " +
               "  from pfjcs a left join zfajzfws b " +
               "  on a.fjcsdmz=b.zfwsdmz " +
               "  and b.ajdjid='"+v_ajdjid+"'" +
               "  where fjcsdmlb='MOBILEZFWS' " +
               "  order by fjcsorder ";

        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PfjcsDTO.class,
                pd.getPage(), pd.getRows());

        List<PfjcsDTO> ls = (List<PfjcsDTO>) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        r.put("page", pd.getPage() + 1);//下一页
        return r;
    }
    public Map queryLawdocList_MobileIndex(HttpServletRequest request, PfjcsDTO dto, PagesDTO pd)
            throws Exception {
        String v_ajdjid = "a";
        if (StringUtils.isNotEmpty(dto.getAjdjid())) {
            v_ajdjid = dto.getAjdjid();
        }
/*        String sql = "select a.*," +
                "  (case when (select count(*) from zfajzfws t where t.ajdjid='" + v_ajdjid + "' and t.zfwsdmz=a.fjcsdmz)>0 then '已填写' else '' end) as havefill " +
                "from pfjcs a where fjcsdmlb='MOBILEZFWS' order by fjcsorder ";*/

        String sql="select a.*,(case when b.zfwstzbz='1' then '已填写' else '' end) as havefill," +
                "(case when b.fytzbz='1' then '有副页' else '' end) as havefy,"+
                "  b.ajzfwsid,b.ajdjid,b.zfwsqtbid,b.zfwstzbz,b.zfwsczyxm,b.zfwsczsj " +
                "  from pfjcs a , zfajzfws b " +
                "  where fjcsdmlb='MOBILEZFWS' " +
                "  and a.fjcsdmz=b.zfwsdmz " +
                "  and b.ajdjid='"+v_ajdjid+"'" +
                "  order by fjcsorder ";

        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PfjcsDTO.class,
                pd.getPage(), pd.getRows());

        List<PfjcsDTO> ls = (List<PfjcsDTO>) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        r.put("page", pd.getPage() + 1);//下一页
        return r;
    }
    /**
     * queryCompanyList的中文名称：查询企业列表
     * <p>
     * queryCompanyList的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by :
     * @throws Exception
     */
    public Map queryCompanyListForAjdj(HttpServletRequest request, PcompanyDTO dto, PagesDTO pd)
            throws Exception {
        String sql = "";
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.comzzjgdm ,a.comdz,a.comid,a.comdm ,a.commc ,a.comfrhyz,a.comdalei,a.comfrsfzh ");
        sb.append(" ,a.comyddh,IFNULL(a.comyzbm, '456150') comyzbm ,a.aaa027,a.comxiaolei ");
        sb.append(" from pcompany a ");
        sb.append("  where 1=1 and a.aaa027 like :aaa027 and a.commc like :commc");
        sb.append(" order by a.comid desc ");
        sql = sb.toString();
        String[] ParaName = new String[]{"aaa027", "commc"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        System.out.println("sqlsqlsqlsql " + sql);
        Map m = DbUtils
                .DataQueryGrant(GlobalNames.sql, sql, null, PcompanyDTO.class,
                        pd.getPage(), pd.getRows(), dto.getUserid(),
                        "aaa027,aae140,usercom"
                );
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * 查询聚餐申报计划列表，(手机端service方法)
     *
     * @param dto 检查计划DTO
     * @return
     * @throws Exception
     */
    public Map queryJscbPlansByqyType(HttpServletRequest request, BscheckplanDTO dto)
            throws Exception {
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ,( select d.resultstate  from bscheckmaster d where ");
        sb.append(" d.planid=a.planid ");
        sb.append(" and d.comid= :comid and 1=1");
        sb.append(" ) resultstate from bscheckplan a where a.planid in ");
        sb.append(" ( select DISTINCT b.planid from  bscheckpicset b ,omcheckgroup c  ");
        sb.append(" where b.itemid = c.itemid ");
        sb.append(" and c.itempid = :itemid  and 1=1");
        sb.append(" ) order by a.planid desc ");
        String sql = sb.toString();
        String[] paramName = new String[]{"comid", "itemid"};
        int[] paramType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Map.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryCompanyListBycommc的中文名称：查询企业列表 通过企业commc(传入的值待定)
     * <p>
     * queryCompanyListBycommc的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : zy
     * @throws Exception
     */
    public Map queryCompanyListBycommc(HttpServletRequest request,
                                       PcompanyDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.comid,a.comzzjgdm ,a.comdm ,a.comxiaolei,a.comdalei,a.comdalei aae140, a.orgid ");
        sb.append("  , a.commc ,a.comfrhyz ,a.comfrsfzh,a.comyddh,a.aaa027,a.comdz  from pcompany a ");
//		sb.append(" , (select b.AAA102 , o.itemtype from aa10 b, ombasetype o,omcheckgroup c where AAA100 ='COMDALEI' and b.AAZ093 = o.basetype ");
//		sb.append(" and c.itemid=o.itemtype and c.itempid= :itemid and b.AAZ093=:aaz093 and 1=1");
//		sb.append("  ) e where a.comdalei  = e.AAA102 and a.aaa027 like :aaa027");
        sb.append(" where  1=1  and a.commc like :commc  ");
        sb.append(" order by a.comid desc");
        String sql = sb.toString();
//		String[] ParaName = new String[] { "itemid", "aaz093", "aaa027", "commc" };
//		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
//				Types.VARCHAR };
        String[] ParaName = new String[]{"commc"};
        int[] ParaType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        System.out.println("sqlsqlsqlsql  " + sql);
        Map m = DbUtils
                .DataQueryGrant(GlobalNames.sql, sql, null, PcompanyDTO.class, pd.getPage(), pd.getRows(), dto.getUserid(),
                        "aaa027,aae140,orgid,usercom");
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * queryCompany的中文名称：查询所有的企业信息
     * <p>
     * queryCompany的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    public Map queryCompany(HttpServletRequest request, PcompanyDTO dto,
                            PagesDTO pd) throws Exception {
        // 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
        String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
        dto.setAaa027(aaa027);

        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select pcom.*,t.outercomid as camorgid from Pcompany pcom left join pcompanyimport t on pcom.comid=t.comid ");
        sb.append(" where 1=1 ");
        sb.append(" and pcom.comid = :comid ");
        sb.append(" and pcom.commc like :commc ");
        sb.append(" and pcom.comdalei = :comdalei ");
        sb.append(" and pcom.comhhbbz = :comhhbbz ");
        //gu20180612 sb.append(" and pcom.comspjkbz = :comspjkbz ");
        sb.append(" and pcom.comcameraflag = :comcameraflag ");
        sb.append(" and pcom.combxbz = :combxbz ");
        sb.append(" and pcom.comshbz = :comshbz ");
        sb.append(" and pcom.comjyjcbz = :comjyjcbz ");
        sb.append(" and pcom.aaa027 like :aaa027 ");
        sb.append(" and pcom.comjdzb > 0 ");//zjf
        sb.append(" order by comid desc ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[]{"comid", "commc", "comdalei", "comhhbbz", "comcameraflag", "combxbz",
                "comshbz", "comjyjcbz", "aaa027"};
        int[] paramType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
                Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        System.out.println(sql);
//		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
//				PcompanyDTO.class, pd.getPage(), pd.getRows(),
//				);

        Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null,
                PcompanyDTO.class, pd.getPage(), pd.getRows(), dto.getUserid(),
                "aaa027,aae140,orgid,usercom"
        );

        //"aaa027,aae140,orgid,usercom"
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * 拼接明细字符串
     *
     * @param list 明细列表
     * @return
     * @throws Exception
     */
    public String getJCSBDetaillist(HttpServletRequest request, BsCheckMasterDTO dto, List<BsCheckDetailDTO> list) throws Exception {
        List itemidlist = new ArrayList();
        StringBuffer sb = new StringBuffer();
        String tbody = "";
        String tbodyBotoom = "";
        String checkTrue = "☑";
        String checkFalse = "□";//&#9633;□
        dto.setTbodytype("jcsbCheckPaln");
        dto.setTbodycode(dto.getPlanchecktype());
        //获取表头信息
        BsTbodyInfoDTo tbodybean = getTbodyInfo(request, dto);
        if (tbodybean != null) {
            tbody = tbodybean.getTbodyinfo();
            tbodyBotoom = tbodybean.getTfootinfo();

            String tbodyval = "";
            //表头
            for (int i = 0; i < list.size(); i++) {
                //含有不合并
                if (itemidlist.contains(list.get(i).getItemid())) {
                    sb.append("<tr  id='tr" + i + "' ><td>" + list.get(i).getContent() + "</td><td>" + list.get(i).getContentsortid() + "</td><td>" + getconentimpinfo("CONTENTIMPT", list.get(i).getContentimpt()) + "</td><td>" + (("1".equals(list.get(i).getDetaildecide())) ? "&radic;" : "") + "</td><td>" + (("2".equals(list.get(i).getDetaildecide())) ? "&radic;" : "") + "</td><td>" + (("3".equals(list.get(i).getDetaildecide())) ? "&radic;" : "") + "</td></tr>");
                } else {
                    itemidlist.add(list.get(i).getItemid());
                    sb.append("<tr id='total" + i + "' ><td id=" + list.get(i).getItemid() + " rowspan=" + list.get(i).getCount() + ">" + list.get(i).getItemname() + "</td><td>" + list.get(i).getContent() + "</td><td>" + list.get(i).getContentsortid() + "</td><td>" + getconentimpinfo("CONTENTIMPT", list.get(i).getContentimpt()) + "</td><td>" + (("1".equals(list.get(i).getDetaildecide())) ? "&radic;" : "") + "</td><td>" + (("2".equals(list.get(i).getDetaildecide())) ? "&radic;" : "") + "</td><td>" + (("3".equals(list.get(i).getDetaildecide())) ? "&radic;" : "") + "</td></tr>");
                }
            }
            //表尾
            sb.append("</tbody>");
            tbodyval = tbody.replace("</tbody>", sb.toString());

            return tbodyval + tbodyBotoom;
        }

        return null;
    }

    //获取执法人员信息
    public String getzfzjh(String userid) throws Exception {
        if (userid == null) {// 手机端传入userid pc端通过session获取userid
            Sysuser s = SysmanageUtil.getSysuser();
            if (s != null) {
                userid = s.getUserid();
            }
        }
        String zjhm = "";
        if (!"".equalsIgnoreCase(userid)) {
            Viewzfry zfry = dao.fetch(Viewzfry.class, Cnd.where("userid", "=", userid));
            if (zfry != null) {
                zjhm = zfry.getZfryzjhm();
            }
        }
        return zjhm;
    }

    /**
     * 查询企业信息通过结果id，
     *
     * @param dto 检查结果概要DTO
     * @return
     * @throws Exception
     */
    public PcompanyDTO getQiyeInfoByid(HttpServletRequest request, BsCheckMasterDTO dto) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select  DISTINCT (select e.itemname from omcheckgroup e where e.itemid=d.itempid) itemname, b.*,a.operatedate,a.resultdate,");
        sb.append("(select GROUP_CONCAT(t1.comxkfw)  from pcompanyxkz t1 where t1.comid=b.comid group by t1.comid) as  comxkfw "); //gu20170421add
        sb.append("  from bscheckmaster a ,pcompany b ,bscheckpicset c ,omcheckgroup d ");
        sb.append("  where a.comid=b.comid and c.planid= a.planid and c.itemid = d.itemid  ");
        sb.append(" and a.resultid= :resultid ");
        String sql = sb.toString();
        //转化sql语句
        String[] paramName = new String[]{"resultid"};
        int[] paramType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        System.out.println(sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class);
        List<PcompanyDTO> list = (List<PcompanyDTO>) m.get(GlobalNames.SI_RESULTSET);
        if (list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    /**
     * reportPosition的中文名称：上报地理坐标位置
     * <p>
     * reportPosition的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    public String reportPosition(HttpServletRequest request, @Param("..") PzfpositionDTO dto) {
        try {
            reportPositionImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * 上传坐标位置
     *
     * @param request
     * @param dto
     */
    @Aop({"trans"})
    public void reportPositionImp(HttpServletRequest request, @Param("..") PzfpositionDTO dto) {
        Timestamp reporttime = new Timestamp(System.currentTimeMillis());
        String id = DbUtils.getSequenceStr();
        Pzfposition pzfposition = new Pzfposition();
        BeanHelper.copyProperties(dto, pzfposition);  //拷贝对应的从前台传来的数据
        pzfposition.setId(id);
        pzfposition.setReporttime(reporttime);
        dao.insert(pzfposition);
    }

    /**
     * queryAjdjZxpd征信评定
     * <p>
     * queryAjdjZxpd征信评定
     *
     * @return Written by : zy
     * @throws Exception
     */
    public List<QproductDTO> queryProOrClBySym(String sym) throws Exception {
        if ("".equals(sym)) {
            throw new BusinessException("二维码错误！");
        }

        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT com.commc, com.comdz, com.comyddh,pc.cppcpch, pc.cppcscrq, ");
        sb.append(" p.proid, p.proname, p.prosptm, p.probzgg, p.probzq, p.procpbzh,p.proplxx, ");
        sb.append(" p.propm, p.probzqdwmc, p.procdjd1142583, p.progg, ");
        sb.append(" (select getAa10_aaa103('PROZL',p.prozl)) as prozlstr ");
        sb.append(" FROM qproduct p, pcompany com, qproductpc pc  ");
        sb.append(" WHERE p.procomid = com.comid and p.proid = pc.proid ");
        sb.append("  and p.proid = ");
        sb.append(" (SELECT proid FROM qproductpc WHERE cppcid =  ");
        sb.append(" (SELECT cppcid FROM qsymscb WHERE qsymscbid =  ");
        sb.append(" (SELECT qsymscbid FROM qsymscmxb  ");
        sb.append(" WHERE sym = '").append(sym).append("'))) ");
        String sql = sb.toString();
        //
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductDTO.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        QproductDTO pro = null;
        if (ls != null && ls.size() > 0) {
            pro = (QproductDTO) ls.get(0);
        }
        List<QproductDTO> items = new ArrayList<QproductDTO>();
        List<QproductDTO> result = new ArrayList<QproductDTO>();
        QproductDTO item = new QproductDTO();
        item.setProid(pro.getProid()); // 商品id
        item.setProname(pro.getProname()); // 商品名
        item.setComdz(pro.getComdz()); // 企业地址
        item.setCommc(pro.getCommc()); // 企业名称
        item.setComyddh(pro.getComyddh()); // 企业电话
        item.setProbzgg(pro.getProbzgg()); // 包装规格
        item.setProbzq(pro.getProbzq()); // 保质期
        item.setProcpbzh(pro.getProcpbzh()); // 产品标准号
        item.setProplxx(pro.getProplxx()); // 配料信息
        item.setPropm(pro.getPropm()); // 品名
        item.setProsptm(pro.getProsptm()); // 商品条码
        item.setProzlstr(pro.getProzlstr()); // 产品种类对应汉字
        item.setProcdjd(pro.getProcdjd()); // 产地基地名称
        item.setCppcpch(pro.getCppcpch()); // 商品批次号
        item.setCppcscrq(pro.getCppcscrq()); // 商品生产日期
        item.setProbzqdwmc(pro.getProbzqdwmc()); // 保质期单位名称
        item.setProgg(pro.getProgg()); // 商品规格
        result.add(item);

        items.add(item);
        query(items, result);
        return result;
    }

    public List<QproductDTO> query(List<QproductDTO> items, List<QproductDTO> result) throws Exception {
        List<QproductDTO> itemsExt = new ArrayList<QproductDTO>();
        for (QproductDTO item : items) {
            String code = item.getProid();
            StringBuffer sb = new StringBuffer("");
            sb.append(" SELECT t.* FROM  ");
            sb.append(" (SELECT c.cpclid,c.cpclname,com.commc, com.comdz, com.comyddh,pc.cppcpch, pc.cppcscrq, ");
            sb.append(" p.proid, p.proname, p.prosptm, p.probzgg, p.probzq, p.procpbzh,p.proplxx, ");
            sb.append(" p.propm, p.probzqdwmc, p.procdjd, p.progg, ");
            sb.append(" (select getAa10_aaa103('PROZL',p.prozl)) as prozlstr ");
            sb.append(" FROM qproductcl c, qproduct p, pcompany com, qproductpc pc  ");
            sb.append(" WHERE c.cpclid = p.proid and p.procomid = com.comid and p.proid = pc.proid and  c.proid = :proid  ) t ");
            sb.append(" WHERE NOT EXISTS(  ");
            sb.append(" select * from (SELECT c.proid,c.cpclid FROM qproductcl c WHERE c.proid = :proid) t1,");
            sb.append("               (SELECT c.proid,c.cpclid FROM qproductcl c WHERE c.proid = :proid) t2 ");
            sb.append(" WHERE t1.cpclid=t2.proid AND t.cpclid=t1.cpclid )");
            QproductDTO dto = new QproductDTO();
            dto.setProid(code);
            String[] ParaName = new String[]{"proid", "proid", "proid"};
            int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
            String sql = sb.toString();
            sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
            Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductDTO.class);
            List<QproductDTO> ls = (List) map.get(GlobalNames.SI_RESULTSET);
            QproductDTO qproductDTO = null;
            for (QproductDTO p : ls) {
                qproductDTO = new QproductDTO();
                qproductDTO.setProid(p.getCpclid()); // 商品id
                //	qproductDTO.setProname(p.getCpclname()); // 商品名
                //	qproductDTO.setCpclname(item.getProname()); // 商品名
                qproductDTO.setComdz(p.getComdz()); // 企业地址
                qproductDTO.setCommc(p.getCommc()); // 企业名称
                qproductDTO.setComyddh(p.getComyddh()); // 企业电话
                qproductDTO.setProbzgg(p.getProbzgg()); // 包装规格
                qproductDTO.setProbzq(p.getProbzq()); // 保质期
                qproductDTO.setProbzqdwmc(p.getProbzqdwmc()); // 保质期单位名称
                qproductDTO.setProcpbzh(p.getProcpbzh()); // 产品标准号
                qproductDTO.setProplxx(p.getProplxx()); // 配料信息
                qproductDTO.setPropm(p.getPropm()); // 品名
                qproductDTO.setProsptm(p.getProsptm()); // 商品条码
                qproductDTO.setProzlstr(p.getProzlstr()); // 产品种类对应汉字
                qproductDTO.setProcdjd(p.getProcdjd()); // 产地基地名称
                qproductDTO.setCppcpch(p.getCppcpch()); // 商品批次号
                qproductDTO.setCppcscrq(p.getCppcscrq()); // 商品生产日期
                qproductDTO.setProgg(p.getProgg()); // 商品规格

                itemsExt.add(qproductDTO);
                result.add(qproductDTO);
                System.out.println(qproductDTO.getProname());
            }

        }
        if (itemsExt.size() > 0) {
            return query(itemsExt, result);
        } else {
            return itemsExt;
        }

    }

    /**
     * querySyxxBySym征信评定
     * <p>
     * querySyxxBySym征信评定
     *
     * @param sym 溯源码
     * @return Written by : zy
     * @throws Exception
     */
    public Object querySyxxBySym(String sym) throws Exception {
        if ("".equals(sym)) {
            throw new BusinessException("二维码错误！");
        }
        Map result = new HashMap();
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT com.commc, com.comdz, com.comyddh,pc.cppcpch, pc.cppcscrq, ");
        sb.append(" p.proid, p.proname,p.prosb, p.prosptm,p.progg,p.prosccj,p.propm,p.probzq,p.procdjd,p.proplxx, ");
        sb.append(" p.procpbzh,p.prozl,p.progtin14,p.bzgtin14,p.probzqdwcode,p.probzqdwmc,");
        sb.append(" p.probzgg,p.procjdh,p.procjdz,p.projysl,p.cphyclbz,p.yclproid,p.projj,p.proprice,");
        sb.append(" (select getAa10_aaa103('PROZL',p.prozl)) as prozlstr ");
        sb.append(" FROM qproduct p, pcompany com, qproductpc pc  ");
        sb.append(" WHERE p.procomid = com.comid and p.proid = pc.proid and p.cphyclbz='1' ");
        sb.append("  and p.proid = ");
        sb.append(" (SELECT proid FROM qproductpc WHERE cppcid =  ");
        sb.append(" (SELECT cppcid FROM qsymscb WHERE qsymscbid =  ");
        sb.append(" (SELECT max(qsymscbid) FROM qsymscmxb  ");
        sb.append(" WHERE sym = '").append(sym).append("'))) ");
        String sql = sb.toString();
        System.out.println("sql555666 " + sql);
        //
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductDTO.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        QproductDTO pro = null;
        System.out.println("ls.size() " + ls.size());
        if (ls != null && ls.size() > 0) {
            pro = (QproductDTO) ls.get(0);

            result.put("productInfo", pro); // 产品信息

            List<Fj> v_fjlist = dao.query(Fj.class, Cnd.where("fjwid", "=", pro.getProid()).and("fjtype", "=", "1"));
            result.put("proPiclist", v_fjlist); // 产品图片信息

            List<QproductDTO> clxxList = queryClxx(pro.getProid());
            result.put("productClInfo", clxxList); // 产品材料信息

            List<Qproductjc> jcList = dao.query(Qproductjc.class, Cnd.where("proid", "=", pro.getProid()).and("jcpc", "=", pro.getCppcpch()));
            result.put("productJcInfo", jcList); // 产品检测信息

            List<Qproductszgcxx> scszList = dao.query(Qproductszgcxx.class, Cnd.where("proid", "=", pro.getProid()).and("cppcpch", "=", pro.getCppcpch()));
            result.put("productScszInfo", scszList); // 产品生产生长信息信息


            //检验检测图片信息
            String v_sql = "SELECT f.fjid,f.fjwid,f.fjpath,f.fjtype,f.fjname FROM fj f " +
                    " WHERE EXISTS (SELECT 1 FROM qproductjc q WHERE q.qproductjcid=f.FJWID " +
                    " AND q.jcpc='" + pro.getCppcpch() + "'" +
                    " AND q.proid='" + pro.getProid() + "')";
            List<Fj> v_jyjcPiclist = (List<Fj>) DbUtils.getDataList(v_sql, Fj.class);
            result.put("jyjcPiclist", v_jyjcPiclist);

            List<Fj> v_fjvideolist = dao.query(Fj.class, Cnd.where("fjwid", "=", pro.getProid()).and("fjtype", "=", "14"));
            result.put("fjvideolist", v_fjvideolist); // 产品视频信息

            v_sql = "select a.* from qsymqrylog a where a.qrysym='" + sym + "' order by qrytime desc limit 1 ";
            List<QsymqrylogDTO> v_QsymqrylogDtolist = (List<QsymqrylogDTO>) DbUtils.getDataList(v_sql, QsymqrylogDTO.class);
            QsymqrylogDTO v_QsymqrylogDTO = null;
            if (v_QsymqrylogDtolist != null && v_QsymqrylogDtolist.size() > 0) {
                v_QsymqrylogDTO = v_QsymqrylogDtolist.get(0);
                int v_count = dao.count(Qsymqrylog.class, Cnd.where("qrysym", "=", sym));
                v_QsymqrylogDTO.setQrycount(v_count);
            }
            result.put("QsymqrylogDTO", v_QsymqrylogDTO); //溯源码查询日志

        }

        return result;
    }

    /**
     * checkSymExist
     * <p>
     * checkSymExist
     *
     * @param sym 溯源码
     * @return Written by : gjf
     * @throws Exception
     */
    public boolean checkSymExist(String sym) throws Exception {
        if ("".equals(sym)) {
            throw new BusinessException("二维码不能为空！");
        }
        Map result = new HashMap();
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT sym  ");
        sb.append(" FROM qsymscmxb a  ");
        sb.append(" WHERE 1=1 ");
        sb.append("  and a.sym ='" + sym + "' limit 1 ");
        String sql = sb.toString();
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, Qsymscmxb.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        QproductDTO pro = null;
        if (ls != null && ls.size() > 0) {
            return true;
        }
        ;
        return false;
    }

    /**
     * TODO
     * queryComByQRcode的中文名称：
     * <p>
     * queryComByQRcode的概要说明：
     *
     * @return
     * @throws Exception Written by : zy
     */
    public Object queryComByQRcode(String comid) throws Exception {
        if ("".equals(comid)) {
            throw new BusinessException("二维码错误！");
        }
        Map result = new HashMap();
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT com.commc, com.comdz, com.comyddh, com.comfrhyz ");
        sb.append(" FROM pcompany com  ");
        sb.append(" WHERE comid = '").append(comid).append("' ");
        String sql = sb.toString();
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class);
        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        PcompanyDTO comInfo = null;
        if (ls != null && ls.size() > 0) {
            comInfo = (PcompanyDTO) ls.get(0);
        }
        // 企业基本信息
        result.put("comInfo", comInfo);
//		// 企业许可证信息
//		String v_sql="SELECT xkz.comxkzbh, xkz.comxkfw, xkz.comxkyxqq, xkz.comxkyxqz, "+
//                " (select getAa10_aaa103('COMZZZM', xkz.comxkzlx)) as comxkzlxstr "+
//                " from pcompanyxkz xkz "+
//                " where xkz.comid = '" + comid + "' ";
//		List<PcompanyXkzDTO> v_xkz = (List<PcompanyXkzDTO>)DbUtils.getDataList(v_sql, PcompanyXkzDTO.class);
//		result.put("xkzList", v_xkz);
        return result;
    }

    // 获取产品材料信息
    public List<QproductDTO> queryClxx(String proid) throws Exception {
        //List<Qcphcldygx> clList = dao.query(Qcphcldygx.class, Cnd.where("proid", "=", proid));
        List<QproductDTO> result = new ArrayList<QproductDTO>();
        //System.out.println("result--------------------------"+result.size());
        //for (int i = 0; i < clList.size(); i++) {
        //String cpclid = clList.get(i).getCpclid(); // 材料id
        StringBuffer sb = new StringBuffer();
//			sb.append(" SELECT com.commc, com.comdz, p.proid, p.proname ");
//			sb.append(" FROM qproduct p, pcompany com, qcompanygx gx ");
//			sb.append(" WHERE p.procomid = com.comid and gx.csid = com.comid ");
//			sb.append(" and p.proid = '").append(cpclid).append("' ");

        sb.append(" SELECT p.proid, p.proname ");
        sb.append(" FROM qproduct p,qcphcldygx gx ");
        sb.append(" WHERE p.proid = gx.cpclid ");
        sb.append(" and gx.proid = '").append(proid).append("' ");

        QproductDTO dto = new QproductDTO();
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        String sql = sb.toString();
        System.out.println("===========================" + sql);
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductDTO.class);
        List<QproductDTO> ls = (List) map.get(GlobalNames.SI_RESULTSET);

        if (ls != null && ls.size() > 0) {
            for (QproductDTO v_temp : ls) {
                result.add(v_temp);
            }

        }
        //}
        return result;
    }

    /***
     *
     * queryWfxw的中文名称：查询违法行为
     *
     * queryWfxw概要说明：
     *
     * @param dto
     * @return
     * @throws Exception
     * Written by:tmm
     */
    public Map queryWfxw(PwfxwcsDTO dto, PagesDTO pd)
            throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select * from ");
        sb.append(" pwfxwcs a ");
        sb.append("  where 1=1 ");
        sb.append(" and a.pwfxwcsid =:pwfxwcsid");
        sb.append(" and a.ajdjajdl =:ajdjajdl ");
        sb.append("  and a.wfxwbh like :wfxwbh");
        sb.append("  and a.wfxwms like :wfxwms");
        sb.append("  ORDER BY  wfxwbh  ");
        String sql = sb.toString();
        String[] ParaName = new String[]{"pwfxwcsid", "ajdjajdl", "wfxwbh", "wfxwms"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PwfxwcsDTO.class, pd
                .getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", ls);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    /**
     * 得到执法办案相对应的文书信息
     *
     * @param dto
     * @return
     */
    public Object getzfbaInfoById(BsCheckMasterDTO dto) {
        if ("".equals(dto.getAjdjid()) || dto.getAjdjid() == null) {
            return "输入的文书编码为空";
        }
//		if("".equals(dto.getType())){

        dto.setTbodytype("adjxcjcbl");//表头属性
        Zfwsxcjcbl8 zfwsxcjcbl8 = dao.fetch(Zfwsxcjcbl8.class, Cnd.where("xcjcblid", "=", dto.getAjdjid()));
//		}


        return zfwsxcjcbl8;
    }


    /**
     * 文书页面拼接
     *
     * @param obj 计划id
     * @return
     * @throws Exception
     */
    public String getajdjDocuments(BsCheckMasterDTO dto, Object obj) throws Exception {
        //巡查笔录
        dto.setTbodycode("1");
        StringBuffer sb = new StringBuffer();
        sb.append("<!DOCTYPE html><html> <head><title>文书打印</title><meta http-equiv='content-type' content='text/html; charset=UTF-8'>");
        sb.append("<meta name='Author' content=''> <meta name='Keywords' content=''> <meta name='Description' content=''>");
				sb.append("</head><body>");
//        sb.append("<meta name='viewport' content='height=device-width,width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no'></head><body>");

        BsTbodyInfoDTo tbodyBean = getTbodyInfo(null, dto);
        if (tbodyBean != null) {
            String tdodyInfo = tbodyBean.getTbodyinfo();
            String table = tbodyBean.getTbody();
//					String  tdodyInfo ="";
            //数值替换
            Field[] fields = obj.getClass().getDeclaredFields();
            Method[] methods = obj.getClass().getMethods();
            String classname = obj.getClass().getName();
            String[] array = classname.split("\\.");
            classname = array[array.length - 1];
            //获取模板赋值信息
            tdodyInfo = gettdodyInfo(fields, methods, classname, tdodyInfo, table, obj);
            sb.append(tdodyInfo);
            sb.append("</body></html>");
        }
        return sb.toString();
    }

    /**
     * 文书页面拼接
     *
     * @param obj 计划id
     * @return
     * @throws Exception
     */
    public String tiHuanWenShuZhi(BsCheckMasterDTO dto, Object obj) throws Exception {
        //巡查笔录
        dto.setTbodycode("1");
        StringBuffer sb = new StringBuffer();
        sb.append("<!DOCTYPE html><html> <head><title>文书打印</title><meta http-equiv='content-type' content='text/html; charset=UTF-8'>");
        sb.append("<meta name='Author' content=''> <meta name='Keywords' content=''> <meta name='Description' content=''>");
//				sb.append("</head><body>");
        sb.append("<meta name='viewport' content='height=device-width,width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no'></head><body>");

        BsTbodyInfoDTo tbodyBean = getTbodyInfo(null, dto);
        if (tbodyBean != null) {
            String tdodyInfo = tbodyBean.getTbodyinfo();
            String table = tbodyBean.getTbody();
//					String  tdodyInfo ="";
            //数值替换
            Field[] fields = obj.getClass().getDeclaredFields();
            Method[] methods = obj.getClass().getMethods();
            String classname = obj.getClass().getName();
            String[] array = classname.split("\\.");
            classname = array[array.length - 1];
            //获取模板赋值信息
            tdodyInfo = gettdodyInfo(fields, methods, classname, tdodyInfo, table, obj);
            sb.append(tdodyInfo);
            sb.append("</body></html>");
        }
        return sb.toString();
    }

    /**
     * 获取赋值后的页面字符串
     *
     * @param fields
     * @param methods
     * @param classname
     * @param tdodyInfo
     * @param obj
     * @return
     * @throws Exception
     */
    public String gettdodyInfo(Field[] fields, Method[] methods, String classname, String tdodyInfo, String table, Object obj) throws Exception {
        String tdodyValue = tdodyInfo;
        String tableValue = table;
        String footStr = "<tr><td style='border-color:rgb(0, 0, 0); width:78px'><span style='font-size:10px;'>其他物品</span></td>"
                + "<td colspan='7' style='border-color:rgb(0, 0, 0); width:529px'><p>wpqdqtwp</p></td></tr>";
        String nbsp = "&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        String isStr = "□";
        String notIsStr = "☑";
        for (int i = 0; i < fields.length; i++) {
            //文书对应的对时间，系统编码，和选择做特殊处理
            if ("Zfwsxcjcbl8DTO".equals(classname)) {//现场检查
                //时间和系统编码得做特殊处理
                if ("xcjcjcsjksrq".equals(fields[i].getName())) {//开始检查时间
                    String starttime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("year", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("mothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("date", starttime == null ? nbsp : starttime.substring(8, 10))
                            .replaceFirst("time", starttime == null ? nbsp : starttime.substring(11, 13))
                            .replaceFirst("fen", starttime == null ? nbsp : starttime.substring(14, 16));
                } else if ("xcjcjlrqzrq".equals(fields[i].getName())) {//记录人签字日期
                    String starttime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("jlyear", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("jlmothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("jldate", starttime == null ? nbsp : starttime.substring(8, 10));
                    tdodyValue = tdodyValue.replaceFirst("bjyear", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("bjmothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("bjdate", starttime == null ? nbsp : starttime.substring(8, 10));
                    tdodyValue = tdodyValue.replaceFirst("jcyear", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("jcmothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("jcdate", starttime == null ? nbsp : starttime.substring(8, 10));
                    tdodyValue = tdodyValue.replaceFirst("jzyear", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("jzmothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("jzdate", starttime == null ? nbsp : starttime.substring(8, 10));
                } else  if ("xcjcjcsjjsrq".equals(fields[i].getName())) {
                    String endtime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("to_time", endtime == null ? nbsp : endtime.substring(11, 13))
                            .replaceFirst("to_fen", endtime == null ? nbsp : endtime.substring(14, 16));
                } else if ("xcjcsfsqhb".equals(fields[i].getName())) {
                    String isqz = (String) getMethodValue(fields[i], obj);
                    System.out.println("isqz     " + isqz);
                    if ("0".equals(isqz)) {//否
                        tdodyValue = tdodyValue.replaceFirst("isfqz", isStr)
                                .replaceFirst("notisfqz", notIsStr);
                    } else {//是
                        tdodyValue = tdodyValue.replaceFirst("isfqz", notIsStr)
                                .replaceFirst("notisfqz", isStr);
                    }
                } else if ("dcbljdjclb".equals(fields[i].getName())) {
                    String isqz = (String) getMethodValue(fields[i], obj);
                    Aa10 aa10 = dao.fetch(Aa10.class, Cnd.where("aaa100", "=", "DCBLJDJCLB").and("aaa102", "=", isqz));

                    tdodyValue = tdodyValue.replaceFirst("jctype", aa10 == null ? nbsp : aa10.getAaa103());
                }else  if ("checkqm".equals(fields[i].getName())) {//性别
                    tdodyValue = tdodyValue.replaceFirst("jcrqzpic", getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));

                }else  if ("witnessqm".equals(fields[i].getName())) {//性别
                    tdodyValue = tdodyValue.replaceFirst("jianzrqmpic", getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));

                } else {
                    tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
                }

            } else if ("Zfwswpqd37DTO".equals(classname)) {//物品清单

                if ("wpqdid".equals(fields[i].getName())) {//物件品种
                    String wpqdid = (String) getMethodValue(fields[i], obj);
                    WsgldyService v_WsgldyService = new WsgldyService();
                    Zfwswpqd37DTO v_dto = new Zfwswpqd37DTO();
                    PagesDTO v_pdto = new PagesDTO();
                    v_dto.setWpqdid(wpqdid);
                    Map v_map = v_WsgldyService.queryZfwswpqdmx(v_dto, v_pdto);
                    List<Zfwswpqd37DTO> v_list = (List<Zfwswpqd37DTO>) v_map.get("rows");

                    if (v_list.size() != 0) {
                        StringBuffer sp = new StringBuffer();
                        tableValue = tableValue.replaceFirst("</tbody>", "").replaceFirst("</table>", "");
                        for (Zfwswpqd37DTO dto : v_list) {
                            sp.append("<tr><td style='border-color:rgb(0, 0, 0); width:78px'><span style='font-size:10px'>" + dto.getWpmxpm() + "</span></td><td style='border-color:rgb(0, 0, 0); width:160px'><span style='font-size:10px'>" + dto.getWpmxbsscqy() + "</span></td>")
                                    .append("<td style='border-color:rgb(0, 0, 0); width:48px'><span style='font-size:10px'>" + dto.getWpmxgg() + "</span></td><td style='border-color:rgb(0, 0, 0); width:140px'><span style='font-size:10px'>" + dto.getWpmxscpc() + "</span></td>")
                                    .append("<td style='border-color:rgb(0, 0, 0); width:59px'><span style='font-size:10px'>" + dto.getWpmxsl() + "</span></td><td style='border-color:rgb(0, 0, 0); width:48px'><span style='font-size:10px'>" + dto.getWpmxdj() + "</span></td>")
                                    .append("<td style='border-color:rgb(0, 0, 0); width:60px'><span style='font-size:10px'>" + dto.getWpmxbz() + "</span></td><td style='border-color:rgb(0, 0, 0); width:56px'><span style='font-size:10px'>" + dto.getWpmxbeiz() + "</span></td></tr>");
                        }
//						  sp.append(table).append("</tbody></table>");
                        tableValue = tableValue + sp.toString() + footStr + "</tbody></table>";

                    } else {
                        StringBuffer sp = new StringBuffer();
                        tableValue = tableValue.replaceFirst("</tbody>", "").replaceFirst("</table>", "");
                        for (int j = 0; j < 5; j++) {
                            sp.append("<tr><td style='border-color:rgb(0, 0, 0); width:78px'>&nbsp;</td><td style='border-color:rgb(0, 0, 0); width:160px'>&nbsp;</td>")
                                    .append("<td style='border-color:rgb(0, 0, 0); width:48px'>&nbsp;</td><td style='border-color:rgb(0, 0, 0); width:140px'>&nbsp;</td>")
                                    .append("<td style='border-color:rgb(0, 0, 0); width:59px'>&nbsp;</td><td style='border-color:rgb(0, 0, 0); width:48px'>&nbsp;</p></td>")
                                    .append("<td style='border-color:rgb(0, 0, 0); width:60px'>&nbsp;</td><td style='border-color:rgb(0, 0, 0); width:56px'>&nbsp;</td></tr>");
                        }
                        tableValue = tableValue + sp.toString() + footStr + "</tbody></table>";

                    }

                } else if ("wpqdqtwp".equals(fields[i].getName())) {
                    String wpqdqtwp = (String) getMethodValue(fields[i], obj);
                    footStr = footStr.replaceFirst("wpqdqtwp", wpqdqtwp == null ? nbsp : wpqdqtwp);
                    tableValue = tableValue.replaceFirst("wpqdqtwp", wpqdqtwp == null ? nbsp : wpqdqtwp);

                } else if ("wpqddsrqzrq".equals(fields[i].getName())) {
                    tdodyValue = tdodyValue.replaceFirst("dsrqzrq", getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));

                } else {
                    tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
                }


            } else if ("Zfwsxwdcbl7DTO".equals(classname)) {//询问调查笔录
                if ("dcbldckssj".equals(fields[i].getName())) {//时间
                    String starttime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("year", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("mothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("date", starttime == null ? nbsp : starttime.substring(8, 10))
                            .replaceFirst("time", starttime == null ? nbsp : starttime.substring(11, 13))
                            .replaceFirst("fen", starttime == null ? nbsp : starttime.substring(14, 16));
                } else if ("dcblbdcrqzrq".equals(fields[i].getName())) {//被检查人签字日期
                    String starttime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("bjyear", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("bjmothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("bjdate", starttime == null ? nbsp : starttime.substring(8, 10));
                } else if ("dcbldcrqzrq".equals(fields[i].getName())) {//检查人签字日期
                    String starttime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("jcyear", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("jcmothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("jcdate", starttime == null ? nbsp : starttime.substring(8, 10));
                } else if ("dcbljlrqzrq".equals(fields[i].getName())) {//记录人签字日期
                    String starttime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("jlyear", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("jlmothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("jldate", starttime == null ? nbsp : starttime.substring(8, 10));
                } else if ("dcbldcjssj".equals(fields[i].getName())) {
                    String endtime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("to_time", endtime == null ? nbsp : endtime.substring(11, 13))
                            .replaceFirst("to_fen", endtime == null ? nbsp : endtime.substring(14, 16));
                } else if ("dcblbxwrxb".equals(fields[i].getName())) {//性别
                    String sex = (String) getMethodValue(fields[i], obj);
                    Aa10 aa10 = dao.fetch(Aa10.class, Cnd.where("aaa100", "=", "RYXB").and("aaa102", "=", sex));
                    tdodyValue = tdodyValue.replaceFirst("dcblbxwrxb", aa10 == null ? nbsp : aa10.getAaa103());
                } else if ("dcbljdjclb".equals(fields[i].getName())) {//监督
                    String type = (String) getMethodValue(fields[i], obj);
                    Aa10 aa10 = dao.fetch(Aa10.class, Cnd.where("aaa100", "=", "DCBLJDJCLB").and("aaa102", "=", type));
                    tdodyValue = tdodyValue.replaceFirst("dcbljdjclb", aa10 == null ? nbsp : aa10.getAaa103());
                } else if ("dcblmz".equals(fields[i].getName())) {//民族
                    String mz = (String) getMethodValue(fields[i], obj);
                    Aa10 aa10 = dao.fetch(Aa10.class, Cnd.where("aaa100", "=", "AAC005").and("aaa102", "=", mz));
                    tdodyValue = tdodyValue.replaceFirst("dcblmz", aa10 == null ? nbsp : aa10.getAaa103());
                } else {
                    tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
                }
            } else if ("Zfwscfkyjds12DTO".equals(classname)) {//查封扣押
                if ("cfkyksrq".equals(fields[i].getName())) {//时间
                    String cfkyksrq = (String) getMethodValue(fields[i], obj);
                    cfkyksrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", cfkyksrq);
                    tdodyValue = tdodyValue.replaceFirst("cfkyksrq", cfkyksrq == null ? nbsp : cfkyksrq);
                } else if ("cfkyjsrq".equals(fields[i].getName())) {//时间
                    String cfkyjsrq = (String) getMethodValue(fields[i], obj);
                    cfkyjsrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", cfkyjsrq);
                    tdodyValue = tdodyValue.replaceFirst("cfkyjsrq", cfkyjsrq == null ? nbsp : cfkyjsrq);
                } else if ("cfkygzrq".equals(fields[i].getName())) {//时间
                    String cfkygzrq = (String) getMethodValue(fields[i], obj);
                    cfkygzrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", cfkygzrq);
                    tdodyValue = tdodyValue.replaceFirst("cfkygzrq", cfkygzrq == null ? nbsp : cfkygzrq);
                } else {
                    tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
                }
            } else if ("ZfwsxwdctzsDTO".equals(classname)) {//询问通知书
                if ("xwdcjzrq".equals(fields[i].getName())) {//时间
                    String xwdcjzrq = (String) getMethodValue(fields[i], obj);
                    xwdcjzrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", xwdcjzrq);
                    tdodyValue = tdodyValue.replaceFirst("xwdcjzrq", xwdcjzrq == null ? nbsp : xwdcjzrq);
                } else if ("xwdcdsrqzrq".equals(fields[i].getName())) {//检查人签字日期
                    String starttime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("year", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("mothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("date", starttime == null ? nbsp : starttime.substring(8, 10));
                } else if ("xwdcqzrq".equals(fields[i].getName())) {//时间
                    String xwdcqzrq = (String) getMethodValue(fields[i], obj);
                    xwdcqzrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", xwdcqzrq);
                    tdodyValue = tdodyValue.replaceFirst("xwdcqzrq", xwdcqzrq == null ? nbsp : xwdcqzrq);
                } else {
                    tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
                }
            } else if ("Zfwszlgztzs20DTO".equals(classname)) {//责令通知书
                if ("zlgzwfxwjzrq".equals(fields[i].getName())) {//时间
                    String zlgzwfxwjzrq = (String) getMethodValue(fields[i], obj);
                    zlgzwfxwjzrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", zlgzwfxwjzrq);
                    tdodyValue = tdodyValue.replaceFirst("zlgzwfxwjzrq", zlgzwfxwjzrq == null ? nbsp : zlgzwfxwjzrq);
                } else if ("zlgzdsrqzrq".equals(fields[i].getName())) {//检查人签字日期
                    String starttime = (String) getMethodValue(fields[i], obj);
                    tdodyValue = tdodyValue.replaceFirst("year", starttime == null ? nbsp : starttime.substring(0, 4))
                            .replaceFirst("mothod", starttime == null ? nbsp : starttime.substring(5, 7))
                            .replaceFirst("date", starttime == null ? nbsp : starttime.substring(8, 10));
                } else if ("zlgzgzrq".equals(fields[i].getName())) {//时间
                    String zlgzgzrq = (String) getMethodValue(fields[i], obj);
                    zlgzgzrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", zlgzgzrq);
                    tdodyValue = tdodyValue.replaceFirst("zlgzgzrq", zlgzgzrq == null ? nbsp : zlgzgzrq);
                } else {
                    tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
                }
            } else if ("Zfwsdcxzcfjds29DTO".equals(classname)) {//行政处罚记录
                if ("dccffddbrxb".equals(fields[i].getName())) {//性别
                    String sex = (String) getMethodValue(fields[i], obj);
                    Aa10 aa10 = dao.fetch(Aa10.class, Cnd.where("aaa100", "=", "RYXB").and("aaa102", "=", sex));
                    tdodyValue = tdodyValue.replaceFirst("sex", aa10 == null ? nbsp : aa10.getAaa103());

                } else if ("dccfdsrqzrq".equals(fields[i].getName())) {//时间 dccfdsrqzrq
                    String dccfdsrqzrq = (String) getMethodValue(fields[i], obj);
                    dccfdsrqzrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", dccfdsrqzrq);
                    tdodyValue = tdodyValue.replaceFirst("dangcxzcfdsrqzrq", dccfdsrqzrq == null ? nbsp : dccfdsrqzrq);
                } else if ("dccfgzrq".equals(fields[i].getName())) {//时间
                    String dccfgzrq = (String) getMethodValue(fields[i], obj);
                    dccfgzrq = DateUtil.getDateString("yyyy-mm-dd", "yyyy年mm月dd日", dccfgzrq);
                    tdodyValue = tdodyValue.replaceFirst("dccfgzrq", dccfgzrq == null ? nbsp : dccfgzrq);
                } else {
                    tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
                }
            }else if ("Zfwsxxdjbcwptzs10DTO".equals(classname)) {//先行登记保存武林通知书
                if ("xztzbcqxksrq".equals(fields[i].getName())) {//性别
                    tdodyValue = tdodyValue.replaceFirst("baocqxksrq", getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));

                } else  if ("xztzbcqxjsrq".equals(fields[i].getName())) {//性别
                    tdodyValue = tdodyValue.replaceFirst("baocunqxjsrq", getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));

                }else  if ("checkqm".equals(fields[i].getName())) {//性别
                    tdodyValue = tdodyValue.replaceFirst("picxztzdsrqz", getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));

                }else  if ("xztzdsrqzrq".equals(fields[i].getName())) {//性别
                    tdodyValue = tdodyValue.replaceFirst("partyqzrq", getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));

                }
                else {
                    tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
                }
            } else {
                tdodyValue = tdodyValue.replaceFirst(fields[i].getName(), getMethodValue(fields[i], obj) == null ? nbsp : (String) getMethodValue(fields[i], obj));
            }
        }

//		tdodyValue=tdodyInfo;
        if (!"".equals(tableValue)) {//
            if ("Zfwswpqd37DTO".equals(classname)) {
                tdodyValue = tdodyValue.replaceFirst("wpqdmx_table", tableValue);
            }
        }
        return tdodyValue;
    }

    public String getwpqdlist() {
        return null;
    }

    /**
     * 运行get 获取数值
     *
     * @param field
     * @return
     */
    public static Object getMethodValue(Field field, Object obj) throws Exception {
        //属性名称
//		 System.out.println(field.getName());
        PropertyDescriptor pd = new PropertyDescriptor(field.getName(),
                obj.getClass());
        Method getMethod = pd.getReadMethod();
//           System.out.println(getMethod.getName());
        Object value = getMethod.invoke(obj);//执行get方法返回一个Object
//           System.out.println(value);
        if (value == null || "null".equals(value) || "".equals(value)) {
            value = null;
        }
        return value;
    }

    /**
     * queryjkhtml 摄像头监控统计
     *
     * @return
     * @throws Exception
     */
    public String queryjkhtml() throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT j.jkid,j.jkymc,j.jkqymc,j.aaa027,p.state FROM pcompanyimport p ,jk j ");
        sb.append(" WHERE p.comid=j.jkqybh ORDER BY p.state, j.jkqymc DESC  ");
        String sql = sb.toString();
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JkDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        StringBuffer sbhtml = new StringBuffer();
        sbhtml.append("<!DOCTYPE html> <html> <head lang='en'><title>监控统计</title>");
        sbhtml.append(" <meta http-equiv='content-type' content='text/html; charset=UTF-8'> ");
        sbhtml.append("<style type='text/css'>       ");
        sbhtml.append("    	table{			 ");
        sbhtml.append("    	width:600px;		 ");
        sbhtml.append("    	margin:0px auto;	 ");
        sbhtml.append("    	font:Georgia 11px;	 ");
        sbhtml.append("    	color:black;		 ");
        sbhtml.append("    	text-align:center;	 ");
        sbhtml.append("    	border-collapse:collapse;");
        sbhtml.append("    	}			 ");
        sbhtml.append("    	table td{		 ");
        sbhtml.append("    	border:1px solid gray;	 ");
        sbhtml.append("    	width:196px;		 ");
        sbhtml.append("    	height:30px;		 ");
        sbhtml.append("    	}			 ");
        sbhtml.append("</style>                      ");
        sbhtml.append("</head> <body> <table width='99%'; border='1px'> ");
        sbhtml.append("<tr>  <td>企业名称</td> <td>摄像头名称</td><td>是否打开</td></tr>");
        if (ls.size() > 0) {
            String state = "";  //登录时间
            for (int i = 0; i < ls.size(); i++) {
                JkDTO jk = (JkDTO) ls.get(i);
                state = ("0".equals(jk.getState()) ? "是" : "否");
                sbhtml.append(" <tr> <td>" + jk.getJkqymc() + "</td><td>"
                        + jk.getJkymc() + "</td><td>" + state + "</td></tr>");
            }
        }
        sbhtml.append(" </table> </body> </html>");
        return sbhtml.toString();

    }

    /**
     * queryjchtml 安全监管检查控统计
     *
     * @param dto
     * @return
     * @throws Exception
     */
    public String queryaqjgjchtml(BsCheckMasterDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        String operatedate = "";
        String endtim = "";
        if (dto.getOperatedate() == null) {
            operatedate = SysmanageUtil.getDbtimeYmd();
            dto.setOperatedate(operatedate);
            endtim = operatedate + " 23:59:59";
        } else {
            operatedate = dto.getOperatedate().substring(0, 10);
            endtim = operatedate + " 23:59:59";
        }
        sb.append(" SELECT s.DESCRIPTION operateperson,p.commc,b.operatedate ,bp.plantitle,b.resultstate ");
        sb.append(" FROM bscheckmaster b ,pcompany p,sysuser s,bscheckplan bp ");
        sb.append(" WHERE bp.planid=b.planid AND b.userid=s.USERID AND p.comid=b.comid ");
        sb.append(" AND operatedate > :operatedate ");
        sb.append(" AND operatedate < '" + endtim + "'");
        //sb.append(" AND s.USERNAME LIKE :aae011 ");
        //gu20180522 sb.append(" AND s.userkind='5' AND s.aaa027 LIKE '410523%'");
        String sql = sb.toString();
        String[] ParaName = new String[]{"operatedate"};
        int[] ParaType = new int[]{Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        StringBuffer sbhtml = new StringBuffer();
        sbhtml.append("<!DOCTYPE html> <html> <head lang='en'><title>检查统计</title>");
        sbhtml.append(" <meta http-equiv='content-type' content='text/html; charset=UTF-8'> ");
        sbhtml.append("<style type='text/css'>       ");
        sbhtml.append("    	table{			 ");
        sbhtml.append("    	width:800px;		 ");
        sbhtml.append("    	margin:0px auto;	 ");
        sbhtml.append("    	font:Georgia 11px;	 ");
        sbhtml.append("    	color:black;		 ");
        sbhtml.append("    	text-align:center;	 ");
        sbhtml.append("    	border-collapse:collapse;");
        sbhtml.append("    	}			 ");
        sbhtml.append("    	table td{		 ");
        sbhtml.append("    	border:1px solid gray;	 ");
        sbhtml.append("    	width:115px;		 ");
        sbhtml.append("    	height:30px;		 ");
        sbhtml.append("    	}			 ");
        sbhtml.append("</style>                      ");
        sbhtml.append("</head> <body> <table width='99%'; border='1px'> ");
        sbhtml.append("<tr>  <td>姓名</td> <td>企业名称</td><td>检查标题</td><td>检查时间</td><td>完成状态</td></tr>");
        if (ls.size() > 0) {
            String resultstate = "";  //完成状态
            for (int i = 0; i < ls.size(); i++) {
                BsCheckMasterDTO bm = (BsCheckMasterDTO) ls.get(i);
                resultstate = ("4".equals(bm.getResultstate()) ? "已完成" : "未完成");
                sbhtml.append(" <tr> <td>" + bm.getOperateperson() + "</td><td>"
                        + bm.getCommc() + "</td><td>" + bm.getPlantitle() + "</td><td>"
                        + bm.getOperatedate() + "</td><td>" + resultstate + "</td></tr>");
            }
        }
        sbhtml.append(" </table> </body> </html>");
        return sbhtml.toString();

    }

    /**
     * queryzfbajchtml 执法办案检查统计
     *
     * @param dto
     * @return
     * @throws Exception
     */
    public String queryzfbajchtml(ZfajdjDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        String ajdjczsj = "";
        if (dto.getAjdjczsj() == null) {
            ajdjczsj = SysmanageUtil.getDbtimeYmd();
            dto.setAjdjczsj(ajdjczsj);
        }
        sb.append(" SELECT s.DESCRIPTION lianczy,z.commc ,z.ajdjczsj FROM  zfajdj z,sysuser s");
        sb.append(" WHERE  z.userid=s.USERID  AND z.ajdjczsj > :ajdjczsj ");
        sb.append(" AND s.userkind='5' AND s.aaa027 LIKE '410523%'");
        String sql = sb.toString();
        String[] ParaName = new String[]{"ajdjczsj"};
        int[] ParaType = new int[]{Types.VARCHAR};
//    	String[] ParaName = new String[] {"operatedate","aae011"};
//    	int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, ZfajdjDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        StringBuffer sbhtml = new StringBuffer();
        sbhtml.append("<!DOCTYPE html> <html> <head lang='en'><title>检查统计</title>");
        sbhtml.append(" <meta http-equiv='content-type' content='text/html; charset=UTF-8'> ");
        sbhtml.append("<style type='text/css'>       ");
        sbhtml.append("    	table{			 ");
        sbhtml.append("    	width:600px;		 ");
        sbhtml.append("    	margin:0px auto;	 ");
        sbhtml.append("    	font:Georgia 11px;	 ");
        sbhtml.append("    	color:black;		 ");
        sbhtml.append("    	text-align:center;	 ");
        sbhtml.append("    	border-collapse:collapse;");
        sbhtml.append("    	}			 ");
        sbhtml.append("    	table td{		 ");
        sbhtml.append("    	border:1px solid gray;	 ");
        sbhtml.append("    	width:196px;		 ");
        sbhtml.append("    	height:30px;		 ");
        sbhtml.append("    	}			 ");
        sbhtml.append("</style>                      ");
        sbhtml.append("</head> <body> <table width='99%'; border='1px'> ");
        sbhtml.append("<tr>  <td>姓名</td> <td>企业名称</td><td>登记时间</td></tr>");
        if (ls.size() > 0) {
            for (int i = 0; i < ls.size(); i++) {
                ZfajdjDTO zf = (ZfajdjDTO) ls.get(i);
                sbhtml.append(" <tr><td>" + zf.getLianczy() + "</td><td>"
                        + zf.getCommc() + "</td><td>" + zf.getAjdjczsj() + "</td></tr>");
            }
        }
        sbhtml.append(" </table> </body> </html>");
        return sbhtml.toString();
    }

    public static void main(String[] args) throws Exception {
        BsCheckMasterDTO dto = new BsCheckMasterDTO();
        SjbService sjb = new SjbService();
        PwfxwcsDTO w = new PwfxwcsDTO();
        w.setAjdjajdl("1111");
        sjb.getajdjDocuments(dto, w);
    }

    /**
     * 查询企业对应的溯源码真实跳转地址
     *
     * @param request
     * @param prm_sym
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public List queryPcomsymurl(HttpServletRequest request, String prm_sym) throws Exception {
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from pcomsymurl a,qsymscb b,qsymscmxb c,qproductpc d,qproduct e ");
        sb.append(" where a.comid=e.procomid ");
        sb.append(" and b.qsymscbid = c.qsymscbid ");
        sb.append(" and b.cppcid = d.cppcid ");
        sb.append(" and d.proid = e.proid ");
        sb.append(" and c.sym='" + prm_sym + "' ");
        String sql = sb.toString();
        // 转化sql语句
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcomsymurlDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }

    /**
     * 得到表头信息， todo Delete
     *
     * @return
     * @throws Exception
     */
    public BsTbodyInfoDTo getTbodyInfo(HttpServletRequest request, BsCheckMasterDTO dto) throws Exception {
        //使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.tbodyinfo ,a.tfootinfo,a.tbody from bstbodyinfo a ");
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
     * getPlanTypeList的中文名称：查询企业计划信息
     * <p>
     * getPlanTypeList的概要说明：根据企业ID，年份获取企业计划信息
     * 原名称:getPlanTypeList
     *
     * @param dto comid:企业ID  year:年份
     * @return
     * @throws Exception
     */
    public String getPlanTypeList(HttpServletRequest request, PcompanyDTO dto)
            throws Exception {
        String sql = "";
        StringBuffer sb = new StringBuffer();
        StringBuffer result = new StringBuffer();

        sb.append(" select count(*) as plancount,h.AAA102 as plantype ,h.AAA103 as plantypename");
        sb.append(" from bscheckmaster f, bscheckplan g ,aa10 h ");
        sb.append(" where f.planid=g.planid and  f.operatedate like :year ");
        sb.append("  and h.AAA100='itemtype' and h.AAA102=g.planchecktype  and f.resultstate=4 ");
        sb.append("  and f.comid=:comid GROUP BY h.aaa102 ,f.comid ");
        sb.append(" order by h.aaa102");
        sql = sb.toString();
        String[] ParaName = new String[]{"year", "comid"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);

        Map m = DbUtils
                .DataQuery(GlobalNames.sql, sql, null, BsCheckMasterDTO.class);
        List<BsCheckMasterDTO> ls = (List<BsCheckMasterDTO>) m.get(GlobalNames.SI_RESULTSET);
        if (ls.size() > 0) {
            sb.setLength(0);
            for (BsCheckMasterDTO maser : ls) {
                result.append(maser.getPlantypename() + " ").append(maser.getPlancount()).append(" ");
            }
        }

        return result.toString();
    }

    /**
     * 查询重要性 todo Delete
     *
     * @param code
     * @param value
     * @return
     * @throws Exception
     */
    public String getconentimpinfo(String code, String value) throws Exception {
        //使用字符串缓冲器类拼接查询语句
//		 Cnd wh = null;
//		 System.out.println(dao.fetch(Aa10.class, Cnd.where("AAA100", "=", code).and("AAA102", "=", value)).getAaa103());
        //转化sql语句
        String aaa103 = dao.fetch(Aa10.class, Cnd.where("AAA100", "=", code).and("AAA102", "=", value)).getAaa103();
        return aaa103;
    }

    /**
     * uploadFjsave的中文名称：附件保存
     * <p>
     * uploadFjsave的概要说明：
     *
     * @param request
     * @return Written by : zy
     */
    public String uploadFjsave(HttpServletRequest request, UploadfjDTO dto) {
        try {
            uploadFjsaveImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * uploadFjsaveImp的中文名称：附件保存实现
     * <p>
     * uploadFjsaveImp的概要说明：
     *
     * @param request
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public void uploadFjsaveImp(HttpServletRequest request, UploadfjDTO dto) throws Exception {
        // 获取id
        String v_id = StringHelper.showNull2Empty(request
                .getParameter("id"));
        if ("".equals(v_id)) {
            throw new BusinessException("ID不能为空！");
        }
        // 操作员id
        String v_userid = StringHelper.showNull2Empty(request
                .getParameter("userid"));
        if ("".equals(v_userid)) {
            throw new BusinessException("用户ID不能为空！");
        }
        // 操作员姓名
        String v_username = StringHelper.showNull2Empty(request
                .getParameter("username"));
        if ("".equals(v_username)) {
            throw new BusinessException("用户名不能为空！");
        }
        // 附件参数代码值
        String v_fjcsdmz = StringHelper.showNull2Empty(request
                .getParameter("fjcsdmz"));
        if ("".equals(v_fjcsdmz)) {
            throw new BusinessException("附件参数类别不能为空！");
        }

        String uplodafilepath = dto.getFjpath();
        if (uplodafilepath == null || "".equals(uplodafilepath)) {
            uplodafilepath = "/upload/";
        } else {
            uplodafilepath = "/upload/" + uplodafilepath + "/";
        }
        // 上传文件路径
        String uploadPath = request.getSession().getServletContext()
                .getRealPath(uplodafilepath);
        //文件夹判断
        File path = new File(uploadPath);
        if (!path.exists()) {
            path.mkdirs();//一级目录
        }
        // 读取上传附件
        Integer chunk = 0;// 分割块数
        Integer chunks = 1;// 总分割数
        String fileName = null; // 文件名
        String tempFileName = null;// 临时文件名
        String newFileName = null;// 最后合并后的新文件名
        BufferedOutputStream outputStream = null;
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(1024);
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setHeaderEncoding("UTF-8");
                List<FileItem> items = upload.parseRequest(request);
                // 区分表单域
                for (int i = 0; i < items.size(); i++) {
                    FileItem fi = items.get(i);
                    // 获取文件名
                    tempFileName = fi.getName();
                    if (tempFileName != null) {
                        String chunkName = tempFileName;
                        fileName = tempFileName;
                        if (chunk != null) {
                            chunkName = chunk + "_" + tempFileName;
                        }
                        File savedFile = new File(uploadPath, chunkName);
                        fi.write(savedFile);
                    }
                }
                newFileName = UUID.randomUUID().toString().replace("-", "")
                        .concat(".")
                        .concat(FilenameUtils.getExtension(tempFileName));
                if (chunk != null && chunk + 1 == chunks) {
                    outputStream = new BufferedOutputStream(
                            new FileOutputStream(new File(uploadPath,
                                    newFileName)));
                    // 遍历文件合并
                    for (int i = 0; i < chunks; i++) {
                        File tempFile = new File(uploadPath, i + "_"
                                + tempFileName);
                        byte[] bytes = FileUtils.readFileToByteArray(tempFile);
                        outputStream.write(bytes);
                        outputStream.flush();
                        tempFile.delete();
                    }
                    outputStream.flush();
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
        // 将附件保存进数据库
        String fjpathString = uplodafilepath + newFileName;
        String fjnameString = fileName;
        String[] a = PubFunc.split(fjpathString, ",");
        String[] b = PubFunc.split(fjnameString, ",");
        for (int i = 0; i < a.length; i++) {
            Fj fj = new Fj();
            fj.setFjpath(a[i]); // 附件保存路径
            fj.setFjname(b[i]); // 附件名称
            fj.setFjcsdmz(v_fjcsdmz); // 附件类别
            fj.setFjuserid(v_userid); // 操作员id
            fj.setFjczyxm(v_username); // 操作员姓名
            String fjtype = PubFunc.getFileExt(b[i]);
            if (!"".equals(fjtype)) {
                // 图片
                if (fjtype.equalsIgnoreCase("jpg")
                        || fjtype.equalsIgnoreCase("jpeg")
                        || fjtype.equalsIgnoreCase("png")
                        || fjtype.equalsIgnoreCase("gif")) {
                    fj.setFjtype("1");
                    // 视频
                } else if (fjtype.equalsIgnoreCase("mp4")
                        || fjtype.equalsIgnoreCase("avi")
                        || fjtype.equalsIgnoreCase("rm")
                        || fjtype.equalsIgnoreCase("rmvb")) {
                    fj.setFjtype("3");
                    // 文档
                } else {
                    fj.setFjtype("2");
                }
            }
            fj.setFjwid(v_id); // 关联id
            final String fjid = DbUtils.getSequenceStr();
            fj.setFjid(fjid); // 附件id
            fj.setFjczsj(SysmanageUtil.getDbtimeYmdHnsTimestamp()); // 操作时间
            dao.insert(fj);

//			// 将图片保存至数据库
//			String rootPath = request.getSession().getServletContext()
//					.getRealPath("/");
//			File file = new File(rootPath + File.separator + fj.getFjpath());
//
//			// 将图片读进输入流
//			InputStream fis = new FileInputStream(file);
//			fj.setFjcontent(fis);
//			dao.update(fj);
//			fis.close();
        }
    }

    /**
     * 附件上传
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    public Map uploadFj(HttpServletRequest request, UploadfjDTO dto) throws Exception {
        return uploadFjImp(request, dto);
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    @Aop({"trans"})
    public Map uploadFjImp(HttpServletRequest request, UploadfjDTO dto) throws Exception {
        // 附件上传保存目录
        String uplodaFileFolder = StringHelper.showNull2Empty(request.getParameter("folderName"));
        if ("".equals(uplodaFileFolder)) {
            uplodaFileFolder = "/upload/"; // 默认上传目录
        } else {
            uplodaFileFolder = "/upload/" + uplodaFileFolder + "/";
        }
        // 配合手机端接口使用
        Sysuser user = SysmanageUtil.getSysuser(); // 当前用户
        String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
        if (!"".equals(userid)) {
            user = new Sysuser();
            user = dao.fetch(Sysuser.class, userid);
        } else {
            if (user == null) {
                throw new BusinessException("用户id不能为空");
            }
        }
        // 获取附件所属表id
        String v_id = StringHelper.showNull2Empty(dto.getFjwid());
        if ("".equals(v_id)) {
            v_id = "wuzhuti"; // 如果所属表id为空，定义为wuzhuti
            uplodaFileFolder = "/upload/linshi/"; // 将文件首先上传到临时文件夹
        }
        // 附件参数代码值
        String v_fjcsdmz = StringHelper.showNull2Empty(request.getParameter("fjcsdmz"));
        // 附件类别
        String v_fjType = StringHelper.showNull2Empty(dto.getFjtype());
        if ("".equals(v_fjType)) {
            v_fjType = "1"; // 默认为图片上传
        }
        if (dto.getFjpath() != null && !"".equals(dto.getFjpath())) {
            uplodaFileFolder = dto.getFjpath();
        }

        // 上传文件路径
        String uploadPath = request.getSession().getServletContext().getRealPath(uplodaFileFolder);
        // 文件夹判断
        File path = new File(uploadPath);
        if (!path.exists()) {
            path.mkdirs();
        }
        // 读取上传附件
        Integer chunk = 0; // 分割块数
        Integer chunks = 1; // 总分割数
        // 支持多个附件同时上传
        List<String> fileName = new ArrayList<String>(); // 文件名
        List<String> tempFileName = new ArrayList<String>(); // 临时文件名
        List<String> newFileName = new ArrayList<String>(); // 最后合并后的新文件名
        BufferedOutputStream outputStream = null;
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(1024);
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setHeaderEncoding("UTF-8");
                List<FileItem> items = upload.parseRequest(request);
                // 区分表单域
                for (int i = 0; i < items.size(); i++) {
                    FileItem fi = items.get(i);
                    // 获取文件名
                    tempFileName.add(fi.getName());
                    if (tempFileName != null) {
                        String chunkName = tempFileName.get(i);
                        fileName.add(tempFileName.get(i));
                        if (chunk != null) {
                            chunkName = chunk + "_" + tempFileName.get(i);
                        }
                        File savedFile = new File(uploadPath, chunkName);
                        fi.write(savedFile);
                    }
                }
                for (int i = 0; i < tempFileName.size(); i++) {
                    newFileName.add(UUID.randomUUID().toString().replace("-", "")
                            .concat(".")
                            .concat(FilenameUtils.getExtension(tempFileName.get(i))));
                }
                if (chunk != null && chunk + 1 == chunks) {
                    for (int j = 0; j < newFileName.size(); j++) {
                        outputStream = new BufferedOutputStream(
                                new FileOutputStream(new File(uploadPath, newFileName.get(j))));
                        // 遍历文件合并
                        File tempFile = new File(uploadPath, "0_" + tempFileName.get(j));
                        byte[] bytes = FileUtils.readFileToByteArray(tempFile);
                        outputStream.write(bytes);
                        outputStream.flush();
                        tempFile.delete();
                        outputStream.close();
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
        Map retMap = new HashMap(); // 返回数据
        List fjInfoList = new ArrayList(); // 附件信息
        for (int j = 0; j < newFileName.size(); j++) {
            // 将附件保存进数据库
            String fjpathString = uplodaFileFolder + newFileName.get(j);
            String fjnameString = fileName.get(j);
            String[] a = PubFunc.split(fjpathString, ",");
            String[] b = PubFunc.split(fjnameString, ",");

            for (int i = 0; i < a.length; i++) {
                List<Fj> fjList = dao.query(Fj.class, Cnd.where("fjwid", "=", v_id)
                        .and("FJTYPE", "=", v_fjType));
                // 获取aaa105字段（0：可以上传多张  1：只能上传一张）
                String flag = dao.query(Aa10.class, Cnd.where("AAA100", "=", "FJTYPE")
                        .and("AAA102", "=", v_fjType)).get(0).getAaa105();
                // 根据附件类型，只能上传一张的，再次上传时更新
                if (fjList != null && fjList.size() > 0 && !"wuzhuti".equals(v_id) &&
                        "1".equals(flag)) {
                    Fj fj = fjList.get(0);
                    fj.setFjpath(a[i]); // 附件保存路径
                    fj.setFjname(b[i]); // 附件名称
                    dao.update(fj); // 更新
                    fjInfoList.add(fj);
                } else {
                    Fj fj = new Fj();
                    fj.setFjpath(a[i]); // 附件保存路径
                    fj.setFjname(b[i]); // 附件名称
                    // 附件类别
                    String fjtype = PubFunc.getFileExt(b[i]);
                    if ("1".equals(v_fjType) && !"".equals(fjtype)) {
                        // 图片
                        if (fjtype.equalsIgnoreCase("jpg")
                                || fjtype.equalsIgnoreCase("jpeg")
                                || fjtype.equalsIgnoreCase("png")
                                || fjtype.equalsIgnoreCase("gif")) {
                            fj.setFjtype("1");
                            // 视频
                        } else if (fjtype.equalsIgnoreCase("mp4")
                                || fjtype.equalsIgnoreCase("avi")
                                || fjtype.equalsIgnoreCase("rm")
                                || fjtype.equalsIgnoreCase("rmvb")) {
                            fj.setFjtype("3");
                            // 文档
                        } else {
                            fj.setFjtype("2");
                        }
                    } else {
                        fj.setFjtype(v_fjType);
                    }
                    fj.setFjwid(v_id); // 附件所属表id
                    fj.setFjid(DbUtils.getSequenceStr()); // 附件id
                    fj.setFjcsdmz("".equals(v_fjcsdmz) ? null : v_fjcsdmz); // 附件参数代码值
                    fj.setFjuserid(user.getUserid()); // 用户id
                    fj.setFjczyxm(user.getDescription()); // 操作员姓名
                    fj.setFjczsj(SysmanageUtil.currentTime()); // 操作时间
                    dao.insert(fj);
                    fjInfoList.add(fj);
                }
            }
        }
        retMap.put("fjinfo", fjInfoList);
        return retMap;
    }

    /**
     * queryNews的中文名称：查询新闻
     * <p>
     * queryNews的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    public Map queryNews(Bord dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.newscontent cateid");
        sb.append(" from News a,Newscate b ");
        sb.append(" where 1 = 1 ");
        sb.append("   and a.cateid = b.cateid ");
        sb.append("   and a.newsid =:newsid ");
        sb.append("   order by a.newstjsj desc");
        String[] ParaName = new String[]{"newsid"};
        int[] ParaType = new int[]{Types.VARCHAR};
        String sql = sb.toString();
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Bord.class, pd
                .getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);

        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * saveComdalei的中文名称：添加企业分类
     * <p>
     * saveComdalei的概要说明：
     *
     * @return Written by : sunyifeng
     */
    public String saveQsymqrylog(HttpServletRequest request, QsymqrylogDTO dto) {
        try {
            saveQsymqrylogImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @SuppressWarnings("unchecked")
    @Aop({"trans"})
    public void saveQsymqrylogImpl(HttpServletRequest request, QsymqrylogDTO dto) throws Exception {
        Qsymqrylog v_newQsymqry = new Qsymqrylog();
        String qsymqrylogid = DbUtils.getSequenceStr();
        v_newQsymqry.setQsymqrylogid(qsymqrylogid);
        v_newQsymqry.setQrysym(dto.getQrysym());
        v_newQsymqry.setQrytime(SysmanageUtil.currentTime());
        v_newQsymqry.setQryposition(StringHelper.myDecodeURI(dto.getQryposition()));
        dao.insert(v_newQsymqry);

    }

    /**
     * queryEmergencyList的中文名称：查询应急登记列表信息
     * <p>
     * queryEmergencyList的概要说明：
     *
     * @param dto
     * @param pd
     * @return Written by : zy
     * @throws Exception
     */
    public Map queryEmergencyList(EmeventcheckinDTO dto, PagesDTO pd) throws Exception {

//		List userList = queryUser(dto.getUserid().toString());
//		Sysuser vSysUser = new Sysuser();
//		if (userList != null) {
//			vSysUser = (Sysuser) userList.get(0);
//			// 统筹区编码
//			dto.setAaa027(vSysUser.getAaa027());
//		}
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,");
        sb.append("getAa10_aaa103('EVENTLEVEL',a.eventlevel) as eventlevelaaa103,");
        sb.append("getAa10_aaa103('EVENTSTATE',a.eventstate) as eventstateaaa103,");
        sb.append("(select t.aaa129 from aa13 t where t.aaa027=a.aaa027 limit 1) as aaa027aaa103 ");
        sb.append(" from emeventcheckin a ");
        sb.append(" where 1=1 ");
        sb.append("  and eventid = :eventid"); // 事件id
        sb.append("  and aaa027 like :aaa027 "); // 统筹区
        sb.append("  and operateperson = :operateperson"); // 经办人
        sb.append("  and eventstate = :eventstate"); //事件状态
        if (!StringUtils.isEmpty(dto.getEventaddress())) {
            sb.append("  and eventaddress like '%" + dto.getEventaddress() + "%'"); //事件状态
        }

        sb.append(" order by a.eventid desc ");
        String sql = sb.toString();
        String[] ParaName = new String[]{"eventid", "aaa027", "operateperson", "eventstate"};
        int[] ParaType = new int[]{Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};

        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        System.out.println("sqlsqlsqlsql " + sql);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EmeventcheckinDTO.class,
                pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    /**
     * getSysuserByuserid   查询人员id和人员姓名及手机号
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    public List getSysuserByuserid(HttpServletRequest request, SysuserDTO dto) throws Exception {
        // sql查询语句
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT s.userid, s.DESCRIPTION ,s.mobile ,s.mobile2 FROM sysuser s ");
        sb.append(" where 1 = 1 ");
        sb.append(" AND userkind not in ('6','7','8','30')");
        sb.append(" and s.description like :description ");
        if (StringUtils.isNotEmpty(dto.getUsername())) {
            sb.append(" and (s.mobile like '%" + dto.getUsername() + "%' or s.username like '%" + dto.getUsername() +
                    "%' or s.description like '%" + dto.getUsername() + "%' )");
        }
        sb.append(" order by s.userposition desc");
        String sql = sb.toString();
        String[] paramName = new String[] {"description"};
        int[] paramType = new int[] {Types.VARCHAR};
        Map map = new HashMap();
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        if (dto.getUserid() != null && !"".equals(dto.getUserid())) {
            map = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, SysuserDTO.class, 0, 0, dto.getUserid(), null);
        } else {
            map = DbUtils.DataQuery(GlobalNames.sql, sql, null, SysuserDTO.class);
        }

        List ls = (List) map.get(GlobalNames.SI_RESULTSET);
        List list = new ArrayList();
        if (ls.size() > 0) {
            Iterator<SysuserDTO> it = ls.iterator();
            while (it.hasNext()) {
                SysuserDTO user = it.next();
                Map m = new TreeMap();
                m.put("userid", user.getUserid());
                m.put("description", user.getDescription());
                list.add(m);
            }
            return list;
        }
        return list;
    }

    /**
     * jpushNotice     极光推送
     *
     * @param request
     * @throws Exception
     */
    public void jpushNotice(HttpServletRequest request) throws Exception {
        // 日程推送
        String v_sql = "select a.* from oanoticemanager a where a.sendflag='0' and a.noticetype = '3' ";
        List<OanoticemanagerDTO> v_mylist = DbUtils.getDataList(v_sql, OanoticemanagerDTO.class);
        List sysuserList = new ArrayList();
        if (v_mylist != null && v_mylist.size() > 0) {
            for (OanoticemanagerDTO v_tempdto : v_mylist) {
                sysuserList.clear();
                // 添加接收人id
                sysuserList.add(v_tempdto.getReceivemanid());
                Boolean v_ret = JPushAllUtil.androidSendPushByalias(sysuserList,
                        "1001", v_tempdto.getNoticetitle(),v_tempdto.getNoticecontent());
                Oanoticemanager v_oldOanoticemanager =(Oanoticemanager)dao.fetch(Oanoticemanager.class, v_tempdto.getOanoticemanagerid());
                v_oldOanoticemanager.setSendflag("1");
                if (v_ret){
                    v_oldOanoticemanager.setSendokflag("1");
                }else {
                    v_oldOanoticemanager.setSendokflag("0");
                }
                dao.update(v_oldOanoticemanager);
            }
        }

        // 任务推送
        String v_sql1 = "select a.* from oanoticemanager a where a.sendflag='0' and a.noticetype = '1'";
        List<OanoticemanagerDTO> v_mylist1 = DbUtils.getDataList(v_sql1, OanoticemanagerDTO.class);
        if (v_mylist1 != null && v_mylist1.size() > 0) {
            for (OanoticemanagerDTO v_tempdto1 : v_mylist1) {
                sysuserList.clear();
                // 添加接收人id
                sysuserList.add(v_tempdto1.getReceivemanid());
                Boolean v_ret = JPushAllUtil.androidSendPushByalias(sysuserList,
                        "1002", v_tempdto1.getNoticetitle(),v_tempdto1.getNoticecontent());
                Oanoticemanager v_oldOanoticemanager =(Oanoticemanager)dao.fetch(Oanoticemanager.class, v_tempdto1.getOanoticemanagerid());
                v_oldOanoticemanager.setSendflag("1");
                if (v_ret){
                    v_oldOanoticemanager.setSendokflag("1");
                }else {
                    v_oldOanoticemanager.setSendokflag("0");
                }
                dao.update(v_oldOanoticemanager);
            }
        }

        // 会议推送
        String v_sql2 = "select a.* from oanoticemanager a where a.sendflag='0' and a.noticetype = '2' ";
        List<OanoticemanagerDTO> v_mylist2 = DbUtils.getDataList(v_sql2, OanoticemanagerDTO.class);
        if (v_mylist2 != null && v_mylist2.size() > 0) {
            for (OanoticemanagerDTO v_tempdto2 : v_mylist2) {
                sysuserList.clear();
                // 添加接收人id
                sysuserList.add(v_tempdto2.getReceivemanid());
                Boolean v_ret = JPushAllUtil.androidSendPushByalias(sysuserList,
                        "1003", v_tempdto2.getNoticetitle(),v_tempdto2.getNoticecontent());
                Oanoticemanager v_oldOanoticemanager =(Oanoticemanager)dao.fetch(Oanoticemanager.class, v_tempdto2.getOanoticemanagerid());
                v_oldOanoticemanager.setSendflag("1");
                if (v_ret){
                    v_oldOanoticemanager.setSendokflag("1");
                }else {
                    v_oldOanoticemanager.setSendokflag("0");
                }
                dao.update(v_oldOanoticemanager);
            }
        }
    }

    /**
     * 的中文名称：查询应急调度回复内容
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception written by ： lfy
     */
    @SuppressWarnings("rawtypes")
    //TODO  文书36
    public Object queryYingjidiaoduHuifu(HttpServletRequest request,
                                  OanoticemanagerDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,b.description from ");
        sb.append("  Oanoticemanager a,sysuser b ");
        sb.append("  where a.receivemanid=b.userid ");
        sb.append("  and a.noticetype = '11' and havereadflag='0'  limit 1 ");
        String sql = sb.toString();
        String[] ParaName = new String[]{};
        int[] ParaType = new int[]{};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
                                  OanoticemanagerDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        OanoticemanagerDTO v_OanoticemanagerDTO=null;
        if (ls != null && ls.size() > 0) {
            v_OanoticemanagerDTO = (OanoticemanagerDTO) ls.get(0);
            Oanoticemanager v_oldOanoticemanager=dao.fetch(Oanoticemanager.class,v_OanoticemanagerDTO.getOanoticemanagerid());
            v_oldOanoticemanager.setHavereadflag("1");
            dao.update(v_oldOanoticemanager);
        }
        return v_OanoticemanagerDTO;
    }

    /**
     *
     * addHuanxinFriendBatch的中文名称：增加环信好友
     *
     * addSysuser的概要说明：
     *
     * @return Written by : zjf
     *
     */
    public boolean addHuanxinFriendForAllUser(HttpServletRequest request) {
        try {
            return addHuanxinFriendForAllUserImp(request);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Aop( { "trans" })
    public boolean  addHuanxinFriendForAllUserImp(HttpServletRequest request) throws Exception {
        //dto.setUserid(userid);
        //dto.setPasswd(MD5Util.MD5(GlobalNameS.RESET_PASSWORD).toLowerCase());
        //需要有userid  passwd
      //  Sysuser v_Sysuser= (Sysuser)SysmanageUtil.getSysuser();
        String v_sql="";

        Sysuser v_tempSysuser=new Sysuser();
        v_sql="select a.* from sysuser a where a.easemobflag='1'";
        List<Sysuser> v_huanxinUser=DbUtils.getDataList(v_sql,Sysuser.class);
        for (Sysuser huanxinuser:v_huanxinUser){
            v_sql="select a.* from sysuser a where a.easemobflag='1' and a.userid<>'"+huanxinuser.getUserid()+
                    "' and not exists (select 1 from sysuserhuanxinfriend b where b.userid='"+huanxinuser.getUserid()+"' and b.frienduserid=a.userid)";
            List<Sysuser> v_frienduser=DbUtils.getDataList(v_sql,Sysuser.class);
            for (Sysuser frienduser:v_frienduser){
                v_tempSysuser.setUserid(huanxinuser.getUserid());
                v_tempSysuser.setPasswd(huanxinuser.getPasswd());
                v_tempSysuser.setEasemobfriend(frienduser.getUserid());

                if (!SysEasemobService.getInstance().addSysuserEasemobFriend(v_tempSysuser)){
                    //throw new BusinessException("删除环信用户失败");
                    return false;
                }

                Sysuserhuanxinfriend v_newSysuserhuanxinfriend=new Sysuserhuanxinfriend();
                String v_Sysuserhuanxinfriendid=DbUtils.getSequenceStr();
                v_newSysuserhuanxinfriend.setSysuserhuanxinfriendid(v_Sysuserhuanxinfriendid);
                v_newSysuserhuanxinfriend.setUserid(huanxinuser.getUserid());
                v_newSysuserhuanxinfriend.setFrienduserid(frienduser.getUserid());
                v_newSysuserhuanxinfriend.setCzyname("sysinit");
                v_newSysuserhuanxinfriend.setCzsj(SysmanageUtil.currentTime());
                dao.insert(v_newSysuserhuanxinfriend);

            }
        }
        return true;

    }

    public String jpushMinglingMsgAll(HttpServletRequest request, EmeventcheckinDTO dto)
            throws Exception {
        //给手机端推送的消息，格式定位 mingling=yingjidiaodu,title=应急调度,content= 已读
        //应急视频，格式定位 mingling=yingjishipin,title=应急视频,content=
        List sysuserList = new ArrayList();

        List<Sysuser> v_listuser=new ArrayList<Sysuser>();
        if (!com.alibaba.druid.util.StringUtils.isEmpty(dto.getUsergridstr())){
            v_listuser= Json.fromJsonAsList(Sysuser.class, dto.getUsergridstr());
        }

        //String v_sql="select a.* from sysuser a where a.userkind not in ('6','7','8','20','21','30')";
        //List<Sysuser> v_listsysuser=(List<Sysuser>)DbUtils.getDataList(v_sql,Sysuser.class);
        for (Sysuser v_tempsysuser:v_listuser ){
            sysuserList.add(v_tempsysuser.getUserid());
            //dto.setOperateperson(v_tempsysuser.getUserid());
            //jpushMinglingMsg(request,dto);
        }


        String v_msg="mingling="+dto.getJpushmingling()+"&title="+dto.getJpushtitle()+"&content="+dto.getJpushcontent();
        Boolean v_success= JPushAllUtil.androidSendMsgPushByalias(sysuserList, "1",v_msg );
        if (v_success) {
            return "";
        }else{
            return "推送失败";
        }
    }



}
