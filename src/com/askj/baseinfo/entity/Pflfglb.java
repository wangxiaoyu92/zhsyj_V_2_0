package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PFLFGLB的中文含义是: 法律法规类别表; InnoDB free: 65536 kB
 * @Creation     2016/03/11 14:45:54
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PFLFGLB")
public class Pflfglb {
	//子节点数量,非映射字段
	@Column
	@Readonly
	private int childnum;
	//是否父节点,非映射字段
	@Column
	@Readonly
	private boolean isparent;
	//是否展开,非映射字段
	@Column
	@Readonly
	private boolean isopen;
	/**
	 * @Description flfglbid的中文含义是： 
	 */
	@Column
	@Name
	private String flfglbid;

	/**
	 * @Description flfglbjb的中文含义是： 类别级别0大类1小类
	 */
	@Column
	private String flfglbjb;

	/**
	 * @Description flfglbbm的中文含义是： 类别编码
	 */
	@Column
	private String flfglbbm;

	/**
	 * @Description flfglbmc的中文含义是： 类别名称
	 */
	@Column
	private String flfglbmc;

	/**
	 * @Description flfgczy的中文含义是： 操作员
	 */
	@Column
	private String flfgczy;

	/**
	 * @Description flfgczsj的中文含义是： 操作时间
	 */
	@Column
	private String flfgczsj;
	/**
	 * @Description parent的中文含义是：父类别ID
	 */
	@Column
	private Integer parentnode;
	
	/**
	 * @Description orderno的中文含义是：在同一机构中的序号
	 */
	@Column
	private Long orderno;
	
	public int getChildnum() {
		return childnum;
	}
	public void setChildnum(int childnum) {
		this.childnum = childnum;
	}
	public boolean getIsparent() {
		return isparent;
	}
	public void setIsparent(boolean isparent) {
		this.isparent = isparent;
	}
	public boolean getIsopen() {
		return isopen;
	}
	public void setIsopen(boolean isopen) {
		this.isopen = isopen;
	}

	public Integer getParentnode() {
		return parentnode;
	}
	public void setParentnode(Integer parentnode) {
		this.parentnode = parentnode;
	}
	public Long getOrderno() {
		return orderno;
	}
	public void setOrderno(Long orderno) {
		this.orderno = orderno;
	}
		/**
	 * @Description flfglbid的中文含义是： 
	 */
	public void setFlfglbid(String flfglbid){ 
		this.flfglbid = flfglbid;
	}
	/**
	 * @Description flfglbid的中文含义是： 
	 */
	public String getFlfglbid(){
		return flfglbid;
	}
	/**
	 * @Description flfglbjb的中文含义是： 类别级别0大类1小类
	 */
	public void setFlfglbjb(String flfglbjb){ 
		this.flfglbjb = flfglbjb;
	}
	/**
	 * @Description flfglbjb的中文含义是： 类别级别0大类1小类
	 */
	public String getFlfglbjb(){
		return flfglbjb;
	}
	/**
	 * @Description flfglbbm的中文含义是： 类别编码
	 */
	public void setFlfglbbm(String flfglbbm){ 
		this.flfglbbm = flfglbbm;
	}
	/**
	 * @Description flfglbbm的中文含义是： 类别编码
	 */
	public String getFlfglbbm(){
		return flfglbbm;
	}
	/**
	 * @Description flfglbmc的中文含义是： 类别名称
	 */
	public void setFlfglbmc(String flfglbmc){ 
		this.flfglbmc = flfglbmc;
	}
	/**
	 * @Description flfglbmc的中文含义是： 类别名称
	 */
	public String getFlfglbmc(){
		return flfglbmc;
	}
	/**
	 * @Description flfgczy的中文含义是： 操作员
	 */
	public void setFlfgczy(String flfgczy){ 
		this.flfgczy = flfgczy;
	}
	/**
	 * @Description flfgczy的中文含义是： 操作员
	 */
	public String getFlfgczy(){
		return flfgczy;
	}
	/**
	 * @Description flfgczsj的中文含义是： 操作时间
	 */
	public void setFlfgczsj(String flfgczsj){ 
		this.flfgczsj = flfgczsj;
	}
	/**
	 * @Description flfgczsj的中文含义是： 操作时间
	 */
	public String getFlfgczsj(){
		return flfgczsj;
	}

}