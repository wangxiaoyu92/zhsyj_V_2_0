package com.askj.spsy.service;

import com.askj.spsy.dto.QledgersalesDTO;
import com.askj.spsy.dto.QledgerstockDTO;
import com.askj.spsy.dto.QproductDTO;
import com.askj.spsy.entity.Qcphcldygx;
import com.askj.spsy.entity.Qledgersales;
import com.askj.spsy.entity.Qproduct;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.mvc.annotation.Param;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductinService {
 
	@Inject
	protected Dao dao;
	
	/**
	 * 
	 *  queryProductin的中文名称：查看范围内产品
	 *  queryProductin的概要说明：
	 *  @param dto
	 *  @param pd
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryProductin(QproductDTO dto,
			PagesDTO pd) throws Exception{
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* , ");
		sb.append(" (SELECT AAA103 FROM aa10  WHERE AAA100='prozl' AND AAA102=a.prozl) prozlstr ");
        sb.append(" from qproduct a "); 
        sb.append(" where 1=1 ");
        sb.append(" and a.procomid=:procomid");
        sb.append(" and a.proid=:proid");
        sb.append(" and a.proname like :proname");
        sb.append(" and a.prosptm like :prosptm");
        sb.append(" and a.cphyclbz = :cphyclbz");
        sb.append(" order by proid ");
        
		String sql = sb.toString();
		String[] ParaName = new String[] {"procomid","proid", "proname", "prosptm", "cphyclbz"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("==============================" + sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QproductDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		// 获取产品图片
		List<QproductDTO> result = new ArrayList<QproductDTO>();
		if (ls != null && ls.size() > 0) {
			for ( int i = 0; i < ls.size(); i++) {
				QproductDTO pro = (QproductDTO) ls.get(i);
				List<Fj> fjls = dao.query(Fj.class, Cnd.where("fjwid", "=", pro.getProid()));
				if (fjls != null && fjls.size() > 0) {
					pro.setFjpath(fjls.get(0).getFjpath()); // 附件路径
				} else {
					pro.setFjpath("/images/default2.gif"); // 附件路径
				}
				result.add(pro);
			}
		}
		Map r = new HashMap();
		r.put("rows", result);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 *  addProductin的中文名称：添加 更新 新产品
	 *  addProductin的概要说明：
	 *  @param dto
	 *  @return
	 *  Written by:ly
	 */
	public String addProductin(QproductDTO dto){
		try {
			addProductinImpl(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 *  addProductinImpl的中文名称：实现添加更新的方法
	 *  addProductinImpl的概要说明：
	 *  @param dto
	 *  @throws Exception
	 *  Written by:ly
	 */
	@Aop( { "trans" })
	public void addProductinImpl(QproductDTO dto) throws Exception{
		Qproduct qpro=dao.fetch(Qproduct.class,Cnd.where("proid", "=", dto.getProid()));
		if(null!=qpro){
			if("2".equals(qpro.getCphyclbz())){
				 StringBuffer sb = new StringBuffer();
				sb.append(" update Qproduct set proname= '").append(dto.getProname());
				sb.append("' where proid= '").append(dto.getProid()).append("'") ;
				 Sql sql = Sqls.create(sb.toString()); 
				dao.execute(sql);
			}else{ 
			qpro.setBzgtin14(dto.getBzgtin14());// 包装溯源码。 包装符为2
			qpro.setProbzgg(dto.getProbzgg());// 包装规格
			qpro.setProbzq(dto.getProbzq());//  保质期
			qpro.setProbzqdwcode(dto.getProbzqdwcode());// 保质期单位代码aaa100=BZQDWMC 
			qpro.setProbzqdwmc(dto.getProbzqdwmc());// 保质期单位名称
			qpro.setProcdjd(dto.getProcdjd());// 产地/基地名称
			qpro.setProcpbzh(dto.getProcpbzh());// 产品标准号
			qpro.setProgg(dto.getProgg());// 规格型号
			qpro.setProgtin14(dto.getProgtin14());//产品溯源码。包装符为1
			qpro.setProname(dto.getProname());// 商品名称
			qpro.setProplxx(dto.getProplxx());// 配料信息
			qpro.setPropm(dto.getPropm());// 品名
			qpro.setProsb(dto.getProsb());// 商标
			qpro.setProsccj(dto.getProsccj());// 生产厂家
			qpro.setProsptm(dto.getProsptm());// 商品条码
			qpro.setProzl(dto.getProzl());// 产品种类 1一般产品 2养殖业有耳标脚环类产品
			qpro.setProcjdh(dto.getProcjdh());// 生产厂家电话
			qpro.setProcjdz(dto.getProcjdz());// 生产厂家电话
			qpro.setProjj(dto.getProjj());// 产品简介
			qpro.setProprice(dto.getProprice());// 价格
			dao.update(qpro);
			}
		} else {
			Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser(); 
			String v_id = DbUtils.getSequenceStr();
			Qproduct pro=new Qproduct(); 
			pro.setProcomid(vSysUser.getAaz001());//comid==procomid==userid
			pro.setProid(v_id); 
			pro.setBzgtin14(dto.getBzgtin14());// 包装溯源码。 包装符为2
			pro.setProbzgg(dto.getProbzgg());// 包装规格
			pro.setProbzq(dto.getProbzq());//  保质期
			pro.setProbzqdwcode(dto.getProbzqdwcode());// 保质期单位代码aaa100=BZQDWMC 
			pro.setProbzqdwmc(dto.getProbzqdwmc());// 保质期单位名称
			pro.setProcdjd(dto.getProcdjd());// 产地/基地名称
		    pro.setProcpbzh(dto.getProcpbzh());// 产品标准号
			pro.setProgg(dto.getProgg());// 规格型号
			pro.setProgtin14(dto.getProgtin14());//产品溯源码。包装符为1
			pro.setProname(dto.getProname());// 商品名称
			pro.setProplxx(dto.getProplxx());// 配料信息
			pro.setPropm(dto.getPropm());// 品名
			pro.setProsb(dto.getProsb());// 商标
			pro.setProsccj(dto.getProsccj());// 生产厂家
			pro.setProsptm(dto.getProsptm());// 商品条码
			pro.setProzl(dto.getProzl());// 产品种类 1一般产品 2养殖业有耳标脚环类产品
			pro.setProcjdh(dto.getProcjdh());// 生产厂家电话
			pro.setProcjdz(dto.getProcjdz());// 生产厂家电话
			pro.setCphyclbz(dto.getCphyclbz());// 产品或材料标识
			pro.setProjj(dto.getProjj());// 产品简介
			pro.setProprice(dto.getProprice());// 价格
			
			dao.insert(pro); 
		}
	}
	
	/**
	  * 
	  *  delProductin的中文名称：删除企业产品
	  *  delProductin的概要说明：
	  *  @param proid
	  *  @return
	  *  Written by:ly
	  */
	public String delProductin(String proid){
		try {
			delProductinImpl(proid);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		} 
		return null;
	}
	
	@Aop( { "trans" })
	public void delProductinImpl(String proid){
		dao.clear(Qproduct.class,Cnd.where("proid","=",proid));
	}
	
	/**
	 * 
	 * queryproductinZTreeAsync的中文名称：企业产品
	 * queryproductinZTreeAsync的概要说明：
	 * @param request
	 * @return
	 * @throws Exception
	 * Written by:ly
	 */
	@SuppressWarnings("rawtypes")
	public List  queryproductinZTreeAsync(HttpServletRequest request) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		String userid=vSysUser.getAaz001();
		String sb=" SELECT 0 AS proid,'企业产品列表' AS proname,-1 AS parentid, 'true' AS isparent, "
				+ " 'true' AS isopen  UNION ALL  "
			  	+ " SELECT proid, proname, 0 as parentid, 'false' AS isparent, 'false' AS isopen  "
			  	+ "FROM qproduct "
			  	+ "  where procomid =  '"+userid +"' and cphyclbz = '1'"; 
		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, QproductDTO.class);
	    List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
	
	/**
	 * 
	 * queryProductin的中文名称：查看产品材料详情
	 * queryProductin的概要说明：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by:ly
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryProductcl(QproductDTO dto,
				PagesDTO pd) throws Exception{
		if(null==dto.getProcomid()||"".equals(dto.getProcomid())){
			Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser(); 
 		    String userid=vSysUser.getAaz001();
 		    dto.setProcomid(userid);
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.proid, a.procomid, a.proname  ");
	    sb.append(" from qproduct a, qcphcldygx gx "); 
        sb.append(" where 1=1 ");
        sb.append(" and gx.cpclid = a.proid");
        sb.append(" and a.procomid=:procomid");
        sb.append(" and gx.proid=:proid");
        sb.append(" order by proid ");
		String sql = sb.toString();
		String[] ParaName = new String[] {"procomid","proid"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
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
	 * queryComCl的中文名称：查询企业材料
	 * 
	 * queryComCl的概要说明：
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryComCl(QproductDTO dto, PagesDTO pd) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser(); 
	    dto.setProcomid(vSysUser.getAaz001());
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.proid, a.proname  ");
	    sb.append(" from qproduct a "); 
	    sb.append(" where 1=1 ");
	    sb.append(" and a.cphyclbz = '2'"); // 原材料
	    sb.append(" and a.procomid = :procomid");
	    sb.append(" and a.proname like :proname");
	    sb.append(" and a.proid not in (");
	    sb.append(" 	select pro.proid from qproduct pro, qcphcldygx gx  ");
	    sb.append(" 	where gx.cpclid = pro.proid ");
	    sb.append(" 	and gx.proid = :proid)");
	    sb.append(" order by proid ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "procomid", "proname", "proid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		System.out.println("================="+sql);
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
	 * addComCls的中文名称：添加材料
	 * 
	 * addComCls的概要说明：
	 * 
	 * @param dto
	 * @return
	 * Written by:ly
	 */
	public String addProductCls(HttpServletRequest request, QproductDTO dto){
		try {
			addProductClsImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
		
	/**
	 * 
	 * addComClsImpl的中文名称：添加材料实现方法
	 * 
	 * addComClsImpl的概要说明：
	 * @param dto
	 *        Written by : zy
	 */
	public void addProductClsImpl(HttpServletRequest request, QproductDTO dto){
		// 获取要添加材料的商品
		String proid = StringHelper.showNull2Empty(request.getParameter("proid"));
		// 获取添加材料
		String JsonStr = request.getParameter("clStr");
		List<QproductDTO> proList = Json.fromJsonAsList(QproductDTO.class, JsonStr);
		for (int i = 0; i < proList.size(); i++) {
			QproductDTO product = (QproductDTO) proList.get(i);
			
			String v_id = DbUtils.getSequenceStr();
			Qcphcldygx se = new Qcphcldygx();
			se.setQcphcldygxid(v_id); // 产品或材料对应关系id
			se.setProid(proid); // 对应产品id
			se.setCpclid(product.getProid()); // 对应材料id
			dao.insert(se);
		}
	}
		
	/**
	 * 
	 * delprocl的中文名称：删除材料
	 * 
	 * delprocl的概要说明：
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String delprocl(QproductDTO dto){
		try {
			delproclImp(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	} 
		
	/**
	 * 
	 * delproclImp的中文名称：删除材料实现
	 * 
	 * delproclImp的概要说明：
	 * @param dto
	 *        Written by : zy
	 */
	@Aop( { "trans" })
	public void delproclImp(QproductDTO dto){
		dao.clear(Qcphcldygx.class,
				Cnd.where("proid", "=", dto.getProid())
				.and("cpclid", "=", dto.getCpclid())); // 删除qcphcldygx表中信息
	}
	 
	/**
	 * 
	 *  querykcsy的中文名称：查看进货库存剩余量
	 *  querykcsy的概要说明：
	 *  @param dto
	 *  @return
	 *  Written by:ly
	 * @throws Exception 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map querykcsy(@Param("..") QledgerstockDTO dto) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		dto.setLgtocomid(vSysUser.getAaz001());
		StringBuffer sb=new StringBuffer();
		sb.append(" SELECT * FROM qledgerstock q ");
		sb.append("  WHERE 1=1 ");
		sb.append(" AND qledgerstockid=:qledgerstockid ");
		sb.append(" AND q.lgtocomid=:lgtocomid ");//买方id ==此时企业id   买进就是企业拥有的
		String sql = sb.toString();
		 String[] ParaName = new String[] {"qledgerstockid","lgtocomid"};
		 int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR};

		 sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto ); 
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QledgerstockDTO.class );
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	/**
	 * 
	 *  savesales的中文名称：保存销售记录
	 *  savesales的概要说明：
	 *  @param dto
	 *  @return
	 *  Written by:ly
	 */
	public String savesales(@Param("..") QledgerstockDTO dto){
		try {
			savesalesImpl(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 
	 *  savesalesImpl的中文名称：保存销售记录的实现方法
	 *  savesalesImpl的概要说明：
	 *  @param dto
	 *  Written by:ly
	 */
	public void savesalesImpl(@Param("..") QledgerstockDTO dto) throws Exception {
		String v_id = DbUtils.getSequenceStr();
		Sysuser vSysUser = SysmanageUtil.getSysuser();

		Qledgersales sal = new Qledgersales();
		sal.setLqledgersalesid(v_id);//销货id
		sal.setLgsfromcomid(vSysUser.getAaz001());//卖方公司id
		if ("1".equals(dto.getLgcomfwnfww())) { // 如果是范围外企业
			sal.setLgsjylx("2");// 交易类型1 范围内交易 2范围外交易
		} else {
			sal.setLgsjylx("1");// 交易类型1 范围内交易 2范围外交易
		}
		sal.setLgsprobzgg(dto.getLgprobzgg());//包装规格
		sal.setLgsprobzq(dto.getLgprobzq());//保质期
		sal.setLgsprobzqdwmc(dto.getLgprobzqdwmc());// 保质期单位ID
		sal.setLgsprobzqdwcode(dto.getLgprobzqdwcode());//保质期单位名称
		sal.setLgsprocjdz(dto.getLgprocjdz());//厂家地址
		sal.setLgsprocode(dto.getLgprocode());//交易商品溯源码(范围外交易时 此字段为空)
		sal.setLgsprogg(dto.getLgprogg());// 规格
		sal.setLgsprojydwcode(dto.getLgprojydwcode());//食品包装计量单位
		sal.setLgsprodqrq(dto.getLgprodqrq());//到期日期
		sal.setLgsprojyrq(dto.getLgprojyrq());// 商品交易日期
		sal.setLgsprosptm(dto.getLgprosptm());//商品条码
		sal.setLgsproscrq(dto.getLgproscrq());//生产日期
		sal.setLgstocomid(dto.getLgtocomid());//买方公司ID
		//sal.setLgproscrq(DateUtil.getCurrentDate_String());  //生产日期
		sal.setLgsprojysl(dto.getLgprojysl().toString()); //交易商品数量
		sal.setLgsprojydwmc(dto.getLgprojydwmc()); //交易商品单位名称
		sal.setLgsprojyyf(dto.getLgprojyrq().substring(5, 6));// 商品交易月份
		sal.setLgsproname(dto.getLgproname());//商品名称
		sal.setLgspropc(dto.getLgpropc());//商品批次(范围外交易时 此字段为空)
		sal.setLgsprosccj(dto.getLgprosccj());// 生产厂家
		sal.setLgsproid(dto.getLgproid());// 交易商品ID
		dao.insert(sal);
		String qylb = vSysUser.getComsyqylx();
		if("1".equals(qylb)){        //1表示生产企业
			 StringBuffer sb = new StringBuffer();
			 sb.append(" update qproductpc set cppcsysl=REPLACE(cppcsysl,cppcsysl,cppcsysl-").append(dto.getLgprojysl()+")");
			 sb.append("  where proid= '").append(dto.getQledgerstockid()).append("'") ;
				 Sql sql = Sqls.create(sb.toString());
			dao.execute(sql);
		}else if("2".equals(qylb)){   //流通
			StringBuffer sb = new StringBuffer();
			sb.append(" update qledgerstock set lgprosysl=REPLACE(lgprosysl,lgprosysl,lgprosysl- ").append(dto.getLgprojysl()+")");
			sb.append(" where qledgerstockid= '").append(dto.getQledgerstockid()).append("'") ;
			Sql sql = Sqls.create(sb.toString());
			dao.execute(sql);
		}
	}
	/**
	 * 
	 *  querysckc的中文名称：查询 生产 库存
	 *  querysckc的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map querysckc(@Param("..") QledgerstockDTO dto) throws Exception{
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		dto.setLgfromcomid(vSysUser.getAaz001());
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT q.proid qledgerstockid, q.proid lgproid , q.proname lgproname, ");
		sb.append(" q.prosptm lgprosptm, q.progg lgprogg, q.prosccj lgprosccj ,q.probzq lgprobzq, ");
		sb.append(" q.probzqdwcode lgprobzqdwcode, q.probzqdwmc lgprobzqdwmc,  ");
		sb.append(" q.probzgg lgprobzgg,q.progtin14 lgprocode , ");
		sb.append(" q.procjdz lgprocjdz,  p.cppcscrq lgproscrq , ");
		sb.append(" p.cppcpch lgpropc ,p.cppcscsl lgprojysl ,p.cppcsysl lgprosysl, ");
		sb.append(" getaa10_aaa103('CPPCSCDWDM',p.cppcscdwdm) AS lgprojydwmc ");
		sb.append(" FROM qproduct q ,qproductpc p    ");
		sb.append(" WHERE p.proid = q.proid AND q.cphyclbz = '1' ");
		sb.append(" AND q.proid = :qledgerstockid ");
		sb.append(" AND q.procomid = :lgfromcomid ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "qledgerstockid", "lgfromcomid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto );
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QledgerstockDTO.class );
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	/**
	 * 
	 *  querySalesDetail的中文名称：查询销售明细
	 *  querySalesDetail的概要说明：
	 *  @param dto
	 *  @return
	 *  @throws Exception
	 *  Written by:ly
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map querySalesDetail(@Param("..") QledgersalesDTO dto) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		dto.setLgsfromcomid(vSysUser.getAaz001());
		StringBuffer sb=new StringBuffer();
	    sb.append("  SELECT q.* ,p.commc FROM  qledgersales q, pcompany p ");
	    sb.append(" WHERE 1=1 AND  p.comid=q.lgstocomid "); 
	    sb.append(" AND q.lgsfromcomid=:lgsfromcomid ");
	    sb.append(" AND q.lgsproid=:lgsproid  ");
	    sb.append(" AND q.lgspropc=:lgspropc  ");
	    String sql = sb.toString();
		 String[] ParaName = new String[] {"lgsfromcomid","lgsproid","lgspropc"};
		 int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		 sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto ); 
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QledgersalesDTO.class );
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	 public Map salestzjg(@Param("..") QledgersalesDTO dto) throws Exception{
		    StringBuffer sb=new StringBuffer();
		    sb.append("  SELECT q.* , p.commc FROM  qledgersales q , pcompany p ");
		    sb.append(" WHERE 1=1 AND p.comid=q.lgstocomid ");
			sb.append(" AND lgsfromcomid=:lgsfromcomid ");
			sb.append(" AND lgsproname like :lgsproname ");
			sb.append(" AND q.lgsprojyrq=:lgsprojyrq "); 
			sb.append(" AND q.lqledgersalesid=:lqledgersalesid ");
			sb.append(" AND q.lgsproid = :lgsproid ");
			String sql = sb.toString();
			String[] ParaName = new String[] {"lgsproname","lgsfromcomid","lgsprojyrq","lqledgersalesid","lgsproid"};
			 int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
			 sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto ); 
			Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, QledgersalesDTO.class );
			List ls = (List) m.get(GlobalNames.SI_RESULTSET);
			Map r = new HashMap();
			r.put("rows", ls);
			r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
			return r; 
	 }
}
