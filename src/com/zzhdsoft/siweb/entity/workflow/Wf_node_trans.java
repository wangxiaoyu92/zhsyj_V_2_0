package com.zzhdsoft.siweb.entity.workflow;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  WF_NODE_TRANS的中文含义是: 节点流向表
 * @Creation     2016/03/18 17:38:46
 * @Written      Create Tool By zjf 
 **/
@Table(value = "WF_NODE_TRANS")
public class Wf_node_trans {
	/**
	 * @Description nodetransid的中文含义是： 节点流向表ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_nodetransid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_nodetransid.nextval from dual"))
	private String nodetransid;

	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	@Column
	private String psbh;

	/**
	 * @Description transid的中文含义是： 流向ID
	 */
	@Column
	private String transid;

	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	@Column
	private String transname;

	/**
	 * @Description transval的中文含义是： 流向值
	 */
	@Column
	private String transval;

	/**
	 * @Description transfrom的中文含义是： 流向from
	 */
	@Column
	private String transfrom;

	/**
	 * @Description transto的中文含义是： 流向to
	 */
	@Column
	private String transto;

	
		/**
	 * @Description nodetransid的中文含义是： 节点流向表ID
	 */
	public void setNodetransid(String nodetransid){ 
		this.nodetransid = nodetransid;
	}
	/**
	 * @Description nodetransid的中文含义是： 节点流向表ID
	 */
	public String getNodetransid(){
		return nodetransid;
	}
	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	public void setPsbh(String psbh){ 
		this.psbh = psbh;
	}
	/**
	 * @Description psbh的中文含义是： 工作流编号
	 */
	public String getPsbh(){
		return psbh;
	}
	/**
	 * @Description transid的中文含义是： 流向ID
	 */
	public void setTransid(String transid){ 
		this.transid = transid;
	}
	/**
	 * @Description transid的中文含义是： 流向ID
	 */
	public String getTransid(){
		return transid;
	}
	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	public void setTransname(String transname){ 
		this.transname = transname;
	}
	/**
	 * @Description transname的中文含义是： 流向名称
	 */
	public String getTransname(){
		return transname;
	}
	/**
	 * @Description transval的中文含义是： 流向值
	 */
	public void setTransval(String transval){ 
		this.transval = transval;
	}
	/**
	 * @Description transval的中文含义是： 流向值
	 */
	public String getTransval(){
		return transval;
	}
	/**
	 * @Description transfrom的中文含义是： 流向from
	 */
	public void setTransfrom(String transfrom){ 
		this.transfrom = transfrom;
	}
	/**
	 * @Description transfrom的中文含义是： 流向from
	 */
	public String getTransfrom(){
		return transfrom;
	}
	/**
	 * @Description transto的中文含义是： 流向to
	 */
	public void setTransto(String transto){ 
		this.transto = transto;
	}
	/**
	 * @Description transto的中文含义是： 流向to
	 */
	public String getTransto(){
		return transto;
	}

	
}