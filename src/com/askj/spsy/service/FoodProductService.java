package com.askj.spsy.service;

import com.alibaba.druid.util.StringUtils;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.environment.entity.EnvAirInfo;
import com.askj.environment.entity.EnvSoilInfo;
import com.askj.environment.entity.EnvWalterInfo;
import com.askj.spsy.dto.*;
import com.askj.spsy.entity.*;
import com.lbs.leaf.ExportedExcelDataInfo;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.lbs.leaf.util.ExcelUtil;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.ExcelServlet;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.log4j.Logger;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 
 * FoodProductService的中文名称：食品加工溯源service
 * 
 * FoodProductService的描述：
 * 
 * Written by : zy
 */
public class FoodProductService extends BaseService {
	protected final Logger logger = Logger.getLogger(FoodProductService.class);
	@Inject
	private Dao dao;
	
	private ExcelServlet v_ExcelServlet=new ExcelServlet();
	
	/**
	 * 
	 * queryComList的中文名称：查询客户关系list
	 * 
	 * queryComList的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryComList(QcompanygxDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT gx.comgxlx, gx.comgxtime, gx.csid, gx.cominoutlx, gx.gxid, ");
		sb.append(" cscom.comdalei, cscom.comdz, cscom.comfrhyz, cscom.commc, cscom.comyddh, dqcom.commc dqcommc, ");
		sb.append(" pro.probzgg, pro.progg, pro.proname, pro.prozl, dqpro.proname dqproname, dqpro.cphyclbz dqcphyclbz ");
        sb.append(" from qcompanygx gx, pcompany cscom, pcompany dqcom, qproduct pro, qproduct dqpro "); 
        sb.append(" where 1=1 "); 
        sb.append(" and gx.csid = cscom.comid "); // 客户公司
        sb.append(" and gx.comid = dqcom.comid "); // 当前公司
        sb.append(" and gx.csproid = pro.proid "); // 客户商品
        sb.append(" and gx.cphyclid = dqpro.proid "); // 当前企业商品或原材料
        sb.append(" and gx.comid = '").append(vSysUser.getAaz001()).append("'");
        sb.append(" and cscom.commc like :commc ");
        sb.append(" and gx.comgxlx =:comgxlx ");
        sb.append(" and cscom.comdalei =:comdalei ");
        sb.append(" and pro.proname like :proname ");
        sb.append("  order by gx.csid asc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "commc", "comgxlx", "comdalei", "proname"};
		int[] ParaType = new int[] {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QcompanygxDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}	
	
	/**
	 * 
	 * addComProducts的中文名称：新增客户关系对应产品信息
	 * 
	 * addComProducts的概要说明：
	 * 
	 * @param request
	 * @return Written by : zy
	 * 
	 */
	public String addComProducts(HttpServletRequest request) {
		try {
			addComProductsImp(request);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void addComProductsImp(HttpServletRequest request)
			throws Exception {
		// 获取当前公司id
		String comid = StringHelper.showNull2Empty(request.getParameter("comid"));
		// 获取产品或原材料id
		String cphyclid = StringHelper.showNull2Empty(request.getParameter("cphyclid"));
		// 获取当前公司供销类型1:供货商；2:销货商
		String comgxlx = StringHelper.showNull2Empty(request.getParameter("comgxlx"));
		// 获取当前时间
		String currentTime = SysmanageUtil.getDbtimeYmdHns();
		// 获取添加商品
		String JsonStr = request.getParameter("JsonStr");
		List<QproductDTO> proList = Json.fromJsonAsList(QproductDTO.class, JsonStr);
		for (int i = 0; i < proList.size(); i++) {
			QproductDTO product = (QproductDTO) proList.get(i);
			// 判断客户商品是否在关系表里，避免重复添加
			Qcompanygx se = checkComProductIsInGx(comid, product.getProcomid(), product.getProid());
			if ((se == null) || !(comgxlx.equals(se.getComgxlx()))) {
				String v_id = DbUtils.getSequenceStr();
				se = new Qcompanygx();
				se.setGxid(v_id); // 关系id
				se.setComgxlx(comgxlx); // 公司供销关系
				se.setComgxtime(currentTime); // 客户关系建立时间
				se.setComid(comid); // 企业id
				se.setCominoutlx("1"); // 公司系统内外类型. 1:系统内（默认）；2系统外
				se.setCsid(product.getProcomid()); // 客户id
				se.setCsproid(product.getProid()); // 客户商品id
				se.setCphyclid(cphyclid);
				dao.insert(se);
			}
		}
	}
		
	/**
	 * 
	 * checkComProductIsInGx的中文名称：判断该企业商品是否在客户关系表里
	 * 
	 * checkComProductIsInGx的概要说明：
	 * @param comid
	 * @param csid
	 * @param proid
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	public Qcompanygx checkComProductIsInGx(String comid, String csid, String proid)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append("  from qcompanygx a ");
		sb.append(" where 1 = 1 ");
		sb.append(" and comid = '").append(comid).append("' ");
		sb.append(" and csid = '").append(csid).append("' ");
		sb.append(" and csproid = '").append(proid).append("' ");
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
		Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				Qcompanygx.class);
		List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
		Qcompanygx gx = null;
		if (ls != null && ls.size() > 0) {
			gx = (Qcompanygx) ls.get(0);
			return gx;
		} else {
			return null;
		}
	}
	
	/**
	 * 
	 * queryComDto的中文名称：查询客户关系详情
	 * 
	 * queryComDto的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public QcompanygxDTO queryComDto(QcompanygxDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT gx.comgxlx, (select getAa10_aaa103('COMGXLX',gx.comgxlx)) as comgxlxstr, ");
		sb.append(" gx.comgxtime, gx.csid, gx.cominoutlx, gx.gxid, ");
		sb.append(" com.comdalei, (select getAa10_aaa103('COMDALEI',com.comdalei)) as comdaleistr, ");
		sb.append(" com.comdz, com.comfrhyz, com.commc, com.comyddh, ");
		sb.append(" pro.probzgg, pro.progg, pro.proname, ");
		sb.append(" pro.prozl,  (select getAa10_aaa103('PROZL',pro.prozl)) as prozlstr");
        sb.append(" from qcompanygx gx, pcompany com, qproduct pro "); 
        sb.append(" where 1=1 "); 
        sb.append(" and gx.csid = com.comid "); 
        sb.append(" and gx.csproid = pro.proid ");  
        sb.append(" and gx.gxid =:gxid ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "gxid"};
		int[] ParaType = new int[] {Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QcompanygxDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		QcompanygxDTO v_dto = null;
		if (ls != null && ls.size() > 0) {
			v_dto = (QcompanygxDTO) ls.get(0);
		}
		return v_dto;
	}	
	
	/**
	 * 
	 * delComgx的中文名称：删除客户关系
	 * 
	 * delComgx的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String delComgx(HttpServletRequest request, QcompanygxDTO dto) {
		try {
			if (null != dto.getGxid()) {
				delComgxImp(request, dto);
			} else {
				return "没有接收到要删除的gxid！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop({ "trans" })
	public void delComgxImp(HttpServletRequest request, QcompanygxDTO dto) {
		// 删除关系id
		dao.clear(Qcompanygx.class, Cnd.where("gxid", "=", dto.getGxid()));
	}	
	
	/**
	 * 
	 * queryComProductsListAsync的中文名称：根据Ztree插件的树格式，组装机构树。异步加载（传入父节点ID）
	 * 
	 * queryComProductsListAsync的概要说明：查询企业产品树
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public List queryComProductsListAsync(HttpServletRequest request) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" select 0 as proid, '企业产品列表' AS proname,  ");
		sb.append(" -1 as parentid, 'true' as isparent,'true' as isopen  ");
		sb.append(" union all ");
		sb.append(" SELECT  pro.proid, pro.proname, 0 as parentid, ");
		sb.append(" 'false' as isparent, 'false' as isopen ");
		sb.append(" from pcompany com , qproduct pro  ");
		sb.append(" WHERE 1 = 1 ");
		sb.append(" and pro.procomid = com.comid ");
		sb.append(" and pro.cphyclbz = '1' ");
		sb.append(" and com.comid ='").append(vSysUser.getAaz001()).append("' ");
		Map m = DbUtils.DataQuery("sql", sb.toString(), null, QproductDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}	
	
	/**
	 * 
	 * queryComProductsPc的中文名称：查询商品批次列表
	 * 
	 * queryComProductsPc的概要说明：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	 @SuppressWarnings({ "rawtypes", "unchecked" })
	 public Map queryComProductsPc(QproductpcDTO dto, PagesDTO pd) throws Exception{
		  if (dto.getProcomid() == null || "".equals(dto.getProcomid())) {
			  Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
			  dto.setProcomid(vSysUser.getAaz001());
		  }
		  
		  StringBuffer sb = new StringBuffer();
		  sb.append(" select pc.*, pro.proname, pro.prozl, com.commc ");
		  sb.append(" from qproductpc pc, qproduct pro, pcompany com "); 
		  sb.append(" where 1=1 ");
		  sb.append(" and pc.proid = pro.proid ");
		  sb.append(" and pro.procomid = com.comid ");
		  sb.append(" and pro.proid = :proid ");
		  sb.append(" and pro.proname like :proname ");
		  sb.append(" and pc.cppcpch like :cppcpch ");
		  sb.append(" and com.comid = :procomid");
		  sb.append(" order by pc.cppcid ");
	  
		  String sql = sb.toString();
		  String[] ParaName = new String[] { "proid", "proname", "cppcpch", "procomid" };
		  int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
	
		  sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		  Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductpcDTO.class,
				pd.getPage(), pd.getRows());
		  List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		  Map r = new HashMap();
		  r.put("rows", ls);
		  r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		  return r;
	 }
	 
	/**
	 * 
	 * selectComProducts的中文名称：选择商品
	 * 
	 * selectComProducts的概要说明：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	 @SuppressWarnings({ "rawtypes", "unchecked" })
	 public Map selectComProducts(QproductDTO dto, PagesDTO pd) throws Exception{
		 Sysuser user = SysmanageUtil.getSysuser();
		 StringBuffer sb = new StringBuffer();
		 Pcompany mfcom = dao.fetch(Pcompany.class, dto.getProcomid()); // 获取供货商公司信息
		 // 如果是范围外公司(不用从产品批次表中取)
		 if ("1".equals(mfcom.getComfwnfww())) {
			 sb.append(" select pro.proid,pro.proname,pro.prosptm,gx.cphyclid, ");
			 sb.append(" pro.probzq, pro.probzqdwmc,pro.progg,pro.probzgg,pro.prosccj,pro.procjdz,pro.probzqdwcode ");
			 sb.append(" from qproduct pro LEFT JOIN qcompanygx gx "); 
			 sb.append(" on gx.csproid = pro.proid and gx.csid = pro.procomid "); 
			 sb.append(" where 1=1 ");
			 sb.append(" and pro.cphyclbz = '1'"); // 默认选中商品
			 sb.append(" and pro.procomid = :procomid ");
			 sb.append(" and pro.proname like :proname ");
			 sb.append(" and pro.prosptm like :prosptm ");
			 sb.append(" and gx.comid =  '").append(user.getAaz001()).append("' ");
			 sb.append(" order by pro.proid ");
		 } else { // 如果是范围内企业，必须包含产品批次信息

			 sb.append(" select pc.cppcpch,pc.cppcscrq,pc.cppcscsl,pro.proid,pro.proname,pro.prosptm,gx.cphyclid, ");
			 sb.append(" pro.probzq, pro.probzqdwmc,pro.progg,pro.probzgg,pro.prosccj,pro.procjdz,pro.probzqdwcode, ");
			 sb.append(" (select getAa10_aaa103('CPPCSCDWDM',pc.cppcscdwdm)) as cppcscdwdmstr,cppcscdwdm");
			 sb.append(" from qproduct pro LEFT JOIN qcompanygx gx "); 
			 sb.append(" on gx.csproid = pro.proid and gx.csid = pro.procomid "); 
			 sb.append(" left join qproductpc pc on pc.proid=pro.proid ");
			 sb.append(" where 1=1 ");
			 sb.append(" and pro.cphyclbz = '1'"); // 默认选中商品
			 sb.append(" and pro.procomid = :procomid ");
			 sb.append(" and pro.proname like :proname ");
			 sb.append(" and pro.prosptm like :prosptm ");
			 sb.append(" and gx.comid =  '").append(user.getAaz001()).append("' ");
			 sb.append(" order by pro.proid ");			 
		 }
		 
		 String sql = sb.toString();
		 String[] ParaName = new String[] { "procomid", "proname", "prosptm" };
		 int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		 sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		 System.out.println("sqlsqlsql=================================="+sql);
		 Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductDTO.class,
			pd.getPage(), pd.getRows());
		 List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		 Map r = new HashMap();
		 r.put("rows", ls);
		 r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		 return r;
	 }
		 
	 /**
	  * 
	  *	addProductPc的中文名称：添加产品批次
	  * addProductPc的概要说明：
      *  @param dto
	  *  @return
	  *  Written by:zy
	  */
	 public String addProductPc(HttpServletRequest request, QproductpcDTO dto){
		 try {
			 addProductPcImpl(request, dto);
		 } catch (Exception e) {
			 return Lang.wrapThrow(e).getMessage();
		 }
		 return null;
	 }
	 
	 /**
	  * 
	  * addProductPcImpl的中文名称：实现添加方法
	  *  addProductPcImpl的概要说明：
	  *  @param dto
	  *  @throws Exception
	  *  Written by:zy
	  */
	  @Aop( { "trans" })
	  public void addProductPcImpl(HttpServletRequest request, QproductpcDTO dto) throws Exception{
		  if (dto.getCppcid() != null && !"".equals(dto.getCppcid())) {
			  Qproductpc pc = dao.fetch(Qproductpc.class, dto.getCppcid());
			  pc.setCppcpch(dto.getCppcpch()); // 商品批次号
			  pc.setCppcscdwdm(dto.getCppcscdwdm()); // 生成单位代码
			  pc.setCppcscrq(dto.getCppcscrq()); // 生产日期
			  pc.setCppcscsl(dto.getCppcscsl()); // 生产数量
			  pc.setCppcsysl(dto.getCppcscsl()); // 剩余数量（等于生产数量）
			  dao.update(pc);
		  } else {
			  String v_id = DbUtils.getSequenceStr();
			  Qproductpc pc = new Qproductpc();
			  BeanHelper.copyProperties(dto, pc);
			  pc.setCppcid(v_id);
			  pc.setCppcsysl(pc.getCppcscsl()); // 剩余数量（等于生产数量）
			  pc.setCppcsymscbz("0"); // 默认没有生成溯源码
			  dao.insert(pc); 
		  }
	  }
	  
	  /**
	   * 
	   * queryComProductsPc的中文名称：查询商品批次dto
	   * 
	   * queryComProductsPc的概要说明：
	   * @param request
	   * @param dto
	   * @return
	   * @throws Exception
	   *        Written by : zy
	   */
	  @SuppressWarnings({ "rawtypes" })
	  public QproductpcDTO queryProductPcDto(HttpServletRequest request, QproductpcDTO dto) throws Exception{
		  StringBuffer sb = new StringBuffer();
		  sb.append(" select pc.* ");
		  sb.append(" from qproductpc pc "); 
		  sb.append(" where 1=1 ");
		  sb.append(" and pc.cppcid =:cppcid");
		  sb.append(" order by pc.cppcid ");
   
		  String sql = sb.toString();
		  String[] ParaName = new String[] { "cppcid" };
		  int[] ParaType = new int[] { Types.VARCHAR };

		  sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		  Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductpcDTO.class);
		  List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		  QproductpcDTO v_dto = null;
		  if (ls != null && ls.size() > 0) {
			  v_dto = (QproductpcDTO) ls.get(0);
		  }
		  return v_dto;
	  }
	  
	  /**
	   * 
	   * delProductPc的中文名称：删除产品批次信息
	   * 
	   * delProductPc的概要说明：
	   * @param request
	   * @param dto
	   * @return
	   *        Written by : zy
	   */
	  public String delProductPc(HttpServletRequest request, QproductpcDTO dto){
		  try {
			  delProductPcImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		} 
		  return null;
	  }
	  
	  /**
	   * 
	   * delProductPcImpl的中文名称：删除产品批次实现
	   * 
	   * delProductPcImpl的概要说明：
	   * @param request
	   * @param dto
	   *        Written by : zy
	   */
	  @Aop( { "trans" })
	  public void delProductPcImpl(HttpServletRequest request, QproductpcDTO dto){
		  dao.clear(Qproductpc.class,Cnd.where("cppcid", "=", dto.getCppcid()));
	  } 
	  
	 /**
	  * 
	  *	applySym的中文名称：申请溯源码
	  * applySym的概要说明：
      *  @param dto
	  *  @return
	  *  Written by:zy
	  */
	  public String applySym(HttpServletRequest request, QsymscbDTO dto){
		  try {
			  applySymImpl(request, dto);
		  } catch (Exception e) {
			  return Lang.wrapThrow(e).getMessage();
		  }
		  return null;
	  }
	  
	  /**
	   * 
	   *  applySymImpl的中文名称：实现方法
	   *  applySymImpl的概要说明：
	   *  @param dto
	   *  @throws Exception
	   *  Written by:zy
	   */
	  @Aop( { "trans" })
	  public void applySymImpl(HttpServletRequest request, QsymscbDTO dto) throws Exception{
		  Sysuser v_user = SysmanageUtil.getSysuser();
		  String v_aaz001=v_user.getAaz001();
		  
		  String v_id = DbUtils.getSequenceStr();
		  Qsymscb pc = new Qsymscb();
		  BeanHelper.copyProperties(dto, pc);
		  pc.setQsymscbid(v_id);
		  pc.setSymsqsj(SysmanageUtil.getDbtimeYmdHns());
		  dao.insert(pc); 
		  // 溯源码明细
		  SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
		  String v_nowymd=df.format(new Date());// new Date()为获取当前系统时间		  
		  String rootPath = request.getSession().getServletContext().getRealPath("/");
		  String folderPath = rootPath +File.separator + "/upload/sym/"+v_aaz001+"/"+v_nowymd; 
		
		  // 二维码保存文件夹
		  File folder = new File(folderPath);
		  if (!folder.exists()) {
			folder.mkdirs();
		  }
		  int start = Integer.parseInt(dto.getSymksh());
		  int end = Integer.parseInt(dto.getSymjsh());
		  for (int i = start; i <= end; i++) {
			  StringBuffer sb = new StringBuffer();
			  sb.append(String.valueOf(i));
			  while(sb.toString().length() != 6) {
				  sb.insert(0, "0");
			  }
			  String sym = dto.getCppcid() + sb.toString();
			  String v_mxid = DbUtils.getSequenceStr();
			  Qsymscmxb mx = new Qsymscmxb();
			  mx.setQsymscbid(v_id);
			  mx.setSym(sym);
			  mx.setQsymscmxbid(v_mxid);
			  
				String qrcodePath = "/upload/sym/"+v_aaz001+"/"+v_nowymd+"/"+sym+".gif";//
				String codePath = rootPath + File.separator + "/upload/sym/"+v_aaz001+"/"+v_nowymd+"/"+sym + ".gif";
				//先删除原来的二维码图片
				if(FileUtil.checkFile(codePath)){
					FileUtil.delFile(codePath);
				}	
				// 获取企业二维码前缀
				Aa01 aa01 = SysmanageUtil.getAa01("SYMQZ");
				String comInfo = aa01.getAaa005() + sym;
				boolean flag =  SysmanageUtil.createQrcode(codePath, comInfo, ""); // 创建二维码
				// 创建二维码成功，保存进数据库
				if (!flag) {
                   throw new BusinessException("创建二维码失败");
				}
				
				mx.setQrcodepath(qrcodePath);
			  dao.insert(mx);
		  }
			
		  // 更新产品批次表
		  dao.update(Qproductpc.class, Chain.make("cppcsymscbz", "1"), Cnd.where("cppcid", "=", dto.getCppcid()));
	  }
	  
	  /**
	   * 
	   * queryProductSyms的中文名称：查询产品溯源码
	   * 
	   * queryProductSyms的概要说明：
	   * 
	   * @param request
	   * @return Written by : zy
	   * @throws Exception
	   * 
	   */
	  @SuppressWarnings({ "unchecked", "rawtypes" })
	  public Map queryProductSyms(HttpServletRequest request, PagesDTO pd) throws Exception {
		  
		  String cppcid = StringHelper.showNull2Empty(request.getParameter("cppcid"));
			
		  StringBuffer sb = new StringBuffer();
		  sb.append(" SELECT mx.* ");
		  sb.append(" from qsymscmxb mx "); 
		  sb.append(" where 1=1 "); 
		  sb.append(" and mx.qsymscbid = ( "); 
		  sb.append(" SELECT sc.qsymscbid "); 
		  sb.append(" from qsymscb sc ");
		  sb.append(" where sc.cppcid =  '").append(cppcid).append("') ");
		  sb.append("  order by mx.qsymscmxbid asc");
		  String sql = sb.toString();
		  String[] ParaName = new String[] {};
		  int[] ParaType = new int[] {};
		  sql = QueryFactory.getSQL(sql, ParaName, ParaType, null, pd);	
		  Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QsymscmxbDTO.class,
				  pd.getPage(), pd.getRows());
		  List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		  Map r = new HashMap();
		  r.put("rows", ls);
		  r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		  return r;
	  }
	  
	  /**
	   * 
	   * querySymQrcode的中文名称：查询产品溯源码
	   * 
	   * querySymQrcode的概要说明：
	   * 
	   * @param request
	   * @return Written by : gjf
	   * @throws Exception
	   * 
	   */
	  @SuppressWarnings({ "unchecked", "rawtypes" })
	  public Map querySymQrcode(HttpServletRequest request,QsymscmxbDTO dto,PagesDTO pd) throws Exception {
		  StringBuffer sb = new StringBuffer();
		  sb.append(" SELECT mx.* ");
		  sb.append(" from qsymscmxb mx "); 
		  sb.append(" where 1=1 "); 
		  sb.append(" and qsymscmxbid=:qsymscmxbid");
		  String sql = sb.toString();
		  String[] ParaName = new String[] {"qsymscmxbid"};
		  int[] ParaType = new int[] {Types.VARCHAR};
		  sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);	
		  Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QsymscmxbDTO.class,
				  pd.getPage(), pd.getRows());
		  List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		  Map r = new HashMap();
		  r.put("rows", ls);
		  r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		  return r;
	  }	  
	  
	  /**
	   * 
	   * exportExcel的中文名称：导出溯源码到excel表格
	   * 
	   * exportExcel的概要说明：
	   * 
	   * @param request
	   * @return Written by : zy
	 * @throws IOException 
	   * @throws Exception
	   * 
	   */
//	  public String exportExcel(HttpServletRequest request,HttpServletResponse response) {
//		  int v_rownum=0;
//		  
//		  try {
//			  String cppcid = StringHelper.showNull2Empty(request.getParameter("cppcid"));
//			  // 取溯源码前缀
//			  Aa01 aa01 = SysmanageUtil.getAa01("SYMQZ"); 
//			  String sqmqz = aa01.getAaa005();
//			  List<Qsymscb> sclist = dao.query(Qsymscb.class, Cnd.where("cppcid", "=", cppcid));
//			  List<Qsymscmxb> mxList = null;
//			  if (sclist != null && sclist.size() > 0) {
//				  mxList = dao.query(Qsymscmxb.class, Cnd.where("qsymscbid", "=", sclist.get(0).getQsymscbid()));
//				  HSSFWorkbook wb = new HSSFWorkbook(); // 第一步，创建一个webbook，对应一个Excel文件  
//				  HSSFSheet sheet = wb.createSheet("溯源码"); // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
//				  sheet.setColumnWidth(0, 100*256); // 设置第一列单元格宽度
//				  HSSFCellStyle style = wb.createCellStyle(); // 样式
//				  style.setWrapText(true); // 设置自适应宽度
//				  
//				  HSSFRow rowhead = sheet.createRow(v_rownum);
//				  HSSFCell cellhead = rowhead.createCell(0);
//				  cellhead.setCellValue("溯源码");
//				  cellhead.setCellStyle(style);				  
//				  
//				  for (int i = 0; i < mxList.size(); i++) {
//					  v_rownum=v_rownum+1;
//					  Qsymscmxb mx = mxList.get(i);
//					  HSSFRow row = sheet.createRow(v_rownum);
//					  HSSFCell cell = row.createCell(0);
//					  cell.setCellValue(sqmqz + mx.getSym());
//					  cell.setCellStyle(style);
//				  }
//				  String fileName = "upload/symxls/"+DbUtils.getSequenceStr() + "_溯源码.xls";
//				  //当前用户桌面
//				  //File desktopDir = FileSystemView.getFileSystemView().getHomeDirectory();
//				  //String desktopPath = desktopDir.getAbsolutePath();
//				  // 将excel保存到桌面
//				  //FileOutputStream fout = new FileOutputStream(desktopPath+"/" + fileName);  
//				  fileName = request.getSession().getServletContext().getRealPath(fileName);
//					
//				  FileOutputStream fout = new FileOutputStream(fileName);
//				  wb.write(fout);  
//				  fout.close(); 
//				  
//				  v_ExcelServlet.download(fileName, response);
//			  }
//		  } catch (Exception e) {
//			  return Lang.wrapThrow(e).getMessage();
//		  }
//		  return null;
//		  
//	  }
	  
	  public File exportExcel(HttpServletRequest request) throws IOException {
		  String filepath = request.getSession().getServletContext().getRealPath("");
		  filepath = filepath.replaceAll("\\\\", "/");
		  filepath = filepath+"/upload/symxls/";
		  String fileName = filepath + DbUtils.getSequenceStr() + "_溯源码.xls";
		  String fileNameYc = filepath + DbUtils.getSequenceStr() + "_异常信息.txt";
		  File file;		  
		  
		  try {
			  String cppcid = StringHelper.showNull2Empty(request.getParameter("cppcid"));
			  
			  final List<ExportedExcelDataInfo> lstExd = new ArrayList<ExportedExcelDataInfo>();
			  // 取溯源码前缀
//			  Aa01 aa01 = SysmanageUtil.getAa01("SYMQZ");
//			  String sqmqz = aa01.getAaa005();
			  List<Qsymscb> sclist = dao.query(Qsymscb.class, Cnd.where("cppcid", "=", cppcid));
			  List<Qsymscmxb> mxList = null;
			  if (sclist != null && sclist.size() > 0) {
				  //mxList = dao.query(Qsymscmxb.class, Cnd.where("qsymscbid", "=", sclist.get(0).getQsymscbid()));
				  String v_sql = "select a.sym from Qsymscmxb a where a.qsymscbid='" + sclist.get(0).getQsymscbid().toString()+"'";
				  List<Qsymscmxb> v_qsymscmxb = DbUtils.getDataList(v_sql, Qsymscmxb.class);
				  ExportedExcelDataInfo exd = SysmanageUtil.createExcelMainWorkSheet("溯源码", "Qsymscmxb", v_qsymscmxb, false);
				  lstExd.add(exd);
			  }	  
					
		      file = ExcelUtil.exportMultiDataAsExcel(lstExd, fileName, true);
			  return file;
			}catch (Exception e) {
				file = new File(fileNameYc);
				FileWriter fw = new FileWriter(file);
				fw.write(e.getMessage());
				fw.close();
				return file;
			} finally {
				// 删除服务器上的临时文件
				// if (file.exists()) {
				// file.delete();
				// }
			}
	  }
	  
	  
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
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT stock.qledgerstockid,stock.lgprojydwmc, stock.lgfromcomid, stock.lgprojyrq, stock.lgprojysl, ");
		sb.append(" stock.lgprobzq,stock.lgprobzqdwmc, stock.lgprodqrq, com.commc, stock.lgproscrq, ");
		sb.append(" stock.lgpropc,stock.lgproname, stock.lgprosptm,stock.lgprosysl, com.comdz, com.comyddh, com.comfrhyz, ");
		 sb.append("(select GROUP_CONCAT(t1.comxkzbh)  from pcompanyxkz t1 where t1.comid=com.comid group by t1.comid) as  comzzzmbh ");
		sb.append(" from qledgerstock stock, pcompany com "); 
        sb.append(" where 1=1 "); 
        sb.append(" and stock.lgfromcomid = com.comid "); 
        sb.append(" and stock.lgtocomid = '").append(vSysUser.getAaz001()).append("'");
        sb.append(" and stock.sphyclid = :sphyclid ");
        sb.append(" and stock.lgprojydwmc = :lgprojydwmc ");
        sb.append(" and com.commc like :commc ");
        //sb.append(" and com.comzzzmbh like :comzzzmbh ");
        sb.append(" and stock.lgproname like :lgproname ");
        sb.append(" and stock.lgprosptm like :lgprosptm ");
        sb.append("  order by stock.qledgerstockid asc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "sphyclid", "lgprojydwmc", "commc", "lgproname", "lgprosptm"};
		int[] ParaType = new int[] {Types.VARCHAR, Types.VARCHAR,  Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};

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
	 * 
	 * queryStockDTO的中文名称：查询台账信息dto
	 * 
	 * queryStockDTO的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes" })
	public QledgerstockDTO queryStockDTO(HttpServletRequest request, QledgerstockDTO dto) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT stock.*, ");
		sb.append(" com.commc, "); // com.comzzzmbh,
		sb.append(" com.comdz, com.comyddh, com.comfrhyz ");
        sb.append(" from qledgerstock stock, pcompany com, qproduct pro  "); 
		sb.append(" where 1=1 "); 
		sb.append(" and stock.lgfromcomid = com.comid "); 
		sb.append(" and com.comid = pro.procomid "); 
		sb.append(" and stock.lgproid = pro.proid "); 
		sb.append(" and stock.qledgerstockid = :qledgerstockid");
   
		String sql = sb.toString();
		String[] ParaName = new String[] { "qledgerstockid" };
		int[] ParaType = new int[] { Types.VARCHAR };

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QledgerstockDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		QledgerstockDTO v_dto = null;
		if (ls != null && ls.size() > 0) {
			v_dto = (QledgerstockDTO) ls.get(0);
		}
		return v_dto;
	}
		
	/**
	 * 
	 * saveStock的中文名称：新增台账信息
	 * 
	 * saveStock的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String saveStock(HttpServletRequest request, QledgerstockDTO dto) {
		try {
			saveStockImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * saveStockImp的中文名称：保存进货台账实现
	 * 
	 * saveStockImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void saveStockImp(HttpServletRequest request, QledgerstockDTO dto)
			throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		String v_id = DbUtils.getSequenceStr();
		// 保存进货台账信息
		Qledgerstock se = new Qledgerstock();
		se.setQledgerstockid(v_id); // id
		se.setLgfromcomid(dto.getLgfromcomid()); // 卖方公司id
		se.setLgproid(dto.getLgproid()); // 交易商品id
		se.setLgproscrq(dto.getLgproscrq()); // 生产日期
		se.setLgprobzq(dto.getLgprobzq()); // 保质期
		se.setLgtocomid(vSysUser.getAaz001()); // 买方公司id
		se.setLgprobzgg(dto.getLgprobzgg()); // 包装规格
		se.setLgprobzqdwcode(dto.getLgprobzqdwcode()); // 保质期单位id
		se.setLgprobzqdwmc(dto.getLgprobzqdwmc()); // 保质期单位名称
		se.setLgprocjdz(dto.getLgprocjdz()); // 厂家地址
		se.setLgprocode(dto.getLgprocode()); // 商品交易溯源码
		se.setLgprogg(dto.getLgprogg()); // 规格
		se.setLgprojydwcode(dto.getLgprojydwcode()); // 食品包装计量单位
		se.setLgprojydwmc(dto.getLgprojydwmc()); // 交易商品单位名称
		se.setLgprojyrq(dto.getLgprojyrq()); // 商品交易日期
		se.setLgprojysl(dto.getLgprojysl().toString()); // 交易商品数量
		se.setLgproname(dto.getLgproname()); // 交易商品名称
		se.setLgpropc(dto.getLgpropc()); // 交易商品批次
		se.setLgprosccj(dto.getLgprosccj()); // 生产厂家
		se.setLgprosptm(dto.getLgprosptm()); // 商品条码
		se.setSphyclid(dto.getSphyclid()); // 商品或原材料id
		se.setLgprosysl(dto.getLgprojysl()); // 剩余数量
		se.setLgjylx(dto.getLgjylx()); // 范围内外交易类型
		se.setLgprosfyx("1"); // 是否有效（默认有效）
		dao.insert(se);
		// 将进货信息添加或更新入进货库存汇总表
		List<Qjhkchzb> kcList = dao.query(Qjhkchzb.class, Cnd.where("comid", "=", vSysUser.getAaz001())
				.and("proid", "=", dto.getSphyclid()).and("projldw", "=", dto.getLgprojydwmc()));
		// 如果没有库存信息，插入新数据
		if (kcList == null || kcList.size() == 0) {
			Qjhkchzb jhkc = new Qjhkchzb();
			jhkc.setComid(vSysUser.getAaz001()); // 公司id
			jhkc.setJhkcjhsl(dto.getLgprojysl().toString()); // 进货数量
			jhkc.setProid(dto.getSphyclid()); // 商品id（商品或原材料id）
			jhkc.setProjldw(dto.getLgprojydwmc()); // 产品计量单位
			jhkc.setQjhkchzb(DbUtils.getSequenceStr()); // 库存汇总id
			jhkc.setJhkcjysl(dto.getLgprojysl().toString()); // 结余数量
			jhkc.setJhkcchsl("0"); // 出库数量
			dao.insert(jhkc);
		} else { // 结余与进货，在原来基础上加上交易数量
			Qjhkchzb jhkc = kcList.get(0);
			jhkc.setJhkcjhsl(dto.getLgprojysl().add(new BigDecimal(jhkc.getJhkcjhsl())).toString()); // 进货数量
			jhkc.setJhkcjysl(dto.getLgprojysl().add(new BigDecimal(jhkc.getJhkcjysl())).toString()); // 结余数量
			dao.update(jhkc);
		}
	}
		
	/**
	   * 
	   * delStock的中文名称：删除台账信息
	   * 
	   * delStock的概要说明：
	   * @param request
	   * @param dto
	   * @return
	   *        Written by : zy
	   */
	  public String delStock(HttpServletRequest request, QledgerstockDTO dto){
		  try {
			  //该库存如果已经有出货，不能删除
				int v_count = dao.count(Qproductclsyjlb.class, 
						Cnd.where("cppcid", "=", dto.getCppcid()));
				if (v_count > 0){
					throw new BusinessException("不能修改：该进货记录已经产生了使用记录");
				}	
			  delStockImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		} 
		  return null;
	  }
	  
	  /**
	   * 
	   * delStockImpl的中文名称：删除产品批次实现
	   * 
	   * delStockImpl的概要说明：
	   * @param request
	   * @param dto
	   *        Written by : zy
	   */
	  @Aop( { "trans" })
	  public void delStockImpl(HttpServletRequest request, QledgerstockDTO dto){
		  //gu20170630 库存表还要清除呀		  
		  dao.clear(Qledgerstock.class,Cnd.where("qledgerstockid", "=", dto.getQledgerstockid()));
		  
	  } 
	  
	  /**
	   * 
	   * querySelectcom的中文名称：查询供货商公司
	   * 
	   * querySelectcom的概要说明：
	   * 
	   * @return Written by : zy
	   * @throws Exception
	   * 
	   */
	  @SuppressWarnings({ "unchecked", "rawtypes" })
	  public Map querySelectcom(QcompanygxDTO dto, PagesDTO pd) throws Exception {

		  Sysuser vSysUser = SysmanageUtil.getSysuser();
		  StringBuffer sb = new StringBuffer();
		  sb.append(" SELECT com.comdm, com.comfwnfww,com.comdz, com.comfrhyz, com.commc, com.comyddh, ");
		  if ("1".equals(dto.getComfwnfww())) { // 如果是范围外企业，需要从客户关系表中查询
			  sb.append(" tem.csid, tem.comgxlx, tem.comid, ");
		  }
		  sb.append("(select GROUP_CONCAT(t1.comxkzbh)  from pcompanyxkz t1 where t1.comid=com.comid group by t1.comid) as  comzzzmbh ");
		  sb.append(" from pcompany com ");
		  if ("1".equals(dto.getComfwnfww())) { // 如果是范围外企业，需要从客户关系表中查询
			  sb.append(" ,(SELECT gx.csid, gx.comgxlx, gx.comid	");
			  sb.append(" FROM qcompanygx gx where 1 = 1 ");
			  if (!StringUtils.isEmpty(dto.getComgxlx())) {
				  sb.append(" and gx.comgxlx = '" + dto.getComgxlx() + "' "); // 供货商关系类型
			  }
			  sb.append(" GROUP BY gx.csid, gx.comgxlx, gx.comid ) tem ");
			  sb.append(" where 1=1 ");
			  sb.append(" and tem.comid = '").append(vSysUser.getAaz001()).append("'");
			  sb.append(" and com.comid = tem.csid ");
		  }
		  else {
			  sb.append(" where 1=1");
		  }
		  sb.append(" and com.commc like :commc ");
		  sb.append("  order by com.comid asc");
		  String sql = sb.toString();
		  String[] ParaName = new String[] { "comgxlx", "commc" };
		  int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		  
		  sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		  Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QcompanygxDTO.class, pd.getPage(), pd.getRows());
		  List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		  Map r = new HashMap();
		  r.put("rows", ls);
		  r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		  return r;
	  }	
	  
    /**
	 * 	
	 * queryJhhz的中文名称：进货汇总
	 * 
	 * queryJhhz的概要说明：
	 * 
	 * @param request
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryJhhz(HttpServletRequest request, PagesDTO pd) throws Exception {
		updataJhhzByStock(); // 根据进货台账更新进货库存汇总表
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT hz.*, ");
		sb.append(" pro.proname, pro.cphyclbz ");
        sb.append(" from qjhkchzb hz, qproduct pro "); 
        sb.append(" where 1=1 "); 
        sb.append(" and hz.proid = pro.proid "); 
        sb.append(" and hz.comid = '").append(vSysUser.getAaz001()).append("'");
        sb.append("  order by hz.qjhkchzb asc");
		String sql = sb.toString();
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null, pd);
		System.out.println("----------------"+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QjhkchzbDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * updataJhhzByStock的中文名称：根据进货台账更新进货库存汇总
	 * 
	 * updataJhhzByStock的概要说明：
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	@SuppressWarnings({ "rawtypes", "static-access" })
	public void updataJhhzByStock() throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT SUM(s.lgprojysl) lgprojysl, SUM(s.lgprosysl) lgprosysl, ");
		sb.append(" s.lgprojydwmc, s.lgtocomid, s.sphyclid  ");
		sb.append(" FROM qledgerstock s ");
        sb.append(" where 1=1 "); 
        sb.append(" and s.lgtocomid = '").append(vSysUser.getAaz001()).append("' ");
        sb.append(" GROUP BY s.lgtocomid, s.sphyclid, s.lgprojydwmc  "); 
		String sql = sb.toString();
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};
		PagesDTO pd = new PagesDTO();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Qledgerstock.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		for (int i = 0; i < ls.size(); i++) {
			Qledgerstock stock = (Qledgerstock) ls.get(i);
			dao.update(Qjhkchzb.class, Chain.make("jhkcjhsl", stock.getLgprojysl()) // 进货数量
					.make("jhkcjysl", stock.getLgprosysl()), // 结余数量
					Cnd.where("comid", "=", stock.getLgtocomid()) // 公司id
					.and("proid", "=", stock.getSphyclid()) // 商品id
					.and("projldw", "=", stock.getLgprojydwmc())); // 单位名称
		}
		
	}
	
	/**
	 * 
	 * saveProductScszxx的中文名称：保存产品生产生长信息
	 * 
	 * saveProductScszxx的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String saveProductScszxx(HttpServletRequest request, QproductszgcxxDTO dto) {
		try {
			saveProductScszxxImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * saveProductScszxxImp的中文名称：保存产品生产生长信息实现
	 * 
	 * saveProductScszxxImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void saveProductScszxxImp(HttpServletRequest request, QproductszgcxxDTO dto)
			throws Exception {
		
		if (dto.getSzgcid() != null && !"".equals(dto.getSzgcid())) {
			Qproductszgcxx se = dao.fetch(Qproductszgcxx.class, dto.getSzgcid());
			se.setCppcpch(dto.getCppcpch()); // 产品批次号
			se.setProid(dto.getProid()); // 产品id
			se.setSzgcbz(dto.getSzgcbz()); // 备注
			se.setSzgccznr(dto.getSzgccznr()); // 操作内容
			se.setSzgcczr(dto.getSzgcczr()); // 操作人
			se.setSzgcczrq(dto.getSzgcczrq()); // 操作日期
			dao.update(se);
			
		} else {
			String v_id = DbUtils.getSequenceStr();
			// 保存产品生产生长信息
			Qproductszgcxx se = new Qproductszgcxx();
			se.setCppcpch(dto.getCppcpch()); // 产品批次号
			se.setProid(dto.getProid()); // 产品id
			se.setSzgcbz(dto.getSzgcbz()); // 备注
			se.setSzgccznr(dto.getSzgccznr()); // 操作内容
			se.setSzgcczr(dto.getSzgcczr()); // 操作人
			se.setSzgcczrq(dto.getSzgcczrq()); // 操作日期
			se.setSzgcid(v_id); // id
			dao.insert(se);
		}
	}
	
	/**
	 * 	
	 * queryProductScszxx的中文名称：查询产品生产生长信息
	 * 
	 * queryProductScszxx的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryProductScszxx(QproductszgcxxDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT xx.* ");
        sb.append(" from qproductszgcxx xx"); 
        sb.append(" where 1=1 "); 
        sb.append(" and xx.proid = :proid "); 
        sb.append(" and xx.cppcpch = :cppcpch");
        sb.append("  order by xx.szgcid asc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "proid", "cppcpch" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("----------------"+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Qproductszgcxx.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * queryProductScszxxDto的中文名称：查询产品生产生长信息dto
	 * 
	 * queryProductScszxxDto的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public QproductszgcxxDTO queryProductScszxxDto(QproductszgcxxDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT xx.* ");
        sb.append(" from qproductszgcxx xx"); 
        sb.append(" where 1=1 "); 
        sb.append(" and xx.szgcid = :szgcid "); 
		String sql = sb.toString();
		String[] ParaName = new String[] { "szgcid"};
		int[] ParaType = new int[] {Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductszgcxxDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		QproductszgcxxDTO v_dto = null;
		if (ls != null && ls.size() > 0) {
			v_dto = (QproductszgcxxDTO) ls.get(0);
		}
		return v_dto;
	}	
	
	/**
	  * 
	  * deleteScszxx的中文名称：删除生产生长信息
	  * 
	  * deleteScszxx的概要说明：
	  * @param request
	  * @param dto
	  * @return
	  *        Written by : zy
	  */
	public String deleteScszxx(HttpServletRequest request, QproductszgcxxDTO dto){
		try {
			  deleteScszxxImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		} 
		  return null;
	}
	  
	/**
	 * 
	 * deleteScszxxImpl的中文名称：删除产品批次实现
	 * 
	 * deleteScszxxImpl的概要说明：
	 * @param request
	 * @param dto
	 *        Written by : zy
	 */
	@Aop( { "trans" })
	public void deleteScszxxImpl(HttpServletRequest request, QproductszgcxxDTO dto){
		dao.clear(Qproductszgcxx.class,Cnd.where("szgcid", "=", dto.getSzgcid()));
	} 
	
	/**
	 * 
	 * saveProductJcjyxx的中文名称：保存产品检测检验信息
	 * 
	 * saveProductJcjyxx的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String saveProductJcjyxx(HttpServletRequest request, QproductjcDTO dto) {
		try {
			saveProductJcjyxxImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 
	 * saveProductJcjyxxImp的中文名称：保存产品检测检验信息实现
	 * 
	 * saveProductJcjyxxImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void saveProductJcjyxxImp(HttpServletRequest request, QproductjcDTO dto)
			throws Exception {
		
		if (dto.getQproductjcid() != null && !"".equals(dto.getQproductjcid())) {
			Qproductjc se = dao.fetch(Qproductjc.class, dto.getQproductjcid());
			se.setJcdw(dto.getJcdw()); // 检测单位
			se.setJcitem(dto.getJcitem()); // 检测项目
			se.setJcjcy(dto.getJcjcy()); // 检验员
			se.setJcjg(dto.getJcjg()); // 检测结果
			se.setJcpc(dto.getJcpc()); // 检测批次
			se.setJcsj(dto.getJcsj()); // 检测时间
			se.setProid(dto.getProid()); // 产品id
			dao.update(se);
			
		} else {
			String v_id = DbUtils.getSequenceStr();
			// 保存产品生产生长信息
			Qproductjc se = new Qproductjc();
			se.setJcdw(dto.getJcdw()); // 检测单位
			se.setJcitem(dto.getJcitem()); // 检测项目
			se.setJcjcy(dto.getJcjcy()); // 检验员
			se.setJcjg(dto.getJcjg()); // 检测结果
			se.setJcpc(dto.getJcpc()); // 检测批次
			se.setJcsj(dto.getJcsj()); // 检测时间
			se.setProid(dto.getProid()); // 产品id
			se.setQproductjcid(v_id); // id
			dao.insert(se);
		}
	}
	
	/**
	 * 	
	 * queryProductJcjyxx的中文名称：查询产品检测检验信息
	 * 
	 * queryProductJcjyxx的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map queryProductJcjyxx(QproductjcDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT jc.* ");
        sb.append(" from qproductjc jc "); 
        sb.append(" where 1=1 "); 
        sb.append(" and jc.proid = :proid "); 
        sb.append(" and jc.jcpc = :jcpc");
        sb.append("  order by jc.qproductjcid asc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "proid", "jcpc" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("----------------"+sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Qproductjc.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * queryProductJcjyxxDto的中文名称：查询产品检测检验信息dto
	 * 
	 * queryProductJcjyxxDto的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public QproductjcDTO queryProductJcjyxxDto(QproductjcDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT jc.* ");
        sb.append(" from qproductjc jc "); 
        sb.append(" where 1=1 "); 
        sb.append(" and jc.qproductjcid = :qproductjcid "); 
		String sql = sb.toString();
		String[] ParaName = new String[] { "qproductjcid"};
		int[] ParaType = new int[] {Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductjcDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		QproductjcDTO v_dto = null;
		if (ls != null && ls.size() > 0) {
			v_dto = (QproductjcDTO) ls.get(0);
		}
		return v_dto;
	}	
	
	/**
	  * 
	  * deleteJcjyxx的中文名称：删除检测检验信息
	  * 
	  * deleteJcjyxx的概要说明：
	  * @param request
	  * @param dto
	  * @return
	  *        Written by : zy
	  */
	public String deleteJcjyxx(HttpServletRequest request, QproductjcDTO dto){
		try {
			deleteJcjyxxImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		} 
		  return null;
	}
	  
	/**
	 * 
	 * deleteJcjyxxImpl的中文名称：删除检测检验实现
	 * 
	 * deleteJcjyxxImpl的概要说明：
	 * @param request
	 * @param dto
	 *        Written by : zy
	 */
	@Aop( { "trans" })
	public void deleteJcjyxxImpl(HttpServletRequest request, QproductjcDTO dto){
		dao.clear(Qproductjc.class,Cnd.where("qproductjcid", "=", dto.getQproductjcid()));
	}
	
	
	/**
	  * 
	  * deletesym的中文名称：删除溯源码
	  * 
	  * deletesym的概要说明：
	  * @param request
	  * @param dto
	  * @return
	  *        Written by : gjf
	  */
	public String deletesym(HttpServletRequest request, QproductpcDTO dto){
		try {
			deletesymImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		} 
		  return null;
	}
	  
	/**
	 * 
	 * deleteJcjyxxImpl的中文名称：删除检测检验实现
	 * 
	 * deleteJcjyxxImpl的概要说明：
	 * @param request
	 * @param dto
	 *        Written by : zy
	 * @throws Exception 
	 */
	@Aop( { "trans" })
	public void deletesymImpl(HttpServletRequest request, QproductpcDTO dto) throws Exception{
		//删除生成的二维码图片
		String v_sql="select a.* from qsymscmxb a,qsymscb b "+
		" where a.qsymscbid=b.qsymscbid and b.cppcid='"+dto.getCppcid()+"'";
		List<Qsymscmxb> symmxlist=DbUtils.getDataList(v_sql, Qsymscmxb.class);
		if (symmxlist!=null && symmxlist.size()>0){
			for (Qsymscmxb mxb:symmxlist){
				String rootPath = request.getSession().getServletContext().getRealPath("/");
				String v_filepath=rootPath + File.separator + mxb.getQrcodepath();
				File file = new File(v_filepath);
				if (file.exists()) {
					file.delete();
				}
				dao.delete(mxb);
			}
		};
		
		//删除二维码 主表
		dao.clear(Qsymscb.class,Cnd.where("cppcid", "=", dto.getCppcid()));
		
		Qproductpc v_propc=dao.fetch(Qproductpc.class, Cnd.where("cppcid", "=", dto.getCppcid()));
		v_propc.setCppcsymscbz("0");
		dao.update(v_propc);
	}

	/**
	 *
	 * saveProductSzhjxx的中文名称：保存产品生长环境信息
	 *
	 * saveProductSzhjxx的概要说明：
	 *
	 * @param dto
	 * @return Written by : zy
	 *
	 */
	public String saveProductSzhjxx(HttpServletRequest request, QproductszhjxxDTO dto) {
		try {
			saveProductSzhjxxImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * saveProductSzhjxxImp的中文名称：保存产品生长环境信息实现
	 *
	 * saveProductSzhjxxImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void saveProductSzhjxxImp(HttpServletRequest request, QproductszhjxxDTO dto)
			throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		String currTime = SysmanageUtil.getDbtimeYmdHns();
		// 大气信息
		EnvAirInfo air = new EnvAirInfo();
		air.setAirid(DbUtils.getSequenceStr()); // 主键id
		air.setAirtsp(dto.getAirtsp()); // 总悬浮颗粒物
		air.setAirthc(dto.getAirthc()); // 总碳氢化合物
		air.setAirto(dto.getAirto()); // 总氧化剂
		air.setAiroxynitride(dto.getAiroxynitride()); // 氮氧化物
		air.setAirso2(dto.getAirso2()); // 二氧化硫
		air.setAirco(dto.getAirco()); // 一氧化碳
		air.setAirdustfall(dto.getAirdustfall()); // 降尘
		air.setProid(dto.getProid()); // 产品id
		air.setCppcpch(dto.getCppcpch()); // 产品批次号
		air.setOperatoruserid(user.getUserid()); // 操作用户ID
		air.setOperatorusername(user.getDescription()); // 操作用户名
		air.setOperatordate(currTime); // 操作日期
		dao.insert(air);
		// 水信息
		EnvWalterInfo water = new EnvWalterInfo();
		water.setWalterid(DbUtils.getSequenceStr()); // 主键id
		water.setWalterph(dto.getWalterph()); // PH
		water.setWaltero2(dto.getWaltero2()); // 溶氧
		water.setWaltertemp(dto.getWaltertemp()); // 温度
		water.setWalterele(dto.getWalterele()); // 电导率
		water.setWalterturbidity(dto.getWalterturbidity()); // 浊度
		water.setProid(dto.getProid()); // 产品id
		water.setCppcpch(dto.getCppcpch()); // 产品批次号
		water.setOperatoruserid(user.getUserid()); // 操作用户ID
		water.setOperatorusername(user.getDescription()); // 操作用户名
		water.setOperatordate(currTime); // 操作日期
		dao.insert(water);
		// 土壤信息
		EnvSoilInfo soil = new EnvSoilInfo();
		soil.setSoilid(DbUtils.getSequenceStr()); // 主键id
		soil.setSoiltemperature(dto.getSoiltemperature()); // 土壤温度
		soil.setSoilsalinity(dto.getSoilsalinity()); // 土壤盐分
		soil.setSoilmoisture(dto.getSoilmoisture()); // 土壤水分
		soil.setProid(dto.getProid()); // 产品id
		soil.setCppcpch(dto.getCppcpch()); // 产品批次号
		soil.setOperatoruserid(user.getUserid()); // 操作用户ID
		soil.setOperatorusername(user.getDescription()); // 操作用户名
		soil.setOperatordate(currTime); // 操作日期
		dao.insert(soil);
	}
	 
}
