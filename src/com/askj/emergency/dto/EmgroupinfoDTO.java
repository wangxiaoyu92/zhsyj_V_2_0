package com.askj.emergency.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  EMGROUPINFO的中文含义是: 应急小组信息表; InnoDB free: 2731008 kBDTO
 * @Creation     2016/05/26 15:56:47
 * @Written      Create Tool By zjf 
 **/
public class EmgroupinfoDTO {
	/**
	 * @Description groupid的中文含义是： 应急小组ID
	 */
	private String groupid;

	/**
	 * @Description groupname的中文含义是： 应急小组名称
	 */
	private String groupname;

	/**
	 * @Description remark的中文含义是： 备注
	 */
	private String remark;

	/**
	 * @Description state的中文含义是： 状态 [0:添加 1:删除]
	 */
	private String state;

	/**
	 * @Description opepateperson的中文含义是： 经办人
	 */
	private String opepateperson;

	/**
	 * @Description opepatedate的中文含义是： 经办时间
	 */
	private String opepatedate;

	
		/**
	 * @Description groupid的中文含义是： 应急小组ID
	 */
	public void setGroupid(String groupid){ 
		this.groupid = groupid;
	}
	/**
	 * @Description groupid的中文含义是： 应急小组ID
	 */
	public String getGroupid(){
		return groupid;
	}
	/**
	 * @Description groupname的中文含义是： 应急小组名称
	 */
	public void setGroupname(String groupname){ 
		this.groupname = groupname;
	}
	/**
	 * @Description groupname的中文含义是： 应急小组名称
	 */
	public String getGroupname(){
		return groupname;
	}
	/**
	 * @Description remark的中文含义是： 备注
	 */
	public void setRemark(String remark){ 
		this.remark = remark;
	}
	/**
	 * @Description remark的中文含义是： 备注
	 */
	public String getRemark(){
		return remark;
	}
	/**
	 * @Description state的中文含义是： 状态 [0:添加 1:删除]
	 */
	public void setState(String state){ 
		this.state = state;
	}
	/**
	 * @Description state的中文含义是： 状态 [0:添加 1:删除]
	 */
	public String getState(){
		return state;
	}
	/**
	 * @Description opepateperson的中文含义是： 经办人
	 */
	public void setOpepateperson(String opepateperson){ 
		this.opepateperson = opepateperson;
	}
	/**
	 * @Description opepateperson的中文含义是： 经办人
	 */
	public String getOpepateperson(){
		return opepateperson;
	}
	/**
	 * @Description opepatedate的中文含义是： 经办时间
	 */
	public void setOpepatedate(String opepatedate){ 
		this.opepatedate = opepatedate;
	}
	/**
	 * @Description opepatedate的中文含义是： 经办时间
	 */
	public String getOpepatedate(){
		return opepatedate;
	}

	
}