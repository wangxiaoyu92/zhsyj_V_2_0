package com.askj.supervision.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class PjingcyfwlhDTO {
	//扩展开始
	/** userid 的中文含义是：用户id*/
	private String userid;
	//扩展结束
/** 餐饮服务提供者静态风险因素量化分值表; InnoDB free: 14336 kB  */
	/** pjingcyfwlhid 的中文含义是：餐饮服务提供者静态风险因素量化分值表id*/
	private String pjingcyfwlhid;

	/** comid 的中文含义是：企业id*/
	private String comid;

	/** checkyear 的中文含义是：年度*/
	private String checkyear;

	/** ythgm 的中文含义是：业态和规模*/
	private String ythgm;

	/** lengshidp 的中文含义是：类别和数量冷食类单品数*/
	private String lengshidp;

	/** lengshiyf 的中文含义是：类别和数量冷食类含易腐原料*/
	private String lengshiyf;

	/** shengshidp 的中文含义是：类别和数量生食类单品数*/
	private String shengshidp;

	/** gaodiandp 的中文含义是：类别和数量糕点类单品数*/
	private String gaodiandp;

	/** gaodianyf 的中文含义是：类别和数量糕点类易腐原料*/
	private String gaodianyf;

	/** reshidp 的中文含义是：类别和数量热食类单品数*/
	private String reshidp;

	/** reshiyf 的中文含义是：类别和数量热食类易腐原料*/
	private String reshiyf;

	/** zizhiyinpindp 的中文含义是：类别和数量自制饮品单品数*/
	private String zizhiyinpindp;

	/** qitadp 的中文含义是：类别和数量其他类食品制售单品数*/
	private String qitadp;

	/** dfzh 的中文含义是：得分总和*/
	private String dfzh;

	/** aae011 的中文含义是：经办人*/
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	private Timestamp aae036;

	/** resultid 的中文含义是：*/
	private String resultid;


	public void setPjingcyfwlhid(String pjingcyfwlhid){
		this.pjingcyfwlhid=pjingcyfwlhid;
	}

	public String getPjingcyfwlhid(){
		return pjingcyfwlhid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setCheckyear(String checkyear){
		this.checkyear=checkyear;
	}

	public String getCheckyear(){
		return checkyear;
	}

	public void setYthgm(String ythgm){
		this.ythgm=ythgm;
	}

	public String getYthgm(){
		return ythgm;
	}

	public void setLengshidp(String lengshidp){
		this.lengshidp=lengshidp;
	}

	public String getLengshidp(){
		return lengshidp;
	}

	public void setLengshiyf(String lengshiyf){
		this.lengshiyf=lengshiyf;
	}

	public String getLengshiyf(){
		return lengshiyf;
	}

	public void setShengshidp(String shengshidp){
		this.shengshidp=shengshidp;
	}

	public String getShengshidp(){
		return shengshidp;
	}

	public void setGaodiandp(String gaodiandp){
		this.gaodiandp=gaodiandp;
	}

	public String getGaodiandp(){
		return gaodiandp;
	}

	public void setGaodianyf(String gaodianyf){
		this.gaodianyf=gaodianyf;
	}

	public String getGaodianyf(){
		return gaodianyf;
	}

	public void setReshidp(String reshidp){
		this.reshidp=reshidp;
	}

	public String getReshidp(){
		return reshidp;
	}

	public void setReshiyf(String reshiyf){
		this.reshiyf=reshiyf;
	}

	public String getReshiyf(){
		return reshiyf;
	}

	public void setZizhiyinpindp(String zizhiyinpindp){
		this.zizhiyinpindp=zizhiyinpindp;
	}

	public String getZizhiyinpindp(){
		return zizhiyinpindp;
	}

	public void setQitadp(String qitadp){
		this.qitadp=qitadp;
	}

	public String getQitadp(){
		return qitadp;
	}

	public void setDfzh(String dfzh){
		this.dfzh=dfzh;
	}

	public String getDfzh(){
		return dfzh;
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

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getResultid() {
		return resultid;
	}

	public void setResultid(String resultid) {
		this.resultid = resultid;
	}
}

