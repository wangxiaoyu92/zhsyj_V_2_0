package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.*;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description JCSB的中文含义是: InnoDB free: 2722816 kB
 * @Creation 2016/05/19 14:13:20
 * @Written Create Tool By zjf
 **/
@Table(value = "JCSB")
public class Jcsb {
	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jcsbid')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_jcsbid.nextval from dual"))
	private String jcsbid;

	/**
	 * @Description jcsbbh的中文含义是： 聚餐申报编号
	 */
	@Column
	private String jcsbbh;

	/**
	 * @Description jcsbjbrxm的中文含义是： 举办人姓名
	 */
	@Column
	private String jcsbjbrxm;

	/**
	 * @Description jcsbjbrsjh的中文含义是： 举办人手机号
	 */
	@Column
	private String jcsbjbrsjh;

	/**
	 * @Description jcsbjclx的中文含义是： 聚餐类型
	 */
	@Column
	private String jcsbjclx;

	/**
	 * @Description jcsbjcdd的中文含义是： 聚餐地点
	 */
	@Column
	private String jcsbjcdd;

	/**
	 * @Description jcsbjdzb的中文含义是： 聚餐地点经度坐标
	 */
	@Column
	private String jcsbjdzb;

	/**
	 * @Description jcsbwdzb的中文含义是： 聚餐地点纬度坐标
	 */
	@Column
	private String jcsbwdzb;

	/**
	 * @Description jcsbbjzt的中文含义是： 聚餐地点标记状态
	 */
	@Column
	private String jcsbbjzt;

	/**
	 * @Description jcsbjcsj1的中文含义是： 聚餐时间1
	 */
	@Column
	private Date jcsbjcsj1;

	/**
	 * @Description jcsbjccc1的中文含义是： 聚餐餐次1
	 */
	@Column
	private String jcsbjccc1;

	/**
	 * @Description jcsbjcsj2的中文含义是： 聚餐时间2
	 */
	@Column
	private Date jcsbjcsj2;

	/**
	 * @Description jcsbjccc2的中文含义是： 聚餐餐次2
	 */
	@Column
	private String jcsbjccc2;

	/**
	 * @Description jcsbjcsj3的中文含义是： 聚餐时间3
	 */
	@Column
	private Date jcsbjcsj3;

	/**
	 * @Description jcsbjccc3的中文含义是： 聚餐餐次3
	 */
	@Column
	private String jcsbjccc3;

	/**
	 * @Description jcsbjcrs的中文含义是： 聚餐人数
	 */
	@Column
	private String jcsbjcrs;

	/**
	 * @Description jcsbjcgm的中文含义是： 聚餐规模
	 */
	@Column
	private String jcsbjcgm;
	
	/**
	 * @Description jcsbylly的中文含义是： 原料来源
	 */
	@Column
	private String jcsbylly;

	/**
	 * @Description jcsbcsly的中文含义是： 厨师来源
	 */
	@Column
	private String jcsbcsly;

	/**
	 * @Description jcsbcyjly的中文含义是： 餐饮具来源
	 */
	@Column
	private String jcsbcyjly;

	/**
	 * @Description jgyxcjcbz的中文含义是： 监管员现场检查标志
	 */
	@Column
	private String jgyxcjcbz;

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
	 * @Description aab301的中文含义是： 行政区划编码
	 */
	@Column
	private String aab301;

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
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
	private Timestamp aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	@Column
	private String aae013;

	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	public void setJcsbid(String jcsbid) {
		this.jcsbid = jcsbid;
	}

	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	public String getJcsbid() {
		return jcsbid;
	}

	/**
	 * @Description jcsbbh的中文含义是： 聚餐申报编号
	 */
	public void setJcsbbh(String jcsbbh) {
		this.jcsbbh = jcsbbh;
	}

	/**
	 * @Description jcsbbh的中文含义是： 聚餐申报编号
	 */
	public String getJcsbbh() {
		return jcsbbh;
	}

	/**
	 * @Description jcsbjbrxm的中文含义是： 举办人姓名
	 */
	public void setJcsbjbrxm(String jcsbjbrxm) {
		this.jcsbjbrxm = jcsbjbrxm;
	}

	/**
	 * @Description jcsbjbrxm的中文含义是： 举办人姓名
	 */
	public String getJcsbjbrxm() {
		return jcsbjbrxm;
	}

	/**
	 * @Description jcsbjbrsjh的中文含义是： 举办人手机号
	 */
	public void setJcsbjbrsjh(String jcsbjbrsjh) {
		this.jcsbjbrsjh = jcsbjbrsjh;
	}

	/**
	 * @Description jcsbjbrsjh的中文含义是： 举办人手机号
	 */
	public String getJcsbjbrsjh() {
		return jcsbjbrsjh;
	}

	/**
	 * @Description jcsbjclx的中文含义是： 聚餐类型
	 */
	public void setJcsbjclx(String jcsbjclx) {
		this.jcsbjclx = jcsbjclx;
	}

	/**
	 * @Description jcsbjclx的中文含义是： 聚餐类型
	 */
	public String getJcsbjclx() {
		return jcsbjclx;
	}

	/**
	 * @Description jcsbjcdd的中文含义是： 聚餐地点
	 */
	public void setJcsbjcdd(String jcsbjcdd) {
		this.jcsbjcdd = jcsbjcdd;
	}

	/**
	 * @Description jcsbjcdd的中文含义是： 聚餐地点
	 */
	public String getJcsbjcdd() {
		return jcsbjcdd;
	}

	/**
	 * @Description jcsbjdzb的中文含义是： 聚餐地点经度坐标
	 */
	public void setJcsbjdzb(String jcsbjdzb) {
		this.jcsbjdzb = jcsbjdzb;
	}

	/**
	 * @Description jcsbjdzb的中文含义是： 聚餐地点经度坐标
	 */
	public String getJcsbjdzb() {
		return jcsbjdzb;
	}

	/**
	 * @Description jcsbwdzb的中文含义是： 聚餐地点纬度坐标
	 */
	public void setJcsbwdzb(String jcsbwdzb) {
		this.jcsbwdzb = jcsbwdzb;
	}

	/**
	 * @Description jcsbwdzb的中文含义是： 聚餐地点纬度坐标
	 */
	public String getJcsbwdzb() {
		return jcsbwdzb;
	}

	/**
	 * @Description jcsbbjzt的中文含义是： 聚餐地点标记状态
	 */
	public void setJcsbbjzt(String jcsbbjzt) {
		this.jcsbbjzt = jcsbbjzt;
	}

	/**
	 * @Description jcsbbjzt的中文含义是： 聚餐地点标记状态
	 */
	public String getJcsbbjzt() {
		return jcsbbjzt;
	}

	/**
	 * @Description jcsbjcsj1的中文含义是： 聚餐时间1
	 */
	public void setJcsbjcsj1(Date jcsbjcsj1) {
		this.jcsbjcsj1 = jcsbjcsj1;
	}

	/**
	 * @Description jcsbjcsj1的中文含义是： 聚餐时间1
	 */
	public Date getJcsbjcsj1() {
		return jcsbjcsj1;
	}

	/**
	 * @Description jcsbjccc1的中文含义是： 聚餐餐次1
	 */
	public void setJcsbjccc1(String jcsbjccc1) {
		this.jcsbjccc1 = jcsbjccc1;
	}

	/**
	 * @Description jcsbjccc1的中文含义是： 聚餐餐次1
	 */
	public String getJcsbjccc1() {
		return jcsbjccc1;
	}

	/**
	 * @Description jcsbjcsj2的中文含义是： 聚餐时间2
	 */
	public void setJcsbjcsj2(Date jcsbjcsj2) {
		this.jcsbjcsj2 = jcsbjcsj2;
	}

	/**
	 * @Description jcsbjcsj2的中文含义是： 聚餐时间2
	 */
	public Date getJcsbjcsj2() {
		return jcsbjcsj2;
	}

	/**
	 * @Description jcsbjccc2的中文含义是： 聚餐餐次2
	 */
	public void setJcsbjccc2(String jcsbjccc2) {
		this.jcsbjccc2 = jcsbjccc2;
	}

	/**
	 * @Description jcsbjccc2的中文含义是： 聚餐餐次2
	 */
	public String getJcsbjccc2() {
		return jcsbjccc2;
	}

	/**
	 * @Description jcsbjcsj3的中文含义是： 聚餐时间3
	 */
	public void setJcsbjcsj3(Date jcsbjcsj3) {
		this.jcsbjcsj3 = jcsbjcsj3;
	}

	/**
	 * @Description jcsbjcsj3的中文含义是： 聚餐时间3
	 */
	public Date getJcsbjcsj3() {
		return jcsbjcsj3;
	}

	/**
	 * @Description jcsbjccc3的中文含义是： 聚餐餐次3
	 */
	public void setJcsbjccc3(String jcsbjccc3) {
		this.jcsbjccc3 = jcsbjccc3;
	}

	/**
	 * @Description jcsbjccc1的中文含义是： 聚餐餐次3
	 */
	public String getJcsbjccc3() {
		return jcsbjccc3;
	}

	/**
	 * @Description jcsbjcrs的中文含义是： 聚餐人数
	 */
	public void setJcsbjcrs(String jcsbjcrs) {
		this.jcsbjcrs = jcsbjcrs;
	}

	/**
	 * @Description jcsbjcrs的中文含义是： 聚餐人数
	 */
	public String getJcsbjcrs() {
		return jcsbjcrs;
	}

	/**
	 * @Description jcsbjcgm的中文含义是： 聚餐规模
	 */
	public void setJcsbjcgm(String jcsbjcgm) {
		this.jcsbjcgm = jcsbjcgm;
	}

	/**
	 * @Description jcsbjcgm的中文含义是： 聚餐规模
	 */
	public String getJcsbjcgm() {
		return jcsbjcgm;
	}
	
	/**
	 * @Description jcsbylly的中文含义是： 原料来源
	 */
	public void setJcsbylly(String jcsbylly) {
		this.jcsbylly = jcsbylly;
	}

	/**
	 * @Description jcsbylly的中文含义是： 原料来源
	 */
	public String getJcsbylly() {
		return jcsbylly;
	}

	/**
	 * @Description jcsbcsly的中文含义是： 厨师来源
	 */
	public void setJcsbcsly(String jcsbcsly) {
		this.jcsbcsly = jcsbcsly;
	}

	/**
	 * @Description jcsbcsly的中文含义是： 厨师来源
	 */
	public String getJcsbcsly() {
		return jcsbcsly;
	}

	/**
	 * @Description jcsbcyjly的中文含义是： 餐饮具来源
	 */
	public void setJcsbcyjly(String jcsbcyjly) {
		this.jcsbcyjly = jcsbcyjly;
	}

	/**
	 * @Description jcsbcyjly的中文含义是： 餐饮具来源
	 */
	public String getJcsbcyjly() {
		return jcsbcyjly;
	}

	/**
	 * @Description jgyxcjcbz的中文含义是： 监管员现场检查标志
	 */
	public String getJgyxcjcbz() {
		return jgyxcjcbz;
	}

	/**
	 * @Description jgyxcjcbz的中文含义是： 监管员现场检查标志
	 */
	public void setJgyxcjcbz(String jgyxcjcbz) {
		this.jgyxcjcbz = jgyxcjcbz;
	}

	/**
	 * @Description comshengdm的中文含义是： 省份代码
	 */
	public void setComshengdm(String comshengdm) {
		this.comshengdm = comshengdm;
	}

	/**
	 * @Description comshengdm的中文含义是： 省份代码
	 */
	public String getComshengdm() {
		return comshengdm;
	}

	/**
	 * @Description comshengmc的中文含义是： 省份名称
	 */
	public void setComshengmc(String comshengmc) {
		this.comshengmc = comshengmc;
	}

	/**
	 * @Description comshengmc的中文含义是： 省份名称
	 */
	public String getComshengmc() {
		return comshengmc;
	}

	/**
	 * @Description comshidm的中文含义是： 市代码
	 */
	public void setComshidm(String comshidm) {
		this.comshidm = comshidm;
	}

	/**
	 * @Description comshidm的中文含义是： 市代码
	 */
	public String getComshidm() {
		return comshidm;
	}

	/**
	 * @Description comshimc的中文含义是： 市名称
	 */
	public void setComshimc(String comshimc) {
		this.comshimc = comshimc;
	}

	/**
	 * @Description comshimc的中文含义是： 市名称
	 */
	public String getComshimc() {
		return comshimc;
	}

	/**
	 * @Description comxiandm的中文含义是： 县代码
	 */
	public void setComxiandm(String comxiandm) {
		this.comxiandm = comxiandm;
	}

	/**
	 * @Description comxiandm的中文含义是： 县代码
	 */
	public String getComxiandm() {
		return comxiandm;
	}

	/**
	 * @Description comxianmc的中文含义是： 县名称
	 */
	public void setComxianmc(String comxianmc) {
		this.comxianmc = comxianmc;
	}

	/**
	 * @Description comxianmc的中文含义是： 县名称
	 */
	public String getComxianmc() {
		return comxianmc;
	}

	/**
	 * @Description comxiangdm的中文含义是： 街道办/乡镇代码
	 */
	public void setComxiangdm(String comxiangdm) {
		this.comxiangdm = comxiangdm;
	}

	/**
	 * @Description comxiangdm的中文含义是： 街道办/乡镇代码
	 */
	public String getComxiangdm() {
		return comxiangdm;
	}

	/**
	 * @Description comxiangmc的中文含义是： 街道办/乡镇名称
	 */
	public void setComxiangmc(String comxiangmc) {
		this.comxiangmc = comxiangmc;
	}

	/**
	 * @Description comxiangmc的中文含义是： 街道办/乡镇名称
	 */
	public String getComxiangmc() {
		return comxiangmc;
	}

	/**
	 * @Description comcundm的中文含义是： 社区/行政村代码
	 */
	public void setComcundm(String comcundm) {
		this.comcundm = comcundm;
	}

	/**
	 * @Description comcundm的中文含义是： 社区/行政村代码
	 */
	public String getComcundm() {
		return comcundm;
	}

	/**
	 * @Description comcunmc的中文含义是： 社区/行政村名称
	 */
	public void setComcunmc(String comcunmc) {
		this.comcunmc = comcunmc;
	}

	/**
	 * @Description comcunmc的中文含义是： 社区/行政村名称
	 */
	public String getComcunmc() {
		return comcunmc;
	}

	/**
	 * @Description aab301的中文含义是： 行政区划编码
	 */
	public void setAab301(String aab301) {
		this.aab301 = aab301;
	}

	/**
	 * @Description aab301的中文含义是： 行政区划编码
	 */
	public String getAab301() {
		return aab301;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027() {
		return aaa027;
	}

	/**
	 * @Description orgid的中文含义是： 所属机构id
	 */
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	/**
	 * @Description orgid的中文含义是： 所属机构id
	 */
	public String getOrgid() {
		return orgid;
	}

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011() {
		return aae011;
	}

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public void setAae036(Timestamp aae036) {
		this.aae036 = aae036;
	}

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public Timestamp getAae036() {
		return aae036;
	}

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public void setAae013(String aae013) {
		this.aae013 = aae013;
	}

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public String getAae013() {
		return aae013;
	}

}