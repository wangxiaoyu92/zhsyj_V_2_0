package com.askj.baseinfo.entity;

import java.io.InputStream;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  PFJ的中文含义是: 通用附件表(一般涉及附件的都要放到本表); InnoDB free: 11264 kB
 * @Creation     2016/02/01 16:06:40
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PFJ")
public class Pfj {
	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	@Column
	@Name
	private String fjid;

	/**
	 * @Description fjcsdmz的中文含义是： 对应PFJCS表字段
	 */
	@Column
	private String fjcsdmz;

	/**
	 * @Description fjwid的中文含义是： 本表和其他表的关联ID
	 */
	@Column
	private String fjwid;

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	@Column
	private String fjpath;

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	@Column
	private InputStream fjcontent;

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档 
	 */
	@Column
	private String fjtype;

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	@Column
	private String fjname;
	
	
	/**
	 * @Description fjuserid的中文含义是： 附件userid
	 */
	@Column
	private String fjuserid;

	/**
	 * @Description fjczyxm的中文含义是：附件操作员姓名
	 */
	@Column
	private String fjczyxm;

	/**
	 * @Description fjczsj的中文含义是： 操作时间
	 */
	@Column
	private String fjczsj;
	

	
		/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	public void setFjid(String fjid){ 
		this.fjid = fjid;
	}
	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	public String getFjid(){
		return fjid;
	}
	/**
	 * @Description fjcsdmz的中文含义是： 对应PFJCS表字段
	 */
	public void setFjcsdmz(String fjcsdmz){ 
		this.fjcsdmz = fjcsdmz;
	}
	/**
	 * @Description fjcsdmz的中文含义是： 对应PFJCS表字段
	 */
	public String getFjcsdmz(){
		return fjcsdmz;
	}
	/**
	 * @Description fjwid的中文含义是： 本表和其他表的关联ID
	 */
	public void setFjwid(String fjwid){ 
		this.fjwid = fjwid;
	}
	/**
	 * @Description fjwid的中文含义是： 本表和其他表的关联ID
	 */
	public String getFjwid(){
		return fjwid;
	}
	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	public void setFjpath(String fjpath){ 
		this.fjpath = fjpath;
	}
	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	public String getFjpath(){
		return fjpath;
	}
	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public void setFjcontent(InputStream fjcontent){ 
		this.fjcontent = fjcontent;
	}
	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public InputStream getFjcontent(){
		return fjcontent;
	}
	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档 
	 */
	public void setFjtype(String fjtype){ 
		this.fjtype = fjtype;
	}
	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档 
	 */
	public String getFjtype(){
		return fjtype;
	}
	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	public void setFjname(String fjname){ 
		this.fjname = fjname;
	}
	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	public String getFjname(){
		return fjname;
	}
	public String getFjuserid() {
		return fjuserid;
	}
	public void setFjuserid(String fjuserid) {
		this.fjuserid = fjuserid;
	}
	public String getFjczyxm() {
		return fjczyxm;
	}
	public void setFjczyxm(String fjczyxm) {
		this.fjczyxm = fjczyxm;
	}
	public String getFjczsj() {
		return fjczsj;
	}
	public void setFjczsj(String fjczsj) {
		this.fjczsj = fjczsj;
	}

	
}