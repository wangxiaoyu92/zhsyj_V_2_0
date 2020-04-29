package com.askj.tmsyj.tmsyj.dto;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;

public class HjyjczbmxbDTO {	
	/** 检验检测主表  */
	/** hjyjczbid 的中文含义是：检验检测主表id*/
	private String hjyjczbid;

	/** hviewjgztid 的中文含义是：监管主体表id(仪器对接用)*/
	private String hviewjgztid;

	/** hviewjgztmc 的中文含义是：监管主体名称(仪器对接用:被检单位)*/
	private String hviewjgztmc;

	/** jcztbzjid 的中文含义是：检测主体表主键id*/
	private String jcztbzjid;

	/** jyjcbgbh 的中文含义是：检验检测报告编号*/
	private String jyjcbgbh;

	/** jyjcrq 的中文含义是：检验检测日期(仪器对接用)*/
	private Timestamp jyjcrq;

	/** eptbh 的中文含义是：e票通编号*/
	private String eptbh;

	/** jcypid 的中文含义是：商品id(仪器对接用)*/
	private String jcypid;

	/** jcypmc 的中文含义是：商品名称(仪器对接用-样品名称)*/
	private String jcypmc;

	/** jcjylb 的中文含义是：检测检验类别aaa100=jcjylb*/
	private String jcjylb;

	/** jcorgid 的中文含义是：检测机构id*/
	private String jcorgid;

	/** jcorgmc 的中文含义是：检测机构名称(仪器对接用:检测单位)*/
	private String jcorgmc;

	/** jcryid 的中文含义是：检测人员id*/
	private String jcryid;

	/** jcrymc 的中文含义是：检测人员名称(仪器对接用)*/
	private String jcrymc;

	/** fjjg 的中文含义是：复检结果*/
	private String fjjg;

	/** jcjyshbz 的中文含义是：审核标志见aaa100=JCJYSHBZ*/
	private String jcjyshbz;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;

	/** sjcsfs 的中文含义是：数据产生方式0本系统录入1仪器对接*/
	private String sjcsfs;

	/** sbxh 的中文含义是：设备型号(仪器对接用)*/
	private String sbxh;

	/** sbxlh 的中文含义是：设备序列号*/
	private String sbxlh;


	public void setHjyjczbid(String hjyjczbid){
		this.hjyjczbid=hjyjczbid;
	}

	public String getHjyjczbid(){
		return hjyjczbid;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setHviewjgztmc(String hviewjgztmc){
		this.hviewjgztmc=hviewjgztmc;
	}

	public String getHviewjgztmc(){
		return hviewjgztmc;
	}

	public void setJcztbzjid(String jcztbzjid){
		this.jcztbzjid=jcztbzjid;
	}

	public String getJcztbzjid(){
		return jcztbzjid;
	}

	public void setJyjcbgbh(String jyjcbgbh){
		this.jyjcbgbh=jyjcbgbh;
	}

	public String getJyjcbgbh(){
		return jyjcbgbh;
	}

	public void setJyjcrq(Timestamp jyjcrq){
		this.jyjcrq=jyjcrq;
	}

	public Timestamp getJyjcrq(){
		return jyjcrq;
	}

	public void setEptbh(String eptbh){
		this.eptbh=eptbh;
	}

	public String getEptbh(){
		return eptbh;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setJcypmc(String jcypmc){
		this.jcypmc=jcypmc;
	}

	public String getJcypmc(){
		return jcypmc;
	}

	public void setJcjylb(String jcjylb){
		this.jcjylb=jcjylb;
	}

	public String getJcjylb(){
		return jcjylb;
	}

	public void setJcorgid(String jcorgid){
		this.jcorgid=jcorgid;
	}

	public String getJcorgid(){
		return jcorgid;
	}

	public void setJcorgmc(String jcorgmc){
		this.jcorgmc=jcorgmc;
	}

	public String getJcorgmc(){
		return jcorgmc;
	}

	public void setJcryid(String jcryid){
		this.jcryid=jcryid;
	}

	public String getJcryid(){
		return jcryid;
	}

	public void setJcrymc(String jcrymc){
		this.jcrymc=jcrymc;
	}

	public String getJcrymc(){
		return jcrymc;
	}

	public void setFjjg(String fjjg){
		this.fjjg=fjjg;
	}

	public String getFjjg(){
		return fjjg;
	}

	public void setJcjyshbz(String jcjyshbz){
		this.jcjyshbz=jcjyshbz;
	}

	public String getJcjyshbz(){
		return jcjyshbz;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(Timestamp aae036){
		this.aae036=aae036;
	}

	public Timestamp getAae036(){
		return aae036;
	}

	public void setSjcsfs(String sjcsfs){
		this.sjcsfs=sjcsfs;
	}

	public String getSjcsfs(){
		return sjcsfs;
	}

	public void setSbxh(String sbxh){
		this.sbxh=sbxh;
	}

	public String getSbxh(){
		return sbxh;
	}

	public void setSbxlh(String sbxlh){
		this.sbxlh=sbxlh;
	}

	public String getSbxlh(){
		return sbxlh;
	}

	
	/** 检验检测明细表  */
	/** hjyjcmxbid 的中文含义是：检验检测明细表id*/
	private String hjyjcmxbid;

	/** jcxmbh 的中文含义是：检测项目id(仪器导入用)*/
	private String jcxmbh;

	/** jcxmmc 的中文含义是：检测项目名称(仪器导入用)*/
	private String jcxmmc;

	/** jcz 的中文含义是：检测值(仪器导入用)*/
	private String jcz;

	/** szdw 的中文含义是：数值单位(仪器导入用)*/
	private String szdw;

	/** jyjcjl 的中文含义是：检验检测结论aaa100=jyjcjl(仪器导入用-结果判定)*/
	private String jyjcjl;

	/** xlbz 的中文含义是：限量标准,执行标准号(仪器导入用)*/
	private String xlbz;

	/** bzz 的中文含义是：标准值(仪器导入用-标准值，限量值)*/
	private String bzz;


	public void setHjyjcmxbid(String hjyjcmxbid){
		this.hjyjcmxbid=hjyjcmxbid;
	}

	public String getHjyjcmxbid(){
		return hjyjcmxbid;
	}

	public void setJcxmbh(String jcxmbh){
		this.jcxmbh=jcxmbh;
	}

	public String getJcxmbh(){
		return jcxmbh;
	}

	public void setJcxmmc(String jcxmmc){
		this.jcxmmc=jcxmmc;
	}

	public String getJcxmmc(){
		return jcxmmc;
	}

	public void setJcz(String jcz){
		this.jcz=jcz;
	}

	public String getJcz(){
		return jcz;
	}

	public void setSzdw(String szdw){
		this.szdw=szdw;
	}

	public String getSzdw(){
		return szdw;
	}

	public void setJyjcjl(String jyjcjl){
		this.jyjcjl=jyjcjl;
	}

	public String getJyjcjl(){
		return jyjcjl;
	}

	public void setXlbz(String xlbz){
		this.xlbz=xlbz;
	}

	public String getXlbz(){
		return xlbz;
	}

	public void setBzz(String bzz){
		this.bzz=bzz;
	}

	public String getBzz(){
		return bzz;
	}


	/** comid 的中文含义是：企业ID*/
	private String comid;
	/** commc 的中文含义是：企业名称*/
	private String commc;


	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}

	public String getCommc() {
		return commc;
	}

	public void setCommc(String commc) {
		this.commc = commc;
	}
	
	
}

