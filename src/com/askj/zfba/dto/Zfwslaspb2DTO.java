package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSLASPB2的中文含义是: 执法文书立案审批表; InnoDB free: 75776 kBDTO
 * @Creation     2016/03/12 15:06:00
 * @Written      Create Tool By zjf 
 **/
public class Zfwslaspb2DTO {

	//扩展开始
	/**
	 * 一个方法被多个地方调用，这个表示是那个地方用，以区别处理
	 */
	private String operatetype;
	/**
	 * comid
	 */
	private String comid;

	//扩展结束

	private String laspid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	
	private String ajdjid;

	/**
	 * @Description laspflfg的中文含义是： 违反的法律法规
	 */
	
	private String laspflfg;

	/**
	 * @Description laspjbr的中文含义是： 经办人
	 */
	
	private String laspjbr;

	/**
	 * @Description laspjbrqzrq的中文含义是： 经办人签字日期
	 */
	
	private String laspjbrqzrq;

	/**
	 * @Description laspcbbmfzr的中文含义是： 承办部门负责人
	 */
	
	private String laspcbbmfzr;

	/**
	 * @Description laspcbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	
	private String laspcbbmfzrqzrq;

	/**
	 * @Description laspspyj的中文含义是： 审批意见
	 */
	
	private String laspspyj;

	/**
	 * @Description laspfgfzrqzrq的中文含义是： 分管负责人签字日期
	 */
	
	private String laspfgfzrqzrq;

	/**
	 * @Description laspfgfzr的中文含义是： 分管负责人
	 */
	
	private String laspfgfzr;

	/**
	 * @Description laspaqzy的中文含义是： 案情摘要
	 */
	
	private String laspaqzy;

	/**
	 * @Description laspjbr2的中文含义是： 经办人2
	 */
	
	private String laspjbr2;

	/**
	 * @Description laspzbr的中文含义是： 主办人
	 */
	
	private String laspzbr;

	/**
	 * @Description laspcbr的中文含义是： 协办人
	 */
	
	private String laspcbr;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	
	private String ajdjay;

	/**
	 * @Description laspdsr的中文含义是： 当事人
	 */
	
	private String laspdsr;

	/**
	 * @Description laspfddbr的中文含义是： 法定代表人(负责人)
	 */
	
	private String laspfddbr;

	/**
	 * @Description laspdz的中文含义是： 地址
	 */
	
	private String laspdz;

	/**
	 * @Description lasplxfs的中文含义是： 联系方式
	 */
	
	private String lasplxfs;

	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	
	private String ajdjajly;
	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	
	private String ajdjajlystr;

	/**
	 * @Description laspjyzb的中文含义是： 建议主办
	 */
	
	private String laspjyzb;

	/**
	 * @Description laspjyxb的中文含义是： 建议协办
	 */
	
	private String laspjyxb;

	/**
	 * @Description laspsplarq的中文含义是： 审批立案日期(汤阴)
	 */
	
	private String laspsplarq;

	/**
	 * @Description laspspzb的中文含义是： 审批主办(汤阴)
	 */
	
	private String laspspzb;

	/**
	 * @Description laspspxb的中文含义是： 审批协办(汤阴)
	 */
	
	private String laspspxb;
	/**
	 * @Description laspspxb的中文含义是： 审批协办(汤阴)
	 */
	
	private String zfwsdmz;

	/**
	 * @Description laspspxb的中文含义是： 文书编号
	 */
	private String laspwsbh;

	
	public String getLaspwsbh() {
	return laspwsbh;
	}
	public void setLaspwsbh(String laspwsbh) {
		this.laspwsbh = laspwsbh;
	}
	
		public String getZfwsdmz() {
		return zfwsdmz;
	}
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
		public String getAjdjajlystr() {
		return ajdjajlystr;
	}
	public void setAjdjajlystr(String ajdjajlystr) {
		this.ajdjajlystr = ajdjajlystr;
	}
		/**
	 * @Description laspid的中文含义是： 
	 */
	public void setLaspid(String laspid){ 
		this.laspid = laspid;
	}
	/**
	 * @Description laspid的中文含义是： 
	 */
	public String getLaspid(){
		return laspid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description laspflfg的中文含义是： 违反的法律法规
	 */
	public void setLaspflfg(String laspflfg){ 
		this.laspflfg = laspflfg;
	}
	/**
	 * @Description laspflfg的中文含义是： 违反的法律法规
	 */
	public String getLaspflfg(){
		return laspflfg;
	}
	/**
	 * @Description laspjbr的中文含义是： 经办人
	 */
	public void setLaspjbr(String laspjbr){ 
		this.laspjbr = laspjbr;
	}
	/**
	 * @Description laspjbr的中文含义是： 经办人
	 */
	public String getLaspjbr(){
		return laspjbr;
	}
	/**
	 * @Description laspjbrqzrq的中文含义是： 经办人签字日期
	 */
	public void setLaspjbrqzrq(String laspjbrqzrq){ 
		this.laspjbrqzrq = laspjbrqzrq;
	}
	/**
	 * @Description laspjbrqzrq的中文含义是： 经办人签字日期
	 */
	public String getLaspjbrqzrq(){
		return laspjbrqzrq;
	}
	/**
	 * @Description laspcbbmfzr的中文含义是： 承办部门负责人
	 */
	public void setLaspcbbmfzr(String laspcbbmfzr){ 
		this.laspcbbmfzr = laspcbbmfzr;
	}
	/**
	 * @Description laspcbbmfzr的中文含义是： 承办部门负责人
	 */
	public String getLaspcbbmfzr(){
		return laspcbbmfzr;
	}
	/**
	 * @Description laspcbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	public void setLaspcbbmfzrqzrq(String laspcbbmfzrqzrq){ 
		this.laspcbbmfzrqzrq = laspcbbmfzrqzrq;
	}
	/**
	 * @Description laspcbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	public String getLaspcbbmfzrqzrq(){
		return laspcbbmfzrqzrq;
	}
	/**
	 * @Description laspspyj的中文含义是： 审批意见
	 */
	public void setLaspspyj(String laspspyj){ 
		this.laspspyj = laspspyj;
	}
	/**
	 * @Description laspspyj的中文含义是： 审批意见
	 */
	public String getLaspspyj(){
		return laspspyj;
	}
	/**
	 * @Description laspfgfzrqzrq的中文含义是： 分管负责人签字日期
	 */
	public void setLaspfgfzrqzrq(String laspfgfzrqzrq){ 
		this.laspfgfzrqzrq = laspfgfzrqzrq;
	}
	/**
	 * @Description laspfgfzrqzrq的中文含义是： 分管负责人签字日期
	 */
	public String getLaspfgfzrqzrq(){
		return laspfgfzrqzrq;
	}
	/**
	 * @Description laspfgfzr的中文含义是： 分管负责人
	 */
	public void setLaspfgfzr(String laspfgfzr){ 
		this.laspfgfzr = laspfgfzr;
	}
	/**
	 * @Description laspfgfzr的中文含义是： 分管负责人
	 */
	public String getLaspfgfzr(){
		return laspfgfzr;
	}
	/**
	 * @Description laspaqzy的中文含义是： 案情摘要
	 */
	public void setLaspaqzy(String laspaqzy){ 
		this.laspaqzy = laspaqzy;
	}
	/**
	 * @Description laspaqzy的中文含义是： 案情摘要
	 */
	public String getLaspaqzy(){
		return laspaqzy;
	}
	/**
	 * @Description laspjbr2的中文含义是： 经办人2
	 */
	public void setLaspjbr2(String laspjbr2){ 
		this.laspjbr2 = laspjbr2;
	}
	/**
	 * @Description laspjbr2的中文含义是： 经办人2
	 */
	public String getLaspjbr2(){
		return laspjbr2;
	}
	/**
	 * @Description laspzbr的中文含义是： 主办人
	 */
	public void setLaspzbr(String laspzbr){ 
		this.laspzbr = laspzbr;
	}
	/**
	 * @Description laspzbr的中文含义是： 主办人
	 */
	public String getLaspzbr(){
		return laspzbr;
	}
	/**
	 * @Description laspcbr的中文含义是： 协办人
	 */
	public void setLaspcbr(String laspcbr){ 
		this.laspcbr = laspcbr;
	}
	/**
	 * @Description laspcbr的中文含义是： 协办人
	 */
	public String getLaspcbr(){
		return laspcbr;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public void setAjdjay(String ajdjay){ 
		this.ajdjay = ajdjay;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public String getAjdjay(){
		return ajdjay;
	}
	/**
	 * @Description laspdsr的中文含义是： 当事人
	 */
	public void setLaspdsr(String laspdsr){ 
		this.laspdsr = laspdsr;
	}
	/**
	 * @Description laspdsr的中文含义是： 当事人
	 */
	public String getLaspdsr(){
		return laspdsr;
	}
	/**
	 * @Description laspfddbr的中文含义是： 法定代表人(负责人)
	 */
	public void setLaspfddbr(String laspfddbr){ 
		this.laspfddbr = laspfddbr;
	}
	/**
	 * @Description laspfddbr的中文含义是： 法定代表人(负责人)
	 */
	public String getLaspfddbr(){
		return laspfddbr;
	}
	/**
	 * @Description laspdz的中文含义是： 地址
	 */
	public void setLaspdz(String laspdz){ 
		this.laspdz = laspdz;
	}
	/**
	 * @Description laspdz的中文含义是： 地址
	 */
	public String getLaspdz(){
		return laspdz;
	}
	/**
	 * @Description lasplxfs的中文含义是： 联系方式
	 */
	public void setLasplxfs(String lasplxfs){ 
		this.lasplxfs = lasplxfs;
	}
	/**
	 * @Description lasplxfs的中文含义是： 联系方式
	 */
	public String getLasplxfs(){
		return lasplxfs;
	}
	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	public void setAjdjajly(String ajdjajly){ 
		this.ajdjajly = ajdjajly;
	}
	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	public String getAjdjajly(){
		return ajdjajly;
	}
	/**
	 * @Description laspjyzb的中文含义是： 建议主办
	 */
	public void setLaspjyzb(String laspjyzb){ 
		this.laspjyzb = laspjyzb;
	}
	/**
	 * @Description laspjyzb的中文含义是： 建议主办
	 */
	public String getLaspjyzb(){
		return laspjyzb;
	}
	/**
	 * @Description laspjyxb的中文含义是： 建议协办
	 */
	public void setLaspjyxb(String laspjyxb){ 
		this.laspjyxb = laspjyxb;
	}
	/**
	 * @Description laspjyxb的中文含义是： 建议协办
	 */
	public String getLaspjyxb(){
		return laspjyxb;
	}
	/**
	 * @Description laspsplarq的中文含义是： 审批立案日期(汤阴)
	 */
	public void setLaspsplarq(String laspsplarq){ 
		this.laspsplarq = laspsplarq;
	}
	/**
	 * @Description laspsplarq的中文含义是： 审批立案日期(汤阴)
	 */
	public String getLaspsplarq(){
		return laspsplarq;
	}
	/**
	 * @Description laspspzb的中文含义是： 审批主办(汤阴)
	 */
	public void setLaspspzb(String laspspzb){ 
		this.laspspzb = laspspzb;
	}
	/**
	 * @Description laspspzb的中文含义是： 审批主办(汤阴)
	 */
	public String getLaspspzb(){
		return laspspzb;
	}
	/**
	 * @Description laspspxb的中文含义是： 审批协办(汤阴)
	 */
	public void setLaspspxb(String laspspxb){ 
		this.laspspxb = laspspxb;
	}
	/**
	 * @Description laspspxb的中文含义是： 审批协办(汤阴)
	 */
	public String getLaspspxb(){
		return laspspxb;
	}

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}
}