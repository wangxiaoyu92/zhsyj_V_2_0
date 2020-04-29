package com.askj.ncjtjc.entity;

import org.nutz.dao.entity.annotation.*;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description  CS的中文含义是: 厨师信息表; InnoDB free: 2721792 kB
 * @Creation     2016/05/18 16:18:14
 * @Written      Create Tool By zjf 
 **/
@Table(value = "CS")
public class Cs {
	/**
	 * @Description csid的中文含义是： 厨师ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_csid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_csid.nextval from dual"))
	private String csid;

	/**
	 * @Description csbh的中文含义是： 厨师编号
	 */
	@Column
	private String csbh;

	/**
	 * @Description csxm的中文含义是： 厨师姓名
	 */
	@Column
	private String csxm;

	/**
	 * @Description cspym的中文含义是： 厨师姓名拼音码
	 */
	@Column
	private String cspym;

	/**
	 * @Description csxb的中文含义是： 厨师性别
	 */
	@Column
	private String csxb;

	/**
	 * @Description cscsrq的中文含义是： 厨师出生日期
	 */
	@Column
	private String cscsrq;

	/**
	 * @Description cssfzjlx的中文含义是： 厨师身份证件类型
	 */
	@Column
	private String cssfzjlx;

	/**
	 * @Description cssfzjhm的中文含义是： 厨师身份证号
	 */
	@Column
	private String cssfzjhm;

	/**
	 * @Description cssjh的中文含义是： 厨师手机号
	 */
	@Column
	private String cssjh;

	/**
	 * @Description cswhcd的中文含义是： 厨师文化程度
	 */
	@Column
	private String cswhcd;

	/**
	 * @Description cscynx的中文含义是： 厨师从业年限
	 */
	@Column
	private String cscynx;

	/**
	 * @Description csjkzm的中文含义是： 厨师健康证明
	 */
	@Column
	private String csjkzm;

	/**
	 * @Description csjkzyxq的中文含义是： 厨师健康证有效期
	 */
	@Column
	private Date csjkzyxq;

	/**
	 * @Description csjktjdd的中文含义是： 厨师健康体检地点
	 */
	@Column
	private String csjktjdd;
	
	/**
	 * @Description cspxqk的中文含义是： 厨师培训情况
	 */
	@Column
	private String cspxqk;

	/**
	 * @Description cspxhgzyxq的中文含义是： 厨师培训合格证有效期
	 */
	@Column
	private Date cspxhgzyxq;

	/**
	 * @Description csjtzz的中文含义是： 厨师家庭住址
	 */
	@Column
	private String csjtzz;

	/**
	 * @Description cshkszd的中文含义是： 厨师户口所在地
	 */
	@Column
	private String cshkszd;

	/**
	 * @Description csyx的中文含义是： 厨师邮箱
	 */
	@Column
	private String csyx;

	/**
	 * @Description csqq的中文含义是： 厨师QQ
	 */
	@Column
	private String csqq;

	/**
	 * @Description cswx的中文含义是： 厨师微信
	 */
	@Column
	private String cswx;

	/**
	 * @Description cssflx的中文含义是： 厨师身份类型
	 */
	@Column
	private String cssflx;

	/**
	 * @Description csfwdbh的中文含义是： 厨师服务队编号
	 */
	@Column
	private String csfwdbh;

	/**
	 * @Description csfwqy的中文含义是： 厨师服务区域
	 */
	@Column
	private String csfwqy;

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
	 * @Description csid的中文含义是： 厨师ID
	 */
	public void setCsid(String csid){ 
		this.csid = csid;
	}
	/**
	 * @Description csid的中文含义是： 厨师ID
	 */
	public String getCsid(){
		return csid;
	}
	/**
	 * @Description csbh的中文含义是： 厨师编号
	 */
	public void setCsbh(String csbh){ 
		this.csbh = csbh;
	}
	/**
	 * @Description csbh的中文含义是： 厨师编号
	 */
	public String getCsbh(){
		return csbh;
	}
	/**
	 * @Description csxm的中文含义是： 厨师姓名
	 */
	public void setCsxm(String csxm){ 
		this.csxm = csxm;
	}
	/**
	 * @Description csxm的中文含义是： 厨师姓名
	 */
	public String getCsxm(){
		return csxm;
	}
	/**
	 * @Description cspym的中文含义是： 厨师姓名拼音码
	 */
	public void setCspym(String cspym){ 
		this.cspym = cspym;
	}
	/**
	 * @Description cspym的中文含义是： 厨师姓名拼音码
	 */
	public String getCspym(){
		return cspym;
	}
	/**
	 * @Description csxb的中文含义是： 厨师性别
	 */
	public void setCsxb(String csxb){ 
		this.csxb = csxb;
	}
	/**
	 * @Description csxb的中文含义是： 厨师性别
	 */
	public String getCsxb(){
		return csxb;
	}
	/**
	 * @Description cscsrq的中文含义是： 厨师出生日期
	 */
	public void setCscsrq(String cscsrq){ 
		this.cscsrq = cscsrq;
	}
	/**
	 * @Description cscsrq的中文含义是： 厨师出生日期
	 */
	public String getCscsrq(){
		return cscsrq;
	}
	/**
	 * @Description cssfzjlx的中文含义是： 厨师身份证件类型
	 */
	public void setCssfzjlx(String cssfzjlx){ 
		this.cssfzjlx = cssfzjlx;
	}
	/**
	 * @Description cssfzjlx的中文含义是： 厨师身份证件类型
	 */
	public String getCssfzjlx(){
		return cssfzjlx;
	}
	/**
	 * @Description cssfzjhm的中文含义是： 厨师身份证号
	 */
	public void setCssfzjhm(String cssfzjhm){ 
		this.cssfzjhm = cssfzjhm;
	}
	/**
	 * @Description cssfzjhm的中文含义是： 厨师身份证号
	 */
	public String getCssfzjhm(){
		return cssfzjhm;
	}
	/**
	 * @Description cssjh的中文含义是： 厨师手机号
	 */
	public void setCssjh(String cssjh){ 
		this.cssjh = cssjh;
	}
	/**
	 * @Description cssjh的中文含义是： 厨师手机号
	 */
	public String getCssjh(){
		return cssjh;
	}
	/**
	 * @Description cswhcd的中文含义是： 厨师文化程度
	 */
	public void setCswhcd(String cswhcd){ 
		this.cswhcd = cswhcd;
	}
	/**
	 * @Description cswhcd的中文含义是： 厨师文化程度
	 */
	public String getCswhcd(){
		return cswhcd;
	}
	/**
	 * @Description cscynx的中文含义是： 厨师从业年限
	 */
	public void setCscynx(String cscynx){ 
		this.cscynx = cscynx;
	}
	/**
	 * @Description cscynx的中文含义是： 厨师从业年限
	 */
	public String getCscynx(){
		return cscynx;
	}
	/**
	 * @Description csjkzm的中文含义是： 厨师健康证明
	 */
	public void setCsjkzm(String csjkzm){ 
		this.csjkzm = csjkzm;
	}
	/**
	 * @Description csjkzm的中文含义是： 厨师健康证明
	 */
	public String getCsjkzm(){
		return csjkzm;
	}
	/**
	 * @Description csjkzyxq的中文含义是： 厨师健康证有效期
	 */
	public void setCsjkzyxq(Date csjkzyxq){ 
		this.csjkzyxq = csjkzyxq;
	}
	/**
	 * @Description csjkzyxq的中文含义是： 厨师健康证有效期
	 */
	public Date getCsjkzyxq(){
		return csjkzyxq;
	}
	/**
	 * @Description csjktjdd的中文含义是： 厨师健康体检地点
	 */
	public void setCsjktjdd(String csjktjdd){ 
		this.csjktjdd = csjktjdd;
	}
	/**
	 * @Description csjktjdd的中文含义是： 厨师健康体检地点
	 */
	public String getCsjktjdd(){ 
		return csjktjdd;
	}
	
	/**
	 * @Description cspxqk的中文含义是： 厨师培训情况
	 */
	public void setCspxqk(String cspxqk){ 
		this.cspxqk = cspxqk;
	}
	/**
	 * @Description cspxqk的中文含义是： 厨师培训情况
	 */
	public String getCspxqk(){
		return cspxqk;
	}
	/**
	 * @Description cspxhgzyxq的中文含义是： 厨师培训合格证有效期
	 */
	public void setCspxhgzyxq(Date cspxhgzyxq){ 
		this.cspxhgzyxq = cspxhgzyxq;
	}
	/**
	 * @Description cspxhgzyxq的中文含义是： 厨师培训合格证有效期
	 */
	public Date getCspxhgzyxq(){
		return cspxhgzyxq;
	}
	/**
	 * @Description csjtzz的中文含义是： 厨师家庭住址
	 */
	public void setCsjtzz(String csjtzz){ 
		this.csjtzz = csjtzz;
	}
	/**
	 * @Description csjtzz的中文含义是： 厨师家庭住址
	 */
	public String getCsjtzz(){
		return csjtzz;
	}
	/**
	 * @Description cshkszd的中文含义是： 厨师户口所在地
	 */
	public void setCshkszd(String cshkszd){ 
		this.cshkszd = cshkszd;
	}
	/**
	 * @Description cshkszd的中文含义是： 厨师户口所在地
	 */
	public String getCshkszd(){
		return cshkszd;
	}
	/**
	 * @Description csyx的中文含义是： 厨师邮箱
	 */
	public void setCsyx(String csyx){ 
		this.csyx = csyx;
	}
	/**
	 * @Description csyx的中文含义是： 厨师邮箱
	 */
	public String getCsyx(){
		return csyx;
	}
	/**
	 * @Description csqq的中文含义是： 厨师QQ
	 */
	public void setCsqq(String csqq){ 
		this.csqq = csqq;
	}
	/**
	 * @Description csqq的中文含义是： 厨师QQ
	 */
	public String getCsqq(){
		return csqq;
	}
	/**
	 * @Description cswx的中文含义是： 厨师微信
	 */
	public void setCswx(String cswx){ 
		this.cswx = cswx;
	}
	/**
	 * @Description cswx的中文含义是： 厨师微信
	 */
	public String getCswx(){
		return cswx;
	}
	/**
	 * @Description cssflx的中文含义是： 厨师身份类型
	 */
	public void setCssflx(String cssflx){ 
		this.cssflx = cssflx;
	}
	/**
	 * @Description cssflx的中文含义是： 厨师身份类型
	 */
	public String getCssflx(){
		return cssflx;
	}
	/**
	 * @Description csfwdbh的中文含义是： 厨师服务队编号
	 */
	public void setCsfwdbh(String csfwdbh){ 
		this.csfwdbh = csfwdbh;
	}
	/**
	 * @Description csfwdbh的中文含义是： 厨师服务队编号
	 */
	public String getCsfwdbh(){
		return csfwdbh;
	}
	/**
	 * @Description csfwqy的中文含义是： 厨师服务区域
	 */
	public void setCsfwqy(String csfwqy){ 
		this.csfwqy = csfwqy;
	}
	/**
	 * @Description csfwqy的中文含义是： 厨师服务区域
	 */
	public String getCsfwqy(){
		return csfwqy;
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