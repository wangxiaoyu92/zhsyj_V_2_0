package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFAJZFWSNODE的中文含义是: 执法案件执法文书和流程节点对照表; InnoDB free: 2754560 kB
 * @Creation     2016/04/21 15:34:58
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFAJZFWSNODE")
public class Zfajzfwsnode {
	/**
	 * @Description zfajzfwsnodeid的中文含义是： 执法案件执法文书和流程节点对照表ID
	 */
	@Column
	@Name
	private String zfajzfwsnodeid;

	/**
	 * @Description psbh的中文含义是： 流程编码
	 */
	@Column
	private String psbh;

	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	@Column
	private String nodeid;

	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	@Column
	private String zfwsdmz;

	
		/**
	 * @Description zfajzfwsnodeid的中文含义是： 执法案件执法文书和流程节点对照表ID
	 */
	public void setZfajzfwsnodeid(String zfajzfwsnodeid){ 
		this.zfajzfwsnodeid = zfajzfwsnodeid;
	}
	/**
	 * @Description zfajzfwsnodeid的中文含义是： 执法案件执法文书和流程节点对照表ID
	 */
	public String getZfajzfwsnodeid(){
		return zfajzfwsnodeid;
	}
	/**
	 * @Description psbh的中文含义是： 流程编码
	 */
	public void setPsbh(String psbh){ 
		this.psbh = psbh;
	}
	/**
	 * @Description psbh的中文含义是： 流程编码
	 */
	public String getPsbh(){
		return psbh;
	}
	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	public void setNodeid(String nodeid){ 
		this.nodeid = nodeid;
	}
	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	public String getNodeid(){
		return nodeid;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	public void setZfwsdmz(String zfwsdmz){ 
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
	public String getZfwsdmz(){
		return zfwsdmz;
	}

	
}