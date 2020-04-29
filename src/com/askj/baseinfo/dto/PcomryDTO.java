package com.askj.baseinfo.dto;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class PcomryDTO {
/** 人员表; InnoDB free: 303104 kB  */
	//扩展开始

	public String getWuzhutipicid() {
		return wuzhutipicid;
	}

	public void setWuzhutipicid(String wuzhutipicid) {
		this.wuzhutipicid = wuzhutipicid;
	}

	/** wuzhutipicid 的中文含义是：无主题生成图片*/

	private String wuzhutipicid;
	/** ryid 的中文含义是：人员健康证图片path*/
	private String ryjkzpath;
	/** ryid 的中文含义是：人员健康证图片名称*/
	private String ryjkzname;
	/** ryid 的中文含义是：人员培训证图片path*/
	private String rypxzpath;
	/** ryid 的中文含义是：人员培训证图片名称*/
	private String rypxzname;
	/** ryzppath 的中文含义是：人员照片path*/
	private String ryzppath;
	/** ryzpname 的中文含义是：人员照片名称*/
	private String ryzpname;		
	/** commc 的中文含义是：企业名称*/
	private String commc;	
	/** comryusername 的中文含义是：企业用户产生的用户名称*/
	private String comryusername;
	private String userid;
	private String sjordn;

	public String getSjordn() {
		return sjordn;
	}

	public void setSjordn(String sjordn) {
		this.sjordn = sjordn;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	//扩展结束
	
	
	/** ryid 的中文含义是：*/
	private String ryid;

	/** ryzjlx 的中文含义是：证件类型对应代码表ryzjlx*/
	private String ryzjlx;

	/** ryzjh 的中文含义是：证件号码*/
	private String ryzjh;

	/** ryxm 的中文含义是：姓名*/
	private String ryxm;

	/** ryxb 的中文含义是：性别对应代表ryxb*/
	private String ryxb;

	/** rycsrq 的中文含义是：出生日期*/
	private Timestamp rycsrq;

	/** rynl 的中文含义是：年龄*/
	private BigDecimal rynl;

	/** ryxueli 的中文含义是：学历对应代表ryxueli*/
	private String ryxueli;

	/** rybeginwork 的中文含义是：开始工作日期*/
	private Date rybeginwork;

	/** rylxdh 的中文含义是：联系电话*/
	private String rylxdh;

	/** ryzhuanye 的中文含义是：专业*/
	private String ryzhuanye;

	/** ryjszc 的中文含义是：技术职称*/
	private String ryjszc;

	/** rycyfw 的中文含义是：从业范围*/
	private String rycyfw;

	/** rycyzglb 的中文含义是：从业资格类别*/
	private String rycyzglb;

	/** ryzgzsbh 的中文含义是：资格证书编号*/
	private String ryzgzsbh;

	/** ryzgzsfzrq 的中文含义是：资格证书发证日期*/
	private Timestamp ryzgzsfzrq;

	/** rysfzyys 的中文含义是：是否执业药师*/
	private String rysfzyys;

	/** ryzyyszcbh 的中文含义是：职业药师注册编号*/
	private String ryzyyszcbh;

	/** ryzyyszcrq 的中文含义是：职业药师注册日期*/
	private Timestamp ryzyyszcrq;

	/** ryzyyszsyxqz 的中文含义是：职业药师证书有效期至*/
	private Timestamp ryzyyszsyxqz;

	/** rybyyx 的中文含义是：毕业院校*/
	private String rybyyx;

	/** ryzwgw 的中文含义是：职务岗位*/
	private String ryzwgw;
	private String ryzwgwinfo;

	/** rymz 的中文含义是：民族对应代码表rymz*/
	private String rymz;

	/** comid 的中文含义是：单位id*/
	private String comid;

	/** ryjg 的中文含义是：籍贯*/
	private String ryjg;

	/** ryzt 的中文含义是：人员状态1在职2离职*/
	private String ryzt;

	/** rytxdz 的中文含义是：通讯地址*/
	private String rytxdz;

	/** ryqq 的中文含义是：人员qq*/
	private String ryqq;

	/** ryemail 的中文含义是：人员email*/
	private String ryemail;

	/** ryzhize 的中文含义是：人员职责*/
	private String ryzhize;

	/** rysflb 的中文含义是：人员身份类别aaa100=RYSFLB*/
	private String rysflb;

	/** ryjkqk 的中文含义是：人员健康情况aaa100=RYJKQK0不合格1合格*/
	private String ryjkqk;

	/** rypxqk 的中文含义是：人员培训情况aaa100=RYPXQK0未培训1已培训*/
	private String rypxqk;

	/** ryjianjie 的中文含义是：人员简介*/
	private String ryjianjie;

	/** rysfspaqgly 的中文含义是：是否食品安全管理员aaa100=RYSFSPAQGLY*/
	private String rysfspaqgly;

	/** rysfjdgsry 的中文含义是：是否监督公示人员aaa100=RYSFJDGSRY*/
	private String rysfjdgsry;

	/** ryjkzh 的中文含义是：人员健康证号*/
	private String ryjkzh;

	/** ryjkzfzrq 的中文含义是：健康证发证日期*/
	private Date ryjkzfzrq;

	/** ryjkzyxjzrq 的中文含义是：健康证有效截止日期*/
	private Date ryjkzyxjzrq;


	public String getRyzwgwinfo() {
		return ryzwgwinfo;
	}

	public void setRyzwgwinfo(String ryzwgwinfo) {
		this.ryzwgwinfo = ryzwgwinfo;
	}

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

	public void setRyjkzfzrq(Date ryjkzfzrq){
		this.ryjkzfzrq=ryjkzfzrq;
	}

	public Date getRyjkzfzrq(){
		return ryjkzfzrq;
	}

	public void setRyjkzyxjzrq(Date ryjkzyxjzrq){
		this.ryjkzyxjzrq=ryjkzyxjzrq;
	}

	public Date getRyjkzyxjzrq(){
		return ryjkzyxjzrq;
	}

	public String getRyjkzpath() {
		return ryjkzpath;
	}

	public void setRyjkzpath(String ryjkzpath) {
		this.ryjkzpath = ryjkzpath;
	}

	public String getRyjkzname() {
		return ryjkzname;
	}

	public void setRyjkzname(String ryjkzname) {
		this.ryjkzname = ryjkzname;
	}

	public String getRypxzpath() {
		return rypxzpath;
	}

	public void setRypxzpath(String rypxzpath) {
		this.rypxzpath = rypxzpath;
	}

	public String getRypxzname() {
		return rypxzname;
	}

	public void setRypxzname(String rypxzname) {
		this.rypxzname = rypxzname;
	}

	public String getRyzppath() {
		return ryzppath;
	}

	public void setRyzppath(String ryzppath) {
		this.ryzppath = ryzppath;
	}

	public String getRyzpname() {
		return ryzpname;
	}

	public void setRyzpname(String ryzpname) {
		this.ryzpname = ryzpname;
	}

	public String getCommc() {
		return commc;
	}

	public void setCommc(String commc) {
		this.commc = commc;
	}

	public String getComryusername() {
		return comryusername;
	}

	public void setComryusername(String comryusername) {
		this.comryusername = comryusername;
	}
}

