package com.askj.oa.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.oa.dto.CirculationpaperDTO;
import com.askj.oa.dto.EgarchiveinfoDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.oa.entity.Circulationpaper;
import com.askj.oa.entity.Egarchivefile;
import com.askj.oa.entity.Egarchiveinfo;
import com.askj.oa.entity.Egarchivereceived;
import com.zzhdsoft.siweb.service.BaseService;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * ArchiveService的中文名称：公文管理service
 * 
 * ArchiveService的描述：
 * 
 * Written by : syf
 */
public class ArchiveService extends BaseService {
	protected final Logger logger = Logger.getLogger(ArchiveService.class);
	@Inject
	private Dao dao;
	/**
	 * 
	 * queryArchive中文名称:查询公文管理
	 * queryArchive概要描述:
	 * written by  :  lfy
	 * @throws Exception 
	 */
	public Map queryArchive(EgarchiveinfoDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from egarchiveinfo  ");
		sb.append(" where 1 = 1 ");
		sb.append(" and  archivetitle  like :archivetitle ");
		sb.append(" and  archiveopperuser  like :archiveopperuser");
		sb.append(" and  archiveid  = :archiveid");
		sb.append(" and  archiveopperuserid  = '"+vSysUser.getUserid()+"'");
		sb.append(" ORDER BY  archiveid  DESC");
		String[] ParaName = new String[] { "archivetitle", "archiveopperuser","archiveid"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgarchiveinfoDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	public Map queryArchiveDTO(EgarchiveinfoDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from egarchiveinfo  ");
		sb.append(" where 1 = 1 ");
		sb.append(" and  archivetitle  like :archivetitle ");
		sb.append(" and  archiveopperuser  like :archiveopperuser");
		sb.append(" and  archiveid  = :archiveid");

		sb.append(" ORDER BY  archiveid  DESC");
		String[] ParaName = new String[] { "archivetitle", "archiveopperuser","archiveid"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgarchiveinfoDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	/**
	 * 
	 * delArchive中文名称:删除公文
	 * delArchive概要描述:删除公文
	 * written by  :  lfy
	 */
	public String delArchive(HttpServletRequest request, EgarchiveinfoDTO dto) {
		// TODO Auto-generated method stub
		try {
			if (null != dto.getArchiveid()) {
				delArchiveImp(request, dto);
			} else {
				return "没有接收到要删除的公文ID！";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void delArchiveImp(HttpServletRequest request, EgarchiveinfoDTO dto) {
		dao.clear(Egarchiveinfo.class, Cnd.where("archiveid", "=", dto.getArchiveid()));
	}
	
	
	/**
	 * 
	 * addArchive中文名称:添加公文
	 * addArchive概要描述:
	 * written by  :  lfy
	 */
	public String addArchive(HttpServletRequest request, EgarchiveinfoDTO dto) {
		try {
			addArchiveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void addArchiveImp(HttpServletRequest request, EgarchiveinfoDTO dto) throws Exception {
		if (null != dto.getArchiveid() && !"".equals(dto.getArchiveid())) {
			Egarchiveinfo se = dao.fetch(Egarchiveinfo.class, dto.getArchiveid());
			se.setArchivestate("0");
			se.setSlbz("0");
			se.setArchivecode(dto.getArchivecode());//文档编号
			se.setArchivecontent(dto.getArchivecontent());//文档正文
			se.setArchivekey(dto.getArchivekey());//文档关键字
			se.setArchiveremark(dto.getArchiveremark());//备注
			se.setArchivetitle(dto.getArchivetitle());//标题
			se.setHuigao(dto.getHuigao());
			se.setRank(dto.getRank());
			se.setTerm(dto.getTerm());
			se.setFixedbasis(dto.getFixedbasis());
			se.setMaindelivery(dto.getMaindelivery());
			se.setCopy(dto.getCopy());
			se.setTyping(dto.getTyping());
			se.setProofreading(dto.getProofreading());
			se.setNumber(dto.getNumber());
			se.setWriting1(dto.getWriting1());
			se.setWriting2(dto.getWriting2());
			se.setWriting3(dto.getWriting3());
			se.setSealtime(dto.getSealtime());
			se.setThematicwords(dto.getThematicwords());
			se.setMessagetype(dto.getMessagetype());
			se.setSwzbh(dto.getSwzbh());
			dao.update(se);
		} else {
			Sysuser vSysUser = SysmanageUtil.getSysuser();
			String v_dbDatetime = SysmanageUtil.getDbtimeYmdHns();
			String archid = DbUtils.getSequenceStr();
			Egarchiveinfo v_Egarchiveinfo = new Egarchiveinfo();
			BeanHelper.copyProperties(dto, v_Egarchiveinfo);
			v_Egarchiveinfo.setArchiveid(dto.getFileid());//公文id
			v_Egarchiveinfo.setArchiveopperdate(v_dbDatetime);//日期
			v_Egarchiveinfo.setArchiveopperuser(vSysUser.getDescription());//名字
			v_Egarchiveinfo.setArchiveopperuserid(vSysUser.getUserid());//用户id
			v_Egarchiveinfo.setArchivestate("0");
			v_Egarchiveinfo.setSlbz("0");
			v_Egarchiveinfo.setHuigao(dto.getHuigao());
			v_Egarchiveinfo.setRank(dto.getRank());
			v_Egarchiveinfo.setTerm(dto.getTerm());
			v_Egarchiveinfo.setFixedbasis(dto.getFixedbasis());
			v_Egarchiveinfo.setMaindelivery(dto.getMaindelivery());
			v_Egarchiveinfo.setCopy(dto.getCopy());
			v_Egarchiveinfo.setTyping(dto.getTyping());
			v_Egarchiveinfo.setProofreading(dto.getProofreading());
			v_Egarchiveinfo.setNumber(dto.getNumber());
			v_Egarchiveinfo.setWriting1(dto.getWriting1());
			v_Egarchiveinfo.setWriting2(dto.getWriting2());
			v_Egarchiveinfo.setWriting3(dto.getWriting3());
			v_Egarchiveinfo.setSealtime(dto.getSealtime());
			v_Egarchiveinfo.setThematicwords(dto.getThematicwords());
			v_Egarchiveinfo.setMessagetype(dto.getMessagetype());
			v_Egarchiveinfo.setSwzbh(dto.getSwzbh());
			dao.insert(v_Egarchiveinfo);

			if("2".equals(dto.getMessagetype())) {
				Egarchivefile gd = new Egarchivefile();
				gd.setFileid(v_Egarchiveinfo.getArchiveid());//公文id
				gd.setFilecode(v_Egarchiveinfo.getArchivecode());//公文编码
				gd.setFilecontent(v_Egarchiveinfo.getArchivecontent());//公文内容
				gd.setFilekey(v_Egarchiveinfo.getArchivekey());//公文关键字
				gd.setFileremark(v_Egarchiveinfo.getArchiveremark());//公文备注
				gd.setFileopperdate(v_Egarchiveinfo.getArchiveopperdate());//公文时间
				gd.setFileopperuserid(v_Egarchiveinfo.getArchiveopperuserid());//用户id
				gd.setFileopperuser(v_Egarchiveinfo.getArchiveopperuser());//用户名
				gd.setFiletitle(v_Egarchiveinfo.getArchivetitle());//公文标题
				gd.setFilestate("1");//公文状态
				dao.insert(gd);
			}
		}
	}


	public String addArchivenew(HttpServletRequest request, EgarchiveinfoDTO dto) {
		try {
			addArchivenewImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void addArchivenewImp(HttpServletRequest request, EgarchiveinfoDTO dto) throws Exception {
		if (null != dto.getArchiveid() && !"".equals(dto.getArchiveid())) {
			Egarchiveinfo se = dao.fetch(Egarchiveinfo.class, dto.getArchiveid());
			se.setWriting1(dto.getWriting1());
			se.setWriting2(dto.getWriting2());
			se.setWriting3(dto.getWriting3());
			se.setLwjg(dto.getLwjg());
			dao.update(se);
		}
	}
	/**
	 * 
	 * queryRearchive中文含义:查询收文
	 * queryRearchive描述:
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	public Map queryRearchive(EgarchiveinfoDTO dto, PagesDTO pd) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*,b.messagetype from egarchivereceived  a");
		sb.append("  left join egarchiveinfo b on a.archiveid=b.archiveid");
		sb.append(" where 1 = 1 ");
		sb.append(" and  a.rcarchivestate = 1 ");
		sb.append(" and  a.rcarchivetitle  like :rcarchivetitle ");
		sb.append(" and  a.rcarchiveopperuser  like :rcarchiveopperuser");
		sb.append(" and  a.rcarchiveid  = :rcarchiveid");
		sb.append(" and  a.archiveid  = :archiveid");
		sb.append(" and  a.rcarchiveuserid  = '"+vSysUser.getUserid()+"'");
		String[] ParaName = new String[] { "rcarchivetitle", "rcarchiveopperuser","rcarchiveid","archiveid","rcarchiveuserid"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgarchiveinfoDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}

	/**
	 *
	 * querySwbianhao中文含义:查询收文总编号
	 * querySwbianhao描述:
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by  ：  zk
	 */
	public Map querySwbianhao(EgarchiveinfoDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select  right(ifnull(max(swzbh)+1,'01'),2) swzbh  ");
		sb.append(" from egarchiveinfo ");
		sb.append(" where 1 = 1 ");
		sb.append(" and  messagetype='2' ");
		sb.append("and DATE_FORMAT( sealtime, '%Y%m' ) = DATE_FORMAT( CURDATE( ) , '%Y%m' ) ");
		sb.append(" and  lwjg  = :lwjg");
		String[] ParaName = new String[] { "lwjg"};
		int[] ParaType = new int[] { Types.VARCHAR};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgarchiveinfoDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap<Object, Object>();
		r.put("rows", ls);
		return r;
	}

	public Map queryCount(EgarchiveinfoDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select  *  ");
		sb.append(" from egarchiveinfo ");
		sb.append(" where 1 = 1 ");
		sb.append(" and  messagetype='1' ");
		sb.append(" and  lwjg  = :swzbh");
		String[] ParaName = new String[] { "swzbh"};
		int[] ParaType = new int[] { Types.VARCHAR};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgarchiveinfoDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap<Object, Object>();
		r.put("rows", ls);
		return r;
	}
	/**
	 * 
	 * queryGdarchive中文含义:查询归档
	 * queryGdarchive描述:
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * written  by  ：  lfy
	 */
	public Map queryGdarchive(EgarchiveinfoDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.*, ");
		sb.append(" (select b.messagetype from  egarchiveinfo b where a.fileid=b.archiveid) messagetype ");
		sb.append("from egarchivefile  a   ");
		sb.append(" where 1 = 1 ");
		sb.append(" and  a.filestate = 1");
		sb.append(" and  a.filetitle  like :filetitle ");
		sb.append(" and  a.fileopperuser  like :fileopperuser");
		sb.append(" and  a.fileid  = :fileid");
		sb.append(" order by a.fileopperdate desc");
		String[] ParaName = new String[] { "filetitle", "fileopperuser","fileid"};
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		String sql = sb.toString();
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, EgarchiveinfoDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap<Object, Object>();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	/**
	 * 
	 * updateArchive中文含义:
	 * updateArchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * written  by  ：  lfy
	 */
	public String updateArchive(HttpServletRequest request, EgarchiveinfoDTO dto) {
		try {
			updateArchiveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void updateArchiveImp(HttpServletRequest request, EgarchiveinfoDTO dto) throws Exception {
		if (null != dto.getArchiveid() && !"".equals(dto.getArchiveid())) {
			if(null != dto.getArchivestate() && !"".equals(dto.getArchivestate())){
				String sql="UPDATE  egarchiveinfo e  SET  e.archivestate='"+dto.getArchivestate()
						   +"' WHERE e.archiveid='"+dto.getArchiveid()+"'";
				Sql sqls = Sqls.create(sql.toString());
				dao.execute(sqls);
			}
		}
	}
	/**
	 * 
	 * a2Rearchive中文含义:
	 * a2Rearchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * written  by  ：  lfy
	 */
	public String a2Rearchive(HttpServletRequest request, EgarchiveinfoDTO dto,CirculationpaperDTO circulationpaperDTO) {
		try {
			dao.clear(Egarchivereceived.class,Cnd.where("archiveid", "=", dto.getArchiveid()));
			a2RearchiveImp(request, dto,circulationpaperDTO);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void a2RearchiveImp(HttpServletRequest request, EgarchiveinfoDTO dto,CirculationpaperDTO circulationpaperDTO) throws Exception {

		if(null != dto.getArchiveid() && !"".equals(dto.getArchiveid())){
			Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
			if(vSysUser==null){
				vSysUser = SysmanageUtil.getSysuser(dto.getRcarchiveopperuserid());
			}
			if (null != circulationpaperDTO.getCyry() && !"".equals(circulationpaperDTO.getCyry())) {
				String[] cyry = circulationpaperDTO.getCyry().split(",");
				String[] cyryid = circulationpaperDTO.getCyryid().split(",");


				for (int i = 0; i < cyry.length; i++) {
					//目标对象
					Egarchivereceived re=new Egarchivereceived();
					EgarchiveinfoDTO converDto = new EgarchiveinfoDTO();
					converDto.setArchiveid(dto.getArchiveid());
					Map map=queryArchive(dto, new PagesDTO());
					List ls = (List) map.get("rows");
					if(ls.size()>0 && ls != null){
						EgarchiveinfoDTO info = (EgarchiveinfoDTO)ls.get(0);
						re.setRcarchiveid(DbUtils.getSequenceStr());//收文ID
						re.setRcarchivecode(info.getArchivecode());//公文编码
						re.setRcarchivecontent(info.getArchivecontent());//公文内容
						re.setRcarchivekey(info.getArchivekey());//公文关键字
						re.setRcarchiveremark(info.getArchiveremark());//公文备注
						re.setRcarchiveopperdate(info.getArchiveopperdate());//公文时间
						re.setRcarchiveopperuserid(vSysUser.getUserid());//用户id
						re.setRcarchiveopperuser(vSysUser.getUsername());//用户名
						re.setRcarchivetitle(info.getArchivetitle());//公文标题
						re.setRcarchivestate(info.getArchivestate());//公文状态
						re.setRcarchiveuserid(cyryid[i]);
						re.setRcarchiveusername(cyry[i]);
						re.setArchiveid(info.getArchiveid());

					}

					converDto = new EgarchiveinfoDTO();
					converDto.setArchiveid(dto.getArchiveid());
					converDto.setRcarchiveuserid(re.getRcarchiveuserid());
					map=this.queryRearchive(converDto,new PagesDTO());
					ls = (List) map.get("rows");
					if(ls.size()>0 && ls != null){
						dao.update(re);
					}else{
						dao.insert(re);
					}

				}
			}
		}

	}

	/**
	 * 
	 * gdAearchive中文含义:
	 * gdAearchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * written  by  ：  lfy
	 */
	public String gdAearchive(HttpServletRequest request, EgarchiveinfoDTO dto) {
		try {
			gdAearchiveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void gdAearchiveImp(HttpServletRequest request, EgarchiveinfoDTO dto) throws Exception {

		if(null != dto.getArchiveid() && !"".equals(dto.getArchiveid())){
			//目标对象
			Egarchivefile gd=new Egarchivefile();

			Map map=queryArchive(dto, new PagesDTO());
			List ls = (List) map.get("rows");
			if(ls.size()>0 && ls != null){
				EgarchiveinfoDTO info = (EgarchiveinfoDTO)ls.get(0);
				gd.setFileid(info.getArchiveid());//公文id
				gd.setFilecode(info.getArchivecode());//公文编码
				gd.setFilecontent(info.getArchivecontent());//公文内容
				gd.setFilekey(info.getArchivekey());//公文关键字
				gd.setFileremark(info.getArchiveremark());//公文备注
				gd.setFileopperdate(info.getArchiveopperdate());//公文时间
				gd.setFileopperuserid(info.getArchiveopperuserid());//用户id
				gd.setFileopperuser(info.getArchiveopperuser());//用户名
				gd.setFiletitle(info.getArchivetitle());//公文标题
				gd.setFilestate("1");//公文状态
			}
			dto.setFileid(dto.getArchiveid());
			map=this.queryGdarchive(dto,new PagesDTO());
			ls = (List) map.get("rows");
			if(ls.size()>0 && ls != null){
				dao.update(gd);
			}else{
				dao.insert(gd);
			}

		}
	}
	/**
	 * 
	 * delRearchive中文含义:
	 * delRearchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * written  by  ：  lfy
	 */
	public String delRearchive(HttpServletRequest request, EgarchiveinfoDTO dto) {
		try {
			delRearchiveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void delRearchiveImp(HttpServletRequest request, EgarchiveinfoDTO dto) throws Exception {
		if (null != dto.getRcarchiveid() && !"".equals(dto.getRcarchiveid())) {
				String sql="UPDATE  egarchivereceived  e  SET  e.rcarchivestate=0  WHERE e.rcarchiveid='"+dto.getRcarchiveid()+"'";
				Sql sqls = Sqls.create(sql.toString());
				dao.execute(sqls);
		}
	}
	/**
	 * 
	 * delgdArchive中文含义:
	 * delgdArchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * written  by  ：  lfy
	 */
	public String delgdArchive(HttpServletRequest request, EgarchiveinfoDTO dto) {
		try {
			delgdArchiveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void delgdArchiveImp(HttpServletRequest request,EgarchiveinfoDTO dto) {
		if (null != dto.getFileid() && !"".equals(dto.getFileid())) {
			String sql="UPDATE  egarchivefile  e  SET  e.filestate=0  WHERE e.fileid='"+dto.getFileid()+"'";
			Sql sqls = Sqls.create(sql.toString());
			dao.execute(sqls);
	}
	}
	/**
	 * 
	 * paperArchive中文含义:
	 * paperArchive描述:
	 * @param request
	 * @param dto
	 * @return
	 * written  by  ：  lfy
	 */
	public String paperArchive(HttpServletRequest request, CirculationpaperDTO dto) {
		try {
			paperarchiveImp(request, dto);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	@Aop({ "trans" })
	private void paperarchiveImp(HttpServletRequest request,
			CirculationpaperDTO dto) throws Exception {
		Sysuser vSysUser = (Sysuser) SysmanageUtil.getSysuser();
		if (null != dto.getCyry() && !"".equals(dto.getCyry())) {
			String[] cyry = dto.getCyry().split(",");
			String[] cyryid = dto.getCyryid().split(",");
			for (int i = 0; i < cyry.length; i++) {
				String cid = DbUtils.getSequenceStr();
				Circulationpaper cir = new Circulationpaper();
				cir.setPaperid(cid);//传阅id
				cir.setRecuserid(cyryid[i]);//接受者id
				cir.setRecusername(cyry[i]);//接受者名字
				cir.setPaperstate("0");//传阅状态  0为未查看
				cir.setPaperuserid(vSysUser.getUserid());//传阅者id
				cir.setPaperusername(vSysUser.getUsername());//传阅者名字
				cir.setFileid(dto.getFileid());//公文id
				if(null != dto.getFileid()&& !"".equals(dto.getFileid())){
					EgarchiveinfoDTO info=new EgarchiveinfoDTO();
					info.setFileid(dto.getFileid());
					Map	map=this.queryGdarchive(info,new PagesDTO());
					List ls = (List) map.get("rows");
					if(ls.size()>0 && ls != null){
						EgarchiveinfoDTO info2 = (EgarchiveinfoDTO)ls.get(0);
						cir.setFiletitle(info2.getFiletitle());//公文标题
					}
				}
				dao.insert(cir);
			}
		}
			
			}
		}

	 
