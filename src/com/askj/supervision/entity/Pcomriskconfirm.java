package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Pcomriskconfirm")
public class Pcomriskconfirm {
/** 食品生产经营者风险等级确定表; InnoDB free: 14336 kB  */
	/** pcomriskconfirmid 的中文含义是：食品生产经营者风险等级确定表id*/
	@Name
	@Column
	private String pcomriskconfirmid;

	/** comid 的中文含义是：企业id*/
	@Column
	private String comid;

	/** checkyear 的中文含义是：年度*/
	@Column
	private String checkyear;

	/** checkno 的中文含义是：编号*/
	@Column
	private String checkno;

	/** commc 的中文含义是：企业名称*/
	@Column
	private String commc;

	/** comdz 的中文含义是：企业地址*/
	@Column
	private String comdz;

	/** zzzmbh 的中文含义是：营业执照编号或信用代码*/
	@Column
	private String zzzmbh;

	/** lxrhfs 的中文含义是：联系人及联系方式*/
	@Column
	private String lxrhfs;

	/** sndfxdj 的中文含义是：上年度风险等级*/
	@Column
	private String sndfxdj;

	/** staticscore 的中文含义是：静态风险因素量化风险分值*/
	@Column
	private BigDecimal staticscore;

	/** dynamicscore 的中文含义是：动态风险因素量化风险分值	
            动态风险因素量化风险分值*/
	@Column
	private BigDecimal dynamicscore;

	/** totalscore 的中文含义是：风险等级得分*/
	@Column
	private BigDecimal totalscore;

	/** fxdj 的中文含义是：风险等级*/
	@Column
	private String fxdj;

	/** gywfflfg 的中文含义是：故意违反食品安全法律法规0否1是*/
	@Column
	private String gywfflfg;

	/** ycjysbfh 的中文含义是：有1次及以上国家或者省级监督抽检不符合食品安全标准的0否1是*/
	@Column
	private String ycjysbfh;

	/** wfflfg 的中文含义是：违反食品安全法律法规规定0否1是*/
	@Column
	private String wfflfg;

	/** fsaqsg 的中文含义是：发生食品安全事故的0否1是*/
	@Column
	private String fsaqsg;

	/** bagd 的中文含义是：不按规定进行产品召回或者停止生产经营的*/
	@Column
	private String bagd;

	/** bpezf 的中文含义是：拒绝、逃避、阻挠执法人员进行监督检查*/
	@Column
	private String bpezf;

	/** kstdj 的中文含义是：可以上调风险等级情形的*/
	@Column
	private String kstdj;

	/** suggestfxdj 的中文含义是：建议风险等级*/
	@Column
	private String suggestfxdj;

	/** xyndfxdj 的中文含义是：下一年度风险等级*/
	@Column
	private String xyndfxdj;

	/** fxdjbz 的中文含义是：备注*/
	@Column
	private String fxdjbz;

	/** tbrqm 的中文含义是：填表人签名，存放对于附件表id*/
	@Column
	private String tbrqm;

	/** tbrqmrq 的中文含义是：填表人签名日期*/
	@Column
	private Date tbrqmrq;

	/** shrqm 的中文含义是：审核人签名，存放对于附件表id*/
	@Column
	private String shrqm;

	/** shrqmrq 的中文含义是：审核人签名日期*/
	@Column
	private Date shrqmrq;

	/** aae011 的中文含义是：经办人*/
	@Column
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	@Column
	private Timestamp aae036;

	/** resultid 的中文含义是：*/
	@Column
	private String resultid;


	public void setPcomriskconfirmid(String pcomriskconfirmid){
		this.pcomriskconfirmid=pcomriskconfirmid;
	}

	public String getPcomriskconfirmid(){
		return pcomriskconfirmid;
	}

	public void setCheckyear(String checkyear){
		this.checkyear=checkyear;
	}

	public String getCheckyear(){
		return checkyear;
	}

	public void setCheckno(String checkno){
		this.checkno=checkno;
	}

	public String getCheckno(){
		return checkno;
	}

	public void setCommc(String commc){
		this.commc=commc;
	}

	public String getCommc(){
		return commc;
	}

	public void setComdz(String comdz){
		this.comdz=comdz;
	}

	public String getComdz(){
		return comdz;
	}

	public void setZzzmbh(String zzzmbh){
		this.zzzmbh=zzzmbh;
	}

	public String getZzzmbh(){
		return zzzmbh;
	}

	public void setLxrhfs(String lxrhfs){
		this.lxrhfs=lxrhfs;
	}

	public String getLxrhfs(){
		return lxrhfs;
	}

	public void setSndfxdj(String sndfxdj){
		this.sndfxdj=sndfxdj;
	}

	public String getSndfxdj(){
		return sndfxdj;
	}

	public void setStaticscore(BigDecimal staticscore){
		this.staticscore=staticscore;
	}

	public BigDecimal getStaticscore(){
		return staticscore;
	}

	public void setDynamicscore(BigDecimal dynamicscore){
		this.dynamicscore=dynamicscore;
	}

	public BigDecimal getDynamicscore(){
		return dynamicscore;
	}

	public void setTotalscore(BigDecimal totalscore){
		this.totalscore=totalscore;
	}

	public BigDecimal getTotalscore(){
		return totalscore;
	}

	public void setFxdj(String fxdj){
		this.fxdj=fxdj;
	}

	public String getFxdj(){
		return fxdj;
	}

	public void setGywfflfg(String gywfflfg){
		this.gywfflfg=gywfflfg;
	}

	public String getGywfflfg(){
		return gywfflfg;
	}

	public void setYcjysbfh(String ycjysbfh){
		this.ycjysbfh=ycjysbfh;
	}

	public String getYcjysbfh(){
		return ycjysbfh;
	}

	public void setWfflfg(String wfflfg){
		this.wfflfg=wfflfg;
	}

	public String getWfflfg(){
		return wfflfg;
	}

	public void setFsaqsg(String fsaqsg){
		this.fsaqsg=fsaqsg;
	}

	public String getFsaqsg(){
		return fsaqsg;
	}

	public void setBagd(String bagd){
		this.bagd=bagd;
	}

	public String getBagd(){
		return bagd;
	}

	public void setBpezf(String bpezf){
		this.bpezf=bpezf;
	}

	public String getBpezf(){
		return bpezf;
	}

	public void setKstdj(String kstdj){
		this.kstdj=kstdj;
	}

	public String getKstdj(){
		return kstdj;
	}

	public String getSuggestfxdj() {
		return suggestfxdj;
	}

	public void setSuggestfxdj(String suggestfxdj) {
		this.suggestfxdj = suggestfxdj;
	}

	public void setXyndfxdj(String xyndfxdj){
		this.xyndfxdj=xyndfxdj;
	}

	public String getXyndfxdj(){
		return xyndfxdj;
	}

	public void setFxdjbz(String fxdjbz){
		this.fxdjbz=fxdjbz;
	}

	public String getFxdjbz(){
		return fxdjbz;
	}

	public void setTbrqm(String tbrqm){
		this.tbrqm=tbrqm;
	}

	public String getTbrqm(){
		return tbrqm;
	}

	public void setTbrqmrq(Date tbrqmrq){
		this.tbrqmrq=tbrqmrq;
	}

	public Date getTbrqmrq(){
		return tbrqmrq;
	}

	public void setShrqm(String shrqm){
		this.shrqm=shrqm;
	}

	public String getShrqm(){
		return shrqm;
	}

	public void setShrqmrq(Date shrqmrq){
		this.shrqmrq=shrqmrq;
	}

	public Date getShrqmrq(){
		return shrqmrq;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}

	public String getAae011() {
		return aae011;
	}

	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}

	public Timestamp getAae036() {
		return aae036;
	}

	public void setAae036(Timestamp aae036) {
		this.aae036 = aae036;
	}

	public String getResultid() {
		return resultid;
	}

	public void setResultid(String resultid) {
		this.resultid = resultid;
	}
}

