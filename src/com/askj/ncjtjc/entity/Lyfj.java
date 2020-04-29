package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import java.io.InputStream;

/**
 * @Description LYFJ的中文含义是: 两员附件表
 * @Creation 2016/07/25 15:54:01
 * @Written Create Tool By sunyifeng
 **/
@Table(value = "LYFJ")
public class Lyfj {
	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	@Column
	@Id(auto = false)
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_fjid')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_fjid.nextval from dual"))
	private Long fjid;

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	@Column
	private String fjname;

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	@Column
	private String fjpath;

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	@Column
	private String fjtype;

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	@Column
	private InputStream fjcontent;

	/**
	 * @Description lsid的中文含义是： 附件所属两员ID
	 */
	@Column
	private String lyid;

	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	public void setFjid(Long fjid) {
		this.fjid = fjid;
	}

	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	public Long getFjid() {
		return fjid;
	}

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	public void setFjname(String fjname) {
		this.fjname = fjname;
	}

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	public String getFjname() {
		return fjname;
	}

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
	}

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	public String getFjpath() {
		return fjpath;
	}

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	public void setFjtype(String fjtype) {
		this.fjtype = fjtype;
	}

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	public String getFjtype() {
		return fjtype;
	}

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public void setFjcontent(InputStream fjcontent) {
		this.fjcontent = fjcontent;
	}

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public InputStream getFjcontent() {
		return fjcontent;
	}

	/**
	 * @Description lsid的中文含义是： 附件所属两员ID
	 */
	public void setLyid(String lyid) {
		this.lyid = lyid;
	}

	/**
	 * @Description lsid的中文含义是： 附件所属两员ID
	 */
	public String getLyid() {
		return lyid;
	}

}