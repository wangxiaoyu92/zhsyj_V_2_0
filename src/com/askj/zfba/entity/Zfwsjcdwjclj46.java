package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

import java.util.Date;

/**
 * @Description  JCDWJCLJ46的中文含义是: 稽查队文件处理笺（jian）
 * @Creation     2016/09/29 10:25:03
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSJCDWJCLJ46")
public class Zfwsjcdwjclj46 {
	/**
	 * @Description jcwjclid的中文含义是： 稽查队文件处理笺id
	 */
	@Name
	@Column
	private String jcwjclid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	@Column
	private String ajdjid;
	/**
	 * @Description jcwjclwjbh的中文含义是： 稽查队文件处理笺文件编号
	 */
	@Column
	private String jcwjclwjbh;

	/**
	 * @Description jcwjclwjsxh的中文含义是： 稽查队文件处理笺文件顺序号
	 */
	@Column
	private String jcwjclwjsxh;

	/**
	 * @Description jcwjclwjsdrq的中文含义是： 稽查队文件处理笺文件收到日期
	 */
	@Column
	private Date jcwjclwjsdrq;

	/**
	 * @Description jcwjclwjbt的中文含义是： 稽查队文件处理笺文件标题
	 */
	@Column
	private String jcwjclwjbt;

	/**
	 * @Description jcwjclldps的中文含义是： 稽查队文件处理笺领导批示
	 */
	@Column
	private String jcwjclldps;

	/**
	 * @Description jcwjclyzqm1的中文含义是： 稽查队文件处理笺阅者签名1
	 */
	@Column
	private String jcwjclyzqm1;

	/**
	 * @Description jcwjclyzqm2的中文含义是： 稽查队文件处理笺阅者签名2
	 */
	@Column
	private String jcwjclyzqm2;

	/**
	 * @Description jcwjclyzqm3的中文含义是： 稽查队文件处理笺阅者签名3
	 */
	@Column
	private String jcwjclyzqm3;

	/**
	 * @Description jcwjclyzqm4的中文含义是： 稽查队文件处理笺阅者签名4
	 */
	@Column
	private String jcwjclyzqm4;

	/**
	 * @Description jcwjclyzqm5的中文含义是： 稽查队文件处理笺阅者签名5
	 */
	@Column
	private String jcwjclyzqm5;

	/**
	 * @Description jcwjclyzqm6的中文含义是： 稽查队文件处理笺阅者签名6
	 */
	@Column
	private String jcwjclyzqm6;

	/**
	 * @Description jcwjclyzqm7的中文含义是： 稽查队文件处理笺阅者签名7
	 */
	@Column
	private String jcwjclyzqm7;

	/**
	 * @Description jcwjclyzqm8的中文含义是： 稽查队文件处理笺阅者签名8
	 */
	@Column
	private String jcwjclyzqm8;

	/**
	 * @Description jcwjclyzqm9的中文含义是： 稽查队文件处理笺阅者签名9
	 */
	@Column
	private String jcwjclyzqm9;

	/**
	 * @Description jcwjclyzqm10的中文含义是： 稽查队文件处理笺阅者签名10
	 */
	@Column
	private String jcwjclyzqm10;

	/**
	 * @Description jcwjclyzqmrq1的中文含义是： 稽查队文件处理笺阅者签名日期1
	 */
	@Column
	private Date jcwjclyzqmrq1;

	/**
	 * @Description jcwjclyzqmrq2的中文含义是： 稽查队文件处理笺阅者签名日期2
	 */
	@Column
	private Date jcwjclyzqmrq2;

	/**
	 * @Description jcwjclyzqmrq3的中文含义是： 稽查队文件处理笺阅者签名日期3
	 */
	@Column
	private Date jcwjclyzqmrq3;

	/**
	 * @Description jcwjclyzqmrq4的中文含义是： 稽查队文件处理笺阅者签名日期4
	 */
	@Column
	private Date jcwjclyzqmrq4;

	/**
	 * @Description jcwjclyzqmrq5的中文含义是： 稽查队文件处理笺阅者签名日期5
	 */
	@Column
	private Date jcwjclyzqmrq5;

	/**
	 * @Description jcwjclyzqmrq6的中文含义是： 稽查队文件处理笺阅者签名日期6
	 */
	@Column
	private Date jcwjclyzqmrq6;

	/**
	 * @Description jcwjclyzqmrq7的中文含义是： 稽查队文件处理笺阅者签名日期7
	 */
	@Column
	private Date jcwjclyzqmrq7;

	/**
	 * @Description jcwjclyzqmrq8的中文含义是： 稽查队文件处理笺阅者签名日期8
	 */
	@Column
	private Date jcwjclyzqmrq8;

	/**
	 * @Description jcwjclyzqmrq9的中文含义是： 稽查队文件处理笺阅者签名日期9
	 */
	@Column
	private Date jcwjclyzqmrq9;

	/**
	 * @Description jcwjclyzqmrq10的中文含义是： 稽查队文件处理笺阅者签名日期10
	 */
	@Column
	private Date jcwjclyzqmrq10;

	/**
	 * @Description jcwjclbz的中文含义是： 稽查队文件处理笺备注
	 */
	@Column
	private String jcwjclbz;

	
		/**
	 * @Description jcwjclid的中文含义是： 稽查队文件处理笺id
	 */
	public void setJcwjclid(String jcwjclid){ 
		this.jcwjclid = jcwjclid;
	}
	/**
	 * @Description jcwjclid的中文含义是： 稽查队文件处理笺id
	 */
	public String getJcwjclid(){
		return jcwjclid;
	}
	/**
	 * @Description jcwjclwjbh的中文含义是： 稽查队文件处理笺文件编号
	 */
	public void setJcwjclwjbh(String jcwjclwjbh){ 
		this.jcwjclwjbh = jcwjclwjbh;
	}
	/**
	 * @Description ajdjid的中文含义是： 稽查队文件处理笺文件编号
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description jcwjclwjbh的中文含义是： 稽查队文件处理笺文件编号
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description jcwjclwjbh的中文含义是： 稽查队文件处理笺文件编号
	 */
	public String getJcwjclwjbh(){
		return jcwjclwjbh;
	}
	/**
	 * @Description jcwjclwjsxh的中文含义是： 稽查队文件处理笺文件顺序号
	 */
	public void setJcwjclwjsxh(String jcwjclwjsxh){ 
		this.jcwjclwjsxh = jcwjclwjsxh;
	}
	/**
	 * @Description jcwjclwjsxh的中文含义是： 稽查队文件处理笺文件顺序号
	 */
	public String getJcwjclwjsxh(){
		return jcwjclwjsxh;
	}
	/**
	 * @Description jcwjclwjsdrq的中文含义是： 稽查队文件处理笺文件收到日期
	 */
	public void setJcwjclwjsdrq(Date jcwjclwjsdrq){
		this.jcwjclwjsdrq = jcwjclwjsdrq;
	}
	/**
	 * @Description jcwjclwjsdrq的中文含义是： 稽查队文件处理笺文件收到日期
	 */
	public Date getJcwjclwjsdrq(){
		return jcwjclwjsdrq;
	}
	/**
	 * @Description jcwjclwjbt的中文含义是： 稽查队文件处理笺文件标题
	 */
	public void setJcwjclwjbt(String jcwjclwjbt){ 
		this.jcwjclwjbt = jcwjclwjbt;
	}
	/**
	 * @Description jcwjclwjbt的中文含义是： 稽查队文件处理笺文件标题
	 */
	public String getJcwjclwjbt(){
		return jcwjclwjbt;
	}
	/**
	 * @Description jcwjclldps的中文含义是： 稽查队文件处理笺领导批示
	 */
	public void setJcwjclldps(String jcwjclldps){ 
		this.jcwjclldps = jcwjclldps;
	}
	/**
	 * @Description jcwjclldps的中文含义是： 稽查队文件处理笺领导批示
	 */
	public String getJcwjclldps(){
		return jcwjclldps;
	}
	/**
	 * @Description jcwjclyzqm1的中文含义是： 稽查队文件处理笺阅者签名1
	 */
	public void setJcwjclyzqm1(String jcwjclyzqm1){ 
		this.jcwjclyzqm1 = jcwjclyzqm1;
	}
	/**
	 * @Description jcwjclyzqm1的中文含义是： 稽查队文件处理笺阅者签名1
	 */
	public String getJcwjclyzqm1(){
		return jcwjclyzqm1;
	}
	/**
	 * @Description jcwjclyzqm2的中文含义是： 稽查队文件处理笺阅者签名2
	 */
	public void setJcwjclyzqm2(String jcwjclyzqm2){ 
		this.jcwjclyzqm2 = jcwjclyzqm2;
	}
	/**
	 * @Description jcwjclyzqm2的中文含义是： 稽查队文件处理笺阅者签名2
	 */
	public String getJcwjclyzqm2(){
		return jcwjclyzqm2;
	}
	/**
	 * @Description jcwjclyzqm3的中文含义是： 稽查队文件处理笺阅者签名3
	 */
	public void setJcwjclyzqm3(String jcwjclyzqm3){ 
		this.jcwjclyzqm3 = jcwjclyzqm3;
	}
	/**
	 * @Description jcwjclyzqm3的中文含义是： 稽查队文件处理笺阅者签名3
	 */
	public String getJcwjclyzqm3(){
		return jcwjclyzqm3;
	}
	/**
	 * @Description jcwjclyzqm4的中文含义是： 稽查队文件处理笺阅者签名4
	 */
	public void setJcwjclyzqm4(String jcwjclyzqm4){ 
		this.jcwjclyzqm4 = jcwjclyzqm4;
	}
	/**
	 * @Description jcwjclyzqm4的中文含义是： 稽查队文件处理笺阅者签名4
	 */
	public String getJcwjclyzqm4(){
		return jcwjclyzqm4;
	}
	/**
	 * @Description jcwjclyzqm5的中文含义是： 稽查队文件处理笺阅者签名5
	 */
	public void setJcwjclyzqm5(String jcwjclyzqm5){ 
		this.jcwjclyzqm5 = jcwjclyzqm5;
	}
	/**
	 * @Description jcwjclyzqm5的中文含义是： 稽查队文件处理笺阅者签名5
	 */
	public String getJcwjclyzqm5(){
		return jcwjclyzqm5;
	}
	/**
	 * @Description jcwjclyzqm6的中文含义是： 稽查队文件处理笺阅者签名6
	 */
	public void setJcwjclyzqm6(String jcwjclyzqm6){ 
		this.jcwjclyzqm6 = jcwjclyzqm6;
	}
	/**
	 * @Description jcwjclyzqm6的中文含义是： 稽查队文件处理笺阅者签名6
	 */
	public String getJcwjclyzqm6(){
		return jcwjclyzqm6;
	}
	/**
	 * @Description jcwjclyzqm7的中文含义是： 稽查队文件处理笺阅者签名7
	 */
	public void setJcwjclyzqm7(String jcwjclyzqm7){ 
		this.jcwjclyzqm7 = jcwjclyzqm7;
	}
	/**
	 * @Description jcwjclyzqm7的中文含义是： 稽查队文件处理笺阅者签名7
	 */
	public String getJcwjclyzqm7(){
		return jcwjclyzqm7;
	}
	/**
	 * @Description jcwjclyzqm8的中文含义是： 稽查队文件处理笺阅者签名8
	 */
	public void setJcwjclyzqm8(String jcwjclyzqm8){ 
		this.jcwjclyzqm8 = jcwjclyzqm8;
	}
	/**
	 * @Description jcwjclyzqm8的中文含义是： 稽查队文件处理笺阅者签名8
	 */
	public String getJcwjclyzqm8(){
		return jcwjclyzqm8;
	}
	/**
	 * @Description jcwjclyzqm9的中文含义是： 稽查队文件处理笺阅者签名9
	 */
	public void setJcwjclyzqm9(String jcwjclyzqm9){ 
		this.jcwjclyzqm9 = jcwjclyzqm9;
	}
	/**
	 * @Description jcwjclyzqm9的中文含义是： 稽查队文件处理笺阅者签名9
	 */
	public String getJcwjclyzqm9(){
		return jcwjclyzqm9;
	}
	/**
	 * @Description jcwjclyzqm10的中文含义是： 稽查队文件处理笺阅者签名10
	 */
	public void setJcwjclyzqm10(String jcwjclyzqm10){ 
		this.jcwjclyzqm10 = jcwjclyzqm10;
	}
	/**
	 * @Description jcwjclyzqm10的中文含义是： 稽查队文件处理笺阅者签名10
	 */
	public String getJcwjclyzqm10(){
		return jcwjclyzqm10;
	}
	/**
	 * @Description jcwjclyzqmrq1的中文含义是： 稽查队文件处理笺阅者签名日期1
	 */
	public void setJcwjclyzqmrq1(Date jcwjclyzqmrq1){
		this.jcwjclyzqmrq1 = jcwjclyzqmrq1;
	}
	/**
	 * @Description jcwjclyzqmrq1的中文含义是： 稽查队文件处理笺阅者签名日期1
	 */
	public Date getJcwjclyzqmrq1(){
		return jcwjclyzqmrq1;
	}
	/**
	 * @Description jcwjclyzqmrq2的中文含义是： 稽查队文件处理笺阅者签名日期2
	 */
	public void setJcwjclyzqmrq2(Date jcwjclyzqmrq2){
		this.jcwjclyzqmrq2 = jcwjclyzqmrq2;
	}
	/**
	 * @Description jcwjclyzqmrq2的中文含义是： 稽查队文件处理笺阅者签名日期2
	 */
	public Date getJcwjclyzqmrq2(){
		return jcwjclyzqmrq2;
	}
	/**
	 * @Description jcwjclyzqmrq3的中文含义是： 稽查队文件处理笺阅者签名日期3
	 */
	public void setJcwjclyzqmrq3(Date jcwjclyzqmrq3){
		this.jcwjclyzqmrq3 = jcwjclyzqmrq3;
	}
	/**
	 * @Description jcwjclyzqmrq3的中文含义是： 稽查队文件处理笺阅者签名日期3
	 */
	public Date getJcwjclyzqmrq3(){
		return jcwjclyzqmrq3;
	}
	/**
	 * @Description jcwjclyzqmrq4的中文含义是： 稽查队文件处理笺阅者签名日期4
	 */
	public void setJcwjclyzqmrq4(Date jcwjclyzqmrq4){
		this.jcwjclyzqmrq4 = jcwjclyzqmrq4;
	}
	/**
	 * @Description jcwjclyzqmrq4的中文含义是： 稽查队文件处理笺阅者签名日期4
	 */
	public Date getJcwjclyzqmrq4(){
		return jcwjclyzqmrq4;
	}
	/**
	 * @Description jcwjclyzqmrq5的中文含义是： 稽查队文件处理笺阅者签名日期5
	 */
	public void setJcwjclyzqmrq5(Date jcwjclyzqmrq5){
		this.jcwjclyzqmrq5 = jcwjclyzqmrq5;
	}
	/**
	 * @Description jcwjclyzqmrq5的中文含义是： 稽查队文件处理笺阅者签名日期5
	 */
	public Date getJcwjclyzqmrq5(){
		return jcwjclyzqmrq5;
	}
	/**
	 * @Description jcwjclyzqmrq6的中文含义是： 稽查队文件处理笺阅者签名日期6
	 */
	public void setJcwjclyzqmrq6(Date jcwjclyzqmrq6){
		this.jcwjclyzqmrq6 = jcwjclyzqmrq6;
	}
	/**
	 * @Description jcwjclyzqmrq6的中文含义是： 稽查队文件处理笺阅者签名日期6
	 */
	public Date getJcwjclyzqmrq6(){
		return jcwjclyzqmrq6;
	}
	/**
	 * @Description jcwjclyzqmrq7的中文含义是： 稽查队文件处理笺阅者签名日期7
	 */
	public void setJcwjclyzqmrq7(Date jcwjclyzqmrq7){
		this.jcwjclyzqmrq7 = jcwjclyzqmrq7;
	}
	/**
	 * @Description jcwjclyzqmrq7的中文含义是： 稽查队文件处理笺阅者签名日期7
	 */
	public Date getJcwjclyzqmrq7(){
		return jcwjclyzqmrq7;
	}
	/**
	 * @Description jcwjclyzqmrq8的中文含义是： 稽查队文件处理笺阅者签名日期8
	 */
	public void setJcwjclyzqmrq8(Date jcwjclyzqmrq8){
		this.jcwjclyzqmrq8 = jcwjclyzqmrq8;
	}
	/**
	 * @Description jcwjclyzqmrq8的中文含义是： 稽查队文件处理笺阅者签名日期8
	 */
	public Date getJcwjclyzqmrq8(){
		return jcwjclyzqmrq8;
	}
	/**
	 * @Description jcwjclyzqmrq9的中文含义是： 稽查队文件处理笺阅者签名日期9
	 */
	public void setJcwjclyzqmrq9(Date jcwjclyzqmrq9){
		this.jcwjclyzqmrq9 = jcwjclyzqmrq9;
	}
	/**
	 * @Description jcwjclyzqmrq9的中文含义是： 稽查队文件处理笺阅者签名日期9
	 */
	public Date getJcwjclyzqmrq9(){
		return jcwjclyzqmrq9;
	}
	/**
	 * @Description jcwjclyzqmrq10的中文含义是： 稽查队文件处理笺阅者签名日期10
	 */
	public void setJcwjclyzqmrq10(Date jcwjclyzqmrq10){
		this.jcwjclyzqmrq10 = jcwjclyzqmrq10;
	}
	/**
	 * @Description jcwjclyzqmrq10的中文含义是： 稽查队文件处理笺阅者签名日期10
	 */
	public Date getJcwjclyzqmrq10(){
		return jcwjclyzqmrq10;
	}
	/**
	 * @Description jcwjclbz的中文含义是： 稽查队文件处理笺备注
	 */
	public void setJcwjclbz(String jcwjclbz){ 
		this.jcwjclbz = jcwjclbz;
	}
	/**
	 * @Description jcwjclbz的中文含义是： 稽查队文件处理笺备注
	 */
	public String getJcwjclbz(){
		return jcwjclbz;
	}

	
}