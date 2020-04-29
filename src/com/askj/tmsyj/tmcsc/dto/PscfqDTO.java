package com.askj.tmsyj.tmcsc.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class PscfqDTO {
/** 市场分区表  */
	/** pscfqid 的中文含义是：null*/
	private String pscfqid;

	/** comid 的中文含义是：市场id*/
	private String comid;

	/** scfqbh 的中文含义是：市场分区编号*/
	private String scfqbh;

	/** scfqmc 的中文含义是：市场分区名称*/
	private String scfqmc;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;

	/** aae013 的中文含义是：备注*/
	private String aae013;
	private String isopen;
	private String isparent;
	private String parentname;
	private String parent;
	private int childnum; 

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public String getParentname() {
		return parentname;
	}

	public void setParentname(String parentname) {
		this.parentname = parentname;
	}

	public int getChildnum() {
		return childnum;
	}

	public void setChildnum(int childnum) {
		this.childnum = childnum;
	}

	public String getIsopen() {
		return isopen;
	}

	public void setIsopen(String isopen) {
		this.isopen = isopen;
	}

	public String getIsparent() {
		return isparent;
	}

	public void setIsparent(String isparent) {
		this.isparent = isparent;
	}

	public void setPscfqid(String pscfqid){
		this.pscfqid=pscfqid;
	}

	public String getPscfqid(){
		return pscfqid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setScfqbh(String scfqbh){
		this.scfqbh=scfqbh;
	}

	public String getScfqbh(){
		return scfqbh;
	}

	public void setScfqmc(String scfqmc){
		this.scfqmc=scfqmc;
	}

	public String getScfqmc(){
		return scfqmc;
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

	public void setAae013(String aae013){
		this.aae013=aae013;
	}

	public String getAae013(){
		return aae013;
	}

}

