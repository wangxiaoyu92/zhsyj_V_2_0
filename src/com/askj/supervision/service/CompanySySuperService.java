package com.askj.supervision.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.spsy.dto.QledgerstockDTO;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * CompanySySuperService的中文名称：企业溯源监管service
 * 
 * CompanySySuperService的描述：
 * 
 * Written by : zy
 */
public class CompanySySuperService {
	protected final Logger logger = Logger.getLogger(CompanySySuperService.class);
	@Inject
	private Dao dao;
	
	/**
	 * 	
	 * queryLedgerstock的中文名称：进货台账
	 * 
	 * queryLedgerstock的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryLedgerstock(QledgerstockDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT stock.qledgerstockid,stock.lgprojydwmc, stock.lgfromcomid, stock.lgprojyrq, stock.lgprojysl, ");
		sb.append(" stock.lgprobzq,stock.lgprobzqdwmc, stock.lgprodqrq, stock.lgproscrq, stock.lgpropc,stock.lgproname, ");
		sb.append(" stock.lgprosptm,stock.lgprosysl,com1.commc, com1.comzzzmbh, com1.comdz, com1.comyddh, com1.comfrhyz, ");
		sb.append(" com2.commc mfcommc ");
        sb.append(" from qledgerstock stock, pcompany com1,  pcompany com2 "); 
        sb.append(" where 1=1 "); 
        sb.append(" and stock.lgfromcomid = com1.comid "); // 卖方公司id
        sb.append(" and stock.lgtocomid = com2.comid"); // 买方公司id
        sb.append(" and com1.commc like :commc "); // 卖方公司名称
        sb.append(" and com2.commc like :mfcommc "); // 买方公司名称
        sb.append(" and stock.lgproname like :lgproname "); // 交易商品名称
        sb.append(" and stock.lgprosptm like :lgprosptm "); // 交易商品条码
        sb.append(" and stock.qledgerstockid = :qledgerstockid "); // 台账表主键
        sb.append(" and stock.lgproid = :lgproid "); // 交易商品id
        sb.append(" and stock.lgtocomid = :lgtocomid "); // 买方公司id
        if (dto.getLgprosysl() != null && "1".equals(dto.getLgprosysl())) {
        	sb.append(" and stock.lgprosysl = 0 "); // 剩余数量为0
        } else if (dto.getLgprosysl() != null && "2".equals(dto.getLgprosysl())) {
        	sb.append(" and stock.lgprosysl > 0 "); // 剩余数量不为0
        }
        sb.append("  order by stock.qledgerstockid asc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "commc", "mfcommc", "lgproname", "lgprosptm", "qledgerstockid", "lgproid", "lgtocomid" };
		int[] ParaType = new int[] {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QledgerstockDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 查询出所有的企业信息，并分页显示
	 *
	 * @param dto企业实体类
	 * @param pd分页
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryCompany(PcompanyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select pcom.comid, pcom.commc, pcom.comdm, pcom.comfrhyz, pcom.comsyqylx ");
		sb.append(" from pcompany pcom, qproduct pro ");
		sb.append(" where 1=1 ");
		sb.append(" and pcom.comid = pro.procomid ");
		sb.append(" and pcom.commc like :commc ");
		sb.append(" and pcom.comfwnfww = :comfwnfww "); // 范围内范围外类型
		sb.append(" GROUP BY pcom.comid ");
		//sb.append(" order by comspaqgly desc ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] { "commc", "comfwnfww" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		System.out.println("===================================" + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcompanyDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}
	
}
