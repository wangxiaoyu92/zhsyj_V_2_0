package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Bscompany")
public class Bscompany {
/** 公司企业表; InnoDB free: 315392 kB  */
	/** COM_ID 的中文含义是：企业ID*/
	@Name
	@Column(value="COM_ID")
	private String comId;

	/** COM_USER_NAME 的中文含义是：登录用户名*/
	@Column(value="COM_USER_NAME")
	private String comUserName;

	/** COM_PWD 的中文含义是：登录密码*/
	@Column(value="COM_PWD")
	private String comPwd;

	/** COM_MC 的中文含义是：公司名称*/
	@Column(value="COM_MC")
	private String comMc;

	/** COM_ZJHM 的中文含义是：营业执照号*/
	@Column(value="COM_ZJHM")
	private String comZjhm;

	/** COM_DM 的中文含义是：企业代码：企业类型字母+6位行政区域代码+9位序列号*/
	@Column(value="COM_DM")
	private String comDm;

	/** COM_LXR 的中文含义是：联系人*/
	@Column(value="COM_LXR")
	private String comLxr;

	/** COM_LXDH 的中文含义是：联系固定电话*/
	@Column(value="COM_LXDH")
	private String comLxdh;

	/** COM_ADDRESS 的中文含义是：公司地址*/
	@Column(value="COM_ADDRESS")
	private String comAddress;

	/** COM_SHBZ 的中文含义是：审核标志 Y通过 N未通过 M 等待审核*/
	@Column(value="COM_SHBZ")
	private String comShbz;

	/** COM_SHRID 的中文含义是：审核人ID(默认审核人ID=3)*/
	@Column(value="COM_SHRID")
	private Long comShrid;

	/** COM_SHSJ 的中文含义是：审核时间*/
	@Column(value="COM_SHSJ")
	private Timestamp comShsj;

	/** COM_QYLX 的中文含义是：企业类型ID ：参照BS_QYLX*/
	@Column(value="COM_QYLX")
	private String comQylx;

	/** COM_QYXZ 的中文含义是：1国有 2集体 3股份 4私营 5合资 6外资 7其他*/
	@Column(value="COM_QYXZ")
	private String comQyxz;

	/** COM_PROVINCE_DM 的中文含义是：省份代码*/
	@Column(value="COM_PROVINCE_DM")
	private String comProvinceDm;

	/** COM_CITY_DM 的中文含义是：市代码*/
	@Column(value="COM_CITY_DM")
	private String comCityDm;

	/** COM_COUNTY_DM 的中文含义是：县区代码*/
	@Column(value="COM_COUNTY_DM")
	private String comCountyDm;

	/** COM_WEB 的中文含义是：网址*/
	@Column(value="COM_WEB")
	private String comWeb;

	/** COM_EMAIL 的中文含义是：电子邮件*/
	@Column(value="COM_EMAIL")
	private String comEmail;

	/** COM_PROVINCE 的中文含义是：省份名称*/
	@Column(value="COM_PROVINCE")
	private String comProvince;

	/** COM_CITY 的中文含义是：市名称*/
	@Column(value="COM_CITY")
	private String comCity;

	/** COM_COUNTY 的中文含义是：县区名称*/
	@Column(value="COM_COUNTY")
	private String comCounty;

	/** COM_WTGYY 的中文含义是：审核未通过原因*/
	@Column(value="COM_WTGYY")
	private String comWtgyy;

	/** COM_FAX 的中文含义是：传真*/
	@Column(value="COM_FAX")
	private String comFax;

	/** COM_ZIP 的中文含义是：邮编*/
	@Column(value="COM_ZIP")
	private String comZip;

	/** COM_LXSJ 的中文含义是：联系手机*/
	@Column(value="COM_LXSJ")
	private String comLxsj;

	/** COM_JJXZ 的中文含义是：营业执照上的经济性质或者企业名称预核准上的的经济类型*/
	@Column(value="COM_JJXZ")
	private String comJjxz;

	/** COM_ZZJGDM 的中文含义是：组织机构代码*/
	@Column(value="COM_ZZJGDM")
	private String comZzjgdm;

	/** COM_GSDJJG 的中文含义是：营业执照上的登记机构全称*/
	@Column(value="COM_GSDJJG")
	private String comGsdjjg;

	/** COM_CLRQ 的中文含义是：公司成立日期*/
	@Column(value="COM_CLRQ")
	private Timestamp comClrq;

	/** COM_JYQX 的中文含义是：营业执照上的经营期限*/
	@Column(value="COM_JYQX")
	private String comJyqx;

	/** COM_ZCZJ 的中文含义是：注册资金（万元）*/
	@Column(value="COM_ZCZJ")
	private Long comZczj;

	/** COM_FDDBR 的中文含义是：法定代表人*/
	@Column(value="COM_FDDBR")
	private String comFddbr;

	/** COM_ZCLB 的中文含义是：1企业自行注册2 操作员添加注册*/
	@Column(value="COM_ZCLB")
	private String comZclb;

	/** COM_DZCRID 的中文含义是：代企业注册的操作人ID*/
	@Column(value="COM_DZCRID")
	private Long comDzcrid;

	/** COM_DZCSJ 的中文含义是：代注册时间*/
	@Column(value="COM_DZCSJ")
	private Timestamp comDzcsj;

	/** QYMC 的中文含义是：企业名称*/
	@Column(value="QYMC")
	private String qymc;

	/** QYYWMC 的中文含义是：企业英文名称*/
	@Column(value="QYYWMC")
	private String qyywmc;

	/** YLJGMC 的中文含义是：医疗机构名称*/
	@Column(value="YLJGMC")
	private String yljgmc;

	/** ZZJGDM 的中文含义是：组织机构代码*/
	@Column(value="ZZJGDM")
	private String zzjgdm;

	/** YYZZZCH 的中文含义是：营业执照注册号*/
	@Column(value="YYZZZCH")
	private String yyzzzch;

	/** ZCZJ 的中文含义是：注册资金*/
	@Column(value="ZCZJ")
	private Float zczj;

	/** tzzb 的中文含义是：投资资本*/
	@Column
	private Float tzzb;

	/** JYFS 的中文含义是：经营方式*/
	@Column(value="JYFS")
	private String jyfs;

	/** QYLX 的中文含义是：企业类型*/
	@Column(value="QYLX")
	private String qylx;

	/** FDDBR 的中文含义是：法定代表人*/
	@Column(value="FDDBR")
	private String fddbr;

	/** FRDB 的中文含义是：法人代表*/
	@Column(value="FRDB")
	private String frdb;

	/** QYGM 的中文含义是：企业规模*/
	@Column(value="QYGM")
	private String qygm;

	/** QYRS 的中文含义是：企业人数*/
	@Column(value="QYRS")
	private Long qyrs;

	/** QYSJSJ 的中文含义是：企业始建时间*/
	@Column(value="QYSJSJ")
	private Timestamp qysjsj;

	/** QYZJGMSJ 的中文含义是：企业最近更名时间*/
	@Column(value="QYZJGMSJ")
	private Timestamp qyzjgmsj;

	/** QYLXDHHM 的中文含义是：企业联系电话号码*/
	@Column(value="QYLXDHHM")
	private String qylxdhhm;

	/** QYLXCZHM 的中文含义是：企业联系传真号码*/
	@Column(value="QYLXCZHM")
	private String qylxczhm;

	/** QYWZ 的中文含义是：企业网址*/
	@Column(value="QYWZ")
	private String qywz;

	/** QYFZRXM 的中文含义是：企业负责人姓名*/
	@Column(value="QYFZRXM")
	private String qyfzrxm;

	/** QYLXRXM 的中文含义是：企业联系人姓名*/
	@Column(value="QYLXRXM")
	private String qylxrxm;

	/** ZCDZ 的中文含义是：注册地址*/
	@Column(value="ZCDZ")
	private String zcdz;

	/** ZCDZYW 的中文含义是：注册地址(英文)*/
	@Column(value="ZCDZYW")
	private String zcdzyw;

	/** SCDZ 的中文含义是：生产地址*/
	@Column(value="SCDZ")
	private String scdz;

	/** SCDZYW 的中文含义是：生产地址(英文)*/
	@Column(value="SCDZYW")
	private String scdzyw;

	/** TXDZ 的中文含义是：通信地址*/
	@Column(value="TXDZ")
	private String txdz;

	/** YZBM 的中文含义是：邮政编码*/
	@Column(value="YZBM")
	private String yzbm;

	/** DZGJHDQ 的中文含义是：地址-国家/或地区*/
	@Column(value="DZGJHDQ")
	private String dzgjhdq;

	/** DZSZXSZZQ 的中文含义是：地址-省/直辖市/自治区*/
	@Column(value="DZSZXSZZQ")
	private String dzszxszzq;

	/** DZSQZZZM 的中文含义是：地址-市/区/自治州/盟*/
	@Column(value="DZSQZZZM")
	private String dzsqzzzm;

	/** DZXZZXXJS 的中文含义是：地址-县/自治县/县级市*/
	@Column(value="DZXZZXXJS")
	private String dzxzzxxjs;

	/** DZXZJDBSC 的中文含义是：地址-乡/镇/街道办事处*/
	@Column(value="DZXZJDBSC")
	private String dzxzjdbsc;

	/** DZCJLND 的中文含义是：地址-村/街/路/弄等*/
	@Column(value="DZCJLND")
	private String dzcjlnd;

	/** DZMPHM 的中文含义是：地址-门牌号码*/
	@Column(value="DZMPHM")
	private String dzmphm;

	/** YPSCXKZBH 的中文含义是：药品生产许可证编号*/
	@Column(value="YPSCXKZBH")
	private String ypscxkzbh;

	/** YPGMPZSBH 的中文含义是：药品GMP证书编号*/
	@Column(value="YPGMPZSBH")
	private String ypgmpzsbh;

	/** YPJYXKZH 的中文含义是：药品经营许可证号*/
	@Column(value="YPJYXKZH")
	private String ypjyxkzh;

	/** YPJYZLGLGFRZZSBH 的中文含义是：药品经营质量管理规范认证证书编号*/
	@Column(value="YPJYZLGLGFRZZSBH")
	private String ypjyzlglgfrzzsbh;

	/** YLQXSCXKZH 的中文含义是：医疗器械生产许可证号*/
	@Column(value="YLQXSCXKZH")
	private String ylqxscxkzh;

	/** FZJG 的中文含义是：发证机关*/
	@Column(value="FZJG")
	private String fzjg;

	/** FZRQ 的中文含义是：发证日期*/
	@Column(value="FZRQ")
	private Timestamp fzrq;

	/** ZJZSYXQQSRQ 的中文含义是：证件/证书有效期起始日期*/
	@Column(value="ZJZSYXQQSRQ")
	private Timestamp zjzsyxqqsrq;

	/** ZJZSYXQZZRQ 的中文含义是：证件/证书有效期终止日期*/
	@Column(value="ZJZSYXQZZRQ")
	private Timestamp zjzsyxqzzrq;

	/** CPZCDLJG 的中文含义是：产品注册代理机构*/
	@Column(value="CPZCDLJG")
	private String cpzcdljg;

	/** CPDLR 的中文含义是：产品代理人*/
	@Column(value="CPDLR")
	private String cpdlr;

	/** CPSHFWJG 的中文含义是：产品售后服务机构*/
	@Column(value="CPSHFWJG")
	private String cpshfwjg;

	/** WTYJJG 的中文含义是：委托研究机构*/
	@Column(value="WTYJJG")
	private String wtyjjg;

	/** QYZJBMMC 的中文含义是：企业质监部门名称*/
	@Column(value="QYZJBMMC")
	private String qyzjbmmc;

	/** QYZJBMGJJSZCRS 的中文含义是：企业质监部门高级技术职称人数*/
	@Column(value="QYZJBMGJJSZCRS")
	private Long qyzjbmgjjszcrs;

	/** QYZJBMZJJSZCRS 的中文含义是：企业质监部门中级技术职称人数*/
	@Column(value="QYZJBMZJJSZCRS")
	private Long qyzjbmzjjszcrs;

	/** QYZCDZYBHPZS 的中文含义是：企业注册的中药保护品种数*/
	@Column(value="QYZCDZYBHPZS")
	private Long qyzcdzybhpzs;

	/** GDZCYZ 的中文含义是：固定资产原值*/
	@Column(value="GDZCYZ")
	private Long gdzcyz;

	/** GDZCJZ 的中文含义是：固定资产净值*/
	@Column(value="GDZCJZ")
	private Long gdzcjz;

	/** SNDXSE 的中文含义是：上年度销售额*/
	@Column(value="SNDXSE")
	private Float sndxse;

	/** SNDLS 的中文含义是：上年度利税*/
	@Column(value="SNDLS")
	private Float sndls;

	/** SNGYZCZ 的中文含义是：上年工业总产值*/
	@Column(value="SNGYZCZ")
	private Long sngyzcz;

	/** SNXSSR 的中文含义是：上年销售收入*/
	@Column(value="SNXSSR")
	private Long snxssr;

	/** nxse_f 的中文含义是：连续三年销售额 第一年*/
	@Column(value="nxse_f")
	private Float nxseF;

	/** nxse_s 的中文含义是：连续三年销售额 第二年*/
	@Column(value="nxse_s")
	private Float nxseS;

	/** nxse_t 的中文含义是：连续三年销售额 第三年*/
	@Column(value="nxse_t")
	private Float nxseT;

	/** SNLR 的中文含义是：上年利润*/
	@Column(value="SNLR")
	private Float snlr;

	/** SNSJ 的中文含义是：上年税金*/
	@Column(value="SNSJ")
	private Long snsj;

	/** SNCH 的中文含义是：上年创汇*/
	@Column(value="SNCH")
	private Long snch;

	/** ZYJSRYBL 的中文含义是：专业技术人员比例*/
	@Column(value="ZYJSRYBL")
	private Long zyjsrybl;

	/** ZLSQR 的中文含义是：质量受权人*/
	@Column(value="ZLSQR")
	private String zlsqr;

	/** ZLFZR 的中文含义是：质量负责人*/
	@Column(value="ZLFZR")
	private String zlfzr;

	/** ZLFZRS 的中文含义是：质量负责人数*/
	@Column(value="ZLFZRS")
	private Long zlfzrs;

	/** SCFZR 的中文含义是：生产负责人*/
	@Column(value="SCFZR")
	private String scfzr;

	/** SCFZRS 的中文含义是：生产负责人数*/
	@Column(value="SCFZRS")
	private Long scfzrs;

	/** ZYYSRS 的中文含义是：执业药师人数*/
	@Column(value="ZYYSRS")
	private Long zyysrs;

	/** ZRYSRS 的中文含义是：主任药师人数*/
	@Column(value="ZRYSRS")
	private Long zrysrs;

	/** FZRYSRS 的中文含义是：副主任药师人数*/
	@Column(value="FZRYSRS")
	private Long fzrysrs;

	/** ZGYSRS 的中文含义是：主管药师人数*/
	@Column(value="ZGYSRS")
	private Long zgysrs;

	/** YSRS01 的中文含义是：药师人数*/
	@Column(value="YSRS01")
	private Long ysrs01;

	/** YSRS02 的中文含义是：药士人数*/
	@Column(value="YSRS02")
	private Long ysrs02;

	/** CQZDMJ 的中文含义是：厂区占地面积*/
	@Column(value="CQZDMJ")
	private Long cqzdmj;

	/** JZMJ 的中文含义是：建筑面积*/
	@Column(value="JZMJ")
	private Float jzmj;

	/** scmj 的中文含义是：生产面积*/
	@Column
	private Float scmj;

	/** jhmj 的中文含义是：净化面积*/
	@Column
	private Float jhmj;

	/** jymj 的中文含义是：检验面积*/
	@Column
	private Float jymj;

	/** yclccmj 的中文含义是：原材料仓储面积*/
	@Column
	private Float yclccmj;

	/** cpccmj 的中文含义是：成品仓储面积*/
	@Column
	private Float cpccmj;

	/** YLJGBZCWS 的中文含义是：医疗机构编制床位数*/
	@Column(value="YLJGBZCWS")
	private Long yljgbzcws;

	/** QYZXBZ 的中文含义是：企业注销标志*/
	@Column(value="QYZXBZ")
	private String qyzxbz;

	/** QYZXRQ 的中文含义是：企业注销日期*/
	@Column(value="QYZXRQ")
	private Timestamp qyzxrq;

	/** QYZXYY 的中文含义是：企业注销原因*/
	@Column(value="QYZXYY")
	private String qyzxyy;

	/** QYSSMGSMC 的中文含义是：企业所属母公司名称*/
	@Column(value="QYSSMGSMC")
	private String qyssmgsmc;

	/** QYSSMGSDZ 的中文含义是：企业所属母公司地址*/
	@Column(value="QYSSMGSDZ")
	private String qyssmgsdz;

	/** WFGBHDQ 的中文含义是：外方国别或地区*/
	@Column(value="WFGBHDQ")
	private String wfgbhdq;

	/** GYSMC 的中文含义是：供应商名称*/
	@Column(value="GYSMC")
	private String gysmc;

	/** CPJXSMC 的中文含义是：产品经销商名称*/
	@Column(value="CPJXSMC")
	private String cpjxsmc;

	/** FDDBRSFZ 的中文含义是：法定代表人身份证号*/
	@Column(value="FDDBRSFZ")
	private String fddbrsfz;

	/** FDDBRLXDH 的中文含义是：法定代表人联系电话*/
	@Column(value="FDDBRLXDH")
	private String fddbrlxdh;

	/** ZCLY 的中文含义是：注册来源  1企业主动注册 2工商数据资料补齐生成*/
	@Column(value="ZCLY")
	private String zcly;

	/** UUID 的中文含义是：UUID*/
	@Column(value="UUID")
	private String uuid;

	/** LX_DL 的中文含义是：企业类型所属的大类，对应bs_qylxl中的x_dl*/
	@Column(value="LX_DL")
	private String lxDl;

	/** zjlx 的中文含义是：证件类型 01 社会信用代码 02 营业执照号 03身份证*/
	@Column
	private String zjlx;

	/** zycp 的中文含义是：主要产品*/
	@Column
	private String zycp;

	/** ncl 的中文含义是：年产量*/
	@Column
	private String ncl;

	/** sjc 的中文含义是：更新时间戳*/
	@Column
	private Timestamp sjc;


	public void setComId(String comId){
		this.comId=comId;
	}

	public String getComId(){
		return comId;
	}

	public void setComUserName(String comUserName){
		this.comUserName=comUserName;
	}

	public String getComUserName(){
		return comUserName;
	}

	public void setComPwd(String comPwd){
		this.comPwd=comPwd;
	}

	public String getComPwd(){
		return comPwd;
	}

	public void setComMc(String comMc){
		this.comMc=comMc;
	}

	public String getComMc(){
		return comMc;
	}

	public void setComZjhm(String comZjhm){
		this.comZjhm=comZjhm;
	}

	public String getComZjhm(){
		return comZjhm;
	}

	public void setComDm(String comDm){
		this.comDm=comDm;
	}

	public String getComDm(){
		return comDm;
	}

	public void setComLxr(String comLxr){
		this.comLxr=comLxr;
	}

	public String getComLxr(){
		return comLxr;
	}

	public void setComLxdh(String comLxdh){
		this.comLxdh=comLxdh;
	}

	public String getComLxdh(){
		return comLxdh;
	}

	public void setComAddress(String comAddress){
		this.comAddress=comAddress;
	}

	public String getComAddress(){
		return comAddress;
	}

	public void setComShbz(String comShbz){
		this.comShbz=comShbz;
	}

	public String getComShbz(){
		return comShbz;
	}

	public void setComShrid(Long comShrid){
		this.comShrid=comShrid;
	}

	public Long getComShrid(){
		return comShrid;
	}

	public void setComShsj(Timestamp comShsj){
		this.comShsj=comShsj;
	}

	public Timestamp getComShsj(){
		return comShsj;
	}

	public void setComQylx(String comQylx){
		this.comQylx=comQylx;
	}

	public String getComQylx(){
		return comQylx;
	}

	public void setComQyxz(String comQyxz){
		this.comQyxz=comQyxz;
	}

	public String getComQyxz(){
		return comQyxz;
	}

	public void setComProvinceDm(String comProvinceDm){
		this.comProvinceDm=comProvinceDm;
	}

	public String getComProvinceDm(){
		return comProvinceDm;
	}

	public void setComCityDm(String comCityDm){
		this.comCityDm=comCityDm;
	}

	public String getComCityDm(){
		return comCityDm;
	}

	public void setComCountyDm(String comCountyDm){
		this.comCountyDm=comCountyDm;
	}

	public String getComCountyDm(){
		return comCountyDm;
	}

	public void setComWeb(String comWeb){
		this.comWeb=comWeb;
	}

	public String getComWeb(){
		return comWeb;
	}

	public void setComEmail(String comEmail){
		this.comEmail=comEmail;
	}

	public String getComEmail(){
		return comEmail;
	}

	public void setComProvince(String comProvince){
		this.comProvince=comProvince;
	}

	public String getComProvince(){
		return comProvince;
	}

	public void setComCity(String comCity){
		this.comCity=comCity;
	}

	public String getComCity(){
		return comCity;
	}

	public void setComCounty(String comCounty){
		this.comCounty=comCounty;
	}

	public String getComCounty(){
		return comCounty;
	}

	public void setComWtgyy(String comWtgyy){
		this.comWtgyy=comWtgyy;
	}

	public String getComWtgyy(){
		return comWtgyy;
	}

	public void setComFax(String comFax){
		this.comFax=comFax;
	}

	public String getComFax(){
		return comFax;
	}

	public void setComZip(String comZip){
		this.comZip=comZip;
	}

	public String getComZip(){
		return comZip;
	}

	public void setComLxsj(String comLxsj){
		this.comLxsj=comLxsj;
	}

	public String getComLxsj(){
		return comLxsj;
	}

	public void setComJjxz(String comJjxz){
		this.comJjxz=comJjxz;
	}

	public String getComJjxz(){
		return comJjxz;
	}

	public void setComZzjgdm(String comZzjgdm){
		this.comZzjgdm=comZzjgdm;
	}

	public String getComZzjgdm(){
		return comZzjgdm;
	}

	public void setComGsdjjg(String comGsdjjg){
		this.comGsdjjg=comGsdjjg;
	}

	public String getComGsdjjg(){
		return comGsdjjg;
	}

	public void setComClrq(Timestamp comClrq){
		this.comClrq=comClrq;
	}

	public Timestamp getComClrq(){
		return comClrq;
	}

	public void setComJyqx(String comJyqx){
		this.comJyqx=comJyqx;
	}

	public String getComJyqx(){
		return comJyqx;
	}

	public void setComZczj(Long comZczj){
		this.comZczj=comZczj;
	}

	public Long getComZczj(){
		return comZczj;
	}

	public void setComFddbr(String comFddbr){
		this.comFddbr=comFddbr;
	}

	public String getComFddbr(){
		return comFddbr;
	}

	public void setComZclb(String comZclb){
		this.comZclb=comZclb;
	}

	public String getComZclb(){
		return comZclb;
	}

	public void setComDzcrid(Long comDzcrid){
		this.comDzcrid=comDzcrid;
	}

	public Long getComDzcrid(){
		return comDzcrid;
	}

	public void setComDzcsj(Timestamp comDzcsj){
		this.comDzcsj=comDzcsj;
	}

	public Timestamp getComDzcsj(){
		return comDzcsj;
	}

	public void setQymc(String qymc){
		this.qymc=qymc;
	}

	public String getQymc(){
		return qymc;
	}

	public void setQyywmc(String qyywmc){
		this.qyywmc=qyywmc;
	}

	public String getQyywmc(){
		return qyywmc;
	}

	public void setYljgmc(String yljgmc){
		this.yljgmc=yljgmc;
	}

	public String getYljgmc(){
		return yljgmc;
	}

	public void setZzjgdm(String zzjgdm){
		this.zzjgdm=zzjgdm;
	}

	public String getZzjgdm(){
		return zzjgdm;
	}

	public void setYyzzzch(String yyzzzch){
		this.yyzzzch=yyzzzch;
	}

	public String getYyzzzch(){
		return yyzzzch;
	}

	public void setZczj(Float zczj){
		this.zczj=zczj;
	}

	public Float getZczj(){
		return zczj;
	}

	public void setTzzb(Float tzzb){
		this.tzzb=tzzb;
	}

	public Float getTzzb(){
		return tzzb;
	}

	public void setJyfs(String jyfs){
		this.jyfs=jyfs;
	}

	public String getJyfs(){
		return jyfs;
	}

	public void setQylx(String qylx){
		this.qylx=qylx;
	}

	public String getQylx(){
		return qylx;
	}

	public void setFddbr(String fddbr){
		this.fddbr=fddbr;
	}

	public String getFddbr(){
		return fddbr;
	}

	public void setFrdb(String frdb){
		this.frdb=frdb;
	}

	public String getFrdb(){
		return frdb;
	}

	public void setQygm(String qygm){
		this.qygm=qygm;
	}

	public String getQygm(){
		return qygm;
	}

	public void setQyrs(Long qyrs){
		this.qyrs=qyrs;
	}

	public Long getQyrs(){
		return qyrs;
	}

	public void setQysjsj(Timestamp qysjsj){
		this.qysjsj=qysjsj;
	}

	public Timestamp getQysjsj(){
		return qysjsj;
	}

	public void setQyzjgmsj(Timestamp qyzjgmsj){
		this.qyzjgmsj=qyzjgmsj;
	}

	public Timestamp getQyzjgmsj(){
		return qyzjgmsj;
	}

	public void setQylxdhhm(String qylxdhhm){
		this.qylxdhhm=qylxdhhm;
	}

	public String getQylxdhhm(){
		return qylxdhhm;
	}

	public void setQylxczhm(String qylxczhm){
		this.qylxczhm=qylxczhm;
	}

	public String getQylxczhm(){
		return qylxczhm;
	}

	public void setQywz(String qywz){
		this.qywz=qywz;
	}

	public String getQywz(){
		return qywz;
	}

	public void setQyfzrxm(String qyfzrxm){
		this.qyfzrxm=qyfzrxm;
	}

	public String getQyfzrxm(){
		return qyfzrxm;
	}

	public void setQylxrxm(String qylxrxm){
		this.qylxrxm=qylxrxm;
	}

	public String getQylxrxm(){
		return qylxrxm;
	}

	public void setZcdz(String zcdz){
		this.zcdz=zcdz;
	}

	public String getZcdz(){
		return zcdz;
	}

	public void setZcdzyw(String zcdzyw){
		this.zcdzyw=zcdzyw;
	}

	public String getZcdzyw(){
		return zcdzyw;
	}

	public void setScdz(String scdz){
		this.scdz=scdz;
	}

	public String getScdz(){
		return scdz;
	}

	public void setScdzyw(String scdzyw){
		this.scdzyw=scdzyw;
	}

	public String getScdzyw(){
		return scdzyw;
	}

	public void setTxdz(String txdz){
		this.txdz=txdz;
	}

	public String getTxdz(){
		return txdz;
	}

	public void setYzbm(String yzbm){
		this.yzbm=yzbm;
	}

	public String getYzbm(){
		return yzbm;
	}

	public void setDzgjhdq(String dzgjhdq){
		this.dzgjhdq=dzgjhdq;
	}

	public String getDzgjhdq(){
		return dzgjhdq;
	}

	public void setDzszxszzq(String dzszxszzq){
		this.dzszxszzq=dzszxszzq;
	}

	public String getDzszxszzq(){
		return dzszxszzq;
	}

	public void setDzsqzzzm(String dzsqzzzm){
		this.dzsqzzzm=dzsqzzzm;
	}

	public String getDzsqzzzm(){
		return dzsqzzzm;
	}

	public void setDzxzzxxjs(String dzxzzxxjs){
		this.dzxzzxxjs=dzxzzxxjs;
	}

	public String getDzxzzxxjs(){
		return dzxzzxxjs;
	}

	public void setDzxzjdbsc(String dzxzjdbsc){
		this.dzxzjdbsc=dzxzjdbsc;
	}

	public String getDzxzjdbsc(){
		return dzxzjdbsc;
	}

	public void setDzcjlnd(String dzcjlnd){
		this.dzcjlnd=dzcjlnd;
	}

	public String getDzcjlnd(){
		return dzcjlnd;
	}

	public void setDzmphm(String dzmphm){
		this.dzmphm=dzmphm;
	}

	public String getDzmphm(){
		return dzmphm;
	}

	public void setYpscxkzbh(String ypscxkzbh){
		this.ypscxkzbh=ypscxkzbh;
	}

	public String getYpscxkzbh(){
		return ypscxkzbh;
	}

	public void setYpgmpzsbh(String ypgmpzsbh){
		this.ypgmpzsbh=ypgmpzsbh;
	}

	public String getYpgmpzsbh(){
		return ypgmpzsbh;
	}

	public void setYpjyxkzh(String ypjyxkzh){
		this.ypjyxkzh=ypjyxkzh;
	}

	public String getYpjyxkzh(){
		return ypjyxkzh;
	}

	public void setYpjyzlglgfrzzsbh(String ypjyzlglgfrzzsbh){
		this.ypjyzlglgfrzzsbh=ypjyzlglgfrzzsbh;
	}

	public String getYpjyzlglgfrzzsbh(){
		return ypjyzlglgfrzzsbh;
	}

	public void setYlqxscxkzh(String ylqxscxkzh){
		this.ylqxscxkzh=ylqxscxkzh;
	}

	public String getYlqxscxkzh(){
		return ylqxscxkzh;
	}

	public void setFzjg(String fzjg){
		this.fzjg=fzjg;
	}

	public String getFzjg(){
		return fzjg;
	}

	public void setFzrq(Timestamp fzrq){
		this.fzrq=fzrq;
	}

	public Timestamp getFzrq(){
		return fzrq;
	}

	public void setZjzsyxqqsrq(Timestamp zjzsyxqqsrq){
		this.zjzsyxqqsrq=zjzsyxqqsrq;
	}

	public Timestamp getZjzsyxqqsrq(){
		return zjzsyxqqsrq;
	}

	public void setZjzsyxqzzrq(Timestamp zjzsyxqzzrq){
		this.zjzsyxqzzrq=zjzsyxqzzrq;
	}

	public Timestamp getZjzsyxqzzrq(){
		return zjzsyxqzzrq;
	}

	public void setCpzcdljg(String cpzcdljg){
		this.cpzcdljg=cpzcdljg;
	}

	public String getCpzcdljg(){
		return cpzcdljg;
	}

	public void setCpdlr(String cpdlr){
		this.cpdlr=cpdlr;
	}

	public String getCpdlr(){
		return cpdlr;
	}

	public void setCpshfwjg(String cpshfwjg){
		this.cpshfwjg=cpshfwjg;
	}

	public String getCpshfwjg(){
		return cpshfwjg;
	}

	public void setWtyjjg(String wtyjjg){
		this.wtyjjg=wtyjjg;
	}

	public String getWtyjjg(){
		return wtyjjg;
	}

	public void setQyzjbmmc(String qyzjbmmc){
		this.qyzjbmmc=qyzjbmmc;
	}

	public String getQyzjbmmc(){
		return qyzjbmmc;
	}

	public void setQyzjbmgjjszcrs(Long qyzjbmgjjszcrs){
		this.qyzjbmgjjszcrs=qyzjbmgjjszcrs;
	}

	public Long getQyzjbmgjjszcrs(){
		return qyzjbmgjjszcrs;
	}

	public void setQyzjbmzjjszcrs(Long qyzjbmzjjszcrs){
		this.qyzjbmzjjszcrs=qyzjbmzjjszcrs;
	}

	public Long getQyzjbmzjjszcrs(){
		return qyzjbmzjjszcrs;
	}

	public void setQyzcdzybhpzs(Long qyzcdzybhpzs){
		this.qyzcdzybhpzs=qyzcdzybhpzs;
	}

	public Long getQyzcdzybhpzs(){
		return qyzcdzybhpzs;
	}

	public void setGdzcyz(Long gdzcyz){
		this.gdzcyz=gdzcyz;
	}

	public Long getGdzcyz(){
		return gdzcyz;
	}

	public void setGdzcjz(Long gdzcjz){
		this.gdzcjz=gdzcjz;
	}

	public Long getGdzcjz(){
		return gdzcjz;
	}

	public void setSndxse(Float sndxse){
		this.sndxse=sndxse;
	}

	public Float getSndxse(){
		return sndxse;
	}

	public void setSndls(Float sndls){
		this.sndls=sndls;
	}

	public Float getSndls(){
		return sndls;
	}

	public void setSngyzcz(Long sngyzcz){
		this.sngyzcz=sngyzcz;
	}

	public Long getSngyzcz(){
		return sngyzcz;
	}

	public void setSnxssr(Long snxssr){
		this.snxssr=snxssr;
	}

	public Long getSnxssr(){
		return snxssr;
	}

	public void setNxseF(Float nxseF){
		this.nxseF=nxseF;
	}

	public Float getNxseF(){
		return nxseF;
	}

	public void setNxseS(Float nxseS){
		this.nxseS=nxseS;
	}

	public Float getNxseS(){
		return nxseS;
	}

	public void setNxseT(Float nxseT){
		this.nxseT=nxseT;
	}

	public Float getNxseT(){
		return nxseT;
	}

	public void setSnlr(Float snlr){
		this.snlr=snlr;
	}

	public Float getSnlr(){
		return snlr;
	}

	public void setSnsj(Long snsj){
		this.snsj=snsj;
	}

	public Long getSnsj(){
		return snsj;
	}

	public void setSnch(Long snch){
		this.snch=snch;
	}

	public Long getSnch(){
		return snch;
	}

	public void setZyjsrybl(Long zyjsrybl){
		this.zyjsrybl=zyjsrybl;
	}

	public Long getZyjsrybl(){
		return zyjsrybl;
	}

	public void setZlsqr(String zlsqr){
		this.zlsqr=zlsqr;
	}

	public String getZlsqr(){
		return zlsqr;
	}

	public void setZlfzr(String zlfzr){
		this.zlfzr=zlfzr;
	}

	public String getZlfzr(){
		return zlfzr;
	}

	public void setZlfzrs(Long zlfzrs){
		this.zlfzrs=zlfzrs;
	}

	public Long getZlfzrs(){
		return zlfzrs;
	}

	public void setScfzr(String scfzr){
		this.scfzr=scfzr;
	}

	public String getScfzr(){
		return scfzr;
	}

	public void setScfzrs(Long scfzrs){
		this.scfzrs=scfzrs;
	}

	public Long getScfzrs(){
		return scfzrs;
	}

	public void setZyysrs(Long zyysrs){
		this.zyysrs=zyysrs;
	}

	public Long getZyysrs(){
		return zyysrs;
	}

	public void setZrysrs(Long zrysrs){
		this.zrysrs=zrysrs;
	}

	public Long getZrysrs(){
		return zrysrs;
	}

	public void setFzrysrs(Long fzrysrs){
		this.fzrysrs=fzrysrs;
	}

	public Long getFzrysrs(){
		return fzrysrs;
	}

	public void setZgysrs(Long zgysrs){
		this.zgysrs=zgysrs;
	}

	public Long getZgysrs(){
		return zgysrs;
	}

	public void setYsrs01(Long ysrs01){
		this.ysrs01=ysrs01;
	}

	public Long getYsrs01(){
		return ysrs01;
	}

	public void setYsrs02(Long ysrs02){
		this.ysrs02=ysrs02;
	}

	public Long getYsrs02(){
		return ysrs02;
	}

	public void setCqzdmj(Long cqzdmj){
		this.cqzdmj=cqzdmj;
	}

	public Long getCqzdmj(){
		return cqzdmj;
	}

	public void setJzmj(Float jzmj){
		this.jzmj=jzmj;
	}

	public Float getJzmj(){
		return jzmj;
	}

	public void setScmj(Float scmj){
		this.scmj=scmj;
	}

	public Float getScmj(){
		return scmj;
	}

	public void setJhmj(Float jhmj){
		this.jhmj=jhmj;
	}

	public Float getJhmj(){
		return jhmj;
	}

	public void setJymj(Float jymj){
		this.jymj=jymj;
	}

	public Float getJymj(){
		return jymj;
	}

	public void setYclccmj(Float yclccmj){
		this.yclccmj=yclccmj;
	}

	public Float getYclccmj(){
		return yclccmj;
	}

	public void setCpccmj(Float cpccmj){
		this.cpccmj=cpccmj;
	}

	public Float getCpccmj(){
		return cpccmj;
	}

	public void setYljgbzcws(Long yljgbzcws){
		this.yljgbzcws=yljgbzcws;
	}

	public Long getYljgbzcws(){
		return yljgbzcws;
	}

	public void setQyzxbz(String qyzxbz){
		this.qyzxbz=qyzxbz;
	}

	public String getQyzxbz(){
		return qyzxbz;
	}

	public void setQyzxrq(Timestamp qyzxrq){
		this.qyzxrq=qyzxrq;
	}

	public Timestamp getQyzxrq(){
		return qyzxrq;
	}

	public void setQyzxyy(String qyzxyy){
		this.qyzxyy=qyzxyy;
	}

	public String getQyzxyy(){
		return qyzxyy;
	}

	public void setQyssmgsmc(String qyssmgsmc){
		this.qyssmgsmc=qyssmgsmc;
	}

	public String getQyssmgsmc(){
		return qyssmgsmc;
	}

	public void setQyssmgsdz(String qyssmgsdz){
		this.qyssmgsdz=qyssmgsdz;
	}

	public String getQyssmgsdz(){
		return qyssmgsdz;
	}

	public void setWfgbhdq(String wfgbhdq){
		this.wfgbhdq=wfgbhdq;
	}

	public String getWfgbhdq(){
		return wfgbhdq;
	}

	public void setGysmc(String gysmc){
		this.gysmc=gysmc;
	}

	public String getGysmc(){
		return gysmc;
	}

	public void setCpjxsmc(String cpjxsmc){
		this.cpjxsmc=cpjxsmc;
	}

	public String getCpjxsmc(){
		return cpjxsmc;
	}

	public void setFddbrsfz(String fddbrsfz){
		this.fddbrsfz=fddbrsfz;
	}

	public String getFddbrsfz(){
		return fddbrsfz;
	}

	public void setFddbrlxdh(String fddbrlxdh){
		this.fddbrlxdh=fddbrlxdh;
	}

	public String getFddbrlxdh(){
		return fddbrlxdh;
	}

	public void setZcly(String zcly){
		this.zcly=zcly;
	}

	public String getZcly(){
		return zcly;
	}

	public void setUuid(String uuid){
		this.uuid=uuid;
	}

	public String getUuid(){
		return uuid;
	}

	public void setLxDl(String lxDl){
		this.lxDl=lxDl;
	}

	public String getLxDl(){
		return lxDl;
	}

	public void setZjlx(String zjlx){
		this.zjlx=zjlx;
	}

	public String getZjlx(){
		return zjlx;
	}

	public void setZycp(String zycp){
		this.zycp=zycp;
	}

	public String getZycp(){
		return zycp;
	}

	public void setNcl(String ncl){
		this.ncl=ncl;
	}

	public String getNcl(){
		return ncl;
	}

	public Timestamp getSjc() {
		return sjc;
	}

	public void setSjc(Timestamp sjc) {
		this.sjc = sjc;
	}

}

