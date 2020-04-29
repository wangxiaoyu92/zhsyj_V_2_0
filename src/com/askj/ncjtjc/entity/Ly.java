package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description  LY的中文含义是: 两员信息表; InnoDB free: 2721792 kB
 * @Creation     2016/07/25 16:18:14
 * @Written      Create Tool By sunyifeng 
 **/
@Table(value = "LY")
public class Ly {
	/**
	 * @Description lyid的中文含义是： 两员ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_lyid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_lyid.nextval from dual"))
	private String lyid;

	/**
	 * @Description lybh的中文含义是： 两员编号
	 */
	@Column
	private String lybh;

	/**
	 * @Description lyxm的中文含义是： 两员姓名
	 */
	@Column
	private String lyxm;

	/**
	 * @Description lypym的中文含义是： 两员姓名拼音码
	 */
	@Column
	private String lypym;

	/**
	 * @Description lyxb的中文含义是： 两员性别
	 */
	@Column
	private String lyxb;

	/**
	 * @Description lylyrq的中文含义是： 两员出生日期
	 */
	@Column
	private String lylyrq;

	/**
	 * @Description lysfzjlx的中文含义是： 两员身份证件类型
	 */
	@Column
	private String lysfzjlx;

	/**
	 * @Description lysfzjhm的中文含义是： 两员身份证号
	 */
	@Column
	private String lysfzjhm;

	/**
	 * @Description lysjh的中文含义是： 两员手机号
	 */
	@Column
	private String lysjh;

	/**
	 * @Description lywhcd的中文含义是： 两员文化程度
	 */
	@Column
	private String lywhcd;

	/**
	 * @Description lycynx的中文含义是： 两员从业年限
	 */
	@Column
	private String lycynx;

	/**
	 * @Description lyjkzm的中文含义是： 两员健康证明
	 */
	@Column
	private String lyjkzm;

	/**
	 * @Description lyjkzyxq的中文含义是： 两员健康证有效期
	 */
	@Column
	private Date lyjkzyxq;

	/**
	 * @Description lyjktjdd的中文含义是： 两员健康体检地点
	 */
	@Column
	private String lyjktjdd;
	
	/**
	 * @Description lypxqk的中文含义是： 两员培训情况
	 */
	@Column
	private String lypxqk;

	/**
	 * @Description lypxhgzyxq的中文含义是： 两员培训合格证有效期
	 */
	@Column
	private Date lypxhgzyxq;

	/**
	 * @Description lyjtzz的中文含义是： 两员家庭住址
	 */
	@Column
	private String lyjtzz;

	/**
	 * @Description lyhkszd的中文含义是： 两员户口所在地
	 */
	@Column
	private String lyhkszd;

	/**
	 * @Description lyyx的中文含义是： 两员邮箱
	 */
	@Column
	private String lyyx;

	/**
	 * @Description lyqq的中文含义是： 两员QQ
	 */
	@Column
	private String lyqq;

	/**
	 * @Description lywx的中文含义是： 两员微信
	 */
	@Column
	private String lywx;

	/**
	 * @Description lysflx的中文含义是： 两员身份类型
	 */
	@Column
	private String lysflx;

	/**
	 * @Description lyfwdbh的中文含义是： 两员服务队编号
	 */
	@Column
	private String lyfwdbh;

	/**
	 * @Description lyfwqy的中文含义是： 两员服务区域
	 */
	@Column
	private String lyfwqy;

	/**
	 * @Description comshengdm的中文含义是： 省份代码
	 */
	@Column
	private String comshengdm;

	/**
	 * @Description comshengmc的中文含义是： 省份名称
	 */
	@Column
	private String comshengmc;

	/**
	 * @Description comshidm的中文含义是： 市代码
	 */
	@Column
	private String comshidm;

	/**
	 * @Description comshimc的中文含义是： 市名称
	 */
	@Column
	private String comshimc;

	/**
	 * @Description comxiandm的中文含义是： 县代码
	 */
	@Column
	private String comxiandm;

	/**
	 * @Description comxianmc的中文含义是： 县名称
	 */
	@Column
	private String comxianmc;

	/**
	 * @Description comxiangdm的中文含义是： 街道办/乡镇代码
	 */
	@Column
	private String comxiangdm;

	/**
	 * @Description comxiangmc的中文含义是： 街道办/乡镇名称
	 */
	@Column
	private String comxiangmc;

	/**
	 * @Description comcundm的中文含义是： 社区/行政村代码
	 */
	@Column
	private String comcundm;

	/**
	 * @Description comcunmc的中文含义是： 社区/行政村名称
	 */
	@Column
	private String comcunmc;
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;
	
	/**
	 * @Description orgid的中文含义是： 所属机构id
	 */
	@Column
	private String orgid;
	
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办日期
	 */
	@Column
	private Timestamp aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	@Column
	private String aae013;

	
	/**
	 * @Description lyid的中文含义是： 两员ID
	 */
	public void setLyid(String lyid){ 
		this.lyid = lyid;
	}
	/**
	 * @Description lyid的中文含义是： 两员ID
	 */
	public String getLyid(){
		return lyid;
	}
	/**
	 * @Description lybh的中文含义是： 两员编号
	 */
	public void setLybh(String lybh){ 
		this.lybh = lybh;
	}
	/**
	 * @Description lybh的中文含义是： 两员编号
	 */
	public String getLybh(){
		return lybh;
	}
	/**
	 * @Description lyxm的中文含义是： 两员姓名
	 */
	public void setLyxm(String lyxm){ 
		this.lyxm = lyxm;
	}
	/**
	 * @Description lyxm的中文含义是： 两员姓名
	 */
	public String getLyxm(){
		return lyxm;
	}
	/**
	 * @Description lypym的中文含义是： 两员姓名拼音码
	 */
	public void setLypym(String lypym){ 
		this.lypym = lypym;
	}
	/**
	 * @Description lypym的中文含义是： 两员姓名拼音码
	 */
	public String getLypym(){
		return lypym;
	}
	/**
	 * @Description lyxb的中文含义是： 两员性别
	 */
	public void setLyxb(String lyxb){ 
		this.lyxb = lyxb;
	}
	/**
	 * @Description lyxb的中文含义是： 两员性别
	 */
	public String getLyxb(){
		return lyxb;
	}
	/**
	 * @Description lylyrq的中文含义是： 两员出生日期
	 */
	public void setLylyrq(String lylyrq){ 
		this.lylyrq = lylyrq;
	}
	/**
	 * @Description lylyrq的中文含义是： 两员出生日期
	 */
	public String getLylyrq(){
		return lylyrq;
	}
	/**
	 * @Description lysfzjlx的中文含义是： 两员身份证件类型
	 */
	public void setLysfzjlx(String lysfzjlx){ 
		this.lysfzjlx = lysfzjlx;
	}
	/**
	 * @Description lysfzjlx的中文含义是： 两员身份证件类型
	 */
	public String getLysfzjlx(){
		return lysfzjlx;
	}
	/**
	 * @Description lysfzjhm的中文含义是： 两员身份证号
	 */
	public void setLysfzjhm(String lysfzjhm){ 
		this.lysfzjhm = lysfzjhm;
	}
	/**
	 * @Description lysfzjhm的中文含义是： 两员身份证号
	 */
	public String getLysfzjhm(){
		return lysfzjhm;
	}
	/**
	 * @Description lysjh的中文含义是： 两员手机号
	 */
	public void setLysjh(String lysjh){ 
		this.lysjh = lysjh;
	}
	/**
	 * @Description lysjh的中文含义是： 两员手机号
	 */
	public String getLysjh(){
		return lysjh;
	}
	/**
	 * @Description lywhcd的中文含义是： 两员文化程度
	 */
	public void setLywhcd(String lywhcd){ 
		this.lywhcd = lywhcd;
	}
	/**
	 * @Description lywhcd的中文含义是： 两员文化程度
	 */
	public String getLywhcd(){
		return lywhcd;
	}
	/**
	 * @Description lycynx的中文含义是： 两员从业年限
	 */
	public void setLycynx(String lycynx){ 
		this.lycynx = lycynx;
	}
	/**
	 * @Description lycynx的中文含义是： 两员从业年限
	 */
	public String getLycynx(){
		return lycynx;
	}
	/**
	 * @Description lyjkzm的中文含义是： 两员健康证明
	 */
	public void setLyjkzm(String lyjkzm){ 
		this.lyjkzm = lyjkzm;
	}
	/**
	 * @Description lyjkzm的中文含义是： 两员健康证明
	 */
	public String getLyjkzm(){
		return lyjkzm;
	}
	/**
	 * @Description lyjkzyxq的中文含义是： 两员健康证有效期
	 */
	public void setLyjkzyxq(Date lyjkzyxq){ 
		this.lyjkzyxq = lyjkzyxq;
	}
	/**
	 * @Description lyjkzyxq的中文含义是： 两员健康证有效期
	 */
	public Date getLyjkzyxq(){
		return lyjkzyxq;
	}
	/**
	 * @Description lyjktjdd的中文含义是： 两员健康体检地点
	 */
	public void setLyjktjdd(String lyjktjdd){ 
		this.lyjktjdd = lyjktjdd;
	}
	/**
	 * @Description lyjktjdd的中文含义是： 两员健康体检地点
	 */
	public String getLyjktjdd(){ 
		return lyjktjdd;
	}
	
	/**
	 * @Description lypxqk的中文含义是： 两员培训情况
	 */
	public void setLypxqk(String lypxqk){ 
		this.lypxqk = lypxqk;
	}
	/**
	 * @Description lypxqk的中文含义是： 两员培训情况
	 */
	public String getLypxqk(){
		return lypxqk;
	}
	/**
	 * @Description lypxhgzyxq的中文含义是： 两员培训合格证有效期
	 */
	public void setLypxhgzyxq(Date lypxhgzyxq){ 
		this.lypxhgzyxq = lypxhgzyxq;
	}
	/**
	 * @Description lypxhgzyxq的中文含义是： 两员培训合格证有效期
	 */
	public Date getLypxhgzyxq(){
		return lypxhgzyxq;
	}
	/**
	 * @Description lyjtzz的中文含义是： 两员家庭住址
	 */
	public void setLyjtzz(String lyjtzz){ 
		this.lyjtzz = lyjtzz;
	}
	/**
	 * @Description lyjtzz的中文含义是： 两员家庭住址
	 */
	public String getLyjtzz(){
		return lyjtzz;
	}
	/**
	 * @Description lyhkszd的中文含义是： 两员户口所在地
	 */
	public void setLyhkszd(String lyhkszd){ 
		this.lyhkszd = lyhkszd;
	}
	/**
	 * @Description lyhkszd的中文含义是： 两员户口所在地
	 */
	public String getLyhkszd(){
		return lyhkszd;
	}
	/**
	 * @Description lyyx的中文含义是： 两员邮箱
	 */
	public void setLyyx(String lyyx){ 
		this.lyyx = lyyx;
	}
	/**
	 * @Description lyyx的中文含义是： 两员邮箱
	 */
	public String getLyyx(){
		return lyyx;
	}
	/**
	 * @Description lyqq的中文含义是： 两员QQ
	 */
	public void setLyqq(String lyqq){ 
		this.lyqq = lyqq;
	}
	/**
	 * @Description lyqq的中文含义是： 两员QQ
	 */
	public String getLyqq(){
		return lyqq;
	}
	/**
	 * @Description lywx的中文含义是： 两员微信
	 */
	public void setLywx(String lywx){ 
		this.lywx = lywx;
	}
	/**
	 * @Description lywx的中文含义是： 两员微信
	 */
	public String getLywx(){
		return lywx;
	}
	/**
	 * @Description lysflx的中文含义是： 两员身份类型
	 */
	public void setLysflx(String lysflx){ 
		this.lysflx = lysflx;
	}
	/**
	 * @Description lysflx的中文含义是： 两员身份类型
	 */
	public String getLysflx(){
		return lysflx;
	}
	/**
	 * @Description lyfwdbh的中文含义是： 两员服务队编号
	 */
	public void setLyfwdbh(String lyfwdbh){ 
		this.lyfwdbh = lyfwdbh;
	}
	/**
	 * @Description lyfwdbh的中文含义是： 两员服务队编号
	 */
	public String getLyfwdbh(){
		return lyfwdbh;
	}
	/**
	 * @Description lyfwqy的中文含义是： 两员服务区域
	 */
	public void setLyfwqy(String lyfwqy){ 
		this.lyfwqy = lyfwqy;
	}
	/**
	 * @Description lyfwqy的中文含义是： 两员服务区域
	 */
	public String getLyfwqy(){
		return lyfwqy;
	}
	
	/**
	 * @Description comshengdm的中文含义是： 省份代码
	 */
	public void setComshengdm(String comshengdm){ 
		this.comshengdm = comshengdm;
	}
	/**
	 * @Description comshengdm的中文含义是： 省份代码
	 */
	public String getComshengdm(){
		return comshengdm;
	}
	/**
	 * @Description comshengmc的中文含义是： 省份名称
	 */
	public void setComshengmc(String comshengmc){ 
		this.comshengmc = comshengmc;
	}
	/**
	 * @Description comshengmc的中文含义是： 省份名称
	 */
	public String getComshengmc(){
		return comshengmc;
	}
	/**
	 * @Description comshidm的中文含义是： 市代码
	 */
	public void setComshidm(String comshidm){ 
		this.comshidm = comshidm;
	}
	/**
	 * @Description comshidm的中文含义是： 市代码
	 */
	public String getComshidm(){
		return comshidm;
	}
	/**
	 * @Description comshimc的中文含义是： 市名称
	 */
	public void setComshimc(String comshimc){ 
		this.comshimc = comshimc;
	}
	/**
	 * @Description comshimc的中文含义是： 市名称
	 */
	public String getComshimc(){
		return comshimc;
	}
	/**
	 * @Description comxiandm的中文含义是： 县代码
	 */
	public void setComxiandm(String comxiandm){ 
		this.comxiandm = comxiandm;
	}
	/**
	 * @Description comxiandm的中文含义是： 县代码
	 */
	public String getComxiandm(){
		return comxiandm;
	}
	/**
	 * @Description comxianmc的中文含义是： 县名称
	 */
	public void setComxianmc(String comxianmc){ 
		this.comxianmc = comxianmc;
	}
	/**
	 * @Description comxianmc的中文含义是： 县名称
	 */
	public String getComxianmc(){
		return comxianmc;
	}
	/**
	 * @Description comxiangdm的中文含义是： 街道办/乡镇代码
	 */
	public void setComxiangdm(String comxiangdm){ 
		this.comxiangdm = comxiangdm;
	}
	/**
	 * @Description comxiangdm的中文含义是： 街道办/乡镇代码
	 */
	public String getComxiangdm(){
		return comxiangdm;
	}
	/**
	 * @Description comxiangmc的中文含义是： 街道办/乡镇名称
	 */
	public void setComxiangmc(String comxiangmc){ 
		this.comxiangmc = comxiangmc;
	}
	/**
	 * @Description comxiangmc的中文含义是： 街道办/乡镇名称
	 */
	public String getComxiangmc(){
		return comxiangmc;
	}
	/**
	 * @Description comcundm的中文含义是： 社区/行政村代码
	 */
	public void setComcundm(String comcundm){ 
		this.comcundm = comcundm;
	}
	/**
	 * @Description comcundm的中文含义是： 社区/行政村代码
	 */
	public String getComcundm(){
		return comcundm;
	}
	/**
	 * @Description comcunmc的中文含义是： 社区/行政村名称
	 */
	public void setComcunmc(String comcunmc){ 
		this.comcunmc = comcunmc;
	}
	/**
	 * @Description comcunmc的中文含义是： 社区/行政村名称
	 */
	public String getComcunmc(){
		return comcunmc;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027(){
		return aaa027;
	}
	/**
	 * @Description orgid的中文含义是： 所属机构id
	 */
	public void setOrgid(String orgid){ 
		this.orgid = orgid;
	}
	/**
	 * @Description orgid的中文含义是： 所属机构id
	 */
	public String getOrgid(){
		return orgid;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 经办日期
	 */
	public void setAae036(Timestamp aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 经办日期
	 */
	public Timestamp getAae036(){
		return aae036;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public void setAae013(String aae013){ 
		this.aae013 = aae013;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public String getAae013(){
		return aae013;
	}
}