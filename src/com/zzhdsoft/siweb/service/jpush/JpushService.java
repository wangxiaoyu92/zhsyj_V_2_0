package com.zzhdsoft.siweb.service.jpush; 
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean; 
import org.nutz.lang.Lang;

import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.sysmanager.SysuserDTO;
import com.zzhdsoft.siweb.dto.jpush.JpushInfoDTO;
import com.zzhdsoft.siweb.dto.jpush.JpushlogDTO;
import com.zzhdsoft.siweb.entity.sysmanager.Sysuser;
import com.zzhdsoft.siweb.entity.jpush.Jpushlog;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;
import com.zzhdsoft.utils.push.JPushAllUtil;

@IocBean
public class JpushService {

	protected final Logger logger = Logger.getLogger(JpushService.class);

	@Inject
	private Dao dao;
	
	/**
	 * 
	 * sendMessage的中文名称：极光推送消息
	 * 
	 * sendMessage的概要说明：
	 * @param request
	 * @param dto
	 * @return
	 *        Written by : zy
	 */
	public String sendMessage(HttpServletRequest request, JpushInfoDTO dto){
		try{
			sendMessageImpl(request,dto);
		}catch(Exception e){
			return Lang.wrapThrow(e).getMessage();
		}
		return null;
	}
	
	/**
	 * 
	 * sendMessageImpl的中文名称：极光推送消息实现
	 * 
	 * sendMessageImpl的概要说明：
	 * @param request
	 * @param dto
	 * @throws Exception
	 *        Written by : zy
	 */
	@Aop({"trans"})
	public void sendMessageImpl(HttpServletRequest request, JpushInfoDTO dto) throws Exception {

		Sysuser v_user = SysmanageUtil.getSysuser(); // 当前用户
		if(v_user==null){
			v_user = SysmanageUtil.getSysuser(dto.getUserid());
		}
		String currentTime = SysmanageUtil.getDbtimeYmdHns(); // 当前时间
		List<String> useridList = new ArrayList<String>(); // 推送人员集合
		JSONArray v_array = null;
		Object[]  v_objArray = null;
		// 推送人员
		v_array = JSONArray.fromObject(dto.getAccertuserid_rows());
		v_objArray = v_array.toArray();
		for (int i = 0; i <= v_objArray.length - 1; i++) {
			JSONObject v_obj = JSONObject.fromObject(v_objArray[i]);
			SysuserDTO v_dto = (SysuserDTO) JSONObject.toBean(v_obj, SysuserDTO.class);
			// 推送日志
			Jpushlog v_log = new Jpushlog();
			v_log.setAccertuserid(v_dto.getUserid()); // 接收人id
			v_log.setMessage(dto.getMessage()); // 推送消息内容
			v_log.setSendtime(currentTime); // 推送时间
			v_log.setSenduserid(v_user.getUserid()); // 推送人id
			v_log.setTitle(dto.getTitle()); // 标题
			v_log.setType(dto.getType()); // 消息类型
			v_log.setLogid(DbUtils.getSequenceStr()); // 日志id
			dao.insert(v_log);
			useridList.add(v_dto.getUserid());
		}	
		// 发送任务给指定人员（手机端极光推送）
		JPushAllUtil.androidSendPushByalias(useridList, dto.getType(),  dto.getMessage(), dto.getTitle());	
	}
	
	/**
	 * 
	 * queryJpushLog的中文名称：查询极光推送日志
	 * 
	 * queryJpushLog的概要说明：
	 * @param request
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 *        Written by : zy
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map queryJpushLog(HttpServletRequest request, JpushlogDTO dto, PagesDTO pd) throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append(" select log.*, a.username accertusername, b.username sendusername ");
		sb.append(" from jpushlog log, sysuser a, sysuser b ");
		sb.append(" where 1 = 1 ");
		sb.append("  AND log.accertuserid = a.userid  ");
		sb.append("  AND log.senduserid = b.userid  ");
		sb.append("  and log.type = :type ");
		String sql = sb.toString();
		String[] ParaName = new String[] { "type" };
		int[] ParaType = new int[] { Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		Map m = DbUtils.DataQuery(GlobalNames.sql, sql, null, JpushlogDTO.class, pd.getPage(), pd.getRows());
		List ls = (List) m.get(GlobalNames.SI_RESULTSET);
		Map r = new HashMap();
		r.put("rows", ls);
		r.put("total", m.get(GlobalNames.SI_TOTALROWNUM));
		return r;
	}
	
}
