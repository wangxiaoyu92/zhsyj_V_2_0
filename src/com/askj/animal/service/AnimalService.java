package com.askj.animal.service;

import com.askj.animal.dto.AnimaldeathDTO;
import com.askj.animal.dto.AnimalfenceDTO;
import com.askj.animal.dto.AnimalhouseDTO;
import com.askj.animal.dto.AnimalinfoDTO;
import com.askj.animal.entity.Animaldeath;
import com.askj.animal.entity.Animalfence;
import com.askj.animal.entity.Animalhouse;
import com.askj.animal.entity.Animalinfo;
import com.lbs.leaf.util.BeanHelper;
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
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 *  AnimalService的中文名称：动物管理
 *
 *  AnimalService的描述：
 *
 *  Written  by  : zk
 */
public class AnimalService {
    protected final Logger logger = Logger.getLogger(AnimalService.class);

    @Inject
    private Dao dao;

    /**
     * queryAnimalinfo的中文名称：动物信息列表查询
     * <p>
     * queryAnimalinfo的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryAnimalinfo(HttpServletRequest request, AnimalinfoDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.animalinfoid, a.fenceid,a.animalno,a.sex,a.haircolor,a.culturestyle,a.weaningweight,a.deathweight,a.fatherid,");
        sb.append(" a.fatherno, a.motherid,a.motherno,a.inputtype,a.identificationcode,a.equipmenttype,");
        sb.append(" DATE_FORMAT(birthday,'%Y-%m-%d %H:%i:%S') birthday,DATE_FORMAT(weaningdate,'%Y-%m-%d %H:%i:%S') weaningdate,DATE_FORMAT(deathdate,'%Y-%m-%d %H:%i:%S') deathdate,");
        sb.append(" (select b.fencename from animalfence b where a.fenceid=b.animalfenceid) fencename");
        sb.append(" FROM animalinfo a where 1=1 ");
        sb.append(" and animalno like:animalno ");
        sb.append(" and fenceid =:fenceid ");
        sb.append(" order by birthday desc ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {"animalno","fenceid"};
        int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AnimalinfoDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryAnimaldeath的中文名称：动物死亡信息列表查询
     * <p>
     * queryAnimaldeath的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryAnimaldeath(HttpServletRequest request, AnimaldeathDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.animaldeathid,a.animalinfoid,a.deathweight,a.deathreason,a.treatmentmode,a.symptom, ");
        sb.append(" (select b.animalno from animalinfo b where a.animalinfoid=b.animalinfoid) animalinfono, ");
        sb.append(" DATE_FORMAT(a.deathdate,'%Y-%m-%d %H:%i:%S') deathdate ");
        sb.append(" FROM animaldeath a  ");
        sb.append(" where 1=1 ");
        sb.append("and a.animalinfoid =:animalinfoid");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {"animalinfoid"};
        int[] paramType = new int[] {Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,  AnimaldeathDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * queryAnimalfence的中文名称：动物栅栏信息列表查询
     * <p>
     * queryAnimalfence的概要说明：
     *
     * @param request
     * @param dto
     * @param pd
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryAnimalfence(HttpServletRequest request, AnimalfenceDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.* ");
        sb.append(" FROM animalfence a  ");
        sb.append(" where 1=1 ");
        sb.append(" and a.houseid = :houseid ");
        sb.append(" and a.fenceno like :fenceno ");
        sb.append(" and a.fencename like :fencename ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {"houseid","fenceno","fencename"};
        int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,  AnimalfenceDTO.class, pd.getPage(), pd.getRows());
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return map;
    }

    /**
     * saveAnimalinfo的中文名称：动物信息保存
     * <p>
     * saveAnimalinfo的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public String saveAnimalinfo(HttpServletRequest request, AnimalinfoDTO dto) {
        try {
            saveAnimalinfoImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveAnimaldeath的中文名称：动物死亡信息保存
     * <p>
     * saveAnimaldeath的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public String saveAnimaldeath(HttpServletRequest request, AnimaldeathDTO dto) {
        try {
            saveAnimaldeathImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveAnimalhouse的中文名称：动物舍所信息保存
     * <p>
     * saveAnimalhouse的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public String saveAnimalhouse(HttpServletRequest request, AnimalhouseDTO dto) {
        try {
            saveAnimalhouseImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveAnimalfence的中文名称：动物栅栏信息保存
     * <p>
     * saveAnimalfence的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public String saveAnimalfence(HttpServletRequest request, AnimalfenceDTO dto) {
        try {
            saveAnimalfenceImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * saveAnimalfenceImp的中文名称：动物栅栏信息保存
     * <p>
     * saveAnimalfenceImp的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop( { "trans" })
    public void saveAnimalfenceImp(HttpServletRequest request, AnimalfenceDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间
        if (dto.getAnimalfenceid() != null && !"".equals(dto.getAnimalfenceid())) {
            Animalfence trust=dao.fetch(Animalfence.class, dto.getAnimalfenceid());
            BeanHelper.copyProperties(dto, trust);
            trust.setAae011(vSysUser.getUsername());
            trust.setAae036(v_dbDatetime);
            dao.update(trust);
        }else{
            Animalfence trust=new Animalfence();
            BeanHelper.copyProperties(dto, trust);
            trust.setAnimalfenceid(DbUtils.getSequenceStr());
            trust.setAae011(vSysUser.getUsername());
            trust.setAae036(v_dbDatetime);
            dao.insert(trust);
        }
    }

    /**
     * saveAnimaldeathImp的中文名称：动物死亡信息保存
     * <p>
     * saveAnimaldeathImp的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop( { "trans" })
    public void saveAnimaldeathImp(HttpServletRequest request, AnimaldeathDTO dto) throws Exception {

        if (dto.getAnimaldeathid() != null && !"".equals(dto.getAnimaldeathid())) {
            Animaldeath trust=dao.fetch(Animaldeath.class, dto.getAnimaldeathid());
            BeanHelper.copyProperties(dto, trust);
            dao.update(trust);
        }else{
            Animaldeath trust=new Animaldeath();
            BeanHelper.copyProperties(dto, trust);
            trust.setAnimaldeathid(DbUtils.getSequenceStr());
            dao.insert(trust);
        }
    }

    /**
     * saveAnimalinfoImp的中文名称：动物信息保存
     * <p>
     * saveAnimalinfoImp的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop( { "trans" })
    public void saveAnimalinfoImp(HttpServletRequest request, AnimalinfoDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间

        if (dto.getAnimalinfoid() != null && !"".equals(dto.getAnimalinfoid())) {
            Animalinfo trust=dao.fetch(Animalinfo.class, dto.getAnimalinfoid());
            BeanHelper.copyProperties(dto, trust);
            if("".equals(dto.getDeathdate())){
                trust.setDeathdate(null);
            }
            if("".equals(dto.getDeathweight())){
                trust.setDeathweight(null);
            }
            if("".equals(dto.getWeaningdate())){
                trust.setWeaningdate(null);
            }
            if("".equals(dto.getWeaningweight())){
                trust.setWeaningweight(null);
            }
            trust.setAae011(vSysUser.getUsername());
            trust.setAae036(v_dbDatetime);
            dao.update(trust);
        }else{
            Animalinfo trust=new Animalinfo();
            BeanHelper.copyProperties(dto, trust);
            trust.setAnimalinfoid(DbUtils.getSequenceStr());
            trust.setInputtype("0");
            if("".equals(dto.getDeathdate())){
                trust.setDeathdate(null);
            }
            if("".equals(dto.getDeathweight())){
                trust.setDeathweight(null);
            }
            if("".equals(dto.getWeaningdate())){
                trust.setWeaningdate(null);
            }
            if("".equals(dto.getWeaningweight())){
                trust.setWeaningweight(null);
            }
            trust.setAae011(vSysUser.getUsername());
            trust.setAae036(v_dbDatetime);
            dao.insert(trust);
        }
    }

    /**
     * saveAnimalhouseImp的中文名称：动物舍所信息保存
     * <p>
     * saveAnimalhouseImp的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop( { "trans" })
    public void  saveAnimalhouseImp(HttpServletRequest request, AnimalhouseDTO dto) throws Exception {
        Sysuser vSysUser = SysmanageUtil.getSysuser(); // 获取当前用户
        String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns(); // 获取当前时间

        if (dto.getAnimalhouseid() != null && !"".equals(dto.getAnimalhouseid())) {
            Animalhouse trust=dao.fetch(Animalhouse.class, dto.getAnimalhouseid());
            BeanHelper.copyProperties(dto, trust);
            trust.setAae011(vSysUser.getUsername());
            trust.setAae036(v_dbDatetime);
            dao.update(trust);
        }else{
            Animalhouse trust=new Animalhouse();
            BeanHelper.copyProperties(dto, trust);
            trust.setAnimalhouseid(DbUtils.getSequenceStr());
            trust.setAae011(vSysUser.getUsername());
            trust.setAae036(v_dbDatetime);
            dao.insert(trust);
        }
    }

    /**
     * queryAnimalinfoDTO的中文名称：动物信息查询
     * <p>
     * queryAnimalinfoDTO的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryAnimalinfoDTO(HttpServletRequest request, AnimalinfoDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.animalinfoid, a.fenceid,a.animalno,a.sex,a.haircolor,a.culturestyle,a.weaningweight,a.deathweight,a.fatherid,");
        sb.append(" a.fatherno, a.motherid,a.motherno,a.inputtype,a.identificationcode,a.equipmenttype,");
        sb.append(" DATE_FORMAT(birthday,'%Y-%m-%d %H:%i:%S') birthday,DATE_FORMAT(weaningdate,'%Y-%m-%d %H:%i:%S') weaningdate,DATE_FORMAT(deathdate,'%Y-%m-%d %H:%i:%S') deathdate,");
        sb.append(" (select b.fencename from animalfence b where a.fenceid=b.animalfenceid) fencename");
        sb.append(" FROM animalinfo a where 1=1 ");
        sb.append("  and a.animalinfoid = :animalinfoid ");
        sb.append("  and a.animalno = :animalno ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] { "animalinfoid","animalno"};
        int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AnimalinfoDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        return map;
    }

    /**
     * queryAnimaldeathDTO的中文名称：动物死亡信息查询
     * <p>
     * queryAnimaldeathDTO的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryAnimaldeathDTO(HttpServletRequest request, AnimaldeathDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.* ,");
        sb.append("(select b.animalno from animalinfo b where b.animalinfoid = a.animalinfoid ) animalinfono");
        sb.append(" FROM animaldeath a where 1=1 ");
        sb.append("  and a.animaldeathid = :animaldeathid ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] { "animaldeathid"};
        int[] paramType = new int[] {Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AnimaldeathDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        return map;
    }

    /**
     * queryAnimalfenceDTO的中文名称：动物栅栏信息查询
     * <p>
     * queryAnimalfenceDTO的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryAnimalfenceDTO(HttpServletRequest request, AnimalfenceDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.*, ");
        sb.append(" (select b.housename from animalhouse b where b.animalhouseid = a.houseid) housename ");
        sb.append(" FROM animalfence a where 1=1 ");

        sb.append("  and a.animalfenceid = :animalfenceid ");
        sb.append("  and a.fenceno = :fenceno ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] { "animalfenceid","fenceno"};
        int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AnimalfenceDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        return map;
    }

    /**
     * queryAnimalhouseDTO的中文名称：动物舍所信息查询
     * <p>
     * queryAnimalhouseDTO的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map queryAnimalhouseDTO(HttpServletRequest request, AnimalhouseDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.*");
        sb.append(" FROM animalhouse a where 1=1 ");
        sb.append("  and a.houseno = :houseno ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] { "houseno"};
        int[] paramType = new int[] {Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AnimalhouseDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        Map map = new HashMap();
        map.put("rows", list);
        return map;
    }

    /**
     * queryAnimalZTreeAsync的中文名称：动物舍所信息分类树
     * <p>
     * queryAnimalZTreeAsync的概要说明：
     *
     * @param request
     * @return
     * @throws Exception
     * @author : zk
     */
    public List queryAnimalZTreeAsync(HttpServletRequest request) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,(select count(b.animalhouseid) from animalhouse b where b.parenthouseid=a.animalhouseid) childnum,");
        sb.append(" (select c.housename from animalhouse c where a.parenthouseid=c.animalhouseid) parentname,");
        sb.append(" (select orgname from sysorg d where d.orgid=a.orgid ) orgname");
        sb.append(" from animalhouse a ");
        sb.append("  where 1=1 ");
        Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, AnimalhouseDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        return ls;
    }

    /**
     * delAnimaldeath的中文名称：动物死亡信息删除
     * <p>
     * delAnimaldeath的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public String delAnimaldeath(HttpServletRequest request,AnimaldeathDTO dto) {
        try {
            if (null != dto.getAnimaldeathid()) {
                delAnimaldeathImp(request, dto);
            } else {
                return "没有接收到要删除的动物死亡信息ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    /**
     * delAnimaldeathImp的中文名称：动物死亡信息删除
     * <p>
     * delAnimaldeathImp的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    @Aop({ "trans" })
    public void delAnimaldeathImp(HttpServletRequest request, AnimaldeathDTO dto) {
        // 删除动物死亡信息
        dao.clear(Animaldeath.class, Cnd.where("animaldeathid", "=", dto.getAnimaldeathid()));
    }

    /**
     * delAnimalinfo的中文名称：动物信息删除
     * <p>
     * delAnimalinfo的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public String delAnimalinfo(HttpServletRequest request,AnimalinfoDTO dto) {
        try {
            if (null != dto.getAnimalinfoid()) {
                delAnimalinfoImp(request, dto);
            } else {
                return "没有接收到要删除的动物信息ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({ "trans" })
    public void delAnimalinfoImp(HttpServletRequest request, AnimalinfoDTO dto) {
        // 删除动物信息
        dao.clear(Animalinfo.class, Cnd.where("animalinfoid", "=", dto.getAnimalinfoid()));
        // 删除动物死亡信息
        dao.clear(Animaldeath.class, Cnd.where("animalinfoid", "=", dto.getAnimalinfoid()));
    }

    /**
     * delAnimalfence的中文名称：动物栅栏信息删除
     * <p>
     * delAnimalfence的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public String delAnimalfence(HttpServletRequest request,AnimalfenceDTO dto) {
        try {
            if (null != dto.getAnimalfenceid()) {
                delAnimalfenceImp(request, dto);
            } else {
                return "没有接收到要删除的动物栅栏信息ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }


    @Aop({ "trans" })
    public void delAnimalfenceImp(HttpServletRequest request, AnimalfenceDTO dto) throws Exception{
        // 删除动物栅栏信息
        dao.clear(Animalfence.class, Cnd.where("animalfenceid", "=", dto.getAnimalfenceid()));
        AnimalinfoDTO animalinfoDto=new AnimalinfoDTO();
        animalinfoDto.setFenceid(dto.getAnimalfenceid());
        List list1=(List)queryAnimalList(animalinfoDto);
        if (list1 != null && list1.size() > 0) {
            for(int i=0;i<list1.size();i++){
                animalinfoDto = (AnimalinfoDTO) list1.get(i);
                // 删除动物信息
                dao.clear(Animalinfo.class, Cnd.where("animalinfoid", "=", animalinfoDto.getAnimalinfoid()));
                // 删除动物死亡信息
                dao.clear(Animaldeath.class, Cnd.where("animalinfoid", "=", animalinfoDto.getAnimalinfoid()));
            }
        }
    }

    /**
     * delAnimalhouse的中文名称：动物舍所信息删除
     * <p>
     * delAnimalhouse的概要说明：
     *
     * @param request
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public String delAnimalhouse(HttpServletRequest request,AnimalhouseDTO dto) {
        try {
            if (null != dto.getAnimalhouseid()) {
                delAnimalhouseImp(request, dto);
            } else {
                return "没有接收到要删除的动物舍所信息ID！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({ "trans" })
    public void delAnimalhouseImp(HttpServletRequest request, AnimalhouseDTO dto) throws Exception{
        // 删除动物舍所信息
        dao.clear(Animalhouse.class, Cnd.where("animalhouseid", "=", dto.getAnimalhouseid()));
        // 删除下面的动物舍所信息
        dao.clear(Animalhouse.class, Cnd.where("parenthouseid", "=", dto.getAnimalhouseid()));
        AnimalfenceDTO animalfenceDto=new AnimalfenceDTO();
        animalfenceDto.setHouseid(dto.getAnimalhouseid());
        List list1=queryAnimalfenceList(animalfenceDto);
        if (list1 != null && list1.size() > 0) {
            for(int i=0;i<list1.size();i++){
                animalfenceDto = (AnimalfenceDTO) list1.get(i);
                delAnimalfenceImp(request,animalfenceDto);
            }
        }
        AnimalhouseDTO animalhouseDto=new AnimalhouseDTO();
        animalhouseDto.setParenthouseid(dto.getAnimalhouseid());
        List list2=queryAnimalhouseList(animalhouseDto);
        if (list2 != null && list2.size() > 0) {
            for(int i=0;i<list2.size();i++){
                animalhouseDto = (AnimalhouseDTO) list2.get(i);
                AnimalfenceDTO animalfence=new AnimalfenceDTO();
                animalfence.setHouseid(animalhouseDto.getAnimalhouseid());
                List list3=queryAnimalfenceList(animalfence);
                if (list3 != null && list3.size() > 0) {
                    for(int j=0;j<list1.size();j++){
                        animalfence = (AnimalfenceDTO) list1.get(j);
                        delAnimalfenceImp(request,animalfence);
                    }
                }
            }
        }


    }

    /**
     * queryAnimalList的中文名称：动物信息列表
     * <p>
     * queryAnimalList的概要说明：
     *
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public List queryAnimalList(AnimalinfoDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.animalinfoid");
        sb.append(" FROM animalinfo a where 1=1 ");
        sb.append(" and fenceid =:fenceid ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {"fenceid"};
        int[] paramType = new int[] {Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AnimalinfoDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        return list;
    }

    /**
     * queryAnimalfenceList的中文名称：动物栅栏信息列表
     * <p>
     * queryAnimalfenceList的概要说明：
     *
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public List queryAnimalfenceList(AnimalfenceDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.animalfenceid");
        sb.append(" FROM animalfence a where 1=1 ");
        sb.append(" and houseid =:houseid ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {"houseid"};
        int[] paramType = new int[] {Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AnimalfenceDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        return list;
    }

    /**
     * queryAnimalhouseList的中文名称：动物舍所信息列表
     * <p>
     * queryAnimalhouseList的概要说明：
     *
     * @param dto
     * @return
     * @throws Exception
     * @author : zk
     */
    public List queryAnimalhouseList(AnimalhouseDTO dto) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" SELECT a.animalhouseid");
        sb.append(" FROM animalhouse a where 1=1 ");
        sb.append(" and a.parenthouseid =:animalhouseid ");
        String sql = sb.toString();
        // 转化sql语句
        String[] paramName = new String[] {"animalhouseid"};
        int[] paramType = new int[] {Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AnimalhouseDTO.class);
        List list = (List) m.get(GlobalNames.SI_RESULTSET);
        return list;
    }

}
