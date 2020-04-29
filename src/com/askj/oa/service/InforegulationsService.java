package com.askj.oa.service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import common.Logger;
import org.nutz.dao.Dao;
import org.nutz.dao.Cnd;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zzhdsoft.utils.BeanCopyUtil;
import com.askj.oa.dto.InforeGulationsDTO;
import com.askj.oa.entity.InforeGulations;

/**
*
*  InforegulationsService的中文名称：信息上报数量设置Service
*
*  InforegulationsService的描述：
*
*  @author : 孙意峰
*  @version : V1.0
*/
@IocBean
public class InforegulationsService {
    protected final Logger logger = Logger.getLogger(InforegulationsService.class);

    @Inject
    private Dao dao;

    /**
     * queryInforegulations的中文名称：查询信息上报数量设置列表
     * <p>
     * queryInforegulations的概要说明：
     *
     * @param request Written by : 孙意峰
     */
    public Map queryInforegulationss(HttpServletRequest request, InforeGulationsDTO dto, PagesDTO pd) throws Exception {
        // 页面初始化
        StringBuffer sqlBuffer = new StringBuffer();
        sqlBuffer.append("select id,(SELECT ORGNAME FROM sysorg a where a.ORGID=b.orgid ) orgname,orgid,yearnumber,monthnumber,localdistinction from InforeGulations b");

        if (dto.getOrgid() != null && !"".equals(dto.getOrgid())) {
            sqlBuffer.append(" where orgid = '").append(dto.getOrgid()).append("' "); // 机构名称
        }
        String sql = sqlBuffer.toString();
        // 转化sql语句
        String[] paramName = new String[]{};
        int[] paramType = new int[]{};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, InforeGulationsDTO.class, pd.getPage(), pd.getRows());
        //Map m = DbUtils.DataQueryGrant(GlobalNames.sql, sql, null, InforeGulationsDTO.class, pd.getPage(), pd.getRows(),dto.getUserid(),"aaa027,aae140,orgid");
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * saveCourse的中文名称：保存课程信息
     * <p>
     * saveCourse的概要说明：
     *
     * @param request
     * @param dto
     * @return Written by : zy
     */
    public String saveInforegulations(HttpServletRequest request, InforeGulationsDTO dto) {
        try {
            saveInforegulationsImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveCourseImp的中文名称：保存课程方法实现
     * <p>
     * saveCourseImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception Written by : zy
     */
    @Aop({"trans"})
    public void saveInforegulationsImpl(HttpServletRequest request, InforeGulationsDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间

        // 对课程信息保存
        // 如果id存在，更新
        if (dto.getId() != null && !"".equals(dto.getId())) {
            InforeGulations v_course = dao.fetch(InforeGulations.class, dto.getId());
            v_course.setLocaldistinction(dto.getLocaldistinction());
            v_course.setMonthnumber(dto.getMonthnumber());
            v_course.setYearnumber(dto.getYearnumber());
            v_course.setOrgid(dto.getOrgid());
            v_course.setOrgname(dto.getOrgname());
            dao.update(v_course);
        } else {
            InforeGulations v_info = new InforeGulations();
            v_info.setId(DbUtils.getSequenceStr());
            v_info.setLocaldistinction(dto.getLocaldistinction());
            v_info.setMonthnumber(dto.getMonthnumber());
            v_info.setYearnumber(dto.getYearnumber());
            v_info.setOrgid(dto.getOrgid());
            v_info.setOrgname(dto.getOrgname());
            dao.insert(v_info);
        }


    }


    /**
     * queryCourseObj的中文名称：查询课程信息
     * <p>
     * queryCourseObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception Written by : zy
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    public Map queryInforegulationsObj(HttpServletRequest request, InforeGulationsDTO dto) throws Exception {
        // 课程信息
        InforeGulations courseInfo = dao.fetch(InforeGulations.class, dto.getId());
        Map map = new HashMap();
        map.put("inforegulations", courseInfo); // 课程信息
        return map;
    }


    /**
     * delCourse的中文名称：删除课程信息
     * <p>
     * delCourse的概要说明：
     *
     * @param request
     * @return Written by : zy
     */
    public String delInforegulations(HttpServletRequest request, InforeGulationsDTO dto) {
        try {
            deleteInforegulationsImpl(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }


    @Aop({"trans"})
    public void deleteInforegulationsImpl(HttpServletRequest request, InforeGulationsDTO dto) throws Exception {
        dao.clear(InforeGulations.class, Cnd.where("id", "=", dto.getId()));
    }

}

