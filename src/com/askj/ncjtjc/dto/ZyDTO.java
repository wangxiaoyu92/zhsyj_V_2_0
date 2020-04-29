package com.askj.ncjtjc.dto;

import java.sql.Timestamp;

/**
 * 
 * ZyDTO的中文名称：农村集体聚餐DTO
 * 
 * ZyDTO的描述：
 * 
 * Written by : zjf
 */
public class ZyDTO {
	/**
	 * @Description reprole的中文含义是：演示数据权限,1不控制
	 */
	private String reprole;
	/**
	 * @Description startDate的中文含义是： 起始日期
	 */
	private String startDate;
	/**
	 * @Description endDate的中文含义是： 截至日期
	 */
	private String endDate;

	/**
	 * @Description aae160的中文含义是： 变更原因
	 */
	private String aae160;
	/**
	 * @Description comshengdm的中文含义是： 省份代码
	 */
	private String comshengdm;

	/**
	 * @Description comshengmc的中文含义是： 省份名称
	 */
	private String comshengmc;

	/**
	 * @Description comshidm的中文含义是： 市代码
	 */
	private String comshidm;

	/**
	 * @Description comshimc的中文含义是： 市名称
	 */
	private String comshimc;

	/**
	 * @Description comxiandm的中文含义是： 县代码
	 */
	private String comxiandm;

	/**
	 * @Description comxianmc的中文含义是： 县名称
	 */
	private String comxianmc;

	/**
	 * @Description comxiangdm的中文含义是： 街道办/乡镇代码
	 */
	private String comxiangdm;

	/**
	 * @Description comxiangmc的中文含义是： 街道办/乡镇名称
	 */
	private String comxiangmc;

	/**
	 * @Description comcundm的中文含义是： 社区/行政村代码
	 */
	private String comcundm;

	/**
	 * @Description comcunmc的中文含义是： 社区/行政村名称
	 */
	private String comcunmc;
	/**
	 * @Description aab301的中文含义是： 行政区划编码
	 */
	private String aab301;
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	private String aaa027;
	/**
	 * @Description orgname的中文含义是： 统筹区名称
	 */
	private String aaa027name;
	/**
	 * @Description orgid的中文含义是： 所属机构id
	 */
	private String orgid;

	/**
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	private String orgname;
	/**
	 * @Description orgcode的中文含义是： 所属机构编码
	 */
	private String orgcode;
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办日期
	 */
	private Timestamp aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	private String aae013;
	private String qddszid;

	public String getQddszid() {
		return qddszid;
	}

	public void setQddszid(String qddszid) {
		this.qddszid = qddszid;
	}

	/**
	 * @Description reprole的中文含义是： 演示数据权限,1不控制
	 */
	public void setReprole(String reprole) {
		this.reprole = reprole;
	}

	/**
	 * @Description reprole的中文含义是： 演示数据权限,1不控制
	 */
	public String getReprole() {
		return reprole;
	}
	/**
	 * @Description startDate的中文含义是： 起始日期
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * @Description startDate的中文含义是： 起始日期
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * @Description endDate的中文含义是： 截至日期
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @Description endDate的中文含义是： 截至日期
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @Description aae160的中文含义是： 变更原因
	 */
	public void setAae160(String aae160) {
		this.aae160 = aae160;
	}

	/**
	 * @Description aae160的中文含义是： 变更原因
	 */
	public String getAae160() {
		return aae160;
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
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public String getAaa027name() {
		return aaa027name;
	}

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public void setAaa027name(String aaa027name) {
		this.aaa027name = aaa027name;
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
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	/**
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	public String getOrgname() {
		return orgname;
	}

	/**
	 * @Description orgcode的中文含义是： 所属机构编码
	 */
	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}

	/**
	 * @Description orgcode的中文含义是： 所属机构编码
	 */
	public String getOrgcode() {
		return orgcode;
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
	 * @Description aae036的中文含义是： 经办日期
	 */
	public void setAae036(Timestamp aae036) {
		this.aae036 = aae036;
	}

	/**
	 * @Description aae036的中文含义是： 经办日期
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

	/**
	 * @Description csid的中文含义是： 厨师ID
	 */
	private String csid;

	/**
	 * @Description csbh的中文含义是： 厨师编号
	 */
	private String csbh;

	/**
	 * @Description csxm的中文含义是： 厨师姓名
	 */
	private String csxm;

	/**
	 * @Description cspym的中文含义是： 厨师姓名拼音码
	 */
	private String cspym;

	/**
	 * @Description csxb的中文含义是： 厨师性别
	 */
	private String csxb;

	/**
	 * @Description cscsrq的中文含义是： 厨师出生日期
	 */
	private String cscsrq;

	/**
	 * @Description cssfzjlx的中文含义是： 厨师身份证件类型
	 */
	private String cssfzjlx;

	/**
	 * @Description cssfzjhm的中文含义是： 厨师身份证号
	 */
	private String cssfzjhm;

	/**
	 * @Description cssjh的中文含义是： 厨师手机号
	 */
	private String cssjh;

	/**
	 * @Description cswhcd的中文含义是： 厨师文化程度
	 */
	private String cswhcd;

	/**
	 * @Description cscynx的中文含义是： 厨师从业年限
	 */
	private String cscynx;

	/**
	 * @Description csjkzm的中文含义是： 厨师健康证明
	 */
	private String csjkzm;

	/**
	 * @Description csjkzyxq的中文含义是： 厨师健康证有效期
	 */
	private String csjkzyxq;

	/**
	 * @Description csjktjdd的中文含义是： 厨师健康体检地点
	 */
	private String csjktjdd;

	/**
	 * @Description cspxqk的中文含义是： 厨师培训情况
	 */
	private String cspxqk;

	/**
	 * @Description cspxhgzyxq的中文含义是： 厨师培训合格证有效期
	 */
	private String cspxhgzyxq;

	/**
	 * @Description csjtzz的中文含义是： 厨师家庭住址
	 */
	private String csjtzz;

	/**
	 * @Description cshkszd的中文含义是： 厨师户口所在地
	 */
	private String cshkszd;

	/**
	 * @Description csyx的中文含义是： 厨师邮箱
	 */
	private String csyx;

	/**
	 * @Description csqq的中文含义是： 厨师QQ
	 */
	private String csqq;

	/**
	 * @Description cswx的中文含义是： 厨师微信
	 */
	private String cswx;

	/**
	 * @Description cssflx的中文含义是： 厨师身份类型
	 */
	private String cssflx;

	/**
	 * @Description csfwdbh的中文含义是： 厨师服务队编号
	 */
	private String csfwdbh;

	/**
	 * @Description csfwqy的中文含义是： 厨师服务区域
	 */
	private String csfwqy;
	/**
	 * @Description itemid的中文含义是： 申报大类类别
	 */
	private String itemid;

	/**
	 * @Description csid的中文含义是： 厨师ID
	 */
	public void setCsid(String csid) {
		this.csid = csid;
	}

	/**
	 * @Description csid的中文含义是： 厨师ID
	 */
	public String getCsid() {
		return csid;
	}

	/**
	 * @Description csbh的中文含义是： 厨师编号
	 */
	public void setCsbh(String csbh) {
		this.csbh = csbh;
	}

	/**
	 * @Description csbh的中文含义是： 厨师编号
	 */
	public String getCsbh() {
		return csbh;
	}

	/**
	 * @Description csxm的中文含义是： 厨师姓名
	 */
	public void setCsxm(String csxm) {
		this.csxm = csxm;
	}

	/**
	 * @Description csxm的中文含义是： 厨师姓名
	 */
	public String getCsxm() {
		return csxm;
	}

	/**
	 * @Description cspym的中文含义是： 厨师姓名拼音码
	 */
	public void setCspym(String cspym) {
		this.cspym = cspym;
	}

	/**
	 * @Description cspym的中文含义是： 厨师姓名拼音码
	 */
	public String getCspym() {
		return cspym;
	}

	/**
	 * @Description csxb的中文含义是： 厨师性别
	 */
	public void setCsxb(String csxb) {
		this.csxb = csxb;
	}

	/**
	 * @Description csxb的中文含义是： 厨师性别
	 */
	public String getCsxb() {
		return csxb;
	}

	/**
	 * @Description cscsrq的中文含义是： 厨师出生日期
	 */
	public void setCscsrq(String cscsrq) {
		this.cscsrq = cscsrq;
	}

	/**
	 * @Description cscsrq的中文含义是： 厨师出生日期
	 */
	public String getCscsrq() {
		return cscsrq;
	}

	/**
	 * @Description cssfzjlx的中文含义是： 厨师身份证件类型
	 */
	public void setCssfzjlx(String cssfzjlx) {
		this.cssfzjlx = cssfzjlx;
	}

	/**
	 * @Description cssfzjlx的中文含义是： 厨师身份证件类型
	 */
	public String getCssfzjlx() {
		return cssfzjlx;
	}

	/**
	 * @Description cssfzjhm的中文含义是： 厨师身份证号
	 */
	public void setCssfzjhm(String cssfzjhm) {
		this.cssfzjhm = cssfzjhm;
	}

	/**
	 * @Description cssfzjhm的中文含义是： 厨师身份证号
	 */
	public String getCssfzjhm() {
		return cssfzjhm;
	}

	/**
	 * @Description cssjh的中文含义是： 厨师手机号
	 */
	public void setCssjh(String cssjh) {
		this.cssjh = cssjh;
	}

	/**
	 * @Description cssjh的中文含义是： 厨师手机号
	 */
	public String getCssjh() {
		return cssjh;
	}

	/**
	 * @Description cswhcd的中文含义是： 厨师文化程度
	 */
	public void setCswhcd(String cswhcd) {
		this.cswhcd = cswhcd;
	}

	/**
	 * @Description cswhcd的中文含义是： 厨师文化程度
	 */
	public String getCswhcd() {
		return cswhcd;
	}

	/**
	 * @Description cscynx的中文含义是： 厨师从业年限
	 */
	public void setCscynx(String cscynx) {
		this.cscynx = cscynx;
	}

	/**
	 * @Description cscynx的中文含义是： 厨师从业年限
	 */
	public String getCscynx() {
		return cscynx;
	}

	/**
	 * @Description csjkzm的中文含义是： 厨师健康证明
	 */
	public void setCsjkzm(String csjkzm) {
		this.csjkzm = csjkzm;
	}

	/**
	 * @Description csjkzm的中文含义是： 厨师健康证明
	 */
	public String getCsjkzm() {
		return csjkzm;
	}

	/**
	 * @Description csjkzyxq的中文含义是： 厨师健康证有效期
	 */
	public void setCsjkzyxq(String csjkzyxq) {
		this.csjkzyxq = csjkzyxq;
	}

	/**
	 * @Description csjkzyxq的中文含义是： 厨师健康证有效期
	 */
	public String getCsjkzyxq() {
		return csjkzyxq;
	}

	/**
	 * @Description csjktjdd的中文含义是： 厨师健康体检地点
	 */
	public void setCsjktjdd(String csjktjdd) {
		this.csjktjdd = csjktjdd;
	}

	/**
	 * @Description csjktjdd的中文含义是： 厨师健康体检地点
	 */
	public String getCsjktjdd() {
		return csjktjdd;
	}

	/**
	 * @Description cspxqk的中文含义是： 厨师培训情况
	 */
	public void setCspxqk(String cspxqk) {
		this.cspxqk = cspxqk;
	}

	/**
	 * @Description cspxqk的中文含义是： 厨师培训情况
	 */
	public String getCspxqk() {
		return cspxqk;
	}

	/**
	 * @Description cspxhgzyxq的中文含义是： 厨师培训合格证有效期
	 */
	public void setCspxhgzyxq(String cspxhgzyxq) {
		this.cspxhgzyxq = cspxhgzyxq;
	}

	/**
	 * @Description cspxhgzyxq的中文含义是： 厨师培训合格证有效期
	 */
	public String getCspxhgzyxq() {
		return cspxhgzyxq;
	}

	/**
	 * @Description csjtzz的中文含义是： 厨师家庭住址
	 */
	public void setCsjtzz(String csjtzz) {
		this.csjtzz = csjtzz;
	}

	/**
	 * @Description csjtzz的中文含义是： 厨师家庭住址
	 */
	public String getCsjtzz() {
		return csjtzz;
	}

	/**
	 * @Description cshkszd的中文含义是： 厨师户口所在地
	 */
	public void setCshkszd(String cshkszd) {
		this.cshkszd = cshkszd;
	}

	/**
	 * @Description cshkszd的中文含义是： 厨师户口所在地
	 */
	public String getCshkszd() {
		return cshkszd;
	}

	/**
	 * @Description csyx的中文含义是： 厨师邮箱
	 */
	public void setCsyx(String csyx) {
		this.csyx = csyx;
	}

	/**
	 * @Description csyx的中文含义是： 厨师邮箱
	 */
	public String getCsyx() {
		return csyx;
	}

	/**
	 * @Description csqq的中文含义是： 厨师QQ
	 */
	public void setCsqq(String csqq) {
		this.csqq = csqq;
	}

	/**
	 * @Description csqq的中文含义是： 厨师QQ
	 */
	public String getCsqq() {
		return csqq;
	}

	/**
	 * @Description cswx的中文含义是： 厨师微信
	 */
	public void setCswx(String cswx) {
		this.cswx = cswx;
	}

	/**
	 * @Description cswx的中文含义是： 厨师微信
	 */
	public String getCswx() {
		return cswx;
	}

	/**
	 * @Description cssflx的中文含义是： 厨师身份类型
	 */
	public void setCssflx(String cssflx) {
		this.cssflx = cssflx;
	}

	/**
	 * @Description cssflx的中文含义是： 厨师身份类型
	 */
	public String getCssflx() {
		return cssflx;
	}

	/**
	 * @Description csfwdbh的中文含义是： 厨师服务队编号
	 */
	public void setCsfwdbh(String csfwdbh) {
		this.csfwdbh = csfwdbh;
	}

	/**
	 * @Description csfwdbh的中文含义是： 厨师服务队编号
	 */
	public String getCsfwdbh() {
		return csfwdbh;
	}

	/**
	 * @Description csfwqy的中文含义是： 厨师服务区域
	 */
	public void setCsfwqy(String csfwqy) {
		this.csfwqy = csfwqy;
	}

	/**
	 * @Description csfwqy的中文含义是： 厨师服务区域
	 */
	public String getCsfwqy() {
		return csfwqy;
	}

	/**
	 * @Description lszpid的中文含义是： 厨师照片ID
	 */
	private String cszpid;

	/**
	 * @Description cszp的中文含义是： 厨师照片
	 */
	private String cszp;

	/**
	 * @Description cszpid的中文含义是： 厨师照片ID
	 */
	public void setCszpid(String cszpid) {
		this.cszpid = cszpid;
	}

	/**
	 * @Description cszpid的中文含义是： 厨师照片ID
	 */
	public String getCszpid() {
		return cszpid;
	}

	/**
	 * @Description cszp的中文含义是： 厨师照片
	 */
	public void setCszp(String cszp) {
		this.cszp = cszp;
	}

	/**
	 * @Description cszp的中文含义是： 厨师照片
	 */
	public String getCszp() {
		return cszp;
	}

	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	private Long fjid;

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	private String fjname;

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	private String fjpath;

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	private String fjtype;

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	private String fjcontent;

	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	public void setFjid(Long fjid) {
		this.fjid = fjid;
	}

	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	public Long getFjid() {
		return fjid;
	}

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	public void setFjname(String fjname) {
		this.fjname = fjname;
	}

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	public String getFjname() {
		return fjname;
	}

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
	}

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	public String getFjpath() {
		return fjpath;
	}

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	public void setFjtype(String fjtype) {
		this.fjtype = fjtype;
	}

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	public String getFjtype() {
		return fjtype;
	}

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public void setFjcontent(String fjcontent) {
		this.fjcontent = fjcontent;
	}

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public String getFjcontent() {
		return fjcontent;
	}

	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
	private String jcsbid;

	/**
	 * @Description jcsbbh的中文含义是： 聚餐申报编号
	 */
	private String jcsbbh;

	/**
	 * @Description jcsbjbrxm的中文含义是： 举办人姓名
	 */
	private String jcsbjbrxm;

	/**
	 * @Description jcsbjbrsjh的中文含义是： 举办人手机号
	 */
	private String jcsbjbrsjh;

	/**
	 * @Description jcsbjclx的中文含义是： 聚餐类型
	 */
	private String jcsbjclx;
	private String jcsbjclxstr;

	/**
	 * @Description jcsbjcdd的中文含义是： 聚餐地点
	 */
	private String jcsbjcdd;

	/**
	 * @Description jcsbjdzb的中文含义是： 聚餐地点经度坐标
	 */
	private String jcsbjdzb;

	/**
	 * @Description jcsbwdzb的中文含义是： 聚餐地点纬度坐标
	 */
	private String jcsbwdzb;

	/**
	 * @Description jcsbbjzt的中文含义是： 聚餐地点标记状态
	 */
	private String jcsbbjzt;

	/**
	 * @Description jcsbjcsj1的中文含义是： 聚餐时间1
	 */
	private String jcsbjcsj1;
	/**
	 * @Description jcsbjccc1的中文含义是： 聚餐餐次1
	 */
	private String jcsbjccc1;
	private String jcsbjccc1str;
	private String jcsbjccc2str;
	private String jcsbjccc3str;

	/**
	 * @Description jcsbjcsj2的中文含义是： 聚餐时间2
	 */
	private String jcsbjcsj2;
	/**
	 * @Description jcsbjccc2的中文含义是： 聚餐餐次2
	 */
	private String jcsbjccc2;

	/**
	 * @Description jcsbjcsj3的中文含义是： 聚餐时间3
	 */
	private String jcsbjcsj3;
	/**
	 * @Description jcsbjccc3的中文含义是： 聚餐餐次3
	 */
	private String jcsbjccc3;

	/**
	 * @Description jcsbjcrs的中文含义是： 聚餐人数
	 */
	private String jcsbjcrs;
	/**
	 * @Description jcsbjcgm的中文含义是： 聚餐规模
	 */
	private String jcsbjcgm;
	/**
	 * @Description jcsbylly的中文含义是： 原料来源
	 */
	private String jcsbylly;
	private String jcsbyllystr;

	/**
	 * @Description jcsbcsly的中文含义是： 厨师来源
	 */
	private String jcsbcsly;
	private String jcsbcslystr;
	/**
	 * @Description jcsbcyjly的中文含义是： 餐饮具来源
	 */
	private String jcsbcyjly;
	private String jcsbcyjlystr;
	/**
	 * @Description jgyxcjcbz的中文含义是： 监管员现场检查标志
	 */
	private String jgyxcjcbz;

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
	public void setJcsbjcsj1(String jcsbjcsj1) {
		this.jcsbjcsj1 = jcsbjcsj1;
	}

	/**
	 * @Description jcsbjcsj1的中文含义是： 聚餐时间1
	 */
	public String getJcsbjcsj1() {
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
	public void setJcsbjcsj2(String jcsbjcsj2) {
		this.jcsbjcsj2 = jcsbjcsj2;
	}

	/**
	 * @Description jcsbjcsj2的中文含义是： 聚餐时间2
	 */
	public String getJcsbjcsj2() {
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
	public void setJcsbjcsj3(String jcsbjcsj3) {
		this.jcsbjcsj3 = jcsbjcsj3;
	}

	/**
	 * @Description jcsbjcsj3的中文含义是： 聚餐时间3
	 */
	public String getJcsbjcsj3() {
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
	 * @Description jcsbcsid的中文含义是： 聚餐申报厨师id
	 */
	private String jcsbcsid;

	/**
	 * @Description jcsbcslx的中文含义是： 聚餐申报厨师类型
	 */
	private String jcsbcslx;

	/**
	 * @Description jcsbcsid的中文含义是： 聚餐申报厨师id
	 */
	public void setJcsbcsid(String jcsbcsid) {
		this.jcsbcsid = jcsbcsid;
	}

	/**
	 * @Description jcsbcsid的中文含义是： 聚餐申报厨师id
	 */
	public String getJcsbcsid() {
		return jcsbcsid;
	}

	/**
	 * @Description jcsbcslx的中文含义是： 聚餐申报厨师类型
	 */
	public void setJcsbcslx(String jcsbcslx) {
		this.jcsbcslx = jcsbcslx;
	}

	/**
	 * @Description jcsbcslx的中文含义是： 聚餐申报厨师类型
	 */
	public String getJcsbcslx() {
		return jcsbcslx;
	}

	/**
	 * @Description jcsbcdid的中文含义是： 聚餐申报菜单id
	 */
	private String jcsbcdid;

	/**
	 * @Description jcsbcdlx的中文含义是： 聚餐申报菜单类型
	 */
	private String jcsbcdlx;

	/**
	 * @Description jcsbcdmc的中文含义是： 聚餐申报菜单名
	 */
	private String jcsbcdmc;

	/**
	 * @Description jcsbcdid的中文含义是： 聚餐申报菜单id
	 */
	public void setJcsbcdid(String jcsbcdid) {
		this.jcsbcdid = jcsbcdid;
	}

	/**
	 * @Description jcsbcdid的中文含义是： 聚餐申报菜单id
	 */
	public String getJcsbcdid() {
		return jcsbcdid;
	}

	/**
	 * @Description jcsbcdlx的中文含义是： 聚餐申报菜单类型
	 */
	public void setJcsbcdlx(String jcsbcdlx) {
		this.jcsbcdlx = jcsbcdlx;
	}

	/**
	 * @Description jcsbcdlx的中文含义是： 聚餐申报菜单类型
	 */
	public String getJcsbcdlx() {
		return jcsbcdlx;
	}

	/**
	 * @Description jcsbcdmc的中文含义是： 聚餐申报菜单名
	 */
	public void setJcsbcdmc(String jcsbcdmc) {
		this.jcsbcdmc = jcsbcdmc;
	}

	/**
	 * @Description jcsbcdmc的中文含义是： 聚餐申报菜单名
	 */
	public String getJcsbcdmc() {
		return jcsbcdmc;
	}

	/**
	 * @Description jcsbpswpid的中文含义是： 聚餐申报配送物品id
	 */
	private String jcsbpswpid;

	/**
	 * @Description jcsbpswplx的中文含义是： 聚餐申报配送物品类型
	 */
	private String jcsbpswplx;

	/**
	 * @Description jcsbpswpmc的中文含义是： 聚餐申报配送物品名称
	 */
	private String jcsbpswpmc;

	/**
	 * @Description jcsbpswppp的中文含义是： 聚餐申报配送物品品牌
	 */
	private String jcsbpswppp;

	/**
	 * @Description jcsbpswpsl的中文含义是： 聚餐申报配送物品数量
	 */
	private String jcsbpswpsl;

	/**
	 * @Description jcsbpswpid的中文含义是： 聚餐申报配送物品id
	 */
	public void setJcsbpswpid(String jcsbpswpid) {
		this.jcsbpswpid = jcsbpswpid;
	}

	/**
	 * @Description jcsbpswpid的中文含义是： 聚餐申报配送物品id
	 */
	public String getJcsbpswpid() {
		return jcsbpswpid;
	}

	/**
	 * @Description jcsbpswplx的中文含义是： 聚餐申报配送物品类型
	 */
	public void setJcsbpswplx(String jcsbpswplx) {
		this.jcsbpswplx = jcsbpswplx;
	}

	/**
	 * @Description jcsbpswplx的中文含义是： 聚餐申报配送物品类型
	 */
	public String getJcsbpswplx() {
		return jcsbpswplx;
	}

	/**
	 * @Description jcsbpswpmc的中文含义是： 聚餐申报配送物品名称
	 */
	public void setJcsbpswpmc(String jcsbpswpmc) {
		this.jcsbpswpmc = jcsbpswpmc;
	}

	/**
	 * @Description jcsbpswpmc的中文含义是： 聚餐申报配送物品名称
	 */
	public String getJcsbpswpmc() {
		return jcsbpswpmc;
	}

	/**
	 * @Description jcsbpswppp的中文含义是： 聚餐申报配送物品品牌
	 */
	public void setJcsbpswppp(String jcsbpswppp) {
		this.jcsbpswppp = jcsbpswppp;
	}

	/**
	 * @Description jcsbpswppp的中文含义是： 聚餐申报配送物品品牌
	 */
	public String getJcsbpswppp() {
		return jcsbpswppp;
	}

	/**
	 * @Description jcsbpswpsl的中文含义是： 聚餐申报配送物品数量
	 */
	public void setJcsbpswpsl(String jcsbpswpsl) {
		this.jcsbpswpsl = jcsbpswpsl;
	}

	/**
	 * @Description jcsbpswpsl的中文含义是： 聚餐申报配送物品数量
	 */
	public String getJcsbpswpsl() {
		return jcsbpswpsl;
	}

	/**
	 * @Description jcsbjgyid的中文含义是： 聚餐申报指派监管员表id
	 */
	private String jcsbjgyid;

	/**
	 * @Description userid的中文含义是： 监管员id
	 */
	private String userid;

	/**
	 * @Description jcsbjgyid的中文含义是： 聚餐申报指派监管员表id
	 */
	public void setJcsbjgyid(String jcsbjgyid) {
		this.jcsbjgyid = jcsbjgyid;
	}

	/**
	 * @Description jcsbjgyid的中文含义是： 聚餐申报指派监管员表id
	 */
	public String getJcsbjgyid() {
		return jcsbjgyid;
	}

	/**
	 * @Description userid的中文含义是： 监管员id
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

	/**
	 * @Description userid的中文含义是： 监管员id
	 */
	public String getUserid() {
		return userid;
	}

	/**
	 * @Description dwid的中文含义是： 定位ID
	 */
	private String dwid;

	/**
	 * @Description dwjdzb的中文含义是： 经度坐标
	 */
	private String dwjdzb;

	/**
	 * @Description dwwdzb的中文含义是： 纬度坐标
	 */
	private String dwwdzb;

	/**
	 * @Description dwdd的中文含义是： 定位地点
	 */
	private String dwdd;

	/**
	 * @Description dwsj的中文含义是： 定位时间
	 */
	private String dwsj;

	/**
	 * @Description dwfs的中文含义是： 定位方式
	 */
	private String dwfs;
	
	/**
	 * @Description dwid的中文含义是： 定位ID
	 */
	public void setDwid(String dwid) {
		this.dwid = dwid;
	}

	/**
	 * @Description dwid的中文含义是： 定位ID
	 */
	public String getDwid() {
		return dwid;
	}

	/**
	 * @Description dwjdzb的中文含义是： 经度坐标
	 */
	public void setDwjdzb(String dwjdzb) {
		this.dwjdzb = dwjdzb;
	}

	/**
	 * @Description dwjdzb的中文含义是： 经度坐标
	 */
	public String getDwjdzb() {
		return dwjdzb;
	}

	/**
	 * @Description dwwdzb的中文含义是： 纬度坐标
	 */
	public void setDwwdzb(String dwwdzb) {
		this.dwwdzb = dwwdzb;
	}

	/**
	 * @Description dwwdzb的中文含义是： 纬度坐标
	 */
	public String getDwwdzb() {
		return dwwdzb;
	}

	/**
	 * @Description dwdd的中文含义是： 定位地点
	 */
	public void setDwdd(String dwdd) {
		this.dwdd = dwdd;
	}

	/**
	 * @Description dwdd的中文含义是： 定位地点
	 */
	public String getDwdd() {
		return dwdd;
	}

	/**
	 * @Description dwsj的中文含义是： 定位时间
	 */
	public void setDwsj(String dwsj) {
		this.dwsj = dwsj;
	}

	/**
	 * @Description dwsj的中文含义是： 定位时间
	 */
	public String getDwsj() {
		return dwsj;
	}

	/**
	 * @Description dwfs的中文含义是： 定位方式
	 */
	public String getDwfs() {
		return dwfs;
	}
	/**
	 * @Description dwfs的中文含义是： 定位方式
	 */
	public void setDwfs(String dwfs) {
		this.dwfs = dwfs;
	}

	public String getItemid() {
		return itemid;
	}

	public void setItemid(String itemid) {
		this.itemid = itemid;
	}

	public String getJcsbjclxstr() {
		return jcsbjclxstr;
	}

	public void setJcsbjclxstr(String jcsbjclxstr) {
		this.jcsbjclxstr = jcsbjclxstr;
	} 
	public String getJcsbjccc1str() {
		return jcsbjccc1str;
	}

	public void setJcsbjccc1str(String jcsbjccc1str) {
		this.jcsbjccc1str = jcsbjccc1str;
	}

	public String getJcsbjccc2str() {
		return jcsbjccc2str;
	}

	public void setJcsbjccc2str(String jcsbjccc2str) {
		this.jcsbjccc2str = jcsbjccc2str;
	}

	public String getJcsbjccc3str() {
		return jcsbjccc3str;
	}

	public void setJcsbjccc3str(String jcsbjccc3str) {
		this.jcsbjccc3str = jcsbjccc3str;
	}

	public String getJcsbyllystr() {
		return jcsbyllystr;
	}

	public void setJcsbyllystr(String jcsbyllystr) {
		this.jcsbyllystr = jcsbyllystr;
	}

	public String getJcsbcslystr() {
		return jcsbcslystr;
	}

	public void setJcsbcslystr(String jcsbcslystr) {
		this.jcsbcslystr = jcsbcslystr;
	}

	public String getJcsbcyjlystr() {
		return jcsbcyjlystr;
	}

	public void setJcsbcyjlystr(String jcsbcyjlystr) {
		this.jcsbcyjlystr = jcsbcyjlystr;
	}

}
