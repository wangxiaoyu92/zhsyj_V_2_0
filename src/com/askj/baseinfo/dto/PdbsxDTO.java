package com.askj.baseinfo.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PDBSX的中文含义是: 待办事项表; InnoDB free: 9216 kBDTO
 * @Creation     2016/10/09 17:16:21
 * @Written      Create Tool By zjf 
 **/
public class PdbsxDTO {
	/**
	 * @Description dokind的中文含义是：chayue查阅huifu回复
	 */
	private String dokind;
	
	/**
	 * @Description fsorgname的中文含义是： 发送人机构名称
	 */
	private String fsorgname;
	
	/**
	 * @Description jieshouren_table_rows的中文含义是： 
	 */
	private String jieshouren_table_rows;
	
	/**
	 * @Description pdbsxid的中文含义是： 
	 */
	private String pdbsxid;

	/**
	 * @Description qtbid的中文含义是： 
	 */
	private String qtbid;

	/**
	 * @Description fsuserid的中文含义是： 
	 */
	private String fsuserid;

	/**
	 * @Description fsusername的中文含义是： 
	 */
	private String fsusername;

	/**
	 * @Description fssj的中文含义是： 
	 */
	private String fssj;

	/**
	 * @Description fsnr的中文含义是： 
	 */
	private String fsnr;

	/**
	 * @Description fsxtbz的中文含义是： 
	 */
	private String fsxtbz;
	
	/**
	 * @Description pdbsxjsrid的中文含义是： 
	 */
	private String pdbsxjsrid;

	/**
	 * @Description pdbsxid的中文含义是： 
	 */
	//private String pdbsxid;

	/**
	 * @Description jsuserid的中文含义是： 
	 */
	private String jsuserid;

	/**
	 * @Description jsusername的中文含义是： 
	 */
	private String jsusername;

	/**
	 * @Description jsclyj的中文含义是： 
	 */
	private String jsclyj;

	/**
	 * @Description jssj的中文含义是： 
	 */
	private String jssj;
	/**
	 * @Description jsorgid的中文含义是： 接收人所属机构id
	 */
	private String jsorgid;
	
	/**
	 * @Description jsorgname的中文含义是： 接收人所属机构名称
	 */
	private String jsorgname;	
	/**
	 * @Description jsbz的中文含义是： 接收标志
	 */
	private String jsbz;	
	/**
	 * @Description hfid的中文含义是： 回复id
	 */
	private String hfid;		

	
		/**
	 * @Description pdbsxid的中文含义是： 
	 */
	public void setPdbsxid(String pdbsxid){ 
		this.pdbsxid = pdbsxid;
	}
	/**
	 * @Description pdbsxid的中文含义是： 
	 */
	public String getPdbsxid(){
		return pdbsxid;
	}
	/**
	 * @Description qtbid的中文含义是： 
	 */
	public void setQtbid(String qtbid){ 
		this.qtbid = qtbid;
	}
	/**
	 * @Description qtbid的中文含义是： 
	 */
	public String getQtbid(){
		return qtbid;
	}
	/**
	 * @Description fsuserid的中文含义是： 
	 */
	public void setFsuserid(String fsuserid){ 
		this.fsuserid = fsuserid;
	}
	/**
	 * @Description fsuserid的中文含义是： 
	 */
	public String getFsuserid(){
		return fsuserid;
	}
	/**
	 * @Description fsusername的中文含义是： 
	 */
	public void setFsusername(String fsusername){ 
		this.fsusername = fsusername;
	}
	/**
	 * @Description fsusername的中文含义是： 
	 */
	public String getFsusername(){
		return fsusername;
	}
	/**
	 * @Description fssj的中文含义是： 
	 */
	public void setFssj(String fssj){ 
		this.fssj = fssj;
	}
	/**
	 * @Description fssj的中文含义是： 
	 */
	public String getFssj(){
		return fssj;
	}
	/**
	 * @Description fsnr的中文含义是： 
	 */
	public void setFsnr(String fsnr){ 
		this.fsnr = fsnr;
	}
	/**
	 * @Description fsnr的中文含义是： 
	 */
	public String getFsnr(){
		return fsnr;
	}
	/**
	 * @Description fsxtbz的中文含义是： 
	 */
	public void setFsxtbz(String fsxtbz){ 
		this.fsxtbz = fsxtbz;
	}
	/**
	 * @Description fsxtbz的中文含义是： 
	 */
	public String getFsxtbz(){
		return fsxtbz;
	}
	public String getPdbsxjsrid() {
		return pdbsxjsrid;
	}
	public void setPdbsxjsrid(String pdbsxjsrid) {
		this.pdbsxjsrid = pdbsxjsrid;
	}
	public String getJsuserid() {
		return jsuserid;
	}
	public void setJsuserid(String jsuserid) {
		this.jsuserid = jsuserid;
	}
	public String getJsusername() {
		return jsusername;
	}
	public void setJsusername(String jsusername) {
		this.jsusername = jsusername;
	}
	public String getJsclyj() {
		return jsclyj;
	}
	public void setJsclyj(String jsclyj) {
		this.jsclyj = jsclyj;
	}
	public String getJssj() {
		return jssj;
	}
	public void setJssj(String jssj) {
		this.jssj = jssj;
	}
	public String getJsorgid() {
		return jsorgid;
	}
	public void setJsorgid(String jsorgid) {
		this.jsorgid = jsorgid;
	}
	public String getJsorgname() {
		return jsorgname;
	}
	public void setJsorgname(String jsorgname) {
		this.jsorgname = jsorgname;
	}
	public String getJieshouren_table_rows() {
		return jieshouren_table_rows;
	}
	public void setJieshouren_table_rows(String jieshouren_table_rows) {
		this.jieshouren_table_rows = jieshouren_table_rows;
	}
	public String getFsorgname() {
		return fsorgname;
	}
	public void setFsorgname(String fsorgname) {
		this.fsorgname = fsorgname;
	}
	public String getJsbz() {
		return jsbz;
	}
	public void setJsbz(String jsbz) {
		this.jsbz = jsbz;
	}
	public String getHfid() {
		return hfid;
	}
	public void setHfid(String hfid) {
		this.hfid = hfid;
	}
	public String getDokind() {
		return dokind;
	}
	public void setDokind(String dokind) {
		this.dokind = dokind;
	}
	
}