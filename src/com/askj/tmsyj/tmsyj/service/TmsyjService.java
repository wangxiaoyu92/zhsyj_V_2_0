package com.askj.tmsyj.tmsyj.service;

import com.zzhdsoft.siweb.service.BaseService;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.askj.tmsyj.tmsyj.dto.*;
import com.askj.tmsyj.tmsyj.entity.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import com.alibaba.druid.util.StringUtils;
import com.askj.baseinfo.service.pub.PubService;
import com.askj.jyjc.dto.JyjcypDTO;
import com.askj.jyjc.entity.Jyjcxm;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.Aa01;
import com.zzhdsoft.siweb.entity.Fj;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.utils.FileUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;


/**
 *
 * TmsyjService的中文名称：【透明食药监】service
 *
 * TmsyjService的描述：
 *
 * @author ：zjf
 * @version ：V1.0
 */
public class TmsyjService extends BaseService {
	protected static final Log log = Logs.get();
	@Inject
	private Dao dao;
	@Inject
	private PubService pubService;

	/**
	 * queryJinhuo 查询进货信息
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes"})
	public Map queryJinhuo(HttpServletRequest request, HjhbDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser(); // 6企业用户 8商户 7快检人员
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (vSysUser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		if (StringUtils.isEmpty(dto.getHviewjgztid())
				&& ("6".equals(vSysUser.getUserkind()) || "8".equals(vSysUser.getUserkind()))){
			dto.setHviewjgztid(vSysUser.getAaz001());
		}
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.jcypid,a.jhspjldw,a.jhscd,a.jhsjfxid,");//,a.jhsl
		sb.append("a.jhsjfxsztid,a.jcfs,a.jhprice,a.jhtotal,a.jhscrq,a.jhscpcm,");
		sb.append("a.jhhgzmlx,a.jhscjyjl,a.jhqycyjl,a.jhgysid,a.jhscsid,a.jhsptm,");
		sb.append("a.hviewjgztid,a.eptbh,a.aae011,a.aae036,a.jhkcl,a.jhqrbz,a.jhplh,");
		sb.append("c.spsb,c.spggxh,c.spbzq,c.spzxbzh,");

		if (!StringUtils.isEmpty(dto.getQuerybatchjinhuo())&&("1".equals(dto.getQuerybatchjinhuo()))){
			sb.append(" '' as hjhbid,'' as jhsl, ");
		}else{
			sb.append(" a.hjhbid,a.jhsl, ");
		};

		sb.append(" b.jgztmc,c.jcypmc,");
		sb.append(" getAa10_aaa103('spjldw', a.jhspjldw) jhspjldwmc, "); // 计量单位对应名称
		sb.append(" getAa10_aaa103('jhhgzmlx', a.jhhgzmlx) jhhgzmlxmc, "); // 进货合格证明类型名称
		sb.append(" getAa10_aaa103('jhscjyjl', a.jhscjyjl) jhscjyjlmc, "); // 生产检验结论名称
		sb.append(" getAa10_aaa103('jhqycyjl', a.jhqycyjl) jhqycyjlmc, "); // 企业查验结论名称
		sb.append(" (select max(t.fjpath) from fj t where t.fjwid=a.eptbh and fjtype='9') as jchhgzmpath, ");
		sb.append("(select t.jgztmc from hviewjgzt t where t.hviewjgztid=a.jhgysid ) as jhgysmc,");//and t.jgztlx='3'
		sb.append("(select t.jgztmc from hviewjgzt t where t.hviewjgztid=a.jhscsid ) as jhscsmc, ");	//and t.jgztlx='4'
//		sb.append("(select t.jgztkhmc from hjgztkhgx t where t.hjgztkhgxid=a.jhgysid and t.jgztkhgx='1') as jhgysmc,");
//		sb.append("(select t.jgztkhmc from hjgztkhgx t where t.hjgztkhgxid=a.jhscsid and t.jgztkhgx='2') as jhscsmc ");
		sb.append(" fun_jinhuojiance(a.hjhbid) as jhjcqk, "); // 进货检测情况
		sb.append(" (select count(t.fjwid) from fj t where t.fjwid=a.hjhbid and t.fjtype='12') as jhszspbz  ");//是否已经索证索票

		sb.append(" FROM hjhb a,hviewjgzt b,jyjcyp c");
		sb.append(" where a.hviewjgztid = b.hviewjgztid ");
		sb.append(" and a.jcypid = c.jcypid ");
		sb.append(" and a.hjhbid = :hjhbid ");
		sb.append(" and a.hviewjgztid = :hviewjgztid ");
		sb.append(" and a.aae036 >= :aae036start ");
		sb.append(" and a.aae036 <= :aae036end ");
		if (!StringUtils.isEmpty(dto.getJcypmc())){
			sb.append(" and c.jcypmc like '%"+dto.getJcypmc()+"%'");
		};
		sb.append(" and a.jcypid = :jcypid ");
		if (!StringUtils.isEmpty(dto.getQuerymaxjhjl())&&("1".equals(dto.getQuerymaxjhjl()))){
			sb.append(" and a.hjhbid in (select max(t.hjhbid) from hjhb t where t.hviewjgztid=:hviewjgztid and t.jcypid=:jcypid) ");
		};
		int v_querybatchhisdays=1;
		if (!StringUtils.isEmpty(dto.getQuerybatchhisdays())){
			v_querybatchhisdays=Integer.parseInt(dto.getQuerybatchhisdays());
		}
		if (!StringUtils.isEmpty(dto.getQuerybatchjinhuo())&&("1".equals(dto.getQuerybatchjinhuo()))){
			sb.append(" and a.hjhbid in (select max(t.hjhbid) from hjhb t where t.hviewjgztid=:hviewjgztid ");
			sb.append(" and t.aae036>=curdate()-"+v_querybatchhisdays+" group by t.jcypid ) ");
		};
		sb.append(" and a.jhplh = :jhplh ");

		if (!StringUtils.isEmpty(dto.getQuerybatchjinhuo())&&("2".equals(dto.getQuerybatchjinhuo()))){//2批量进货 双击主表查询
			sb.append(" order by hjhbid asc ");
		}else{
			sb.append(" order by hjhbid desc ");
		};


		String sql = sb.toString();

		// 转化sql语句
		String[] paramName = new String[] { "hjhbid", "hviewjgztid", "aae036start", "aae036end","jcypid","jhplh" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjhbDTO.class, pd.getPage(), pd.getRows());

		/*List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));*/
		return m;
	}

	/**
	 *
	 * saveJinhuo的中文名称：保存进货信息
	 *
	 * saveJinhuo的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	public String saveJinhuo(HttpServletRequest request, HjhbDTO dto) {
		try {
			saveJinhuoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveJinhuoImp(HttpServletRequest request, HjhbDTO dto) throws Exception{
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (vSysUser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		if (null != dto.getHjhbid() && !"".equals(dto.getHjhbid())) {
			//如果进货记录，产生了分销记录，不允许修改
			int v_count = dao.count(Hxhb.class, Cnd.where("hjhbid", "=", dto.getHjhbid()));
			if (v_count > 0){
				throw new BusinessException("不能修改：该进货记录已经产生了销货记录");
			}
			//开始修改
			Boolean v_updateSjfxsztid = false;
			Hjhb v_oldHjhb = dao.fetch(Hjhb.class, dto.getHjhbid());
			if (StringUtils.isEmpty(v_oldHjhb.getJhsjfxid())
					&& (!v_oldHjhb.getJhgysid().equals(dto.getJhgysid()))){
				v_updateSjfxsztid = true;
			}
			BeanHelper.copyProperties(dto, v_oldHjhb); // 拷贝对应的从前台传来的数据
			v_oldHjhb.setJhkcl(v_oldHjhb.getJhsl()); // 进出货库存量
			v_oldHjhb.setJhtotal(StringHelper.NullToZero(v_oldHjhb.getJhsl())
					.multiply(StringHelper.NullToZero(v_oldHjhb.getJhprice())));
			//如果上级 分销id不为空 供应商变化了的话需要 更新上级分销商主体id
			if (v_updateSjfxsztid){
				v_oldHjhb.setJhsjfxsztid(dto.getJhgysid());//上级分销商主体id 设置为 供应商的
			}
			dao.update(v_oldHjhb);
		} else {
			String v_hjhbid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();

			Hjhb v_Hjhb = new Hjhb();
			BeanHelper.copyProperties(dto, v_Hjhb); // 拷贝对应的从前台传来的数据
			v_Hjhb.setHjhbid(v_hjhbid);
			v_Hjhb.setHviewjgztid(vSysUser.getAaz001());
			v_Hjhb.setAae011(vSysUser.getDescription());
			v_Hjhb.setAae036(v_dbtime);
			v_Hjhb.setJhkcl(v_Hjhb.getJhsl());//进出货库存量
			v_Hjhb.setEptbh(v_hjhbid);//e票通编号,根据这个号能拉取所有的本次进货的分销信息
			v_Hjhb.setJhtotal(StringHelper.NullToZero(v_Hjhb.getJhsl())
					.multiply(StringHelper.NullToZero(v_Hjhb.getJhprice())));//进出货库存量
			v_Hjhb.setJhsjfxsztid(dto.getJhgysid()); // 首次进货上级分销商主体id 设置为 供应商的
			dao.insert(v_Hjhb);


			FjDTO v_fjdto = new FjDTO();
			v_fjdto.setFjwid(v_hjhbid);
			// 进货索证索票图片的保存
			v_fjdto.setFolderName("jinhuopiao");
			v_fjdto.setFjpath(dto.getSzsppath());
			v_fjdto.setFjname(dto.getSzspname());
			v_fjdto.setFjtype("12");
			pubService.saveFjWuzhuti(request, v_fjdto);

			// 检测图片的保存
			v_fjdto.setFolderName("jchhgzm");
			v_fjdto.setFjpath(dto.getJchhgzmpath());
			v_fjdto.setFjname(dto.getJchhgzmname());
			v_fjdto.setFjtype("9");
			pubService.saveFjWuzhuti(request, v_fjdto);
		}
	}

	/**
	 * 删除进出货信息，根据id删除
	 */
	public String delJinhuo(HttpServletRequest request, final HjhbDTO dto) {
		try {
			delJinhuoImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除进出货信息，实现类 交给事务管理
	 *
	 * @param request
	 * @param comid
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void delJinhuoImpl(HttpServletRequest request, HjhbDTO dto) throws Exception {
		if (!(dto.getHjhbid() == null || "".equals(dto.getHjhbid()))) {
			//如果进货记录，产生了分销记录，不允许修改
			int v_count = dao.count(Hxhb.class, Cnd.where("hjhbid", "=", dto.getHjhbid()));
			if (v_count > 0){
				throw new BusinessException("不能修改：该进货记录已经产生了销货记录");
			}
			//删除进出货合格证明图片信息
			pubService.delFjFromFjwid(request,dto.getHjhbid());
			// 删除进出货信息
			dao.clear(Hjhb.class, Cnd.where("hjhbid", "=", dto.getHjhbid()));
		}
	}

	/**
	 * 删除检测信息
	 */
	public String delJiance(HttpServletRequest request, final HjhbDTO dto) {
		try {
			delJianceImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除检测信息，实现类 交给事务管理
	 *
	 * @param request
	 * @param comid
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void delJianceImpl(HttpServletRequest request, HjhbDTO dto) throws Exception {
		if (!(dto.getHjhbid()== null || "".equals(dto.getHjhbid()))) {
			//如果进货记录，产生了分销记录，不允许修改
			int v_count=dao.count(Hxhb.class, Cnd.where("hjhbid", "=", dto.getHjhbid()));
			if (v_count>0){
				throw new BusinessException("不能删除检测信息：该进货记录已经产生了销货记录");
			}
			//获取主表信息
			Hjyjczb v_hjyjczb=dao.fetch(Hjyjczb.class, Cnd.where("jcztbzjid", "=", dto.getHjhbid()));
			//删除检测明细表信息
			dao.clear(Hjyjcmxb.class, Cnd.where("hjyjczbid", "=", v_hjyjczb.getHjyjczbid()));
			// 删除检测主表信息
			dao.clear(Hjyjczb.class, Cnd.where("jcztbzjid", "=", dto.getHjhbid()));
		}
	}

	/**
	 *
	 * saveXiaohuo的中文名称：保存进货信息
	 *
	 * saveXiaohuo的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	public String saveXiaohuo(HttpServletRequest request, HxhbDTO dto){
		try {
			saveXiaohuoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveXiaohuoImp(HttpServletRequest request, HxhbDTO dto) throws Exception{
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (vSysUser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		BigDecimal v_jhkcl = new BigDecimal(0);
		if (null != dto.getHxhbid() && !"".equals(dto.getHxhbid())) {
			//如果该销货记录对应的对应的新产生的进货记录，已经确认，或已经产生了分销记录不允许删除
			Hjhb v_newHjhb = dao.fetch(Hjhb.class, Cnd.where("hjhbid", "=", dto.getHjhbidnew()));
			if ("1".equals(v_newHjhb.getJhqrbz())){
				throw new BusinessException("不能修改：该分销记录已经被确认进货");
			}
			int v_count = dao.count(Hxhb.class, Cnd.where("hjhbid", "=", v_newHjhb.getHjhbid()));
			if (v_count > 0){
				throw new BusinessException("不能修改：该分销记录产生的进货记录，已经产生了销货记录");
			}

			Hxhb v_oldHxhb = dao.fetch(Hxhb.class, dto.getHxhbid());
			Hjhb v_firstHjhb = dao.fetch(Hjhb.class,v_oldHxhb.getHjhbid());
			//更新原进货记录的库存量
			v_jhkcl = StringHelper.NullToZero(v_oldHxhb.getXhsl())
					.subtract(StringHelper.NullToZero(dto.getXhsl()));
			v_jhkcl = StringHelper.NullToZero(v_firstHjhb.getJhkcl())
					.add(StringHelper.NullToZero(v_jhkcl));
			v_firstHjhb.setJhkcl(v_jhkcl);
			dao.update(v_firstHjhb);

			//修改销货记录
			BeanHelper.copyProperties(dto, v_oldHxhb); // 拷贝对应的从前台传来的数据
			v_oldHxhb.setXhtotal(StringHelper.NullToZero(v_oldHxhb.getXhsl())
					.multiply(StringHelper.NullToZero(v_oldHxhb.getXhprice())));
			dao.update(v_oldHxhb);

			//修改新生成的进货记录
			v_newHjhb.setJhsl(dto.getXhsl());//进货数量
			v_newHjhb.setJhspjldw(dto.getXhspjldw());//进货计量单位aaa100=spjldw
			v_newHjhb.setJhsjfxid(dto.getHjhbid());//上级分销id
			v_newHjhb.setJhprice(dto.getXhprice());//单价
			v_newHjhb.setJhtotal(StringHelper.NullToZero(v_newHjhb.getJhsl()).multiply(StringHelper.NullToZero(v_newHjhb.getJhprice())));//合计
			v_newHjhb.setHviewjgztid(dto.getHviewjgztid());
			v_newHjhb.setJhkcl(dto.getXhsl());//进货库存量
			v_newHjhb.setJcfs("2");//2上游流转 分销产生的进货默认检测方式 上游流转
			dao.update(v_newHjhb);
		}else{
			String v_hxhbid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
			//获取选择的进货记录
			Hjhb v_oldHjhb = dao.fetch(Hjhb.class, Cnd.where("hjhbid", "=", dto.getHjhbid()));

			//插入一条进货记录
			String v_newhjhbid = DbUtils.getSequenceStr();
			Hjhb v_Hjhb = new Hjhb();
			BeanHelper.copyProperties(v_oldHjhb, v_Hjhb); // 拷贝对应的从前台传来的数据
			v_Hjhb.setHjhbid(v_newhjhbid);
			v_Hjhb.setJhsl(dto.getXhsl());//进货数量
			v_Hjhb.setJhspjldw(dto.getXhspjldw());//进货计量单位aaa100=spjldw
			v_Hjhb.setJhsjfxid(dto.getHjhbid());//上级分销id
			v_Hjhb.setJhprice(dto.getXhprice());//单价
			v_Hjhb.setJhtotal(StringHelper.NullToZero(v_Hjhb.getJhsl())
					.multiply(StringHelper.NullToZero(v_Hjhb.getJhprice())));//合计
			v_Hjhb.setHviewjgztid(dto.getHviewjgztid());
			v_Hjhb.setAae011(vSysUser.getDescription());
			v_Hjhb.setAae036(v_dbtime);
			v_Hjhb.setJhkcl(dto.getXhsl());//进货库存量
			v_Hjhb.setJhqrbz("0");//进货确认标志0未确认1已确认
			v_Hjhb.setJhsjfxsztid(v_oldHjhb.getHviewjgztid());//进货上级分销商id
			dao.insert(v_Hjhb);

			//插入一条销货记录
			Hxhb v_Hxhb = new Hxhb();
			BeanHelper.copyProperties(dto, v_Hxhb); // 拷贝对应的从前台传来的数据
			v_Hxhb.setHxhbid(v_hxhbid);
			v_Hxhb.setXhtotal(StringHelper.NullToZero(v_Hxhb.getXhsl())
					.multiply(StringHelper.NullToZero(v_Hxhb.getXhprice())));
			v_Hxhb.setHjhbidnew(v_newhjhbid);//新生成的进货表id
			v_Hxhb.setAae011(vSysUser.getDescription());
			v_Hxhb.setAae036(v_dbtime);
			dao.insert(v_Hxhb);

			//更新原进货记录的库存量
			v_jhkcl = StringHelper.NullToZero(v_oldHjhb.getJhkcl())
					.subtract(StringHelper.NullToZero(dto.getXhsl()));
			v_oldHjhb.setJhkcl(v_jhkcl);
			dao.update(v_oldHjhb);
		}
	}

	/**
	 * queryXiaohuo 查询进货信息
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes"})
	public Map queryXiaohuo(HttpServletRequest request, HxhbDTO dto, PagesDTO pd) throws Exception {

		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (vSysUser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		dto.setHviewjgztid(vSysUser.getAaz001());
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.*,b.jgztmc,c.jcypmc,");
		sb.append(" getAa10_aaa103('spjldw', a.xhspjldw) xhspjldwmc, "); // 计量单位对应名称
		sb.append("d.jhsjfxid,d.jhkcl,d.jhspjldw,d.jhprice,d.jhscd,d.jhscrq,d.jhgysid,");
		sb.append("d.jhscsid,d.jhsptm,d.jhscpcm,");
		sb.append("(select t.jgztmc from hviewjgzt t where t.hviewjgztid=d.jhgysid and t.jgztlx='3') as jhgysmc,");
		sb.append("(select t.jgztmc from hviewjgzt t where t.hviewjgztid=d.jhscsid and t.jgztlx='4') as jhscsmc, ");
		sb.append("(select t.jgztmc from hviewjgzt t where t.hviewjgztid=e.hviewjgztid) as ghsmc,e.hviewjgztid as ghsid, ");
		sb.append(" e.jhqrbz as ghsjhqrbz ");
		sb.append(" FROM hxhb a,hviewjgzt b,jyjcyp c,hjhb d,hjhb e");
		sb.append(" where a.hviewjgztid = b.hviewjgztid ");
		sb.append(" and a.jcypid = c.jcypid ");
		sb.append(" and a.hjhbid = d.hjhbid ");
		sb.append(" and a.hjhbidnew = e.hjhbid ");
		sb.append(" and a.hxhbid = :hxhbid ");
		sb.append(" and d.hviewjgztid = :hviewjgztid ");
		sb.append(" and a.aae036 >= :aae036start ");
		sb.append(" and a.aae036 <= :aae036end ");
		sb.append(" and c.jcypmc like :jcypmc ");
		sb.append(" order by hxhbid desc ");
		String sql = sb.toString();

		// 转化sql语句
		String[] paramName = new String[] { "hxhbid", "hviewjgztid", "aae036start", "aae036end", "jcypmc" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HxhbDTO.class, pd.getPage(), pd.getRows());
		/*System.out.println("queryXiaohuo-sql "+sql);
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));*/
		return m;
	}

	/**
	 * 删除销货信息，根据id删除
	 */
	public String delXiaohuo(HttpServletRequest request, final HxhbDTO dto) {
		try {
			delXiaohuoImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除销货信息，实现类 交给事务管理
	 *
	 * @param request
	 * @param comid
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void delXiaohuoImpl(HttpServletRequest request, HxhbDTO dto) throws Exception {
		if (!(dto.getHxhbid()== null || "".equals(dto.getHxhbid()))) {
			//如果该销货记录对应的对应的新产生的进货记录，已经确认，或已经产生了分销记录不允许删除
			Hjhb v_newHjhb = dao.fetch(Hjhb.class, Cnd.where("hjhbid", "=", dto.getHjhbidnew()));
			if ("1".equals(v_newHjhb.getJhqrbz())){
				throw new BusinessException("不能删除：该分销记录已经被确认进货");
			}
			int v_count = dao.count(Hxhb.class, Cnd.where("hjhbid", "=", v_newHjhb.getHjhbid()));
			if (v_count > 0){
				throw new BusinessException("不能删除：该分销记录产生的进货记录，已经产生了销货记录");
			}

			//获取要删除的销货记录
			Hxhb v_delHxhb = dao.fetch(Hxhb.class, Cnd.where("hxhbid", "=", dto.getHxhbid()));
			//更新他从哪条分销过来的记录
			BigDecimal v_jhkcl = new BigDecimal(0);
			Hjhb v_srcHjhb = dao.fetch(Hjhb.class,Cnd.where("hjhbid", "=", v_delHxhb.getHjhbid()));
			v_jhkcl = StringHelper.NullToZero(v_srcHjhb.getJhkcl()).add(StringHelper.NullToZero(v_delHxhb.getXhsl()));
			v_srcHjhb.setJhkcl(v_jhkcl);
			dao.update(v_srcHjhb);
			//删除新生成的进货信息
			dao.clear(Hjhb.class, Cnd.where("hjhbid", "=", v_delHxhb.getHjhbidnew()));
			//删除销货记录
			dao.clear(Hxhb.class, Cnd.where("hxhbid","=",dto.getHxhbid()));
		}
	}

	/**
	 * queryJiancemx 查询检测明细
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJiancemx(HttpServletRequest request, HjyjcmxbDTO dto, PagesDTO pd) throws Exception {
//		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		String v_hjyjczbid="no";
		if (!StringUtils.isEmpty(dto.getHjyjczbid())){
			v_hjyjczbid=dto.getHjyjczbid();
		}
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.* ");
		sb.append(" FROM hjyjcmxb a ");
		sb.append(" where a.hjyjczbid ='"+v_hjyjczbid+"' ");
		String sql = sb.toString();
		// 转化sql语句
		//String[] paramName = new String[] {"hjhbid","hviewjgztid","aae036start","aae036end" };
		//int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
		//sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjyjcmxbDTO.class,
				pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 * queryJiancezb 查询检测主表
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJiancezb(HttpServletRequest request, HjyjczbDTO dto, PagesDTO pd) throws Exception {
//		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		String v_jcztbzjid="no";
		if (!StringUtils.isEmpty(dto.getJcztbzjid())){
			v_jcztbzjid=dto.getJcztbzjid();
		}
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.* ");
		sb.append(" FROM hjyjczb a ");
		sb.append(" where a.jcztbzjid ='"+v_jcztbzjid+"' ");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjyjczbDTO.class,
				pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * saveJiance的中文名称：保存检测信息
	 *
	 * saveJiance的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	public String saveJiance(HttpServletRequest request, HjyjczbDTO dto) {
		try {
			saveJianceImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveJianceImp(HttpServletRequest request, HjyjczbDTO dto) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		String v_hjyjczbid = "";

		if (null != dto.getHjyjczbid() && !"".equals(dto.getHjyjczbid())) {
			v_hjyjczbid=dto.getHjyjczbid();
			Hjyjczb v_oldHjyjczb=dao.fetch(Hjyjczb.class, Cnd.where("hjyjczbid", "=", v_hjyjczbid));
			BeanHelper.copyProperties(dto, v_oldHjyjczb); // 拷贝对应的从前台传来的数据
			dao.update(v_oldHjyjczb);

			//先删除检测明细
			dao.clear(Hjyjcmxb.class, Cnd.where("hjyjczbid", "=", v_hjyjczbid));
		}else{
			v_hjyjczbid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();
			//获取选择的进货记录
			//Hjhb v_oldHjhb=dao.fetch(Hjhb.class, Cnd.where("hjhbid", "=", dto.getHjhbid()));

			//保存检验检测主表信息
			Hjyjczb v_Hjyjczb=new Hjyjczb();
			BeanHelper.copyProperties(dto, v_Hjyjczb); // 拷贝对应的从前台传来的数据
			v_Hjyjczb.setHjyjczbid(v_hjyjczbid);
			v_Hjyjczb.setAae011(vSysUser.getDescription());
			v_Hjyjczb.setAae036(v_dbtime);
			v_Hjyjczb.setJcjyshbz("0");//检测检验审核标志0未审核1已审核
			dao.insert(v_Hjyjczb);
		}

		//保存检验检测明细表信息
		JSONArray v_array = null;
		Object[] v_objArray = null;
		v_array = JSONArray.fromObject(dto.getJcmxbgriddata());
		v_objArray = v_array.toArray();
		String v_hjyjcmxbid = "";
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			Hjyjcmxb v_Hjyjcmxb = (Hjyjcmxb) JSONObject.toBean(v_obj, Hjyjcmxb.class);
			// 获取物品明细id
			v_hjyjcmxbid = DbUtils.getSequenceStr();
			v_Hjyjcmxb.setHjyjcmxbid(v_hjyjcmxbid);
			v_Hjyjcmxb.setHjyjczbid(v_hjyjczbid);
			Jyjcxm v_jyjcxm=dao.fetch(Jyjcxm.class,Cnd.where("jcxmbh", "=", v_Hjyjcmxb.getJcxmid()));
			if (v_jyjcxm!=null){
				v_Hjyjcmxb.setJcxmmc(v_jyjcxm.getJcxmmc());
			}
			dao.insert(v_Hjyjcmxb);
		}

	}

	/**
	 * queryScpc 查询生产批次信息
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryScpc(HttpServletRequest request, HscpcbDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();//6企业用户 8商户 7快检人员
		if (StringUtils.isEmpty(dto.getHviewjgztid())
				&& ("6".equals(vSysUser.getUserkind()) || "8".equals(vSysUser.getUserkind())) ){
			dto.setHviewjgztid(vSysUser.getAaz001());
		}
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.*,b.jgztmc,b.jgztzzzmbh,c.jcypmc,");
		sb.append("getAa10_aaa103('SPJLDW',a.scspjldw) as scspjldwmc,");
		sb.append(" (select t.fjpath from fj t where t.fjwid=a.hscpcbid and fjtype='9') as jchhgzmpath ");
		sb.append(" FROM hscpcb a,hviewjgzt b,jyjcyp c");
		sb.append(" where a.hviewjgztid=b.hviewjgztid ");
		sb.append(" and a.jcypid=c.jcypid ");
		sb.append(" and a.hscpcbid=:hscpcbid ");
		sb.append(" and a.hviewjgztid=:hviewjgztid ");
		sb.append(" and a.aae036>=:aae036start ");
		sb.append(" and a.aae036<=:aae036end ");
		sb.append(" order by hscpcbid desc ");
		String sql = sb.toString();

		// 转化sql语句
		String[] paramName = new String[] {"hscpcbid","hviewjgztid","aae036start","aae036end" };
		int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HscpcbDTO.class,
				pd.getPage(), pd.getRows());

		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * saveScpc的中文名称：保存生产批次
	 *
	 * saveScpc的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	public String saveScpc(HttpServletRequest request, HscpcbDTO dto) {
		try {
			saveScpcImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveScpcImp(HttpServletRequest request, HscpcbDTO dto) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		if (null != dto.getHscpcbid() && !"".equals(dto.getHscpcbid())) {
			//如果进货记录，产生了分销记录，不允许修改
			int v_count=dao.count(Hscxhb.class, Cnd.where("hscpcbid", "=", dto.getHscpcbid()));
			if (v_count>0){
				throw new BusinessException("不能修改：该生产记录已经产生了销货记录");
			}
			//开始修改
			Hscpcb v_oldHscpcb=dao.fetch(Hscpcb.class, dto.getHscpcbid());
			BeanHelper.copyProperties(dto, v_oldHscpcb); // 拷贝对应的从前台传来的数据
			v_oldHscpcb.setSysl(v_oldHscpcb.getScsl());//
			dao.update(v_oldHscpcb);
		}else{
			String v_hscpcbid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();

			Hscpcb v_Hscpcb=new Hscpcb();
			BeanHelper.copyProperties(dto, v_Hscpcb); // 拷贝对应的从前台传来的数据
			v_Hscpcb.setHscpcbid(v_hscpcbid);
			v_Hscpcb.setHviewjgztid(vSysUser.getAaz001());
			v_Hscpcb.setAae011(vSysUser.getDescription());
			v_Hscpcb.setAae036(v_dbtime);
			v_Hscpcb.setSysl(v_Hscpcb.getScsl());//
			dao.insert(v_Hscpcb);

			//合格证明图片的保存
			FjDTO v_fjdto=new FjDTO();
			v_fjdto.setFjwid(v_hscpcbid);
			v_fjdto.setFolderName("jchhgzm");

			v_fjdto.setFjpath(dto.getJchhgzmpath());
			v_fjdto.setFjname(dto.getJchhgzmname());
			v_fjdto.setFjtype("9");
			pubService.saveFjWuzhuti(request,v_fjdto);
		}
	}
	/**
	 * 删除生产批次信息，根据id删除
	 */
	public String delScpc(HttpServletRequest request, final HscpcbDTO dto) {
		try {
			delScpcImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除进出货信息，实现类 交给事务管理
	 *
	 * @param request
	 * @param comid
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void delScpcImpl(HttpServletRequest request, HscpcbDTO dto) throws Exception {
		if (!(dto.getHscpcbid()== null || "".equals(dto.getHscpcbid()))) {
			//如果进货记录，产生了分销记录，不允许修改
			int v_count=dao.count(Hscxhb.class, Cnd.where("hscpcbid", "=", dto.getHscpcbid()));
			if (v_count>0){
				throw new BusinessException("不能修改：该进货记录已经产生了销货记录");
			}
			//删除生产批次合格证明图片信息
			pubService.delFjFromFjwid(request,dto.getHscpcbid());
			// 删除生产批次出库信息
			dao.clear(Hscpcb.class, Cnd.where("hscpcbid", "=", dto.getHscpcbid()));
		}
	}

	/**
	 * queryScxh 查询生产销货信息
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map queryScxh(HttpServletRequest request, HscxhbDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();//6企业用户 8商户 7快检人员
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (vSysUser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		if (StringUtils.isEmpty(dto.getHviewjgztid())
				&& ("6".equals(vSysUser.getUserkind()) || "8".equals(vSysUser.getUserkind())) ){
			dto.setHviewjgztid(vSysUser.getAaz001());
		}
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.*,b.jgztmc,b.jgztzzzmbh,c.jcypmc,d.sysl,d.scspjldw,d.scpch,");
		sb.append("getAa10_aaa103('SPJLDW',d.scspjldw) as scspjldwmc,");
		sb.append("(select t.jgztmc from hviewjgzt t where t.hviewjgztid=a.jxsid) as jxsmc,");
		sb.append(" (select t.fjpath from fj t where t.fjwid=a.hscpcbid and fjtype='9') as jchhgzmpath ");
		sb.append(" FROM hscxhb a,hviewjgzt b,jyjcyp c,hscpcb d");
		sb.append(" where a.hviewjgztid = b.hviewjgztid ");
		sb.append(" and a.jcypid = c.jcypid ");
		sb.append(" and a.hscpcbid = d.hscpcbid ");
		sb.append(" and a.hscxhbid = :hscxhbid ");
		sb.append(" and a.hviewjgztid = :hviewjgztid ");
		sb.append(" and a.aae036 >= :aae036start ");
		sb.append(" and a.aae036 <= :aae036end ");
		sb.append(" order by hscxhbid desc ");
		String sql = sb.toString();
		// 转化sql语句
		String[] paramName = new String[] {"hscxhbid","hviewjgztid","aae036start","aae036end" };
		int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HscxhbDTO.class,
				pd.getPage(), pd.getRows());

		/*List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));*/
		return m;
	}
	/**
	 *
	 * saveScxh的中文名称：保存生产销货
	 *
	 * saveScxh的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	public String saveScxh(HttpServletRequest request, HscxhbDTO dto) {
		try {
			saveScxhImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveScxhImp(HttpServletRequest request, HscxhbDTO dto) throws Exception{
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (vSysUser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		if (null != dto.getHscxhbid() && !"".equals(dto.getHscxhbid())) {
			//如果进货记录，产生了分销记录，不允许修改
//			int v_count=dao.count(Hscxhb.class, Cnd.where("hscxhbid", "=", dto.getHscxhbid()));
//			if (v_count>0){
//				throw new BusinessException("不能修改：该生产记录已经产生了销货记录");
//			}

			//获取生产批次表数据
			Hscpcb v_oldHscpcb = dao.fetch(Hscpcb.class, Cnd.where("hscpcbid", "=", dto.getHscpcbid()));
			v_oldHscpcb.setSysl(StringHelper.NullToZero(v_oldHscpcb.getSysl())
					.add(StringHelper.NullToZero(dto.getXssl())));
			dao.update(v_oldHscpcb);
			//开始修改
			Hscxhb v_oldHscxhb=dao.fetch(Hscxhb.class, dto.getHscxhbid());
			BeanHelper.copyProperties(dto, v_oldHscxhb); // 拷贝对应的从前台传来的数据
			dao.update(v_oldHscxhb);
		}else{
			String v_hscxhbid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();

			Hscxhb v_Hscxhb=new Hscxhb();
			BeanHelper.copyProperties(dto, v_Hscxhb); // 拷贝对应的从前台传来的数据
			v_Hscxhb.setHscxhbid(v_hscxhbid);
			v_Hscxhb.setHviewjgztid(vSysUser.getAaz001());
			v_Hscxhb.setAae011(vSysUser.getDescription());
			v_Hscxhb.setAae036(v_dbtime);
			dao.insert(v_Hscxhb);

			//获取生产批次表数据
			Hscpcb v_oldHscpcb=dao.fetch(Hscpcb.class, Cnd.where("hscpcbid", "=", dto.getHscpcbid()));
			v_oldHscpcb.setSysl(StringHelper.NullToZero(v_oldHscpcb.getSysl()).subtract(StringHelper.NullToZero(dto.getXssl())));
			dao.update(v_oldHscpcb);

		}
	}

	/**
	 * 删除生产销货信息，根据id删除
	 */
	public String delScxh(HttpServletRequest request, final HscxhbDTO dto) {
		try {
			delScxhImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除进出货信息，实现类 交给事务管理
	 *
	 * @param request
	 * @param comid
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void delScxhImpl(HttpServletRequest request, HscxhbDTO dto) throws Exception {
		if (!(dto.getHscxhbid()== null || "".equals(dto.getHscxhbid()))) {
			//如果进货记录，产生了分销记录，不允许修改
//			int v_count=dao.count(Hscxhb.class, Cnd.where("hscxhbid", "=", dto.getHscxhbid()));
//			if (v_count>0){
//				throw new BusinessException("不能修改：该进货记录已经产生了销货记录");
//			}
			//获取生产批次表数据
			Hscxhb v_hscxhb = dao.fetch(Hscxhb.class, Cnd.where("hscxhbid", "=", dto.getHscxhbid()));

			Hscpcb v_oldHscpcb = dao.fetch(Hscpcb.class, Cnd.where("hscpcbid", "=", v_hscxhb.getHscpcbid()));
			v_oldHscpcb.setSysl(StringHelper.NullToZero(v_oldHscpcb.getSysl())
					.add(StringHelper.NullToZero(v_hscxhb.getXssl())));
			dao.update(v_oldHscpcb);
			// 删除生产批次出库信息
			dao.clear(Hscxhb.class, Cnd.where("hscxhbid", "=", dto.getHscxhbid()));
		}
	}


	/**
	 *
	 *
	 *  saveCphycl的中文名称：保存产品和原材料
	 *
	 *  saveCphycl的概要说明：
	 * @author : ly
	 */
	public String saveCphycl(HttpServletRequest request, HcphycldybDTO dto) {
		try {
			saveCphyclImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({"trans"})
	public void saveCphyclImpl(HttpServletRequest request, HcphycldybDTO dto) throws Exception{
		// 获取要添加材料的商品
		String cpid = StringHelper.showNull2Empty(request.getParameter("cpid"));
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();

		//dao.delete(Hcphycldyb.class,Cnd.where("","",dto.get));

		String JsonStr = request.getParameter("yclStr");//clStr材料字符串
		List<JyjcypDTO> JyjcypDTOList = Json.fromJsonAsList(JyjcypDTO.class, JsonStr);
		for (int i = 0; i < JyjcypDTOList.size(); i++) {
			JyjcypDTO v_Jyjcyp = (JyjcypDTO)JyjcypDTOList.get(i);
			Hcphycldyb v_obj=new Hcphycldyb();
			String v_id = DbUtils.getSequenceStr();
			v_obj.setHcphycldybid(v_id); // 主键id
			v_obj.setCpid(cpid);// 产品id
			v_obj.setYclid(v_Jyjcyp.getJcypid());// 材料id
			v_obj.setAae036(v_dbtime);// 操作时间
			v_obj.setAae011(vSysUser.getDescription());;// 操作员
			v_obj.setHviewjgztid(vSysUser.getAaz001());
			dao.insert(v_obj);
		}
	}

	/**
	 *
	 *
	 *  delCphycl的中文名称：删除产品和原材料
	 *
	 *  delCphycl的概要说明：
	 * @author : ly
	 */
	public String delCpycl(HttpServletRequest request, HcphycldybDTO dto) {
		try {
			delCpyclImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({"trans"})
	public void delCpyclImpl(HttpServletRequest request, HcphycldybDTO dto) throws Exception{
//		Hcphycldyb cpycl =dao.fetch(Hcphycldyb.class,Cnd.where("hcphycldybid","=",dto.getHcphycldybid()));
//		if(cpycl !=null ){
//			  dao.clear(Hcphycldyb.class, Cnd.where("hcphycldybid","=",dto.getHcphycldybid()));
//		}
		dao.clear(Hcphycldyb.class,Cnd.where("hcphycldybid","=",dto.getHcphycldybid()));
	}

	@SuppressWarnings("rawtypes")
	public List queryCphycl(HttpServletRequest request, JyjcypDTO dto) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		String sb=" SELECT 0 AS jcypid ,'企业产品列表' AS jcypmc,-1 AS parentid, 'true' AS isparent, "
				+ " 'true' AS isopen  UNION ALL  "
				+ " SELECT jcypid, jcypmc , 0 as parentid, 'false' AS isparent, 'false' AS isopen  "
				+ " FROM jyjcyp "
				+ "  where hviewjgztid =  '"+vSysUser.getAaz001() +"' and spsjlx ='1' " ;
		Map m = DbUtils.DataQuery(GlobalNames.sql, sb.toString(), null, JyjcypDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryComCl(HcphycldybDTO dto, PagesDTO pd) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		dto.setHviewjgztid(vSysUser.getAaz001());
//		StringBuffer sb = new StringBuffer();

		String v_sql="select a.* "+
				" from jyjcyp a "+
				" where a.hviewjgztid='"+dto.getHviewjgztid()+"' "+
				" and a.spsjlx='2' "+
				" and not exists (select 1 from hcphycldyb t where t.yclid=a.jcypid and t.hviewjgztid='"+
				dto.getHviewjgztid()+"' and t.cpid='"+dto.getCpid()+"') ";

		Map m = DbUtils.DataQuery(GlobalNames.sql, v_sql, null, JyjcypDTO.class,
				pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List queryCpycl(HttpServletRequest request,
						   HcphycldybDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		String v_sql="select b.*,a.jcypid,a.jcypmc from jyjcyp a,hcphycldyb b "+
				" where a.jcypid=b.yclid and b.hviewjgztid='"+vSysUser.getAaz001()+
				"' and b.cpid='"+dto.getCpid()+"'";

		Map m = DbUtils.DataQuery(GlobalNames.sql, v_sql, null, HcphycldybDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", ls);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return ls;
	}

	/**
	 * queryChouyangbaogao 查询抽样报告信息
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryChouyangbaogao(HttpServletRequest request,
								   HjdjccybgDTO dto, PagesDTO pd) throws Exception {
//		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.*,b.jgztmc,c.jcypmc,");
		sb.append("(select count(t.fjwid) from fj t where t.fjwid=a.hjdjccybgid) as cybgtpscbz ");
		sb.append(" FROM hjdjccybg a,hviewjgzt b,jyjcyp c ");
		sb.append(" where a.hviewjgztid=b.hviewjgztid ");
		sb.append(" and a.jcypid=c.jcypid ");
		sb.append(" and a.hviewjgztid=:hviewjgztid ");
		sb.append(" and a.aae036>=:aae036start ");
		sb.append(" and a.aae036<=:aae036end ");
		if (!StringUtils.isEmpty(dto.getJgztmc())){
			sb.append(" and b.jgztmc like '%"+dto.getJgztmc()+"%' ");
		}
		sb.append(" order by hjdjccybgid desc ");
		String sql = sb.toString();

		// 转化sql语句
		String[] paramName = new String[] {"hviewjgztid","aae036start","aae036end" };
		int[] paramType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjdjccybgDTO.class,
				pd.getPage(), pd.getRows());

		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * saveChouyangbaogao的中文名称：保存抽样报告信息
	 *
	 * saveChouyangbaogao的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	public String saveChouyangbaogao(HttpServletRequest request, HjdjccybgDTO dto) {
		try {
			ChouyangbaogaoImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void ChouyangbaogaoImp(HttpServletRequest request, HjdjccybgDTO dto) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		if (null != dto.getHjdjccybgid() && !"".equals(dto.getHjdjccybgid())) {
			//开始修改
			Hjdjccybg v_oldHjdjccybg=dao.fetch(Hjdjccybg.class, dto.getHjdjccybgid());
			BeanHelper.copyProperties(dto, v_oldHjdjccybg); // 拷贝对应的从前台传来的数据
			dao.update(v_oldHjdjccybg);
		}else{
			String v_Hjdjccybgid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();

			Hjdjccybg v_Hjdjccybg=new Hjdjccybg();
			BeanHelper.copyProperties(dto, v_Hjdjccybg); // 拷贝对应的从前台传来的数据
			v_Hjdjccybg.setHjdjccybgid(v_Hjdjccybgid);
			v_Hjdjccybg.setAae011(vSysUser.getDescription());
			v_Hjdjccybg.setAae036(v_dbtime);
			dao.insert(v_Hjdjccybg);
		}
	}

	/**
	 * 删除抽样报告信息，根据id删除
	 */
	public String delChouyangbaogao(HttpServletRequest request, final HjdjccybgDTO dto) {
		try {
			delChouyangbaogaoImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除监督检查抽样报告信息，实现类 交给事务管理
	 *
	 * @param request
	 * @param comid
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void delChouyangbaogaoImpl(HttpServletRequest request, HjdjccybgDTO dto) throws Exception {
		if (!(dto.getHjdjccybgid()== null || "".equals(dto.getHjdjccybgid()))) {
			// 删除
			dao.clear(Hjdjccybg.class, Cnd.where("hjdjccybgid", "=", dto.getHjdjccybgid()));
		}
	}

	/**
	 *
	 * saveJianceyiqi的中文名称：保存检测仪器
	 *
	 * saveJianceyiqi的概要说明：
	 *
	 * @param dto
	 * @return Written by : gjf
	 *
	 */
	public String saveJianceyiqi(HttpServletRequest request, HjcjgjcyqbDTO dto) {
		try {
			saveJianceyiqiImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void saveJianceyiqiImp(HttpServletRequest request, HjcjgjcyqbDTO dto) throws Exception{
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		if (null != dto.getHjcjgjcyqbid() && !"".equals(dto.getHjcjgjcyqbid())) {
			//开始修改
			Hjcjgjcyqb v_oldHjcjgjcyqb=dao.fetch(Hjcjgjcyqb.class, dto.getHjcjgjcyqbid());
			BeanHelper.copyProperties(dto, v_oldHjcjgjcyqb); // 拷贝对应的从前台传来的数据
			dao.update(v_oldHjcjgjcyqb);
		}else{
			String v_Hjcjgjcyqbid = DbUtils.getSequenceStr();
			Timestamp v_dbtime = SysmanageUtil.getDbtimeYmdHnsTimestamp();

			Hjcjgjcyqb v_Hjcjgjcyqb=new Hjcjgjcyqb();
			BeanHelper.copyProperties(dto, v_Hjcjgjcyqb); // 拷贝对应的从前台传来的数据
			v_Hjcjgjcyqb.setHjcjgjcyqbid(v_Hjcjgjcyqbid);
			v_Hjcjgjcyqb.setAae011(vSysUser.getDescription());
			v_Hjcjgjcyqb.setAae036(v_dbtime);
			//Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
			//6企业用户 7快检人员 8商户
			//如果是 快检人员 身份 取快检人员所属企业的企业id 企业用户去sysuser.aaz001 其他人员取userid
			String v_hviewjgztid=vSysUser.getUserid();
//gu20180604			if ("6".equals(vSysUser.getUserkind()) || "8".equals(vSysUser.getUserkind())){
//				v_hviewjgztid=vSysUser.getAaz001();
//			}
//			if ("7".equals(vSysUser.getUserkind()) ){
//				Pcomry v_pcomry=dao.fetch(Pcomry.class, Cnd.where("ryid", "=", vSysUser.getAaz001()));
//				v_hviewjgztid=v_pcomry.getComid();
//			}
			String v_userkind=vSysUser.getUserkind();
			if ("6".equals(v_userkind)||"7".equals(v_userkind)||"8".equals(v_userkind)||"20".equals(v_userkind)||"21".equals(v_userkind)||"30".equals(v_userkind)){
				v_hviewjgztid=vSysUser.getUsercomid();
			};

			v_Hjcjgjcyqb.setHviewjgztid(v_hviewjgztid);
			dao.insert(v_Hjcjgjcyqb);
		}
	}

	/**
	 * 删除抽样报告信息，根据id删除
	 */
	public String delJianceyiqi(HttpServletRequest request, final HjcjgjcyqbDTO dto) {
		try {
			delJianceyiqiImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 * 删除检测仪器信息，实现类 交给事务管理
	 *
	 * @param request
	 * @param comid
	 * @throws Exception
	 */
	@Aop( { "trans" })
	public void delJianceyiqiImpl(HttpServletRequest request, HjcjgjcyqbDTO dto) throws Exception {
		if (!(dto.getHjcjgjcyqbid()== null || "".equals(dto.getHjcjgjcyqbid()))) {
			// 删除
			dao.clear(Hjcjgjcyqb.class, Cnd.where("hjcjgjcyqbid", "=", dto.getHjcjgjcyqbid()));
		}
	}

	/**
	 * queryJianceyiqi 查询检测仪器
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJianceyiqi(HttpServletRequest request, HjcjgjcyqbDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();//6企业用户 8商户 7快检人员
//	gu20180603	String v_hviewjgztid=vSysUser.getUserid();
//		if ("6".equals(vSysUser.getUserkind()) || "8".equals(vSysUser.getUserkind())){
//			v_hviewjgztid=vSysUser.getAaz001();
//		}
//		//如果是快检人员，取快检人员归属的快检机构
//		if ("7".equals(vSysUser.getUserkind())){
//			Pcomry v_Pcomry=dao.fetch(Pcomry.class, Cnd.where("ryid", "=", vSysUser.getAaz001()));
//			v_hviewjgztid=v_Pcomry.getComid();
//		}
//		if("1".equals(vSysUser.getUserkind())){
//			v_hviewjgztid = dto.getHviewjgztid();
//		}
		if (vSysUser == null) {//wxy 20180611手机端直接使用dto中的userid获取Sysuser
			vSysUser = dao.fetch(Sysuser.class, dto.getUserid());
		}
		String v_hviewjgztid=dto.getHviewjgztid();
		String v_userkind=vSysUser.getUserkind();
		//判断手机登录是否是企业用户
		if ("6".equals(v_userkind) || "7".equals(v_userkind) || "8".equals(v_userkind) || "20".equals(v_userkind) || "21".equals(v_userkind) || "30".equals(v_userkind)) {
			vSysUser.setUserdalei("2"); //企业用户
		}else{
			vSysUser.setUserdalei("1"); //非企业用户
		}
		if (StringUtils.isEmpty(v_hviewjgztid)){
			if ("20".equals(v_userkind) || "21".equals(v_userkind) || "6".equals(v_userkind)||"7".equals(v_userkind)||"8".equals(v_userkind)){
				v_hviewjgztid=vSysUser.getUsercomid();
			}else{
				v_hviewjgztid=vSysUser.getUserid();
			}
		}

		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT a.*,b.jgztmc ");
		sb.append(" from hjcjgjcyqb a left join hviewjgzt b on a.hviewjgztid=b.hviewjgztid ");
		sb.append(" where 1=1  ");
		if("1".equals(vSysUser.getUserdalei())){//非企业
			sb.append(" and a.aaa027='"+vSysUser.getAaa027()+"' ");
		}else{
			sb.append("  and a.hviewjgztid='"+v_hviewjgztid+"' ");
//			sb.append("  and a.userdalei='2' ");
		}

		sb.append(" and a.jcyqmc = :jcyqmc");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[] {"jcyqmc"};
		int[] paramType = new int[] {Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjcjgjcyqbDTO.class,
				pd.getPage(), pd.getRows());

		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * saveBatchjinhuo的中文名称：保存批量进货
	 *
	 * saveBatchjinhuo的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return Written by : zy
	 * @throws Exception
	 */
	public void saveBatchjinhuo(HttpServletRequest request, HjhbDTO dto) throws Exception {
		saveBatchjinhuoImp(request, dto);
	}

	/**
	 * @Description: 保存批量进货实现方法
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @author CatchU
	 */
	@Aop( { "trans" })
	public void saveBatchjinhuoImp(HttpServletRequest request, HjhbDTO dto)
			throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (vSysUser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}

		//新增操作
		//JSONArray v_arrayInserted = null;
		//Object[] v_objArrayInserted = null;

		//v_arrayInserted = JSONArray.fromObject(dto.getBatchjinhuoinsertrows());
		//v_objArrayInserted = v_arrayInserted.toArray();

		String v_hjhbid = null;

		Timestamp v_dbtime = SysmanageUtil.currentTime();
		List<HjhbDTO> lstinsert =new ArrayList();
		if (!StringUtils.isEmpty(dto.getBatchjinhuoinsertrows())){
			lstinsert = Json.fromJsonAsList(HjhbDTO.class, dto.getBatchjinhuoinsertrows());
		}

		List<HjhbDTO> lstupdate = new ArrayList();
		if (!StringUtils.isEmpty(dto.getBatchjinhuoupdaterows())){
			lstupdate = Json.fromJsonAsList(HjhbDTO.class, dto.getBatchjinhuoupdaterows());
		}
		//进货批量号  先从前台传过来的找，没有的用新生成的
		String v_jhplh = DbUtils.getSequenceStr();
//		for (int i = 0; i < lstinsert.size(); i++) {
//			HjhbDTO v_Hjhbdto = (HjhbDTO) lstinsert.get(i);
//			if (!StringUtils.isEmpty(v_Hjhbdto.getJhplh())){
//				v_jhplh=v_Hjhbdto.getJhplh();
//				break;
//			}
//		};
//		if (StringUtils.isEmpty(v_jhplh)){
//			for (int i = 0; i < lstupdate.size(); i++) {
//				HjhbDTO v_Hjhbdto = (HjhbDTO) lstupdate.get(i);
//				if (!StringUtils.isEmpty(v_Hjhbdto.getJhplh())){
//					v_jhplh=v_Hjhbdto.getJhplh();
//					break;
//				}
//			}
//		};
		if (!StringUtils.isEmpty(dto.getJhplh())){
			v_jhplh = dto.getJhplh();
		};



		for (int i = 0; i < lstinsert.size(); i++) {
			HjhbDTO v_Hjhbdto = (HjhbDTO) lstinsert.get(i);
			//for (int i = 0; i <= v_objArrayInserted.length - 1; i++) {
			//JSONObject v_obj = JSONObject.fromObject(v_objArrayInserted[i]);
			//HjhbDTO v_Hjhbdto = (HjhbDTO) JSONObject.toBean(v_obj, HjhbDTO.class);
			if ((v_Hjhbdto.getJhsl()!=null) &&
					(Integer.parseInt(v_Hjhbdto.getJhsl().toString())>0)){
				v_hjhbid = DbUtils.getSequenceStr();

				Hjhb v_Hjhb=new Hjhb();
				BeanHelper.copyProperties(v_Hjhbdto, v_Hjhb); // 拷贝对应的从前台传来的数据

				v_Hjhb.setHjhbid(v_hjhbid);
				v_Hjhb.setHviewjgztid(vSysUser.getAaz001());
				v_Hjhb.setAae011(vSysUser.getDescription());
				v_Hjhb.setAae036(v_dbtime);
				v_Hjhb.setJhkcl(v_Hjhb.getJhsl());//进出货库存量
				v_Hjhb.setEptbh(v_hjhbid);//e票通编号,根据这个号能拉取所有的本次进货的分销信息
				v_Hjhb.setJhtotal(StringHelper.NullToZero(v_Hjhb.getJhsl())
						.multiply(StringHelper.NullToZero(v_Hjhb.getJhprice())));//进出货库存量
				v_Hjhb.setJhsjfxsztid(v_Hjhbdto.getJhgysid()); // 首次进货上级分销商主体id 设置为 供应商的
				v_Hjhb.setJhplh(v_jhplh);
				v_Hjhb.setJhqrbz("0");
				dao.insert(v_Hjhb);
			}
		};

		//更新记录
		//JSONArray v_arrayUpdated = null;
		//Object[]  v_objArrayUpdated = null;
		//v_arrayUpdated = JSONArray.fromObject(dto.getBatchjinhuoupdaterows());
		//v_objArrayUpdated = v_arrayUpdated.toArray();

		for (int i = 0; i < lstupdate.size(); i++) {
			HjhbDTO v_HjhbDtoUpdate = (HjhbDTO) lstupdate.get(i);
			//for (int i = 0; i <= v_objArrayUpdated.length - 1; i++) {
			//JSONObject v_obj = JSONObject.fromObject(v_objArrayUpdated[i]);
			//HjhbDTO v_HjhbDtoUpdate = (HjhbDTO) JSONObject.toBean(v_obj, HjhbDTO.class);
			if ((v_HjhbDtoUpdate.getJhsl()!=null) &&
					(Integer.parseInt(v_HjhbDtoUpdate.getJhsl().toString())>0)){

				//主键为空仍然做新增操作
				if (StringUtils.isEmpty(v_HjhbDtoUpdate.getHjhbid())){
					v_hjhbid = DbUtils.getSequenceStr();

					Hjhb v_Hjhb=new Hjhb();
					BeanHelper.copyProperties(v_HjhbDtoUpdate, v_Hjhb); // 拷贝对应的从前台传来的数据

					v_Hjhb.setHjhbid(v_hjhbid);
					v_Hjhb.setHviewjgztid(vSysUser.getAaz001());
					v_Hjhb.setAae011(vSysUser.getDescription());
					v_Hjhb.setAae036(v_dbtime);
					v_Hjhb.setJhkcl(v_Hjhb.getJhsl());//进出货库存量
					v_Hjhb.setEptbh(v_hjhbid);//e票通编号,根据这个号能拉取所有的本次进货的分销信息
					v_Hjhb.setJhtotal(StringHelper.NullToZero(v_Hjhb.getJhsl())
							.multiply(StringHelper.NullToZero(v_Hjhb.getJhprice())));//进出货库存量
					v_Hjhb.setJhsjfxsztid(v_HjhbDtoUpdate.getJhgysid()); // 首次进货上级分销商主体id 设置为 供应商的
					v_Hjhb.setJhplh(v_jhplh);
					v_Hjhb.setJhqrbz("0");
					dao.insert(v_Hjhb);
				}else{//更新操作
					//如果进货记录，产生了分销记录，不允许修改
					int v_count = dao.count(Hxhb.class, Cnd.where("hjhbid", "=", v_HjhbDtoUpdate.getHjhbid()));
					if (v_count > 0){
						throw new BusinessException("不能修改：商品名称为："+
								v_HjhbDtoUpdate.getJcypmc()+"的进货记录已经产生了销货记录");
					}
					//开始修改
					Boolean v_updateSjfxsztid = false;
					Hjhb v_oldHjhb = dao.fetch(Hjhb.class, v_HjhbDtoUpdate.getHjhbid());
					if (StringUtils.isEmpty(v_oldHjhb.getJhsjfxid())
							&& (!v_oldHjhb.getJhgysid().equals(dto.getJhgysid()))){
						v_updateSjfxsztid = true;
					}
					BeanHelper.copyProperties(v_HjhbDtoUpdate, v_oldHjhb); // 拷贝对应的从前台传来的数据
					v_oldHjhb.setJhkcl(v_oldHjhb.getJhsl()); // 进出货库存量
					v_oldHjhb.setJhtotal(StringHelper.NullToZero(v_oldHjhb.getJhsl())
							.multiply(StringHelper.NullToZero(v_oldHjhb.getJhprice())));
					//如果上级 分销id不为空 供应商变化了的话需要 更新上级分销商主体id
					if (v_updateSjfxsztid){
						v_oldHjhb.setJhsjfxsztid(v_HjhbDtoUpdate.getJhgysid());//上级分销商主体id 设置为 供应商的
					}
					dao.update(v_oldHjhb);
				}
			}
		};
	};

	/**
	 * queryJinhuo 查询进货信息
	 * gjf
	 */
	@SuppressWarnings({ "rawtypes"})
	public Map queryJinhuoBatchMain(HttpServletRequest request, HjhbDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser(); // 6企业用户 8商户 7快检人员
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			vSysUser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (vSysUser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		if (StringUtils.isEmpty(dto.getHviewjgztid())
				&& ("6".equals(vSysUser.getUserkind()) || "8".equals(vSysUser.getUserkind()))){
			dto.setHviewjgztid(vSysUser.getAaz001());
		}

		String v_aaz001="no";
		if (!StringUtils.isEmpty(vSysUser.getAaz001())){
			v_aaz001=vSysUser.getAaz001();
		}
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		//sb.append(" select distinct a.jhplh,max(a.aae011) as aae011,max(a.aae036) as aae036 ");
		sb.append(" select distinct a.jhplh,max(a.aae011) as aae011,max(a.aae036) as aae036 ");
		sb.append(" from hjhb a ");
		sb.append(" where  1=1 ");
		sb.append(" and a.hviewjgztid='"+v_aaz001+"'");
		sb.append(" and a.aae036 >= :aae036start ");
		sb.append(" and a.aae036 <= :aae036end ");
		sb.append(" group by a.jhplh ");
		sb.append(" order by jhplh desc ");
		String sql = sb.toString();

		// 转化sql语句
		String[] paramName = new String[] {"aae036start", "aae036end"};
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, HjhbDTO.class, pd.getPage(), pd.getRows());

		/*List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));*/
		return m;
	}

	@SuppressWarnings({ "rawtypes" })
	public Map queryJgztpicList(HttpServletRequest request, HjgztxgpicDTO dto,
								PagesDTO pd) throws Exception{
		// 获取当前用户
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT h.*, ");
		sb.append("(select count(t.fjwid) from fj t where t.fjwid=h.hjgztxgpicid ) as uploadflag ");
		sb.append(" FROM hjgztxgpic h ");
		sb.append(" where 1=1 ");
		sb.append(" and h.aae036 >= :aae036start ");
		sb.append(" and h.aae036 <= :aae036end ");
		sb.append(" and h.hjgztxgpicid=:hjgztxgpicid ");
		sb.append(" and h.jgztpickind=:jgztpickind ");
		sb.append(" and h.hviewjgztid = '"+sysuser.getAaz001()+"' "); // 监管主体客户关系表id
		sb.append(" order by h.hjgztxgpicid desc ");

		String[] ParaName = new String[] {"aae036start","aae036end","hjgztxgpicid","jgztpickind"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null, null, pd.getPage(), pd.getRows());
		return m ;
	}

	/**
	 *
	 *
	 *  saveKhgx的中文名称：保存更新客户关系
	 *
	 *  saveKhgx的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String saveJgztpic(HttpServletRequest request, HjgztxgpicDTO dto){
		try {
			saveJgztpicImpl(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 *
	 *
	 *  saveJgztpicImpl的中文名称：实现客户关系的 保存 更新
	 *
	 *  saveJgztpicImpl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	@Aop("trans")
	public void saveJgztpicImpl(HttpServletRequest request, HjgztxgpicDTO dto) throws Exception{
		// 获取当前用户
		Sysuser sysuser = (Sysuser)SysmanageUtil.getSysuser();
		// 配合手机端接口使用
		String userid = StringHelper.showNull2Empty(request.getParameter("userid"));
		if (!"".equals(userid)) {
			sysuser = dao.fetch(Sysuser.class, Cnd.where("USERID", "=", userid));
		} else {
			if (sysuser == null) {
				throw new BusinessException("操作员id不能为空");
			}
		};

		Hjgztxgpic hjgztxgpic = new Hjgztxgpic();
		BeanHelper.copyProperties(dto, hjgztxgpic);
		if("".equals(dto.getHjgztxgpicid()) || dto.getHjgztxgpicid() == null){
			String v_Hjgztxgpicid = DbUtils.getSequenceStr();
			hjgztxgpic.setHjgztxgpicid(v_Hjgztxgpicid);
			hjgztxgpic.setHviewjgztid(sysuser.getAaz001());
			hjgztxgpic.setAae011(sysuser.getDescription());
			hjgztxgpic.setAae036(SysmanageUtil.currentTime());
			dao.insert(hjgztxgpic);
		}else{
			dao.update(hjgztxgpic);
		}
	}

	/**
	 *
	 *
	 *  delJgztpic的中文名称：删除监管主体相关图片
	 *
	 *  delJgztpic的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 */
	public String delJgztpic(HttpServletRequest request,HjgztxgpicDTO dto){
		try {
			delJgztpicImpl(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 *
	 *
	 *  delJgztpicImpl的中文名称：删除监管主体相关图片
	 *
	 *  delJgztpicImpl的概要说明：
	 *
	 * @param dto
	 * @return
	 * @author : ly
	 * @throws Exception
	 */
	@Aop("trans")
	public void delJgztpicImpl(HttpServletRequest request,HjgztxgpicDTO dto) throws Exception{
		if(!"".equals(dto.getHjgztxgpicid()) && dto.getHjgztxgpicid() != null){
			Hjgztxgpic hjgztxgpic = dao.fetch(Hjgztxgpic.class, dto.getHjgztxgpicid());
			if(hjgztxgpic != null){
				//先删除相关图片
				pubService.delFjFromFjwid(request,dto.getHjgztxgpicid());

				dao.delete(Hjgztxgpic.class,dto.getHjgztxgpicid());
			}else{
				throw new BusinessException("没有这条信息！！！");
			}
		}else{
			throw new BusinessException("主键不能为空！！！");
		}
	}

	/**
	 *
	 * createJinHuoSpQRcode：创建进货商品二维码
	 *
	 * @param request
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop("trans")
	public void createJinHuoSpQRcode(HttpServletRequest request) throws Exception {
		// 进货id
		String hjhbid = StringHelper.myDecodeURI(request.getParameter("hjhbid"));
		// e票通编号
		String eptbh = StringHelper.myDecodeURI(request.getParameter("eptbh"));
		// 企业id
		String comid = StringHelper.myDecodeURI(request.getParameter("comid"));
		// 根路径
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		// 二维码保存路径
		String v_dir=rootPath + "upload\\qrcode\\";
		String codePath =  v_dir+ eptbh + ".gif";//+ File.separator

		//先删除原来的二维码图片
		if(FileUtil.checkFile(codePath)){
			FileUtil.delFile(codePath);
		}
		File v_file=new File(v_dir);
		if (!v_file.exists()){
			v_file.mkdir();
		}
		// 获取进货溯源码前缀
		Aa01 aa01 = SysmanageUtil.getAa01("JHSYMQZ");
		// 二维码内容
		String codeInfo = aa01.getAaa005() + eptbh + "&hjhbid=" + hjhbid + "&comid=" + comid;
		SysmanageUtil.createQrcode(codePath, codeInfo, ""); // 创建二维码
		System.out.println("==================="+codeInfo);
		// 创建成功后保存
		Fj fj = new Fj();
		fj.setFjczsj(SysmanageUtil.currentTime()); // 操作时间
		fj.setFjid(DbUtils.getSequenceStr()); // 附件id
		fj.setFjpath("/upload/qrcode/" + eptbh + ".gif"); // 路径
		fj.setFjtype("1"); // 默认图片
		fj.setFjwid(hjhbid);
		fj.setFjname(eptbh + ".gif"); // 附件名
		dao.insert(fj);
	}

	/**
	 * 我要投诉分页查询
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public Map queryAqjgWyts(HttpServletRequest request,PcomtousuDTO dto, PagesDTO pd) throws Exception {
		//拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT p.pcomtousuid, p1.commc, p.tsrmc,p.tsnr,p.tssj,p.sfsl,p.slrxm,p.slyj,p.slsj ");
		sb.append(" FROM pcomtousu p ,pcompany p1 WHERE p.comid=p1.comid ORDER BY p.tssj DESC");
		if(!"".equals(dto.getComid())&& dto.getComid()!=null){
			sb.append(" AND p.comid='"+dto.getComid()+"'");
		}
		String sql = sb.toString();
		String[] paramName = new String[]{};
		int[] paramType = new int[]{};
		sql = QueryFactory.getSQL(sql, paramName, paramType,dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PcomtousuDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("rows", list);
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return SysmanageUtil.execAjaxResult(map, null);
	}

	/**
	 * addAqjgWyts : 受理我要投诉
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Object updateAqjgWyts(HttpServletRequest request, PcomtousuDTO dto) throws Exception {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String tssj = sdf.format(new java.util.Date());
		Pcomtousu wyts = null;
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();

		wyts = dao.fetch(Pcomtousu.class, dto.getPcomtousuid());
		if(wyts!=null){
			wyts.setSlyj(dto.getSlyj());
			wyts.setSlrid(vSysUser.getUserid());
			wyts.setSlrxm(vSysUser.getUsername());
			wyts.setSlsj(tssj);
			wyts.setSfsl("1");
		}

		int i=dao.update(wyts);

		return i;
	}
}
