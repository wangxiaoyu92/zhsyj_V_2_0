package com.askj.baseinfo.dto;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class OmcheckgroupDTO {
/** 检查项目表; InnoDB free: 4096 kB  */
	/** itemid 的中文含义是：项目ID*/
	private String itemid;

	/** itempid 的中文含义是：项目父ID*/
	private String itempid;

	/** itemtype 的中文含义是：项目类别*/
	private String itemtype;

	/** itemname 的中文含义是：项目名称*/
	private String itemname;

	/** itemdesc 的中文含义是：项目描述*/
	private String itemdesc;

	/** itemext1 的中文含义是：项目扩展属性1*/
	private String itemext1;

	/** itemext2 的中文含义是：项目扩展属性2*/
	private String itemext2;

	/** itemext3 的中文含义是：项目扩展属性3*/
	private String itemext3;

	/** itemremark 的中文含义是：项目备注*/
	private String itemremark;

	/** operatedate 的中文含义是：项目经办日期*/
	private Timestamp operatedate;

	/** operateperson 的中文含义是：项目经办人*/
	private String operateperson;

	/** itemsortid 的中文含义是：项目排序号*/
	private BigDecimal itemsortid;
	/** planmobankind 的中文含义是：计划模板类型aa10=PLANMOBANKIND*/
	private String planmobankind;


	public void setItemid(String itemid){
		this.itemid=itemid;
	}

	public String getItemid(){
		return itemid;
	}

	public void setItempid(String itempid){
		this.itempid=itempid;
	}

	public String getItempid(){
		return itempid;
	}

	public void setItemtype(String itemtype){
		this.itemtype=itemtype;
	}

	public String getItemtype(){
		return itemtype;
	}

	public void setItemname(String itemname){
		this.itemname=itemname;
	}

	public String getItemname(){
		return itemname;
	}

	public void setItemdesc(String itemdesc){
		this.itemdesc=itemdesc;
	}

	public String getItemdesc(){
		return itemdesc;
	}

	public void setItemext1(String itemext1){
		this.itemext1=itemext1;
	}

	public String getItemext1(){
		return itemext1;
	}

	public void setItemext2(String itemext2){
		this.itemext2=itemext2;
	}

	public String getItemext2(){
		return itemext2;
	}

	public void setItemext3(String itemext3){
		this.itemext3=itemext3;
	}

	public String getItemext3(){
		return itemext3;
	}

	public void setItemremark(String itemremark){
		this.itemremark=itemremark;
	}

	public String getItemremark(){
		return itemremark;
	}

	public void setOperatedate(Timestamp operatedate){
		this.operatedate=operatedate;
	}

	public Timestamp getOperatedate(){
		return operatedate;
	}

	public void setOperateperson(String operateperson){
		this.operateperson=operateperson;
	}

	public String getOperateperson(){
		return operateperson;
	}

	public void setItemsortid(BigDecimal itemsortid){
		this.itemsortid=itemsortid;
	}

	public BigDecimal getItemsortid(){
		return itemsortid;
	}

	public String getPlanmobankind() {
		return planmobankind;
	}

	public void setPlanmobankind(String planmobankind) {
		this.planmobankind = planmobankind;
	}
}

