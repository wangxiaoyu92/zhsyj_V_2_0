package com.askj.supervision.service;

import com.askj.supervision.dto.AreaConditionDTO;
import com.askj.supervision.entity.AreaCondition;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.service.BaseService;
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
 * AreaConditionService的中文名称：区域情况表
 * Created by ce on 2018/5/12.
 */
public class AreaConditionService extends BaseService {
    protected final Logger logger = Logger.getLogger(AreaConditionService.class);

    @Inject
    private Dao dao;

    public Map queryAreaCondition(AreaConditionDTO dto, PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.* ");
        sb.append(" from areacondition a ");
        sb.append(" where 1=1 ");
        sb.append("  and aaa027 like :aaa027");
        sb.append(" order by a.aaa027 desc ");
        String sql = sb.toString();
        String[] ParaName = new String[] {"aaa027"};
        int[] ParaType = new int[] {Types.VARCHAR};
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AreaConditionDTO.class,
                pd.getPage(), pd.getRows());
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        Map r = new HashMap();
        r.put("rows", ls);
        r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
        return r;
    }

    public String saveAreaCondition(HttpServletRequest request, AreaConditionDTO dto) {
        try {
            saveAreaConditionImp(request, dto);
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({ "trans" })
    public void saveAreaConditionImp(HttpServletRequest request, AreaConditionDTO dto)
            throws Exception {
        if (null == dto.getAdd()||"".equals(dto.getAdd())) {
            //修改
            AreaCondition se = dao.fetch(AreaCondition.class, dto.getAaa027());
            se.setAaa027(dto.getAaa027());
            se.setText(dto.getText());
            se.setJdzb(dto.getJdzb());
            se.setWdzb(dto.getWdzb());
            dao.update(se);
        } else {
            AreaCondition ac = dao.fetch(AreaCondition.class, dto.getAaa027());
            if(ac==null){
                AreaCondition se = new AreaCondition();
                BeanHelper.copyProperties(dto, se);
                dao.insert(se);
            }else{
                ac.setAaa027(dto.getAaa027());
                ac.setText(dto.getText());
                ac.setJdzb(dto.getJdzb());
                ac.setWdzb(dto.getWdzb());
                dao.update(ac);
            }

        }
    }

    public Object findAreaCondition(HttpServletRequest request, AreaConditionDTO dto)
            throws Exception {
        // TODO Auto-generated method stub
        StringBuffer sb = new StringBuffer();
        sb.append(" select a.*,b.aaa129 aaa027name from ");
        sb.append(" areacondition a ");
        sb.append(" left join aa13 b on a.aaa027=b.aaa027 ");
        sb.append("  where 1=1 ");
        sb.append("  and a.aaa027 = :aaa027");
        String sql = sb.toString();
        String[] ParaName = new String[] { "aaa027" };
        int[] ParaType = new int[] { Types.VARCHAR };
        sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, AreaConditionDTO.class);
        List ls = (List) m.get(GlobalNames.SI_RESULTSET);
        AreaConditionDTO pdto = new AreaConditionDTO();
        if (ls!=null && ls.size()>0) {
            pdto = (AreaConditionDTO)ls.get(0);
        }
        return pdto;
    }

    public String delAreaCondition(HttpServletRequest request, AreaConditionDTO dto) {
        try {
            if (null != dto.getAaa027()) {
                delAreaConditionImp(request, dto);
            } else {
                return "没有接收到要删除的区域情况！";
            }
        } catch (Exception e) {
            return Lang.wrapThrow(e).getMessage();
        }
        return null;
    }

    @Aop({ "trans" })
    public void delAreaConditionImp(HttpServletRequest request, AreaConditionDTO dto) {
        // 删除案件登记
        dao.clear(AreaCondition.class, Cnd.where("aaa027", "=", dto.getAaa027()));
    }
}
