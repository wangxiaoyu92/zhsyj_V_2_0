package com.askj.baseinfo.dto;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Readonly;


/**
 * @Description  PFLFGLB的中文含义是: 法律法规类别表; InnoDB free: 65536 kBDTO
 * @Creation     2016/03/11 14:37:42
 * @Written      Create Tool By zjf 
 **/
public class PflfglbDTO {
	//子节点数量,非映射字段
	private int childnum;
	//是否父节点,非映射字段
	private boolean isparent;
	//是否展开,非映射字段
	private boolean isopen;
	/**
	 * @Description flfglbid的中文含义是： 
	 */
	private String flfglbid;

	/**
	 * @Description flfglbjb的中文含义是： 类别级别0大类1小类
	 */
	private String flfglbjb;

	/**
	 * @Description flfglbbm的中文含义是： 类别编码
	 */
	private String flfglbbm;

	/**
	 * @Description flfglbmc的中文含义是： 类别名称
	 */
	private String flfglbmc;

	/**
	 * @Description flfgczy的中文含义是： 操作员
	 */
	private String flfgczy;

	/**
	 * @Description flfgczsj的中文含义是： 操作时间
	 */
	private String flfgczsj;
	
	/**
	 * @Description parent的中文含义是：父类别ID
	 */
	private Integer parentnode;
	
	/**
	 * @Description orderno的中文含义是：在同一机构中的序号
	 */
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
	
	public String getFlfglbid() {
		return flfglbid;
	}
	public void setFlfglbid(String flfglbid) {
		this.flfglbid = flfglbid;
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