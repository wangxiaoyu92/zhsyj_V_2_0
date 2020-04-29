package com.zzhdsoft.siweb.service;

import java.sql.Timestamp;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;
import org.apache.log4j.Logger;
import org.nutz.json.Json;
import org.nutz.mvc.Mvcs;
import com.zzhdsoft.GlobalNames;
import com.zzhdsoft.siweb.dto.PagesDTO;
import com.zzhdsoft.siweb.dto.ParamDTO;
import com.zzhdsoft.siweb.dto.ResultDTO;
import com.askj.baseinfo.dto.HviewjgztDTO;
import com.askj.tmsyj.tmsyj.dto.HjhbDTO;
import com.askj.tmsyj.tmsyj.dto.HjyjczbmxbDTO;
import com.askj.tmsyj.tmsyj.service.TmsyjApiService;
import com.zzhdsoft.utils.DateUtil;
import com.zzhdsoft.utils.MD5Util;
import com.zzhdsoft.utils.StringHelper;
import com.zzhdsoft.utils.SysmanageUtil;
import com.zzhdsoft.utils.db.DbUtils;
import com.zzhdsoft.utils.db.QueryFactory;

/**
 * 
 * PubServiceImpl的中文名称：webService数据查询接口实现类
 * 
 * PubServiceImpl的描述：
 * 
 * Written by : zjf
 */
public class PubServiceImpl implements IPubService {
	private static final Logger log = Logger.getLogger(PubServiceImpl.class);

	/**
	 * 
	 * execSQL的中文名称：执行查询、存储过程
	 * 
	 * execSQL的概要说明：
	 * 
	 * @param t
	 * @param sql
	 * @param param
	 * @return Written by : zjf
	 * 
	 */
	public String execSQL(String t, String sql, String param) {
		DataServiceImpl ids = Mvcs.ctx().getDefaultIoc()
				.get(DataServiceImpl.class);

		log.info("TYPE:" + t);
		log.info("SQL:" + sql);
		log.info("PARAM:" + param);

		ParamDTO p = new ParamDTO();
		p.setT(t);
		p.setSql(sql);
		p.setParam(param);
		ResultDTO r = (ResultDTO) ids.query(p);

		return Json.toJson(r);
	}

	/**
	 * 
	 * wlService的中文名称：webService接口
	 * 
	 * wlService的概要说明：
	 * 
	 * @param signature
	 * @param timestamp
	 * @param ywdm
	 * @param inParams
	 * @param flag
	 *            分页标志
	 * @return
	 * @throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String wlService(String signature, String timestamp, String ywdm,
			String inParams) throws Exception {
		PagesDTO pd = new PagesDTO();
		pd.setPage(1);
		pd.setPageSize(10);

		// MD5签名验证
		String appid = "abc";
		String appkey = "123456";
		String signStr = appid + "|" + appkey + "|" + timestamp;
		String MD5Str = MD5Util.MD5Encode(signStr).toUpperCase();
//		if (!signature.equals(MD5Str)) {
//			return Json.toJson(SysmanageUtil
//					.execAjaxResult("签名验证失败，不是合法的用户请求！"));
//		} else {
			if ("".equals(ywdm) || ywdm == null) {
				return Json.toJson(SysmanageUtil.execAjaxResult("业务代码不能为空！"));
			} else {
				if ("jczt001".equals(ywdm)) {
					HviewjgztDTO dto = Json.fromJson(HviewjgztDTO.class,
							inParams);
					return Json.toJson(getJianGuanZhuTi(dto, pd));
				} else if ("jyjc001".equals(ywdm)) {
					HjyjczbmxbDTO dto = Json.fromJson(HjyjczbmxbDTO.class,
							inParams);
					return Json.toJson(uploadJyjc(dto));
				} else if ("uploadJhb001".equals(ywdm)) {
					HjhbDTO dto = Json.fromJson(HjhbDTO.class,inParams);
					return Json.toJson(uploadJhb(dto));
				} else {
					return Json.toJson(SysmanageUtil.execAjaxResult("业务代码错误！"));
				}
			}
//		}
	}

	/**
	 * 
	 * getSjfz的中文名称：获取司机签到队列的分组情况
	 * 
	 * getSjfz的概要说明：当天未派单司机
	 * 
	 * param dto
	 * param pd
	 * return
	 * throws Exception
	 *             Written by : zjf
	 * 
	 */
	public String getSjfz() throws Exception {
		Timestamp startTime = SysmanageUtil.currentTime();
		String qdsj = DateUtil.convertDateToYearMonthDay(startTime);

		StringBuffer sb = new StringBuffer();
		sb.append(" select count(sjid) sjqdrs,");
		sb.append(" thfs,(select getAa10_aaa103('THFS',t.thfs)) as thfsmc,");
		sb.append(" thcq,(select getAa10_aaa103('THCQ',t.thcq)) as thcqmc,");
		sb.append(" fzzt,(select getAa10_aaa103('FZZT',t.fzzt)) as fzztmc ");
		sb.append("  from Sjqd t ");
		sb.append(" where 1=1 ");
		sb.append("  and  DATE_FORMAT(t.qdsj,'%Y%m%d') = ").append(qdsj);// 当天
		sb.append("  and  t.sjzt = '2' ");// 未派单
		sb.append("  and  t.aae016 = '1' ");// 复核通过
		sb.append("  group by t.thfs,t.thcq,t.fzzt ");

		return execSQL(GlobalNames.sql, sb.toString(), null);
	}

	/**
	 * 
	 * getJianGuanZhuTi的中文名称：获取被检单位、摊位信息
	 * 
	 * getJianGuanZhuTi的概要说明：
	 * 
	 * @param dto
	 * @param pd
	 * @return
	 * @throws Exception
	 * @author ：zjf
	 */
	public Map getJianGuanZhuTi(HviewjgztDTO dto, PagesDTO pd) throws Exception {
		Map map = new HashMap();
		String jgztmc = StringHelper.showNull2Empty(dto.getJgztmc());
		String jgztmcjc = StringHelper.showNull2Empty(dto.getJgztmcjc());
		if ("".equals(jgztmc) && "".equals(jgztmcjc)) {
			return SysmanageUtil.execAjaxResult("入参不能为空！");
		}
		StringBuffer sb = new StringBuffer();
		sb.append(" select hviewjgztid jgztid,jgztmc,jgztmcjc,jgztlx,jgzttxdz ");
		sb.append(" from Hviewjgzt a ");
		sb.append(" where 1=1 ");
		sb.append(" and a.jgztfwnfww='1' ");
		sb.append(" and a.jgztmc like :jgztmc ");
		sb.append(" and a.jgztmcjc like :jgztmcjc ");

		String sql = sb.toString();
		String[] ParaName = new String[] { "jgztmc", "jgztmcjc" };
		int[] ParaType = new int[] { Types.VARCHAR, Types.VARCHAR };
		sql = QueryFactory.getSQL(sql, ParaName, ParaType, dto, pd);
		map = DbUtils.DataQuery(GlobalNames.sql, sql, null, null, pd.getPage(),
				pd.getRows());
		return map;
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
	public Map uploadJyjc(HjyjczbmxbDTO dto) {
		TmsyjApiService tmsyjApiService = Mvcs.ctx().getDefaultIoc()
				.get(TmsyjApiService.class);
		String msg = tmsyjApiService.uploadJyjc(dto);
		return SysmanageUtil.execAjaxResult(msg);
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
	public Map uploadJhb(HjhbDTO dto) {
		TmsyjApiService tmsyjApiService = Mvcs.ctx().getDefaultIoc()
				.get(TmsyjApiService.class);
		String msg = tmsyjApiService.uploadJhb(dto);
		return SysmanageUtil.execAjaxResult(msg);
	}

}
