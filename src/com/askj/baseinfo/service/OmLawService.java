package com.askj.baseinfo.service;

import com.askj.baseinfo.dto.OmLawContentDTO;
import com.askj.baseinfo.dto.OmLawGroupDTO;
import com.askj.baseinfo.entity.OmLawContent;
import com.askj.baseinfo.entity.OmLawGroup;
import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import common.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import javax.servlet.http.HttpServletRequest;
import java.sql.Types;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 *  OmLawService的中文名称：法律法规service
 *
 *  OmLawService的描述：
 *
 *  @author : zy
 *  @version : V1.0
 */
public class OmLawService extends BaseService {

	protected final Logger logger = Logger.getLogger(OmLawService.class);
	
	@Inject
	private Dao dao;

	/**
	 *
	 * queryItemZTreeAsync的中文名称：查询项目节点树
	 *
	 * queryItemZTreeAsync概要说明：当itemid为空时查询当前节点信息，否则查询父节点为itemid的节点信息
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 * @author : zy
	 */
	public List queryItemZTreeAsync(HttpServletRequest request) throws Exception {
		String itemId = StringHelper.showNull2Empty(request.getParameter("itemid"));
		String itempid = "0";
		if ("".equals(itemId)) {
			itempid = "0000000000000000000000000";
		}else{
			itempid = itemId;
		}

		String sb = "";
		sb += " select itemid,itemname,itemdesc,itempid,parentname,itemsortid,itemremark,itemtype,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isopen ";
		sb += " from (";
		sb += " select t.itemid,t.itemname,t.itemdesc,t.itempid,t.itemsortid,t.itemremark,t.itemtype,";
		sb += " 	(select count(t1.itemid) from omlawgroup t1 where t1.itempid = t.itemid) childnum, ";
		sb += " 	(select t2.itemname from omlawgroup t2 where t2.itemid = t.itempid) parentname ";
		sb += " from omlawgroup t ";
		sb += " where 1=1 ";

		if (Strings.isBlank(itemId)) {
			sb += " and t.itemid = '" + itempid + "'";
		} else {
			sb += " and t.itempid = '" + itempid + "'";
		}

		sb += " ) h order by itemsortid asc"; // mysql

		Map m = DbUtils.DataQuery("sql", sb, null, OmLawGroupDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}

	/**
	 *
	 * saveLawGroup的中文名称：保存项目
	 *
	 * saveLawGroup的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String saveLawGroup(HttpServletRequest request, OmLawGroupDTO dto) {
		try {
			saveLawGroupImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * saveLawGroupImp的中文名称：保存项目方法实现
	 *
	 * saveLawGroupImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void saveLawGroupImp(HttpServletRequest request, OmLawGroupDTO dto)
			throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		dto.setOperatedate(new Date());
		dto.setOperateperson(user.getUserid().toString());
		if (null != dto.getItemid() && !"".equals(dto.getItemid())) {
			OmLawGroup se = dao.fetch(OmLawGroup.class, dto.getItemid());
			se.setItemid(dto.getItemid());
			se.setItemname(dto.getItemname());
			se.setItempid(dto.getItempid());
			se.setItemremark(dto.getItemremark());
			se.setItemtype(dto.getItemtype());
			se.setItemsortid(dto.getItemsortid());
			se.setItemdesc(dto.getItemdesc());
			se.setOperatedate(dto.getOperatedate());
			se.setOperateperson(dto.getOperateperson());
			dao.update(se);
		} else {
			String sequence = DbUtils.getSequenceStr();
			OmLawGroup olg = new OmLawGroup();
			BeanHelper.copyProperties(dto, olg);
			olg.setItemid(sequence);
			dao.insert(olg);
		}
	}

	/**
	 *
	 * delLawGroup的中文名称：删除项目
	 *
	 * delLawGroup的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String delLawGroup(HttpServletRequest request, OmLawGroupDTO dto) {
		try {
			delLawGroupImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * delLawGroupImp的中文名称：删除项目方法实现
	 *
	 * delLawGroupImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @throws
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void delLawGroupImp(HttpServletRequest request, final OmLawGroupDTO dto) throws Exception {
		// 删除法律法规项目
		dao.delete(OmLawGroup.class, dto.getItemid());
		// 删除法律法规内容
		dao.delete(OmLawContent.class, dto.getItemid());

	}

	/**
	 * queryContent的中文名称：查询内容
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryContent(HttpServletRequest request, OmLawContentDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select contentid, itemid, content, contentcode, contentsortid");
		sb.append(" from omlawcontent a ");
		sb.append(" where 1=1 ");
		sb.append(" and  a.contentid = :contentid ");
		sb.append(" and  a.itemid = :itemid ");
		sb.append(" order by contentsortid asc");

		String[] ParaName = new String[] { "contentid", "itemid" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };

		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				OmLawContentDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * saveContent的中文名称：保存内容
	 *
	 * saveContent的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String saveContent(HttpServletRequest request, OmLawContentDTO dto) {
		try {
			saveContentImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * saveContentImp的中文名称：保存内容
	 *
	 * saveContentImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void saveContentImp(HttpServletRequest request, OmLawContentDTO dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		dto.setContentoperatedate(new Date());
		dto.setContentoperateperson(user.getUserid().toString());
		if (null != dto.getContentid() && !"".equals(dto.getContentid())) {
			OmLawContent se = dao.fetch(OmLawContent.class, dto.getContentid());
			se.setItemid(dto.getItemid());
			se.setContentcode(dto.getContentcode());
			se.setContent(dto.getContent());
			se.setContentsortid(dto.getContentsortid());
			dao.update(se);
		} else {
			String sequence = DbUtils.getSequenceStr();
			OmLawContent olc = new OmLawContent();
			BeanHelper.copyProperties(dto, olc);
			olc.setContentid(sequence);
			dao.insert(olc);
		}
	}

	/**
	 *
	 * delContent的中文名称：删除内容
	 *
	 * delContent的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	public String delContent(HttpServletRequest request, OmLawContentDTO dto) {
		try {
			delContentImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * delContentImp的中文名称：删除内容
	 *
	 * delContentImp的概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @author : zy
	 */
	@Aop( { "trans" })
	public void delContentImp(HttpServletRequest request, OmLawContentDTO dto) throws Exception {

		dao.delete(OmLawContent.class, dto.getContentid());
	}
}
