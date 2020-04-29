package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSXZCFSXTZGZSPB41的中文含义是: 行政处罚事先（听证）告知审批表41; InnoDB free: 2669568 kB
 * @Creation     2016/09/09 11:34:03
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXZCFSXTZGZSPB41")
public class Zfwsxzcfsxtzgzspb41 {
	/**
	 * @Description sxtzgzspbid的中文含义是： id
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_sxtzgzspbid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_sxtzgzspbid.nextval from dual"))
	private String sxtzgzspbid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description sxtzgzay的中文含义是： 案由
	 */
	@Column
	private String sxtzgzay;

	/**
	 * @Description sxtzgzdsr的中文含义是： 当事人
	 */
	@Column
	private String sxtzgzdsr;

	/**
	 * @Description zywfss的中文含义是： 主要违法事实
	 */
	@Column
	private String zywfss;

	/**
	 * @Description cbrycfyj的中文含义是： 承办人员处罚意见
	 */
	@Column
	private String cbrycfyj;

	/**
	 * @Description cbrqz1的中文含义是： 承办人签字1
	 */
	@Column
	private String cbrqz1;

	/**
	 * @Description cbrqz2的中文含义是： 承办人签字2
	 */
	@Column
	private String cbrqz2;

	/**
	 * @Description cbrqzrq的中文含义是： 承办人签字日期
	 */
	@Column
	private String cbrqzrq;

	/**
	 * @Description cbbmscyj的中文含义是： 承办部门审查意见
	 */
	@Column
	private String cbbmscyj;

	/**
	 * @Description cbbmfzrqz的中文含义是： 承办部门负责人签字
	 */
	@Column
	private String cbbmfzrqz;

	/**
	 * @Description cbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	@Column
	private String cbbmfzrqzrq;

	/**
	 * @Description fzjgshyj的中文含义是： 法制机构审核意见
	 */
	@Column
	private String fzjgshyj;

	/**
	 * @Description fzjgfzrqz的中文含义是： 法制机构负责人签字
	 */
	@Column
	private String fzjgfzrqz;

	/**
	 * @Description fzjgfzrqzrq的中文含义是： 法制机构负责人签字日期
	 */
	@Column
	private String fzjgfzrqzrq;

	/**
	 * @Description spyj的中文含义是： 审批意见
	 */
	@Column
	private String spyj;

	/**
	 * @Description spbmfzrqz的中文含义是： 审批部门负责人签字
	 */
	@Column
	private String spbmfzrqz;

	/**
	 * @Description spbmfzrqzrq的中文含义是： 审批部门负责人签字日期
	 */
	@Column
	private String spbmfzrqzrq;

	
		/**
	 * @Description sxtzgzspbid的中文含义是： id
	 */
	public void setSxtzgzspbid(String sxtzgzspbid){ 
		this.sxtzgzspbid = sxtzgzspbid;
	}
	/**
	 * @Description sxtzgzspbid的中文含义是： id
	 */
	public String getSxtzgzspbid(){
		return sxtzgzspbid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description sxtzgzay的中文含义是： 案由
	 */
	public void setSxtzgzay(String sxtzgzay){ 
		this.sxtzgzay = sxtzgzay;
	}
	/**
	 * @Description sxtzgzay的中文含义是： 案由
	 */
	public String getSxtzgzay(){
		return sxtzgzay;
	}
	/**
	 * @Description sxtzgzdsr的中文含义是： 当事人
	 */
	public void setSxtzgzdsr(String sxtzgzdsr){ 
		this.sxtzgzdsr = sxtzgzdsr;
	}
	/**
	 * @Description sxtzgzdsr的中文含义是： 当事人
	 */
	public String getSxtzgzdsr(){
		return sxtzgzdsr;
	}
	/**
	 * @Description zywfss的中文含义是： 主要违法事实
	 */
	public void setZywfss(String zywfss){ 
		this.zywfss = zywfss;
	}
	/**
	 * @Description zywfss的中文含义是： 主要违法事实
	 */
	public String getZywfss(){
		return zywfss;
	}
	/**
	 * @Description cbrycfyj的中文含义是： 承办人员处罚意见
	 */
	public void setCbrycfyj(String cbrycfyj){ 
		this.cbrycfyj = cbrycfyj;
	}
	/**
	 * @Description cbrycfyj的中文含义是： 承办人员处罚意见
	 */
	public String getCbrycfyj(){
		return cbrycfyj;
	}
	/**
	 * @Description cbrqz1的中文含义是： 承办人签字1
	 */
	public void setCbrqz1(String cbrqz1){ 
		this.cbrqz1 = cbrqz1;
	}
	/**
	 * @Description cbrqz1的中文含义是： 承办人签字1
	 */
	public String getCbrqz1(){
		return cbrqz1;
	}
	/**
	 * @Description cbrqz2的中文含义是： 承办人签字2
	 */
	public void setCbrqz2(String cbrqz2){ 
		this.cbrqz2 = cbrqz2;
	}
	/**
	 * @Description cbrqz2的中文含义是： 承办人签字2
	 */
	public String getCbrqz2(){
		return cbrqz2;
	}
	/**
	 * @Description cbrqzrq的中文含义是： 承办人签字日期
	 */
	public void setCbrqzrq(String cbrqzrq){ 
		this.cbrqzrq = cbrqzrq;
	}
	/**
	 * @Description cbrqzrq的中文含义是： 承办人签字日期
	 */
	public String getCbrqzrq(){
		return cbrqzrq;
	}
	/**
	 * @Description cbbmscyj的中文含义是： 承办部门审查意见
	 */
	public void setCbbmscyj(String cbbmscyj){ 
		this.cbbmscyj = cbbmscyj;
	}
	/**
	 * @Description cbbmscyj的中文含义是： 承办部门审查意见
	 */
	public String getCbbmscyj(){
		return cbbmscyj;
	}
	/**
	 * @Description cbbmfzrqz的中文含义是： 承办部门负责人签字
	 */
	public void setCbbmfzrqz(String cbbmfzrqz){ 
		this.cbbmfzrqz = cbbmfzrqz;
	}
	/**
	 * @Description cbbmfzrqz的中文含义是： 承办部门负责人签字
	 */
	public String getCbbmfzrqz(){
		return cbbmfzrqz;
	}
	/**
	 * @Description cbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	public void setCbbmfzrqzrq(String cbbmfzrqzrq){ 
		this.cbbmfzrqzrq = cbbmfzrqzrq;
	}
	/**
	 * @Description cbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	public String getCbbmfzrqzrq(){
		return cbbmfzrqzrq;
	}
	/**
	 * @Description fzjgshyj的中文含义是： 法制机构审核意见
	 */
	public void setFzjgshyj(String fzjgshyj){ 
		this.fzjgshyj = fzjgshyj;
	}
	/**
	 * @Description fzjgshyj的中文含义是： 法制机构审核意见
	 */
	public String getFzjgshyj(){
		return fzjgshyj;
	}
	/**
	 * @Description fzjgfzrqz的中文含义是： 法制机构负责人签字
	 */
	public void setFzjgfzrqz(String fzjgfzrqz){ 
		this.fzjgfzrqz = fzjgfzrqz;
	}
	/**
	 * @Description fzjgfzrqz的中文含义是： 法制机构负责人签字
	 */
	public String getFzjgfzrqz(){
		return fzjgfzrqz;
	}
	/**
	 * @Description fzjgfzrqzrq的中文含义是： 法制机构负责人签字日期
	 */
	public void setFzjgfzrqzrq(String fzjgfzrqzrq){ 
		this.fzjgfzrqzrq = fzjgfzrqzrq;
	}
	/**
	 * @Description fzjgfzrqzrq的中文含义是： 法制机构负责人签字日期
	 */
	public String getFzjgfzrqzrq(){
		return fzjgfzrqzrq;
	}
	/**
	 * @Description spyj的中文含义是： 审批意见
	 */
	public void setSpyj(String spyj){ 
		this.spyj = spyj;
	}
	/**
	 * @Description spyj的中文含义是： 审批意见
	 */
	public String getSpyj(){
		return spyj;
	}
	/**
	 * @Description spbmfzrqz的中文含义是： 审批部门负责人签字
	 */
	public void setSpbmfzrqz(String spbmfzrqz){ 
		this.spbmfzrqz = spbmfzrqz;
	}
	/**
	 * @Description spbmfzrqz的中文含义是： 审批部门负责人签字
	 */
	public String getSpbmfzrqz(){
		return spbmfzrqz;
	}
	/**
	 * @Description spbmfzrqzrq的中文含义是： 审批部门负责人签字日期
	 */
	public void setSpbmfzrqzrq(String spbmfzrqzrq){ 
		this.spbmfzrqzrq = spbmfzrqzrq;
	}
	/**
	 * @Description spbmfzrqzrq的中文含义是： 审批部门负责人签字日期
	 */
	public String getSpbmfzrqzrq(){
		return spbmfzrqzrq;
	}

	
}