package com.askj.supervision.service;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.askj.supervision.dto.BsCheckMasterDTO;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.lang.Lang;

import com.lbs.leaf.util.BeanHelper;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.askj.supervision.dto.BsTbodyInfoDTo;
import com.askj.supervision.entity.Bstbodyinfo;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

public class CheckTbodyService {
	@Inject
	private Dao dao;
	
	
	/**
	 * 
	 * queryTbodyInfoList的中文名称：查询检查内容
	 *
	 * queryTbodyInfoList概要说明：
	 *
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * Written by:syf
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryTbodyInfoList(HttpServletRequest request ,BsTbodyInfoDTo dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from bstbodyinfo a  where a.tbodyid =:tbodyid");
		String[] ParaName = new String[] { "tbodyid"};
		int[] ParaType = new int[] {Types.VARCHAR};
		
		String sqlString = QueryFactory.getSQL(sb.toString(), ParaName,
				ParaType, dto, pd);
		System.out.println("sqlString  "+sqlString);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sqlString, null,
				BsTbodyInfoDTo.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		
		return r;
	}
	
	public String saveTbodyInfo (HttpServletRequest request,BsTbodyInfoDTo dto ){
		try{
			saveTbodyInfoImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}

	public void saveTbodyInfoImpl(HttpServletRequest request,BsTbodyInfoDTo dto){
		//修改
		if(dto.getTbodyid()!=null && !"".equals(dto.getTbodyid())){
			Bstbodyinfo tbodyinfo = new Bstbodyinfo();
			BeanHelper.copyProperties(dto, tbodyinfo);  //拷贝对应的从前台传来的数据
			dao.update(tbodyinfo);
		}else{
			Bstbodyinfo tbodyinfo = new Bstbodyinfo();
			String tbodyid = DbUtils.getSequenceStr();
			BeanHelper.copyProperties(dto, tbodyinfo);  //拷贝对应的从前台传来的数据
			tbodyinfo.setTbodyid(tbodyid);
			dao.insert(tbodyinfo);
				
		}
		
	}

	/**
	 * 得到表头信息列表，
	 * @param
	 * @return
	 * @throws Exception
	 */
	public Map getTbodyInfos(HttpServletRequest request,BsCheckMasterDTO dto) throws Exception {
		//使用字符串缓冲器类拼接查询语句
		StringBuffer sb = new StringBuffer();
		sb.append(" select a.tbodyinfo,a.tfootinfo,a.tbody,a.tbodytype,a.tbodycode,a.tbodyid from bstbodyinfo a ");
		sb.append("  where 1=1 ");
		sb.append("   and a.tbodytype = :tbodytype  and a.tbodycode= :tbodycode and a.aaa027 like :aaa027 ");
		String sql = sb.toString();
		//转化sql语句
		String[] paramName = new String[]{"tbodytype","tbodycode","aaa027"};
		int[] paramType = new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		sql = QueryFactory.getSQL(sql, paramName, paramType, dto);
		System.out.println(sql);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, BsTbodyInfoDTo.class);
		List<BsTbodyInfoDTo> list = (List<BsTbodyInfoDTo>) m.get(GlobalNames.SI_RESULTSET);
		Map map = new HashMap();
		map.put("total",m.get(GlobalNames.SI_TOTALROWNUM));
		map.put("rows",list);
		return map;
	}

}
