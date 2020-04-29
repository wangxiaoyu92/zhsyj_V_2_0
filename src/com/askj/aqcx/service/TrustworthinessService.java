package com.askj.aqcx.service;

import com.askj.aqcx.dto.DiscreditenterpriseDTO;
import com.askj.aqcx.dto.TrustworthinessDTO;
import com.askj.aqcx.entity.Trustworthiness;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
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
 *  TrustworthinessService的中文名称：人员诚信档案诚信
 *
 *  TrustworthinessService的描述：
 *
 *  Written  by  : wcl
 */
public class TrustworthinessService {

    protected final Logger logger = Logger.getLogger(TrustworthinessService.class);

    @Inject
    private Dao dao;

    /**
     *
     * queryTrustInfos的中文名称：查询人员诚信档案
     *
     * queryTrustInfos的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : wcl
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryTrustInfos(HttpServletRequest request, TrustworthinessDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT p.ryid,ryxm,rymz,ryxb,ryjkqk,rynl,rycsrq,rybyyx,ryjg, ");
        sb.append(" id,cxrecord,starttime,endtime,situation,score,telephone  ");
        sb.append(" FROM pcomry p,trustworthiness t where 1=1 AND p.ryid=t.ryid  ");
        if (dto.getRyname() != null && !"".equals(dto.getRyname())) {
            sb.append(" and p.ryxm like '%").append(dto.getRyname()).append("%' "); // 人员名称
        }
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {};
        int[] paramType = new int[] {};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, TrustworthinessDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }


    /**
     *
     * saveTrust的中文名称：保存人员
     *
     * saveTrust的概要说明：
     *
     * @param request
     * @param dto
     * @return
     *        Written by : wcl
     */
    public String saveTrust(HttpServletRequest request, TrustworthinessDTO dto) {
        try {
            saveTrustImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * saveTrustImp的中文名称：保存人员诚信
     *
     * saveTrustImp的概要说明：
     *
     * @param request
     * @param dto
     * @throws Exception
     *        Written by : wcl
     */
    @Aop( { "trans" })
    public void saveTrustImp(HttpServletRequest request, TrustworthinessDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间

        if (dto.getId() != null && !"".equals(dto.getId())) {
            Trustworthiness trust=dao.fetch(Trustworthiness.class, dto.getId());
            trust.setRyid(dto.getRyid());
            trust.setRyname(dto.getRyname());
            trust.setCxrecord(dto.getCxrecord());
            trust.setStarttime(dto.getStarttime());
            trust.setEndtime(dto.getEndtime());
            trust.setSituation(dto.getSituation());
            trust.setScore(dto.getScore());
            trust.setTelephone(dto.getTelephone());
            dao.update(trust);
        }else{
            Trustworthiness trust=new Trustworthiness();
            trust.setId(DbUtils.getSequenceStr());
            trust.setRyid(dto.getRyid());
            trust.setRyname(dto.getRyname());
            trust.setCxrecord(dto.getCxrecord());
            trust.setStarttime(dto.getStarttime());
            trust.setEndtime(dto.getEndtime());
            trust.setSituation(dto.getSituation());
            trust.setScore(dto.getScore());
            trust.setTelephone(dto.getTelephone());
            dao.insert(trust);

        }

    }


    /**
     *
     * queryTrustObj的中文名称：查询人员诚信
     *
     * queryTrustObj的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     *        Written by : wcl
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryTrustObj(HttpServletRequest request, TrustworthinessDTO dto) throws Exception {
        Trustworthiness trust = dao.fetch(Trustworthiness.class, dto.getId());
        Map map = new HashMap();
        map.put("trust", trust); //人员信息
        return map;
    }

    /**
     *
     * delTrust的中文名称：删除人员诚信管理
     *
     * delTrust的概要说明：
     *
     * @param request
     * @return
     *        Written by : wcl
     */

    public String delTrust(HttpServletRequest request, TrustworthinessDTO dto) {
        try {
            delTrustImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     *
     * delTrustImp的中文名称：删除人员诚信设置
     *
     * delTrustImp 的概要说明：
     *
     * @param request
     * @throws Exception
     *        Written by : wcl
     */
    @Aop({ "trans" })
    public void delTrustImp(HttpServletRequest request, TrustworthinessDTO dto) throws Exception {
        dao.clear(Trustworthiness.class, Cnd.where("id", "=", dto.getId()));
    }
}
