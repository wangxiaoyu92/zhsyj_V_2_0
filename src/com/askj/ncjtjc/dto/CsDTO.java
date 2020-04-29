package com.askj.ncjtjc.dto;

import java.sql.Timestamp;

/**
 * @Description CS的中文含义是: 厨师信息表DTO
 * @Creation 2015/12/30 16:58:13
 * @Written Create Tool By zjf
 **/
public class CsDTO {

	// 文件上传
	private String filepath;
	private String message;
	private String succJsonStr;
	private String errorJsonStr;

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

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
	private String cssfzjlxstr;

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
	private String cswhcdstr;

	/**
	 * @Description cscynx的中文含义是： 厨师从业年限
	 */
	private String cscynx;
	private String cscynxstr;

	/**
	 * @Description csjkzm的中文含义是： 厨师健康证明
	 */
	private String csjkzm;
	private String csjkzmstr;

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
	private String cspxqkstr;

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
	 * @Description aaa027name的中文含义是： 统筹区名称
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
	/**
	 * @Description jcsbid的中文含义是： 聚餐申报id
	 */
    private String jcsbid;

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
	 * @Description fjid的中文含义是： 附件ID
	 */
	public Long getFjid() {
		return fjid;
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

	public String getJcsbid() {
		return jcsbid;
	}

	public void setJcsbid(String jcsbid) {
		this.jcsbid = jcsbid;
	}

	public void setFjid(Long fjid) {
		this.fjid = fjid;
	}

	public String getCssfzjlxstr() {
		return cssfzjlxstr;
	}

	public void setCssfzjlxstr(String cssfzjlxstr) {
		this.cssfzjlxstr = cssfzjlxstr;
	}

	public String getCswhcdstr() {
		return cswhcdstr;
	}

	public void setCswhcdstr(String cswhcdstr) {
		this.cswhcdstr = cswhcdstr;
	}

	public String getCscynxstr() {
		return cscynxstr;
	}

	public void setCscynxstr(String cscynxstr) {
		this.cscynxstr = cscynxstr;
	}

	public String getCsjkzmstr() {
		return csjkzmstr;
	}

	public void setCsjkzmstr(String csjkzmstr) {
		this.csjkzmstr = csjkzmstr;
	}

	public String getCspxqkstr() {
		return cspxqkstr;
	}

	public void setCspxqkstr(String cspxqkstr) {
		this.cspxqkstr = cspxqkstr;
	}
	
	
}