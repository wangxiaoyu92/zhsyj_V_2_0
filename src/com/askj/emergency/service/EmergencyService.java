package com.askj.emergency.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.json.Json;
import org.nutz.lang.Lang;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.askj.emergency.dto.EmeventcheckinDTO;
import com.askj.emergency.dto.EmgroupinfoDTO;
import com.askj.emergency.dto.EmteampersonDTO;
import com.zzhdsoft.siweb.entity.news.News;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.emergency.entity.Emeventcheckin;
import com.askj.emergency.entity.Emgroupinfo;
import com.askj.emergency.entity.Emteamperson;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * EmergencyService的中文名称：应急指挥service
 * 
 * EmergencyService的描述：
 * 
 * Written by : zy
 */
public class EmergencyService extends BaseService {
	protected final Logger logger = Logger.getLogger(EmergencyService.class);
	@Inject
	private Dao dao;

	/**
	 * 
	 * queryEmergencysList的中文名称：查询预案信息
	 * 
	 * queryEmergencysList的概要说明：查询预案信息列表包含多条件查询
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	public Map<?, ?> queryEmergencysList(News dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select newsid,b.cateid,newstitle,newsauthor,newsfrom, ");
		sb.append(" newstjsj,newsispicture,newscontent,sfyx ");
		sb.append("  from news a,newscate b ");
		sb.append(" where 1 = 1 ");
		sb.append("   and a.cateid = b.cateid ");
		sb.append("   and b.cateparentid = '2016052509413171962672484'");
		sb.append("   and b.cateid = :cateid ");
		sb.append("   and b.catejc = :catejc ");
		sb.append("   and a.newsid = :newsid");
		sb.append("   and a.newstitle like :newstitle");
		String[] ParaName = new String[] { "cateid", "catejc", "newsid",
				"newstitle" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null, News.class, pd
				.getPage(), pd.getRows());
		List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);

		Map<Object, Object> r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * queryEmergency的中文名称：查询突发事件登记
	 * 
	 * queryEmergency的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	public Map<?, ?> queryEmergency(EmeventcheckinDTO dto, PagesDTO pd) throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*, ");
		sb.append(" (select aaa129 from Aa13 where aaa027 = a.aaa027) aaa027name");
		sb.append(" from emeventcheckin a ");
		sb.append(" where 1=1 ");
		sb.append("  and eventid = :eventid");
		sb.append("  and newsid = :newsid");
		sb.append("  and eventlevel = :eventlevel");//wang添加事件等级搜索参数(之前没有)
		sb.append("  and eventstate = :eventstate");
		sb.append("  and aaa027 like :aaa027 ");
		
		sb.append(" order by a.eventid desc ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "eventid", "newsid","eventlevel", "eventstate", "aaa027"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR, Types.VARCHAR };

		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EmeventcheckinDTO.class,
				pd.getPage(), pd.getRows());
		List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
		Map<Object, Object> r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * delEmergency的中文名称：删除突发事件登记
	 * 
	 * delEmergency的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String delEmergency(HttpServletRequest request, EmeventcheckinDTO dto) {
		try {
			delEmergencyImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	@Aop({ "trans" })
	public void delEmergencyImp(HttpServletRequest request, EmeventcheckinDTO dto)
			throws Exception {
		Emeventcheckin se = dao.fetch(Emeventcheckin.class, dto.getEventid());
		dao.delete(se);
	}
	
	/**
	 * 
	 * queryEmergencyDTO的中文名称：查询突发事件登记信息DTO
	 * 
	 * queryEmergencyDTO的概要说明：
	 * 
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 */
	public Object queryEmergencyDTO(EmeventcheckinDTO dto) throws Exception {

		// 查询事件登记信息
		Emeventcheckin v_emeventcheckin = dao.fetch(Emeventcheckin.class, dto.getEventid());
		EmeventcheckinDTO v_emeventcheckinDTO = new EmeventcheckinDTO();
		if (v_emeventcheckin != null) {
			v_emeventcheckinDTO.setEventaddress(v_emeventcheckin.getEventaddress());
			v_emeventcheckinDTO.setEventcontent(v_emeventcheckin.getEventcontent());
			v_emeventcheckinDTO.setEventdate(v_emeventcheckin.getEventdate());
			v_emeventcheckinDTO.setEventfinder(v_emeventcheckin.getEventfinder());
			v_emeventcheckinDTO.setEventid(v_emeventcheckin.getEventid());
			v_emeventcheckinDTO.setEventlevel(v_emeventcheckin.getEventlevel());
			v_emeventcheckinDTO.setEventstate(v_emeventcheckin.getEventstate());
			v_emeventcheckinDTO.setNewsinitiator(v_emeventcheckin.getNewsinitiator());
			v_emeventcheckinDTO.setOperatedate(v_emeventcheckin.getOperatedate());
			v_emeventcheckinDTO.setOperateperson(v_emeventcheckin.getOperateperson());
			v_emeventcheckinDTO.setRemark(v_emeventcheckin.getRemark());
			v_emeventcheckinDTO.setEventjdzb(v_emeventcheckin.getEventjdzb());
			v_emeventcheckinDTO.setEventwdzb(v_emeventcheckin.getEventwdzb());
			v_emeventcheckinDTO.setAaa027(v_emeventcheckin.getAaa027());
		}
		// 查询预案信息
//		News v_news = dao.fetch(News.class, dto.getNewsid());
//		if (v_news != null) {
//			v_emeventcheckinDTO.setCateid(v_news.getCateid());
//			v_emeventcheckinDTO.setNewsauthor(v_news.getNewsauthor());
//			v_emeventcheckinDTO.setNewscontent(v_news.getNewscontent());
//			v_emeventcheckinDTO.setNewsfrom(v_news.getNewsfrom());
//			v_emeventcheckinDTO.setNewstjsj(v_news.getNewstjsj());
//			v_emeventcheckinDTO.setNewsispicture(v_news.getNewsispicture());
//			v_emeventcheckinDTO.setNewstitle(v_news.getNewstitle());
//			v_emeventcheckinDTO.setSfyx(v_news.getSfyx());
//		}
		return v_emeventcheckinDTO;
	}
	
	/**
	 * 
	 * saveEmergency的中文名称：保存突发事件登记信息
	 * 
	 * saveEmergency的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String saveEmergency(HttpServletRequest request, EmeventcheckinDTO dto) {
		try {
			saveEmergencyImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	@Aop({ "trans" })
	public void saveEmergencyImp(HttpServletRequest request, EmeventcheckinDTO dto)
			throws Exception {
		// 事件发生时间
		if ("".equals(dto.getEventdate())) {
			dto.setEventdate(null);
		}
		Sysuser user = SysmanageUtil.getSysuser();
		if (null != dto.getEventid()&&!"".equals(dto.getEventid())) {
			Emeventcheckin se = dao.fetch(Emeventcheckin.class, dto.getEventid());
			se.setEventaddress(dto.getEventaddress()); // 事件发生地点
			se.setEventjdzb(dto.getEventjdzb());
			se.setEventwdzb(dto.getEventwdzb());
			se.setEventcontent(dto.getEventcontent()); // 事件内容
			se.setEventdate(dto.getEventdate()); // 事件发生时间
			se.setEventfinder(dto.getEventfinder()); // 事件上报人联系方式
			se.setEventlevel(dto.getEventlevel()); // 事件等级
			se.setEventstate(dto.getEventstate()); // 状态
			se.setNewsid(dto.getNewsid()); // 备案信息id
			se.setNewsinitiator(dto.getNewsinitiator()); // 事件上报人
			se.setAaa027(dto.getAaa027());
			se.setOperateperson(user.getUserid()); // 经办人
			se.setOperatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
			se.setRemark(dto.getRemark()); // 备注
			dao.update(se);
		} else {
			String v_id = DbUtils.getSequenceStr();
			Emeventcheckin se = new Emeventcheckin();
			se.setEventid(v_id); // 事件id
			se.setEventaddress(dto.getEventaddress()); // 事件发生地点
			se.setEventjdzb(dto.getEventjdzb());
			se.setEventwdzb(dto.getEventwdzb());
			se.setEventcontent(dto.getEventcontent()); // 事件内容
			se.setEventdate(dto.getEventdate()); // 事件发生时间
			se.setEventfinder(dto.getEventfinder()); // 事件上报人联系方式
			se.setEventlevel(dto.getEventlevel()); // 事件等级
			se.setEventstate(dto.getEventstate()); // 状态
			se.setNewsid(dto.getNewsid()); // 备案信息id
			se.setNewsinitiator(dto.getNewsinitiator()); // 事件上报人
			se.setAaa027(dto.getAaa027());
			se.setOperateperson(user.getUserid()); // 经办人
			se.setOperatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
			se.setRemark(dto.getRemark()); // 备注
			dao.insert(se);
		}
	}
	
	/**
	 * 
	 * queryEmergencyGroupList的中文名称：查询应急队伍信息
	 * 
	 * queryEmergencyGroupList的概要说明：查询应急队伍信息列表包含多条件查询
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	public Map<?, ?> queryEmergencyGroupList(EmgroupinfoDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append("  from emgroupinfo a ");
		sb.append(" where 1 = 1 ");
		sb.append("   and a.groupname like :groupname ");
		sb.append("   and a.state = :state ");
		String[] ParaName = new String[] { "groupname", "state"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null, Emgroupinfo.class, pd
				.getPage(), pd.getRows());
		List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);

		Map<Object, Object> r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * saveEmergencyGroup的中文名称：保存应急小组信息
	 * 
	 * saveEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String saveEmergencyGroup(HttpServletRequest request, EmgroupinfoDTO dto) {
		try {
			saveEmergencyGroupImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveEmergencyGroupImp的中文名称：保存应急小组信息实现方法
	 * 
	 * saveEmergencyGroupImp的概要说明：更新或保存应急小组信息
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void saveEmergencyGroupImp(HttpServletRequest request, EmgroupinfoDTO dto)
			throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		if (null != dto.getGroupid()&&!"".equals(dto.getGroupid())) {
			Emgroupinfo se = dao.fetch(Emgroupinfo.class, dto.getGroupid());
			se.setGroupname(dto.getGroupname()); // 应急小组名
			se.setState("0"); // 状态 默认存在[0:存在 1:删除 2:解散]
			se.setOpepatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
			se.setOpepateperson(user.getUsername()); // 经办人
			se.setRemark(dto.getRemark()); // 备注
			dao.update(se);
		} else {
			String v_id = DbUtils.getSequenceStr();
			Emgroupinfo se = new Emgroupinfo();
			se.setGroupid(v_id); // 小组id
			se.setGroupname(dto.getGroupname()); // 应急小组名
			se.setState("0"); // 状态 默认存在[0:存在 1:删除 2:解散]
			se.setOpepatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
			se.setOpepateperson(user.getUsername()); // 经办人
			se.setRemark(dto.getRemark()); // 备注
			dao.insert(se);
		}
	}
	
	/**
	 * 
	 * delEmergencyGroup的中文名称：删除应急小组信息（解散）
	 * 
	 * delEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String delEmergencyGroup(HttpServletRequest request, EmgroupinfoDTO dto) {
		try {
			delEmergencyGroupImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * delEmergencyGroupImp的中文名称：删除应急小组信息实现方法（解散）
	 * 
	 * delEmergencyGroupImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void delEmergencyGroupImp(HttpServletRequest request, EmgroupinfoDTO dto)
			throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		// 修改应急小组表中的状态
		Emgroupinfo se = dao.fetch(Emgroupinfo.class, dto.getGroupid());
		se.setState("2"); // 状态 默认存在[0:存在 1:删除 2:解散]
		se.setOpepatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
		se.setOpepateperson(user.getUsername()); // 经办人
		dao.update(se);
		// 修改小组成员表中的状态
		dao.update(Emteamperson.class, Chain.make("state","2"), Cnd.where("groupid", "=", dto.getGroupid()));
	}
	
	/**
	 * 
	 * rollbackEmergencyGroup的中文名称：将解散的应急小组恢复
	 * 
	 * rollbackEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String rollbackEmergencyGroup(HttpServletRequest request, EmgroupinfoDTO dto) {
		try {
			rollbackEmergencyGroupImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * rollbackEmergencyGroupImp的中文名称：将解散的应急小组恢复
	 * 
	 * rollbackEmergencyGroupImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void rollbackEmergencyGroupImp(HttpServletRequest request, EmgroupinfoDTO dto)
			throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		// 修改应急小组表中的状态
		Emgroupinfo se = dao.fetch(Emgroupinfo.class, dto.getGroupid());
		se.setState("0"); // 状态 默认存在[0:存在 1:删除 2:解散]
		se.setOpepatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
		se.setOpepateperson(user.getUsername()); // 经办人
		dao.update(se);
		// 修改小组成员表中的状态
		dao.update(Emteamperson.class, Chain.make("state","0"), Cnd.where("groupid", "=", dto.getGroupid()));
	}
	
	/**
	 * 
	 * queryEmergencyGroupDto的中文名称：查询应急小组信息
	 * 
	 * queryEmergencyGroupDto的概要说明：查询单条详细信息
	 * 
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 *             Written by : zy
	 */
	public Object queryEmergencyGroupDto(EmgroupinfoDTO dto) throws Exception {

		Emgroupinfo v_emgroupinfo = dao.fetch(Emgroupinfo.class, dto.getGroupid());
		EmgroupinfoDTO v_emgroupinfoDTO = new EmgroupinfoDTO();
		if (v_emgroupinfo != null && !"".equals(v_emgroupinfo.getGroupid())) {
			Emgroupinfo se = dao.fetch(Emgroupinfo.class, dto.getGroupid());
			v_emgroupinfoDTO.setGroupname(se.getGroupname()); // 应急小组名
			v_emgroupinfoDTO.setState(se.getState()); // 状态
			v_emgroupinfoDTO.setOpepatedate(se.getOpepateperson()); // 经办时间
			v_emgroupinfoDTO.setOpepateperson(se.getOpepatedate()); // 经办人
			v_emgroupinfoDTO.setRemark(se.getRemark()); // 备注
		}
		return v_emgroupinfoDTO;
	}
	
	/**
	 * 
	 * queryEmergencyGroupPerson的中文名称：查询应急队伍成员信息
	 * 
	 * queryEmergencyGroupPerson的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return Written by : zy
	 * @throws Exception
	 * 
	 */
	public Map<?, ?> queryEmergencyGroupPerson(EmteampersonDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select em.*,sys.username, sys.userkind, sys.description, sys.mobile, org.orgname ");
		sb.append("  from emteamperson em, sysuser sys, sysorg org  ");
		sb.append(" where 1 = 1 ");
		sb.append("   and em.USERID = sys.USERID ");
		sb.append("   and sys.ORGID = org.ORGID  ");
		sb.append("   and em.state = 0  "); // 默认查询状态存在的用户
		sb.append("   and em.groupid = :groupid ");
		sb.append("   and em.etpid = :etpid ");
		String[] ParaName = new String[] { "groupid", "etpid"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EmteampersonDTO.class, pd
				.getPage(), pd.getRows());
		List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);

		Map<Object, Object> r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * addUserToEmergencyGroup的中文名称：添加用户到应急小组
	 * 
	 * addUserToEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String addUserToEmergencyGroup(HttpServletRequest request, EmteampersonDTO dto) {
		try {
			addUserToEmergencyGroupImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 
	 * addUserToEmergencyGroupImp的中文名称：添加用户到应急小组实现方法
	 * 
	 * addUserToEmergencyGroupImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void addUserToEmergencyGroupImp(HttpServletRequest request, EmteampersonDTO dto)
			throws Exception {
		// 获取当前用户
		Sysuser user = SysmanageUtil.getSysuser();
		// 获取当前时间
		String currentTime = SysmanageUtil.getDbtimeYmdHns();
		String JsonStr = request.getParameter("JsonStr");
		List<SysuserDTO> personList = Json.fromJsonAsList(SysuserDTO.class, JsonStr);
		for (int i = 0; i < personList.size(); i++) {
			SysuserDTO person = (SysuserDTO) personList.get(i);
			// 判断用户是否加入过当前应急小组
			Emteamperson se = checkUserIsInGroup(person.getUserid(), dto.getGroupid());
			if (se != null) {
				se.setState("0"); // 状态 默认存在[0:存在 1:删除 2:解散]
				se.setOpepatedate(currentTime); // 经办时间
				se.setOpepateperson(user.getUsername()); // 经办人
				dao.update(se);
			} else {
				String v_id = DbUtils.getSequenceStr();
				se = new Emteamperson();
				se.setEtpid(v_id); // 成员关系表id
				se.setGroupid(dto.getGroupid()); // 小组id
				se.setUserid(person.getUserid()); // 用户id
				se.setState("0"); // 状态 默认存在[0:存在 1:删除 2:解散]
				se.setOpepatedate(currentTime); // 经办时间
				se.setOpepateperson(user.getUsername()); // 经办人
				dao.insert(se);
			}
		}
	}
	
	/**
	 * 
	 * checkUserIsInGroup的中文名称：判断用户是否在小组里
	 * 
	 * checkUserIsInGroup的概要说明：
	 * @param userid
	 * @param groupid
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	public Emteamperson checkUserIsInGroup(String userid, String groupid)
			throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.* ");
		sb.append("  from emteamperson a ");
		sb.append(" where 1 = 1 ");
		sb.append(" and userid = '").append(userid).append("' ");
		sb.append(" and groupid = '").append(groupid).append("' ");
		String[] ParaName = new String[] {};
		int[] ParaType = new int[] {};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, null);
		Map<?, ?> m = DbUtils.DataQuery(GlobalNames.sql, sql, null,
				Emteamperson.class);
		List<?> ls = (List<?>) m.get(GlobalNames.SI_RESULTSET);
		Emteamperson emteamperson = new Emteamperson();
		if (ls != null && ls.size() > 0) {
			emteamperson = (Emteamperson) ls.get(0);
			return emteamperson;
		} else {
			return null;
		}
	}
	
	/**
	 * 
	 * delUserOutOfEmergencyGroup的中文名称：将用户从应急小组中移除
	 * 
	 * delUserOutOfEmergencyGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String delUserOutOfEmergencyGroup(HttpServletRequest request, EmteampersonDTO dto) {
		try {
			delUserOutOfEmergencyGroupImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 
	 * delUserOutOfEmergencyGroupImp的中文名称：将用户从应急小组中移除实现方法
	 * 
	 * delUserOutOfEmergencyGroupImp的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void delUserOutOfEmergencyGroupImp(HttpServletRequest request, EmteampersonDTO dto)
			throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		String JsonStr = request.getParameter("JsonStr");
		List<EmteampersonDTO> personList = Json.fromJsonAsList(EmteampersonDTO.class, JsonStr);
		for (int i = 0; i < personList.size(); i++) {
			EmteampersonDTO person = (EmteampersonDTO) personList.get(i);
			Emteamperson se = dao.fetch(Emteamperson.class, person.getEtpid());
			se.setState("1"); // 将存在状态改为删除状态状态 默认存在[0:存在 1:删除 2:解散]
			se.setOpepatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
			se.setOpepateperson(user.getUsername()); // 经办人
			dao.update(se);
		}
	}
	
	/**
	 * 
	 * saveEmergencyGroupPerson的中文名称：保存应急小组成员信息
	 * 
	 * saveEmergencyGroupPerson的概要说明：
	 * 
	 * @param dto
	 * @return Written by : zy
	 * 
	 */
	public String saveEmergencyGroupPerson(HttpServletRequest request, EmteampersonDTO dto) {
		try {
			saveEmergencyGroupPersonImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * saveEmergencyGroupPersonImp的中文名称：保存应急小组成员信息实现方法
	 * 
	 * saveEmergencyGroupPersonImp的概要说明：保存应急小组成员信息
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void saveEmergencyGroupPersonImp(HttpServletRequest request, EmteampersonDTO dto)
			throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		Emteamperson se = dao.fetch(Emteamperson.class, dto.getEtpid());
		se.setState("0"); // 状态 默认存在
		se.setEtptype("".equals(dto.getEtptype())?null:dto.getEtptype()); // 成员类型
		se.setOpepatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
		se.setOpepateperson(user.getUsername()); // 经办人
		se.setEtpremark(dto.getEtpremark()); // 备注
		dao.update(se);
	}

	/**
	 *
	 * saveEmergencyByMobile的中文名称：保存突发事件登记信息
	 *
	 * saveEmergency的概要说明：
	 *
	 * @param dto
	 * @return Written by : zy
	 *
	 */
	public String saveEmergencyByMobile(HttpServletRequest request, EmeventcheckinDTO dto) {
		try {
			saveEmergencyByMobileImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	/**
	 *
	 * saveEmergencyImp的中文名称：保存突发事件登记信息实现方法
	 *
	 * saveEmergencyImp的概要说明：更新或保存突发事件登记信息
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({ "trans" })
	public void saveEmergencyByMobileImp(HttpServletRequest request, EmeventcheckinDTO dto)
			throws Exception {
		// 事件发生时间
		if ("".equals(dto.getEventdate())) {
			dto.setEventdate(null);
		}
		if (null != dto.getEventid()&&!"".equals(dto.getEventid())) {
			Emeventcheckin se = dao.fetch(Emeventcheckin.class, dto.getEventid());
			se.setEventaddress(dto.getEventaddress()); // 事件发生地点
			se.setEventjdzb(dto.getEventjdzb());
			se.setEventwdzb(dto.getEventwdzb());
			se.setEventcontent(dto.getEventcontent()); // 事件内容
			se.setEventdate(dto.getEventdate()); // 事件发生时间
			se.setEventfinder(dto.getEventfinder()); // 事件上报人联系方式
			se.setEventlevel(dto.getEventlevel()); // 事件等级
			se.setEventstate(dto.getEventstate()); // 状态
			se.setNewsid(dto.getNewsid()); // 备案信息id
			se.setNewsinitiator(dto.getNewsinitiator()); // 事件上报人
			se.setAaa027(dto.getAaa027());
			se.setOperateperson(dto.getOperateperson()); // 经办人
			se.setOperatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
			se.setRemark(dto.getRemark()); // 备注
			dao.update(se);
		} else {
			String v_id = DbUtils.getSequenceStr();
			Emeventcheckin se = new Emeventcheckin();
			se.setEventid(v_id); // 事件id
			se.setEventaddress(dto.getEventaddress()); // 事件发生地点
			se.setEventjdzb(dto.getEventjdzb());
			se.setEventwdzb(dto.getEventwdzb());
			se.setEventcontent(dto.getEventcontent()); // 事件内容
			se.setEventdate(dto.getEventdate()); // 事件发生时间
			se.setEventfinder(dto.getEventfinder()); // 事件上报人联系方式
			se.setEventlevel(dto.getEventlevel()); // 事件等级
			se.setEventstate(dto.getEventstate()); // 状态
			se.setNewsid(dto.getNewsid()); // 备案信息id
			se.setNewsinitiator(dto.getNewsinitiator()); // 事件上报人
			se.setAaa027(dto.getAaa027());
			se.setOperateperson(dto.getOperateperson()); // 经办人
			se.setOperatedate(SysmanageUtil.getDbtimeYmdHns()); // 经办时间
			se.setRemark(dto.getRemark()); // 备注
			dao.insert(se);
		}
	}
	
}
