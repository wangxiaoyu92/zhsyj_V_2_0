package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.Column;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class PcyfwnddjpdDTO {
	//扩展开始
	/** cpdjaaa103 初评等级*/
	private String cpdjaaa103;
	/** fpdjaaa103 复评等级*/
	private String fpdjaaa103;
	/** spdjaaa103 审评等级*/
	private String spdjaaa103;

	/** userid 的中文含义是：评定明细列表*/
	private String userid;
	/** pcyfwnddjpdmxlist 的中文含义是：评定明细列表*/
	private String pcyfwnddjpdmxlist;

	//扩展结束
/** 餐饮服务食品安全监督年度等级评定表; InnoDB free: 14336 kB  */
	/** pcyfwnddjpdid 的中文含义是：餐饮服务食品安全监督年度等级评定表id*/
	private String pcyfwnddjpdid;

	/** comid 的中文含义是：单位id*/
	private String comid;

	/** checkyear 的中文含义是：年度*/
	private String checkyear;

	/** dwmc 的中文含义是：单位名称*/
	private String dwmc;

	/** comdz 的中文含义是：地址*/
	private String comdz;

	/** comfrhyz 的中文含义是：法定代表人（负责人或业主）*/
	private String comfrhyz;

	/** comyddh 的中文含义是：电话*/
	private String comyddh;

	/** cyfwxkzh 的中文含义是：餐饮服务许可证证号*/
	private String cyfwxkzh;

	/** xklb 的中文含义是：许可类别*/
	private String xklb;

	/** ndpjdf 的中文含义是：年度平均得分*/
	private String ndpjdf;

	/** lhfjndpddj 的中文含义是：评定等级*/
	private String lhfjndpddj;

	/** cpyj 的中文含义是：初评意见*/
	private String cpyj;

	/** cprq 的中文含义是：初评日期*/
	private Date cprq;

	/** fpyj 的中文含义是：复评意见*/
	private String fpyj;

	/** fprq 的中文含义是：复评日期*/
	private Date fprq;

	/** spyj 的中文含义是：审评意见*/
	private String spyj;

	/** sprq 的中文含义是：审评日期*/
	private Date sprq;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;

	/** resultid 的中文含义是：*/
	private String resultid;

	/** cpyj 的中文含义是：初评等级*/
	private String cpdj;

	/** cpyj 的中文含义是：复评等级*/
	private String fpdj;

	/** cpyj 的中文含义是：审评等级*/
	private String spdj;

	public void setPcyfwnddjpdid(String pcyfwnddjpdid){
		this.pcyfwnddjpdid=pcyfwnddjpdid;
	}

	public String getPcyfwnddjpdid(){
		return pcyfwnddjpdid;
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

	public void setDwmc(String dwmc){
		this.dwmc=dwmc;
	}

	public String getDwmc(){
		return dwmc;
	}

	public void setComdz(String comdz){
		this.comdz=comdz;
	}

	public String getComdz(){
		return comdz;
	}

	public void setComfrhyz(String comfrhyz){
		this.comfrhyz=comfrhyz;
	}

	public String getComfrhyz(){
		return comfrhyz;
	}

	public void setComyddh(String comyddh){
		this.comyddh=comyddh;
	}

	public String getComyddh(){
		return comyddh;
	}

	public void setCyfwxkzh(String cyfwxkzh){
		this.cyfwxkzh=cyfwxkzh;
	}

	public String getCyfwxkzh(){
		return cyfwxkzh;
	}

	public void setXklb(String xklb){
		this.xklb=xklb;
	}

	public String getXklb(){
		return xklb;
	}

	public void setNdpjdf(String ndpjdf){
		this.ndpjdf=ndpjdf;
	}

	public String getNdpjdf(){
		return ndpjdf;
	}

	public void setLhfjndpddj(String lhfjndpddj){
		this.lhfjndpddj=lhfjndpddj;
	}

	public String getLhfjndpddj(){
		return lhfjndpddj;
	}

	public void setCpyj(String cpyj){
		this.cpyj=cpyj;
	}

	public String getCpyj(){
		return cpyj;
	}

	public void setCprq(Date cprq){
		this.cprq=cprq;
	}

	public Date getCprq(){
		return cprq;
	}

	public void setFpyj(String fpyj){
		this.fpyj=fpyj;
	}

	public String getFpyj(){
		return fpyj;
	}

	public void setFprq(Date fprq){
		this.fprq=fprq;
	}

	public Date getFprq(){
		return fprq;
	}

	public void setSpyj(String spyj){
		this.spyj=spyj;
	}

	public String getSpyj(){
		return spyj;
	}

	public void setSprq(Date sprq){
		this.sprq=sprq;
	}

	public Date getSprq(){
		return sprq;
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

	public String getPcyfwnddjpdmxlist() {
		return pcyfwnddjpdmxlist;
	}

	public void setPcyfwnddjpdmxlist(String pcyfwnddjpdmxlist) {
		this.pcyfwnddjpdmxlist = pcyfwnddjpdmxlist;
	}

	public String getResultid() {
		return resultid;
	}

	public void setResultid(String resultid) {
		this.resultid = resultid;
	}

	public String getCpdj() {
		return cpdj;
	}

	public void setCpdj(String cpdj) {
		this.cpdj = cpdj;
	}

	public String getFpdj() {
		return fpdj;
	}

	public void setFpdj(String fpdj) {
		this.fpdj = fpdj;
	}

	public String getSpdj() {
		return spdj;
	}

	public void setSpdj(String spdj) {
		this.spdj = spdj;
	}

	public String getCpdjaaa103() {
		return cpdjaaa103;
	}

	public void setCpdjaaa103(String cpdjaaa103) {
		this.cpdjaaa103 = cpdjaaa103;
	}

	public String getFpdjaaa103() {
		return fpdjaaa103;
	}

	public void setFpdjaaa103(String fpdjaaa103) {
		this.fpdjaaa103 = fpdjaaa103;
	}

	public String getSpdjaaa103() {
		return spdjaaa103;
	}

	public void setSpdjaaa103(String spdjaaa103) {
		this.spdjaaa103 = spdjaaa103;
	}
}

