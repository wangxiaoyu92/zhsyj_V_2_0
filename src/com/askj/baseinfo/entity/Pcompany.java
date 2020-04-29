package com.askj.baseinfo.entity;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

@Table(value = "Pcompany")
public class Pcompany {
/** 公司企业表; InnoDB free: 229376 kB  */
	/** comid 的中文含义是：企业ID*/
	@Name
	@Column
	private String comid;

	/** comdm 的中文含义是：企业代码：企业类型字母+6位行政区域代码+9位序列号*/
	@Column
	private String comdm;

	/** comdalei 的中文含义是：企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营*/
	@Column
	private String comdalei;

	/** comxkzbh 的中文含义是：许可证编号*/
	@Column
	private String comxkzbh;

	/** commc 的中文含义是：企业名称*/
	@Column
	private String commc;

	/** comfrhyz 的中文含义是：企业法人/业主*/
	@Column
	private String comfrhyz;

	/** comfrsfzh 的中文含义是：企业法人/业主身份证号*/
	@Column
	private String comfrsfzh;

	/** comfrxb 的中文含义是：企业法人/业主性别*/
	@Column
	private String comfrxb;

	/** comfrzw 的中文含义是：企业法人/业主职务*/
	@Column
	private String comfrzw;

	/** comfzr 的中文含义是：企业负责人*/
	@Column
	private String comfzr;

	/** comgddh 的中文含义是：固定电话*/
	@Column
	private String comgddh;

	/** comyddh 的中文含义是：移动电话*/
	@Column
	private String comyddh;

	/** comdz 的中文含义是：企业地址*/
	@Column
	private String comdz;

	/** comqq 的中文含义是：企业QQ*/
	@Column
	private String comqq;

	/** comemail 的中文含义是：企业电子邮件*/
	@Column
	private String comemail;

	/** comyzbm 的中文含义是：企业邮政编码*/
	@Column
	private String comyzbm;

	/** comwz 的中文含义是：网址*/
	@Column
	private String comwz;

	/** comcz 的中文含义是：传真*/
	@Column
	private String comcz;

	/** comctmj 的中文含义是：餐厅面积*/
	@Column
	private BigDecimal comctmj;

	/** comcfmj 的中文含义是：厨房面积*/
	@Column
	private BigDecimal comcfmj;

	/** comzmj 的中文含义是：总面积*/
	@Column
	private BigDecimal comzmj;

	/** comjcrs 的中文含义是：就餐人数*/
	@Column
	private Integer comjcrs;

	/** comcyrs 的中文含义是：从业人数*/
	@Column
	private Integer comcyrs;

	/** comcjkzrs 的中文含义是：持健康证人数*/
	@Column
	private Integer comcjkzrs;

	/** comzjzglrs 的中文含义是：专（兼）职管理人员数*/
	@Column
	private Integer comzjzglrs;

	/** comxiaolei 的中文含义是：企业小类，代码表comxiaolei如特大型餐馆*/
	@Column
	private String comxiaolei;

	/** comdmlx 的中文含义是：店面类型，代码表comdmlx如蛋糕店、火锅店*/
	@Column
	private String comdmlx;

	/** comtscx 的中文含义是：特色菜系，代表表comtscx如豫菜*/
	@Column
	private String comtscx;

	/** comtsc 的中文含义是：特色菜*/
	@Column
	private String comtsc;

	/** comzzjgdm 的中文含义是：组织机构代码*/
	@Column
	private String comzzjgdm;

	/** comclrq 的中文含义是：企业成立日期*/
	@Column
	private Timestamp comclrq;

	/** comzczj 的中文含义是：注册资金（万元）*/
	@Column
	private Long comzczj;

	/** comzclb 的中文含义是：1企业自行注册2 操作员添加注册*/
	@Column
	private String comzclb;

	/** comdzcczymc 的中文含义是：代企业注册的操作人*/
	@Column
	private String comdzcczymc;

	/** comdzcsj 的中文含义是：代注册时间*/
	@Column
	private Timestamp comdzcsj;

	/** comshbz 的中文含义是：审核标志 1通过 2未通过 0 等待审核*/
	@Column
	private String comshbz;

	/** comshr 的中文含义是：审核人*/
	@Column
	private String comshr;

	/** comshsj 的中文含义是：审核时间*/
	@Column
	private Timestamp comshsj;

	/** comshwtgyy 的中文含义是：审核未通过原因*/
	@Column
	private String comshwtgyy;

	/** comjianjie 的中文含义是：企业简介*/
	@Column
	private String comjianjie;

	/** comqyxz 的中文含义是：企业性质*/
	@Column
	private String comqyxz;

	/** aaa027 的中文含义是：地区编码*/
	@Column
	private String aaa027;

	/** comjdzb 的中文含义是：经度坐标*/
	@Column
	private String comjdzb;

	/** comwdzb 的中文含义是：纬度坐标*/
	@Column
	private String comwdzb;

	/** comfwnfww 的中文含义是：0范围内1范围外aaa100=COMFWNFWW*/
	@Column
	private String comfwnfww;

	/** comlrcomid 的中文含义是：如果是范围外企业对应的添加该企业的企业ID*/
	@Column
	private String comlrcomid;

	/** comghsorxhs 的中文含义是：0供货商1销货商是供货商还是销货商AAA100=COMGHSORXHS*/
	@Column
	private String comghsorxhs;

	/** comjyjcbz 的中文含义是：检验检测单位标志，见aaa100=COMJYJCBZ*/
	@Column
	private String comjyjcbz;

	/** combxbz 的中文含义是：保险标志*/
	@Column
	private String combxbz;

	/** comspjkbz 的中文含义是：视频监控标志*/
	@Column
	private String comspjkbz;

	/** comhhbbz 的中文含义是：红黑榜标志*/
	@Column
	private String comhhbbz;

	/** comsyqylx 的中文含义是：溯源企业类型0非溯源企业1生成2流通3餐饮aaa100=COMSYQYLX*/
	@Column
	private String comsyqylx;

	/** comywtz 的中文含义是：有无台账*/
	@Column
	private String comywtz;

	/** combeizhu 的中文含义是：备注*/
	@Column
	private String combeizhu;

	/** orgid 的中文含义是：机构ID*/
	@Column
	private String orgid;

	/** comcssbm 的中文含义是：厂商识别码*/
	@Column
	private String comcssbm;

	/** comtsdh 的中文含义是：企业投诉电话*/
	@Column
	private String comtsdh;

	/** comscdz 的中文含义是：企业生产地址*/
	@Column
	private String comscdz;

	/** comzmfx 的中文含义是：企业正门方向*/
	@Column
	private String comzmfx;

	/** comqyndgdzcxz 的中文含义是：前一年度固定资产（现值*/
	@Column
	private BigDecimal comqyndgdzcxz;

	/** comqyndldzj 的中文含义是：前一年度流动资金*/
	@Column
	private BigDecimal comqyndldzj;

	/** comqyndzcz 的中文含义是：前一年度总产值*/
	@Column
	private BigDecimal comqyndzcz;

	/** comqyndnxse 的中文含义是：前一年度年销售额*/
	@Column
	private BigDecimal comqyndnxse;

	/** comqyndyjse 的中文含义是：前一年度缴税金额*/
	@Column
	private BigDecimal comqyndyjse;

	/** comqyndnlr 的中文含义是：前一年度年利润*/
	@Column
	private BigDecimal comqyndnlr;

	/** comsftghaccp 的中文含义是：是否通过HACCP认证0否1是*/
	@Column
	private String comsftghaccp;

	/** comhaccpbh 的中文含义是：HACCP认证证书编号*/
	@Column
	private String comhaccpbh;

	/** comhaccpfzdw 的中文含义是：HACCP发证单位名*/
	@Column
	private String comhaccpfzdw;

	/** comiso9000bh 的中文含义是：ISO9000证书编号*/
	@Column
	private String comiso9000bh;

	/** comiso9000fzdw 的中文含义是：ISO9000发证单位名*/
	@Column
	private String comiso9000fzdw;

	/** comzdmj 的中文含义是：占地面积*/
	@Column
	private BigDecimal comzdmj;

	/** comjzmj 的中文含义是：建筑面积*/
	@Column
	private BigDecimal comjzmj;

	/** comyysj 的中文含义是：营业时间*/
	@Column
	private String comyysj;

	/** comfxdj 的中文含义是：企业风险等级aaa100=comfxdj*/
	@Column
	private String comfxdj;

	/** commcjc 的中文含义是：企业名称简称*/
	@Column
	private String commcjc;

	/** comdaleiname 的中文含义是：企业大类汉字描述*/
	@Column
	private String comdaleiname;

	/** comxiaoleiname 的中文含义是：企业小类汉字描述*/
	@Column
	private String comxiaoleiname;
	
	/** orderno 的中文含义是：显示序号*/
	@Column
	private String orderno;

	/**
	 * @Description sjdatatime的中文含义是：省局数据同步时间
	 */
	@Column
	private Timestamp sjdatatime;
	
	/**
	 * @Description sjdatacomid的中文含义是：省局数据主键
	 */
	@Column
	private String sjdatacomid;	
	
	/**
	 * @Description sjdatacomdm的中文含义是：省局数据企业代码
	 */
	@Column
	private String sjdatacomdm;	
	



	/**
	 * @Description outercomid的中文含义是：外部系统主键
	 */
	@Column
	private String outercomid;


	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setComdm(String comdm){
		this.comdm=comdm;
	}

	public String getComdm(){
		return comdm;
	}

	public void setComdalei(String comdalei){
		this.comdalei=comdalei;
	}

	public String getComdalei(){
		return comdalei;
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

	public void setComfrsfzh(String comfrsfzh){
		this.comfrsfzh=comfrsfzh;
	}

	public String getComfrsfzh(){
		return comfrsfzh;
	}

	public void setComfrxb(String comfrxb){
		this.comfrxb=comfrxb;
	}

	public String getComfrxb(){
		return comfrxb;
	}

	public void setComfrzw(String comfrzw){
		this.comfrzw=comfrzw;
	}

	public String getComfrzw(){
		return comfrzw;
	}

	public void setComfzr(String comfzr){
		this.comfzr=comfzr;
	}

	public String getComfzr(){
		return comfzr;
	}

	public void setComgddh(String comgddh){
		this.comgddh=comgddh;
	}

	public String getComgddh(){
		return comgddh;
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

	public void setComqq(String comqq){
		this.comqq=comqq;
	}

	public String getComqq(){
		return comqq;
	}

	public void setComemail(String comemail){
		this.comemail=comemail;
	}

	public String getComemail(){
		return comemail;
	}

	public void setComyzbm(String comyzbm){
		this.comyzbm=comyzbm;
	}

	public String getComyzbm(){
		return comyzbm;
	}

	public void setComwz(String comwz){
		this.comwz=comwz;
	}

	public String getComwz(){
		return comwz;
	}

	public void setComcz(String comcz){
		this.comcz=comcz;
	}

	public String getComcz(){
		return comcz;
	}

	public void setComctmj(BigDecimal comctmj){
		this.comctmj=comctmj;
	}

	public BigDecimal getComctmj(){
		return comctmj;
	}

	public void setComcfmj(BigDecimal comcfmj){
		this.comcfmj=comcfmj;
	}

	public BigDecimal getComcfmj(){
		return comcfmj;
	}

	public void setComzmj(BigDecimal comzmj){
		this.comzmj=comzmj;
	}

	public BigDecimal getComzmj(){
		return comzmj;
	}

	public void setComjcrs(Integer comjcrs){
		this.comjcrs=comjcrs;
	}

	public Integer getComjcrs(){
		return comjcrs;
	}

	public void setComcyrs(Integer comcyrs){
		this.comcyrs=comcyrs;
	}

	public Integer getComcyrs(){
		return comcyrs;
	}

	public void setComcjkzrs(Integer comcjkzrs){
		this.comcjkzrs=comcjkzrs;
	}

	public Integer getComcjkzrs(){
		return comcjkzrs;
	}

	public void setComzjzglrs(Integer comzjzglrs){
		this.comzjzglrs=comzjzglrs;
	}

	public Integer getComzjzglrs(){
		return comzjzglrs;
	}

	public void setComxiaolei(String comxiaolei){
		this.comxiaolei=comxiaolei;
	}

	public String getComxiaolei(){
		return comxiaolei;
	}

	public void setComdmlx(String comdmlx){
		this.comdmlx=comdmlx;
	}

	public String getComdmlx(){
		return comdmlx;
	}

	public void setComtscx(String comtscx){
		this.comtscx=comtscx;
	}

	public String getComtscx(){
		return comtscx;
	}

	public void setComtsc(String comtsc){
		this.comtsc=comtsc;
	}

	public String getComtsc(){
		return comtsc;
	}

	public void setComzzjgdm(String comzzjgdm){
		this.comzzjgdm=comzzjgdm;
	}

	public String getComzzjgdm(){
		return comzzjgdm;
	}

	public void setComclrq(Timestamp comclrq){
		this.comclrq=comclrq;
	}

	public Timestamp getComclrq(){
		return comclrq;
	}

	public void setComzczj(Long comzczj){
		this.comzczj=comzczj;
	}

	public Long getComzczj(){
		return comzczj;
	}

	public void setComzclb(String comzclb){
		this.comzclb=comzclb;
	}

	public String getComzclb(){
		return comzclb;
	}

	public void setComdzcczymc(String comdzcczymc){
		this.comdzcczymc=comdzcczymc;
	}

	public String getComdzcczymc(){
		return comdzcczymc;
	}

	public void setComdzcsj(Timestamp comdzcsj){
		this.comdzcsj=comdzcsj;
	}

	public Timestamp getComdzcsj(){
		return comdzcsj;
	}

	public void setComshbz(String comshbz){
		this.comshbz=comshbz;
	}

	public String getComshbz(){
		return comshbz;
	}

	public void setComshr(String comshr){
		this.comshr=comshr;
	}

	public String getComshr(){
		return comshr;
	}

	public void setComshsj(Timestamp comshsj){
		this.comshsj=comshsj;
	}

	public Timestamp getComshsj(){
		return comshsj;
	}

	public void setComshwtgyy(String comshwtgyy){
		this.comshwtgyy=comshwtgyy;
	}

	public String getComshwtgyy(){
		return comshwtgyy;
	}

	public void setComjianjie(String comjianjie){
		this.comjianjie=comjianjie;
	}

	public String getComjianjie(){
		return comjianjie;
	}

	public void setComqyxz(String comqyxz){
		this.comqyxz=comqyxz;
	}

	public String getComqyxz(){
		return comqyxz;
	}

	public void setAaa027(String aaa027){
		this.aaa027=aaa027;
	}

	public String getAaa027(){
		return aaa027;
	}

	public void setComjdzb(String comjdzb){
		this.comjdzb=comjdzb;
	}

	public String getComjdzb(){
		return comjdzb;
	}

	public void setComwdzb(String comwdzb){
		this.comwdzb=comwdzb;
	}

	public String getComwdzb(){
		return comwdzb;
	}

	public void setComfwnfww(String comfwnfww){
		this.comfwnfww=comfwnfww;
	}

	public String getComfwnfww(){
		return comfwnfww;
	}

	public void setComlrcomid(String comlrcomid){
		this.comlrcomid=comlrcomid;
	}

	public String getComlrcomid(){
		return comlrcomid;
	}

	public void setComghsorxhs(String comghsorxhs){
		this.comghsorxhs=comghsorxhs;
	}

	public String getComghsorxhs(){
		return comghsorxhs;
	}

	public void setComjyjcbz(String comjyjcbz){
		this.comjyjcbz=comjyjcbz;
	}

	public String getComjyjcbz(){
		return comjyjcbz;
	}

	public void setCombxbz(String combxbz){
		this.combxbz=combxbz;
	}

	public String getCombxbz(){
		return combxbz;
	}

	public void setComspjkbz(String comspjkbz){
		this.comspjkbz=comspjkbz;
	}

	public String getComspjkbz(){
		return comspjkbz;
	}

	public void setComhhbbz(String comhhbbz){
		this.comhhbbz=comhhbbz;
	}

	public String getComhhbbz(){
		return comhhbbz;
	}

	public void setComsyqylx(String comsyqylx){
		this.comsyqylx=comsyqylx;
	}

	public String getComsyqylx(){
		return comsyqylx;
	}

	public void setComywtz(String comywtz){
		this.comywtz=comywtz;
	}

	public String getComywtz(){
		return comywtz;
	}

	public void setCombeizhu(String combeizhu){
		this.combeizhu=combeizhu;
	}

	public String getCombeizhu(){
		return combeizhu;
	}

	public void setOrgid(String orgid){
		this.orgid=orgid;
	}

	public String getOrgid(){
		return orgid;
	}

	public void setComcssbm(String comcssbm){
		this.comcssbm=comcssbm;
	}

	public String getComcssbm(){
		return comcssbm;
	}

	public void setComtsdh(String comtsdh){
		this.comtsdh=comtsdh;
	}

	public String getComtsdh(){
		return comtsdh;
	}

	public void setComscdz(String comscdz){
		this.comscdz=comscdz;
	}

	public String getComscdz(){
		return comscdz;
	}

	public void setComzmfx(String comzmfx){
		this.comzmfx=comzmfx;
	}

	public String getComzmfx(){
		return comzmfx;
	}

	public void setComqyndgdzcxz(BigDecimal comqyndgdzcxz){
		this.comqyndgdzcxz=comqyndgdzcxz;
	}

	public BigDecimal getComqyndgdzcxz(){
		return comqyndgdzcxz;
	}

	public void setComqyndldzj(BigDecimal comqyndldzj){
		this.comqyndldzj=comqyndldzj;
	}

	public BigDecimal getComqyndldzj(){
		return comqyndldzj;
	}

	public void setComqyndzcz(BigDecimal comqyndzcz){
		this.comqyndzcz=comqyndzcz;
	}

	public BigDecimal getComqyndzcz(){
		return comqyndzcz;
	}

	public void setComqyndnxse(BigDecimal comqyndnxse){
		this.comqyndnxse=comqyndnxse;
	}

	public BigDecimal getComqyndnxse(){
		return comqyndnxse;
	}

	public void setComqyndyjse(BigDecimal comqyndyjse){
		this.comqyndyjse=comqyndyjse;
	}

	public BigDecimal getComqyndyjse(){
		return comqyndyjse;
	}

	public void setComqyndnlr(BigDecimal comqyndnlr){
		this.comqyndnlr=comqyndnlr;
	}

	public BigDecimal getComqyndnlr(){
		return comqyndnlr;
	}

	public void setComsftghaccp(String comsftghaccp){
		this.comsftghaccp=comsftghaccp;
	}

	public String getComsftghaccp(){
		return comsftghaccp;
	}

	public void setComhaccpbh(String comhaccpbh){
		this.comhaccpbh=comhaccpbh;
	}

	public String getComhaccpbh(){
		return comhaccpbh;
	}

	public void setComhaccpfzdw(String comhaccpfzdw){
		this.comhaccpfzdw=comhaccpfzdw;
	}

	public String getComhaccpfzdw(){
		return comhaccpfzdw;
	}

	public void setComiso9000bh(String comiso9000bh){
		this.comiso9000bh=comiso9000bh;
	}

	public String getComiso9000bh(){
		return comiso9000bh;
	}

	public void setComiso9000fzdw(String comiso9000fzdw){
		this.comiso9000fzdw=comiso9000fzdw;
	}

	public String getComiso9000fzdw(){
		return comiso9000fzdw;
	}

	public void setComzdmj(BigDecimal comzdmj){
		this.comzdmj=comzdmj;
	}

	public BigDecimal getComzdmj(){
		return comzdmj;
	}

	public void setComjzmj(BigDecimal comjzmj){
		this.comjzmj=comjzmj;
	}

	public BigDecimal getComjzmj(){
		return comjzmj;
	}

	public void setComyysj(String comyysj){
		this.comyysj=comyysj;
	}

	public String getComyysj(){
		return comyysj;
	}

	public void setComfxdj(String comfxdj){
		this.comfxdj=comfxdj;
	}

	public String getComfxdj(){
		return comfxdj;
	}

	public void setCommcjc(String commcjc){
		this.commcjc=commcjc;
	}

	public String getCommcjc(){
		return commcjc;
	}

	public void setComdaleiname(String comdaleiname){
		this.comdaleiname=comdaleiname;
	}

	public String getComdaleiname(){
		return comdaleiname;
	}

	public void setComxiaoleiname(String comxiaoleiname){
		this.comxiaoleiname=comxiaoleiname;
	}

	public String getComxiaoleiname(){
		return comxiaoleiname;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getOutercomid() {
		return outercomid;
	}

	public void setOutercomid(String outercomid) {
		this.outercomid = outercomid;
	}

	public Timestamp getSjdatatime() {
		return sjdatatime;
	}

	public void setSjdatatime(Timestamp sjdatatime) {
		this.sjdatatime = sjdatatime;
	}

	public String getSjdatacomid() {
		return sjdatacomid;
	}

	public void setSjdatacomid(String sjdatacomid) {
		this.sjdatacomid = sjdatacomid;
	}

	public String getSjdatacomdm() {
		return sjdatacomdm;
	}

	public void setSjdatacomdm(String sjdatacomdm) {
		this.sjdatacomdm = sjdatacomdm;
	}
	
	

}

