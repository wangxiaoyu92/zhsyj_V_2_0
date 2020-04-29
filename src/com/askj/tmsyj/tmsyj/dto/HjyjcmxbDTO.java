package com.askj.tmsyj.tmsyj.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class HjyjcmxbDTO {
	/** 检验检测明细表  */
	/** hjyjcmxbid 的中文含义是：检验检测明细表id*/
	private String hjyjcmxbid;

	/** hjyjczbid 的中文含义是：检验检测主表id*/
	private String hjyjczbid;

	/** jcxmbh 的中文含义是：检测项目编号(仪器导入用)*/
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

	public void setHjyjczbid(String hjyjczbid){
		this.hjyjczbid=hjyjczbid;
	}

	public String getHjyjczbid(){
		return hjyjczbid;
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

	public String getJcxmbh() {
		return jcxmbh;
	}

	public void setJcxmbh(String jcxmbh) {
		this.jcxmbh = jcxmbh;
	}

}

