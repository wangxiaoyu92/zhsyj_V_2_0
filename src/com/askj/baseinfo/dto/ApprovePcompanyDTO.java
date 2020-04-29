package com.askj.baseinfo.dto;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description  ApprovePcompanyDTO的中文含义是: 审批企业数据表
 * @Creation     2017/09/07 10:32:29
 * @Written      zy
 **/
public class ApprovePcompanyDTO {	
    
	/** orderno 的中文含义是：序号*/
	private String orderno;
	
	/** comqyxz 的中文含义是：企业性质(经济性质)*/
	private String comqyxz;
	
	/** commc 的中文含义是：企业名称(经营者姓名)*/
	private String commc;
	
	/** comyyzzh 的中文含义是：营业执照号*/
	private String comyyzzh;
	
	/** comfrhyz 的中文含义是：企业法人/业主*/
	private String comfrhyz;
	
	/** comfrhyz 的中文含义是：住所*/
	private String frhyzzs;

	/** comdz 的中文含义是：企业地址(经营场所)*/
	private String comdz;
	
	/** comzmj 的中文含义是：总面积(经营面积)*/
	private BigDecimal comzmj;
	
	/** comxkzztyt 的中文含义是：主体业态(主体业态)*/
    private String comxkzztyt; 
    
    /** comxkfw 的中文含义是：许可范围(经营项目)*/
    private String comxkfw;
    
    /** comdmlx 的中文含义是：店面类型，代码表comdmlx如蛋糕店、火锅店(经营类别)*/
	private String comdmlx;
	
	/** comxkzbh 的中文含义是：许可证编号(许可证号)*/
	private String comxkzbh;
	
	/** orgid 的中文含义是：机构ID(监管机构id)*/
	private String orgid;
	
	/** orgname 的中文含义是：机构名称(监管机构名称)*/
	private String orgname;
	
	/** comrcjdglryid 的中文含义是：日常监管人员id*/
    private String comrcjdglryid;
    
    /** comrcjdglry 的中文含义是：日常监督管理人员*/
	private String comrcjdglry;
	
	/** comxkyxqq 的中文含义是：许可证有效期起(发证日期)*/
    private Date comxkyxqq;	
    
    /** comxkyxqz 的中文含义是：许可证有效期止(有效期至)*/
    private Date comxkyxqz;
	
    /** xkzorg 的中文含义是：许可证机构(发证机关)*/
	private String xkzorg;
	
	/** comyddh 的中文含义是：移动电话(联系电话)*/
	private String comyddh;
	
	/** comslrq 的中文含义是：受理日期*/
    private Timestamp comslrq;
    
	private String succJsonStr;
	
	private String errorJsonStr;
	
	private String message;
	
	public String getSuccJsonStr() {
		return succJsonStr;
	}

	public void setSuccJsonStr(String succJsonStr) {
		this.succJsonStr = succJsonStr;
	}

	public String getErrorJsonStr() {
		return errorJsonStr;
	}

	public void setErrorJsonStr(String errorJsonStr) {
		this.errorJsonStr = errorJsonStr;
	}
	public String getComxkzztyt() {
		return comxkzztyt;
	}
	public void setComxkzztyt(String comxkzztyt) {
		this.comxkzztyt = comxkzztyt;
	}
	public String getComrcjdglryid() {
		return comrcjdglryid;
	}
	public void setComrcjdglryid(String comrcjdglryid) {
		this.comrcjdglryid = comrcjdglryid;
	}

	public void setComxkzbh(String comxkzbh){
		this.comxkzbh=comxkzbh;
	}

	public String getComxkzbh(){
		return comxkzbh;
	}

	public void setCommc(String commc){
		this.commc=commc;
	}

	public String getCommc(){
		return commc;
	}

	public void setComfrhyz(String comfrhyz){
		this.comfrhyz=comfrhyz;
	}

	public String getComfrhyz(){
		return comfrhyz;
	}


	public void setComyddh(String comyddh){
		this.comyddh=comyddh;
	}

	public String getComyddh(){
		return comyddh;
	}

	public void setComdz(String comdz){
		this.comdz=comdz;
	}

	public String getComdz(){
		return comdz;
	}

	public void setComzmj(BigDecimal comzmj){
		this.comzmj=comzmj;
	}

	public BigDecimal getComzmj(){
		return comzmj;
	}

	public void setComdmlx(String comdmlx){
		this.comdmlx=comdmlx;
	}

	public String getComdmlx(){
		return comdmlx;
	}

	public void setComqyxz(String comqyxz){
		this.comqyxz=comqyxz;
	}

	public String getComqyxz(){
		return comqyxz;
	}

	public void setComrcjdglry(String comrcjdglry){
		this.comrcjdglry=comrcjdglry;
	}

	public String getComrcjdglry(){
		return comrcjdglry;
	}

	public void setOrgid(String orgid){
		this.orgid=orgid;
	}

	public Timestamp getComslrq() {
		return comslrq;
	}

	public void setComslrq(Timestamp comslrq) {
		this.comslrq = comslrq;
	}

	public String getOrgid(){
		return orgid;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getComxkfw() {
		return comxkfw;
	}

	public void setComxkfw(String comxkfw) {
		this.comxkfw = comxkfw;
	}

	public Date getComxkyxqq() {
		return comxkyxqq;
	}

	public void setComxkyxqq(Date comxkyxqq) {
		this.comxkyxqq = comxkyxqq;
	}

	public Date getComxkyxqz() {
		return comxkyxqz;
	}

	public void setComxkyxqz(Date comxkyxqz) {
		this.comxkyxqz = comxkyxqz;
	}

	public String getComyyzzh() {
		return comyyzzh;
	}

	public String getFrhyzzs() {
		return frhyzzs;
	}

	public String getOrgname() {
		return orgname;
	}

	public String getXkzorg() {
		return xkzorg;
	}

	public void setComyyzzh(String comyyzzh) {
		this.comyyzzh = comyyzzh;
	}

	public void setFrhyzzs(String frhyzzs) {
		this.frhyzzs = frhyzzs;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public void setXkzorg(String xkzorg) {
		this.xkzorg = xkzorg;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}