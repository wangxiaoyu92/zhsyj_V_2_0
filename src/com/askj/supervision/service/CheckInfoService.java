package com.askj.supervision.service;

import java.sql.Types;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;
import org.nutz.lang.Strings;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.BsCheckPalnAndTypeDTO;
import com.askj.supervision.dto.BscheckplanDTO;
import com.askj.supervision.dto.pubkeyDTO;
import com.zzhdsoft.siweb.entity.Aa10;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.askj.supervision.entity.CheckContent;
import com.askj.supervision.entity.CheckGroup;
import com.askj.supervision.entity.Ombasetype;
import com.zzhdsoft.utils.POIWordUtil;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * CheckInfoService的中文名称：检查信息service
 * 
 * CheckInfoService的描述：
 * 
 * Written by : syf
 */
public class CheckInfoService {
	protected final Logger logger = Logger.getLogger(CheckInfoService.class);
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
	 * Written by:syf
	 */
	public List queryItemZTreeAsync(HttpServletRequest request) throws Exception {
		String itemId = StringHelper.showNull2Empty(request
				.getParameter("itemid")); 
		String itempid = "0";
		if ("".equals(itemId)) {	
			itempid = "0000000000000000000000000";
		}else{
			itempid = itemId;
		}
		
		String sb = "";
		sb += " select itemid,itemname,itemdesc,itempid,parentname,itemsortid,itemremark,itemtype,childnum,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isparent,";
		sb += " case when childnum > 0 then 'true' else 'false' end as isopen,plantypearea,ifnull(planmobankind,'') as planmobankind ";
		sb += " from (";
		sb += " select t.itemid,t.itemname,t.itemdesc,t.itempid,t.itemsortid,t.itemremark,t.itemtype,";
		sb += " 	(select count(t1.itemid) from omcheckgroup t1 where t1.itempid = t.itemid) childnum, ";
		sb += " 	(select t2.itemname from omcheckgroup t2 where t2.itemid = t.itempid) parentname, ";
		//gu20180325
		sb+=" (select group_concat(t2.aaa102) from ombasetype t1,viewcomfenlei t2 where t1.basetype=t2.aaz093 and t1.itemtype=t.itemid) as plantypearea,t.planmobankind ";
		sb += " from omcheckgroup t ";
		sb += " where 1=1 ";

		if (Strings.isBlank(itemId)) {
			sb += " and t.itemid = '" + itempid + "'";			
		} else {
			sb += " and t.itempid = '" + itempid + "'";
		}

		sb += " ) h order by itemsortid asc";// mysql

		Map m = DbUtils.DataQuery("sql", sb, null, CheckGroup.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		return ls;
	}
	
	/**
	 * 
	 * saveCheckGroup的中文名称：检查项目信息
	 * 
	 * saveCheckGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : syf
	 * 
	 */
	@Aop( { "trans" })
	public void saveCheckGroup(HttpServletRequest request, CheckGroup dto)
			throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		dto.setOperatedate(new Date());
		dto.setOperateperson(user.getUserid().toString());
		if (null != dto.getItemid()&&!"".equals(dto.getItemid())) {
			CheckGroup se = dao.fetch(CheckGroup.class, dto.getItemid());
			se.setItemid(dto.getItemid());
			se.setItemname(dto.getItemname());
			se.setItempid(dto.getItempid());
			se.setItemremark(dto.getItemremark());
			se.setItemtype(dto.getItemtype());
			se.setItemsortid(dto.getItemsortid());
			se.setItemdesc(dto.getItemdesc());
			se.setOperatedate(dto.getOperatedate());
			se.setOperateperson(dto.getOperateperson());
			se.setPlanmobankind(dto.getPlanmobankind());
			dao.update(se);
		} else {
			String sequence = DbUtils.getSequenceStr();
			dto.setItemid(sequence);
			dao.insert(dto);
		}
	}
	
	/**
	 * 
	 * delCheckGroup的中文名称：删除检查项目信息
	 * 
	 * delCheckGroup的概要说明：
	 * 
	 * @param dto
	 * @return Written by : syf
	 * 
	 */
	@Aop( { "trans" })
	public String delCheckGroup(HttpServletRequest request, final CheckGroup dto) {
		try {
			if (null != dto.getItemid()) {
					int succ = dao.delete(CheckGroup.class, dto.getItemid());
					if(succ>0){
						return "0";
					}
			} else {
				return "1";
			}
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	/**
	 * 
	 * queryContent的中文名称：查询检查内容
	 *
	 * queryContent概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by:syf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryContent(CheckContent dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select contentid,itemid,content,contentcode,contentimpt,contentscore,contentsortid");
		sb.append("  from omcheckcontent a ");
		sb.append(" where 1=1 ");
		sb.append("  and  a.contentid = :contentid ");
		sb.append("  and  a.itemid = :itemid order by contentsortid asc");

		String[] ParaName = new String[] { "itemid","contentid"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR };
		
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				CheckContent.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		
		return r;
	}
	
	/**
	 * 
	 * saveCheckContent的中文名称：保存检查内容
	 * 
	 * saveCheckContent的概要说明：
	 * 
	 * @param dto
	 * @return Written by : syf
	 * 
	 */
	@Aop( { "trans" })
	public void saveContent(HttpServletRequest request, CheckContent dto) throws Exception {
		Sysuser user = SysmanageUtil.getSysuser();
		dto.setContentoperatedate(new Date());
		dto.setContentoperateperson(user.getUserid().toString());
		if(dto.getContentscore()==0){
			dto.setContentscore(dto.getContentscore());
		}else {
			dto.setContentscore(Double.parseDouble(String.format("%.2f", dto.getContentscore() - 0.005)));//截取小数,保留两位
		}
		if (null != dto.getContentid()&&!"".equals(dto.getContentid())) {
			CheckContent se = dao.fetch(CheckContent.class, dto.getContentid());
			se.setItemid(dto.getItemid());
			se.setContentcode(dto.getContentcode());
			se.setContent(dto.getContent());
			se.setContentimpt(dto.getContentimpt());
			se.setContentscore(dto.getContentscore());
			se.setContentsortid(dto.getContentsortid());
			dao.update(se);
		} else {
			String sequence = DbUtils.getSequenceStr();
			dto.setContentid(sequence);
			dao.insert(dto);
		}
	}

	/**
	 * 
	 * delContent的中文名称：删除检查内容
	 *
	 * delContent概要说明：
	 *
	 * @param request
	 * @param dto
	 * @return
	 * @throws Exception
	 * Written by:syf
	 */
	@Aop( { "trans" })
	public String delContent(HttpServletRequest request, CheckContent dto) throws Exception {

		if (null != dto.getContentid()&&!"".equals(dto.getContentid())) {
			int succ = dao.delete(CheckContent.class, dto.getContentid());
			if(succ>0){
				return "0";
			}
		}else{
			return "1";
		}
		return null;
	}
	/**
	 * 
	 * queryxxzttjfxCount中文名称:查询统计信息
	 * queryxxzttjfxCount概要描述:查询统计信息
	 * 
	 * written by  :  lfy
	 * @throws Exception 
	 */
	public Map queryxxzttjfxCount(HttpServletRequest request,
			pubkeyDTO dto) throws Exception {
		// TODO Auto-generated method stub
		StringBuffer sb = new StringBuffer();
		sb.append(" select count(*) value,'案件已结束' name ");
		sb.append(" from zfajdj where ajjsbz='1'");
		sb.append(" union all select count(*) value,'案件正在处理' name ");
		sb.append(" from zfajdj where slbz='1'");
		sb.append(" union all select count(*) value,'案件已登记' name ");
		sb.append(" from zfajdj where ajjsbz='0'");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, pubkeyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	/**
	 * 
	 * queryaqjgCount中文名称:安全监管
	 * queryaqjgCount概要描述:安全监管
	 * written by  :  lfy
	 * @throws Exception 
	 */
	public Map queryaqjgCount(HttpServletRequest request, pubkeyDTO dto) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("  select count(*) value,'计划' name  from bscheckplan  ");
		sb.append(" union all select count(*) value,'检查中' name from bscheckplan a ,");
		sb.append(" bscheckmaster b where a.planid=b.planid  and b.resultstate='1' ");
		sb.append(" union all select count(*) value,'检查完成' name ");
		sb.append(" from bscheckplan a ,bscheckmaster b where a.planid=b.planid ");
		sb.append(" and b.resultstate<> '1'");
		String sql = sb.toString();
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, pubkeyDTO.class);
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
	/**
	 * 
	 * querycheckList的中文名称：查询检查内容
	 *
	 * querycheckList概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by:syf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map querycheckList(HttpServletRequest request , BsCheckPalnAndTypeDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select c.*,d.itemname from (select a.*,b.AAA102,b.AAA103,b.AAA100,b.aaz093 from  ");
		sb.append(" ombasetype a ,aa10 b where a.basetype=b.AAZ093  ) c ");
		sb.append(" left join omcheckgroup d  on c.itemtype=d.itemid  where  1=1 ");
		sb.append(" and d.itemid=:itemid and c.AAA102=:aaa102 and c.AAA100=:aaa100 and c.basetype=:basetype ");
		sb.append(" order by d.itemname desc,c.basetype ");

		String[] ParaName = new String[] { "itemid","aaa102","aaa100","basetype"};
		int[] ParaType = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR ,Types.VARCHAR};
		
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		System.out.println("sqlString  "+sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				BsCheckPalnAndTypeDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		
		return r;
	}
	/**
	 * 保存信息
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveCheckAndType(HttpServletRequest request,final BsCheckPalnAndTypeDTO dto){
		
		try{
			Aa10 aa10 = getAAZ093Byaaa100(dto.getAaa100(),dto.getAaa102());
			if(aa10!=null){
				dto.setAaz903(aa10.getAaz093());
			}
			Ombasetype ombasetype = getCheckAndType(dto);
			if(ombasetype!=null){
				return "false";
			}else {
				saveCheckAndTypeImpl(request,dto);
			}
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
		
	}
	/**
	 * 保存计划和类别关系
	 * @param request
	 * @param dto
	 */
	public void saveCheckAndTypeImpl(HttpServletRequest request,BsCheckPalnAndTypeDTO dto){
	
	//修改
	if(dto.getBasetype()!=null && !"".equals(dto.getBasetype())){
		delCheckAndType(dto);
	}
		Ombasetype ombasetype = new Ombasetype();
		Aa10 aa10 = getAAZ093Byaaa100(dto.getAaa100(),dto.getAaa102());
		if(aa10!=null){
			ombasetype.setBasetype(aa10.getAaz093());
		}
		ombasetype.setItemtype(dto.getItemid());
		dao.insert(ombasetype);
		
	}


	/**
	 *保存检查项目和企业大类的对应关系
	 * @param request
	 * @param dto
	 * @return
	 */
	public String saveItemidComfenlei(HttpServletRequest request,final CheckGroup dto){
		try{
			saveItemidComfenleiImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;

	}
	/**
	 * 保存检查项目和企业大类的对应关系
	 * @param request
	 * @param dto
	 */
	public void saveItemidComfenleiImpl(HttpServletRequest request,CheckGroup dto){

		dao.clear(Ombasetype.class,Cnd.where("itemtype","=",dto.getItemid()));
		String v_plantypearea=dto.getPlantypearea();
		String [] plantypeareaArr=v_plantypearea.split(",");
		String v_aaa102="";
		//BsCheckPalnAndTypeDTO v_BsCheckPalnAndTypeDTO=new BsCheckPalnAndTypeDTO();
		for (int i=0;i<plantypeareaArr.length;i++){
			v_aaa102=plantypeareaArr[i];
			Aa10 aa10 = getAAZ093Byaaa100("COMDALEI",v_aaa102);
			if(aa10!=null){
				//v_BsCheckPalnAndTypeDTO.setAaz903(aa10.getAaz093());
				//v_BsCheckPalnAndTypeDTO.setItemid(dto.getItemid());
				//Ombasetype ombasetype = getCheckAndType(v_BsCheckPalnAndTypeDTO);
				//if (ombasetype==null){
					Ombasetype v_newombasetype=new Ombasetype();
					v_newombasetype.setItemtype(dto.getItemid());
					v_newombasetype.setBasetype(aa10.getAaz093());
					dao.insert(v_newombasetype);
				//}
			}
		}

	}

	public Aa10 getAAZ093Byaaa100(String aaa100,String aaa102){
		Cnd cnd = Cnd.where("aaa100", "=", aaa100).and("aaa102", "=", aaa102);
		Aa10 aa10 = dao.fetch(Aa10.class, cnd);
		return aa10;
	}
	
	public String delCheckAndType(BsCheckPalnAndTypeDTO dto){
		try {
			Cnd cnd = Cnd.where("basetype", "=", dto.getBasetype()).and("itemtype", "=", dto.getItemtype());
			dao.clear(Ombasetype.class, cnd);
		} catch (Exception e) {
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	public Ombasetype getCheckAndType(BsCheckPalnAndTypeDTO dto){
		Cnd cnd = Cnd.where("basetype", "=", dto.getAaz903()).and("itemtype", "=", dto.getItemid());
			Ombasetype	bastype = dao.fetch(Ombasetype.class, cnd);
		return bastype;
	}

	/**
	 * 添加信息
	 * 
	 */
	public String saveImportDoc(HttpServletRequest request,final BscheckplanDTO dto,String filepath){
		try{
			saveImportDocImpl(request,dto,filepath);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 保存信息的实现方法
	 * 使用事务控制
	 * @param request
	 * @param dto
	 * @throws Exception 
	 */
	@Aop({"trans"})
	public void saveImportDocImpl(HttpServletRequest request, BscheckplanDTO dto,String filepath) throws Exception {
		String itemid  = dto.getItemid();
		Sysuser vSysUser = (Sysuser)SysmanageUtil.getSysuser();
		//表格数据
		  List<Map> list = POIWordUtil.poiWordTableInfo(filepath);
		  String itemname ="";
		  for(int i =1;i<list.size();i++){
			  //检查项目保存
			  if(!"".equals(list.get(i).get("0").toString())&&list.get(i).get("0").toString()!=null){
				  itemname =list.get(i).get("0").toString(); 
				  String id= DbUtils.getSequenceStr();
				  CheckGroup group = new CheckGroup();
				  group.setItempid(itemid);
				  group.setItemname(list.get(i).get("0").toString());
				  group.setItemid(id);
				  group.setItemsortid(i+1);
				  group.setItemtype("1");
				  group.setOperatedate(new Date());
				  group.setOperateperson(vSysUser.getUserid().toString());
				     dao.insert(group);
				     CheckContent content = new CheckContent();
				     String contentid= DbUtils.getSequenceStr();
				     content.setContent(list.get(i).get("2").toString());
				     content.setContentcode(list.get(i).get("1").toString());
				     content.setContentid(contentid);
				     content.setContentimpt(1);
				     content.setContentoperatedate(new Date());
				     content.setContentsortid(i+1);
				     content.setItemid(id);
				     content.setContentoperateperson(vSysUser.getUserid().toString());
					  double contentscore = 0.0;
					  if(list.get(i).size()>3){
						  try{
							  contentscore = Double.parseDouble(list.get(i).get("3").toString());
						  }catch (Exception e){
							  e.printStackTrace();
						  }

					  }
				     content.setContentscore(contentscore);
				     dao.insert(content);
				     
			  }else if("".equals(list.get(i).get("0").toString())||list.get(i).get("0").toString()==null){//明细保存
				  
				  //根据itemid和itemname查询检查内容
				  CheckGroup group = dao.fetch(CheckGroup.class, Cnd.where("itempid", "=", itemid).and("itemname", "=", itemname));
				  //明细保存
				  if(group!=null){
					  if(!"".equals(list.get(i).get("1").toString())&&list.get(i).get("1").toString()!=null){
						  CheckContent content = new CheckContent();
						     String contentid= DbUtils.getSequenceStr();
						     content.setContent(list.get(i).get("2").toString());
						     content.setContentcode(list.get(i).get("1").toString());
						     content.setContentid(contentid);
						     content.setContentimpt(1);
						     content.setContentoperatedate(new Date());
						     content.setContentsortid(i+1);
						     content.setItemid(group.getItemid());
						     content.setContentoperateperson(vSysUser.getUserid().toString());
							  double contentscore = 0.0;
							  if(list.get(i).size()>3){
								  try{
									  contentscore = Double.parseDouble(list.get(i).get("3").toString());
								  }catch (Exception e){
									  e.printStackTrace();
								  }

							  }
							  content.setContentscore(contentscore);
						     dao.insert(content);
					  }
					 
				  }
				  
			  }
			  
		  }
		  
//			POIWordUtil.constructItem(list,itemid);
			//检查内容
//			POIWordUtil.constructContent(list,itemid);
			
			
			
			
	}

}
