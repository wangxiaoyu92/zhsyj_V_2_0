package com.zzhdsoft.siweb.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  FJ的中文含义是: 附件表DTO
 * @Creation     2016/07/27 10:30:27
 * @Written      Create Tool By zjf 
 **/
public class FjDTO {
	/** FJCSDMZ 的中文含义是：对应PFJCS表字段*/
	private String fjcsdmz;

	/** fjuserid 的中文含义是：附件userid*/
	private String fjuserid;

	/** fjczyxm 的中文含义是：操作员姓名*/
	private String fjczyxm;

	/** fjczsj 的中文含义是：操作时间*/
	private Timestamp fjczsj;
	/**
	 * @Description uploadone的中文含义是： 每次上传单个文件
	 */
	private String uploadone;	
	
	/**
	 * @Description folderName的中文含义是： 文件存放的文件夹名
	 */
	private String folderName;	
	
	/**
	 * @Description fjid的中文含义是： 返回的附件外id
	 */
	private String fjwidret;
	/**
	 * @Description fjid的中文含义是： 返回的附件路径
	 */
	private String fjpathret;
	
	
	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	private String fjid;

	/**
	 * @Description fjwid的中文含义是： 附件所属表ID
	 */
	private String fjwid;

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	private String fjpath;

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	private String fjcontent;

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档 
	 */
	private String fjtype;

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	private String fjname;

	
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
	 * @Description fjwid的中文含义是： 附件所属表ID
	 */
	public void setFjwid(String fjwid){ 
		this.fjwid = fjwid;
	}
	/**
	 * @Description fjwid的中文含义是： 附件所属表ID
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
	public void setFjcontent(String fjcontent){ 
		this.fjcontent = fjcontent;
	}
	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public String getFjcontent(){
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
	public String getFjwidret() {
		return fjwidret;
	}
	public void setFjwidret(String fjwidret) {
		this.fjwidret = fjwidret;
	}
	public String getFjpathret() {
		return fjpathret;
	}
	public void setFjpathret(String fjpathret) {
		this.fjpathret = fjpathret;
	}
	public String getFolderName() {
		return folderName;
	}
	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}
	public String getUploadone() {
		return uploadone;
	}
	public void setUploadone(String uploadone) {
		this.uploadone = uploadone;
	}
	public String getFjcsdmz() {
		return fjcsdmz;
	}
	public String getFjuserid() {
		return fjuserid;
	}
	public String getFjczyxm() {
		return fjczyxm;
	}
	public void setFjczyxm(String fjczyxm) {
		this.fjczyxm = fjczyxm;
	}
	public void setFjuserid(String fjuserid) {
		this.fjuserid = fjuserid;
	}
	public void setFjczsj(Timestamp fjczsj) {
		this.fjczsj = fjczsj;
	}
	public Timestamp getFjczsj() {
		return fjczsj;
	}
	public void setFjcsdmz(String fjcsdmz) {
		this.fjcsdmz = fjcsdmz;
	}
}