package com.askj.zx.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.zx.dto.ZxParamDTO;
import com.askj.zx.entity.Zxbusinesscode;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

public class BusinessCodeService extends BaseService{
	protected final Logger logger = Logger.getLogger(BusinessCodeService.class);
	@Inject
	private Dao dao;
	/**
	 * 分页查询征信信息
	 * @param dto
	 * @param pd
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryBusinessAllInfo(Zxbusinesscode dto,PagesDTO pd){
		Cnd c = null;
		c = Cnd.where("1", "=", "1");
		//c.and("lower(bccode)", "=", dto.getBccode().toLowerCase());

		
		Map map = new HashMap();
		map.put("rows", dao.query(Zxbusinesscode.class, c, SysmanageUtil.getPager(pd)));
		map.put("total", dao.count(Zxbusinesscode.class, c));
		return map;
	}
	
	/**
	 * @TODO:查询业务树
	 * @author: zhaichunlei
	 & @DATE : 2016年1月26日
	 * @param curNodeCode
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<ZxParamDTO> queryBusinessCode(String curNodeCode) throws Exception{
		List<ZxParamDTO> list = null;
		StringBuffer sb = new StringBuffer();
		if(curNodeCode == null || curNodeCode.length() == 0 || "0".equals(curNodeCode)){
			sb.append(" SELECT  z.bcId,z.bcCode,z.bcName,z.bcLevel,z.bcPublicity,z.bcTreeCode,z.bcEnable,z.bcParentCode, ");
			sb.append("  IFNULL(a.num,0) num, IF(a.num > 0,'true','false') parent  ");
			sb.append("  FROM zxbusinesscode z LEFT join ");
			sb.append("  (SELECT bcparentcode, COUNT(bccode) num FROM zxbusinesscode  GROUP BY bcParentCode ) a ");
			sb.append("  ON z.bcCode=a.bcParentCode ");
			sb.append(" WHERE  z.bcParentCode is null ");
		}
		else{
			sb.append(" SELECT  z.bcId,z.bcCode,z.bcName,z.bcLevel,z.bcPublicity,z.bcTreeCode,z.bcEnable,z.bcParentCode, ");
			sb.append("  IFNULL(a.num,0) num, IF(a.num > 0,'true','false') parent  ");
			sb.append("  FROM zxbusinesscode z LEFT join ");
			sb.append("  (SELECT bcparentcode, COUNT(bccode) num FROM zxbusinesscode  GROUP BY bcParentCode ) a  ");
			sb.append("  ON z.bcCode=a.bcParentCode ");
			sb.append(" WHERE  z.bcParentCode='"+curNodeCode+"' ");
		}
		
		 
		Map<String,List<ZxParamDTO>> m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null,
				ZxParamDTO.class);
		list = m.get(GlobalNames.SI_RESULTSET);
		
		return list;
	}
	
	/**
	 * @TODO: 查询业务参数数据列表
	 * @author: zhaichunlei
	 & @DATE : 2016年1月27日
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<Object,Object>  queryBusinessCodeList(final ZxParamDTO dto, PagesDTO pd) throws Exception{
		//List<ZxParamDto> list = null;
		//String subsys   = dto.getBpcodesubsys();
		//String business = dto.getBpcodebusiness();
		//String item      = dto.getBpcodeitem();
		//String codeLevel = dto.getBpcodeitem();
		
		String level      =  dto.getLevel(); //节点级别
		String curNode = dto.getBccode();
		String treeCode = dto.getBctreecode();
		
		StringBuffer sb = new StringBuffer();
		//查询根节点若为-1，查询所有参数
		if(curNode == null || "-1".equals(curNode) || "0".equals(curNode)){
			sb.append("SELECT  a.bcId,a.bcCode,a.bcName,a.bcParentCode,a.bcLevel,a.bcPublicity,a.bcTreeCode,");
			sb.append(" z.bpCodeSubSys,z.bpCodeBusiness,z.bpCodeItem,z.bpCodeLevel,");
			sb.append("z.bpId,z.bpScore,z.bpRatio,z.bpYear,z.bpDateBegin,z.bpDateEnd,z.logId ");
			sb.append(" from zxbusinesscode a LEFT JOIN zxbusinesspara z ON a.bcId=z.bcid  ");
			sb.append("WHERE 1=1 ");
			sb.append(" AND z.bpCodeSubSys=:bpcodesubsys AND z.bpCodeBusiness=:bpcodebusiness "); 
			sb.append(" AND z.bpCodeItem=:bpcodeitem AND z.bpCodeLevel=:bpcodelevel ");
		}
		else{
			String tc = "";
			if(level == null || treeCode == null){
				//throw new Exception("查询参数错误");
			}
			else if(level != null && treeCode != null){
				tc = treeCode.substring((Integer.parseInt(level) - 1) * 2,2);
			}
			
			sb.append("SELECT  a.bcId,a.bcCode,a.bcName,a.bcParentCode,a.bcLevel,a.bcPublicity,a.bcTreeCode,");
			sb.append(" z.bpCodeSubSys,z.bpCodeBusiness,z.bpCodeItem,z.bpCodeLevel,");
			sb.append("z.bpId,z.bpScore,z.bpRatio,z.bpYear,z.bpDateBegin,z.bpDateEnd,z.logId ");
			sb.append(" from zxbusinesscode a LEFT JOIN zxbusinesspara z ON a.bcId=z.bcid  ");
			sb.append("WHERE 1=1    ");
			if(tc.length() > 0){
				sb.append(" AND a.bcTreeCode LIKE '"+tc+"%' ");
			}
			sb.append(" AND z.bpCodeSubSys=:bpcodesubsys AND z.bpCodeBusiness=:bpcodebusiness "); 
			sb.append(" AND z.bpCodeItem=:bpcodeitem AND z.bpCodeLevel=:bpcodelevel ");
		}
		
		
		String[] ParaName = new String[] { "bpcodesubsys", "bpcodebusiness", "bpcodeitem","bpcodelevel"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		String sql = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map<Object,Object> m=DbUtils.DataQuery(GlobalNames.sql, sql, null, ZxParamDTO.class,  pd.getPage(),pd.getRows());
		List<ZxParamDTO> ls = (List<ZxParamDTO>) m.get(GlobalNames.SI_RESULTSET);
		Map<Object,Object> map=new HashMap<Object,Object>();
		map.put("rows", ls);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		 
		return map;
	}
}
