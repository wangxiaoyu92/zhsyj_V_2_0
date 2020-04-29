package com.askj.baseinfo.dto; 
import java.sql.Timestamp;

public class HviewjgztDTO {
/** 监管主体表; InnoDB free: 161792 kB  */
	//扩展开始
	/** dokind 的中文含义是：操作类型 包括add update delete三种*/
	private String dokind;
	/** tablemc 的中文含义是：表名 目前包括pcompany 企业基本信息表  监管主体客户关系表hjgztkhgx 商户表psh*/
	private String tablemc;	
	
	//扩展结束
	
	/** hviewjgztid 的中文含义是：监管主体表主键*/
	private String hviewjgztid;

	/** jgztbh 的中文含义是：监管主体编号*/
	private String jgztbh;

	/** jgztmc 的中文含义是：监管主体名称*/
	private String jgztmc;

	/** jgztmcjc 的中文含义是：监管主体名称简称*/
	private String jgztmcjc;

	/** jgztlxr 的中文含义是：监管主体联系人*/
	private String jgztlxr;

	/** jgztlxrgddh 的中文含义是：监管主体联系人固定电话*/
	private String jgztlxrgddh;

	/** jgztlxryddh 的中文含义是：监管主体联系人移动电话*/
	private String jgztlxryddh;

	/** jgzttxdz 的中文含义是：监管主体通讯地址*/
	private String jgzttxdz;

	/** aaa027 的中文含义是：监管主体归属统筹区*/
	private String aaa027;

	/** jgztzzzmmc 的中文含义是：监管主体资质证明名称*/
	private String jgztzzzmmc;

	/** jgztzzzmbh 的中文含义是：监管主体资质证明编号*/
	private String jgztzzzmbh;

	/** jgztlx 的中文含义是：监管主体类型aaa100=jgztlx1企业2商户*/
	private String jgztlx;

	/** jgztgsztid 的中文含义是：监管主体归属主体*/
	private String jgztgsztid;

	/** jgztfwnfww 的中文含义是：客户范围内范围外*/
	private String jgztfwnfww;


	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setJgztbh(String jgztbh){
		this.jgztbh=jgztbh;
	}

	public String getJgztbh(){
		return jgztbh;
	}

	public void setJgztmc(String jgztmc){
		this.jgztmc=jgztmc;
	}

	public String getJgztmc(){
		return jgztmc;
	}

	public void setJgztmcjc(String jgztmcjc){
		this.jgztmcjc=jgztmcjc;
	}

	public String getJgztmcjc(){
		return jgztmcjc;
	}

	public void setJgztlxr(String jgztlxr){
		this.jgztlxr=jgztlxr;
	}

	public String getJgztlxr(){
		return jgztlxr;
	}

	public void setJgztlxrgddh(String jgztlxrgddh){
		this.jgztlxrgddh=jgztlxrgddh;
	}

	public String getJgztlxrgddh(){
		return jgztlxrgddh;
	}

	public void setJgztlxryddh(String jgztlxryddh){
		this.jgztlxryddh=jgztlxryddh;
	}

	public String getJgztlxryddh(){
		return jgztlxryddh;
	}

	public void setJgzttxdz(String jgzttxdz){
		this.jgzttxdz=jgzttxdz;
	}

	public String getJgzttxdz(){
		return jgzttxdz;
	}

	public void setAaa027(String aaa027){
		this.aaa027=aaa027;
	}

	public String getAaa027(){
		return aaa027;
	}

	public void setJgztzzzmmc(String jgztzzzmmc){
		this.jgztzzzmmc=jgztzzzmmc;
	}

	public String getJgztzzzmmc(){
		return jgztzzzmmc;
	}

	public void setJgztzzzmbh(String jgztzzzmbh){
		this.jgztzzzmbh=jgztzzzmbh;
	}

	public String getJgztzzzmbh(){
		return jgztzzzmbh;
	}

	public void setJgztlx(String jgztlx){
		this.jgztlx=jgztlx;
	}

	public String getJgztlx(){
		return jgztlx;
	}

	public void setJgztgsztid(String jgztgsztid){
		this.jgztgsztid=jgztgsztid;
	}

	public String getJgztgsztid(){
		return jgztgsztid;
	}

	public void setJgztfwnfww(String jgztfwnfww){
		this.jgztfwnfww=jgztfwnfww;
	}

	public String getJgztfwnfww(){
		return jgztfwnfww;
	}

	public String getDokind() {
		return dokind;
	}

	public void setDokind(String dokind) {
		this.dokind = dokind;
	}

	public String getTablemc() {
		return tablemc;
	}

	public void setTablemc(String tablemc) {
		this.tablemc = tablemc;
	}
	
	/** 检验检测样品; InnoDB free: 231424 kB  */
	/** querykind 的中文含义是：querykind 查询数据类型 空或0 不加其他条件 为1 加只查本企业商品*/
	private String querykind;	
		
	/** sppicpath 的中文含义是：商品图片路径*/
	private String sppicpath;
	/** sppicname 的中文含义是：商品图片名称*/
	private String sppicname;	
	
	/** jcypid 的中文含义是：检测样品ID*/
	private String jcypid;

	/** jcyplb 的中文含义是：检查样品类别,见AA10表JCYPLB*/
	private String jcyplb;

	/** jcypbh 的中文含义是：商品编号*/
	private String jcypbh;

	/** jcypmc 的中文含义是：检查样品名称*/
	private String jcypmc;

	/** jcypjc 的中文含义是：商品简称*/
	private String jcypjc;

	/** jcypczy 的中文含义是：操作员*/
	private String jcypczy;

	/** jcypczsj 的中文含义是：操作时间*/
	private Timestamp jcypczsj;

	/** jcypgl 的中文含义是：商品归类aaa100=jcypgl*/
	private String jcypgl;

	/** jcypsspp 的中文含义是：所属品牌*/
	private String jcypsspp;

	/** impcpgg 的中文含义是：规格*/
	private String impcpgg;

	/** spsb 的中文含义是：商品商标*/
	private String spsb;

	/** spggxh 的中文含义是：商品规格型号*/
	private String spggxh;

	/** spjldw 的中文含义是：商品计量单位*/
	private String spjldw;

	/** spzxbzh 的中文含义是：商品执行标准号*/
	private String spzxbzh;

	/** spbzq 的中文含义是：商品保质期*/
	private String spbzq;

	/** jcyptp 的中文含义是：检查样品图片*/
	private String jcyptp;

	/** jcyptpwjm 的中文含义是：检查样品图片文件名*/
	private String jcyptpwjm;
	
	/** spfenlei 的中文含义是：商品分类aaa100=spfenlei*/
	private String spfenlei;
	
	/** spsjlx 的中文含义是：商品数据类型aaa100=spsjlx0商品1生产企业产品2生产企业原材料*/
	private String spsjlx;
	

	public String getJcypid() {
		return jcypid;
	}

	public void setJcypid(String jcypid) {
		this.jcypid = jcypid;
	}

	public String getJcyplb() {
		return jcyplb;
	}

	public void setJcyplb(String jcyplb) {
		this.jcyplb = jcyplb;
	}

	public String getJcypbh() {
		return jcypbh;
	}

	public void setJcypbh(String jcypbh) {
		this.jcypbh = jcypbh;
	}

	public String getJcypmc() {
		return jcypmc;
	}

	public void setJcypmc(String jcypmc) {
		this.jcypmc = jcypmc;
	}

	public String getJcypjc() {
		return jcypjc;
	}

	public void setJcypjc(String jcypjc) {
		this.jcypjc = jcypjc;
	}

	public String getJcypczy() {
		return jcypczy;
	}

	public void setJcypczy(String jcypczy) {
		this.jcypczy = jcypczy;
	}

	public Timestamp getJcypczsj() {
		return jcypczsj;
	}

	public void setJcypczsj(Timestamp jcypczsj) {
		this.jcypczsj = jcypczsj;
	}

	public String getJcypgl() {
		return jcypgl;
	}

	public void setJcypgl(String jcypgl) {
		this.jcypgl = jcypgl;
	}

	public String getJcypsspp() {
		return jcypsspp;
	}

	public void setJcypsspp(String jcypsspp) {
		this.jcypsspp = jcypsspp;
	}

	public String getImpcpgg() {
		return impcpgg;
	}

	public void setImpcpgg(String impcpgg) {
		this.impcpgg = impcpgg;
	}

	public String getSpsb() {
		return spsb;
	}

	public void setSpsb(String spsb) {
		this.spsb = spsb;
	}

	public String getSpggxh() {
		return spggxh;
	}

	public void setSpggxh(String spggxh) {
		this.spggxh = spggxh;
	}

	public String getSpjldw() {
		return spjldw;
	}

	public void setSpjldw(String spjldw) {
		this.spjldw = spjldw;
	}

	public String getSpzxbzh() {
		return spzxbzh;
	}

	public void setSpzxbzh(String spzxbzh) {
		this.spzxbzh = spzxbzh;
	}

	public String getSpbzq() {
		return spbzq;
	}

	public void setSpbzq(String spbzq) {
		this.spbzq = spbzq;
	}

	public String getJcyptp() {
		return jcyptp;
	}

	public void setJcyptp(String jcyptp) {
		this.jcyptp = jcyptp;
	}

	public String getJcyptpwjm() {
		return jcyptpwjm;
	}

	public void setJcyptpwjm(String jcyptpwjm) {
		this.jcyptpwjm = jcyptpwjm;
	}

	public String getSppicpath() {
		return sppicpath;
	}

	public void setSppicpath(String sppicpath) {
		this.sppicpath = sppicpath;
	}

	public String getSppicname() {
		return sppicname;
	}

	public void setSppicname(String sppicname) {
		this.sppicname = sppicname;
	}

	public String getSpfenlei() {
		return spfenlei;
	}

	public void setSpfenlei(String spfenlei) {
		this.spfenlei = spfenlei;
	}

	public String getSpsjlx() {
		return spsjlx;
	}

	public void setSpsjlx(String spsjlx) {
		this.spsjlx = spsjlx;
	}


	public String getQuerykind() {
		return querykind;
	}

	public void setQuerykind(String querykind) {
		this.querykind = querykind;
	}
	

}

