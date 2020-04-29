package com.askj.aqcx.service;

import com.askj.aqcx.dto.DiscreditenterpriseDTO;
import com.askj.aqcx.entity.Discreditenterprise;
import com.askj.train.dto.OtsCourseDTO;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 *  DiscreditenterpriseService的中文名称：企业诚信
 *
 *  DiscreditenterpriseService的描述：
 *
 *  Written  by  : wcl
 */

public class DiscreditenterpriseService extends BaseService {
    protected final Logger logger = Logger.getLogger(DiscreditenterpriseService.class);

    @Inject
    private Dao dao;

    /**
     *
     * queryDiscreditenter的中文名称：查询课程列表
     *
     * queryDiscreditenter的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryDiscreditenterInfos(HttpServletRequest request, DiscreditenterpriseDTO dto, PagesDTO pd) throws Exception {
        // 使用字符串缓冲器类拼接查询语句
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT * FROM discreditenterprise a");
        sb.append(" where 1=1 ");
        if (dto.getComname() != null && !"".equals(dto.getComname())) {
            sb.append(" and a.comname like '%").append(dto.getComname()).append("%' "); // 企业名称
        }
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {};
        int[] paramType = new int[] {};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, DiscreditenterpriseDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     *
     * saveDiscred的中文名称：保存失信企业
     *
     * saveDiscred的概要说明：
     *
     * @param request
     * @param dto
     * @return
     *        Written by : wcl
     */

    public String saveDiscred(HttpServletRequest request, DiscreditenterpriseDTO dto) {
        try {
            saveDiscredImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * saveDiscredImp的中文名称：保存失信企业
     *
     * saveDiscredImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception
     *        Written by : wcl
     */
    @Aop( { "trans" })
    public void saveDiscredImp(HttpServletRequest request, DiscreditenterpriseDTO dto) throws Exception {

        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
        // 对失信企业保存
        if (dto.getId() != null && !"".equals(dto.getId())) {
            Discreditenterprise discred=dao.fetch(Discreditenterprise.class, dto.getId());
            discred.setComid(dto.getComid());
            discred.setComname(dto.getComname());
            discred.setType(dto.getType());
            discred.setSerialnumber(dto.getSerialnumber());
            discred.setCategory(dto.getCategory());
            discred.setReason(dto.getReason());
            discred.setEnrolrq(dto.getEnrolrq());
            discred.setIncludery(dto.getIncludery());
            discred.setRemoval(dto.getRemoval());
            discred.setMoverq(dto.getMoverq());
            discred.setRemovery(dto.getRemovery());
            dao.update(discred);
        }else {
            Discreditenterprise discred=new Discreditenterprise();
            discred.setId(DbUtils.getSequenceStr());
            discred.setComid(dto.getComid());
            discred.setComname(dto.getComname());
            discred.setType(dto.getType());
            discred.setSerialnumber(dto.getSerialnumber());
            discred.setCategory(dto.getCategory());
            discred.setReason(dto.getReason());
            discred.setEnrolrq(dto.getEnrolrq());
            discred.setIncludery(dto.getIncludery());
            discred.setRemoval(dto.getRemoval());
            discred.setMoverq(dto.getMoverq());
            discred.setRemovery(dto.getRemovery());
            dao.insert(discred);
        }

    }


    /**
     *
     * queryDiscredObj的中文名称：查询企业安全诚信
     *
     * queryDiscredObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     *        Written by : wcl
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryDiscredObj(HttpServletRequest request, DiscreditenterpriseDTO dto) throws Exception {
        Discreditenterprise discred = dao.fetch(Discreditenterprise.class, dto.getId());
        Map map = new HashMap();
        map.put("discredInfo", discred); // 课程信息
        return map;
    }


    /**
     *
     * delDiscred的中文名称：删除企业诚信管理
     *
     * delDiscred的概要说明：
     *
     * @param request
     * @return
     *        Written by : wcl
     */
    public String delDiscred(HttpServletRequest request, DiscreditenterpriseDTO dto) {
        try {
            delDiscredImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }


    /**
     *
     * delDiscredImp的中文名称：删除企业安全诚信设置
     *
     * delDiscredImp 的概要说明：
     *
     * @param request
     * @throws Exception
     *        Written by : wcl
     */
    @Aop({ "trans" })
    public void delDiscredImp(HttpServletRequest request, DiscreditenterpriseDTO dto) throws Exception {
        dao.clear(Discreditenterprise.class, Cnd.where("id", "=", dto.getId()));
    }


}
