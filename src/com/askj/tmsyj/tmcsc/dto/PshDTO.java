package com.askj.tmsyj.tmcsc.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class PshDTO {
/** 商户表  */
	//扩展开始
	/** shusername 的中文含义是：增加商户时产生的商户账号*/
	private String shusername;
	//扩展结束
	/** pshid 的中文含义是：商户id*/
	private String pshid;

	/** comid 的中文含义是：市场id*/
	private String comid;
	private String commc;

	/** pscfqid 的中文含义是：市场分区id*/
	private String pscfqid;
	private String scfqmc;
	private String parentname;

	/** shtwh 的中文含义是：商户摊位号*/
	private String shtwh;

	/** shmc 的中文含义是：商户名称*/
	private String shmc;

	/** shjc 的中文含义是：商户简称*/
	private String shjc;

	/** shlxr 的中文含义是：商户联系人*/
	private String shlxr;

	/** shtxdz 的中文含义是：商户通讯地址*/
	private String shtxdz;

	/** shyddh 的中文含义是：移动电话*/
	private String shyddh;

	/** shgddh 的中文含义是：固定电话*/
	private String shgddh;

	/** shsfzh 的中文含义是：身份证号*/
	private String shsfzh;

	/** shzzzmmc 的中文含义是：资质证明名称*/
	private String shzzzmmc;
	private String shzzzmmcinfo;

	/** shzzzmbh 的中文含义是：资质证明编号*/
	private String shzzzmbh;


	public String getParentname() {
		return parentname;
	}

	public void setParentname(String parentname) {
		this.parentname = parentname;
	}

	public String getShzzzmmcinfo() {
		return shzzzmmcinfo;
	}

	public void setShzzzmmcinfo(String shzzzmmcinfo) {
		this.shzzzmmcinfo = shzzzmmcinfo;
	}

	public String getCommc() {
		return commc;
	}

	public void setCommc(String commc) {
		this.commc = commc;
	}

	public String getScfqmc() {
		return scfqmc;
	}

	public void setScfqmc(String scfqmc) {
		this.scfqmc = scfqmc;
	}

	public void setPshid(String pshid){
		this.pshid=pshid;
	}

	public String getPshid(){
		return pshid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setPscfqid(String pscfqid){
		this.pscfqid=pscfqid;
	}

	public String getPscfqid(){
		return pscfqid;
	}

	public void setShtwh(String shtwh){
		this.shtwh=shtwh;
	}

	public String getShtwh(){
		return shtwh;
	}

	public void setShmc(String shmc){
		this.shmc=shmc;
	}

	public String getShmc(){
		return shmc;
	}

	public void setShjc(String shjc){
		this.shjc=shjc;
	}

	public String getShjc(){
		return shjc;
	}

	public void setShlxr(String shlxr){
		this.shlxr=shlxr;
	}

	public String getShlxr(){
		return shlxr;
	}

	public void setShtxdz(String shtxdz){
		this.shtxdz=shtxdz;
	}

	public String getShtxdz(){
		return shtxdz;
	}

	public void setShyddh(String shyddh){
		this.shyddh=shyddh;
	}

	public String getShyddh(){
		return shyddh;
	}

	public void setShgddh(String shgddh){
		this.shgddh=shgddh;
	}

	public String getShgddh(){
		return shgddh;
	}

	public void setShsfzh(String shsfzh){
		this.shsfzh=shsfzh;
	}

	public String getShsfzh(){
		return shsfzh;
	}

	public void setShzzzmmc(String shzzzmmc){
		this.shzzzmmc=shzzzmmc;
	}

	public String getShzzzmmc(){
		return shzzzmmc;
	}

	public void setShzzzmbh(String shzzzmbh){
		this.shzzzmbh=shzzzmbh;
	}

	public String getShzzzmbh(){
		return shzzzmbh;
	}

	public String getShusername() {
		return shusername;
	}

	public void setShusername(String shusername) {
		this.shusername = shusername;
	}

}

