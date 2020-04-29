package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.util.Date;

/**
 *
 *  OmLawGroup的中文名称：法律法规项目表
 *
 *  @author : zy
 */
@Table(value = "omlawgroup")
public class OmLawGroup {

	/**
	 * @Description itemid的中文含义是： 项目id(系统生成,唯一关键字)
	 */
	@Column
	@Name
	private String itemid;

	/**
	 * @Description itemname的中文含义是： 项目名称
	 */
	@Column
	private String itemname;

	/**
	 * @Description itemdesc的中文含义是： 项目描述
	 */
	@Column
	private String itemdesc;

	/**
	 * @Description itempid的中文含义是： 父项目id
	 */
	@Column
	private String itempid;

	/**
	 * @Description itemtype的中文含义是： 项目类别
	 */
	@Column
	private String itemtype;
	
	/**
	 * @Description itemremark的中文含义是：项目备注
	 */
	@Column
	private String itemremark;

	/**
	 * @Description itemsortid的中文含义是： 项目排序号
	 */
	@Column
	private Integer itemsortid;
	
	/**
	 * @Description operatedate的中文含义是：项目经办日期
	 */
	@Column
	private Date operatedate;
	
	/**
	 * @Description operateperson的中文含义是：项目经办人
	 */
	@Column
	private String operateperson;

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