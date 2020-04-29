package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.*;
import java.util.Date;
/**
 * @Description  CheckGroup 的中文含义是： 检查项目大类
 * @Creation     2016/05/10 16:03:50
 * @Written      syf
 **/
@Table(value = "OMCHECKGROUP")
public class CheckGroup {
	//扩展开始
	//gjf20180312 plantypearea 计划对应的企业大类
	private String plantypearea;
	//gjf20180312 plantypearea 计划对应的企业大类描述
	private String plantypeareadesc;
	//扩展结束

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

	/**
	 * @Description planmobankind 计划模板类型
	 */
	@Column
	private String planmobankind;

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

	public String getPlantypearea() {
		return plantypearea;
	}

	public void setPlantypearea(String plantypearea) {
		this.plantypearea = plantypearea;
	}

	public String getPlantypeareadesc() {
		return plantypeareadesc;
	}

	public void setPlantypeareadesc(String plantypeareadesc) {
		this.plantypeareadesc = plantypeareadesc;
	}

	public String getPlanmobankind() {
		return planmobankind;
	}

	public void setPlanmobankind(String planmobankind) {
		this.planmobankind = planmobankind;
	}
}