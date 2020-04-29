package com.askj.jyjc.dto;

public class HjyjczbDTO {

	/** ====================== 扩展字段  开始 ====================== */

	/** 快检报告单内容序号 */
	private int kjbgdxh;
	/** 快检报告单被检查单位地址 */
	private String comdz;
	/** 快检报告单检验结果 */
	private String kjbgdjcjg;
	/** 快检报告单批次号 */
	private String kjbgdpch;
	/** 地区编码 */
	private String aaa027;

	private String kjdata;

	/** ====================== 扩展结束 ====================== */

/** 检验检测主表; InnoDB free: 31744 kB  */
	/** hjyjczbid 的中文含义是：检验检测主表id*/
	private String hjyjczbid;
	private String userid;

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	/** hviewjgztid 的中文含义是：监管主体表id(仪器对接用)*/
	private String hviewjgztid;

	/** hviewjgztmc 的中文含义是：监管主体名称(仪器对接用:被检单位)*/
	private String hviewjgztmc;

	/** jcztbzjid 的中文含义是：检测主体表主键id*/
	private String jcztbzjid;

	/** jyjcbgbh 的中文含义是：检验检测报告编号*/
	private String jyjcbgbh;

	/** jyjcrq 的中文含义是：检验检测日期(仪器对接用)*/
	private String jyjcrq;

	/** eptbh 的中文含义是：e票通编号*/
	private String eptbh;

	/** jcypid 的中文含义是：商品id(仪器对接用)*/
	private String jcypid;

	/** jcypmc 的中文含义是：商品名称(仪器对接用-样品名称)*/
	private String jcypmc;

	/** jcjylb 的中文含义是：检测检验类别aaa100=jcjylb*/
	private String jcjylb;

	/** jcorgid 的中文含义是：检测机构id*/
	private String jcorgid;

	/** jcorgmc 的中文含义是：检测机构名称(仪器对接用:检测单位)*/
	private String jcorgmc;

	/** jcryid 的中文含义是：检测人员id*/
	private String jcryid;

	/** jcrymc 的中文含义是：检测人员名称(仪器对接用)*/
	private String jcrymc;

	/** fjjg 的中文含义是：复检结果*/
	private String fjjg;

	/** jcjyshbz 的中文含义是：审核标志见aaa100=JCJYSHBZ*/
	private String jcjyshbz;

	/** jcjyshwtgyy 的中文含义是：审核未通过原因*/
	private String jcjyshwtgyy;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private String aae036;

	/** sjcsfs 的中文含义是：数据产生方式0本系统录入1仪器对接*/
	private String sjcsfs;

	/** sbxh 的中文含义是：设备型号(仪器对接用)*/
	private String sbxh;

	/** sbxlh 的中文含义是：设备序列号*/
	private String sbxlh;

	/** cydjid 的中文含义是：抽样登记ID*/
	private String cydjid;

	/** jsbgrq 的中文含义是：收到报告日期（抽样报告用）*/
	private String jsbgrq;

	/** bgsdrq 的中文含义是：报告送达日期（抽样报告用）*/
	private String bgsdrq;

	/** jcksrq 的中文含义是：检测日期开始（抽样报告用）*/
	private String jcksrq;

	/** jcjsrq 的中文含义是：检测日期结束（抽样报告用）*/
	private String jcjsrq;

	/** cybgsfla 的中文含义是：是否立案aaa100=shifoubz（抽样报告用）*/
	private String cybgsfla;

	/** ajdjid 的中文含义是：案件登记id（抽样报告用）*/
	private String ajdjid;

	/** ajdjbh 的中文含义是：案件登记编号（抽样报告用）*/
	private String ajdjbh;

	/** jycjssxzid 的中文含义是：安全监督抽检实施细则id*/
	private String jycjssxzid;
	private String detectiondatatype;
	private String jcbgrz;

	public String getJcbgrz() {
		return jcbgrz;
	}

	public void setJcbgrz(String jcbgrz) {
		this.jcbgrz = jcbgrz;
	}

	public String getDetectiondatatype() {
		return detectiondatatype;
	}

	public void setDetectiondatatype(String detectiondatatype) {
		this.detectiondatatype = detectiondatatype;
	}

	public void setHjyjczbid(String hjyjczbid){
		this.hjyjczbid=hjyjczbid;
	}

	public String getHjyjczbid(){
		return hjyjczbid;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setHviewjgztmc(String hviewjgztmc){
		this.hviewjgztmc=hviewjgztmc;
	}

	public String getHviewjgztmc(){
		return hviewjgztmc;
	}

	public void setJcztbzjid(String jcztbzjid){
		this.jcztbzjid=jcztbzjid;
	}

	public String getJcztbzjid(){
		return jcztbzjid;
	}

	public void setJyjcbgbh(String jyjcbgbh){
		this.jyjcbgbh=jyjcbgbh;
	}

	public String getJyjcbgbh(){
		return jyjcbgbh;
	}

	public void setJyjcrq(String jyjcrq){
		this.jyjcrq=jyjcrq;
	}

	public String getJyjcrq(){
		return jyjcrq;
	}

	public void setEptbh(String eptbh){
		this.eptbh=eptbh;
	}

	public String getEptbh(){
		return eptbh;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setJcypmc(String jcypmc){
		this.jcypmc=jcypmc;
	}

	public String getJcypmc(){
		return jcypmc;
	}

	public void setJcjylb(String jcjylb){
		this.jcjylb=jcjylb;
	}

	public String getJcjylb(){
		return jcjylb;
	}

	public void setJcorgid(String jcorgid){
		this.jcorgid=jcorgid;
	}

	public String getJcorgid(){
		return jcorgid;
	}

	public void setJcorgmc(String jcorgmc){
		this.jcorgmc=jcorgmc;
	}

	public String getJcorgmc(){
		return jcorgmc;
	}

	public void setJcryid(String jcryid){
		this.jcryid=jcryid;
	}

	public String getJcryid(){
		return jcryid;
	}

	public void setJcrymc(String jcrymc){
		this.jcrymc=jcrymc;
	}

	public String getJcrymc(){
		return jcrymc;
	}

	public void setFjjg(String fjjg){
		this.fjjg=fjjg;
	}

	public String getFjjg(){
		return fjjg;
	}

	public void setJcjyshbz(String jcjyshbz){
		this.jcjyshbz=jcjyshbz;
	}

	public String getJcjyshbz(){
		return jcjyshbz;
	}

	public void setJcjyshwtgyy(String jcjyshwtgyy){
		this.jcjyshwtgyy=jcjyshwtgyy;
	}

	public String getJcjyshwtgyy(){
		return jcjyshwtgyy;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(String aae036){
		this.aae036=aae036;
	}

	public String getAae036(){
		return aae036;
	}

	public void setSjcsfs(String sjcsfs){
		this.sjcsfs=sjcsfs;
	}

	public String getSjcsfs(){
		return sjcsfs;
	}

	public void setSbxh(String sbxh){
		this.sbxh=sbxh;
	}

	public String getSbxh(){
		return sbxh;
	}

	public void setSbxlh(String sbxlh){
		this.sbxlh=sbxlh;
	}

	public String getSbxlh(){
		return sbxlh;
	}

	public void setCydjid(String cydjid){
		this.cydjid=cydjid;
	}

	public String getCydjid(){
		return cydjid;
	}

	public void setJsbgrq(String jsbgrq){
		this.jsbgrq=jsbgrq;
	}

	public String getJsbgrq(){
		return jsbgrq;
	}

	public void setBgsdrq(String bgsdrq){
		this.bgsdrq=bgsdrq;
	}

	public String getBgsdrq(){
		return bgsdrq;
	}

	public void setJcksrq(String jcksrq){
		this.jcksrq=jcksrq;
	}

	public String getJcksrq(){
		return jcksrq;
	}

	public void setJcjsrq(String jcjsrq){
		this.jcjsrq=jcjsrq;
	}

	public String getJcjsrq(){
		return jcjsrq;
	}

	public void setCybgsfla(String cybgsfla){
		this.cybgsfla=cybgsfla;
	}

	public String getCybgsfla(){
		return cybgsfla;
	}

	public void setAjdjid(String ajdjid){
		this.ajdjid=ajdjid;
	}

	public String getAjdjid(){
		return ajdjid;
	}

	public void setAjdjbh(String ajdjbh){
		this.ajdjbh=ajdjbh;
	}

	public String getAjdjbh(){
		return ajdjbh;
	}

	public void setJycjssxzid(String jycjssxzid){
		this.jycjssxzid=jycjssxzid;
	}

	public String getJycjssxzid(){
		return jycjssxzid;
	}

	public int getKjbgdxh() {
		return kjbgdxh;
	}

	public void setKjbgdxh(int kjbgdxh) {
		this.kjbgdxh = kjbgdxh;
	}

	public String getComdz() {
		return comdz;
	}

	public void setComdz(String comdz) {
		this.comdz = comdz;
	}

	public String getKjbgdjcjg() {
		return kjbgdjcjg;
	}

	public void setKjbgdjcjg(String kjbgdjcjg) {
		this.kjbgdjcjg = kjbgdjcjg;
	}

	public String getKjbgdpch() {
		return kjbgdpch;
	}

	public void setKjbgdpch(String kjbgdpch) {
		this.kjbgdpch = kjbgdpch;
	}

	public String getAaa027() {
		return aaa027;
	}

	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}

	public String getKjdata() {
		return kjdata;
	}

	public void setKjdata(String kjdata) {
		this.kjdata = kjdata;
	}
}

