package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Jyjccjrwb")
public class Jyjccjrwb {
/** 检验检测抽检任务表; InnoDB free: 23552 kB  */
	/** jyjccjrwbid 的中文含义是：检验检测抽检任务表id*/
	@Name
	@Column
	private String jyjccjrwbid;

	/** comid 的中文含义是：抽检单位id*/
	@Column
	private String comid;

	/** jcrwmc 的中文含义是：抽检任务名称*/
	@Column
	private String jcrwmc;

	/** jcrwms 的中文含义是：抽检任务描述*/
	@Column
	private String jcrwms;

	/** jcrwkssj 的中文含义是：抽检任务开始时间*/
	@Column
	private String jcrwkssj;

	/** jcrwjssj 的中文含义是：抽检任务结束时间*/
	@Column
	private String jcrwjssj;

	/** cjjgcomid 的中文含义是：承检机构id*/
	@Column
	private String cjjgcomid;

	/** cjjgrwjsbz 的中文含义是：承检机构任务接受标志aaa100=cjjgrwjsbz,0未处理1接受2不接受*/
	@Column
	private String cjjgrwjsbz;

	/** cjjgrwbjsyy 的中文含义是：承检机构任务不接受原因说明*/
	@Column
	private String cjjgrwbjsyy;

	/** jcrwzxzt 的中文含义是：任务执行状态aaa100=jcrwzxzt*/
	@Column
	private String jcrwzxzt;

	/** aae011 的中文含义是：经办人*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	@Column
	private String aae036;


	public void setJyjccjrwbid(String jyjccjrwbid){
		this.jyjccjrwbid=jyjccjrwbid;
	}

	public String getJyjccjrwbid(){
		return jyjccjrwbid;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setJcrwmc(String jcrwmc){
		this.jcrwmc=jcrwmc;
	}

	public String getJcrwmc(){
		return jcrwmc;
	}

	public void setJcrwms(String jcrwms){
		this.jcrwms=jcrwms;
	}

	public String getJcrwms(){
		return jcrwms;
	}

	public void setJcrwkssj(String jcrwkssj){
		this.jcrwkssj=jcrwkssj;
	}

	public String getJcrwkssj(){
		return jcrwkssj;
	}

	public void setJcrwjssj(String jcrwjssj){
		this.jcrwjssj=jcrwjssj;
	}

	public String getJcrwjssj(){
		return jcrwjssj;
	}

	public void setCjjgcomid(String cjjgcomid){
		this.cjjgcomid=cjjgcomid;
	}

	public String getCjjgcomid(){
		return cjjgcomid;
	}

	public void setCjjgrwjsbz(String cjjgrwjsbz){
		this.cjjgrwjsbz=cjjgrwjsbz;
	}

	public String getCjjgrwjsbz(){
		return cjjgrwjsbz;
	}

	public void setCjjgrwbjsyy(String cjjgrwbjsyy){
		this.cjjgrwbjsyy=cjjgrwbjsyy;
	}

	public String getCjjgrwbjsyy(){
		return cjjgrwbjsyy;
	}

	public void setJcrwzxzt(String jcrwzxzt){
		this.jcrwzxzt=jcrwzxzt;
	}

	public String getJcrwzxzt(){
		return jcrwzxzt;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(String aae036){
		this.aae036=aae036;
	}

	public String getAae036(){
		return aae036;
	}

}

