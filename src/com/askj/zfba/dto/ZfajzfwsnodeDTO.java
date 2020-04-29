package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFAJZFWSNODE的中文含义是: 执法案件执法文书和流程节点对照表; InnoDB free: 2754560 kBDTO
 * @Creation     2016/04/21 15:35:16
 * @Written      Create Tool By zjf 
 **/
public class ZfajzfwsnodeDTO {
	/**
	 * @Description zfajzfwsnodeid的中文含义是： 执法案件执法文书和流程节点对照表ID
	 */
	private String zfajzfwsnodeid;

	/**
	 * @Description psbh的中文含义是： 流程编码
	 */
	private String psbh;

	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	private Long nodeid;

	/**
	 * @Description zfwsdmz的中文含义是： 执法文书编号，代码表中的编号
	 */
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
	public void setNodeid(Long nodeid){ 
		this.nodeid = nodeid;
	}
	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	public Long getNodeid(){
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