package com.askj.tmsyj.tmsyj.service;

import cn.jpush.api.utils.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.askj.baseinfo.dto.*;
import com.askj.baseinfo.entity.PcompanyXkz;
import com.askj.baseinfo.entity.Pgzpj;
import com.askj.baseinfo.entity.Pgzpjmx;
import com.askj.baseinfo.service.PcompanyService;
import com.askj.baseinfo.service.pub.PubService;
import com.askj.jk.dto.JkDTO;
import com.askj.jyjc.dto.JyjcndwjDTO;
import com.askj.jyjc.dto.JyjcypDTO;
import com.askj.jyjc.entity.Jyjcndwj;
import com.askj.jyjc.entity.Jyjcndwjmx;
import com.askj.jyjc.entity.Jyjcyp;
import com.askj.spsy.dto.QproductDTO;
import com.askj.supervision.dto.BsCheckMasterDTO;
import com.askj.supervision.dto.PcompanynddtpjDTO;
import com.askj.supervision.entity.BsCheckMaster;
import com.askj.supervision.entity.Bscheckplan;
import com.askj.tmsyj.tmsyj.dto.*;
import com.askj.tmsyj.tmsyj.entity.*;
import com.lbs.commons.GlobalNameS;
import com.lbs.leaf.exception.BusinessException;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.FjDTO;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.PubParentChildDto;
import com.zzhdsoft.siweb.dto.UploadfjDTO;
import com.zzhdsoft.siweb.entity.*;
import com.zzhdsoft.siweb.entity.news.News;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.HttpUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.PubFunc;
import com.zzhdsoft.utils.db.QueryFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.log.Log;
import org.nutz.log.Logs;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * TmsyjApiService的中文名称：【透明食药监】api接口service
 *
 * TmsyjApiService的描述：
 *
 * @author ：zjf
 * @version ：V1.0
 */
public class TmsyjApiService extends BaseService {
	protected static final Log log = Logs.get();
	@Inject
	private Dao dao;
	@Inject
	private PcompanyService pcompanyService;
	@Inject
	private PubService pubService;

	/**
	 *
	 * getAa01List的中文名称：获取系统参数表Aa01
	 *
	 * getAa01List的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getAa01List(HttpServletRequest request,Aa01 dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from Aa01 a ");
		sb.append(" where upper(a.aaa001) = '").append(dto.getAaa001().toUpperCase()).append("'");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null,pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getAa10List的中文名称：获取系统代码表Aa10
	 *
	 * getAa10List的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getAa10List(HttpServletRequest request,Aa10 dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from Aa10 a ");
		sb.append(" where upper(a.aaa100) = '").append(dto.getAaa100().toUpperCase()).append("'");
		if(!"".equals(StringHelper.showNull2Empty(dto.getAaa102()))){
			sb.append(" and a.aaa102 in (").append(dto.getAaa102()).append(")");
		}
		// 添加aaa104 可以根据大类类别获取所属小类信息
		if(!"".equals(StringHelper.showNull2Empty(dto.getAaa104()))){
			sb.append(" and a.aaa104 in (").append(dto.getAaa104()).append(") ");
		}
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null,pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getAa13List的中文名称：获取统筹区列表
	 *
	 * getAa13List的概要说明：aae383 in(3,4)|县、乡行政区划
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getAa13List(HttpServletRequest request, Aa13 dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select baz001,aaa027,aaa129,aaa148,aae383 ");
		sb.append(" from Aa13 a ");
		sb.append(" where 1 = 1 ");
		sb.append("   and ( a.aaa027 = :aaa027 or a.aaa148 = :aaa148 and 1=1 ) ");//zjf 括号里前后加空格，最后必须加1=1
		if(!"".equals(StringHelper.showNull2Empty(dto.getAae383()))){
			sb.append(" and a.aae383 in (").append(dto.getAae383()).append(")");
		}
		sb.append("   order by aaa027 ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "aaa027","aaa148"};
		int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR  };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getAreaTabList的中文名称：获取公众端统筹区tab列表
	 *
	 * getAreaTabList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getAreaTabList(HttpServletRequest request, Aa13 dto,PagesDTO pd) throws Exception {
		Aa01 aa01 = dao.fetch(Aa01.class, Cnd.where("aaa001", "=", "SYSAAA027"));
		if(aa01!=null){
			dto.setAaa027(aa01.getAaa005());
			dto.setAaa148(aa01.getAaa005());
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select baz001,aaa027,aaa129,aaa148,aae383 ");
		sb.append(" from Aa13 a ");
		sb.append(" where 1 = 1 ");
		sb.append("   and ( a.aaa027 = :aaa027 or a.aaa148 = :aaa148 and 1=1 ) ");//zjf 括号里前后加空格，最后必须加1=1
		if(!"".equals(StringHelper.showNull2Empty(dto.getAae383()))){
			sb.append(" and a.aae383 in (").append(dto.getAae383()).append(")");
		}
		sb.append("   order by aaa027 ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "aaa027","aaa148"};
		int[] ParaType = new int[] { Types.VARCHAR,Types.VARCHAR  };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getNewsList的中文名称：获取新闻列表
	 *
	 * getNewsList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getNewsList(HttpServletRequest request, News dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,newstitle,newsauthor,newsfrom, ");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx, ");
		sb.append(" b.cateid,b.catejc,catename ");
		sb.append(" from News a,Newscate b ");
		sb.append(" where 1 = 1 ");
		sb.append("   and a.cateid = b.cateid ");
		sb.append("   and b.cateid = :cateid ");
		sb.append("   and b.catejc like :catejc ");
		sb.append("   and a.newsid = :newsid");
		sb.append("   order by a.newstjsj desc");
		String sql = sb.toString();
		String[] ParaName = new String[] { "cateid", "catejc", "newsid"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getPreNews的中文名称：获取上一条新闻
	 *
	 * getPreNews的概要说明：
	 *
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@SuppressWarnings("rawtypes")
	public Map getPreNews(HttpServletRequest request, News dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,cateid,newstitle,newsauthor,newsfrom,");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx");
		sb.append("  from news");
		sb.append(" where 1 = 1");
		sb.append("   and cateid = :cateid");
		sb.append("   and newsid < :newsid");
		if ("oracle".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   and rownum = 1");
		} else if ("mysql".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   order by newsid desc limit 1");
		}

		String[] ParaName = new String[] { "cateid", "newsid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class);
		return m;
	}

	/**
	 *
	 * getNextNews的中文名称：获取下一条新闻
	 *
	 * getNextNews的概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 *
	 */
	@SuppressWarnings("rawtypes")
	public Map getNextNews(HttpServletRequest request, News dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,cateid,newstitle,newsauthor,newsfrom,");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx");
		sb.append("  from news");
		sb.append(" where 1 = 1");
		sb.append("   and cateid = :cateid");
		sb.append("   and newsid > :newsid");
		if ("oracle".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   and rownum = 1");
		} else if ("mysql".equalsIgnoreCase(GlobalNameS.DATABASE)) {
			sb.append("   order by newsid asc limit 1");
		}

		String[] ParaName = new String[] { "cateid", "newsid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class);
		return m;
	}

	/**
	 *
	 * getPcompanyList的中文名称：获取企业列表
	 *
	 * getPcompanyList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getPcompanyList(HttpServletRequest request, PcompanyDTO dto,
			PagesDTO pd) throws Exception {
		// 是否只显示监控企业(0：否；1：是)
		Aa01 aa01 = SysmanageUtil.getAa01("ISONLYSHOWJKCOM");
		String isOnlyShowJkCom = aa01.getAaa005();

		String preYear = String.valueOf(DateUtil.getCurrentYear());
		StringBuffer sb = new StringBuffer();
		sb.append(" select  distinct a.*,");
		sb.append(" (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name,");
		sb.append(" (select t.fjpath from Fj t where t.fjwid=a.comid and fjtype='4') as icon, ");
		sb.append(" (select t.qrcodepath from Pcomqrcode t where t.comid=a.comid) as qrcode, ");
		sb.append(" (select t.lhfjndpddj from Pcompanynddtpj t where t.comid=a.comid and t.pdyear='").append(preYear).append("') as lhfjndpddj ");
		sb.append(" from Pcompany a  ");
		if (isOnlyShowJkCom != null && "1".equals(isOnlyShowJkCom)) {
			sb.append(" , Jk b, Pcompanyimport c  ");
			sb.append("  where 1=1 ");
			sb.append("  and  b.jkqybh = a.comid ");
			sb.append("  and  a.comid = c.comid ");
		} else {
			sb.append(" where 1=1");
		}
		sb.append(" and a.comid = :comid ");
		sb.append(" and a.commc like :commc ");
		sb.append(" and a.aaa027 like :aaa027 ");
		sb.append(" and a.comspjkbz like :comspjkbz ");
		sb.append(" and a.comfwnfww = '0' ");
//GU20180623		if(!"".equals(StringHelper.showNull2Empty(dto.getComdalei()))){
//			sb.append(" and find_in_set(").append(dto.getComdalei()).append(",a.comdalei) ");
//		};
		if(!"".equals(StringHelper.showNull2Empty(dto.getComdalei()))){
			sb.append(" and exists (select 1 from pcompanycomdalei t where t.comid=a.comid and t.comdalei like '%"+dto.getComdalei()+"%') ");
		};

//gu20180402		if(!"".equals(StringHelper.showNull2Empty(dto.getComxiaolei()))){
//			sb.append(" and find_in_set(").append(dto.getComxiaolei()).append(",a.comxiaolei) ");
//		}
//gu20180623		if(!"".equals(StringHelper.showNull2Empty(dto.getComxiaolei()))){
//			sb.append(" and find_in_set(").append(dto.getComxiaolei()).append(",a.comdalei) ");
//		};
		if(!"".equals(StringHelper.showNull2Empty(dto.getComxiaolei()))){
			sb.append(" and exists (select 1 from pcomxiaolei t where t.comid=a.comid and t.comxiaolei like '%" + dto.getComdalei() + "%') ");
		};
		sb.append(" order by (a.orderno+0) desc");

		String sql = sb.toString();
		String[] paramName = new String[] { "comid", "commc", "aaa027", "comspjkbz" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getPcompanyRcjdglryList的中文名称：获取企业日常监督管理员列表
	 *
	 * getPcompanyJdglryList的概要说明：日常监督管理员
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getPcompanyRcjdglryList(HttpServletRequest request, PcomryDTO dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select pcomrcjdglryid,comid,b.userid,username,description, ");
		sb.append("  mobile,mobile2,orgname,zfryid,zfryzjhm,zfryzw, ");
		sb.append(" (select max(fjpath) from Fj t where t.fjwid=b.zfryid) as icon ");
		sb.append(" from Pcomrcjdglry a,Viewzfry b  ");
		sb.append(" where 1=1");
		sb.append(" and a.userid = b.userid ");
		sb.append(" and a.comid = :comid ");
		String sql = sb.toString();
		String[] paramName = new String[] { "comid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getPcompanyXkzList ： 获取企业资质证明信息
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @user : zy
	 */
	@SuppressWarnings("rawtypes")
	public Map getPcompanyXkzList(HttpServletRequest request, PcompanyXkzDTO dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select p.comxkzid, p.comid,p.comxkzbh, p.comxkfw, p.comxkyxqq, p.comxkyxqz, p.comxkzlx, ");
		sb.append(" p.comxkzzcxs, p.comxkzztyt, p.comxkzjycs, getAa10_aaa103('COMZZZM', p.comxkzlx) comxkzlxstr, ");
		sb.append(" concat('ZZZM',p.comxkzlx) as fjtype,");
		sb.append(" (select t.fjpath from fj t where t.fjwid=p.comxkzid and fjtype=concat('ZZZM',p.comxkzlx)) as fjpath ");
		sb.append(" from Pcompanyxkz p");
		sb.append(" where 1 = 1");
		sb.append(" and comid = :comid "); // 根据公司id获取对应信息列表
		sb.append(" and p.comxkzid = :comxkzid"); // 根据许可证id获取单个信息

		String sql = sb.toString();
		String[] paramName = new String[] { "comid", "comxkzid" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * savePcompanyXkz : 保存企业许可证
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	public String savePcompanyXkz(HttpServletRequest request, PcompanyXkzDTO dto) {
		try {
			savePcompanyXkzImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * savePcompanyXkzImp ： 保存企业许可证实现方法
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @user : zy
	 */
	@Aop( { "trans" })
	public void savePcompanyXkzImp(HttpServletRequest request, PcompanyXkzDTO dto) throws Exception {

		if (dto.getComxkzid() != null && !"".equals(dto.getComxkzid())) {
			PcompanyXkz v_xkz = dao.fetch(PcompanyXkz.class, dto.getComxkzid());
			v_xkz.setComxkfw(dto.getComxkfw()); // 许可范围
			v_xkz.setComxkyxqq(dto.getComxkyxqq()); // 许可有效期起
			v_xkz.setComxkyxqz(dto.getComxkyxqz()); // 许可有效期止
			v_xkz.setComxkzbh(dto.getComxkzbh()); // 许可证编号
			v_xkz.setComxkzjycs(dto.getComxkzjycs()); // 经营场所
			v_xkz.setComxkzlx(dto.getComxkzlx()); // 许可证类型
			v_xkz.setComxkzzcxs(dto.getComxkzzcxs()); // 组成形式
			v_xkz.setComxkzztyt(dto.getComxkzztyt()); // 主体业态
			dao.update(v_xkz);
		} else {
			PcompanyXkz v_xkz = new PcompanyXkz();
			v_xkz.setComxkzid(DbUtils.getSequenceStr()); // id
			v_xkz.setComid(dto.getComid()); // 公司id
			v_xkz.setComxkfw(dto.getComxkfw()); // 许可范围
			v_xkz.setComxkyxqq(dto.getComxkyxqq()); // 许可有效期起
			v_xkz.setComxkyxqz(dto.getComxkyxqz()); // 许可有效期止
			v_xkz.setComxkzbh(dto.getComxkzbh()); // 许可证编号
			v_xkz.setComxkzjycs(dto.getComxkzjycs()); // 经营场所
			v_xkz.setComxkzlx(dto.getComxkzlx()); // 许可证类型
			v_xkz.setComxkzzcxs(dto.getComxkzzcxs()); // 组成形式
			v_xkz.setComxkzztyt(dto.getComxkzztyt()); // 主体业态
			dao.insert(v_xkz);
		}
	}

	/**
	 *
	 * delPcompanyXkz : 删除企业许可证信息
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	public String delPcompanyXkz(HttpServletRequest request, PcompanyXkzDTO dto) {
		try {
			delPcompanyXkzImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * delPcompanyXkzImp ：删除企业许可证信息实现方法
	 * @param request
	 * @param dto
	 * @throws Exception
	 * @user : zy
	 */
	@Aop( { "trans" })
	public void delPcompanyXkzImp(HttpServletRequest request, PcompanyXkzDTO dto) throws Exception {

		if (dto.getComxkzid() != null && !"".equals(dto.getComxkzid())) {
			// 删除附件
			List<Fj> v_listFj = dao.query(Fj.class, Cnd.where("fjwid", "=", dto.getComxkzid()));
			for (Fj v_fj : v_listFj){
				// 刪除服務器上的附件
				String rootPath = request.getSession().getServletContext().getRealPath("/");
				v_fj.setFjpath(rootPath + File.separator + v_fj.getFjpath());
				File file = new File(v_fj.getFjpath());
				if (file.exists()) {
					file.delete();
				}
				dao.delete(v_fj);
			}
			//删除留样信息
			dao.clear(PcompanyXkz.class,Cnd.where("comxkzid", "=", dto.getComxkzid()));
		}
	}

	/**
	 *
	 * getPcompanyXkzFjList的中文名称：获取企业相关许可证附件
	 *
	 * getPcompanyXkzFjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getPcompanyXkzFjList(HttpServletRequest request, PcompanyXkzDTO dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select comid,comxkzid,comxkzlx,fjid,fjwid,fjpath,fjname,fjtype ");
		sb.append(" from Pcompanyxkz,Fj  ");
		sb.append(" where 1=1");
		sb.append(" and comxkzid = fjwid ");
		sb.append(" and comid = :comid ");
		if(!"".equals(StringHelper.showNull2Empty(dto.getComxkzlx()))){
			sb.append(" and comxkzlx in (").append(dto.getComxkzlx()).append(")");
		}

		String sql = sb.toString();
		String[] paramName = new String[] { "comid", "comxkzlx" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getPcomryList的中文名称：获取企业人员列表
	 *
	 * getPcomryList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getPcomryList(HttpServletRequest request, PcomryDTO dto,
			PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select comid, ryid, ryxm, rybeginwork ,rysflb, rylxdh, ");
		sb.append(" ryzt, getAa10_aaa103('ryzt',ryzt) ryztmc,");
		sb.append(" ryzwgw, getAa10_aaa103('ryzwgw',ryzwgw) ryzwgwmc, ");
		sb.append(" (select t.fjpath from Fj t where t.fjwid = ryid and t.fjtype = '7') as ryicon ");
		sb.append(" from Pcomry   ");
		sb.append(" where 1=1");
		sb.append(" and comid = :comid ");
		sb.append(" and ryid = :ryid ");
		sb.append(" and rysfspaqgly = :rysfspaqgly "); // 是否食品安全监管员
		sb.append(" and rysfjdgsry = :rysfjdgsry "); // 是否监督公示人员
		sb.append(" and ryxm like :ryxm "); // 根据人员姓名模糊查询

		String sql = sb.toString();
		String[] paramName = new String[] { "comid", "ryid", "rysfspaqgly", "rysfjdgsry", "ryxm" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getFjList的中文名称：获取附件列表
	 *
	 * getFjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getFjList(HttpServletRequest request, FjDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select * ");
		sb.append(" from Fj  ");
		sb.append(" where 1=1");
		sb.append(" and fjid = :fjid ");
		sb.append(" and fjwid = :fjwid ");
		if(!"".equals(StringHelper.showNull2Empty(dto.getFjtype()))){
			sb.append(" and fjtype in (").append(dto.getFjtype()).append(")");
		}

		String sql = sb.toString();
		String[] paramName = new String[] { "fjid","fjwid" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR  };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getPfjList的中文名称：获取pfj表中的附件列表
	 *
	 * getPfjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getPfjList(HttpServletRequest request, FjDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append(" from fj a ");
		sb.append(" where 1=1");
		sb.append(" and a.fjwid = :fjwid ");

		String sql = sb.toString();
		String[] paramName = new String[] { "fjwid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * delFj的中文名称：删除附件表
	 *
	 * delFj的概要说明：
	 *
	 * @param dto
	 * @return Written by : zjf
	 *
	 */
	public String delFj(HttpServletRequest request, final FjDTO dto) {
		try {
			delFjImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void delFjImp(HttpServletRequest request, final FjDTO dto) {
		String fjidStr = dto.getFjid();
		String[] a = PubFunc.split(fjidStr, ",");
		for (int i = 0; i < a.length; i++) {
			// 删除附件表
			Fj fj = dao.fetch(Fj.class, Cnd.where("fjid", "=", a[i]));
			// 刪除服務器上的附件
			String rootPath = request.getSession().getServletContext()
					.getRealPath("/");
			fj.setFjpath(rootPath + File.separator + fj.getFjpath());
			File file = new File(fj.getFjpath());
			if (file.exists()) {
				file.delete();
			}
			dao.delete(fj);
		}
	}

	/**
	 *
	 * getJkyList的中文名称：获取监控源列表
	 *
	 * getJkyList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getJkyList(HttpServletRequest request,JkDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		// 左关联监控企业负责人表，查看是否指派监管人
		sb.append("  select t.*, case when d.jkqyfzrid then true  ELSE false end as ishavejgy from (");
		sb.append("   select jkid,jkymc,jkybh,jkqybh,jkqymc,jklx,jksppath,a.orderno,camorgid,b.aaa027,");
		sb.append("   (select aaa129 from Aa13 where aaa027 = b.aaa027) aaa027name,c.state,c.synchtime ");
		sb.append("   from Jk a,Pcompany b,Pcompanyimport c ");
		sb.append("   where 1=1 ");
		sb.append("   and  a.jkqybh = b.comid ");
		sb.append("   and  b.comid = c.comid ");
		sb.append("   and  a.jkid = :jkid ");
		sb.append("   and  a.jkybh like :jkybh ");
		sb.append("   and  a.jkqybh like :jkqybh ");
		sb.append("   and  a.jkqymc like :jkqymc ");
		sb.append("   and  a.jklx = :jklx ");
		sb.append("   and  b.aaa027 like :aaa027 ");
		sb.append("   and  c.state = :state ");
		sb.append("   order by c.state desc, a.orderno ");
		sb.append("   ) t LEFT JOIN jkqyfzr d ON t.jkqybh = d.comid ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "jkid", "jkybh", "jkqybh", "jkqymc", "jklx","aaa027","state" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR , Types.VARCHAR ,Types.VARCHAR , Types.VARCHAR, Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getTygcList的中文名称：获取天眼工程离线视频列表
	 *
	 * getTygcList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getTygcList(HttpServletRequest request,JkDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("   select jkid,jkymc,jkybh,jkqybh,jkqymc,jklx,jksppath,orderno,camorgid,aaa027,");
		sb.append("   (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name ");
		sb.append("   from Jk a ");
		sb.append("   where 1=1 ");
		sb.append("   and  a.jklx = :jklx ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "jklx"};
		int[] ParaType = new int[] { Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * addPgzpj的中文名称：新增公众评价信息
	 *
	 * addPgzpj的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author ：zjf
	 */
	public String addPgzpj(HttpServletRequest request,PgzpjDTO dto) {
		try {
			addPgzpjImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void addPgzpjImp(HttpServletRequest request,PgzpjDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		String v_pjcs = dto.getPjcs();
		String v_pjxj = dto.getPjxj();
		String[] a = PubFunc.split(v_pjcs, ",");
		String[] b = PubFunc.split(v_pjxj, ",");

		Pgzpj pgzpj = new Pgzpj();
		String pgzpjid = DbUtils.getSequenceStr();
		pgzpj.setPgzpjid(pgzpjid);
		pgzpj.setPjztid(dto.getPjztid());
		pgzpj.setPjztmc(dto.getPjztmc());
		pgzpj.setPjbt(dto.getPjbt());
		pgzpj.setPjnr(dto.getPjnr());
		pgzpj.setPjr(dto.getPjr());
		pgzpj.setPjsj(startTime);
		pgzpj.setPjdj(dto.getPjdj());
		dao.insert(pgzpj);

		for(int i=0;i<a.length;i++){
			Pgzpjmx pgzpjmx = new Pgzpjmx();
			String pgzpjmxid = DbUtils.getSequenceStr();
			pgzpjmx.setPgzpjmxid(pgzpjmxid);
			pgzpjmx.setPgzpjid(pgzpjid);
			pgzpjmx.setPjcs(a[i]);
			int pjxjs = Integer.valueOf(b[i]);
			pgzpjmx.setPjxj(String.valueOf(pjxjs));
			dao.insert(pgzpjmx);
		}
	}

	/**
	 *
	 * getPgzpjList的中文名称：获取公众评价列表
	 *
	 * getPgzpjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getPgzpjList(HttpServletRequest request, PgzpjDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select pgzpjid,pjztid,pjztmc,pjbt,pjnr,pjdj,pjr,pjsj ");
		sb.append(" from Pgzpj a  ");
		sb.append(" where 1=1");
		sb.append(" and a.pjztid = :pjztid ");
		sb.append(" and a.pgzpjid = :pgzpjid ");
		sb.append(" order by a.pjsj desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "pjztid","pgzpjid" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getPgzpjmxList的中文名称：获取公众评价明细信息
	 *
	 * getPgzpjmxList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
//	@SuppressWarnings("rawtypes")
//	public Map getPgzpjmxList(HttpServletRequest request, PgzpjDTO dto,PagesDTO pd) throws Exception {
//		StringBuffer sb = new StringBuffer();
//		sb.append(" select a.pgzpjid,pjztid,pjztmc,pjbt,pjnr,pjdj,pjr,pjsj, ");
//		sb.append(" pjcs,getAa10_aaa103('pjcs',b.pjcs) as pjcsmc,pjxj ");
//		sb.append(" from Pgzpj a,Pgzpjmx b  ");
//		sb.append(" where 1=1");
//		sb.append(" and a.pgzpjid = b.pgzpjid ");
//		sb.append(" and a.pjztid = :pjztid ");
//		sb.append(" and a.pgzpjid = :pgzpjid ");
//
//		String sql = sb.toString();
//		String[] paramName = new String[] { "pjztid","pgzpjid" };
//		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR};
//		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
//		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
//		return m;
//	}

	/**
	 *
	 * getPgzpjmxList的中文名称：获取公众评价明细信息
	 *
	 * getPgzpjmxList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getPgzpjmxList(HttpServletRequest request, PgzpjDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.pgzpjid,pjsj,GROUP_CONCAT(pjcs SEPARATOR ',')pjcs, ");
		sb.append(" GROUP_CONCAT(getAa10_aaa103 ('pjcs', b.pjcs) SEPARATOR ',') ");
		sb.append(" pjcsmc,GROUP_CONCAT(pjxj SEPARATOR ',') pjxj ");
		sb.append(" FROM Pgzpj a RIGHT JOIN pgzpjmx b ON a.pgzpjid=b.pgzpjid");
		sb.append("  WHERE a.pjztid = :pjztid GROUP BY a.pgzpjid ");

		String sql = sb.toString();
		String[] paramName = new String[]{"pjztid"};
		int[] paramType = new int[]{Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * uploadJyjc的中文名称：检验检测数据上传
	 *
	 * uploadJyjc的概要说明：对接快检设备
	 *
	 * @param dto
	 * @return
	 * @author ：zjf
	 */
	public String uploadJyjc(HjyjczbmxbDTO dto) {
		try {
			uploadJyjcImp(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@Aop( { "trans" })
	public void uploadJyjcImp(HjyjczbmxbDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		Hjyjczb hjyjczb = new Hjyjczb();
		String hjyjczbid = DbUtils.getSequenceStr();
		hjyjczb.setHjyjczbid(hjyjczbid);
		hjyjczb.setHviewjgztid(dto.getComid());
		hjyjczb.setHviewjgztmc(dto.getCommc());
		hjyjczb.setJcorgid(dto.getJcorgid());
		hjyjczb.setJcorgmc(dto.getJcorgmc());
		hjyjczb.setJcrymc(dto.getJcrymc());
		hjyjczb.setJcypmc(dto.getJcypmc());
		hjyjczb.setSbxh(dto.getSbxh());
		hjyjczb.setSbxlh(dto.getSbxlh());
		hjyjczb.setJyjcrq(startTime);
		dao.insert(hjyjczb);

		Hjyjcmxb hjyjcmxb = new Hjyjcmxb();
		String hjyjcmxbid = DbUtils.getSequenceStr();
		hjyjcmxb.setHjyjcmxbid(hjyjcmxbid);
		hjyjcmxb.setHjyjczbid(hjyjczbid);
		hjyjcmxb.setJcxmmc(dto.getJcxmmc());
		hjyjcmxb.setJcz(dto.getJcz());
		hjyjcmxb.setSzdw(dto.getSzdw());
		hjyjcmxb.setBzz(dto.getBzz());
		hjyjcmxb.setXlbz(dto.getXlbz());
		hjyjcmxb.setJyjcjl(dto.getJyjcjl());
		dao.insert(hjyjcmxb);
	}

	/**
	 *
	 * getJyjcjgList的中文名称：获取检验检测结果列表
	 *
	 * getJyjcjgList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getJyjcjgList(HttpServletRequest request, HjyjczbmxbDTO dto,PagesDTO pd) throws Exception {
		//TODO  b.jcxmbh 不存在
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.hjyjczbid,hviewjgztid,hviewjgztmc,jcorgid,jcorgmc,jcryid,jcrymc,jcypid,jcypmc,a.aae011,");
		sb.append(" hjyjcmxbid,b.jcxmid,jcxmmc,jcz,szdw,bzz,xlbz,jyjcrq, ");
		sb.append(" jyjcjl,getAa10_aaa103('jyjcjl',b.jyjcjl) jyjcjlmc ");
		sb.append(" from Hjyjczb a,Hjyjcmxb b  ");
		sb.append(" where 1=1");
		sb.append(" and a.hjyjczbid = b.hjyjczbid ");
		sb.append(" and a.hviewjgztid = :comid ");
		sb.append(" order by a.jyjcrq desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "comid"  };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}
	/**
	 *
	 * getJyjcjgList的中文名称：获取检验检测结果列表
	 *
	 * getJyjcjgList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getJcbgList(HttpServletRequest request, HjhbDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("select * from fj t ");
		sb.append(" where fjtype='9' and  (exists (select 1 from hjhb t2 where t2.hjhbid=t.fjwid and t2.hviewjgztid=:hviewjgztid)");
		sb.append("   or exists (select 1 from hjyjczb t3 where t3.hjyjczbid=t.fjwid and t3.hviewjgztid=:hviewjgztid) )");
		sb.append("  order by t.fjid desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hviewjgztid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getJdjcResultList的中文名称：获取监督检查结果列表
	 *
	 * getJdjcResultList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getJdjcResultList(HttpServletRequest request, BsCheckMasterDTO dto, PagesDTO pd)throws Exception {
		//dto.setYear(String.valueOf(DateUtil.convertDateToYear(new Date())));//本年度
		// 使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select c.commc,a.comid,a.resultid, a.operatedate,a.resultdate, a.resultstate, a.resultremark,b.plancode,b.plantitle, ");
		sb.append(" b.plantype,getAa10_aaa103('plantype',b.plantype) as plantypeinfo, ");
		sb.append(" b.planchecktype,getAa10_aaa103('ITEMTYPE',b.plantype) as planchecktypeinfo, ");
		sb.append(" (select concat(c.username,'(',c.description,')') from sysuser c where c.userid=a.operateperson )  as operateperson ");
		sb.append(" from Bscheckmaster a, Bscheckplan b,Pcompany c ");
		sb.append("where a.planid = b.planid   ");
		sb.append("  and a.comid = c.comid ");
		sb.append("  and a.resultstate = '4' ");
		sb.append("  and a.operatedate like :year  ");
		sb.append("  and a.comid  = :comid  ");
		sb.append("  and a.planid = :planid  ");
		sb.append("  and a.qtbwid = :qtbwid  ");
		sb.append("  and b.planchecktype = :planchecktype ");
		sb.append("  order by a.operatedate desc,a.resultstate");
		String sql = sb.toString();
		String[] paramName = new String[] { "year", "comid","planid","qtbwid","planchecktype"};
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}


	/**
	 *
	 * getJdjcResultDetail的中文名称：获取监督检查结果明细
	 *
	 * getJdjcResultDetail的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	public BsCheckMaster getJdjcResultDetail(HttpServletRequest request, BsCheckMasterDTO dto,PagesDTO pd) throws Exception {
		BsCheckMaster master = dao.fetch(BsCheckMaster.class, dto.getResultid());
		StringBuffer sb = new StringBuffer();
		sb.append("<!DOCTYPE html><html> <head><title>结果明细</title><meta http-equiv='content-type' content='text/html; charset=UTF-8'>");
		sb.append("<meta name='Author' content=''> <meta name='Keywords' content=''> <meta name='Description' content=''>");
		sb.append("</head><body>");

		if (master != null) {
			Bscheckplan  plan = dao.fetch(Bscheckplan.class, master.getPlanid());
			if(plan!=null){
				String type = plan.getPlanchecktype();
				if("0".equals(type)){
					//量化明细表
					sb.append(master.getDetailinfo());
				}else if("1".equals(master.getCheckgroupstate())) {
					//日常结果记录表
					sb.append(master.getDetailinfo());
				}else {
					//日常结果记录表
					sb.append(master.getCheckresultinfo());
					sb.append(master.getDetailinfo());
				}
			}
		} else {
			master = new BsCheckMaster();
			sb.append("暂无数据");
		}

		sb.append("</body></html>");
		master.setDetailinfo(sb.toString());
		return master;
	}

	/**
	 *
	 * getSpxxtmList的中文名称：获取商品信息透明
	 *
	 * getSpxxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getSpxxtmList(HttpServletRequest request, HsptmDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.hjhbid,a.eptbh,a.jcypid,a.jhscpcm,a.jhsl,a.jhscd,a.aae036, ");
		sb.append(" a.jhspjldw,getAa10_aaa103('spjldw',a.jhspjldw) as jhjldwmc,  ");
		sb.append(" a.jcfs,getAa10_aaa103('JCFS',a.jcfs) as jcfsmc,  ");
		sb.append(" b.jcypmc,b.jcypsspp,b.spggxh,b.spbzq,a.jhscrq,  ");
		sb.append(" b.spfenlei,getAa10_aaa103('spfenlei',b.spfenlei) as spfenleimc,");
		sb.append(" c.hviewjgztid,c.jgztmc,c.jgztlx,getAa10_aaa103('JGZTLX',c.jgztlx) jgztlxmc, ");
		sb.append(" a.jhscsid,(SELECT t.jgztmc FROM Hviewjgzt t WHERE t.hviewjgztid=a.jhscsid) as jhscsmc, ");
		sb.append(" a.jhsjfxsztid,(SELECT t1.jgztmc FROM hviewjgzt t1 WHERE t1.hviewjgztid=a.jhsjfxsztid) as jhgysmc ");
		sb.append("  FROM Hjhb a,Jyjcyp b,Hviewjgzt c ");
		sb.append(" WHERE a.hviewjgztid=c.hviewjgztid  ");
		sb.append("   and a.jcypid = b.jcypid ");
		sb.append("   and a.hviewjgztid = :hviewjgztid ");
		sb.append("   and a.hjhbid = :hjhbid ");
		sb.append("   and a.jcypid = :jcypid");
		if(!"".equals(StringHelper.showNull2Empty(dto.getJcypgl()))){
			sb.append(" and b.jcypgl in (").append(dto.getJcypgl()).append(")");
		}
		sb.append(" order by a.aae036 desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hviewjgztid" ,"hjhbid", "jcypid"};
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getSpxxtmList的中文名称：获取商品信息透明
	 *
	 * getSpxxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getSpxxtmList_zm(HttpServletRequest request, HsptmDTO dto, PagesDTO pd) throws Exception {
		Map map = new HashMap();
		List<HjhbDTO> v_hjhbDtoList=new ArrayList<HjhbDTO>();
		if (pd.getPageSize()==0){
			pd.setPageSize(30);
		}

		com.alibaba.fastjson.JSONArray jsonArray = null;
		String requestUrl = SysmanageUtil.g_wanxiang_url+"company_id="+dto.getHviewjgztid()+"&curpage="+
				pd.getPage()+"&pagenum="+pd.getPageSize();
		String charset = "UTF-8";
		String content = HttpUtil.httpGet(requestUrl, charset);
		String v_total="0";
		com.alibaba.fastjson.JSONArray jsonarry1;
		com.alibaba.fastjson.JSONArray jsonarryGoods;
		JSONObject v_t;
		if(StringUtils.isNotEmpty(content)) {
			jsonarry1=com.alibaba.fastjson.JSONArray.parseArray(content);
			//com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
//			if (jsonObject!=null&&jsonObject.containsKey("goods_info")){
//				jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("goods_info").toString());
//			}
			//if (jsonarrytemp!=null&&jsonarrytemp.containsKey("goods_info")){
			//	jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("goods_info").toString());
			//}
			//v_total=jsonObject.get("total_page").toString();
			JSONObject v_obj=jsonarry1.getJSONObject(0);
			v_total=v_obj.get("total_page").toString();
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			jsonarryGoods=com.alibaba.fastjson.JSONArray.parseArray(v_obj.getString("goods_info"));
			for (Object hjhbdtotemp:jsonarryGoods){
				JSONObject v_hjhbobj=(JSONObject)hjhbdtotemp;
				HjhbDTO v_newHjhbDTO=new HjhbDTO();
				v_newHjhbDTO.setJcypmc(v_hjhbobj.getString("GOODS_NAME"));
				if (StringUtils.isNotEmpty(v_hjhbobj.getString("PURCHASE_DATE"))){
					Timestamp ts = new Timestamp(format.parse(v_hjhbobj.getString("PURCHASE_DATE")).getTime());
					//System.out.println(v_hjhbobj.getString("PURCHASE_DATE"));
					v_newHjhbDTO.setAae036(ts);
				}
				v_newHjhbDTO.setJhsl(v_hjhbobj.getBigDecimal("PURCHASE_NUM"));
				v_newHjhbDTO.setJhjldwmc(v_hjhbobj.getString("UNIT"));
				v_newHjhbDTO.setJhgysmc(v_hjhbobj.getString("SUPPLIER"));

				v_newHjhbDTO.setJcypsspp(v_hjhbobj.getString("BRANDS"));
				if (StringUtils.isNotEmpty(v_hjhbobj.getString("PRODUCTION_DATE"))){
					Timestamp ts = new Timestamp(format.parse(v_hjhbobj.getString("PRODUCTION_DATE")).getTime());
					v_newHjhbDTO.setJhscrq(ts);
				}
				v_newHjhbDTO.setSpbzq(v_hjhbobj.getString("SHELF_LIFE"));
				v_newHjhbDTO.setTrace(v_hjhbobj.getString("TRACE"));

				v_hjhbDtoList.add(v_newHjhbDTO);
			}
			//v_total=jsonarry1.getJSONObject("total_page").getString("total_page");
			//int v_goodsindex=jsonarry1.indexOf("goods_info");
			//jsonarryGoods=jsonarrytemp.getJSONArray(v_goodsindex);
			map.put("currPage",v_obj.get("cur_page"));
			map.put("totalPage",v_obj.get("total_page"));
		}

//[{"cur_page":1,"total_page":1,"goods_info":[{"GOODS_NAME":"鲜或冷却猪肉","UNIT":"公斤","PURCHASE_NUM":"2800",
// "PURCHASE_DATE":"2018-04-28","SUPPLIER":"屠宰市场"}]}]

		map.put("rows",v_hjhbDtoList);
		map.put("total", v_total);
		return map;
	}

	/**
	 *
	 * getYlcgtmList的中文名称：获取生产企业自查表
	 *
	 * getYlcgtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getZcbList(HttpServletRequest request, HjgztxgpicDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*, ");
		sb.append(" (select t.fjpath from Fj t where t.fjwid=a.hjgztxgpicid limit 1 ) as fjpath ");
		sb.append(" FROM hjgztxgpic a ");
		sb.append(" where 1=1 ");
		sb.append(" and a.hviewjgztid = :hviewjgztid ");
		sb.append(" and a.jgztpickind = :jgztpickind ");
		sb.append(" order by a.hjgztxgpicid desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hviewjgztid","jgztpickind"};
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getCpxxtmList的中文名称：获取产品信息透明
	 *
	 * getCpxxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getCpxxtmList(HttpServletRequest request, HscpcbDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.hscpcbid,b.jcypid,b.jcypmc,a.scpch,a.sptm,a.scrq,a.bzrq,b.impcpgg, ");
		sb.append(" scspjldw,getaa10_aaa103('SPJLDW',a.scspjldw) AS scspjldwmc,  ");
		sb.append(" (select t.fjpath from Fj t where t.fjwid=a.hscpcbid) as icon ");
		sb.append(" FROM Hscpcb a,Jyjcyp b");
		sb.append(" where 1=1 ");
		sb.append(" and a.jcypid = b.jcypid ");
		sb.append(" and a.hviewjgztid = :hviewjgztid ");
		sb.append(" and a.jcypid = :jcypid ");
		sb.append(" order by a.scrq desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hviewjgztid","jcypid" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getSycptmList的中文名称：获取产品信息透明
	 *
	 * getSycptmList的概要说明：绿色农田种养殖企业的产品信息
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	public Map getSycptmList(HttpServletRequest request, QproductDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.cppcid, b.proid, b.proname, a.cppcpch, b.prosptm, b.prosb, ");
		sb.append(" a.cppcscsl, getaa10_aaa103('CPPCSCDWDM',a.cppcscdwdm) cppcscsldw, ");
		sb.append(" a.cppcscrq, b.progg,  b.procpbzh, b.procomid, ");
		sb.append(" CONCAT(b.probzq, b.probzqdwmc) probzq "); // 保质期
		sb.append(" FROM qproductpc a, qproduct b");
		sb.append(" where 1=1 ");
		sb.append(" and a.proid = b.proid ");
		sb.append(" and b.procomid = :procomid ");
		sb.append(" and a.proid = :proid ");
		sb.append(" order by a.cppcscrq desc ");
		String sql = sb.toString();
		String[] paramName = new String[] { "procomid", "proid" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getCpsctmList的中文名称：获取产品生长信息
	 *
	 * getCpsctmList的概要说明：绿色农田种养殖企业的产品信息
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	public Map getCpsctmList(HttpServletRequest request, QproductDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.szgcid, a.proid, a.szgcczr, a.szgccznr, a.szgcczrq, a.szgcbz, a.cppcpch ");
		sb.append(" FROM qproductszgcxx a");
		sb.append(" where 1=1 ");
		sb.append(" and a.proid = :proid ");
		sb.append(" and a.cppcpch = :cppcpch ");
		sb.append(" order by a.szgcczrq desc ");
		String sql = sb.toString();
		String[] paramName = new String[] { "proid", "cppcpch" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getCpjcjytmList的中文名称：获取检验检疫信息
	 *
	 * getCpjcjytmList的概要说明：绿色农田种养殖企业的产品信息
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	public Map getCpjcjytmList(HttpServletRequest request, QproductDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.qproductjcid, a.proid, a.jcitem, a.jcjg, a.jcdw, a.jcsj, a.jcpc, a.jcjcy ");
		sb.append(" FROM qproductjc a");
		sb.append(" where 1=1 ");
		sb.append(" and a.proid = :proid ");
		sb.append(" and a.jcpc = :cppcpch ");
		sb.append(" order by a.jcsj desc ");
		String sql = sb.toString();
		String[] paramName = new String[] { "proid", "cppcpch" };
		int[] paramType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getXsqxtmList的中文名称：获取销售去向透明
	 *
	 * getXsqxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getXsqxtmList(HttpServletRequest request, HscxhbDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.hscxhbid,a.jcypid,a.hscpcbid,a.hviewjgztid,a.xssj, ");
		sb.append(" b.jcypmc,b.impcpgg,c.scpch,c.sptm,a.xssl,c.bzrq, ");
		sb.append(" d.jgzttxdz,d.jgztlxr,d.jgztzzzmmc,d.jgztzzzmbh,a.jxsid,d.jgztmc jxsmc,  ");
		sb.append(" (select t.fjpath from Fj t where t.fjwid=b.jcypid) as icon ");
		sb.append(" from Hscxhb a,Jyjcyp b,Hscpcb c,Hviewjgzt d ");
		sb.append(" where 1=1 ");
		sb.append(" and a.jcypid = b.jcypid ");
		sb.append(" and a.hscpcbid = c.hscpcbid ");
		sb.append(" and a.jxsid = d.hviewjgztid ");
		sb.append(" and a.hviewjgztid = :hviewjgztid ");
		sb.append(" and a.jcypid = :jcypid ");
		sb.append(" and a.hscxhbid = :hscxhbid");
		sb.append(" and a.hscpcbid = :hscpcbid");
		sb.append(" order by a.xssj desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hviewjgztid", "jcypid", "hscxhbid", "hscpcbid" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getKjfjList的中文名称：获取食品快检附件信息
	 *
	 * getKjfjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getKjfjList(HttpServletRequest request, HjhbDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select b.* ");
		sb.append(" from Hjhb a,Fj b ");
		sb.append(" where 1=1 ");
		sb.append(" and a.hjhbid = b.fjwid ");
		sb.append(" and (a.jhsjfxid is null or a.jhsjfxid ='') ");
		sb.append(" and a.eptbh in (select t.eptbh from Hjhb t where t.hjhbid = :hjhbid) ");
		sb.append(" and b.fjtype = '9' ");
		sb.append(" order by hjhbid desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hviewjgztid","hjhbid" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getCpxxtmJyjcFjList的中文名称：获取生产企业产品的检验报告附件列表
	 *
	 * getCpxxtmJyjcFjList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getCpxxtmJyjcFjList(HttpServletRequest request, HscpcbDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*  ");
		sb.append(" from Fj a,Hscpcb b,Jyjcyp c ");
		sb.append(" where a.fjwid = b.hscpcbid ");
		sb.append("   and b.jcypid = c.jcypid ");
		sb.append("   and b.hscpcbid = :hscpcbid ");
		sb.append("   and c.jcypid = :jcypid ");
		sb.append("   and a.fjtype = '9' ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hscpcbid","jcypid" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}
	/**
	 *
	 * getCpxxtmplList的中文名称：获取生产企业产品的配料表
	 *
	 * getCpxxtmplList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getCpxxtmplList(HttpServletRequest request, HscpcbDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT (SELECT c.jcypmc FROM jyjcyp c WHERE c.jcypid= :jcypid ) 'cpmc', ");
		sb.append(" group_concat(DISTINCT  b.jcypmc Separator ',') 'plxx' ");
		sb.append(" FROM hcphycldyb a , jyjcyp b  ");
		sb.append("  WHERE a.cpid= :jcypid AND a.yclid=b.jcypid GROUP BY a.cpid ");

		String sql = sb.toString();
		String[] paramName = new String[] { "jcypid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getLsdjtmList的中文名称：获取历史等级透明
	 *
	 * getLsdjtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getLsdjtmList(HttpServletRequest request, PcompanynddtpjDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*  ");
		sb.append(" from Pcompanynddtpj a ");
		sb.append(" where 1 = 1 ");
		sb.append("   and a.comid = :comid ");
		sb.append("   and a.pdyear = :pdyear ");
		sb.append(" order by a.pdyear desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "comid","pdyear" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getSpsyList的中文名称：获取食品溯源信息
	 *
	 * getSpsyList的概要说明：追溯
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getSpsyList(HttpServletRequest request, HsptmDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.hjhbid,a.eptbh as ywbh,a.jcypid,b.jcypmc,a.aae036, ");
		sb.append(" c.hviewjgztid as comid,c.jgztmc as commc, ");
		sb.append(" c.jgztlx,getAa10_aaa103('JGZTLX',c.jgztlx) jgztlxmc, ");
		sb.append(" a.jhsjfxsztid as nodeid,(SELECT t1.jgztmc FROM hviewjgzt t1 WHERE t1.hviewjgztid=a.jhsjfxsztid) as nodename ");
		sb.append("  FROM Hjhb a,Jyjcyp b,Hviewjgzt c ");
		sb.append(" WHERE a.jcypid = b.jcypid ");
		sb.append("   and a.hviewjgztid = c.hviewjgztid ");
//		if(!"".equals(StringHelper.showNull2Empty(dto.getHviewjgztid()))){
//			sb.append("   and a.hjhbid <= (SELECT t3.hjhbid FROM hjhb t3 WHERE t3.eptbh = :eptbh AND t3.hviewjgztid = :hviewjgztid) ");
//		}
		if(!"".equals(StringHelper.showNull2Empty(dto.getHjhbid()))){
			sb.append("   and a.hjhbid <= :hjhbid ");
		}
		sb.append(" and (a.hjhbid=:hjhbid or (a.hjhbid in (select t4.jhsjfxid from hjhb t4 where t4.eptbh=:eptbh and LENGTH(t4.jhsjfxid)>0 )))");
		//sb.append("   and a.eptbh = :eptbh ");
		sb.append("   ORDER BY a.hjhbid ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hjhbid","eptbh","hviewjgztid" };
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

//gu20180104gai	public Map getSpsyList(HttpServletRequest request, HsptmDTO dto, PagesDTO pd) throws Exception {
//		StringBuffer sb = new StringBuffer();
//		sb.append(" select a.hjhbid,a.eptbh as ywbh,a.jcypid,b.jcypmc,a.aae036, ");
//		sb.append(" c.hviewjgztid as comid,c.jgztmc as commc, ");
//		sb.append(" c.jgztlx,getAa10_aaa103('JGZTLX',c.jgztlx) jgztlxmc, ");
//		sb.append(" a.jhsjfxsztid as nodeid,(SELECT t1.jgztmc FROM hviewjgzt t1 WHERE t1.hviewjgztid=a.jhsjfxsztid) as nodename ");
//		sb.append("  FROM Hjhb a,Jyjcyp b,Hviewjgzt c ");
//		sb.append(" WHERE a.jcypid = b.jcypid ");
//		sb.append("   and a.hviewjgztid = c.hviewjgztid ");
//		if(!"".equals(StringHelper.showNull2Empty(dto.getHviewjgztid()))){
//			sb.append("   and a.hjhbid <= (SELECT t3.hjhbid FROM hjhb t3 WHERE t3.eptbh = :eptbh AND t3.hviewjgztid = :hviewjgztid) ");
//		}
//		sb.append("   and a.eptbh = :eptbh ");
//		sb.append("   ORDER BY a.hjhbid ");
//		
//		String sql = sb.toString();
//		String[] paramName = new String[] { "eptbh","hviewjgztid" };
//		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR };
//		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
//		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
//		return m;
//	}

	/**
	 *
	 * uploadFj的中文名称：附件上传
	 *
	 * uploadFj的概要说明：
	 *
	 * @param request
	 * @return
	 * @author : zy
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map uploadFj(HttpServletRequest request,UploadfjDTO dto) throws Exception {
		return uploadFjImp(request,dto);
	}

	/**
	 *
	 * uploadFjImp的中文名称：附件上传实现
	 *
	 * uploadFjImp的概要说明：
	 *
	 * @param request
	 * @throws Exception
	 * @author : zy
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Aop({ "trans" })
	public Map uploadFjImp(HttpServletRequest request,UploadfjDTO dto) throws Exception {
		// 附件上传保存目录
		String uplodaFileFolder = StringHelper.showNull2Empty(request.getParameter("folderName"));
		if ("".equals(uplodaFileFolder)) {
			uplodaFileFolder = "/upload/"; // 默认上传目录
		} else {
			uplodaFileFolder = "/upload/" + uplodaFileFolder + "/";
		}
		// 获取附件所属表id
		String v_id = StringHelper.showNull2Empty(dto.getFjwid());
		if ("".equals(v_id)) {
			v_id = "wuzhuti"; // 如果所属表id为空，定义为wuzhuti
			uplodaFileFolder = "/upload/linshi/"; // 将文件首先上传到临时文件夹
		}
		// 附件类别
		String v_fjType = StringHelper.showNull2Empty(dto.getFjtype());
		if ("".equals(v_fjType)) {
			v_fjType = "1"; // 默认为图片上传
		}

		// 上传文件路径
		String uploadPath = request.getSession().getServletContext().getRealPath(uplodaFileFolder);
		// 文件夹判断
		File path = new File(uploadPath);
		if (!path.exists()) {
			path.mkdirs();
        }
		// 读取上传附件
		Integer chunk = 0; // 分割块数
		Integer chunks = 1; // 总分割数
		// 支持多个附件同时上传
		List<String> fileName = new ArrayList<String>(); // 文件名
		List<String> tempFileName = new ArrayList<String>(); // 临时文件名
		List<String> newFileName = new ArrayList<String>(); // 最后合并后的新文件名
		BufferedOutputStream outputStream = null;
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				factory.setSizeThreshold(1024);
				ServletFileUpload upload = new ServletFileUpload(factory);
				upload.setHeaderEncoding("UTF-8");
				List<FileItem> items = upload.parseRequest(request);
				// 区分表单域
				for (int i = 0; i < items.size(); i++) {
					FileItem fi = items.get(i);
					// 获取文件名
					tempFileName.add(fi.getName());
					if (tempFileName != null) {
						String chunkName = tempFileName.get(i);
						fileName.add(tempFileName.get(i));
						if (chunk != null) {
							chunkName = chunk + "_" + tempFileName.get(i);
						}
						File savedFile = new File(uploadPath, chunkName);
						fi.write(savedFile);
					}
				}
				for (int i = 0; i < tempFileName.size(); i++) {
					newFileName.add(UUID.randomUUID().toString().replace("-", "")
							.concat(".")
							.concat(FilenameUtils.getExtension(tempFileName.get(i))));
				}
				if (chunk != null && chunk + 1 == chunks) {
					for (int j = 0; j < newFileName.size(); j++) {
						outputStream = new BufferedOutputStream(
								new FileOutputStream(new File(uploadPath, newFileName.get(j))));
						// 遍历文件合并
						File tempFile = new File(uploadPath, "0_" + tempFileName.get(j));
						byte[] bytes = FileUtils.readFileToByteArray(tempFile);
						outputStream.write(bytes);
						outputStream.flush();
						tempFile.delete();
						outputStream.close();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (outputStream != null)
						outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		Map retMap = new HashMap(); // 返回数据
		List fjInfoList = new ArrayList(); // 附件信息
		for (int j = 0; j < newFileName.size(); j++) {
			// 将附件保存进数据库
			String fjpathString = uplodaFileFolder + newFileName.get(j);
			String fjnameString = fileName.get(j);
			String[] a = PubFunc.split(fjpathString, ",");
			String[] b = PubFunc.split(fjnameString, ",");

			for (int i = 0; i < a.length; i++) {
				List<Fj> fjList = dao.query(Fj.class, Cnd.where("fjwid", "=", v_id)
						.and("FJTYPE", "=", v_fjType));
				// 获取aaa105字段（0：可以上传多张  1：只能上传一张）
				String flag = dao.query(Aa10.class, Cnd.where("AAA100", "=", "FJTYPE")
						.and("AAA102", "=", v_fjType)).get(0).getAaa105();
				// 根据附件类型，只能上传一张的，再次上传时更新
				if (fjList != null && fjList.size() > 0 && !"wuzhuti".equals(v_id) &&
						"1".equals(flag)) {
					Fj fj = fjList.get(0);
					fj.setFjpath(a[i]); // 附件保存路径
					fj.setFjname(b[i]); // 附件名称
					dao.update(fj); // 更新
					fjInfoList.add(fj);
				} else {
					Fj fj = new Fj();
					fj.setFjpath(a[i]); // 附件保存路径
					fj.setFjname(b[i]); // 附件名称
					// 附件类别
					String fjtype = PubFunc.getFileExt(b[i]);
					if ("1".equals(v_fjType) && !"".equals(fjtype)) {
						// 图片
						if (fjtype.equalsIgnoreCase("jpg")
								|| fjtype.equalsIgnoreCase("jpeg")
								|| fjtype.equalsIgnoreCase("png")
								|| fjtype.equalsIgnoreCase("gif")) {
							fj.setFjtype("1");
							// 视频
						} else if (fjtype.equalsIgnoreCase("mp4")
								|| fjtype.equalsIgnoreCase("avi")
								|| fjtype.equalsIgnoreCase("rm")
								|| fjtype.equalsIgnoreCase("rmvb")) {
							fj.setFjtype("3");
							// 文档
						} else {
							fj.setFjtype("2");
						}
					} else {
						fj.setFjtype(v_fjType);
					}
					fj.setFjwid(v_id); // 附件所属表id
					fj.setFjid(DbUtils.getSequenceStr()); // 附件id
					dao.insert(fj);
					fjInfoList.add(fj);
				}
			}
		}
		retMap.put("fjinfo", fjInfoList);
		return retMap;
	}

	/**
	 *
	 * uploadJhb的中文名称：上传进货台账
	 *
	 * uploadJhb的概要说明：对接进销存软件
	 *
	 * @param dto
	 * @return
	 * @author ：zjf
	 */
	public String uploadJhb(HjhbDTO dto) {
		try {
			uploadJhbImp(dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	@SuppressWarnings("rawtypes")
	@Aop( { "trans" })
	public void uploadJhbImp(HjhbDTO dto) throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();

		Sysuser vSysUser = dao.fetch(Sysuser.class, Cnd.where("aaz001", "=", dto.getHviewjgztid()));
		if (vSysUser == null) {
			throw new BusinessException("未获取到当前企业对应的操作员信息！");
		}

		//进货台账
		Hjhb v_Hjhb = new Hjhb();
		String v_hjhbid = DbUtils.getSequenceStr();
		BeanHelper.copyProperties(dto, v_Hjhb); // 拷贝对应的从前台传来的数据

		//进货商品【获取系统对应的商品计量单位】
		String jhspjldw = dto.getJhspjldw();
		String v_sql2 = "select aaa102 from aa10 where aaa100 = 'spjldw' and aaa103 = '"+ jhspjldw +"'";

		List spjldwList = DbUtils.getDataList(v_sql2,Aa10.class);
		if(spjldwList!=null && spjldwList.size()>0){
			Aa10 aa10 = (Aa10)spjldwList.get(0);
			jhspjldw = aa10.getAaa102();
		}else{
			Aa10 aa10 = new Aa10();
			aa10.setAaz093(DbUtils.getSequenceStr());
			aa10.setAaz094("2017042115103434616090855");
			aa10.setAaa100("SPJLDW");
			String aaa102 = dao.execute(Sqls.fetchString("select max(aaa102)+1 from aa10 where aaa100='spjldw' ")).getString();
			aa10.setAaa102(aaa102);
			aa10.setAaa103(jhspjldw);
			dao.insert(aa10);
			jhspjldw = aa10.getAaa102();
		}
		v_Hjhb.setJhspjldw(jhspjldw);

		//进货商品【获取系统对应的商品id】
		String jcypmc = dto.getJcypmc();
		String v_sql = "select jcypid from jyjcyp where jcypmc='"+
				   dto.getJcypmc() +"'  and (hviewjgztid='' or hviewjgztid is null)";
		List spList = DbUtils.getDataList(v_sql,Jyjcyp.class);
		String jcypid = "";
		if(spList!=null && spList.size()>0){
			Jyjcyp jyjcyp = (Jyjcyp)spList.get(0);
			jcypid = jyjcyp.getJcypid();
		}else{
			Jyjcyp jcxm = new Jyjcyp();
			jcypid = DbUtils.getSequenceStr();
			jcxm.setJcypid(jcypid);
			jcxm.setJcypmc(jcypmc);
			jcxm.setJcypgl(dto.getJcypgl());
			jcxm.setJcypczy(vSysUser.getDescription());
			jcxm.setJcypczsj(startTime);
			jcxm.setUserid(vSysUser.getUserid());
			jcxm.setJcypsspp(dto.getJcypsspp());
			jcxm.setSpsb(dto.getSpsb());
			jcxm.setImpcpgg(dto.getImpcpgg());
			jcxm.setSpbzq(dto.getSpbzq());
			jcxm.setSpjldw(dto.getJhspjldw());
			dao.insert(jcxm);
		}
		v_Hjhb.setJcypid(jcypid);

		//进货供应商
		String jhgysid = "";
		String v_sql3 = "select hjgztkhgxid from hjgztkhgx where hviewjgztid = '"+dto.getHviewjgztid()+"' and jgztkhmc='"+dto.getJhgysmc()+"' and jgztkhgx='1'";

		List jhgysList = DbUtils.getDataList(v_sql3,Hjgztkhgx.class);
		if(jhgysList!=null && jhgysList.size()>0){
			Hjgztkhgx hjgztkhgx = (Hjgztkhgx)jhgysList.get(0);
			jhgysid = hjgztkhgx.getHjgztkhgxid();
		}else{
			Hjgztkhgx khgx = new Hjgztkhgx();
			String v_Hjgztkhgxid = DbUtils.getSequenceStr();
			khgx.setJgztkhgx("1");
			khgx.setHjgztkhgxid(v_Hjgztkhgxid);
			khgx.setJgztkhmc(dto.getJhgysmc());
			khgx.setHviewjgztid(vSysUser.getAaz001());
 			khgx.setJgztfwnztid(vSysUser.getAaz001());//gu20170502 现在这块都增加范围外的，这个字段记录当前操作员aaz001
 			khgx.setJgztfwnfww("2"); // 1范围内2范围外
 			khgx.setAaa027(vSysUser.getAaa027());
 			dao.insert(khgx);

 			jhgysid = khgx.getHjgztkhgxid();

			//gu20170425 往主体信息表同步数据
			HviewjgztDTO v_HviewjgztDTO = new HviewjgztDTO();
			v_HviewjgztDTO.setHviewjgztid(v_Hjgztkhgxid);
			v_HviewjgztDTO.setDokind("add");
			v_HviewjgztDTO.setTablemc("hjgztkhgx");
			pcompanyService.HviewjgztManage(v_HviewjgztDTO);
		}
		v_Hjhb.setJhgysid(jhgysid);

		v_Hjhb.setHjhbid(v_hjhbid);
		v_Hjhb.setJhqrbz("1");
		v_Hjhb.setHviewjgztid(vSysUser.getAaz001());
		v_Hjhb.setAae011(vSysUser.getDescription());
		v_Hjhb.setAae036(startTime);
		v_Hjhb.setJhkcl(v_Hjhb.getJhsl());//进出货库存量
		v_Hjhb.setEptbh(v_hjhbid);//e票通编号,根据这个号能拉取所有的本次进货的分销信息
		v_Hjhb.setJhtotal(StringHelper.NullToZero(v_Hjhb.getJhsl())
				.multiply(StringHelper.NullToZero(v_Hjhb.getJhprice())));//进出货库存量
		v_Hjhb.setJhsjfxsztid(jhgysid); // 首次进货上级分销商主体id 设置为 供应商的
		dao.insert(v_Hjhb);
	}

	/**
	 *
	 * addPublicSupervision : 添加公众监督
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	public String addPublicSupervision(HttpServletRequest request, PgzjdDTO dto) {
		try {
			addPublicSupervisionImp(request,dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * addPublicSupervision : 添加公众监督
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@Aop( { "trans" })
	public void addPublicSupervisionImp(HttpServletRequest request, PgzjdDTO dto) throws Exception {

		Timestamp startTime = SysmanageUtil.currentTime();
		String v_path = dto.getPjdtppath();
		String v_name = dto.getPjdtpname();
		String[] paths = PubFunc.split(v_path, ",");
		String[] names = PubFunc.split(v_name, ",");
		// 监督信息保存
		Pgzjd gzjd = new Pgzjd();
		String v_id = DbUtils.getSequenceStr();
		gzjd.setPgzjdid(v_id); // id
		gzjd.setPjdbt(dto.getPjdbt()); // 标题
		gzjd.setPjdnr(dto.getPjdnr()); // 内容
		gzjd.setPjdr(dto.getPjdr()); // 监督人
		gzjd.setPjdsj(startTime); // 监督时间
		gzjd.setPmobile(dto.getPmobile()); // 监督人手机号
		dao.insert(gzjd);


		// 监督图片保存
		for(int i = 0; i < paths.length; i++){
			FjDTO v_fjdto = new FjDTO();
			v_fjdto.setFjwid(v_id);
			// 监督图片上传
			v_fjdto.setFolderName("gzjd"); // 上传文件夹
			v_fjdto.setFjpath(paths[i]);
			v_fjdto.setFjname(names[i]);
			v_fjdto.setFjtype("3");
			pubService.saveFjWuzhuti(request, v_fjdto);
		}
	}

	/**
	 *
	 * getPublicSupervisionList : 获取监督信息列表
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getPublicSupervisionList(HttpServletRequest request, PgzjdDTO dto,
			PagesDTO pd) throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.pgzjdid, a.pjdr, a.pjdsj, a.pjdbt, a.pmobile, a.pjdnr, ");
		sb.append(" (SELECT s.DESCRIPTION FROM sysuser s WHERE s.USERID = a.pjdr) pjdrname ");
		sb.append(" from pgzjd a ");
		sb.append(" where 1=1 ");
		sb.append(" and pjdr = :pjdr ");

		String sql = sb.toString();
		String[] paramName = new String[] { "pjdr" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PgzjdDTO.class, pd.getPage(), pd.getRows());
		List list = (List) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		if (list != null && list.size() > 0) {
			List  infoList = new ArrayList();
			for (int i = 0; i < list.size(); i++) {
				PgzjdDTO v_info = (PgzjdDTO) list.get(i);
				// 附件
				List<Fj> fjList = dao.query(Fj.class,
						Cnd.where("FJWID", "=", v_info.getPgzjdid()));
				v_info.setFjlist(fjList); // 附件信息
				infoList.add(v_info);
			}
			map.put("rows", infoList);
		}
		map.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return map;
	}

	/**
	 *
	 * getYlcgtmList的中文名称：获取原料采购透明
	 *
	 * getYlcgtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getYlcgtmList(HttpServletRequest request, HjhbDTO dto,PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT a.hjhbid,b.jcypmc,b.spggxh,a.aae036,a.jhsl,  ");
		sb.append(" getaa10_aaa103('SPJLDW',a.jhspjldw) AS jhspjldwmc, ");
		sb.append(" b.spsb,a.jhscrq,a.jhscpcm, b.spzxbzh AS zxbz,b.spbzq,'' AS yxqz, ");
		sb.append(" getaa10_aaa103('JHHGZMLX',a.jhhgzmlx) AS jhhgzmlxmc, ");
		sb.append(" getaa10_aaa103('JHSCJYJL',a.jhscjyjl) AS jhscjyjlmc,  ");
		sb.append(" getaa10_aaa103('JHQYCYJL',a.jhqycyjl) AS jhqycyjlmc,  ");
		sb.append(" a.jhgysid,(SELECT t.jgztmc FROM hviewjgzt t WHERE t.hviewjgztid=a.jhgysid) AS jhgysmc, ");
		sb.append(" (select t.fjpath from Fj t where t.fjwid=b.jcypid) as icon ");
		sb.append(" FROM Hjhb a,Jyjcyp b ");
		sb.append(" where 1=1 ");
		sb.append(" and a.jcypid = b.jcypid ");
		sb.append(" and a.hviewjgztid = :hviewjgztid ");
		sb.append(" and a.hjhbid= :hjhbid ");
		sb.append(" order by a.aae036 desc ");

		String sql = sb.toString();
		String[] paramName = new String[] { "hviewjgztid","hjhbid"};
		int[] paramType = new int[] { Types.VARCHAR,Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getSpxxtmList的中文名称：获取原料采购透明
	 *
	 * getSpxxtmList的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	@SuppressWarnings("rawtypes")
	public Map getYlcgtmList_zm(HttpServletRequest request, HjhbDTO dto, PagesDTO pd) throws Exception {
		Map map = new HashMap();
		List<HjhbDTO> v_hjhbDtoList=new ArrayList<HjhbDTO>();
		if (pd.getPageSize()==0){
			pd.setPageSize(30);
		}

		com.alibaba.fastjson.JSONArray jsonArray = null;
		String requestUrl = SysmanageUtil.g_wanxiang_cy_url+"company_id="+dto.getHviewjgztid()+"&type="+dto.getJcypgl()+"&curpage="+
				pd.getPage()+"&pagenum="+pd.getPageSize();
		String charset = "UTF-8";
		String content = HttpUtil.httpGet(requestUrl, charset);
		String v_total="0";
		com.alibaba.fastjson.JSONArray jsonarry1;
		com.alibaba.fastjson.JSONArray jsonarryGoods;
		JSONObject v_t;
		if(StringUtils.isNotEmpty(content)) {
			jsonarry1=com.alibaba.fastjson.JSONArray.parseArray(content);
			//com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
//			if (jsonObject!=null&&jsonObject.containsKey("goods_info")){
//				jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("goods_info").toString());
//			}
			//if (jsonarrytemp!=null&&jsonarrytemp.containsKey("goods_info")){
			//	jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("goods_info").toString());
			//}
			//v_total=jsonObject.get("total_page").toString();
			JSONObject v_obj=jsonarry1.getJSONObject(0);
			v_total=v_obj.get("total_page").toString();
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			jsonarryGoods=com.alibaba.fastjson.JSONArray.parseArray(v_obj.getString("goods_info"));
			for (Object hjhbdtotemp:jsonarryGoods){
				JSONObject v_hjhbobj=(JSONObject)hjhbdtotemp;
				HjhbDTO v_newHjhbDTO=new HjhbDTO();
				v_newHjhbDTO.setJcypmc(v_hjhbobj.getString("GOODS_NAME"));
				if (StringUtils.isNotEmpty(v_hjhbobj.getString("PURCHASE_DATE"))){
					Timestamp ts = new Timestamp(format.parse(v_hjhbobj.getString("PURCHASE_DATE")).getTime());
					//System.out.println(v_hjhbobj.getString("PURCHASE_DATE"));
					v_newHjhbDTO.setAae036(ts);
				}
				v_newHjhbDTO.setJhsl(v_hjhbobj.getBigDecimal("PURCHASE_NUM"));
				v_newHjhbDTO.setJhjldwmc(v_hjhbobj.getString("UNIT"));
				v_newHjhbDTO.setJhgysmc(v_hjhbobj.getString("SUPPLIER"));

				v_newHjhbDTO.setJcypsspp(v_hjhbobj.getString("BRANDS"));
				if (StringUtils.isNotEmpty(v_hjhbobj.getString("PRODUCTION_DATE"))){
					Timestamp ts = new Timestamp(format.parse(v_hjhbobj.getString("PRODUCTION_DATE")).getTime());
					v_newHjhbDTO.setJhscrq(ts);
				}
				v_newHjhbDTO.setSpbzq(v_hjhbobj.getString("SHELF_LIFE"));
				v_newHjhbDTO.setTrace(v_hjhbobj.getString("TRACE"));

				v_hjhbDtoList.add(v_newHjhbDTO);
			}
			//v_total=jsonarry1.getJSONObject("total_page").getString("total_page");
			//int v_goodsindex=jsonarry1.indexOf("goods_info");
			//jsonarryGoods=jsonarrytemp.getJSONArray(v_goodsindex);
			map.put("currPage",v_obj.get("cur_page"));
			map.put("totalPage",v_obj.get("total_page"));
		}

//[{"cur_page":1,"total_page":1,"goods_info":[{"GOODS_NAME":"鲜或冷却猪肉","UNIT":"公斤","PURCHASE_NUM":"2800",
// "PURCHASE_DATE":"2018-04-28","SUPPLIER":"屠宰市场"}]}]



		map.put("rows",v_hjhbDtoList);
		map.put("total", v_total);
		return map;
	}

	/**
	 *
	 * querySymOfLt： 查询商品溯源信息（非流通企业）
	 *
	 * @param hjhbid 进货表id
	 * @return Written by : zy
	 * @throws Exception
	 *
	 */
	public Object querySymOfLt(String hjhbid) throws Exception {
		if ("".equals(hjhbid)) {
			throw new BusinessException("二维码错误！");
		}
		Map result = new HashMap();
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT j.* ");
		sb.append(" FROM jyjcyp j, hjhb h ");
		sb.append(" WHERE j.jcypid = h.jcypid ");
		sb.append(" and h.hjhbid = '").append(hjhbid).append("' ");
		String sql = sb.toString();
		//
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
		Map map = DbUtils.DataQuery(GlobalNames.sql, sql, null, JyjcypDTO.class);
		List ls = (List) map.get(GlobalNames.SI_RESULTSET);
		JyjcypDTO pro = null;
		if (ls != null && ls.size() > 0) {
			pro = (JyjcypDTO) ls.get(0);
			result.put("ypInfo", pro); // 产品信息

			// 检测主表信息
			List<Hjyjczb> v_jyjcPiclist = dao.query(Hjyjczb.class, Cnd.where("jcztbzjid", "=", hjhbid));
			if (v_jyjcPiclist != null && v_jyjcPiclist.size() > 0) {
				result.put("jcZbInfo", v_jyjcPiclist.get(0));
				// 检测明细信息
				List<Hjyjcmxb> v_mxList = dao.query(Hjyjcmxb.class,
						Cnd.where("hjyjczbid", "=", v_jyjcPiclist.get(0).getHjyjczbid()));
				result.put("jcMxList", v_mxList); // 检测明细
			}
		}

		return result;
	}

	/**
	 *
	 * addJyjcyp : 添加你点我检
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Jyjcndwjmx addJyjcyp(HttpServletRequest request, JyjcndwjDTO dto) throws Exception {
		Jyjcndwj ndwj = new Jyjcndwj();
		Jyjcndwjmx ndwjmx = new Jyjcndwjmx();
		Jyjcndwjmx ndwjmx2 = null;
		String jyjcndwjid = DbUtils.getSequenceStr();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String datetime = sdf.format(new java.util.Date());
		dto.setJyjcndwjid(jyjcndwjid);
		dto.setSqsj(datetime);

		ndwj.setJyjcndwjid(jyjcndwjid);
		ndwj.setAaa027(dto.getAaa027());
		ndwj.setNdwjddfl(dto.getNdwjddfl());
		ndwj.setCommc(dto.getCommc());
		ndwj.setJcreason(dto.getJcreason());
		ndwj.setSfgk(dto.getSfgk());
		ndwj.setSqrxm(dto.getSqrxm());
		ndwj.setRyxb(dto.getRyxb());
		ndwj.setSqrtel(dto.getSqrtel());
		ndwj.setSqsj(dto.getSqsj());

//		BeanHelper.copyProperties(dto, ndwj);
		Jyjcndwj ndwj2 = dao.insert(ndwj);//保存你点我检
		if (ndwj2 != null) {
			String[] str = dto.getNdwjjcyp().split(",");

			for (int i = 0; i < str.length; i++) {
				String jyjcndwjmxid = DbUtils.getSequenceStr();
				ndwjmx.setJyjcndwjid(ndwj2.getJyjcndwjid());
				ndwjmx.setJyjcndwjmxid(jyjcndwjmxid);
				ndwjmx.setNdwjjcyp(str[i]);
				ndwjmx2 = dao.insert(ndwjmx);
			}
		}
		return ndwjmx2;
	}

    /**
	 *
	 * queryparentchild : 查询常见食品
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryparentchild(HttpServletRequest request, PubParentChildDto dto,PagesDTO pd) throws Exception {
        StringBuffer sb = new StringBuffer();
        sb.append(" select * FROM parentchild WHERE parentchildlb='ndwjjcyp' and parentid != '0'");

        String sql = sb.toString();
        String[] paramName = new String[] {};
        int[] paramType = new int[] {};
        sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
        Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, PubParentChild.class, pd.getPage(), pd.getRows());
        return m;
	}

	/**
	 * addAqjgWyts : 添加我要投诉
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @user : zy
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	public Pcomtousu addAqjgWyts(HttpServletRequest request, PcomtousuDTO dto) throws Exception {

		String pcomtousuid = DbUtils.getSequenceStr();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String tssj = sdf.format(new java.util.Date());

		Pcomtousu wyts = new Pcomtousu();
		Pcomtousu wyts2 = null;
//		BeanHelper.copyProperties(dto, wyts);
		wyts.setPcomtousuid(pcomtousuid);
		wyts.setComid(dto.getComid());
		wyts.setTsrmc(dto.getTsrmc());
		wyts.setTsnr(dto.getTsnr());
		wyts.setTssj(tssj);
		wyts.setSfsl("0");

		wyts2=dao.insert(wyts);

		return wyts2;
	}

	/**
	 *
	 * getSycpxsqxtmList的中文名称：获取溯源产品销售去向信息
	 *
	 * getSycpxsqxtmList的概要说明：绿色农田种养殖企业的产品信息
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	public Map getSycpxsqxtmList(HttpServletRequest request, PcompanyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT q.lqledgersalesid, q.lgsprosptm, q.lgsproname, ");
		sb.append(" (SELECT p1.commc FROM pcompany p1 WHERE p1.comid = q.lgsfromcomid) AS fromcom, ");
		sb.append(" (SELECT p1.commc FROM pcompany p1 WHERE p1.comid = q.lgstocomid) AS tocom, ");
		sb.append(" q.lgsproid, q.lgsprojysl, q.lgsprojydwmc, q.lgsprojyrq, q.lgspropc, q.lgsjylx  ");
		sb.append(" FROM qledgersales q ");
		sb.append(" where 1=1 ");
		sb.append(" and q.lgsfromcomid = :comid ");
		sb.append(" ORDER BY q.lgsprojyrq ");
		String sql = sb.toString();
		String[] paramName = new String[] { "comid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}

	/**
	 *
	 * getSycpcgxxtmList的中文名称：获取溯源产品采购信息
	 *
	 * getSycpcgxxtmList的概要说明：绿色农田种养殖企业的产品信息
	 *
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zy
	 */
	@SuppressWarnings("rawtypes")
	public Map getSycpcgxxtmList(HttpServletRequest request, PcompanyDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT q.qledgerstockid, q.lgprosptm, q.lgproname, ");
		sb.append(" (SELECT p1.commc FROM pcompany p1 WHERE p1.comid = q.lgfromcomid) AS fromcom, ");
		sb.append(" (SELECT p1.commc FROM pcompany p1 WHERE p1.comid = q.lgtocomid) AS tocom, ");
		sb.append(" q.lgproid, q.lgprojysl, q.lgprojyrq, q.lgpropc, q.lgjylx  ");
		sb.append(" FROM qledgerstock q ");
		sb.append(" where 1=1 ");
		sb.append(" and q.lgtocomid = :comid ");
		sb.append(" ORDER BY q.lgprojyrq ");
		String sql = sb.toString();
		String[] paramName = new String[] { "comid" };
		int[] paramType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null,null, pd.getPage(), pd.getRows());
		return m;
	}
}
