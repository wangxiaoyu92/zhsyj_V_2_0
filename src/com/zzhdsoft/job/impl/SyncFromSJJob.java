package com.zzhdsoft.job.impl;

import org.apache.log4j.Logger;
import org.nutz.dao.Dao;
import org.nutz.mvc.Mvcs;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.alibaba.fastjson.JSONObject;
import com.askj.baseinfo.dto.PcompanyDTO;
import com.askj.baseinfo.entity.Pcompany;
import com.askj.baseinfo.service.PcompanyService;
import com.lbs.util.StringUtils;
import com.zzhdsoft.utils.HttpUtil;
import com.zzhdsoft.utils.db.DbUtils;

/**
 * 
 * SyncFromMCLZJob的中文名称：同步数据定时任务
 * 
 * SyncFromMCLZJob的描述：
 * 
 * Written by : sunyifeng
 */
public class SyncFromSJJob implements Job {
	private static final Logger logger = Logger.getLogger(SyncFromSJJob.class);
	private static  Dao dao;
	
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		logger.info("同步省局企业数据任务开始...");
		//getComInfoDataFromSJ();
		logger.info("同步省局企业数据任务结束...");
	}

	/**
	 *
	 *  getComDataFromSJ的中文名称：获取省局企业列表
	 *
	 *  getComDataFromSJ的概要说明：
	 *
	 *  @return
	 *  Written  by  : sunyifeng
	 * @throws Exception 
	 *
	 */
	private void getComInfoDataFromSJ() throws Exception{
		boolean v_loop=true;
		while (v_loop){
			//获取本地企业最到的同步时间
			String v_sql="select max(sn) as sn from pcompany a ";
			PcompanyDTO v_pcomDto=(PcompanyDTO)DbUtils.getDataList(v_sql, Pcompany.class).get(0);
			String v_maxcomsn=v_pcomDto.getSn();
			if (StringUtils.isEmpty(v_maxcomsn)){
				v_maxcomsn="1991-01-01";
			}
			
			com.alibaba.fastjson.JSONArray jsonArray = null;
			String requestUrl = "http://as.hda.gov.cn/com_onSearchCompany.action?time=2016-04-11&gUser=askj&gPwd=5FC17478F4171944318FE9256BEDB47B&pageSize=500&pageCurrent=1";
			String charset = "UTF-8";
			String content = HttpUtil.httpGet(requestUrl, charset);
			if(StringUtils.isNotEmpty(content)) {
				com.alibaba.fastjson.JSONObject jsonObject = com.alibaba.fastjson.JSONObject.parseObject(content);
				if (jsonObject!=null&&jsonObject.containsKey("rows")){
					jsonArray = com.alibaba.fastjson.JSONArray.parseArray(jsonObject.get("rows").toString());
				}
			}
			if(jsonArray!=null){
				PcompanyService pcompanyService = Mvcs.ctx().getDefaultIoc().get(
						PcompanyService.class);
				for(Object cominfo:jsonArray){
					JSONObject com = (JSONObject) cominfo;


					PcompanyDTO pcompany = new PcompanyDTO();
					pcompany.setComid(com.getString(""));    //企业ID
					pcompany.setComdm(com.getString(""));    //企业代码：企业类型字母+6位行政区域代码+9位序列号
					pcompany.setCommc(com.getString(""));    //企业名称
					pcompany.setComdalei(com.getString(""));    //企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营
					pcompany.setComxkzbh(com.getString(""));    //许可证编号
					pcompany.setComfrhyz(com.getString(""));    //企业法人/业主
					pcompany.setComfrsfzh(com.getString(""));    //企业法人/业主身份证号
					pcompany.setComfrxb(com.getString(""));    //企业法人/业主性别
					pcompany.setComfrzw(com.getString(""));    //企业法人/业主职务
					pcompany.setComfzr(com.getString(""));    //企业负责人
					pcompany.setComgddh(com.getString(""));    //固定电话
					pcompany.setComyddh(com.getString(""));    //移动电话
					pcompany.setComdz(com.getString(""));    //企业地址
					pcompany.setComqq(com.getString(""));    //企业QQ
					pcompany.setComemail(com.getString(""));    //企业电子邮件
					pcompany.setComyzbm(com.getString(""));    //企业邮政编码
					pcompany.setComwz(com.getString(""));    //网址
					pcompany.setComcz(com.getString(""));    //传真
					pcompany.setComctmj(com.getBigDecimal(""));    //餐厅面积
					pcompany.setComcfmj(com.getBigDecimal(""));    //厨房面积
					pcompany.setComzmj(com.getBigDecimal(""));    //总面积
					pcompany.setComjcrs(com.getInteger(""));    //就餐人数
					pcompany.setComcyrs(com.getInteger(""));    //从业人数
					pcompany.setComcjkzrs(com.getInteger(""));    //持健康证人数
					pcompany.setComzjzglrs(com.getInteger(""));    //专（兼）职管理人员数
					pcompany.setComxiaolei(com.getString(""));    //企业小类，代码表comxiaolei如特大型餐馆
					pcompany.setComdmlx(com.getString(""));    //店面类型，代码表comdmlx如蛋糕店、火锅店
					pcompany.setComtscx(com.getString(""));    //特色菜系，代表表comtscx如豫菜
					pcompany.setComtsc(com.getString(""));    //特色菜
					pcompany.setComzzjgdm(com.getString(""));    //组织机构代码
					pcompany.setComclrq(com.getTimestamp(""));    //企业成立日期
					pcompany.setComzczj(com.getLong(""));    //注册资金（万元）
					pcompany.setComzclb(com.getString(""));    //1企业自行注册2 操作员添加注册
					pcompany.setComdzcczymc(com.getString(""));    //代企业注册的操作人
					pcompany.setComdzcsj(com.getTimestamp(""));    //代注册时间
					pcompany.setComshbz(com.getString(""));    //审核标志 1通过 2未通过 0 等待审核
					pcompany.setComshr(com.getString(""));    //审核人
					pcompany.setComshsj(com.getTimestamp(""));    //审核时间
					pcompany.setComshwtgyy(com.getString(""));    //审核未通过原因
					pcompany.setComjianjie(com.getString(""));    //企业简介
					pcompany.setComqyxz(com.getString(""));    //企业性质
					pcompany.setAaa027(com.getString(""));    //地区编码
					pcompany.setComjdzb(com.getString(""));    //经度坐标
					pcompany.setComwdzb(com.getString(""));    //纬度坐标
					pcompany.setComfwnfww(com.getString(""));    //0范围内1范围外aaa100=COMFWNFWW
					pcompany.setComlrcomid(com.getString(""));    //如果是范围外企业对应的添加该企业的企业ID
					pcompany.setComghsorxhs(com.getString(""));    //0供货商1销货商是供货商还是销货商AAA100=COMGHSORXHS
					pcompany.setComjyjcbz(com.getString(""));    //检验检测单位标志，见aaa100=COMJYJCBZ
					pcompany.setCombxbz(com.getString(""));    //保险标志
					pcompany.setComspjkbz(com.getString(""));    //视频监控标志
					pcompany.setComhhbbz(com.getString(""));    //红黑榜标志
					pcompany.setComsyqylx(com.getString(""));    //溯源企业类型0非溯源企业1生成2流通3餐饮aaa100=COMSYQYLX
					pcompany.setComywtz(com.getString(""));    //有无台账
					pcompany.setCombeizhu(com.getString(""));    //备注
					pcompany.setOrgid(com.getString(""));    //机构id
					pcompany.setComcssbm(com.getString(""));    //厂商识别码
					pcompany.setComtsdh(com.getString(""));    //企业投诉电话
					pcompany.setComscdz(com.getString(""));    //企业生产地址
					pcompany.setComzmfx(com.getString(""));    //企业正门方向
					pcompany.setComqyndgdzcxz(com.getBigDecimal(""));    //前一年度固定资产（现值
					pcompany.setComqyndldzj(com.getBigDecimal(""));    //前一年度流动资金
					pcompany.setComqyndzcz(com.getBigDecimal(""));    //前一年度总产值
					pcompany.setComqyndnxse(com.getBigDecimal(""));    //前一年度年销售额
					pcompany.setComqyndyjse(com.getBigDecimal(""));    //前一年度缴税金额
					pcompany.setComqyndnlr(com.getBigDecimal(""));    //前一年度年利润
					pcompany.setComsftghaccp(com.getString(""));    //是否通过HACCP认证0否1是
					pcompany.setComhaccpbh(com.getString(""));    //HACCP认证证书编号
					pcompany.setComhaccpfzdw(com.getString(""));    //HACCP发证单位名
					pcompany.setComiso9000bh(com.getString(""));    //ISO9000证书编号
					pcompany.setComiso9000fzdw(com.getString(""));    //ISO9000发证单位名
					pcompany.setComzdmj(com.getBigDecimal(""));    //占地面积
					pcompany.setComjzmj(com.getBigDecimal(""));    //建筑面积
					pcompany.setComyysj(com.getString(""));    //营业时间
					pcompany.setComfxdj(com.getString(""));    //企业风险等级aaa100=comfxdj
					pcompany.setCommcjc(com.getString(""));    //企业名称简称
					pcompany.setComdaleiname(com.getString(""));    //企业大类汉字描述
					pcompany.setComxiaoleiname(com.getString(""));    //企业小类汉字描述
					pcompany.setOrderno(com.getString(""));    //显示序号
					pcompany.setSn(com.getString(""));    //数据版本号
					pcompany.setOutercomid(com.getString(""));    //外部系统主键
					try {
						pcompanyService.savePcompany(null,pcompany);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}			
		}//loop
	}
}
