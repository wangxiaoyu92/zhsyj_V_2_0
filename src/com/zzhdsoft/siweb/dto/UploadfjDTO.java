package com.zzhdsoft.siweb.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PFJ的中文含义是: 通用附件表(一般涉及附件的都要放到本表); InnoDB free: 11264 kBDTO
 * @Creation     2016/02/01 14:06:06
 * @Written      Create Tool By zjf 
 **/
public class UploadfjDTO {
	//扩展开始
	//扩展结束
	/**
	 * @Description fjpath的中文含义是： 图片文件路径和姓名
	 */
	private String picFilePathAndName;	
	/**
	 * @Description fjuserid的中文含义是： 附件userid
	 */
	private String fjuserid;

	/**
	 * @Description fjczyxm的中文含义是：附件操作员姓名
	 */
	private String fjczyxm;

	/**
	 * @Description fjczsj的中文含义是： 操作时间
	 */
	private String fjczsj;	
	
	
	
	/**
	 * @Description ajdjid的中文含义是：案件登记ID 
	 */
	private String ajdjid;
	/**
	 * @Description ycfjcount的中文含义是： 已传附件数
	 */
	private Long ycfjcount;	
	
	
	
	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	private String fjid;

	/**
	 * @Description fjcsdmz的中文含义是： 对应PFJCS表字段
	 */
	//private String fjcsdmz;

	/**
	 * @Description fjwid的中文含义是： 本表和其他表的关联ID
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
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	private String fjcsid;

	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	private String fjcsdmlb;

	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	private String fjcsdmlbmc;

	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	private String fjcsdmz;

	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	private String fjcsdmmc;

	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	private String fjcsksrq;

	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	private String fjcszzrq;

	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	private String fjcsqyflag;

	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	private String fjcsfjbc;
	
	/**
	 * @Description fjcsdlbh的中文含义是： 附件参数大类编号
	 */
	private String fjcsdlbh;
	
	/**
	 * @Description fjcsdlmc的中文含义是： 附件参数大类名称
	 */
	private String fjcsdlmc;
	
	
	
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
	
	public String getPicFilePathAndName() {
		return picFilePathAndName;
	}
	public void setPicFilePathAndName(String picFilePathAndName) {
		this.picFilePathAndName = picFilePathAndName;
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
	public Long getYcfjcount() {
		return ycfjcount;
	}
	public void setYcfjcount(Long ycfjcount) {
		this.ycfjcount = ycfjcount;
	}
	public String getFjcsid() {
		return fjcsid;
	}
	public void setFjcsid(String fjcsid) {
		this.fjcsid = fjcsid;
	}
	public String getFjcsdmlb() {
		return fjcsdmlb;
	}
	public void setFjcsdmlb(String fjcsdmlb) {
		this.fjcsdmlb = fjcsdmlb;
	}
	public String getFjcsdmlbmc() {
		return fjcsdmlbmc;
	}
	public void setFjcsdmlbmc(String fjcsdmlbmc) {
		this.fjcsdmlbmc = fjcsdmlbmc;
	}
	public String getFjcsdmz() {
		return fjcsdmz;
	}
	public void setFjcsdmz(String fjcsdmz) {
		this.fjcsdmz = fjcsdmz;
	}
	public String getFjcsdmmc() {
		return fjcsdmmc;
	}
	public void setFjcsdmmc(String fjcsdmmc) {
		this.fjcsdmmc = fjcsdmmc;
	}
	public String getFjcsksrq() {
		return fjcsksrq;
	}
	public void setFjcsksrq(String fjcsksrq) {
		this.fjcsksrq = fjcsksrq;
	}
	public String getFjcszzrq() {
		return fjcszzrq;
	}
	public void setFjcszzrq(String fjcszzrq) {
		this.fjcszzrq = fjcszzrq;
	}
	public String getFjcsqyflag() {
		return fjcsqyflag;
	}
	public void setFjcsqyflag(String fjcsqyflag) {
		this.fjcsqyflag = fjcsqyflag;
	}
	public String getFjcsfjbc() {
		return fjcsfjbc;
	}
	public void setFjcsfjbc(String fjcsfjbc) {
		this.fjcsfjbc = fjcsfjbc;
	}
	public String getAjdjid() {
		return ajdjid;
	}
	public void setAjdjid(String ajdjid) {
		this.ajdjid = ajdjid;
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
	public String getFjcsdlbh() {
		return fjcsdlbh;
	}
	public void setFjcsdlbh(String fjcsdlbh) {
		this.fjcsdlbh = fjcsdlbh;
	}
	public String getFjcsdlmc() {
		return fjcsdlmc;
	}
	public void setFjcsdlmc(String fjcsdlmc) {
		this.fjcsdlmc = fjcsdlmc;
	}
	
}