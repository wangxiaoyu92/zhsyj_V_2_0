package com.askj.baseinfo.entity;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "Pcomry")
public class Pcomry {
/** 人员表; InnoDB free: 303104 kB  */
	/** ryid 的中文含义是：*/
	@Name
	@Column
	private String ryid;

	/** ryzjlx 的中文含义是：证件类型对应代码表ryzjlx*/
	@Column
	private String ryzjlx;

	/** ryzjh 的中文含义是：证件号码*/
	@Column
	private String ryzjh;

	/** ryxm 的中文含义是：姓名*/
	@Column
	private String ryxm;

	/** ryxb 的中文含义是：性别对应代表ryxb*/
	@Column
	private String ryxb;

	/** rycsrq 的中文含义是：出生日期*/
	@Column
	private Timestamp rycsrq;

	/** rynl 的中文含义是：年龄*/
	@Column
	private BigDecimal rynl;

	/** ryxueli 的中文含义是：学历对应代表ryxueli*/
	@Column
	private String ryxueli;

	/** rybeginwork 的中文含义是：开始工作日期*/
	@Column
	private Date rybeginwork;

	/** rylxdh 的中文含义是：联系电话*/
	@Column
	private String rylxdh;

	/** ryzhuanye 的中文含义是：专业*/
	@Column
	private String ryzhuanye;

	/** ryjszc 的中文含义是：技术职称*/
	@Column
	private String ryjszc;

	/** rycyfw 的中文含义是：从业范围*/
	@Column
	private String rycyfw;

	/** rycyzglb 的中文含义是：从业资格类别*/
	@Column
	private String rycyzglb;

	/** ryzgzsbh 的中文含义是：资格证书编号*/
	@Column
	private String ryzgzsbh;

	/** ryzgzsfzrq 的中文含义是：资格证书发证日期*/
	@Column
	private Timestamp ryzgzsfzrq;

	/** rysfzyys 的中文含义是：是否执业药师*/
	@Column
	private String rysfzyys;

	/** ryzyyszcbh 的中文含义是：职业药师注册编号*/
	@Column
	private String ryzyyszcbh;

	/** ryzyyszcrq 的中文含义是：职业药师注册日期*/
	@Column
	private Timestamp ryzyyszcrq;

	/** ryzyyszsyxqz 的中文含义是：职业药师证书有效期至*/
	@Column
	private Timestamp ryzyyszsyxqz;

	/** rybyyx 的中文含义是：毕业院校*/
	@Column
	private String rybyyx;

	/** ryzwgw 的中文含义是：职务岗位*/
	@Column
	private String ryzwgw;

	/** rymz 的中文含义是：民族对应代码表rymz*/
	@Column
	private String rymz;

	/** comid 的中文含义是：单位id*/
	@Column
	private String comid;

	/** ryjg 的中文含义是：籍贯*/
	@Column
	private String ryjg;

	/** ryzt 的中文含义是：人员状态1在职2离职*/
	@Column
	private String ryzt;

	/** rytxdz 的中文含义是：通讯地址*/
	@Column
	private String rytxdz;

	/** ryqq 的中文含义是：人员qq*/
	@Column
	private String ryqq;

	/** ryemail 的中文含义是：人员email*/
	@Column
	private String ryemail;

	/** ryzhize 的中文含义是：人员职责*/
	@Column
	private String ryzhize;

	/** rysflb 的中文含义是：人员身份类别aaa100=RYSFLB*/
	@Column
	private String rysflb;

	/** ryjkqk 的中文含义是：人员健康情况aaa100=RYJKQK0不合格1合格*/
	@Column
	private String ryjkqk;

	/** rypxqk 的中文含义是：人员培训情况aaa100=RYPXQK0未培训1已培训*/
	@Column
	private String rypxqk;

	/** ryjianjie 的中文含义是：人员简介*/
	@Column
	private String ryjianjie;

	/** rysfspaqgly 的中文含义是：是否食品安全管理员aaa100=RYSFSPAQGLY*/
	@Column
	private String rysfspaqgly;

	/** rysfjdgsry 的中文含义是：是否监督公示人员*/
	@Column
	private String rysfjdgsry;

	/** ryjkzh 的中文含义是：人员健康证号*/
	@Column
	private String ryjkzh;

	/** ryjkzfzrq 的中文含义是：健康证发证日期*/
	@Column
	private Date ryjkzfzrq;

	/** ryjkzyxjzrq 的中文含义是：健康证有效截止日期*/
	@Column
	private Date ryjkzyxjzrq;


	public void setRyid(String ryid){
		this.ryid=ryid;
	}

	public String getRyid(){
		return ryid;
	}

	public void setRyzjlx(String ryzjlx){
		this.ryzjlx=ryzjlx;
	}

	public String getRyzjlx(){
		return ryzjlx;
	}

	public void setRyzjh(String ryzjh){
		this.ryzjh=ryzjh;
	}

	public String getRyzjh(){
		return ryzjh;
	}

	public void setRyxm(String ryxm){
		this.ryxm=ryxm;
	}

	public String getRyxm(){
		return ryxm;
	}

	public void setRyxb(String ryxb){
		this.ryxb=ryxb;
	}

	public String getRyxb(){
		return ryxb;
	}

	public void setRycsrq(Timestamp rycsrq){
		this.rycsrq=rycsrq;
	}

	public Timestamp getRycsrq(){
		return rycsrq;
	}

	public void setRynl(BigDecimal rynl){
		this.rynl=rynl;
	}

	public BigDecimal getRynl(){
		return rynl;
	}

	public void setRyxueli(String ryxueli){
		this.ryxueli=ryxueli;
	}

	public String getRyxueli(){
		return ryxueli;
	}

	public void setRybeginwork(Date rybeginwork){
		this.rybeginwork=rybeginwork;
	}

	public Date getRybeginwork(){
		return rybeginwork;
	}

	public void setRylxdh(String rylxdh){
		this.rylxdh=rylxdh;
	}

	public String getRylxdh(){
		return rylxdh;
	}

	public void setRyzhuanye(String ryzhuanye){
		this.ryzhuanye=ryzhuanye;
	}

	public String getRyzhuanye(){
		return ryzhuanye;
	}

	public void setRyjszc(String ryjszc){
		this.ryjszc=ryjszc;
	}

	public String getRyjszc(){
		return ryjszc;
	}

	public void setRycyfw(String rycyfw){
		this.rycyfw=rycyfw;
	}

	public String getRycyfw(){
		return rycyfw;
	}

	public void setRycyzglb(String rycyzglb){
		this.rycyzglb=rycyzglb;
	}

	public String getRycyzglb(){
		return rycyzglb;
	}

	public void setRyzgzsbh(String ryzgzsbh){
		this.ryzgzsbh=ryzgzsbh;
	}

	public String getRyzgzsbh(){
		return ryzgzsbh;
	}

	public void setRyzgzsfzrq(Timestamp ryzgzsfzrq){
		this.ryzgzsfzrq=ryzgzsfzrq;
	}

	public Timestamp getRyzgzsfzrq(){
		return ryzgzsfzrq;
	}

	public void setRysfzyys(String rysfzyys){
		this.rysfzyys=rysfzyys;
	}

	public String getRysfzyys(){
		return rysfzyys;
	}

	public void setRyzyyszcbh(String ryzyyszcbh){
		this.ryzyyszcbh=ryzyyszcbh;
	}

	public String getRyzyyszcbh(){
		return ryzyyszcbh;
	}

	public void setRyzyyszcrq(Timestamp ryzyyszcrq){
		this.ryzyyszcrq=ryzyyszcrq;
	}

	public Timestamp getRyzyyszcrq(){
		return ryzyyszcrq;
	}

	public void setRyzyyszsyxqz(Timestamp ryzyyszsyxqz){
		this.ryzyyszsyxqz=ryzyyszsyxqz;
	}

	public Timestamp getRyzyyszsyxqz(){
		return ryzyyszsyxqz;
	}

	public void setRybyyx(String rybyyx){
		this.rybyyx=rybyyx;
	}

	public String getRybyyx(){
		return rybyyx;
	}

	public void setRyzwgw(String ryzwgw){
		this.ryzwgw=ryzwgw;
	}

	public String getRyzwgw(){
		return ryzwgw;
	}

	public void setRymz(String rymz){
		this.rymz=rymz;
	}

	public String getRymz(){
		return rymz;
	}

	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setRyjg(String ryjg){
		this.ryjg=ryjg;
	}

	public String getRyjg(){
		return ryjg;
	}

	public void setRyzt(String ryzt){
		this.ryzt=ryzt;
	}

	public String getRyzt(){
		return ryzt;
	}

	public void setRytxdz(String rytxdz){
		this.rytxdz=rytxdz;
	}

	public String getRytxdz(){
		return rytxdz;
	}

	public void setRyqq(String ryqq){
		this.ryqq=ryqq;
	}

	public String getRyqq(){
		return ryqq;
	}

	public void setRyemail(String ryemail){
		this.ryemail=ryemail;
	}

	public String getRyemail(){
		return ryemail;
	}

	public void setRyzhize(String ryzhize){
		this.ryzhize=ryzhize;
	}

	public String getRyzhize(){
		return ryzhize;
	}

	public void setRysflb(String rysflb){
		this.rysflb=rysflb;
	}

	public String getRysflb(){
		return rysflb;
	}

	public void setRyjkqk(String ryjkqk){
		this.ryjkqk=ryjkqk;
	}

	public String getRyjkqk(){
		return ryjkqk;
	}

	public void setRypxqk(String rypxqk){
		this.rypxqk=rypxqk;
	}

	public String getRypxqk(){
		return rypxqk;
	}

	public void setRyjianjie(String ryjianjie){
		this.ryjianjie=ryjianjie;
	}

	public String getRyjianjie(){
		return ryjianjie;
	}

	public void setRysfspaqgly(String rysfspaqgly){
		this.rysfspaqgly=rysfspaqgly;
	}

	public String getRysfspaqgly(){
		return rysfspaqgly;
	}

	public void setRysfjdgsry(String rysfjdgsry){
		this.rysfjdgsry=rysfjdgsry;
	}

	public String getRysfjdgsry(){
		return rysfjdgsry;
	}

	public void setRyjkzh(String ryjkzh){
		this.ryjkzh=ryjkzh;
	}

	public String getRyjkzh(){
		return ryjkzh;
	}



	public Date getRyjkzfzrq() {
		return ryjkzfzrq;
	}

	public void setRyjkzfzrq(Date ryjkzfzrq) {
		this.ryjkzfzrq = ryjkzfzrq;
	}

	public void setRyjkzyxjzrq(Date ryjkzyxjzrq){
		this.ryjkzyxjzrq=ryjkzyxjzrq;
	}

	public Date getRyjkzyxjzrq(){
		return ryjkzyxjzrq;
	}

}

