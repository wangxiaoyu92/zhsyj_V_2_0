package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Pcyfwdtdjpdb")
public class Pcyfwdtdjpdb {
/** 餐饮服务食品安全监督动态等级评定表; InnoDB free: 51200 kB  */
	/** pcyfwdtdjpdb 的中文含义是：餐饮服务食品安全监督动态等级评定表id*/
	@Name
	@Column
	private String pcyfwdtdjpdbid;

	/** comid 的中文含义是：企业id*/
	@Column
	private String comid;

	/** resultid 的中文含义是：检查主表id*/
	@Column
	private String resultid;

	/** commc 的中文含义是：被检查单位名称*/
	@Column
	private String commc;

	/** comdz 的中文含义是：地址*/
	@Column
	private String comdz;

	/** comfrhyz 的中文含义是：法定代表人*/
	@Column
	private String comfrhyz;

	/** comyddh 的中文含义是：电话*/
	@Column
	private String comyddh;

	/** xkzbh 的中文含义是：餐饮服务许可证编号*/
	@Column
	private String comxkzbh;

	/** xklb 的中文含义是：许可类别*/
	@Column
	private String xklb;

	/** jckssj 的中文含义是：检查开始时间*/
	@Column
	private Timestamp jckssj;

	/** jcjssj 的中文含义是：检查结束时间*/
	@Column
	private Timestamp jcjssj;

	/** aae011 的中文含义是：操作员*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private Timestamp aae036;

	/** jcryqzpic 的中文含义是：检查人员签字*/
	@Column
	private String jcryqzpic;

	/** spaqglrypic 的中文含义是：食品安全管理人员签字*/
	@Column
	private String spaqglrypic;


	public void setPcyfwdtdjpdbid(String pcyfwdtdjpdb){
		this.pcyfwdtdjpdbid=pcyfwdtdjpdb;
	}

	public String getPcyfwdtdjpdbid(){
		return pcyfwdtdjpdbid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setResultid(String resultid){
		this.resultid=resultid;
	}

	public String getResultid(){
		return resultid;
	}

	public void setCommc(String commc){
		this.commc=commc;
	}

	public String getCommc(){
		return commc;
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

	public String getComxkzbh() {
		return comxkzbh;
	}

	public void setComxkzbh(String comxkzbh) {
		this.comxkzbh = comxkzbh;
	}

	public void setXklb(String xklb){
		this.xklb=xklb;
	}

	public String getXklb(){
		return xklb;
	}

	public void setJckssj(Timestamp jckssj){
		this.jckssj=jckssj;
	}

	public Timestamp getJckssj(){
		return jckssj;
	}

	public void setJcjssj(Timestamp jcjssj){
		this.jcjssj=jcjssj;
	}

	public Timestamp getJcjssj(){
		return jcjssj;
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

	public String getJcryqzpic() {
		return jcryqzpic;
	}

	public void setJcryqzpic(String jcryqzpic) {
		this.jcryqzpic = jcryqzpic;
	}

	public String getSpaqglrypic() {
		return spaqglrypic;
	}

	public void setSpaqglrypic(String spaqglrypic) {
		this.spaqglrypic = spaqglrypic;
	}
}

