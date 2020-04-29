package com.askj.baseinfo.dto;

import java.util.Date;

/**
 *  OmLawGroupDTO的中文名称：法律法规项目表
 *
 *  @author : zy
 */
public class OmLawGroupDTO {
	
	//子节点数量,非映射字段
	private int childnum;

	//是否父节点,非映射字段
	private boolean isparent;

	//是否展开,非映射字段
	private boolean isopen;
	
	//父项目名称
	private String parentname;
	
	/**
	 * @Description itemid的中文含义是： 项目id(系统生成,唯一关键字)
	 */
	private String itemid;

	/**
	 * @Description itemname的中文含义是： 项目名称
	 */
	private String itemname;

	/**
	 * @Description itemdesc的中文含义是： 项目描述
	 */
	private String itemdesc;

	/**
	 * @Description itempid的中文含义是： 父项目id
	 */
	private String itempid;

	/**
	 * @Description itemtype的中文含义是： 项目类别
	 */
	private String itemtype;
	
	/**
	 * @Description itemremark的中文含义是：项目备注
	 */
	private String itemremark;

	/**
	 * @Description itemsortid的中文含义是： 项目排序号
	 */
	private Integer itemsortid;
	
	/**
	 * @Description operatedate的中文含义是：项目经办日期
	 */
	private Date operatedate;
	
	/**
	 * @Description operateperson的中文含义是：项目经办人
	 */
	private String operateperson;

	public int getChildnum() {
		return childnum;
	}

	public void setChildnum(int childnum) {
		this.childnum = childnum;
	}

	public boolean isIsparent() {
		return isparent;
	}

	public void setIsparent(boolean isparent) {
		this.isparent = isparent;
	}

	public boolean isIsopen() {
		return isopen;
	}

	public void setIsopen(boolean isopen) {
		this.isopen = isopen;
	}

	public String getParentname() {
		return parentname;
	}

	public void setParentname(String parentname) {
		this.parentname = parentname;
	}

	public String getItemid() {
		return itemid;
	}

	public void setItemid(String itemid) {
		this.itemid = itemid;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getItemdesc() {
		return itemdesc;
	}

	public void setItemdesc(String itemdesc) {
		this.itemdesc = itemdesc;
	}

	public String getItempid() {
		return itempid;
	}

	public void setItempid(String itempid) {
		this.itempid = itempid;
	}

	public String getItemtype() {
		return itemtype;
	}

	public void setItemtype(String itemtype) {
		this.itemtype = itemtype;
	}

	public Integer getItemsortid() {
		return itemsortid;
	}

	public void setItemsortid(Integer itemsortid) {
		this.itemsortid = itemsortid;
	}

	public String getItemremark() {
		return itemremark;
	}

	public void setItemremark(String itemremark) {
		this.itemremark = itemremark;
	}

	public Date getOperatedate() {
		return operatedate;
	}

	public void setOperatedate(Date operatedate) {
		this.operatedate = operatedate;
	}

	public String getOperateperson() {
		return operateperson;
	}

	public void setOperateperson(String operateperson) {
		this.operateperson = operateperson;
	}

}