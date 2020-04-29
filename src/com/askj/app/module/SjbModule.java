package com.askj.app.module;

import com.askj.app.service.SjbService;
import com.askj.baseinfo.dto.*;
import com.askj.baseinfo.service.PcompanyService;
import com.askj.baseinfo.service.PcomryService;
import com.askj.baseinfo.service.pub.PubService;
import com.askj.emergency.dto.EmeventcheckinDTO;
import com.askj.emergency.service.EmergencyService;
import com.askj.jk.dto.JkDTO;
import com.askj.jk.dto.JkqyfzrDTO;
import com.askj.jk.service.JkglService;
import com.askj.ncjtjc.dto.CsDTO;
import com.askj.ncjtjc.dto.LyDTO;
import com.askj.ncjtjc.dto.ZyDTO;
import com.askj.ncjtjc.module.NcjtjcApiModule;
import com.askj.oa.dto.OanoticemanagerDTO;
import com.askj.spsy.dto.QproductDTO;
import com.askj.spsy.dto.QsymqrylogDTO;
import com.askj.spsy.entity.Qproductjc;
import com.askj.spsy.entity.Qproductszgcxx;
import com.askj.supervision.dto.BsCheckDetailDTO;
import com.askj.supervision.dto.BsCheckMasterDTO;
import com.askj.supervision.dto.BscheckplanDTO;
import com.askj.supervision.dto.OmcheckbasisDTO;
import com.askj.supervision.entity.BsCheckDetail;
import com.askj.supervision.entity.BsCheckMaster;
import com.askj.supervision.module.SupervisionApiModule;
import com.askj.supervision.module.SupervisionOldApiModule;
import com.askj.zfba.dto.*;
import com.askj.zfba.service.PzfryService;
import com.askj.zfba.service.pub.WsgldyService;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.job.QuartzManager;
import com.zzhdsoft.siweb.dto.Aa10DTO;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.UploadfjDTO;
import com.zzhdsoft.siweb.dto.news.NewsDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.Bord;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.sysmanager.Syslogonlog;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.news.NewsService;
import com.zzhdsoft.siweb.service.sysmanager.SysEasemobService;
import com.zzhdsoft.siweb.service.sysmanager.SysorgService;
import com.zzhdsoft.siweb.service.sysmanager.SysuserService;
import com.zzhdsoft.utils.*;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.document.DocumentInfo;
import com.zzhdsoft.utils.push.JPushAllUtil;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Strings;
import org.nutz.mvc.ViewModel;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;

/**
 * SjbModule的中文名称：司机宝Module
 * <p>
 * SjbModule的描述:
 * <p>
 * Written by : zjf
 */
@At("/common/sjb")
@IocBean
public class SjbModule {

    protected final Logger logger = Logger.getLogger(SjbModule.class);

    @Inject
    protected SjbService sjbService;

    @Inject
    protected SupervisionApiModule supervisionApiModule;

    @Inject
    protected SupervisionOldApiModule supervisionOldApiModule;

    @Inject
    protected SysorgService sysorgService;

    @Inject
    protected PubService pubService;

    @Inject
    protected EmergencyService emergencyService;

    @Inject
    private PcompanyService pcompanyService;

    @Inject
    protected JkglService jkglService;

    @Inject
    protected WsgldyService wsgldyService;

    @Inject
    protected NewsService newsService;

    @Inject
    private SysuserService sysuserService;

    @Inject
    private NcjtjcApiModule ncjtjcApiModule;

    @Inject
    private PcomryService pcomryService;

    @Inject
    private PzfryService pzfryService;
    /**
     * updateCompanyXkz的中文名称：修改企业许可证
     * <p>
     * updateCompanyXkz的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     * @throws Exception
     */
    @DocumentInfo(
            sort = 51,
            name = "updateCompanyXkz",
            desc = "修改企业许可证",
            functiondesc = "修改企业许可证",
            author = "zy",
            params = " comxkzid :许可证id /" +
                    "comid：企业id /" +
                    "comxkzbh：许可证编号 /" +
                    "comxkfw：许可范围 /" +
                    "comxkyxqq：许可有效期起 /" +
                    "comxkyxqz：许可有效期止 /" +
                    "comxkzlx：许可证类型 /" +
                    "comxkzzcxs：组成形式 /" +
                    "comxkzztyt：主体业态 /" +
                    "comxkzjycs：经营场所 /" +
                    "sjdatacomdm：省局代码 /" +
                    "sjdataid：省局id /" +
                    "sjdatatime：省局时间 /",
            returndesc = "{ " +
                    "\"code\": 返回码, " +
                    "\"msg\": 返回信息, " +
                    "}",
            date = "2018-03-30",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object updateCompanyXkz(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto) {
        return SysmanageUtil.execAjaxResult(pcompanyService.savePcompanyXkzSingle(request, dto));
    }


    /**
     * 跳转到聊天页面
     */
    @At
    @Ok("jsp:/jsp/jk/qydtjk/chat")
    public void chatIndex(HttpServletRequest request){
        //极光聊天信息
    }


    /**
     * getAa01toJSON的中文名称：查询系统参数表AA01
     * <p>
     * getAa01toJSON的概要说明：
     *
     * @param aaa001
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 1,
            name = "getAa01toJSON",
            desc = "查询系统参数表AA01",
            functiondesc = "查询系统参数表AA01",
            author = "zjf",
            params = "aaa001: 参数类别代码 /aaa001=APPVERSION_ANDROID（获取app版本号）/ aaa001=APPURL_ANDROID（获取app下载地址）/ aaa001=VIDEO_URL（应急指挥视频）",
            returndesc = "{\"data\":{\n" +
                    "\"aaa001\":\"参数类别代码\",\n" +
                    "\"aaa002\":\"参数类别名称\",\n" +
                    "\"aaa005\":\"参数值\",\n" +
                    "\"aaa104\":\"代码可维护标志\",\n" +
                    "\"aaz499\":\"综合参数ID\",\n" +
                    "\"aaa105\":\"参数值域说明\",\n" +
                    "\"aaa027\":\"统筹区编码\"},\n" +
                    "\"code\":\"0\",\n" +
                    "\"msg\":\"\"\n" +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @SuppressWarnings({"rawtypes", "unchecked"})
    @At
    @Ok("json")
    public Object getAa01toJSON(@Param("aaa001") String aaa001) {

        Map map = new HashMap();
        try {
            Aa01 aa01 = null;
            aa01 = SysmanageUtil.getAa01(aaa001);
            if (aa01 != null) {
                map.put("data", aa01);
            } else {
                throw new BusinessException("获取系统参数表数据【" + aaa001 + "】失败！");
            }
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    @At
    @Ok("json")
    public Object getAa01toJSON2(HttpServletRequest request,@Param("aaa001") String aaa001) {
        String v_json=request.getParameter("json");

        System.out.println(v_json);
        Map map = new HashMap();
        try {
            Aa01 aa01 = null;
            aa01 = SysmanageUtil.getAa01(aaa001);
            if (aa01 != null) {
                map.put("data", aa01);
            } else {
                throw new BusinessException("获取系统参数表数据【" + aaa001 + "】失败！");
            }
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * getAppVersion的中文名称：获取APP的最新版本号
     * <p>
     * getAppVersion的概要说明：
     *
     * @param request
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 9,
            name = "getAppVersion",
            desc = "获取APP的最新版本号",
            functiondesc = "获取APP的最新版本号",
            author = "zjf",
            params = "platform:0表示ios ， 1表示Android，必填",
            returndesc = "{\"newAppVersion\":\"最新版本号\",\"code\":\"0\",\"msg\":\"\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getAppVersion(HttpServletRequest request) {
        Map map = new HashMap();
        try {
            String platform = request.getParameter("platform");
            Aa01 aa01 = new Aa01();
            if ("0".equals(platform)) {
                aa01 = SysmanageUtil.getAa01("APPVERSION_IOS");
            } else if ("1".equals(platform)) {
                aa01 = SysmanageUtil.getAa01("APPVERSION_ANDROID");
            }
            map.put("newAppVersion", aa01.getAaa005());
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryAjdjZxpd：征信评定
     * <p>
     * queryAjdjZxpd：征信评定
     *
     * @param request
     * @return
     * @throws Exception Written by : zy
     */
    @DocumentInfo(
            sort = 2,
            name = "queryAjdjZxpd",
            desc = "征信评定",
            functiondesc = "征信评定",
            author = "zy",
            params = "无",
            returndesc = "{\"data\":{   " +
                    "\"id\":\"项目编码\",  " +
                    "\"text\":\"项目名称\"},  " +
                    "\"code\":\"0\",  " +
                    "\"msg\":\"\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryAjdjZxpd(HttpServletRequest request) {

        Map map = new HashMap();
        try {
            List list = sjbService.queryAjdjZxpd(request);
            if (list != null && list.size() > 0) {
                map.put("data", list);
            } else {
                map.put("data", "");
            }
            map.put("data", list);
            return SysmanageUtil.execAjaxResult(map, null);//
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);//
        }
    }

    /**
     * getAa10toJSON的中文名称：查询系统代码表AA10
     * <p>
     * getAa10toJSON的概要说明：
     *
     * @param aaa100
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 3,
            name = "getAa10toJSON",
            desc = "查询系统代码表AA10",
            functiondesc = "查询系统代码表AA10",
            author = "zjf",
            params = "aaa100：代码类别 ，必填",
            returndesc = "{\"data\":{   " +
                    "\"id\":\"代码值\",  " +
                    "\"text\":\"代码名称\"},  " +
                    "\"code\":\"0\",  " +
                    "\"msg\":\"\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getAa10toJSON(@Param("aaa100") String aaa100) {
        Map map = new HashMap();
        try {
            List ls = sjbService.getAa10List(aaa100);
            if (ls != null && ls.size() > 0) {
                map.put("data", ls);
            } else {
                throw new BusinessException("获取系统代码表数据【" + aaa100 + "】失败！");
            }
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * 返回树状结构的类别区划
     *
     * @param aaa100
     * @return
     */
    @DocumentInfo(
            sort = 4,
            name = "getAa10toJSONstr",
            desc = "返回树状结构的类别区划",
            functiondesc = "返回树状结构的类别区划",
            author = "zjf",
            params = "aaa100: 参数类别代码 /aaa001=APPVERSION_ANDROID（获取app版本号）/ aaa001=APPURL_ANDROID（获取app下载地址）/ aaa001=VIDEO_URL（应急指挥视频）",
            returndesc = "{\"data\":{   " +
                    "\"id\":\"代码值\",  " +
                    "\"text\":\"代码名称\"},  " +
                    "\"code\":\"0\",  " +
                    "\"msg\":\"\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getAa10toJSONstr(@Param("aaa100") String aaa100, @Param("aaa104") String aaa104, @Param("planid") String planid) {
        Map map = new HashMap();
        try {
            List ls = sjbService.getAa10Liststr(aaa100, aaa104, planid);
            if (ls != null && ls.size() > 0) {
                map.put("data", ls);
            } else {
                Aa10 aa10 = new Aa10();
                //aa10.setAae031(1);
                ls.add(aa10);
                map.put("data", ls);
            }
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * getAa10Byaaa101toJSON的中文名称：获取大类相关子类(手机需要新增字段 userid)
     * <p>
     * getAa10Byaaa101toJSON的概要说明：
     *
     * @return Written by : tmm ,String userid
     */
    @DocumentInfo(
            sort = 5,
            name = "getAa10Byaaa101toJSON",
            desc = "获取大类相关子类(手机需要新增字段 userid)",
            functiondesc = "获取大类相关子类(手机需要新增字段 userid)",
            author = "zjf",
            params = "userid: 登录用户ID /aaa101：企业类别，必填 / （aaa101=spsc 食品类别 /aaa101=ypsc   药品类  ），必选其一  /aaa100=comdalei ，必填",
            returndesc = "{\"total\":15," +
                    "\"code\":\"0\"," +
                    "\"msg\":\"\"," +
                    "\"rows\":" +
                    "{\"aaz093\":\"30636\"," +
                    "\"id\":\"代码值\"," +
                    "\"text\":\"代码名称\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getAa10Byaaa101toJSON(HttpServletRequest request, @Param("..") Aa10DTO dto) {
        Map map = new HashMap();
        try {
            List ls = sjbService.getAa10ListByaaa101(dto);
            map.put("rows", ls);
            map.put("total", ls.size());
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
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
     */
    @DocumentInfo(
            sort = 10,
            name = "loginSjb",
            desc = "APP用户登录",
            functiondesc = "APP用户登录",
            author = "zjf",
            params = "username:用户名 ，必填 / passwd：密码，必填  / Logonappvision：手机app版本号",
            returndesc = "{\"data\":[\n" +
                    "{\n" +
                    "\"userid\":\"用户id\",\n" +
                    "\"mobile\":\"手机号\",\n" +
                    "\"passwd\":\"密码\",\n" +
                    "\"username\":\"执法人员姓名\",\n" +
                    "\"aac003\":\"姓名\",\n" +
                    "\"aac002\":\"身份证号\",\n" +
                    "\"aaa027\":\"统筹区\",\n" +
                    "\"aaz010\":\"当事人id\",\n" +
                    "\"description\":\"用户描述\",\n" +
                    "\"lockstate\":\"账户锁定状态\",\n" +
                    "\"orgid\":\"机构id\",\n" +
                    "\"userkind\":\"用户类别\",\n" +
                    "\n" +
                    "\"aae383\":\"区域级别\",\n" +
                    "\"reprole\":\"权限\",\n" +
                    "\n" +
                    "}, \n" +
                    "..................\n" +
                    "]\n" +
                    ",\"code\":\"0\",\"msg\":\"\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object loginSjb(HttpServletRequest request, @Param("..") SysuserDTO dto) {
        Map map = new HashMap();
        try {
            SysuserDTO sysuser = sjbService.loginSjb(request, dto);
            map.put("data", sysuser);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * modifyPwd的中文名称：用户修改密码
     * <p>
     * modifyPwd的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zjf
     */
    @DocumentInfo(
            sort = 11,
            name = "modifyPwd",
            desc = "用户修改密码",
            functiondesc = "用户修改密码",
            author = "zjf",
            params = "username：用户名 ， 必填 / passwd:老密码 ，必填 / passwd2：新密码，必填",
            returndesc = "{\"data\":[\n" +
                    " ]\n" +
                    ",\"code\":\"0\",\"msg\":\"\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object modifyPwd(HttpServletRequest request, @Param("..") SysuserDTO dto)
            throws Exception {
        return SysmanageUtil.execAjaxResult(sjbService.modifyPwd(request, dto));
    }

    /**
     * setUserPhoto的中文名称：设置系统用户照片
     * <p>
     * setUserPhoto的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zjf
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object setUserPhoto(HttpServletRequest request, @Param("..") SysuserDTO dto) {
        Map map = new HashMap();
        try {
            String filePath = sjbService.setUserPhoto(request, dto);
            if (!Strings.isBlank(filePath)) {
                int pfindex = filePath.lastIndexOf("\\");
                String fileName = filePath.substring(pfindex + 1);
                filePath = GlobalNameS.CAMERA_UPLOAD_FILE_PATH + File.separator + fileName;
                filePath = filePath.replace("\\", "/");
            }

            map.put("filePath", filePath);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * getUserPhoto的中文名称：获取系统用户照片
     * <p>
     * getUserPhoto的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zjf
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getUserPhoto(HttpServletRequest request, @Param("..") SysuserDTO dto) {
        Map map = new HashMap();
        try {
            String filePath = sjbService.getUserPhoto(request, dto);
            if (!Strings.isBlank(filePath)) {
                int pfindex = filePath.lastIndexOf("\\");
                String fileName = filePath.substring(pfindex + 1);
                filePath = GlobalNameS.CAMERA_DOWNLOAD_FILE_PATH + File.separator + fileName;
                filePath = filePath.replace("\\", "/");
            }

            map.put("filePath", filePath);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * getSysFunctionByUserId的中文名称：获取手机用户的菜单权限
     * <p>
     * getSysFunctionByUserId的概要说明：手机APP专用
     *
     * @return Written by : zjf
     * @throws Exception
     */
    @DocumentInfo(
            sort = 11,
            name = "getSysFunctionByUserId",
            desc = "获取手机用户的菜单权限",
            functiondesc = "获取手机用户的菜单权限 手机APP专用",
            author = "zjf",
            params = "userId: 用户id ，必填 ",
            returndesc = "{\"total\":返回条数,\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":[\"childnum\":菜单孩子个数," +
                    "\"isparent\":是否是父节点 true表示是," +
                    "\"isopen\":是否打开 true表示," +
                    "\"parentname\":\"父菜单名称\"," +
                    "\"functionid\":\"菜单id\"," +
                    "\"location\":\"菜单url\"," +
                    "\"title\":\"菜单名称\"," +
                    "\"parent\":\"父菜单id\"," +
                    "\"orderno\":菜单排序," +
                    "\"type\":\"菜单类型\"," +
                    "\"visible\":\"是否显示该菜单\"," +
                    "\"bizid\":\"菜单标志\"," +
                    "\"target\":\"\"," +
                    "\"systemcode\":\"所属子系统\"]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object getSysFunctionByUserId(HttpServletRequest request, @Param("userId") String userid,
                                         @Param("parentid") String parentid) {
        Map map = new HashMap();
        try {
            map = sjbService.getSysFunctionByUserId(request, userid, parentid);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * addSysuserLocation的中文名称：APP用户上报GPS位置
     * <p>
     * addSysuserLocation的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 12,
            name = "addSysuserLocation",
            desc = "APP用户上报GPS位置",
            functiondesc = "APP用户上报GPS位置 手机APP专用",
            author = "zjf",
            params = "userId: 用户id ， 必填 /" +
                    " dwfs：定位方式 ，必填 " +
                    " dwjdzb：定位精度坐标，选填 /" +
                    " dwdd：定位地点，选填 /" +
                    " dwwdzb:定位纬度坐标 ，选填 / ",
            returndesc = "{\"code\":\"状态码\",\"msg\":\"返回信息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object addSysuserLocation(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return SysmanageUtil.execAjaxResult(sjbService.addSysuserLocation(request, dto));
    }

    /**
     * getSysuserLocation的中文名称：获取APP用户GPS位置
     * <p>
     * getSysuserLocation的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 13,
            name = "getSysuserLocation",
            desc = "获取APP用户GPS位置",
            functiondesc = "获取APP用户GPS位置 手机APP专用",
            author = "zjf",
            params = "userid ：用户id",
            returndesc = "{\"total\":返回总记录,\"code\":\"状态码\",\"msg\":\"\",\"rows\":" +
                    "{\"dwsj\":\"定位时间\"," +
                    "\"username\":\"用户名\"," +
                    "\"mobile2\":\"\"," +
                    "\"address\":\"\"," +
                    "\"description\":\"用户描述\"," +
                    "\"userid\":\"用户id\"," +
                    "\"lng\":\"经度坐标\"," +
                    "\"lat\":\"纬度坐标\"," +
                    "\"mobile\":\"手机号\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getSysuserLocation(HttpServletRequest request, @Param("..") ZyDTO dto,
                                     @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        List sjclList = new ArrayList();
        try {
            // 获取用户历史轨迹
            Map maps = sjbService.getSysUserHisLocation(dto, pd);
            List ls = (List) maps.get("rows");
            if (ls != null && ls.size() > 0) {
                for (int i = 0; i < ls.size(); i++) {
                    Map zyDTO = (HashMap) ls.get(i);

                    Map mdtoMap = new HashMap();
                    String lng = StringHelper.showNull2Empty(zyDTO.get("dwjdzb"));
                    String lat = StringHelper.showNull2Empty(zyDTO.get("dwwdzb"));
                    String address = StringHelper.showNull2Empty(zyDTO.get("dwdd"));
                    String dwsj = StringHelper.showNull2Empty(zyDTO.get("dwsj"));
                    String userid = StringHelper.showNull2Empty(zyDTO.get("userid"));
                    String username = StringHelper.showNull2Empty(zyDTO.get("username"));
                    String description = StringHelper.showNull2Empty(zyDTO.get("description"));
                    String mobile = StringHelper.showNull2Empty(zyDTO.get("mobile"));
                    String mobile2 = StringHelper.showNull2Empty(zyDTO.get("mobile2"));

                    mdtoMap.put("address", address);
                    mdtoMap.put("lng", lng);
                    mdtoMap.put("lat", lat);
                    mdtoMap.put("dwsj", dwsj);
                    mdtoMap.put("userid", userid);
                    mdtoMap.put("username", username);
                    mdtoMap.put("description", description);
                    mdtoMap.put("mobile", mobile);
                    mdtoMap.put("mobile2", mobile2);
                    sjclList.add(mdtoMap);
                }
            } else {
                throw new BusinessException("没有获取到用户的定位信息！");
            }

            map.put("rows", sjclList);
            map.put("total", maps.get("total"));
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * getSysUserHisLocation的中文名称：获取APP用户历史轨迹
     * <p>
     * getSysUserHisLocation的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 13,
            name = "getSysUserHisLocation",
            desc = "获取APP用户历史轨迹",
            functiondesc = "获取APP用户历史轨迹 手机APP专用",
            author = "zjf",
            params = "userid ：用户id",
            returndesc = "{\"total\":返回总记录,\"code\":\"状态码\",\"msg\":\"\"," +
                    "rows\":[{\"dwsj\":\"定位时间\"," +
                    "\"address\":\"地址\"," +
                    "\"lng\":\"经度坐标\"," +
                    "\"lat\":\"纬度坐标\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked", "unused"})
    public Object getSysUserHisLocation(HttpServletRequest request, @Param("..") ZyDTO dto,
                                        @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        List sjclList = new ArrayList();
        try {
            String userid = dto.getUserid();
            if ("".equals(userid)) {
                throw new BusinessException("用户ID不能为空！");
            }
            Long begindate = null;
            Long enddate = null;
            if ("".equals(dto.getStartDate())) {
                begindate = System.currentTimeMillis();
            } else {
                begindate = PubFunc.getTime(dto.getStartDate());
            }
            if ("".equals(dto.getEndDate())) {
                Calendar cal = PubFunc.getCal(dto.getStartDate());
                cal.add(Calendar.DAY_OF_WEEK, 1); // 开始时间加7天
                enddate = cal.getTime().getTime();
            } else {
                enddate = PubFunc.getTime(dto.getEndDate());
            }

            // 获取用户历史轨迹
            Map maps = sjbService.getSysUserHisLocation(dto, pd);
            List ls = (List) maps.get("rows");
            if (ls != null && ls.size() > 0) {
                for (int i = 0; i < ls.size(); i++) {
                    Map zyDTO = (HashMap) ls.get(i);

                    Map mdtoMap = new HashMap();
                    String lng = StringHelper.showNull2Empty(zyDTO.get("dwjdzb"));
                    String lat = StringHelper.showNull2Empty(zyDTO.get("dwwdzb"));
                    String address = StringHelper.showNull2Empty(zyDTO.get("dwdd"));
                    String dwsj = StringHelper.showNull2Empty(zyDTO.get("dwsj"));

                    mdtoMap.put("address", address);
                    mdtoMap.put("lng", lng);
                    mdtoMap.put("lat", lat);
                    mdtoMap.put("dwsj", dwsj);
                    sjclList.add(mdtoMap);
                }
            } else {
                throw new BusinessException("没有获取到用户的历史轨迹信息！");
            }

            map.put("rows", sjclList);
            map.put("total", ls.size());
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
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
    @DocumentInfo(
            sort = 60,
            name = "checkSysuserqd",
            desc = "校验APP用户是否符合签到条件",
            functiondesc = "校验APP用户是否符合签到条件 (一天签到一次)",
            author = "zjf",
            params = "userid ：用户id",
            returndesc = "{\"code\": 返回码,0代表可签到-1签到过\n" +
                    "    \"msg\": 返回信息,}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object checkSysuserqd(HttpServletRequest request, @Param("..") ZyDTO dto,
                                 @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            String mess = sjbService.checkSysuserqd(request, dto, pd);
            map.put("qddszid", mess);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * 查询组织机构树
     * querySysorgZTreeAsync的中文名称：按Ztree插件格式构造机构树
     * <p>
     * querySysorgZTreeAsync的概要说明：异步加载（传入父节点ID)
     *
     * @return
     * @throws Exception Written by : zjf
     */
    @DocumentInfo(
            sort = 6,
            name = "querySysorgZTreeAsync",
            desc = "按Ztree插件格式构造机构树",
            functiondesc = "异步加载（传入父节点ID)",
            author = "zjf",
            params = "orgid:传入的机构父节点ID ，必填",
            returndesc = "{\"orgData\":\"{\n" +
                    "\"childnum\":子类个数\n" +
                    "\"isParent\":true,\n" +
                    "\"open\":true,\n" +
                    "\"orgid\":机构id,\n" +
                    "\"orgname\":机构名称,\n" +
                    "\"shortname\":机构简称,\n" +
                    "\"orgdesc\":机构描述,\n" +
                    "\"address\":机构地址,\n" +
                    "\"parent\":父机构id\n" +
                    "\"principal\":机构负责人\n" +
                    "\"linkman\":联系人,\n" +
                    "\"tel\":电话,\n" +
                    "\"orgkin\":机构类别,1机构,2部门,\n" +
                    "\"orgcode\":机构代码(即机构的编号),\n" +
                    "\"orderno\":在同一级机构中的序号,\n" +
                    "\"fz\":分组\n" +
                    "}\"," +
                    "\"code\":\"0\"," +
                    "\"msg\":\"\"" +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object querySysorgZTreeAsync(HttpServletRequest request) {
        try {
            List sysorgList = (List) sysorgService.querySysorgZTreeAsync(request);
            Map m = new HashMap();
            m.put("rows", sysorgList);
            m.put("total", sysorgList.size());

            return SysmanageUtil.execAjaxResult(m, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(null, e);
        }
    }

    /**
     * 查询统筹区树
     * querySystcqZTreeAsync的中文名称：按Ztree插件格式构造统筹区树
     * <p>
     * querySystcqZTreeAsync的概要说明：异步加载（传入父节点ID）
     *
     * @return Written by : zy
     */
    @DocumentInfo(
            sort = 7,
            name = "querySystcqZTreeAsync",
            desc = "按Ztree插件格式构造机构树",
            functiondesc = "异步加载（传入父节点ID)",
            author = "zjf",
            params = "aaa027:传入的统筹父节点ID，必填",
            returndesc = "{\"orgData\":\"{\n" +
                    "\"childnum\":子类个数\n" +
                    "\"isParent\":true,\n" +
                    "\"open\":true,\n" +
                    "\"orgid\":机构id,\n" +
                    "\"orgname\":机构名称,\n" +
                    "\"shortname\":机构简称,\n" +
                    "\"orgdesc\":机构描述,\n" +
                    "\"address\":机构地址,\n" +
                    "\"parent\":父机构id\n" +
                    "\"principal\":机构负责人\n" +
                    "\"linkman\":联系人,\n" +
                    "\"tel\":电话,\n" +
                    "\"orgkin\":机构类别,1机构,2部门,\n" +
                    "\"orgcode\":机构代码(即机构的编号),\n" +
                    "\"orderno\":在同一级机构中的序号,\n" +
                    "\"fz\":分组\n" +
                    "}\"," +
                    "\"code\":\"0\"," +
                    "\"msg\":\"\"" +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object querySystcqZTreeAsync(HttpServletRequest request) {
        try {
            List aaa027List = (List) sysorgService.querySystcqZTreeAsync(request);
            Map m = new HashMap();
            m.put("rows", aaa027List);
            m.put("total", aaa027List.size());
            return SysmanageUtil.execAjaxResult(m, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(null, e);
        }
    }

    /**
     * getChineseSpell的中文名称：获得一个字符串的汉语拼音码
     * <p>
     * getChineseSpell的概要说明:
     *
     * @param request
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 8,
            name = "getChineseSpell",
            desc = "获得一个字符串的汉语拼音码",
            functiondesc = "获得一个字符串的汉语拼音码",
            author = "zjf",
            params = "zwname:要转换的汉字，必填",
            returndesc = "{\"pym\":\"汉字拼音字母\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getChineseSpell(HttpServletRequest request) {
        String zwname = request.getParameter("zwname");
        String pym = PinYinUtil.GetChineseSpell(zwname);
        Map rtnMap = new HashMap();
        rtnMap.put("pym", pym);

        return rtnMap;
    }

    /**
     * querySysuserdw的中文名称：查询APP用户定位记录
     * <p>
     * querySysuserdw的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    @DocumentInfo(
            sort = 59,
            name = "querySysuserdw",
            desc = "查询APP用户定位记录",
            functiondesc = "查询APP用户定位记录",
            author = "zjf",
            params = "\"userid\":用户id " +
                    "\"dwfs:定位方式 1\" " +
                    "\"startDate\"：开始时间 " +
                    "\"endDate\"：结束时间",
            returndesc = "{\"total\":返回总记录,\"code\":\"状态码\",\"msg\":\"\"," +
                    "rows\":[{\"code\": 返回码 " +
                    "\"msg\": 返回信息, " +
                    "rows{\n" +
                    "dwsj:登记时间 " +
                    "dwdd：签到地点 " +
                    "dwjdzb：经度 " +
                    "dwwdzb：纬度}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object querySysuserdw(HttpServletRequest request, @Param("..") ZyDTO dto,
                                 @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            String startDate = StringHelper.showNull2Empty(dto.getStartDate());
            String endDate = StringHelper.showNull2Empty(dto.getEndDate());
            if ("".equals(startDate) && "".equals(endDate)) {
                Timestamp startTime = SysmanageUtil.currentTime();
                String dwsj = DateUtil.convertDateToYearMonthDay(startTime);
                dto.setDwsj(dwsj);
            }
            map = sjbService.querySysuserdw(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * jpushInfo的中文名称：极光推送消息
     * <p>
     * jpushInfo的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @At
    @Ok("json")
    public Object jpushInfo(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto, @Param("..") PagesDTO pd) {
        return SysmanageUtil.execAjaxResult(sjbService.jpushInfo(request, dto));
    }

    /**
     * jpushInfo的中文名称：极光推送消息
     * <p>
     * jpushInfo的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @At
    @Ok("json")
    public Object jpushMinglingMsg(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto, @Param("..") PagesDTO pd) {
//        dto.setJpushmingling("yingjishipin");
//        dto.setJpushtitle("应急视频");
//        dto.setJpushcontent(dto.getEventcontent());
        try {
            return SysmanageUtil.execAjaxResult(sjbService.jpushMinglingMsg(request, dto));
        } catch (Exception e) {
            e.printStackTrace();
            return SysmanageUtil.execAjaxResult(e.getMessage());
        }
    }

    /**
     * yingjidiaodu 的中文应急调度名称：应急调度
     * yingjidiaodu 的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @At
    @Ok("json")
    public Object  yingjidiaodu(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto, @Param("..") PagesDTO pd) {
        return SysmanageUtil.execAjaxResult(sjbService.yingjidiaodu(request, dto));
    }

    /**
     * yingjidiaodu 的中文应急调度名称：应急调度
     * yingjidiaodu 的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @At
    @Ok("json")
    public Object  yingjidiaoduAll(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto, @Param("..") PagesDTO pd) {
        return SysmanageUtil.execAjaxResult(sjbService.yingjidiaoduAll(request, dto));
    }

    /**
     * yingjidiaodu 的中文应急调度名称：应急调度
     * yingjidiaodu 的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @At
    @Ok("json")
    public Object  yingjidiaoduHuifu(HttpServletRequest request, @Param("..") OanoticemanagerDTO dto, @Param("..") PagesDTO pd) {
        return SysmanageUtil.execAjaxResult(sjbService.yingjidiaoduHuifu(request, dto));
    }

    /**
     * sendPushMsgAll的中文名称：发给所有安装app应用的人(静默发送，app客户端收到后不会显示在通知栏)
     * <p>
     * sendPushMsgAll的概要说明：定位人员使用
     *
     * @param request
     * @return Written by : tmm
     */
    @DocumentInfo(
            sort = 58,
            name = "sendPushMsgAll",
            desc = "发给所有安装app应用的人(静默发送，app客户端收到后不会显示在通知栏)",
            functiondesc = "发给所有安装app应用的人(静默发送，app客户端收到后不会显示在通知栏) ",
            author = "tmm",
            params = " ",
            returndesc = "{ \"code\": 返回码 " +
                    " \"msg\": 返回信息" +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object sendPushMsgAll(HttpServletRequest request) {
        List list = new ArrayList();
        list.add("0");
        //给所有人发送内容(正式用)
        Boolean result = JPushAllUtil.androidAllSendMSgPush(null, JPushAllUtil.MSG_CONTENT);
        if (result) {
            return SysmanageUtil.execAjaxResult("");
        }
        return SysmanageUtil.execAjaxResult("定位人员失败");
    }

    /**
     * sendPushAlertAll的中文名称：发给所有安装app应用的人(通知，app客户端收到后会显示在通知栏)
     * <p>
     * sendPushAlertAll的概要说明：
     *
     * @param request
     * @return Written by : tmm
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object sendPushAlertAll(HttpServletRequest request, @Param("..") String alert, @Param("..") String title) {
        List list = new ArrayList();
        list.add("0");
        //给所有人发送通知(正式用)
        Boolean result = JPushAllUtil.androidAllSendAlertPush("0", alert, title);
        if (result) {
            return SysmanageUtil.execAjaxResult("");
        }
        return SysmanageUtil.execAjaxResult("发送通知失败！");
    }

    /**
     * zsdqtxIndex的中文名称：证审到期预警页面
     * <p>
     * zsdqtxIndex的概要说明：
     *
     * @param request Written by : zjf
     */
    @At
    @Ok("jsp:/jsp/jg/ncjtjc/zsdqtx")
    public void zsdqtxIndex(HttpServletRequest request) {
        // 页面初始化
    }

    /**
     * queryZsdqtx的中文名称：证审到期预警统计
     * <p>
     * queryZsdqtx的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryZsdqtx(HttpServletRequest request, @Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = sjbService.queryCsjkzdqtx(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryCsjkzdqtx的中文名称：健康证到期提醒
     * <p>
     * queryCsjkzdqtx的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryCsjkzdqtx(HttpServletRequest request, @Param("..") ZyDTO dto,
                                 @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = sjbService.queryCsjkzdqtx(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryAjdj的中文名称：查询案件详细信息
     * <p>
     * queryAjdj的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : zy
     */

    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryAjdjObj(HttpServletRequest request) {
        // 获取案件登记id
        String v_ajdjid = request.getParameter("ajdjid");
        String v_operatetype = request.getParameter("operatetype");
        String v_comid = request.getParameter("comid");
        Map map = new HashMap();
        try {
            ZfajdjDTO v_ZfajdjDTO = sjbService.queryAjdjObj(v_ajdjid,v_operatetype,v_comid);
            map.put("data", v_ZfajdjDTO);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * queryZfry：查询执法人员
     * <p>
     *
     *
     * @param request
     * @return
     * @throws Exception Written by : zy
     */

    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryZfry(HttpServletRequest request) {
        // 获取案件登记id
        String v_username = request.getParameter("username");
        String v_zfrylybm = request.getParameter("zfrylybm");
//        String v_comid = request.getParameter("comid");
        Map map = new HashMap();
        try {
            PagesDTO pd=new PagesDTO();
//            pd.setRows(10);
//            pd.setPage(1);
            PzfryDTO dto=new PzfryDTO();
            dto.setMobile(v_username);
            dto.setZfrylybm(v_zfrylybm);
            map = pzfryService.pzfry(dto,pd);
//            map.put("data", v_ZfajdjDTO);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * queryAjdjList的中文名称：查询案件列表信息
     * <p>
     * queryAjdjList的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : zy
     */
    @DocumentInfo(
            sort = 56,
            name = "queryAjdjList",
            desc = "查询案件列表信息",
            functiondesc = "查询案件列表信息",
            author = "zy",
            params = "ajdjid ：案件登记id",
            returndesc = "{\"rows\":{ " +
                    "ajdjid：案件登记id " +
                    "ajdjbh：案件登记编号 " +
                    "comdm：企业代码 " +
                    "commc：企业名称 " +
                    "comdz：企业地址 " +
                    "comfrhyz：企业法人 " +
                    "ajzt：案件状态 " +
                    "comfrsfzh：企业法人身份证号 " +
                    "comyddh：联系电话 " +
                    "comyzbm：邮政编码 " +
                    "ajdjafsj：案发时间 " +
                    "ajdjay：案由 " +
                    "ajdjajly：案件来源 " +
                    "ajdjjbqk案件基本情况 " +
                    "ajdjclyj：处理意见 " +
                    "ajdjczy：案件登记操作员姓名 " +
                    "ajdjczsj:案件登记操作时间 " +
                    "lianczy：立案操作员 " +
                    "liansj：立案时间 " +
                    "dcqzczy：调查取证操作员 " +
                    "dcqzsj：调查取证时间 " +
                    "cfjdcx：处罚决定程序1一般程序2听证程序3简易程序 " +
                    "cfjdczy：处罚决定操作员 " +
                    "cfjdsj：处罚决定时间 " +
                    "jagdczy：结案归档操作员 " +
                    "jagdsj：结案归档时间 " +
                    "AAA027：统筹区编码 " +
                    "ajdjsfgx：案件登记是否归本部门管辖1是0否 " +
                    "ajjsbz：案件结束标志0否1是 " +
                    "aae140：案件登记案件大类 " +
                    "ajdjajbhnf：案件编号年份 " +
                    "ajdjajbhxh：编号序号  " +
                    "comzzzm：资质证明 " +
                    "comzzzmbh：资质证明编号 " +
                    "comzzjgdm：组织机构代码 " +
                    "comfrxb：企业法人性别 " +
                    "comfrzw：企业法人职务 " +
                    "comfrnl：企业法人年龄 " +
                    "slbz：受理标志 " +
                    "slczy：受理操作员 " +
                    "slsj：受理时间 " +
                    "zxxmcsbm：征信项目参数编码 " +
                    "wfxwbh：违法行为编号 " +
                    "ajdjwfss:违法事实 " +
                    "orgid:机构ID }, \"code\": 返回码, " +
                    " \"msg\": 返回信息 }",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryAjdjList(HttpServletRequest request, @Param("..") ZfajdjDTO dto,
                                @Param("..") PagesDTO pd) {
        // 查询案件登记列表信息
        Map map = new HashMap();
        try {
            map = sjbService.queryAjdjList(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * saveAjdj的中文名称：案件登记接口
     * <p>
     * saveAjdj的概要说明：
     *
     * @param request
     * @return Written by : zy
     * @throws IOException
     */
    @DocumentInfo(
            sort = 55,
            name = "saveAjdj",
            desc = "案件登记接口",
            functiondesc = "案件登记接口",
            author = "zy",
            params = "\"userid\":用户id " +
                    "\"ajdjbh\":案件登记编号 " +
                    "\"comdm\":企业编号 " +
                    "\"commc\":企业名称 " +
                    "\"comdz\":企业地址 " +
                    "\"comfrhyz\":企业法人 " +
                    "\"comfrsfzh\":企业法人身份证号 " +
                    "\"comyddh\":联系电话 " +
                    "\"comyzbm\":邮政编码 " +
                    "\"ajdjafsj\":案发时间 " +
                    "\"ajdjay\":案由 " +
                    "\"aae140\":案件大类 " +
                    "\"wfxwbh\":案由编号 " +
                    "\"ajdjajly\":案件来源 " +
                    "\"ajdjjbqk\":案件基本情况",
            returndesc = "{" +
                    " \"code\": 返回码, " +
                    " \"msg\": 返回信息 " +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object saveAjdj(HttpServletRequest request) {
        Map map = new HashMap();
        try {
            // 获取内容长度
            int len = request.getContentLength();
            byte[] buffer = new byte[len];
            // 获取输入流
            ServletInputStream in = request.getInputStream();
            int total = 0;
            for (int once = 0; total < len && once >= 0; total += once) {
                once = in.readLine(buffer, total, len);
            }
            // 编码
            String data = new String(buffer, "utf-8");
            // 将json字符串转换问json对象
            JSONObject jsonObj = JSONObject.fromObject(data);
            // 将json对象转换为对象类
            ZfajdjDTO dto = (ZfajdjDTO) JSONObject.toBean(jsonObj, ZfajdjDTO.class);

            String asbjid = sjbService.saveAjdj(request, dto);
            map.put("ajdjid", asbjid);
            // 调用方法对内容进行保存
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }

    }

    /**
     * queryAjdjlyList的中文名称：查询案件来由
     * <p>
     * queryAjdjlyList的概要说明：
     *
     * @param request wfxwms wfxwbh
     * @return
     * @throws Exception Written by : zy
     */
    @DocumentInfo(
            sort = 54,
            name = "queryAjdjlyList",
            desc = "查询案件来由",
            functiondesc = "查询案件来由",
            author = "zy",
            params = " ",
            returndesc = "{\"total\":总记录数， " +
                    "  \"rows\":[ \"pwfxwcsid\":违法行为参数id, " +
                    "  \"wfxwbh\":,违法行为编号 " +
                    "  \"wfxwbz\":违法行为备注 , " +
                    "  \"wfxwcffgtk\": 条款, " +
                    "  \"wfxwcffgtknr\":处罚法规条款内容, " +
                    "  \"wfxwms\": 处罚内容, " +
                    "  \"wfxwwffg\":  违反法规 " +
                    " \"wfxwwftk\":违反条款, " +
                    " \"wfxwwftknr\": 违反条款内容,  } ... ] }",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryAjdjlyList(HttpServletRequest request, @Param("..") PwfxwcsDTO dto,
                                  @Param("..") PagesDTO pd) {
        // 查询案件登记列表信息
        Map map = new HashMap();
        try {
            map = pubService.querySelectay(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * querylvlgList的中文名称：查询法律信息
     * <p>
     * querylvlgList的概要说明：
     *
     * @param request wfxwms wfxwbh
     * @return
     * @throws Exception Written by : tmm
     */
    @DocumentInfo(
            sort = 53,
            name = "querylvlgList",
            desc = "查询法律信息",
            functiondesc = "查询法律信息",
            author = "tmm",
            params = "age ：分页 " +
                    " wfxwms：违法行为描述",
            returndesc = "{ \"total\":总记录数， " +
                    " \"rows\" :[ { \"pwfxwcsid\":违法行为参数id, " +
                    " \"wfxwbh\":,违法行为编号 " +
                    " \"wfxwbz\":违法行为备注 , " +
                    " \"wfxwcffgtk\": 条款, " +
                    " \"wfxwcffgtknr\":处罚法规条款内容, " +
                    " \"wfxwms\": 处罚内容, " +
                    " \"wfxwwffg\":  违反法规" +
                    " \"wfxwwftk\":违反条款, " +
                    " \"wfxwwftknr\": 违反条款内容  } ... ]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object querylvlgList(HttpServletRequest request, @Param("..") PwfxwcsDTO dto,
                                @Param("..") PagesDTO pd) {
        // 查询法律信息列表信息
        Map map = new HashMap();
        int num = pd.getPage() != 0 ? 10 : 0;
        pd.setRows(num);//每页个数
        try {
            map = sjbService.queryWfxw(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }


    /**
     * getAjdjlyDTO的中文名称：查询法律信息
     * <p>
     * getAjdjlyDTO的概要说明：
     *
     * @param request wfxwms wfxwbh
     * @return
     * @throws Exception Written by : tmm
     */
    @DocumentInfo(
            sort = 52,
            name = "getAjdjlyDTO",
            desc = "查询法律信息",
            functiondesc = "查询法律信息",
            author = "tmm",
            params = "page ：分页 " +
                    " wfxwms：违法行为描述",
            returndesc = "{\"total\":总记录数" +
                    "\"rows\":[  ajdjajdl：案件登记大类 " +
                    " \"pwfxwcsid\":违法行为参数id, " +
                    " \"wfxwbh\":,违法行为编号 " +
                    " \"wfxwbz\":违法行为备注 , " +
                    " \"wfxwcffgtk\": 条款, " +
                    " \"wfxwcffgtknr\":处罚法规条款内容, " +
                    " \"wfxwms\": 处罚内容, " +
                    " \"wfxwwffg\":  违反法规 " +
                    " \"wfxwwftk\":违反条款, " +
                    " \"wfxwwftknr\": 违反条款内容 }, " +
                    "... ]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getAjdjlyDTO(HttpServletRequest request, @Param("..") PwfxwcsDTO dto,
                               @Param("..") PagesDTO pd) {
        // 查询案件登记列表信息
        Map map = new HashMap();
        try {
            map = sjbService.queryWfxw(dto, pd);
            List ls = (List) map.get("rows");
            PwfxwcsDTO pwfxwcsDTO = null;
            if (ls != null && ls.size() > 0) {
                pwfxwcsDTO = (PwfxwcsDTO) ls.get(0);
            }
            map.put("data", pwfxwcsDTO);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * saveCompany的中文名称：添加企业基本信息 完成的是注册功能
     * <p>
     * saveCompany的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : tmm
     * @throws Exception
     */
    @DocumentInfo(
            sort = 51,
            name = "queryCompanyListForAjdj",
            desc = "案件登记企业列表",
            functiondesc = "案件登记企业列表",
            author = "tmm",
            params = " userid :用户id " +
                    "commc：公司名 " +
                    "comid：企业id " +
                    "orgid：组织机构id " +
                    "comdalei：企业大类 " +
                    "aaa027：统筹区 " +
                    "comdz：企业地址 " +
                    "comjdzb：经度 " +
                    "comwdzb：纬度 " +
                    "comfrhyz：企业法人 " +
                    "comfrsfzh：法人身份证号 " +
                    "comfzr：企业负责人 " +
                    "comgdd：固定电话 " +
                    "comyddh：移动电话 " +
                    "comctmj：餐厅面积 " +
                    "comcfmj：厨房面积 " +
                    "comzmj：总面积 " +
                    "comjcrs：就餐人数 " +
                    "comcyrs：就业人数 " +
                    "comcjkzrs：持健康证人数 " +
                    "comzjzglrs：专兼职管理人员 " +
                    "comxiaolei：小类 " +
                    "comzzjgdm：组织机构代码 ",
            returndesc = "{ " +
                    "\"code\": 返回码, " +
                    "\"msg\": 返回信息, " +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object saveCompany(HttpServletRequest request, @Param("..") PcompanyDTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
//			pcompanyService.savePcompany(request, dto);
//			String qyid = dto.getComid();
//			if (qyid != null) {
//				result.put("qyid", qyid);
            dto.setSjordnbz("2");//gu20161020add
            pcompanyService.savePcompany(request, dto);
            if (dto.getComid() != null && !"".equals(dto.getComid())) {
                result.put("qyid", dto.getComid());
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }


    /**
     *
     * queryCompanyList的中文名称：查询企业列表
     *
     * queryCompanyList的概要说明：
     *
     * @param request
     * @return
     * @throws Exception
     *             Written by : tmm
     */
    @DocumentInfo(
            sort = 50,
            name="queryCompanyList",
            desc = "查询企业列表",
            functiondesc = "查询企业列表",
            author = "tmm",
            params = "userid: 登录用户ID\n" +
                    "aaz093：企业类型主键\n" +
                    "Page:分页 "  ,
            returndesc = "{“total”:总记录数，" +
                    "\"rows\":[" +
                    "{ \"comid\":企业id," +
                    "\"comzzzmbh\": 资质证明编号," +
                    " \"comzzjgdm\": 组织机构代码," +
                    "\"comdm\": 企业代码," +
                    "\"commc\": 企业名称," +
                    "\"comfrhyz\": 企业法人/业主," +
                    "\"comfrsfzh\":  企业法人/业主身份证号," +
                    "\"comdz\":企业地址," +
                    "\"comyddh\": 移动电话," +
                    "\"aaa027\": 地区编码," +
                    "\"comzzzm\": 资质证明" +
                    "\"itemid\"：企业类型ID" +
                    "\"comdalei\"：企业大类" +
                    "\"aaz093\"：企业大类主键" +
                    "\"comyzbm\"：企业邮政编码" +
                    "\"resultcount\"：企业检查次数" +
                    "\"plantresult\"：计划类别" +
                    "}, " +
                    "... " +
                    "]}",
            date="2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({ "rawtypes" })
    public Object queryCompanyList(HttpServletRequest request, @Param("..") PcompanyDTO dto,
                                   @Param("..")PagesDTO pd) {
        // 查询企业信息
        Map map = new HashMap();
        try {
            int v_page=pd.getPage()==0?1:pd.getPage();
            pd.setPage(v_page);
            int num = pd.getRows()==0?50:pd.getRows();
            pd.setRows(num);//每页个数
            map = sjbService.queryCompanyList(request, dto,pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }


    /**
     * queryLawdocList的中文名称：查询执法文书列表
     * <p>
     * queryLawdocList：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})

    public Object queryLawdocList(HttpServletRequest request, @Param("..") PfjcsDTO dto,
                                  @Param("..") PagesDTO pd) {
        // 查询企业信息
        Map map = new HashMap();
        try {
            int num = pd.getPageSize() != 0 ? pd.getPageSize() : 10;

            pd.setRows(num);//每页个数
            map = sjbService.queryLawdocList_MobileIndex(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }
    @At
    @Ok("json")
    public Object delZfws(HttpServletRequest request,
                          @Param("..") ZfajzfwsDTO dto) {
        Map map=new HashMap();
        try{
            String id=wsgldyService.delZfws_MOBILEZFWS(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }
    /**
     * queryCompanyListForAjdj的中文名称：案件登记企业列表
     * <p>
     * queryCompanyListForAjdj的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @DocumentInfo(
            sort = 49,
            name = "queryCompanyListForAjdj",
            desc = "案件登记企业列表",
            functiondesc = "案件登记企业列表",
            author = "tmm",
            params = "aaa027: 统筹区编号 " +
                    "Page:分页 " +
                    "commc：企业名称 ",
            returndesc = "{“total”:总记录数， " +
                    "\"rows\":[{\"comid\":企业id, " +
                    "  \"comzzzmbh\": 资质证明编号, " +
                    "  \"comzzjgdm\": 组织机构代码, " +
                    "  \"comdm\": 企业代码, " +
                    "  \"commc\": 企业名称, " +
                    "  \"comfrhyz\": 企业法人/业主, " +
                    "  \"comfrsfzh\":  企业法人/业主身份证号, " +
                    "  \"comdz\":企业地址, " +
                    "  \"comyddh\": 移动电话, " +
                    "  \"aaa027\": 地区编码, " +
                    "  \"comzzzm\": 资质证明 " +
                    "  \"itemid\"：企业类型ID " +
                    " \"comdalei\"：企业大类 " +
                    " \"aaz093\"：企业大类主键 " +
                    " \"comyzbm\"：企业邮政编码 " +
                    " \"resultcount\"：企业检查次数 " +
                    " \"plantresult\"：计划类别 }  " +
                    "... " +
                    "] }",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryCompanyListForAjdj(HttpServletRequest request, @Param("..") PcompanyDTO dto,
                                          @Param("..") PagesDTO pd) {
        // 查询企业信息
        Map map = new HashMap();
        try {
            // 通用处理统筹区编码(手机端接口使用本方法时必须传人aaa027,且aaa027不能为空。)
            String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
            dto.setAaa027(aaa027);
            int num = pd.getPage() != 0 ? 10 : 0;
            pd.setRows(num);//每页个数
            map = sjbService.queryCompanyListForAjdj(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * getJcsbPlansByqyType的中文名称：根据企业类别获取相关的计划列表（查询结果）和企业id
     * <p>
     * getJcsbPlansByqyType的概要说明：获取计划列表和结果状态（聚餐申报（适用大类与检查itemid 多对一））
     *
     * @param dto
     * @return Written by : tmm
     * @throws Exception
     */
    @DocumentInfo(
            sort = 49,
            name = "getJcsbPlansByqyType",
            desc = "根据企业类别获取相关的计划列表（查询结果）和企业id",
            functiondesc = "获取计划列表和结果状态（聚餐申报（适用大类与检查itemid 多对一））",
            author = "tmm",
            params = "itemid: 检查项目id " +
                    "comid:企业id,必填 ",
            returndesc = "{\"total\":总记录数， " +
                    "\"rows\":[  \"total\": 总记录数," +
                    "\"code\": 返回码," +
                    "\"msg\": 返回信息," +
                    "“rows”:[{ \"planid\": 计划id," +
                    " \"plancode\": 计划编号," +
                    " \"plantitle\": 计划标题," +
                    " \"planchecktype\": 检查类型," +
                    " \"plantype\": 计划类型," +
                    " \"planstdate\":计划开始时间," +
                    " \"planeddate\":计划结束时间," +
                    " \"plancontent\": 计划内容," +
                    " \"planremark\": 计划备注," +
                    " \"planoperatedate\": 计划经办日期," +
                    " \"planoperator\": 计划操作员ID," +
                    "“resultstate”:检查状态（0初始化，1已完成，2已固化） ] }",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object getJcsbPlansByqyType(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
        Map map = new HashMap();
        try {
            map = sjbService.queryJscbPlansByqyType(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryCompany的中文名称：查询所有企业信息
     * <p>
     * queryCompany的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryCompany(HttpServletRequest request, @Param("..") PcompanyDTO dto,
                               @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
        dto.setAaa027(aaa027);
        try {
            map = sjbService.queryCompany(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryNews的中文名称：查询所有新闻信息
     * <p>
     * queryNews的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zk
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryNews(HttpServletRequest request, @Param("..") NewsDTO dto,
                            @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            /*int num = pd.getPage()!=0?10:0;
			pd.setRows(num);*/
            map = sjbService.getNewsList(request, dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryCompanyListBycommc的中文名称：查询企业列表通过企业名称和用户id（commc和userid）
     * <p>
     * queryCompanyListBycommc的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @DocumentInfo(
            sort = 48,
            name = "queryCompanyListBycommc",
            desc = "查询企业列表通过企业名称和用户id（commc和userid）",
            functiondesc = "查询企业列表通过企业名称和用户id（commc和userid）",
            author = "tmm",
            params = "userid：用户id" +
                    "commc：企业名称" +
                    "aaa027：统筹区编码 ，必填 ",
            returndesc = "{“total”:总记录数， " +
                    "“rows”:[  \"comid\":企业id, " +
                    " \"comzzzmbh\": 资质证明编号, " +
                    " \"comzzjgdm\": 组织机构代码, " +
                    " \"comdm\": 企业代码, " +
                    " \"commc\": 企业名称, " +
                    " \"comfrhyz\": 企业法人/业主, " +
                    " \"comfrsfzh\":  企业法人/业主身份证号, " +
                    " \"comyddh\": 移动电话, " +
                    " \"aaa027\": 地区编码, " +
                    " \"comzzzm\": 资质证明 " +
                    " \"itemid\"：企业类型ID " +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryCompanyListBycommc(HttpServletRequest request, @Param("..") PcompanyDTO dto,
                                          @Param("..") PagesDTO pd) {
        // 查询企业信息
        Map map = new HashMap();
//		Map mapxkz = new HashMap();

        String aaa027 = SysmanageUtil.getSysuserAaa027(dto.getAaa027());
        dto.setAaa027(aaa027);
        if ("null".equalsIgnoreCase(dto.getUserid()) || StringUtils.isEmpty(dto.getUserid())) {
            Map result = new HashMap();
            result.put("code", "9999");
            result.put("msg", "操作失败");
            result.put("success", false);
            result.put("msg", "用户ID[userid]不能为空");
            return result;
        }
        try {
            int num = pd.getPage() != 0 ? 10 : 0;
            pd.setRows(num);//每页个数
            //gu20170919改为从pcompanry查  map = sjbService.queryCompanyListBycommc(request, dto,pd);
            map = pcompanyService.queryCompany(request, dto, pd);

            //gu20161021 add 查询单位许可证信息
//			PcompanyXkzDTO v_xkzdto=new PcompanyXkzDTO();
//			v_xkzdto.setComid(dto.getComid());
//			mapxkz=pcompanyService.queryPcompanyXkz(v_xkzdto,pd);
//			System.out.println("mapxkz "+mapxkz.get("rows"));
//			map.put("xkzdata", mapxkz.get("rows"));

            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * queryCompanyDTO的中文名称：查询企业DTO
     * <p>
     * queryCompanyDTO的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    @DocumentInfo(
            sort = 47,
            name = "queryCompanyDTO",
            desc = "查询企业DTO",
            functiondesc = "查询企业DTO",
            author = "zjf",
            params = "aaa027:统筹区编码，必填/" +
                    "comid:企业id，必填/" +
                    "userid:用户id，必填/" +
                    "comdalei：企业大类， /" +
                    "commc：企业名称，/" +
                    "comshbz：企业审核标准，/" +
                    "comjyjcbz：检验检测标准，/" +
                    "comfwnfww ：范围内外企业，/",
            returndesc = "{ “total”:总记录数，\n" +
                    "“rows”:[\"comid\":企业id,\n" +
                    "\"comzzzmbh\": 资质证明编号,\n" +
                    "\"comzzjgdm\": 组织机构代码,\n" +
                    "\"comdm\": 企业代码,\n" +
                    "\"commc\": 企业名称,\n" +
                    "\"comfrhyz\": 企业法人/业主,\n" +
                    "\"comfrsfzh\":  企业法人/业主身份证号,\n" +
                    "\"comyddh\": 移动电话,\n" +
                    "\"aaa027\": 地区编码,\n" +
                    "\"comzzzm\": 资质证明\n" +
                    "\"itemid\"：企业类型ID\n" +
                    "orgid：组织机构id\n" +
                    "comdalei：企业大类\n" +
                    "aaa027：统筹区\n" +
                    "comdz：企业地址\n" +
                    "comjdzb：经度\n" +
                    "comwdzb：纬度\n" +
                    "comfrhyz：企业法人\n" +
                    "comfrsfzh：法人身份证号\n" +
                    "comfzr：企业负责人\n" +
                    "comgdd：固定电话\n" +
                    "comyddh：移动电话\n" +
                    "comctmj：餐厅面积\n" +
                    "comcfmj：厨房面积\n" +
                    "comzmj：总面积\n" +
                    "comjcrs：就餐人数\n" +
                    "comcyrs：就业人数\n" +
                    "comcjkzrs：持健康证人数\n" +
                    "comzjzglrs：专兼职管理人员\n" +
                    "comxiaolei：小类\n" +
                    "comzzjgdm：组织机构代码},]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryCompanyDTO(HttpServletRequest request, @Param("..") PcompanyDTO dto,
                                  @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        Map mapxkz = new HashMap();
        try {
            map = pcompanyService.queryCompany(request, dto, pd);
            List list = (List) map.get("rows");
            PcompanyDTO pcDto = null;
            if (list != null && list.size() > 0) {
                pcDto = (PcompanyDTO) list.get(0);
            }
            map.put("data", pcDto);

            //gu20161021 add 查询单位许可证信息
            PcompanyXkzDTO v_xkzdto = new PcompanyXkzDTO();
            v_xkzdto.setComid(dto.getComid());
            mapxkz = pcompanyService.queryPcompanyXkz(v_xkzdto, pd);
            System.out.println("mapxkz " + mapxkz.get("rows"));
            map.put("xkzdata", mapxkz.get("rows"));

            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryCs的中文名称：查询厨师
     * <p>
     * queryCs的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    @DocumentInfo(
            sort = 46,
            name = "queryCs",
            desc = "查询厨师",
            functiondesc = "查询厨师",
            author = "zjf",
            params = "csid：厨师id" +
                    "csbh：厨师编号" +
                    "csxm：厨师姓名" +
                    "cssfzjhm：厨师身份证号" +
                    "jcsbid：聚餐申报id" +
                    "aaa027：统筹区编码 ，必填 ",
            returndesc = "{\"total\":1,\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"csid\":\"厨师id --- 2016072515371245242033812\"," +
                    "\"csbh\":\"厨师编号 --- CS20160725271\"," +
                    "\"csxm\":\"厨师姓名 -- 李亚军\"," +
                    "\"cspym\":\"厨师姓名拼音 -- LYJ\"," +
                    "\"csxb\":\"厨师性别 --  1\"," +
                    "\"cscsrq\":\"厨师出生日期  ---  19881218\"," +
                    "\"cssfzjlx\":\"厨师身份证件类型 -- 1\"," +
                    "\"cssfzjlxstr\":\"厨师身份证件类型名称 ---  居民身份证（户口簿）\"," +
                    "\"cssfzjhm\":\"厨师身份证件号码  --  411122198812183517\"," +
                    "\"cssjh\":\"厨师手机号 --  13683653009\"," +
                    "\"cswhcd\":\"\"," +
                    "\"cscynx\":\"\"," +
                    "\"csjkzm\":\"\"," +
                    "\"csjkzyxq\":\"\"," +
                    "\"csjktjdd\":\"\"," +
                    "\"cspxqk\":\"\"," +
                    "\"cspxhgzyxq\":\"\"," +
                    "\"csjtzz\":\"汤阴县任固镇\"," +
                    "\"csyx\":\"\"," +
                    "\"csqq\":\"\"," +
                    "\"cswx\":\"\"," +
                    "\"csfwqy\":\"厨师服务区域\"," +
                    "\"aaa027\":\"统筹区编码 --  410523102000\"," +
                    "\"aaa027name\":\"统筹区名称 --  任固镇\"," +
                    "\"orgid\":\"机构id ---  2016060617473623689299856\"," +
                    "\"orgname\":\"机构名称  --  汤阴县食药局任固所\"," +
                    "\"aae036\":\"操作日期 -- 2016-07-25 15:37:12\"," +
                    "\"aae013\":\"备注\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryCs(HttpServletRequest request, @Param("..") CsDTO dto,
                          @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryChefList(request, dto, pd);
    }

    /**
     * queryCsDTO的中文名称：查询厨师DTO
     * <p>
     * queryCsDTO的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    @DocumentInfo(
            sort = 45,
            name = "queryCsDTO",
            desc = "查询厨师DTO",
            functiondesc = "查询厨师DTO",
            author = "zjf",
            params = "csid：厨师id" +
                    "csbh：厨师编号" +
                    "csxm：厨师姓名" +
                    "cssfzjhm：厨师身份证号" +
                    "jcsbid：聚餐id" +
                    "aaa027：统筹区编码 ，必填 ",
            returndesc = "{\"total\":返回记录总数  ,\"" +
                    "data\":{\"csid\":\"厨师id --- 2016072515371245242033812\"," +
                    "\"csbh\":\"厨师编号 --- CS20160725271\"," +
                    "\"csxm\":\"厨师姓名 -- 李亚军\"," +
                    "\"cspym\":\"厨师姓名拼音 -- LYJ\"," +
                    "\"csxb\":\"厨师性别 --  1\"," +
                    "\"cscsrq\":\"厨师出生日期  ---  19881218\"," +
                    "\"cssfzjlx\":\"厨师身份证件类型 -- 1\"," +
                    "\"cssfzjlxstr\":\"厨师身份证件类型名称 ---  居民身份证（户口簿）\"," +
                    "\"cssfzjhm\":\"厨师身份证件号码  --  411122198812183517\"," +
                    "\"cssjh\":\"厨师手机号 --  13683653009\"," +
                    "\"cswhcd\":\"\"," +
                    "\"cscynx\":\"\"," +
                    "\"csjkzm\":\"\"," +
                    "\"csjkzyxq\":\"\"," +
                    "\"csjktjdd\":\"\"," +
                    "\"cspxqk\":\"\"," +
                    "\"cspxhgzyxq\":\"\"," +
                    "\"csjtzz\":\"汤阴县任固镇\"," +
                    "\"csyx\":\"\"," +
                    "\"csqq\":\"\"," +
                    "\"cswx\":\"\"," +
                    "\"csfwqy\":\"厨师服务区域\"," +
                    "\"aaa027\":\"统筹区编码 --  410523102000\"," +
                    "\"aaa027name\":\"统筹区名称 --  任固镇\"," +
                    "\"orgid\":\"机构id ---  2016060617473623689299856\"," +
                    "\"orgname\":\"机构名称  --  汤阴县食药局任固所\"," +
                    "\"aae036\":\"操作日期 -- 2016-07-25 15:37:12\"," +
                    "\"aae013\":\"备注\"}," +
                    "\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"csid\":\"厨师id --- 2016072515371245242033812\"," +
                    "\"csbh\":\"厨师编号 --- CS20160725271\"," +
                    "\"csxm\":\"厨师姓名 -- 李亚军\"," +
                    "\"cspym\":\"厨师姓名拼音 -- LYJ\"," +
                    "\"csxb\":\"厨师性别 --  1\"," +
                    "\"cscsrq\":\"厨师出生日期  ---  19881218\"," +
                    "\"cssfzjlx\":\"厨师身份证件类型 -- 1\"," +
                    "\"cssfzjlxstr\":\"厨师身份证件类型名称 ---  居民身份证（户口簿）\"," +
                    "\"cssfzjhm\":\"厨师身份证件号码  --  411122198812183517\"," +
                    "\"cssjh\":\"厨师手机号 --  13683653009\"," +
                    "\"cswhcd\":\"\"," +
                    "\"cscynx\":\"\"," +
                    "\"csjkzm\":\"\"," +
                    "\"csjkzyxq\":\"\"," +
                    "\"csjktjdd\":\"\"," +
                    "\"cspxqk\":\"\"," +
                    "\"cspxhgzyxq\":\"\"," +
                    "\"csjtzz\":\"汤阴县任固镇\"," +
                    "\"csyx\":\"\"," +
                    "\"csqq\":\"\"," +
                    "\"cswx\":\"\"," +
                    "\"csfwqy\":\"厨师服务区域\"," +
                    "\"aaa027\":\"统筹区编码 --  410523102000\"," +
                    "\"aaa027name\":\"统筹区名称 --  任固镇\"," +
                    "\"orgid\":\"机构id ---  2016060617473623689299856\"," +
                    "\"orgname\":\"机构名称  --  汤阴县食药局任固所\"," +
                    "\"aae036\":\"操作日期 -- 2016-07-25 15:37:12\"," +
                    "\"aae013\":\"备注\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryCsDTO(HttpServletRequest request, @Param("..") CsDTO dto,
                             @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryChefDto(request, dto, pd);
    }

    /**
     * queryJcsb的中文名称：查询聚餐申报
     * <p>
     * queryJcsb的概要说明：传入 aaa027
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    @DocumentInfo(
            sort = 44,
            name = "queryJcsb",
            desc = "查询聚餐申报",
            functiondesc = "查询聚餐申报",
            author = "zjf",
            params = "jcsbid：聚餐申报id" +
                    "jcsbbh：聚餐申报编号" +
                    "jcsbjbrxm：举办人姓名" +
                    "jcsbjbrsjh：举办人手机号" +
                    "jcsbjcgm：聚餐规模" +
                    "aaa027：统筹区编码 ，必填 ",
            returndesc = "{\"total\":1,\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"aab301\":\"行政区划名称 -- 商丘市虞城县利民镇谢庄村\"," +
                    "\"aaa027\":\"统筹区编码 -- 410523100200\"," +
                    "\"aaa027name\":\"统筹区名称  --- 石家庄村\"," +
                    "\"orgid\":\"机构id --- 411425107000\"," +
                    "\"aae011\":\"操作员 --- admin\"," +
                    "\"aae036\":\"操作时间 --- 2016-01-06 16:08:07\"," +
                    "\"aae013\":\"备注 ---  聚餐申报测试1111\"," +
                    "\"jcsbid\":\"聚餐申报id  ---- 1\"," +
                    "\"jcsbbh\":\"聚餐申报编号 --  JCSB20160106223\"," +
                    "\"jcsbjbrxm\":\"举办人姓名 --- 王飞\"," +
                    "\"jcsbjbrsjh\":\"举办人手机号 --  13345678900\"," +
                    "\"jcsbjclx\":\"聚餐类型  --- 1\"," +
                    "\"jcsbjclxstr\":\"聚餐类型名称 ---  婚宴\"," +
                    "\"jcsbjdzb\":\"聚餐经度坐标 --  115.932779\"," +
                    "\"jcsbwdzb\":\"聚餐纬度坐标 --- 34.479443\"," +
                    "\"jcsbjcsj1\":\"聚餐时间1 --  2016-06-20\"," +
                    "\"jcsbjccc1\":\"聚餐餐次编号  --  2\"," +
                    "\"jcsbjccc1str\":\"聚餐餐次1名称 ---  中餐\"," +
                    "\"jcsbjccc2str\":\"聚餐餐次2名称  --  晚餐\"," +
                    "\"jcsbjccc3str\":\"聚餐餐次2名称  --  中餐\"," +
                    "\"jcsbjcsj2\":\"聚餐时间2 -- 2016-06-20\"," +
                    "\"jcsbjccc2\":\"聚餐餐次编号2  ---  3\"," +
                    "\"jcsbjcsj3\":\"聚餐时间3 --  2016-06-21\"," +
                    "\"jcsbjccc3\":\"聚餐餐次编号3  ---  2\"," +
                    "\"jcsbjcrs\":\"聚餐人数 --  350\"," +
                    "\"jcsbylly\":\"聚餐材料来源 --- 1\"," +
                    "\"jcsbyllystr\":\"材料来源名称 ---  自备\"," +
                    "\"jcsbcsly\":\"厨师来源 --  1\"," +
                    "\"jcsbcslystr\":\"厨师来源名称  ---  家庭成员\"," +
                    "\"jcsbcyjly\":\"聚餐申报餐具来源编码 --- 2\"," +
                    "\"jcsbcyjlystr\":\"聚餐申报餐具来源名称 --- 一次性\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryJcsb(HttpServletRequest request, @Param("..") ZyDTO dto,
                            @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryJcsbList(request, dto, pd);
    }

    /**
     * addCs的中文名称：新增厨师
     * <p>
     * addCs的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 44,
            name = "addCs",
            desc = "新增厨师",
            functiondesc = "新增厨师",
            author = "zjf",
            params = " csid：厨师id ，必填 /" +
                    "csbh：厨师编号" +
                    "csxm：厨师姓名" +
                    "cspym：厨师姓名拼音" +
                    "csxb：厨师性别" +
                    "cscsrq：厨师出生日期" +
                    "cssfzjlx：厨师证件类型" +
                    "cssfzjhm：厨师身份证件号码" +
                    "cswhcd：厨师文化程度" +
                    "cscynx：厨师从业年限" +
                    "csjkzm：厨师健康证明" +
                    "csjkzyxq：厨师健康证有效期" +
                    "csjktjdd：厨师健康体检地点" +
                    "cspxqk：厨师培训情况" +
                    "cspxhgzyxq：厨师培训合格证有效期" +
                    "csjtzz：厨师家庭地址" +
                    "cshkszd：厨师户口所在地" +
                    "csyx：厨师邮箱" +
                    "csqq：厨师qq" +
                    "cswx：厨师微信" +
                    "cssflx：厨师身份类型" +
                    "csfwdbh：厨师服务队编号" +
                    "csfwqy：厨师服务区域" +
                    "comshengdm：省份代码值" +
                    "comshengmc：省份名称" +
                    "comshidm：市代码值" +
                    "comshimc：市名称" +
                    "comxiandm：县代码" +
                    "comxianmc：县名称" +
                    "comxiangdm：乡镇代码" +
                    "comxiangmc：乡镇名称" +
                    "comcundm：社区/行政村代码" +
                    "comcunmc：社区/行政村名称" +
                    "aab301：行政区划编码" +
                    "aaa027：统筹区编码" +
                    "orgid：所属机构id" +
                    "aae013：备注",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object addCs(HttpServletRequest request, @Param("..") CsDTO dto) {
        return ncjtjcApiModule.addChef(request, dto);
    }

    /**
     * updateCs的中文名称：修改厨师
     * <p>
     * updateCs的概要说明：
     *
     * @param dto
     * @return Written by : zy
     */
    @DocumentInfo(
            sort = 43,
            name = "updateCs",
            desc = "修改厨师",
            functiondesc = "修改厨师",
            author = "zy",
            params = " csid：厨师id ，必填 /" +
                    "csbh：厨师编号" +
                    "csxm：厨师姓名" +
                    "cspym：厨师姓名拼音" +
                    "csxb：厨师性别" +
                    "cscsrq：厨师出生日期" +
                    "cssfzjlx：厨师证件类型" +
                    "cssfzjhm：厨师身份证件号码" +
                    "cswhcd：厨师文化程度" +
                    "cscynx：厨师从业年限" +
                    "csjkzm：厨师健康证明" +
                    "csjkzyxq：厨师健康证有效期" +
                    "csjktjdd：厨师健康体检地点" +
                    "cspxqk：厨师培训情况" +
                    "cspxhgzyxq：厨师培训合格证有效期" +
                    "csjtzz：厨师家庭地址" +
                    "cshkszd：厨师户口所在地" +
                    "csyx：厨师邮箱" +
                    "csqq：厨师qq" +
                    "cswx：厨师微信" +
                    "cssflx：厨师身份类型" +
                    "csfwdbh：厨师服务队编号" +
                    "csfwqy：厨师服务区域" +
                    "comshengdm：省份代码值" +
                    "comshengmc：省份名称" +
                    "comshidm：市代码值" +
                    "comshimc：市名称" +
                    "comxiandm：县代码" +
                    "comxianmc：县名称" +
                    "comxiangdm：乡镇代码" +
                    "comxiangmc：乡镇名称" +
                    "comcundm：社区/行政村代码" +
                    "comcunmc：社区/行政村名称" +
                    "aab301：行政区划编码" +
                    "aaa027：统筹区编码" +
                    "orgid：所属机构id" +
                    "aae013：备注",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object updateCs(HttpServletRequest request, @Param("..") CsDTO dto) {
        return ncjtjcApiModule.updateChef(request, dto);
    }

    /**
     * delCs的中文名称：删除厨师
     * <p>
     * delCs的概要说明：
     *
     * @param dto
     * @return Written by : zy
     */
    @DocumentInfo(
            sort = 42,
            name = "delCs",
            desc = "删除厨师",
            functiondesc = "删除厨师",
            author = "zy",
            params = " csid：厨师id ，必填 /",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delCs(HttpServletRequest request, @Param("..") CsDTO dto) {
        return ncjtjcApiModule.deleteChef(request, dto);
    }

    /**
     * addJcsb的中文名称：新增聚餐申报
     * <p>
     * addJcsb的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 41,
            name = "addJcsb",
            desc = "新增聚餐申报",
            functiondesc = "新增聚餐申报",
            author = "zy",
            params = " jcsbid：聚餐申报id ，必填 /" +
                    "jcsbbh：聚餐申报编号" +
                    "jcsbjbrxm：举办人" +
                    "jcsbjbrsjh：举办人手机号" +
                    "jcsbjclx：聚餐类型" +
                    "jcsbjcdd：聚餐地点" +
                    "jcsbjdzb：聚餐经度坐标" +
                    "jcsbwdzb：聚餐纬度坐标" +
                    "jcsbbjzt：聚餐申报标志状态" +
                    "jcsbjcsj1：聚餐时间1" +
                    "jcsbjcsj2：聚餐时间2 " +
                    "jcsbjcsj3：聚餐时间2" +
                    "jcsbjcrs：聚餐人数" +
                    "jcsbjcgm：聚餐规模" +
                    "jcsbylly：聚餐材料来源" +
                    "jcsbcsly：聚餐厨师来源" +
                    "jcsbcyjly：聚餐餐具来源" +
                    "jgyxcjcbz：监管员检查标志" +
                    "comshengdm：省份代码值" +
                    "comshengmc：省份名称" +
                    "comshidm：市代码值" +
                    "comshimc：市名称" +
                    "comxiandm：县代码" +
                    "comxianmc：县名称" +
                    "comxiangdm：乡镇代码" +
                    "comxiangmc：乡镇名称" +
                    "comcundm：社区/行政村代码" +
                    "comcunmc：社区/行政村名称" +
                    "aab301：行政区划编码" +
                    "aaa027：统筹区编码" +
                    "orgid：所属机构id" +
                    "aae013：备注",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object addJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.addJcsb(request, dto);
    }

    /**
     * updateJcsb的中文名称：修改聚餐申报
     * <p>
     * updateJcsb的概要说明：
     *
     * @param dto
     * @return Written by : zy
     */
    @DocumentInfo(
            sort = 40,
            name = "updateJcsb",
            desc = "修改聚餐申报",
            functiondesc = "修改聚餐申报",
            author = "zy",
            params = " jcsbid：聚餐申报id ，必填 /" +
                    "jcsbbh：聚餐申报编号" +
                    "jcsbjbrxm：举办人" +
                    "jcsbjbrsjh：举办人手机号" +
                    "jcsbjclx：聚餐类型" +
                    "jcsbjcdd：聚餐地点" +
                    "jcsbjdzb：聚餐经度坐标" +
                    "jcsbwdzb：聚餐纬度坐标" +
                    "jcsbbjzt：聚餐申报标志状态" +
                    "jcsbjcsj1：聚餐时间1" +
                    "jcsbjcsj2：聚餐时间2 " +
                    "jcsbjcsj3：聚餐时间2" +
                    "jcsbjcrs：聚餐人数" +
                    "jcsbjcgm：聚餐规模" +
                    "jcsbylly：聚餐材料来源" +
                    "jcsbcsly：聚餐厨师来源" +
                    "jcsbcyjly：聚餐餐具来源" +
                    "jgyxcjcbz：监管员检查标志" +
                    "comshengdm：省份代码值" +
                    "comshengmc：省份名称" +
                    "comshidm：市代码值" +
                    "comshimc：市名称" +
                    "comxiandm：县代码" +
                    "comxianmc：县名称" +
                    "comxiangdm：乡镇代码" +
                    "comxiangmc：乡镇名称" +
                    "comcundm：社区/行政村代码" +
                    "comcunmc：社区/行政村名称" +
                    "aab301：行政区划编码" +
                    "aaa027：统筹区编码" +
                    "orgid：所属机构id" +
                    "aae013：备注",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object updateJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.updateJcsb(request, dto);
    }

    /**
     * delJcsb的中文名称：删除聚餐申报
     * <p>
     * delJcsb的概要说明：
     *
     * @param dto
     * @return Written by : zy
     */
    @DocumentInfo(
            sort = 39,
            name = "delJcsb",
            desc = "删除聚餐申报",
            functiondesc = "删除聚餐申报",
            author = "zy",
            params = " jcsbid：聚餐申报id ，必填 / ",
            returndesc = "{\"code\":\"状态码\"," +
                    "\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delJcsb(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.deleteJcsb(request, dto);
    }

    /**
     * queryJcsbcs的中文名称：查询聚餐申报厨师
     * <p>
     * queryJcsbcs的概要说明：
     *
     * @param dto
     * @throws Exception Written by : zjf
     */
    @DocumentInfo(
            sort = 38,
            name = "queryJcsbcs",
            desc = "查询聚餐申报厨师",
            functiondesc = "查询聚餐申报厨师",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，必填 / ",
            returndesc = "{\"total\":2,\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"csid\":\"厨师id -- 2016051720175196894464537\"," +
                    "\"csxm\":\"厨师姓名 -- 李飞\"," +
                    "\"csxb\":\"厨师性别  -- 1\"," +
                    "\"cswhcd\":\"41\"," +
                    "\"cscynx\":\"3\"," +
                    "\"csjkzm\":\"1\"," +
                    "\"csjkzyxq\":\"2016-12-17\"," +
                    "\"cspxqk\":\"1\"," +
                    "\"csyx\":\"hy2288@qq.com\"," +
                    "\"csqq\":\"12345678\"," +
                    "\"cswx\":\"wx001\"," +
                    "\"csfwqy\":\"利民镇\"," +
                    "\"jcsbid\":\"1\"," +
                    "\"jcsbcsid\":\"2017080810214047647187260\"," +
                    "\"jcsbcslx\":\"\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryJcsbcs(HttpServletRequest request, @Param("..") ZyDTO dto,
                              @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryJcsbChefs(request, dto, pd);
    }

    /**
     * queryJcsbcsAll的中文名称：查询所有聚餐申报厨师
     * <p>
     * queryJcsbcsAll的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : tmm
     */
    @DocumentInfo(
            sort = 37,
            name = "queryJcsbcsAll",
            desc = "查询所有聚餐申报厨师",
            functiondesc = "查询所有聚餐申报厨师",
            author = "tmm",
            params = " csid：厨师id ，选填/" +
                    "csbh：厨师编号，选填/" +
                    "csxm：厨师姓名 ，选填 /" +
                    "cspym：厨师姓名拼音，选填" +
                    "cssfzjhm：厨师身份证件号码，选填/" +
                    "jcsbid：聚餐申报id，选填/" +
                    "aaa027：区域编码，选填 / ",
            returndesc = "\"total\":1,\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"csid\":\"厨师id --  2016072515371245242033812\"," +
                    "\"csbh\":\"厨师编号 -- CS20160725271\"," +
                    "\"csxm\":\"厨师姓名 -- 李亚军\"," +
                    "\"cspym\":\"姓名拼音 -- LYJ\"," +
                    "\"csxb\":\"厨师性别 --  1\"," +
                    "\"cscsrq\":\"厨师出生日期 --  19881218\"," +
                    "\"cssfzjlx\":\"厨师身份证件类型 -- 1\"," +
                    "\"cssfzjlxstr\":\"厨师身份证件类型名称 -- 居民身份证（户口簿）\"," +
                    "\"cssfzjhm\":\"厨师身份证件号 -- 411122198812183517\"," +
                    "\"cssjh\":\"厨师手机号码 -- 13683653009\"," +
                    "\"cswhcd\":\"\"," +
                    "\"cscynx\":\"\"," +
                    "\"csjkzm\":\"\"," +
                    "\"csjkzyxq\":\"\"," +
                    "\"csjktjdd\":\"\"," +
                    "\"cspxqk\":\"\"," +
                    "\"cspxhgzyxq\":\"\"," +
                    "\"csjtzz\":\"汤阴县任固镇\"," +
                    "\"csyx\":\"\"," +
                    "\"csqq\":\"\"," +
                    "\"cswx\":\"\"," +
                    "\"csfwqy\":\"\"," +
                    "\"aaa027\":\"统筹区编码 -- 410523102000\"," +
                    "\"aaa027name\":\"统筹区名称 --  任固镇\"," +
                    "\"orgid\":\"机构id   2016060617473623689299856\"," +
                    "\"orgname\":\"机构名称 -- 汤阴县食药局任固所\"," +
                    "\"aae036\":\"操作日期 -- 2016-07-25 15:37:12\"," +
                    "\"aae013\":\"\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryJcsbcsAll(HttpServletRequest request, @Param("..") CsDTO dto,
                                 @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryAllOfJcsbChefs(request, dto, pd);
    }

    /**
     * addJcsbcs的中文名称：聚餐申报厨师【保存】
     * <p>
     * addJcsbcs的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 36,
            name = "addJcsbcs",
            desc = "聚餐申报厨师【删除】",
            functiondesc = "聚餐申报厨师【删除】",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，选填 / " +
                    "succJsonStr：聚餐申报厨师列表 / ",
            returndesc = "{\"code\":\"状态码\",\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object addJcsbcs(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.addJcsbChef(request, dto);
    }

    /**
     * delJcsbcs的中文名称：聚餐申报厨师【删除】
     * <p>
     * delJcsbcs的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 35,
            name = "delJcsbcs",
            desc = "聚餐申报厨师【删除】",
            functiondesc = "聚餐申报厨师【删除】",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，必填填 / ",
            returndesc = "{\"code\":\"状态码\",\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delJcsbcs(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.deleteJcsbChef(request, dto);
    }

    /**
     * queryJcsbcd的中文名称：查询聚餐申报菜单
     * <p>
     * queryJcsbcd的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    @DocumentInfo(
            sort = 34,
            name = "queryJcsbcd",
            desc = "查询聚餐申报菜单",
            functiondesc = "查询聚餐申报菜单",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，选填 / ",
            returndesc = "{\"code\":\"状态码\",\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryJcsbcd(HttpServletRequest request,
                              @Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryJcsbMenu(request, dto, pd);
    }

    /**
     * addJcsbcd的中文名称：聚餐申报菜单【保存】
     * <p>
     * addJcsbcd的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 33,
            name = "addJcsbcd",
            desc = "聚餐申报菜单【保存】",
            functiondesc = "聚餐申报菜单【保存】",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，选填 / " +
                    "succJsonStr：聚餐申报菜单列表 / ",
            returndesc = "{\"code\":\"状态码\",\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object addJcsbcd(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.addJcsbMenu(request, dto);
    }

    /**
     * delJcsbcd的中文名称：聚餐申报菜单【删除】
     * <p>
     * delJcsbcd的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 32,
            name = "delJcsbcd",
            desc = "聚餐申报菜单【删除】",
            functiondesc = "聚餐申报菜单【删除】",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，必填 / ",
            returndesc = "{\"code\":\"状态码\",\"msg\":\"返回信息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delJcsbcd(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.deleteJcsbMenu(request, dto);
    }

    /**
     * queryJcsbpswp的中文名称：查询聚餐申报配送物品
     * <p>
     * queryJcsbpswp的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    @DocumentInfo(
            sort = 31,
            name = "queryJcsbpswp",
            desc = "查询聚餐申报配送物品",
            functiondesc = "查询聚餐申报配送物品",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，选填 / ",
            returndesc = "{\"total\":返回总条数,\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"jcsbpswpid\":\"聚餐申报配送物品 -- 2016052411251398445345606\"," +
                    "\"jcsbid\":\"聚餐申报id --  1\"," +
                    "\"jcsbpswpmc\":\"聚餐申报配送物品名称  --   面粉\"," +
                    "\"jcsbpswppp\":\"  一加一\"," +
                    "\"jcsbpswpsl\":\"聚餐申报配送物数量  --  100斤\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryJcsbpswp(HttpServletRequest request,
                                @Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryJcsbAccessories(request, dto, pd);
    }

    /**
     * addJcsbpswp的中文名称：聚餐申报配送物品【保存】
     * <p>
     * addJcsbpswp的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 30,
            name = "addJcsbpswp",
            desc = "聚餐申报配送物品【保存】",
            functiondesc = "聚餐申报配送物品【保存】",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，选填 / " +
                    "succJsonStr：聚餐申报物品列表 / ",
            returndesc = "{\"code\":\"状态码\",\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object addJcsbpswp(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.addJcsbAccessories(request, dto);
    }

    /**
     * delJcsbpswp的中文名称：聚餐申报配送物品【删除】
     * <p>
     * delJcsbpswp的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 29,
            name = "delJcsbpswp",
            desc = "聚餐申报配送物品【删除】",
            functiondesc = "聚餐申报配送物品【删除】",
            author = "zjf",
            params = " jcsbpswpid：聚餐申报配送物品id ，选填 /",
            returndesc = "{\"code\":\"状态码\",\"msg\":\"返回消息\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delJcsbpswp(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.delteJcsbAccessories(request, dto);
    }

    /**
     * queryJcjgyNo的中文名称：查询聚餐可指派的现场监管员
     * <p>
     * queryJcjgyNo的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    @DocumentInfo(
            sort = 28,
            name = "queryJcjgyNo",
            desc = "查询聚餐可指派的现场监管员 ",
            functiondesc = "查询聚餐可指派的现场监管员",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，选填 /",
            returndesc = "{\"total\":返回总条数,\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":[{\"userid\":\"用户id --- 190\"," +
                    "\"username\":\"用户名  --  翟建峰\"," +
                    "\"userkind\":\"用户类型 --  1\"," +
                    "\"orgname\":\"机构名称  --   汤阴县食药局\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryJcjgyNo(HttpServletRequest request,
                               @Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryAllOfJcsbSupervisor(request, dto, pd);
    }

    /**
     * queryJcjgy的中文名称：查询聚餐已指派的现场监管员
     * <p>
     * queryJcjgy的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zjf
     */
    @DocumentInfo(
            sort = 27,
            name = "queryJcjgy",
            desc = "查询聚餐已指派的现场监管员",
            functiondesc = "查询聚餐已指派的现场监管员",
            author = "zjf",
            params = " jcsbid：聚餐申报id ，选填 /",
            returndesc = "{\"total\":返回总条数,\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":[{\"userid\":\"用户id --- 190\"," +
                    "\"username\":\"用户名  --  翟建峰\"," +
                    "\"userkind\":\"用户类型 --  1\"," +
                    "\"orgname\":\"机构名称  --   汤阴县食药局\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryJcjgy(HttpServletRequest request, @Param("..") ZyDTO dto,
                             @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryJcsbSupervisor(request, dto, pd);
    }

    /**
     * addJcjgy的中文名称：聚餐指派现场监管员【保存】
     * <p>
     * addJcjgy的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 26,
            name = "addJcjgy",
            desc = "聚餐指派现场监管员【保存】 ",
            functiondesc = "聚餐指派现场监管员【保存】",
            author = "zy",
            params = " jcsbid：聚餐申报id ，选填 /" +
                    "jcsbbh：聚餐申报编号，选填" +
                    "jcsbjbrxm " +
                    "jcsbjbrsjh" +
                    "jcsbjcrs" +
                    "jgyxcjcbz" +
                    "userid：用户id",
            returndesc = "{\"total\":1,\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"aab301\":\"行政区划名称 --  商丘市虞城县利民镇谢庄村\"," +
                    "\"aaa027\":\"区域编码 -- 410523100200\"," +
                    "\"aaa027name\":\"区域名称 -- 石家庄村\"," +
                    "\"orgid\":\"机构id -- 411425107000\"," +
                    "\"aae011\":\"操作员  -- admin\"," +
                    "\"aae036\":\"操作时间 --  2016-01-06 16:08:07\"," +
                    "\"aae013\":\"聚餐申报测试1111\"," +
                    "\"itemid\":\"申报明细id  --- 2016051812073008784888309\"," +
                    "\"jcsbid\":\"申报id -- 1\"," +
                    "\"jcsbbh\":\"申报编号  --  JCSB20160106223\"," +
                    "\"jcsbjbrxm\":\"举办人姓名 -- 王飞\"," +
                    "\"jcsbjbrsjh\":\"举办人手机号  --  13345678900\"," +
                    "\"jcsbjclx\":\"聚餐类型 --  1\"," +
                    "\"jcsbjdzb\":\"聚餐经度坐标  --- 115.932779\"," +
                    "\"jcsbwdzb\":\"聚餐纬度坐标 --  34.479443\"," +
                    "\"jcsbjcsj1\":\"2016-06-20\"," +
                    "\"jcsbjccc1\":\"2\"," +
                    "\"jcsbjcsj2\":\"2016-06-20\"," +
                    "\"jcsbjccc2\":\"3\"," +
                    "\"jcsbjcsj3\":\"2016-06-21\"," +
                    "\"jcsbjccc3\":\"2\"," +
                    "\"jcsbjcrs\":\"350\"," +
                    "\"jcsbylly\":\"1\"," +
                    "\"jcsbcsly\":\"1\"," +
                    "\"jcsbcyjly\":\"2\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object addJcjgy(HttpServletRequest request, @Param("..") ZyDTO dto) {
        return ncjtjcApiModule.addJcsbSupervisor(request, dto);
    }

    /**
     * queryJcsbByJgy的中文名称：【根据指派的监管员】查询聚餐申报记录
     * <p>
     * queryJcsbByJgy的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : zjf
     * @throws Exception
     */
    @DocumentInfo(
            sort = 25,
            name = "queryJcsbByJgy",
            desc = "【根据指派的监管员】查询聚餐申报记录 ",
            functiondesc = "【根据指派的监管员】查询聚餐申报记录",
            author = "zy",
            params = " jcsbid：聚餐申报id ，选填 /jcsbbh：聚餐申报编号，选填/" +
                    "jcsbjbrxm ：聚餐申报举办人项目 /" +
                    "jcsbjbrsjh：聚餐申报举办人手机号 /" +
                    "jcsbjcrs：聚餐申报人数 /" +
                    "jgyxcjcbz ：监管员现场检查标志/" +
                    "userid：用户id",
            returndesc = "{\"total\":1,\"code\":\"0\",\"msg\":\"\"," +
                    "\"rows\":[{\"aab301\":\"行政区划名称 -- 商丘市虞城县利民镇谢庄村\"," +
                    "\"aaa027\":\"区域编码 -- 410523100200\"," +
                    "\"aaa027name\":\"区域名称 -- 石家庄村\"," +
                    "\"orgid\":\"机构id -- 411425107000\"," +
                    "\"aae011\":\"操作员  -- admin\"," +
                    "\"aae036\":\"操作时间 --  2016-01-06 16:08:07\"," +
                    "\"aae013\":\"聚餐申报测试1111\"," +
                    "\"itemid\":\"申报明细id  --- 2016051812073008784888309\"," +
                    "\"jcsbid\":\"申报id -- 1\"," +
                    "\"jcsbbh\":\"申报编号  --  JCSB20160106223\"," +
                    "\"jcsbjbrxm\":\"举办人姓名 -- 王飞\"," +
                    "\"jcsbjbrsjh\":\"举办人手机号  --  13345678900\"," +
                    "\"jcsbjclx\":\"聚餐类型 --  1\"," +
                    "\"jcsbjdzb\":\"聚餐经度坐标  --- 115.932779\"," +
                    "\"jcsbwdzb\":\"聚餐纬度坐标 --  34.479443\"," +
                    "\"jcsbjcsj1\":\"2016-06-20\"," +
                    "\"jcsbjccc1\":\"2\"," +
                    "\"jcsbjcsj2\":\"2016-06-20\"," +
                    "\"jcsbjccc2\":\"3\"," +
                    "\"jcsbjcsj3\":\"2016-06-21\"," +
                    "\"jcsbjccc3\":\"2\"," +
                    "\"jcsbjcrs\":\"350\"," +
                    "\"jcsbylly\":\"1\"," +
                    "\"jcsbcsly\":\"1\"," +
                    "\"jcsbcyjly\":\"2\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryJcsbByJgy(HttpServletRequest request,
                                 @Param("..") ZyDTO dto, @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryJcsbBySupervisor(request, dto, pd);
    }

    /**
     * saveEmergencyGroupPerson的中文名称：保存应急小组成员信息
     * <p>
     * saveEmergencyGroupPerson的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : zy
     */
    @DocumentInfo(
            sort = 23,
            name = "saveEmergencyByMobile",
            desc = "保存突发事件登记信息 ",
            functiondesc = "保存突发事件登记信息",
            author = "zy",
            params = "eventid:事件 ，选填 / " +
                    "newsid：备案信息，选填" +
                    "newsinitiator:上报人" +
                    "eventaddress：事件发生地址" +
                    "eventjdzb：事件发生经度坐标" +
                    "eventwdzb：事件发生纬度坐标" +
                    "eventfinder：事件上报人联系方式" +
                    "eventdate：事件发生日期" +
                    "eventcontent：事件内容" +
                    "eventlevel事件等级" +
                    "eventstate：事件处理状态",
            returndesc = "{\"total\":返回总数据条数,\"code\":\"状态码\",\"msg\":\"返回信息\",",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
//	public Object saveEmergencyByMobile(HttpServletRequest request,
//			@Param("..") EmeventcheckinDTO dto) {
//		return SysmanageUtil.execAjaxResult(emergencyService.saveEmergencyByMobile(request, dto));
//	}
    public Object saveEmergencyByMobile(HttpServletRequest request) {
        Map map = new HashMap();
        try {
            // 获取内容长度
            int len = request.getContentLength();
            byte[] buffer = new byte[len];
            // 获取输入流
            ServletInputStream in = request.getInputStream();
            int total = 0;
            for (int once = 0; total < len && once >= 0; total += once) {
                once = in.readLine(buffer, total, len);
            }
            // 编码
            String data = new String(buffer, "utf-8");
            // 将json字符串转换问json对象
            JSONObject jsonObj = JSONObject.fromObject(data);
            // 将json对象转换为对象类
            EmeventcheckinDTO dto = (EmeventcheckinDTO) JSONObject.toBean(jsonObj, EmeventcheckinDTO.class);

            return SysmanageUtil.execAjaxResult(emergencyService.saveEmergencyByMobile(request, dto));
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * g的中文名称：【根据溯源码】查询产品或材料来源
     * <p>
     * g的概要说明：
     *
     * @param request
     * @return Written by : zy
     * @throws Exception
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object g(HttpServletRequest request, @Param("sym") String sym) {
        Map map = new HashMap();
        try {
            List<QproductDTO> list = (List<QproductDTO>) sjbService.querySyxxBySym(sym);
            map.put("data", list);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * companyIndex的中文名称：
     * <p>
     * companyIndex的概要说明：
     *
     * @param request
     * @throws Exception Written by : zy
     */
    @At
    @Ok("jsp:/jsp/pub/companyInfo")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public void companyIndex(HttpServletRequest request) throws Exception {
        String v_comid = request.getParameter("comid");
        Map map = new HashMap();
        map = (Map) sjbService.queryComByQRcode(v_comid);
        // 企业信息
        PcompanyDTO v_com = (PcompanyDTO) map.get("comInfo");
        request.setAttribute("comInfo", v_com);
        // 许可证信息
        PcompanyXkzDTO dto = new PcompanyXkzDTO();
        dto.setComid(v_comid);
        PagesDTO pd = new PagesDTO();
        List<PcompanyXkzDTO> v_xkz = (List<PcompanyXkzDTO>) pcompanyService.queryPcompanyXkz(dto, pd).get("rows");
        request.setAttribute("xkzList", v_xkz);
    }

    /**
     * queryProOrClBySym的中文名称：【根据溯源码】查询产品或材料来源
     * <p>
     * queryProOrClBySym的概要说明：
     *
     * @param request
     * @return Written by : sunyifeng
     * @throws Exception
     */
    @At
    //@Ok("jsp:/jsp/pub/code2")
    @Ok("re:jsp:/jsp/error/error")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public String queryProOrClBySym(HttpServletRequest request, @Param("..") QproductDTO dto) throws Exception {

        String v_sym = request.getParameter("sym");
        String v_weixinsym = request.getParameter("weixinsym");

        request.setAttribute("code", request.getParameter("sym"));

        Map map = new HashMap();
        map = (Map) sjbService.querySyxxBySym(v_sym);

        // 产品信息
        QproductDTO v_productInfo = (QproductDTO) map.get("productInfo");
        request.setAttribute("productInfo", v_productInfo);

        // 产品材料信息
        List<QproductDTO> v_productClInfo = (List<QproductDTO>) map.get("productClInfo");
        request.setAttribute("productClInfo", v_productClInfo);

        // 产品检测信息
        List<Qproductjc> v_productJcInfo = (List<Qproductjc>) map.get("productJcInfo");
        request.setAttribute("productJcInfo", v_productJcInfo);

        // 产品生产生长信息信息
        List<Qproductszgcxx> v_productScszInfo = (List<Qproductszgcxx>) map.get("productScszInfo");
        request.setAttribute("productScszInfo", v_productScszInfo);

        //产品图片
        List<Fj> v_fjlist = (List<Fj>) map.get("proPiclist");
        request.setAttribute("proPiclist", v_fjlist);

        //产品视频
        List<Fj> v_fjvideolist = (List<Fj>) map.get("fjvideolist");
        request.setAttribute("fjvideolist", v_fjvideolist);

        //检验检测图片
        List<Fj> v_jyjcPiclist = (List<Fj>) map.get("jyjcPiclist");
        request.setAttribute("jyjcPiclist", v_jyjcPiclist);

        //溯源码查询日志
        QsymqrylogDTO v_QsymqrylogDTO = (QsymqrylogDTO) map.get("QsymqrylogDTO");
        request.setAttribute("QsymqrylogDTO", v_QsymqrylogDTO);

        //溯源码
        request.setAttribute("sym", v_sym);


        if (!StringUtils.isEmpty(v_weixinsym) && "1".equals(v_weixinsym)) {
            return "jsp:/jsp/asfoodsafe/query";
        } else {
            return "jsp:/jsp/pub/spsy/querySym";
        }

//gu20171229		List v_lst=sjbService.queryPcomsymurl(request,v_sym);
//		if (v_lst!=null && v_lst.size()>0){
//			PcomsymurlDTO v_PcomsymurlDTO=(PcomsymurlDTO)v_lst.get(0);
//			request.setAttribute("symurl", v_PcomsymurlDTO.getTzurl()+"?sym="+v_sym);
//			return "jsp:/jsp/pub/symtiaozhuan";
//		}else{
//			return "jsp:/jsp/pub/spsy/querySym";
//		}
    }

    /**
     * checkSymExist的中文名称：检查溯源码是否存在
     * <p>
     * checkSymExist的概要说明：
     *
     * @param request
     * @return Written by : gjf
     * @throws Exception
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object checkSymExist(HttpServletRequest request, @Param("sym") String sym) {
        Map map = new HashMap();
        try {
            boolean v_have = sjbService.checkSymExist(sym);
            if (v_have) {
                map.put("symexist", "1");
            } else {
                map.put("symexist", "0");
            }
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * querySyxxBySym的中文名称：【根据溯源码】查询溯源信息
     * <p>
     * querySyxxBySym的概要说明：
     *
     * @param request
     * @return Written by : zy
     * @throws Exception
     */
    @DocumentInfo(
            sort = 22,
            name = "querySyxxBySym",
            desc = "【根据溯源码】查询溯源信息 ",
            functiondesc = "【根据溯源码】查询溯源信息 ",
            author = "zy",
            params = "sym:溯源码 ，必填",
            returndesc = "{\"total\":返回总数据条数,\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":[{commc：企业名称" +
                    " comdz：企业地址" +
                    " comyddh： 移动电话号" +
                    "cppcpch" +
                    "cppcscrq" +
                    "proid" +
                    "proname" +
                    "prosptm" +
                    "probzgg" +
                    "probzq" +
                    "procpbzh" +
                    "proplxx" +
                    "propm" +
                    "probzqdwmc" +
                    "procdjd" +
                    "progg}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object querySyxxBySym(HttpServletRequest request, @Param("sym") String sym) {
        Map map = new HashMap();
        try {
            map = (Map) sjbService.querySyxxBySym(sym);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryJkqy的中文名称：查询监控企业
     * <p>
     * queryJkqy的概要说明：
     *
     * @param request
     * @return Written by : tmm
     * @throws Exception
     */
    @DocumentInfo(
            sort = 21,
            name = "queryJkqy",
            desc = "查询监控企业 ",
            functiondesc = "查询监控企业 ",
            author = "tmm",
            params = "\"选填 / jkqybh：监控企业编号 ， 选填 /  " +
                    " jkqymc监控企业名称 ，选填 /" +
                    "comdalei：企业大类，选填  " +
                    " jklx：监控类型，选填/ " +
                    "aaa027：区域编码 ，选填 /  " +
                    " state：摄像头状态 ，选填",
            returndesc = "{\"total\":返回总数据条数,\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":[{\"jkqybh\":\"监控企业编号 -- 2016070607325191136542624\"," +
                    "\"jkqymc\":\"监控企业名称 -- 阿瓦山寨\"," +
                    "\"filepath\":\"图片路径 -- /upload/company/8ed19d1455d84455a8d12db6cfdb0c0c.jpg\"," +
                    "\"comdz\":\"企业地址 -- 汤阴县城关镇\"," +
                    "\"ishavejgy\":\"是否有监管员 -- 1\"," +
                    "\"state\":\"摄像头状态 -- 1\"," +
                    "\"synchtime\":\"摄像头同步时间 -- 2017-09-20 02:00:00\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryJkqy(HttpServletRequest request, @Param("..") JkDTO dto,
                            @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            if (pd.getRows()==0){
                pd.setRows(10);
            }
            map = jkglService.queryJkqy(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryJky的中文名称：查询监控源
     * <p>
     * queryJky的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : tmm
     */
    @DocumentInfo(
            sort = 20,
            name = "queryJky",
            desc = "查询监控源 ",
            functiondesc = "查询监控源 ",
            author = "tmm",
            params = "jkid：监控id ，选填 / jkybh：监控员编号 ， 选填 / " +
                    "jkqybh：监控企业编号，选填 / jkqymc监控企业名称 ，选填 / " +
                    "jklx：监控类型，选填/ aaa027：区域编码 ，选填 / " +
                    "state：摄像头状态 ，选填",
            returndesc = "{\"total\":返回数据总条数,\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":[{\"jkid\":\"摄像头id --  2016092617400129667086866\"," +
                    "\"jkymc\":\"摄像头名称 -- 操作间48mes\"," +
                    "\"jkybh\":\"摄像头编号 --41052321001310000063\"," +
                    "\"jkqybh\":\"摄像头所属企业id -- 2016072011014643749452609\"," +
                    "\"jkqymc\":\"摄像头所属企业名称 -- 汤阴一中\"," +
                    "\"jklx\":\"监控类型 -- 1\"," +
                    "\"jksppath\":\"\"," +
                    "\"orderno\": 排序编号  0," +
                    "\"aaa027\":\"区域编码 -- 410523000000\"," +
                    "\"aaa027name\":\"区域名称 -- 汤阴县\"," +
                    "\"camorgid\":\"外企业id（力天） -- 41052321005000000033\"," +
                    "\"ishavejgy\":\"是否有监管员 -- 1\"," +
                    "\"state\":\"摄像头状态 -- 1\"," +
                    "\"synchtime\":\"摄像头同步时间  --  2017-09-20 02:00:00\"}]}",
            date = "2017-10-25",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryJky(HttpServletRequest request, @Param("..") JkDTO dto,
                           @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = jkglService.queryJky(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryJky的中文名称：查询监控源
     * <p>
     * queryJky的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : tmm
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryJkyMobilecam(HttpServletRequest request, @Param("..") JkDTO dto,
                                    @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = jkglService.queryJkyMobilecam(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    };


    /**
     * queryJkQyFzr的中文名称：查询监控企业负责人
     * <p>
     * queryJkQyFzr的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception Written by : zy
     */
    @DocumentInfo(
            sort = 19,
            name = "queryJkQyFzr",
            desc = "查询监控企业负责人 ",
            functiondesc = "查询监控企业负责人 ",
            author = "zy",
            params = "comid:企业id ，必填 ",
            returndesc = "{\"total\":返回总数据条数,\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":[{\"mobile2\":\"手机号  ---- 13598136486\"," +
                    "\"bmmc\":\"汤阴县食药局城关所\"," +
                    "\"orgid\":\"机构编码 --  2016060617451014232539915\"," +
                    "\"username\":\"用户名 --  韩文清\"," +
                    "\"jkqyfzrid\":\"监控企业负责人id --  2016121310541839253716787\"," +
                    "\"comid\":\"企业id  ---  2016072011014664070324100\"," +
                    "\"userid\":\"用户id --- 2016060709453591083265710\"}]}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryJkQyFzr(HttpServletRequest request, @Param("..") JkqyfzrDTO dto,
                               @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = jkglService.queryJkfzrList(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * queryLy的中文名称：查询两员
     * <p>
     * queryLy的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : tmm
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object queryLy(HttpServletRequest request, @Param("..") LyDTO dto, @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryLy(request, dto, pd);
    }

    /**
     * queryLyDTO的中文名称：查询两员DTO
     * <p>
     * queryLyDTO的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by :tmm
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object queryLyDTO(HttpServletRequest request,
                             @Param("..") LyDTO dto, @Param("..") PagesDTO pd) {
        return ncjtjcApiModule.queryLyDTO(request, dto, pd);
    }

    /**
     * addLy的中文名称：新增两员
     * <p>
     * addLy的概要说明：
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("json")
    public Object addLy(HttpServletRequest request, @Param("..") LyDTO dto) {
        return ncjtjcApiModule.addLy(request, dto);
    }

    /**
     * updateLy的中文名称：修改两员
     * <p>
     * updateLy的概要说明：
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("json")
    public Object updateLy(HttpServletRequest request, @Param("..") LyDTO dto) {
        return ncjtjcApiModule.updateLy(request, dto);
    }

    /**
     * getWsPrintPath：获取文书打印路径
     * <p>
     * getWsPrintPath：
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("json")
    public Object getWsPrintPath(HttpServletRequest request,
                                 @Param("..") BsCheckMasterDTO dto) throws Exception {
//		String v_wsPrintType="0";
//		//获取文书打印类型 WSPRINTTYPE0文书打印类型0正常打印1套打
//		Aa01 v_aa01=(Aa01)SysmanageUtil.getAa01("WSPRINTTYPE");
//		if (v_aa01!=null){
//			v_wsPrintType=v_aa01.getAaa005();
//		}
        Map map = new HashMap();
        try {
            String v_fjwid = "aaa";
            String v_fjpath = "";
//			String rootPath = request.getSession()
//									 .getServletContext()
//									 .getRealPath("/");
            String rootPath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
            v_fjwid = dto.getFjwid();
//			if ("0".equals(dto.getType())) {//现场检查笔录内容
//				v_fjwid = dto.getXcjcblid();
//			}
            FjDTO v_newFjdto = new FjDTO();
            v_newFjdto.setFjwid(v_fjwid);
            List<FjDTO> v_FjList = (List<FjDTO>) pubService.queryFjViewList(request, v_newFjdto);
            if (v_FjList != null && v_FjList.size() > 0) {
                for (int i = 0; i < v_FjList.size(); i++) {
                    FjDTO v_tempFj = v_FjList.get(i);
                    if ("".equals(v_fjpath)) {
                        v_fjpath = rootPath + v_tempFj.getFjpath();
                    } else {
                        v_fjpath = v_fjpath + ',' + rootPath + v_tempFj.getFjpath();
                    }
                }
            }
            map.put("fjpath", v_fjpath);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }

    }

    /**
     * getajdjDocumentsHtml的中文名称：得到案件登记文书页面
     * <p>
     * getajdjDocumentsHtml的概要说明：
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("raw:htm")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getajdjDocumentsHtml(HttpServletRequest request,
                                       @Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) throws Exception {
        try {
            //数据查询
            Object obj = null;
            if ("0".equals(dto.getType())) {
                // 现场见长笔录内容
                Zfwsxcjcbl8DTO dtobean = new Zfwsxcjcbl8DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setXcjcblid(dto.getXcjcblid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dtobean.setPrint("1");
                dto.setTbodytype("adjxcjcbl");//表头属性
                obj = wsgldyService.queryZfwsxcjcblObj(request, dtobean);
            } else if ("1".equals(dto.getType())) {//物品清单
                // 物品清单内容
                Zfwswpqd37DTO dtobean = new Zfwswpqd37DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setWpqdid(dto.getWpqdid());//物品id
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dtobean.setPrint("1");
                dto.setTbodytype("ajdjwpqd");//表头属性
                obj = wsgldyService.queryZfwswpqdObj(request, dtobean);

            } else if ("2".equals(dto.getType())) {//查封扣押决定书
                Zfwscfkyjds12DTO dtobean = new Zfwscfkyjds12DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setCfkyjdsid(dto.getCfkyjdsid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dto.setTbodytype("ajdjcfjds");//表头属性
                obj = wsgldyService.queryZfwscfkyjdslist(request, dtobean);
            } else if ("3".equals(dto.getType())) {//询问调查笔录
                Zfwsxwdcbl7DTO dtobean = new Zfwsxwdcbl7DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setXwdcblid(dto.getZfwsqtbid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dtobean.setPrint("1");
                dto.setTbodytype("ajdjxwdcbl");//表头属性
                obj = wsgldyService.queryZfwxwdcblObj(request, dtobean);
            } else if ("4".equals(dto.getType())) {//询问调查通知书
                ZfwsxwdctzsDTO dtobean = new ZfwsxwdctzsDTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setXwdctzsid(dto.getZfwsqtbid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dtobean.setPrint("1");
                dto.setTbodytype("ajdjxwdctzs");//表头属性
                obj = wsgldyService.queryZfwsxwdctzsObj(request, dtobean);
            } else if ("5".equals(dto.getType())) {//责令整改通知书
                Zfwszlgztzs20DTO dtobean = new Zfwszlgztzs20DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setZlgztzsid(dto.getZlgztzsid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dtobean.setPrint("1");
                dto.setTbodytype("ajdjzlzgtzs");//表头属性
                obj = wsgldyService.queryZfwszlgztzsObj(request, dtobean);
            } else if ("zfwsfy".equals(dto.getType())) {  //执法文书副页
                Zfwsspypxzcfwsfy36DTO dtobean = new Zfwsspypxzcfwsfy36DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setSpypxzcfwsfyid(dto.getSpypxzcfwsfyid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dto.setTbodytype("zfwsfy");//表头属性
                obj = wsgldyService.queryZfwsfyObj(request, dtobean);
            } else if("6".equals(dto.getType())){//先行登记保存物品通知书
                Zfwsxxdjbcwptzs10DTO dtobean = new Zfwsxxdjbcwptzs10DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setXxdjbcwptzsid(dto.getXxdjbcwptzsid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dtobean.setPrint("1");
                dto.setTbodytype("zfwsxxdjbctzs");//表头属性
                obj = wsgldyService.queryZfwsxxdjbcwptzs10Obj(request, dtobean);
            }else if("7".equals(dto.getType())){//没收物品凭证
                Zfwsmswppz30DTO dtobean = new Zfwsmswppz30DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setMswppzid(dto.getMswppzid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dto.setTbodytype("zfwsmswppz");//表头属性
                obj = wsgldyService.queryZfwsmswppzObj(request, dtobean);
            }
            else {  // 7当场行政处罚决定书
                Zfwsdcxzcfjds29DTO dtobean = new Zfwsdcxzcfjds29DTO();
                dtobean.setAjdjid(dto.getAjdjid());
                dtobean.setDcxzcfjdsid(dto.getDcxzcfjdsid());
                dtobean.setAjzfwsid(dto.getAjzfwsid());
                dtobean.setPrint("1");
                dto.setTbodytype("ajdjdcxzcfjds");//表头属性
                obj = wsgldyService.queryZfwsdcxzcfjds29Obj(request, dtobean);
            }

            Map map = new HashMap();
            if ("".equals(obj) || obj == null) {
                map.put("code", "0");
                map.put("msg", "查询不到相关文书数据信息");
                return map;
            }
            return sjbService.getajdjDocuments(dto, obj);
        } catch (Exception e) {
            e.printStackTrace();
            return "暂无数据";
        }

    }

    /**
     * @param request
     * @param dto
     * @return
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object queryZfwsxcjcbl(HttpServletRequest request,
                                  @Param("..") Zfwsxcjcbl8DTO dto) throws Exception {
        return wsgldyService.queryZfwsxcjcblObj(request, dto);
    }

    /*
	 * 法律法规条款页
	 *
	 */
    @At
    @Ok("jsp:/jsp/flfg/news")
    public void flfgnewsIndex(HttpServletRequest request) {
        // 页面初始化
    }
    ///////////////////////8询问调查笔录页///////////////////////

    /**
     * tyzfwsxcjcblIndex 询问调查笔录页
     *
     * @param request
     * @param dto
     * @throws Exception
     */
    @At
    @Ok("jsp:/jsp/pub/zfba/zfbaws/8tyzfwsxcjcbl")
    public void tyzfwsxcjcblIndex(HttpServletRequest request, @Param("..") Zfwsxcjcbl8DTO dto)
            throws Exception {
        String sjws = "2";
        request.setAttribute("sjws", sjws);
        Zfwsxcjcbl8DTO v_zfwsxcjcbl8DTO = (Zfwsxcjcbl8DTO) wsgldyService.queryZfwsxcjcblObj(request, dto);
        request.setAttribute("mybean", v_zfwsxcjcbl8DTO);
    }

    /**
     * 执法文书（物品清单）页面初始化
     *
     * @param request
     * @param dto
     * @throws Exception
     */
    @At
    @Ok("jsp:/jsp/pub/zfba/zfbaws/zfwswpqd37")
    public void zfwswpqdIndex(HttpServletRequest request, @Param("..") Zfwswpqd37DTO dto)
            throws Exception {
        //添加手机端参数
        String sjws = "2";
        request.setAttribute("sjws", sjws);
        // 物品清单内容
        Zfwswpqd37DTO v_zfwswpqd37DTO = (Zfwswpqd37DTO) wsgldyService.queryZfwswpqdObj(request, dto);
        request.setAttribute("mybean", v_zfwswpqd37DTO);
    }
    ///////////////////////12查封（扣押）决定书///////////////////////

    /**
     * ZfwscfkyjdsIndex的中文名称:初始化页面
     * ZfwscfkyjdsIndex的概要描述:
     * <p>
     * Wirtten by : ly
     */
    @At
    @Ok("jsp:/jsp/pub/zfba/zfbaws/12tyzfwscfkyjds")
    public void ZfwscfkyjdsIndex(HttpServletRequest request, @Param("..") Zfwscfkyjds12DTO dto)
            throws Exception {
        //添加手机端参数
        String sjws = "2";
        request.setAttribute("sjws", sjws);
        // 页面初始化
        Zfwscfkyjds12DTO v_Zfwscfkyjds12DTO =
                (Zfwscfkyjds12DTO) wsgldyService.queryZfwscfkyjdslist(request, dto);
        request.setAttribute("mybean", v_Zfwscfkyjds12DTO);
    }

    /**
     *
     * queryNews的中文名称：查询新闻
     *
     * queryNews的概要说明：
     *
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * 参数  "cateid", "catejc", "newsid", "newstitle"
     */
    ///////////////////////001询问调查通知书/////////////////////////////

    /**
     * 初始化页面
     * zfwsxwdctzsIndex的中文名称:询问调查通知书
     * zfwsxwdctzsIndex的概要描述:
     * <p>
     * Wirtten by : ly
     */
    @At
    @Ok("jsp:/jsp/pub/zfba/zfbaws/44zfwsxwdctzs")
    public void zfwsxwdctzsIndex(HttpServletRequest request, @Param("..") ZfwsxwdctzsDTO dto)
            throws Exception {
        //添加手机端参数
        String sjws = "2";
        request.setAttribute("sjws", sjws);
        // 页面初始化
        ZfwsxwdctzsDTO v_ZfwsxwdctzsDTO =
                (ZfwsxwdctzsDTO) wsgldyService.queryZfwsxwdctzsObj(request, dto);
        request.setAttribute("mybean", v_ZfwsxwdctzsDTO);
    }


    ///////////////////////20责令改正通知书////////////////////////////
    @At
    @Ok("jsp:/jsp/pub/zfba/zfbaws/20tyzfwszlgztzs")
    public void zfwszlgztzsIndex(HttpServletRequest request,
                                 @Param("..") Zfwszlgztzs20DTO dto) throws Exception {
        //添加手机端参数
        String sjws = "2";
        request.setAttribute("sjws", sjws);
        // 页面初始化
        Zfwszlgztzs20DTO v_Zfwszlgztzs20DTO =
                (Zfwszlgztzs20DTO) wsgldyService.queryZfwszlgztzsObj(request, dto);
        request.setAttribute("mybean", v_Zfwszlgztzs20DTO);
    }
    /////////////////////////////////////////////////////////////

    /**
     * Zfwsdcxzcfjds29DTOIndex的中文名称：执法文书：当场行政处罚决定书 29
     * <p>
     * Zfwsdcxzcfjds29DTOIndex的概要说明：      查询对象跳转到 当场行政处罚决定书29
     *
     * @param request Written by : ly
     * @throws Exception
     */
    @At
    //@Ok("jsp:/jsp/pub/zfba/zfbaws/dcxzcfjds29")
    @Ok("jsp:/jsp/pub/zfba/zfbaws/zfwsdcxzcfjds29")
    public void Zfwsdcxzcfjds29Index(HttpServletRequest request, @Param("..") Zfwsdcxzcfjds29DTO dto)
            throws Exception {
        //添加手机端参数
        String sjws = "2";
        request.setAttribute("sjws", sjws);
        Zfwsdcxzcfjds29DTO v_dto = (Zfwsdcxzcfjds29DTO) wsgldyService.queryZfwsdcxzcfjds29Obj(request, dto);
        request.setAttribute("mybean", v_dto);
    }

    @At
    @Ok("jsp:/jsp/pub/zfba/zfbaws/7tyzfwsxwdcbl")
    public void ZfwsxwdcblIndex(HttpServletRequest request,
                                @Param("..") Zfwsxwdcbl7DTO dto, ViewModel model) throws Exception {
        //添加手机端参数
        String sjws = "2";
        request.setAttribute("sjws", sjws);
        Zfwsxwdcbl7DTO v_Zfwsxwdcbl7DTO = (Zfwsxwdcbl7DTO) wsgldyService.queryZfwxwdcblObj(request, dto);
        request.setAttribute("mybean", v_Zfwsxwdcbl7DTO);
    }

   /* @At
    @Ok("json")
    public Object queryNews(HttpServletRequest request,@Param("..") News dto, @Param("..") PagesDTO pd)
            throws Exception {
        Map map = new HashMap();
        try {
            map = newsService.queryNews(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }*/


    /**
     * queryAjdjlyList的中文名称：常用字段设置
     * <p>
     * queryAjdjlyList的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : gjf
     */
    @DocumentInfo(
            sort = 17,
            name = "queryPcyzdsz",
            desc = "常用字段设置",
            functiondesc = "常用字段设置",
            author = "gjf",
            params = "tabname：表名 ，选填 / colname：列名，选填/ ",
            returndesc = "{\"total\":返回总条数,\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":[{\"pcyzdszdetailid\":\"明细id -- 2016101817204660434574706\"," +
                    "\"avalue\":\"明细值  ---  责令违反规定测试2\"," +
                    "\"aae140\":\"大类  ---  100\"," +
                    "\"czyxm\":\"操作员 -- 汤阴管理员\"," +
                    "\"czsj\":\"操作时间  --- 2016-10-18 17:20:46\"," +
                    "\"pcyzdszmainid\":\"主表id   ----  2016061618051030920667883\"}]}",
            date = "2017-07-15",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryPcyzdsz(HttpServletRequest request, @Param("..") PcyzdszmainDTO dto,
                               @Param("..") PagesDTO pd) {
        // 查询案件登记列表信息
        Map map = new HashMap();
        try {
            map = pubService.queryPcyzdsz(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * queryPcompanyXkzDTO ：查询企业资质证件信息
     *
     * @throws Exception
     */
    @DocumentInfo(
            sort = 15,
            name = "queryPcompanyXkzDTO",
            desc = "查询企业许可证信息",
            functiondesc = "查询企业许可证信息",
            author = " ",
            params = "comid ：企业id， 选填 / comxkzid：许可证有效期起始 ，选填 ",
            returndesc = "{\"total\":1," +
                    "\"rows\":{\"comxkzid\":\"许可证id  --  2016120918455710256053237\"," +
                    "\"comid\":\"企业id  --  2016072011255086049192944\"," +
                    "\"comxkzbh\":\"许可证编号  --   SP4105231150008716\"," +
                    "\"comxkfw\":\"许可范围  --  预、散、乳（不含）\"," +
                    "\"comxkyxqz\":\"许可日期值 --   2017-06-09\"," +
                    "\"comxkzlx\":\"许可类型  --  4\"," +
                    "\"comxkzlxstr\":\"许可类型字符串  --  食品经营许可证\"," +
                    "\"comxkzzcxs\":\"\"," +
                    "\"comxkzztyt\":\"\"}",
            date = "2017-07-15",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object queryPcompanyXkzDTO(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto,
                                      @Param("..") PagesDTO pd) throws Exception {

        Map map = new HashMap();
        try {
            map = pcompanyService.queryPcompanyXkz(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * savePcompanyXkzDTO ：保存企业资质证件信息
     *
     * @throws Exception
     */
    @DocumentInfo(
            sort = 15,
            name = "savePcompanyXkzDTO",
            desc = "保存企业许可证信息",
            functiondesc = "保存企业许可证信息",
            author = " ",
            params = " comid：企业id， 选填/ comxkzbh：许可证编号 ， 必填 / " +
                    " comxkzid ：许可证id ，保存不填 ， 更新必填  /comxkfw：许可范围 , 选填 / " +
                    " comxkzlx :许可类型 ，必填 / comxkyxqq ：许可证有效期起始 / " +
                    " comxkyxqz: 许可有效期止 ",
            returndesc = "{msg:返回信息," +
                    "code:返回码[-1:失败,0:成功]}",
            date = "2017-07-15",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object savePcompanyXkzDTO(HttpServletRequest request, @Param("succJsonStr") String succJsonStr,
                                     @Param("comid") String comid) {
        Map map = new HashMap();
        try {
            List xkzList = pcompanyService.addXkz(succJsonStr, comid);
            map.put("xkzList", xkzList);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * delPcompanyXkzDTO ： 删除企业资质证件信息
     *
     * @throws Exception
     */
    @DocumentInfo(
            sort = 14,
            name = "delPcompanyXkzDTO",
            desc = "删除企业许可证信息",
            functiondesc = "删除企业许可证信息",
            author = "zy",
            params = " comxkzid：企业许可证id， 选填/",
            returndesc = "{msg:返回信息," +
                    "code:返回码[-1:失败,0:成功]}",
            date = "2017-07-15",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object delPcompanyXkzDTO(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto) {
        return SysmanageUtil
                .execAjaxResult(pcompanyService.delXkz(request, dto));
    }

    /**
     * stopJob的中文名称：停止定时任务
     * <p>
     * stopJob的概要说明：
     *
     * @param request
     * @param jobName
     * @return
     * @throws Exception Written  by  : syf
     */
    @At
    @Ok("json")
    public Object stopJob(HttpServletRequest request, @Param("jobName") String jobName)
            throws Exception {
        System.out.println(jobName);
        QuartzManager.removeJob(jobName);
        return null;
    }

    /**
     * parseHTML2JSON的中文名称：转换ｈｔｍｌ内容为ｊｓｏｎ
     * <p>
     * parseHTML2JSON的概要说明：
     *
     * @return
     * @throws Exception Written  by  : syf
     */
    @At
    @Ok("json")
    public Object parseHTML2JSON(HttpServletRequest request, @Param("uri") String uri)
            throws Exception {
        //uri = "http://as.hda.gov.cn/layerXkzxx.jsp?xkzbh=SC20241052300028&time=Wed%20Sep%2028%2015:16:49%20CST%202016&Code=8";
        com.alibaba.fastjson.JSONObject retObject = new com.alibaba.fastjson.JSONObject();
        com.alibaba.fastjson.JSONObject jsonObject = new com.alibaba.fastjson.JSONObject();
        String content = HttpUtil.httpPost(uri, "UTF-8");
        if (content != null && !"".equals(content)) {
            Document doc = Jsoup.parse(content);
            Elements elements = doc.getElementsByTag("td");
            String[] attrs = new String[]{"comname", "comdz", "xkzbh", "xkzbh_src", "xkzq", "xkzz"};
            int i = 0;
            for (Element element : elements) {
                String elementText = element.text();

                jsonObject.put(attrs[i], elementText);
                i++;
                if (i == 6) break;
            }
        } else {
            return SysmanageUtil.execAjaxResult(null, new BusinessException("转换失败"));
        }
        retObject.put("data", jsonObject);
        return SysmanageUtil.execAjaxResult(retObject, null);
    }

    /**
     * queryloghtml ： 登录记录查看 以html页面返回
     * 参数logontime ：选择的日期    格式为 2001-01-01
     *
     * @param dto
     * @return
     * @throws Exception
     */
    @At
    @Ok("raw:htm")
    public Object queryloghtml(@Param("..") Syslogonlog dto) throws Exception {
        return sysuserService.queryloghtml(dto);
    }

    /**
     * queryqdhtml : 签到 打印  html 页面
     * 参数  unlocktime 选择的日期    格式为 2001-01-01
     *
     * @param dto
     * @return
     * @throws Exception
     */
    @At
    @Ok("raw:htm")
    public Object queryqdhtml(@Param("..") SysuserDTO dto) throws Exception {
        return sysuserService.queryqdhtml(dto);
    }

    /**
     * queryjkhtml : 监控开通情况  以html页面返回
     * 无参数      早上4点以后只返回当天的数据
     *
     * @return
     * @throws Exception
     */
    @At
    @Ok("raw:htm")
    public Object queryjkhtml() throws Exception {
        return sjbService.queryjkhtml();
    }

    /**
     * queryjchtml : 安全监管检查情况    以html页面返回
     * 参数    operatedate : 格式为 2017-01-01
     *
     * @param dto
     * @return
     * @throws Exception
     */
    @At
    @Ok("raw:htm")
    public Object queryjchtml(@Param("..") BsCheckMasterDTO dto) throws Exception {
        return sjbService.queryaqjgjchtml(dto);
    }

    /**
     * queryzfbajchtml : 执法办案登记情况    以html页面返回
     * 参数 ajdjczsj   格式为 2016-01-01
     *
     * @param dto
     * @return
     * @throws Exception
     */
    @At
    @Ok("raw:htm")
    public Object queryzfbajchtml(@Param("..") ZfajdjDTO dto) throws Exception {
        return sjbService.queryzfbajchtml(dto);
    }

    /**
     * getPlansByqyType的中文名称：根据企业类别获取相关的计划列表（查询结果）和企业id
     * <p>
     * getPlansByqyType的概要说明：手机--根据企业类型和企业id查询计划信息和结果状态
     *
     * @param dto
     * @return Written by : tmm
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object getPlansByqyType(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
        return supervisionApiModule.getPlanListByCompany(request, dto);
    }

    /**
     * getoldPlanList的中文名称：得到历史计划检查记录
     * <p>
     * getoldPlanList的概要说明：手机--根据企业id计划id查询企业检查历史
     *
     * @param dto
     * @return Written by : tmm
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object getoldPlanList(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
        return supervisionApiModule.getCheckHistoryListByPlan(request, dto);
    }

    /**
     * getPlansByqyTypeAndid的中文名称：根据企业类别和计划id及企业id获取相关的执法项
     * <p>
     * getPlansByqyTypeAndid的概要说明：
     * 手机--根据企业类型,企业id和计划id获取检查项目明细
     * itemid: 企业类型ID
     * planid: 计划ID
     * comid:企业id
     * resultid:结果id
     * 手机--(聚餐申报： 传入计划id,聚餐id和企业类别（itemid）)
     *
     * @param dto
     * @return Written by : tmm
     * @sunyifengu
     */
    @At
    @Ok("json")
    public Object getPlansByqyTypeAndid(HttpServletRequest request, @Param("..") BscheckplanDTO dto) {
        return supervisionApiModule.getCheckDetailListByCheckHistory(request, dto);
    }

    @At
    @Ok("json")
    public Object getCheckProblemListByDetailId(HttpServletRequest request, @Param("..") OmcheckbasisDTO dto) {
        return supervisionApiModule.getCheckProblemListByContentId(request, dto);
    }

    /**
     * queryCheckMasterId的中文名称：查询检查结果ID 新增检查
     * <p>
     * queryCheckMasterId的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @At
    @Ok("json")
    public Object queryCheckMasterId_20180427(HttpServletRequest request, @Param("..") BsCheckMaster dto) throws Exception {
        return supervisionOldApiModule.queryCheckMasterId(request, dto);
    }


    /**
     * saveCheckMasterId的中文名称：新增结果表
     * <p>
     * saveCheckMasterId的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : syf
     */
    @At
    @Ok("json")
    public Object saveCheckMasterId(HttpServletRequest request, @Param("..") BsCheckMaster dto) throws Exception {
        return supervisionOldApiModule.saveCheckMasterId(request, dto);
    }

    /**
     * saveCheckDetail的中文名称：逐项保存检查结果明细  (预留 截止到20170426未用上)
     * <p>
     * saveCheckDetail的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : syf
     */
    @At
    @Ok("json")
    public Object saveCheckDetail(HttpServletRequest request, @Param("..") BsCheckDetail dto) throws Exception {
        return supervisionApiModule.saveCheckDetail(request, dto);
    }

    /**
     * bathSaveCheckDetail的中文名称：批量保存检查结果明细
     * <p>
     * bathSaveCheckDetail的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @At
    @Ok("json")
    public Object bathSaveCheckDetail(HttpServletRequest request, @Param("..") BsCheckDetailDTO dto,
                                      @Param("..") BsCheckMasterDTO mdto)
            throws Exception {
        return supervisionApiModule.saveCheckDetailForBatch(request, dto, mdto);
    }

    /**
     * resultMaster的中文名称：得到核查结果
     * <p>
     * resultMaster的概要说明：手机--按照结果id返回核查结果
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("json")
    public Object getResultinfo(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) throws Exception {
        return supervisionApiModule.getResultinfoForConfirm(request, dto);
    }

    /**
     * updateResultinfo的中文名称：保存检查结果信息(食品生产企业特殊判断)
     * <p>
     * updateResultinfo的概要说明：穿入reultid和comid comid(需要手机端传入)
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("json")
    public Object updateResultinfo(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) throws Exception {
        return supervisionApiModule.commitResultinfo(request, dto);
    }

    /**
     * getResultHtmlByresultId的中文名称：根据结果id获取结果明细页面信息
     * <p>
     * getResultHtmlByresultId的概要说明：传入resultid
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("raw:htm")
    public Object getResultHtmlByresultId(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
        return supervisionApiModule.getResultInfoForHtml(request, dto);
    }

    /**
     * updateResultStateBy的中文名称：修改结果状态
     * <p>
     * updateResultStateBy的概要说明：传入planid和comid
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("json")
    public Object updateResultStateBy(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
        return supervisionOldApiModule.updateResultStateBy(request, dto);
    }

    /**
     * updateResultByid的中文名称：根据检查结果ID修改检查结果信息
     * <p>
     * updateResultByid的概要说明：resulid(查询顺序需要调整)
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("json")
    public Object updateResultByid(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
        return supervisionOldApiModule.updateResultByid(request, dto);
    }

    /**
     * getResultRecordHtmlByresultId的中文名称：根据结果id获取结果记录页面信息
     * <p>
     * getResultRecordHtmlByresultIds的概要说明：传入resultid
     *
     * @param dto
     * @return Written by : tmm
     */
    @At
    @Ok("raw:htm")
    public Object getResultRecordHtmlByresultId(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto) {
        return supervisionOldApiModule.getResultRecordHtmlByresultId(request, dto);
    }

    /*********************************离线同步*********************************** ST  *************************/
    /**
     * synchronousCheckMasterId的中文名称：同步结果表（同步离线结果数据）
     * <p>
     * synchronousCheckMasterId的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @At
    @Ok("json")
    public Object synchronousCheckMasterId(HttpServletRequest request, @Param("..") BsCheckMaster dto) throws Exception {
        return supervisionOldApiModule.synchronousCheckMasterId(request, dto);
    }

    /**
     * synchronousCheckBathSaveCheckDetail的中文名称：同步检查结果明细（同步离线结果明细数据）
     * <p>
     * synchronousCheckBathSaveCheckDetail的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @At
    @Ok("json")
    public Object synchronousCheckBathSaveCheckDetail(HttpServletRequest request,
                                                      @Param("..") BsCheckDetailDTO dto, @Param("..") BsCheckMasterDTO mdto)
            throws Exception {
        return supervisionOldApiModule.synchronousCheckBathSaveCheckDetail(request, dto, mdto);

    }

    /**
     * getCheckDetailForSaveAfter的中文名称：获取保存后未检查项目
     * <p>
     * getCheckDetailForSaveAfter的概要说明：返回大项ID，明细ID和所在检查表位置，位置从0开始
     *
     * @param dto
     * @return Written by : syf
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object getCheckDetailForSaveAfter(HttpServletRequest request,
                                             @Param("..") BsCheckMasterDTO dto)
            throws Exception {
        return supervisionOldApiModule.getCheckDetailForSaveAfter(request, dto);
    }
    /***********************************离线同步*********************************** ED  *************************/


    /**************************************聚餐申报*********************************** ED  *************************/

    /**
     * getJdjcResultList的中文名称：获取监督检查结果列表
     * <p>
     * getJdjcResultList的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author ：zjf
     */
    @At
    @Ok("json")
    public Object getJdjcResultList(HttpServletRequest request,
                                    @Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) throws Exception {
        return supervisionOldApiModule.getJdjcResultList(request, dto, pd);
    }

    /**
     * getJdjcResultDetail的中文名称：获取监督检查结果明细
     * <p>
     * getJdjcResultDetail的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author ：tmm
     */
    @At
    @Ok("raw:htm")
    public Object getJdjcResultDetail(HttpServletRequest request,
                                      @Param("..") BsCheckMasterDTO dto, @Param("..") PagesDTO pd) {
        return supervisionApiModule.getResultInfoForHtml(request, dto);
    }

    /**
     * querytbodys的中文名称：查询表单数据（手机离线）
     * <p>
     * querytbodys的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return Written by : tmm
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object querytbodys(HttpServletRequest request, @Param("..") BsCheckMasterDTO dto,
                              @Param("..") PagesDTO pd) throws Exception {
        return supervisionOldApiModule.querytbodys(request, dto, pd);
    }

    /**
     * queryCompanyListBycommc的中文名称：查询企业列表通过企业名称和用户id（commc和userid）
     * <p>
     * queryCompanyListBycommc的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @DocumentInfo(
            sort = 13,
            name = "querySysuser",
            desc = "查询企业列表通过企业名称和用户id",
            functiondesc = "查询企业列表通过企业名称和用户id",
            author = "tmm",
            params = "username:企业名称，选填 / userid：用户id，选填填/ ",
            returndesc = "{\"total\":6," +
                    "\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":{\"userid\":\"用户id\"," +
                    "\"username\":\"用户名\"," +
                    "\"passwd\":\"密码\"," +
                    "\"description\":\"用户描述\"," +
                    "\"lockstate\":\"0\"," +
                    "\"orgid\":\"机构代码\"," +
                    "\"userkind\":\"用户类型\"," +
                    "\"mobile\":\"手机号\"," +
                    "\"mobile2\":\"手机号2\"," +
                    "\"telephone\":\"移动电话\"," +
                    "\"aaa027\":\"机构代码\"," +
                    "\"orgname\":\"机构名称\"," +
                    "\"aaa027name\":\"机构名称\"," +
                    "\"selfcomflag\":\"0\"}",
            date = "2017-07-15",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object querySysuser(HttpServletRequest request, @Param("..") Sysuser dto,
                               @Param("..") PagesDTO pd) {
        // 查询企业信息
        Map map = new HashMap();
        try {
            int num = pd.getPage() != 0 ? 10 : 0;
            pd.setRows(num);//每页个数

            dto.setQuerykind("2");//只查非企业用户
            map = sysuserService.querySysuser(dto, pd);

            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * 附件上传
     *
     * @param request
     * @param dto
     * @return
     */
    @DocumentInfo(
            sort = 12,
            name = "uploadFj",
            desc = "附件上传",
            functiondesc = "一次可上传多张图片",
            author = "zy",
            params = " fjwid：附件关联id， 选填/" +
                    " fjcsdmz：附件参数代码值，当上传执法办案附件时必传，否则可选填/" +
                    "fjtype：附件类型 ，能和aa10表中的fjtype匹配 必填 否则可选填/ " +
                    "folderName:附件上传的文件夹名 ，选填/",
            returndesc = "{msg:返回信息,success:是否成功," +
                    "code:返回码[-1:失败,0:成功]}",
            date = "2017-07-15",
            version = "1.0.0")
    @SuppressWarnings("rawtypes")
    @At
    @Ok("json")
    public Object uploadFj(HttpServletRequest request, @Param("..") UploadfjDTO dto) {
        Map map = new HashMap();
        try {
            map = sjbService.uploadFj(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * 以后不调用这个方法，改为调用uploadFj方法;
     * uploadFjsave的中文名称：附件保存
     * <p>
     * uploadFjsave的概要说明：
     *
     * @param request
     * @return Written by : zy
     */
    @At
    @Ok("json")
    public Object uploadFjsave(HttpServletRequest request, @Param("..") UploadfjDTO dto) {
        // 上传附件保存
        return SysmanageUtil.execAjaxResult(sjbService.uploadFjsave(request, dto));
    }

    /**
     * 以后不调用这个方法，改为调用uploadFj方法;
     * saveFj的中文名称：上传图片附件到服务器后【保存记录到附件表】
     * <p>
     * saveFj的概要说明：通用
     *
     * @param request
     * @param dto
     * @return Written by : zjf
     */
    @DocumentInfo(
            sort = 18,
            name = "saveFj",
            desc = "上传图片附件到服务器后【保存记录到附件表】",
            functiondesc = "上传图片附件到服务器后【保存记录到附件表】",
            author = "zjf",
            params = "fjwid: 附件所属表主键id /fjtype： 附件类型，必填 / fjname： 附件名称 " +
                    "/ fjcontent：附件内容 ，必填 / fjid ：附件id ，更新必填 新增不填 /fjpath：附件路径，必填",
            returndesc = "{\"msg\":\"返回消息\"," +
                    "\"code\":\"返回码\"}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object saveFj(HttpServletRequest request, @Param("..") FjDTO dto) {
        return SysmanageUtil.execAjaxResult(pubService.uploadAndSaveFj(request, dto));
    }

    /**
     * getuploadFjList的中文名称：附件查看
     * <p>
     * getuploadFjList的概要说明：fjwid和fjcsdmz
     *
     * @param request
     * @return Written by : tmm
     */

    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object getuploadFjList(HttpServletRequest request, @Param("..") UploadfjDTO dto) {
        Map map = new HashMap();
        try {
            List list = pubService.queryUploadFjList(request, dto);
            map.put("rows", list);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * queryFjlist的中文名称：附件列表
     * <p>
     * queryFjlist的概要说明：fjwid（关联的主键id）,fjcsdmlb(附件参数小类编号)和fjcsdlbh(附件参数大类编号)
     *
     * @param dto
     * @param pd
     * @return Written by : tmm
     */
    @DocumentInfo(
            sort = 52,
            name = "queryFjlist",
            desc = "附件列表",
            functiondesc = "附件列表",
            author = "zjf",
            params = "fjwid:附件id " +
                    "fjcsdmlb(附件参数小类编号) " +
                    "fjcsdlbh(附件参数大类编号) ",
            returndesc = "{ " +
                    "\"code\": 返回码, " +
                    "\"msg\": 返回信息, " +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryFjlist(@Param("..") UploadfjDTO dto, @Param("..") PagesDTO pd) {
        Map map = new HashMap();
        try {
            map = pubService.queryFjlist(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * queryFjViewList的中文名称：查询附件表【fj】
     * <p>
     * queryFjViewList的概要说明：
     *
     * @param dto
     * @return
     * @throws Exception Written by : zjf
     */
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Object queryFjViewList(HttpServletRequest request, @Param("..") FjDTO dto) {
        Map map = new HashMap();
        try {
            List fjList = null;
            fjList = pubService.queryFjViewList(request, dto);
            map.put("rows", fjList);
            map.put("total", fjList.size());
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * delFj的中文名称：删除附件
     * <p>
     * delFj的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zjf
     * @throws Exception
     */
    @DocumentInfo(
            sort = 51,
            name = "uploadFjdel",
            desc = "更新附件",
            functiondesc = "更新附件",
            author = "zjf",
            params = "fjid:附件id ",
            returndesc = "{ " +
                    "\"code\": 返回码, " +
                    "\"msg\": 返回信息, " +
                    "}",
            date = "2017-09-26",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object uploadFjdel(HttpServletRequest request, @Param("..") UploadfjDTO dto) {
        return SysmanageUtil.execAjaxResult(pubService.uploadFjdel(request, dto));
    }

    /**
     * queryNewsDetail的中文名称：新闻内容预览
     * <p>
     * queryNewsDetail的概要说明：
     *
     * @param request
     * @param dto     Written by : zjf
     * @throws Exception
     */
    @At
    @Ok("jsp:/jsp/news/virtualdetail")
//	@SuppressWarnings({ "rawtypes", "unchecked" })
    public void peixunIndex(HttpServletRequest request,
                            @Param("..") Bord dto, @Param("..") PagesDTO pd) throws Exception {
        Map map = sjbService.queryNews(dto, pd);
        List<Bord> ls = (List) map.get("rows");
        Bord bord = new Bord();
        bord.setCateid("检查结果依据暂同步");
        if (ls.size() != 0) {
            bord = ls.get(0);
        }

        request.setAttribute("news", bord);
        request.setAttribute("preNews", bord);
        request.setAttribute("nextNews", bord);
    }

    /**
     * saveQsymqrylog的中文名称：保存溯源码
     * <p>
     * saveQsymqrylog的概要说明：
     *
     * @param request
     * @return Written by : zy
     * @throws IOException
     */
    @At
    @Ok("json")
    public Object saveQsymqrylog(HttpServletRequest request, @Param("..") QsymqrylogDTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
            sjbService.saveQsymqrylog(request, dto);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }

    /**
     * innitEaseMobUser 的中文名称：初始化环信账号
     * <p>
     * innitEaseMobUser 的概要说明：
     *
     * @param request
     * @return Written by : syf
     * @throws IOException
     */
    @At
    @Ok("json")
    public Object innitEaseMobUser(HttpServletRequest request, @Param("..") Sysuser dto, @Param("..") PagesDTO pd) {
        Map<String, String> result = new HashMap<String, String>();
        try {

            Map map = sysuserService.querySysuser(dto, pd);
            if (map.containsKey(GlobalNames.SI_ROWS)) {
                List<Sysuser> ls = (List) map.get(GlobalNames.SI_ROWS);
                for (Sysuser sysUser : ls) {
                    SysEasemobService.getInstance().delSysuserFromEasemob(sysUser);
                    SysEasemobService.getInstance().addSysuserToEasemob(sysUser);
                }
            }

        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }

    /**
     * queryEmergencyList的中文名称：查询应急登记列表信息
     * <p>
     * queryEmergencyList的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : zy
     */
    @DocumentInfo(
            sort = 56,
            name = "queryEmergencyList",
            desc = "查询应急登记列表信息",
            functiondesc = "查询应急登记列表信息",
            author = "gjf",
            params = "",
            returndesc = "",
            date = "2018-03-02",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryEmergencyList(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto,
                                     @Param("..") PagesDTO pd) {
        //单条或多调 1 单条 其他多条
        String v_onerowflag = StringHelper.showNull2Empty(dto.getOnerowflag());
        //StringHelper.showNull2Empty(request.getParameter("onerowflag"));
        // 查询案件登记列表信息
        Map map = new HashMap();
        try {
            map = sjbService.queryEmergencyList(dto, pd);
            if ("1".equals(v_onerowflag)) {
                List<EmeventcheckinDTO> ls = (List) map.get(GlobalNames.SI_ROWS);
                EmeventcheckinDTO v_dto = (EmeventcheckinDTO) ls.get(0);
                map.put("data", v_dto);

            }
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }

    }

    /**
     * queryCheckMasterId的中文名称：查询检查结果ID 新增检查
     * <p>
     * queryCheckMasterId的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @At
    @Ok("json")
    public Object queryCheckMasterId(HttpServletRequest request, @Param("..") BsCheckMaster dto) throws Exception {
        return supervisionOldApiModule.queryCheckMasterId(request, dto);
    }

    /**
     * getSysuserByuserid   查询人员id和人员姓名及手机号
     *
     * @param request
     * @param dto
     * @return Written by : syh
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object getSysuserByuseridtoJSON(HttpServletRequest request, @Param("..") SysuserDTO dto) {
        Map map = new HashMap();
        try {
            List ls = sjbService.getSysuserByuserid(request, dto);
            map.put("rows", ls);
            map.put("total", ls.size());
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }

    /**
     * saveCompany的中文名称：添加企业基本信息 完成的是注册功能
     * <p>
     * saveCompany的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : tmm
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object saveComJingWeiDu(HttpServletRequest request, @Param("..") PcompanyDTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
            dto.setSjordnbz("2");//gu20161020add
            pcompanyService.saveComJingWeiDu(request, dto);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }

    /**
     * 现场检查笔录保存  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveZfwsxcjcbl8(HttpServletRequest request, @Param("..") Zfwsxcjcbl8DTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
            dto.setSjordn("2");
            String xcjcblid= wsgldyService.saveZfwsxcjcbl(request, dto);
            if (xcjcblid != null) {
                result.put("xcjcblid", xcjcblid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }
    /**
     * 现场检查笔录查询  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object queryTyzfwsxcjcbl(HttpServletRequest request, @Param("..") Zfwsxcjcbl8DTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            Zfwsxcjcbl8DTO v_xcjcbl = (Zfwsxcjcbl8DTO) wsgldyService.queryZfwsxcjcblObj(request, dto);
            if(v_xcjcbl != null){
                map.put("data",v_xcjcbl);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);

    }
    /**
     * 询问调查笔录保存  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveZfwsxwdcbl7(HttpServletRequest request, @Param("..") Zfwsxwdcbl7DTO dto) {
        Map result = new HashMap();
        try {
            dto.setSjordn("2");
            String xwdcblid= wsgldyService.saveZfwsxwdcbl(request, dto);
            if (xwdcblid != null) {
                result.put("xwdcblid", xwdcblid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }
    /**
     * 询问调查笔录查询  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object queryZfwsxwdcb(HttpServletRequest request, @Param("..") Zfwsxwdcbl7DTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            Zfwsxwdcbl7DTO v_Zfwsxwdcbl7DTO = (Zfwsxwdcbl7DTO) wsgldyService.queryZfwxwdcblObj(request, dto);
            if(v_Zfwsxwdcbl7DTO != null){
                map.put("data",v_Zfwsxwdcbl7DTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);

    }
    /**
     * 手机端选择添加文书列表  wxy
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object queryAjwsParamlist(@Param("..") ViewzfajzfwsDTO dto,
                                     @Param("..") PagesDTO pd) throws Exception {
        Map map=new HashMap();
        try {
            dto.setOperatetype("2");
            map = wsgldyService.queryAjwsParamlist(dto, pd);
            return SysmanageUtil.execAjaxResult(map, null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    /**
     * 手机端选择添加文书  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveZfwsadd(HttpServletRequest request,
                              @Param("..") ZfajzfwsDTO dto) throws Exception {
        Map map=new HashMap();
        try {
            wsgldyService.saveZfwsadd(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    /**
     * 查封（扣押）决定书保存  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveZfwscfkyjds12(HttpServletRequest request, @Param("..") Zfwscfkyjds12DTO dto) {
        Map result = new HashMap();
        try {
            dto.setSjordn("2");
            String cfkyjdsid= wsgldyService.saveZfwscfkyjds(request, dto);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回ZfwscfkyjdsIndex
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }
    /**
     * 查封（扣押）决定书查询  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object queryZfwscfkyjds(HttpServletRequest request, @Param("..") Zfwscfkyjds12DTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            Zfwscfkyjds12DTO v_Zfwscfkyjds12DTO =
                    (Zfwscfkyjds12DTO) wsgldyService.queryZfwscfkyjdslist(request, dto);
            if(v_Zfwscfkyjds12DTO != null){
                map.put("data",v_Zfwscfkyjds12DTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    /**
     * 责令改正通知书保存  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveZfwszlgztzs20(HttpServletRequest request, @Param("..") Zfwszlgztzs20DTO dto) {
        Map result = new HashMap();
        try {
            dto.setSjordn("2");
            String zlgztzsid= wsgldyService.saveZfwszlgztzs(request, dto);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);// 异常返回ZfwscfkyjdsIndex
        }
        return SysmanageUtil.execAjaxResult(result, null);
    }
    /**
     * 责令改正通知书查询  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object queryZfwszlgztzs(HttpServletRequest request, @Param("..") Zfwszlgztzs20DTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            Zfwszlgztzs20DTO v_Zfwszlgztzs20DTO =
                    (Zfwszlgztzs20DTO) wsgldyService.queryZfwszlgztzsObj(request, dto);
            if(v_Zfwszlgztzs20DTO != null){
                map.put("data",v_Zfwszlgztzs20DTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    /**
     *
     * saveZfwsdcxzcfjds29的中文名称：当场行政处罚决定书 29
     *
     * saveZfwsdcxzcfjds29的概要说明：保存或者修改 行政处罚事先告知书 29
     *
     * @param dto
     * @return Written by : wxy
     */
    @At
    @Ok("json")
    public Object saveZfwsdcxzcfjds29(HttpServletRequest request,
                                      @Param("..")Zfwsdcxzcfjds29DTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
            dto.setSjordn("2");
            String dcxzcfjdsid = wsgldyService.saveZfwsdcxzcfjds29(request, dto);
            if (dcxzcfjdsid != null) {
                result.put("dcxzcfjdsid", dcxzcfjdsid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);//异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
    }
    /**
     * 当场行政处罚决定书查询  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object queryZfwsdcxzcfjds(HttpServletRequest request, @Param("..") Zfwsdcxzcfjds29DTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            Zfwsdcxzcfjds29DTO v_dto = (Zfwsdcxzcfjds29DTO) wsgldyService.queryZfwsdcxzcfjds29Obj(request, dto);
            if(v_dto != null){
                map.put("data",v_dto);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    /**
     * 保存物品清单
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object saveZfwswpqd37(HttpServletRequest request, @Param("..") Zfwswpqd37DTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
            dto.setSjordn("2");
            String wpqdid = wsgldyService.saveZfwswpqd(request, dto);
            if (wpqdid != null) {
                result.put("wpqdid", wpqdid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);//异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
    }
    /**
     * 物品清单查询  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object queryZfwswpqd(HttpServletRequest request, @Param("..") Zfwswpqd37DTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            Zfwswpqd37DTO v_zfwswpqd37DTO = (Zfwswpqd37DTO) wsgldyService.queryZfwswpqdObj(request, dto);
            if(v_zfwswpqd37DTO != null){
                map.put("data",v_zfwswpqd37DTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    /**
     * 查询物品清单明细
     * @param dto
     * @param pd
     * @return
     * @throws Exception wxy
     */
    @At
    @Ok("json")
    public Object queryZfwswpqdmx(@Param("..") Zfwswpqd37DTO dto,
                                  @Param("..") PagesDTO pd) throws Exception {
        Map map = new HashMap();
        try{
            map =wsgldyService.queryZfwswpqdmx(dto, pd);
        }catch (Exception e){
            SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    /**
     * 保存更新讨论记录的信息
     *savexwdctzs的中文名称:保存询问调查通知书
     *savexwdctzs的概要描述:
     *
     *Wirtten by : wxy
     */
    @At
    @Ok("json")
    public Object saveXwdctzs44(HttpServletRequest request,
                                @Param("..") ZfwsxwdctzsDTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
            dto.setSjordn("2");
            String xwdctzsid = wsgldyService.saveXwdctzs(request, dto);
            if (xwdctzsid != null) {
                result.put("xwdctzsid", xwdctzsid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);//异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
    }
    /**
     * 查封（扣押）决定书查询  wxy
     * @param request
     * @param dto
     * @return
     */
    @At
    @Ok("json")
    public Object queryXwdctzs(HttpServletRequest request, @Param("..") ZfwsxwdctzsDTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            ZfwsxwdctzsDTO v_ZfwsxwdctzsDTO =
                    (ZfwsxwdctzsDTO) wsgldyService.queryZfwsxwdctzsObj(request, dto);
            if(v_ZfwsxwdctzsDTO != null){
                map.put("data",v_ZfwsxwdctzsDTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    /**
     * 查询所有人员信息并分页显示
     * @throws Exception
     */
    @At
    @Ok("json")
    public Object queryPcomry(HttpServletRequest request,@Param("..") PcomryDTO dto,@Param("..") PagesDTO pd,@Param("querytype")String querytype) {

        Map map = new HashMap();
        try {
            map = pcomryService.queryPcomry(request, dto, pd, querytype);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    @At
    @Ok("json")
    public Object queryPcomryDTO(HttpServletRequest request,
                                 @Param("..") PcomryDTO dto,
                                 @Param("..") PagesDTO pd,@Param("querytype")String querytype) throws Exception{
        Map map = new HashMap();
        try {
            map = pcomryService.queryPcomry(request,dto, pd,querytype);
            List list = (List) map.get("rows");
            PcomryDTO pcDto = null;
            if(list!=null && list.size()>0){
                pcDto = (PcomryDTO)list.get(0);
            }
            map.put("data", pcDto);
            return SysmanageUtil.execAjaxResult(map, null);
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
    }
    /**
     * 保存企业人员基本信息
     */
    @At
    @Ok("json")
    public Object savePcomry(HttpServletRequest request,@Param("..") PcomryDTO dto){
        Map map = new HashMap();
        try {
            dto.setSjordn("2");
            String id = pcomryService.savePcomry(request, dto);
            if (id != null) {
                map.put("id", id);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }

    /**
     * savePcompanyXkzDTO ：保存企业资质证件信息
     *
     * @throws Exception
     */
    @DocumentInfo(
            sort = 15,
            name = "savePcompanyXkzFromQRcode",
            desc = "保存企业许可证信息",
            functiondesc = "保存企业许可证信息",
            author = " ",
            params = " comid：企业id， 选填/ comxkzbh：许可证编号 ， 必填 / " +
                    " comxkzid ：许可证id ，保存不填 ， 更新必填  /comxkfw：许可范围 , 选填 / " +
                    " comxkzlx :许可类型 ，必填 / comxkyxqq ：许可证有效期起始 / " +
                    " comxkyxqz: 许可有效期止 ",
            returndesc = "{msg:返回信息," +
                    "code:返回码[-1:失败,0:成功]}",
            date = "2017-07-15",
            version = "1.0.0")
    @At
    @Ok("json")
    public Object getXkzinfoFromQrcodeFromShengju(HttpServletRequest request, @Param("..") PcompanyXkzDTO dto ) throws Exception {
        //http://as.hda.gov.cn/layerJyXkzxx.jsp?xkzbh=JY34104810019807
        //String str1="许可证编号:JY14105230016578;经营者名称:汤阴新合作联购超市;经营场所:汤阴县人民路与中华路交叉口西北角（上亿...法定代表人(负责人):叶长锋;主体业态:食品销售经营者;有效期至:2021-08-15;更多信息请访问http://hda.gov.cn/CL0577";
        //String str2="生产者名称:获嘉县和佳调味品酿造厂,社会信用代码（身份证号码）914107241732747048,法定代表人（负责人）娄季隆,生产地址获嘉县获武路,食品类别调味品,许可证编号SC10341072400030,有效期2021-02-25 00:00:00;更多信息请访问http://hda.gov.cn/CL0577";
        Map map = new HashMap();
        try{
            map =pcompanyService.getXkzinfoFromQrcodeFromShengju(request, dto);
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);

    }
    //查询行政处罚文书副页
    @At
    @Ok("json")
    public Object queryZfwsfy(HttpServletRequest request, @Param("..") Zfwsspypxzcfwsfy36DTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            Zfwsspypxzcfwsfy36DTO v_Zfwsspypxzcfwsfy36DTO =
                    (Zfwsspypxzcfwsfy36DTO) wsgldyService.queryZfwxfylist(request, dto);
            if(v_Zfwsspypxzcfwsfy36DTO != null){
                map.put("data",v_Zfwsspypxzcfwsfy36DTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    @At
    @Ok("json")
    public Object saveZfwsfy(HttpServletRequest request,
                                @Param("..") Zfwsspypxzcfwsfy36DTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
            dto.setSjordn("2");
            String spypxzcfwsfyid = wsgldyService.saveZfwsfy(request, dto);
            if (spypxzcfwsfyid != null) {
                result.put("spypxzcfwsfyid", spypxzcfwsfyid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);//异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
    }
    @At
    @Ok("json")
    public Object delZfwsfy(HttpServletRequest request,
                          @Param("..") Zfwsspypxzcfwsfy36DTO dto) {
        Map map=new HashMap();
        try{
            String id=wsgldyService.delZfwsfy(request, dto);
            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }


    //查询应急调度回复内容
    @At
    @Ok("json")
    public Object queryYingjidiaoduHuifu(HttpServletRequest request, @Param("..") OanoticemanagerDTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            OanoticemanagerDTO v_OanoticemanagerDTO =
                    (OanoticemanagerDTO) sjbService.queryYingjidiaoduHuifu(request, dto);
            if(v_OanoticemanagerDTO != null){
                map.put("data",v_OanoticemanagerDTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }


    //手机端保存先行登记保存物品通知书
    @At
    @Ok("json")
    public Object saveZfwsxxdjbcwptzs(HttpServletRequest request,
                                      @Param("..")Zfwsxxdjbcwptzs10DTO dto) {
        Map<String, String> result = new HashMap<String, String>();
        try {
            dto.setSjordn("2");
            String xxdjbcwptzsid = wsgldyService.saveZfwsxxdjbcwptzs10(request, dto);
            if (xxdjbcwptzsid != null) {
                result.put("xxdjbcwptzsid", xxdjbcwptzsid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);//异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回;
    }
    //手机端查询先行登记保存物品通知书
    @At
    @Ok("json")
    public Object queryZfwsxxdjbcwptzs(HttpServletRequest request, @Param("..") Zfwsxxdjbcwptzs10DTO dto)
            throws Exception {
        Map map = new HashMap();
        try{
            Zfwsxxdjbcwptzs10DTO v_zfwsxxdjbcwptzs10DTO = (Zfwsxxdjbcwptzs10DTO) wsgldyService.queryZfwsxxdjbcwptzs10Obj(request, dto);
            if(v_zfwsxxdjbcwptzs10DTO != null){
                map.put("data",v_zfwsxxdjbcwptzs10DTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }
    /**
     * 保存执法文书没收物品凭证文书
     */
    @At
    @Ok("json")
    public Object saveZfwsmswppz(HttpServletRequest request,
                                 @Param("..") Zfwsmswppz30DTO dto) throws Exception{
        Map<String, String> result = new HashMap<String, String>();
        try {
            dto.setSjordn("2");
            String mswppzid = wsgldyService.saveZfwsmswppz(request, dto);
            if (mswppzid != null) {
                result.put("mswppzid", mswppzid);
            }
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(result, e);//异常返回
        }
        return SysmanageUtil.execAjaxResult(result, null);//无异常信息返回
    }
    @At
    @Ok("json")
    public Object queryZfwsmswppz(HttpServletRequest request,@Param("..")Zfwsmswppz30DTO dto)
            throws Exception{
        Map map = new HashMap();
        try{
            Zfwsmswppz30DTO zfwsmswppz30DTO = (Zfwsmswppz30DTO) wsgldyService.queryZfwsmswppzObj(request, dto);
            if(zfwsmswppz30DTO != null){
                map.put("data",zfwsmswppz30DTO);
            }
        }catch (Exception e){
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
        return SysmanageUtil.execAjaxResult(map, null);
    }

    /**
     *
     * addHuanxinFriendAll的中文名称：将系统中所有操作员添加互相添加为好友，可以在系统上线后执行一次
     *
     * @return Written by : zjf
     *
     */
    @At
    @Ok("json")
    public Object addHuanxinFriendForAllUser(HttpServletRequest request) {
        Boolean v_ok=sjbService.addHuanxinFriendForAllUser(request);
        String v_ret="";
        if (!v_ok){
            v_ret="err";
        }
        return SysmanageUtil.execAjaxResult(v_ret);
    }

    /**
     * jpushInfo的中文名称：极光推送消息
     * <p>
     * jpushInfo的概要说明：
     *
     * @param dto
     * @return Written by : zjf
     */
    @At
    @Ok("json")
    public Object jpushMinglingMsgAll(HttpServletRequest request, @Param("..") EmeventcheckinDTO dto, @Param("..") PagesDTO pd) {
//        dto.setJpushmingling("yingjishipin");
//        dto.setJpushtitle("应急视频");
//        dto.setJpushcontent(dto.getEventcontent());
        try {
            return SysmanageUtil.execAjaxResult(sjbService.jpushMinglingMsgAll(request, dto));
        } catch (Exception e) {
            e.printStackTrace();
            return SysmanageUtil.execAjaxResult(e.getMessage());
        }
    }

    /**
     * queryCompanyListBycommc的中文名称：查询企业列表通过企业名称和用户id（commc和userid）
     * <p>
     * queryCompanyListBycommc的概要说明：
     *
     * @param request
     * @return
     * @throws Exception Written by : tmm
     */
    @DocumentInfo(
            sort = 13,
            name = "querySysuser",
            desc = "查询企业列表通过企业名称和用户id",
            functiondesc = "查询企业列表通过企业名称和用户id",
            author = "tmm",
            params = "username:企业名称，选填 / userid：用户id，选填填/ ",
            returndesc = "{\"total\":6," +
                    "\"code\":\"状态码\",\"msg\":\"返回信息\"," +
                    "\"rows\":{\"userid\":\"用户id\"," +
                    "\"username\":\"用户名\"," +
                    "\"passwd\":\"密码\"," +
                    "\"description\":\"用户描述\"," +
                    "\"lockstate\":\"0\"," +
                    "\"orgid\":\"机构代码\"," +
                    "\"userkind\":\"用户类型\"," +
                    "\"mobile\":\"手机号\"," +
                    "\"mobile2\":\"手机号2\"," +
                    "\"telephone\":\"移动电话\"," +
                    "\"aaa027\":\"机构代码\"," +
                    "\"orgname\":\"机构名称\"," +
                    "\"aaa027name\":\"机构名称\"," +
                    "\"selfcomflag\":\"0\"}",
            date = "2017-07-15",
            version = "1.0.0")
    @At
    @Ok("json")
    @SuppressWarnings({"rawtypes"})
    public Object queryUserHuanxinFriend(HttpServletRequest request, @Param("..") Sysuser dto,
                               @Param("..") PagesDTO pd) {
        // 查询企业信息
        Map map = new HashMap();
        try {
            //int num = pd.getPage() != 0 ? 1000 : 0;
            pd.setRows(1000);//每页个数

            //dto.setQuerykind("2");//只查非企业用户
            map = sysuserService.queryUserHuanxinFriend(dto, pd);

            return SysmanageUtil.execAjaxResult(map, null);// 无异常信息返回
        } catch (Exception e) {
            return SysmanageUtil.execAjaxResult(map, e);// 异常返回
        }
    }

    /**
     * 跳转到聊天页面
     */
    @At
    @Ok("jsp:/jsp/jk/qydtjk/chatAll")
    public void chatallIndex(HttpServletRequest request){
        //极光聊天信息
    }

    /**
     * 跳转到聊天页面
     */
    @At
    @Ok("jsp:/jsp/jk/qydtjk/shipinAll")
    public void shipinallIndex(HttpServletRequest request){
        //极光聊天信息
    }

}
