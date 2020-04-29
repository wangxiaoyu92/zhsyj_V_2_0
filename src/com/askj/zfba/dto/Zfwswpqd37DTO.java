package com.askj.zfba.dto;

/**
 * @Description  ZFWSWPQD37的中文含义是: 食品药品行政处罚文书物品清单37; InnoDB free: 76800 kBDTO
 * @Creation     2016/03/17 09:38:07
 * @Written      Create Tool By zjf 
 **/
public class Zfwswpqd37DTO {
	//扩展开始
	/**
	 * 一个方法被多个地方调用，这个表示是那个地方用，以区别处理
	 */
	private String fjwid;
	private String applyqm;
	private String checkedqm;
	private String checkqm;
	private String witnessqm;
	private String recordqm;
	private String noticeqm;
	private String print;

	public String getPrint() {
		return print;
	}

	public void setPrint(String print) {
		this.print = print;
	}

	public String getNoticeqm() {
		return noticeqm;
	}

	public void setNoticeqm(String noticeqm) {
		this.noticeqm = noticeqm;
	}

	public String getFjwid() {
		return fjwid;
	}

	public void setFjwid(String fjwid) {
		this.fjwid = fjwid;
	}

	public String getApplyqm() {
		return applyqm;
	}

	public void setApplyqm(String applyqm) {
		this.applyqm = applyqm;
	}

	public String getCheckedqm() {
		return checkedqm;
	}

	public void setCheckedqm(String checkedqm) {
		this.checkedqm = checkedqm;
	}

	public String getCheckqm() {
		return checkqm;
	}

	public void setCheckqm(String checkqm) {
		this.checkqm = checkqm;
	}

	public String getWitnessqm() {
		return witnessqm;
	}

	public void setWitnessqm(String witnessqm) {
		this.witnessqm = witnessqm;
	}

	public String getRecordqm() {
		return recordqm;
	}

	public void setRecordqm(String recordqm) {
		this.recordqm = recordqm;
	}

	private String operatetype;
	/**
	 * comid
	 */
	private String comid;

	//扩展结束

	/**
	 * 手机或是电脑
	 */
	private String sjordn;		
	/**
	 * 
	 */
	private String userid;		
	
	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	private String xzjgmc;
	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	public String getXzjgmc() {
		return xzjgmc;
	}
	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	public void setXzjgmc(String xzjgmc) {
		this.xzjgmc = xzjgmc;
	}
	/**
	 * @Description wpqdmx_table_rows的中文含义是：物品清单明细
	 */
	private String wpqdmx_table_rows;
	/**
	 * @Description fjcszfwstitle的中文含义是： 执法文书标题，一些公用文书用到
	 */
	private String fjcszfwstitle;		


	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String zfwsdmz;

	/**
	 * @Description wpqdwsbh的中文含义是： 文书编号
	 */
	private String wpqdwsbh;

	/**
	 * @Description wpqddsrqz的中文含义是： 当事人签字
	 */
	private String wpqddsrqz;

	/**
	 * @Description wpqddsrqzrq的中文含义是： 当事人签字日期
	 */
	private String wpqddsrqzrq;

	/**
	 * @Description wpqdzfry1qz的中文含义是： 执法人员1签字
	 */
	private String wpqdzfry1qz;

	/**
	 * @Description wpqdzfry2qz的中文含义是： 执法人员2签字
	 */
	private String wpqdzfry2qz;

	/**
	 * @Description wpqdzfryqzrq的中文含义是： 执法人员签字
	 */
	private String wpqdzfryqzrq;

	/**
	 * @Description wpqdqtwp的中文含义是： 其它物品
	 */
	private String wpqdqtwp;

	/**
	 * @Description wppddsr的中文含义是： 当事人
	 */
	private String wppddsr;

	/**
	 * @Description wppddz的中文含义是： 地址
	 */
	private String wppddz;

	/**
	 * @Description msclcbr的中文含义是： 承办人
	 */
	private String msclcbr;

	/**************物品清单明细表中的信息***********************/
	/**
	 * @Description wpqdmxid的中文含义是： 物品清单明细ID
	 */
	private String wpqdmxid;

	/**
	 * @Description wpqdid的中文含义是： 表37主键物品清单ID
	 */
	private String wpqdid;

	/**
	 * @Description wpmxpm的中文含义是： 品名
	 */
	private String wpmxpm;

	/**
	 * @Description wpmxbsscqy的中文含义是： 标示生产企业或经营单位
	 */
	private String wpmxbsscqy;

	/**
	 * @Description wpmxgg的中文含义是： 规格
	 */
	private String wpmxgg;

	/**
	 * @Description wpmxscpc的中文含义是： 生产批号或生产日期
	 */
	private String wpmxscpc;

	/**
	 * @Description wpmxsl的中文含义是： 数量
	 */
	private String wpmxsl;

	/**
	 * @Description wpmxdj的中文含义是： 单价
	 */
	private String wpmxdj;

	/**
	 * @Description wpmxbz的中文含义是： 包装
	 */
	private String wpmxbz;

	/**
	 * @Description wpmxbeiz的中文含义是： 备注
	 */
	private String wpmxbeiz;
	private String ajzfwsid;

	public String getAjzfwsid() {
		return ajzfwsid;
	}

	public void setAjzfwsid(String ajzfwsid) {
		this.ajzfwsid = ajzfwsid;
	}
	/***************set get 方法****************************/

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public void setZfwsdmz(String zfwsdmz){ 
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public String getZfwsdmz(){
		return zfwsdmz;
	}
	/**
	 * @Description wpqdwsbh的中文含义是： 文书编号
	 */
	public void setWpqdwsbh(String wpqdwsbh){ 
		this.wpqdwsbh = wpqdwsbh;
	}
	/**
	 * @Description wpqdwsbh的中文含义是： 文书编号
	 */
	public String getWpqdwsbh(){
		return wpqdwsbh;
	}
	/**
	 * @Description wpqddsrqz的中文含义是： 当事人签字
	 */
	public void setWpqddsrqz(String wpqddsrqz){ 
		this.wpqddsrqz = wpqddsrqz;
	}
	/**
	 * @Description wpqddsrqz的中文含义是： 当事人签字
	 */
	public String getWpqddsrqz(){
		return wpqddsrqz;
	}
	/**
	 * @Description wpqddsrqzrq的中文含义是： 当事人签字日期
	 */
	public void setWpqddsrqzrq(String wpqddsrqzrq){ 
		this.wpqddsrqzrq = wpqddsrqzrq;
	}
	/**
	 * @Description wpqddsrqzrq的中文含义是： 当事人签字日期
	 */
	public String getWpqddsrqzrq(){
		return wpqddsrqzrq;
	}
	/**
	 * @Description wpqdzfry1qz的中文含义是： 执法人员1签字
	 */
	public void setWpqdzfry1qz(String wpqdzfry1qz){ 
		this.wpqdzfry1qz = wpqdzfry1qz;
	}
	/**
	 * @Description wpqdzfry1qz的中文含义是： 执法人员1签字
	 */
	public String getWpqdzfry1qz(){
		return wpqdzfry1qz;
	}
	/**
	 * @Description wpqdzfry2qz的中文含义是： 执法人员2签字
	 */
	public void setWpqdzfry2qz(String wpqdzfry2qz){ 
		this.wpqdzfry2qz = wpqdzfry2qz;
	}
	/**
	 * @Description wpqdzfry2qz的中文含义是： 执法人员2签字
	 */
	public String getWpqdzfry2qz(){
		return wpqdzfry2qz;
	}
	/**
	 * @Description wpqdzfryqzrq的中文含义是： 执法人员签字
	 */
	public void setWpqdzfryqzrq(String wpqdzfryqzrq){ 
		this.wpqdzfryqzrq = wpqdzfryqzrq;
	}
	/**
	 * @Description wpqdzfryqzrq的中文含义是： 执法人员签字
	 */
	public String getWpqdzfryqzrq(){
		return wpqdzfryqzrq;
	}
	/**
	 * @Description wpqdqtwp的中文含义是： 其它物品
	 */
	public void setWpqdqtwp(String wpqdqtwp){ 
		this.wpqdqtwp = wpqdqtwp;
	}
	/**
	 * @Description wpqdqtwp的中文含义是： 其它物品
	 */
	public String getWpqdqtwp(){
		return wpqdqtwp;
	}

	/**
	 * @Description wppddsr的中文含义是： 当事人
	 */
	public void setWppddsr(String wppddsr){ 
		this.wppddsr = wppddsr;
	}
	/**
	 * @Description wppddsr的中文含义是： 当事人
	 */
	public String getWppddsr(){
		return wppddsr;
	}
	/**
	 * @Description wppddz的中文含义是： 地址
	 */
	public void setWppddz(String wppddz){ 
		this.wppddz = wppddz;
	}
	/**
	 * @Description wppddz的中文含义是： 地址
	 */
	public String getWppddz(){
		return wppddz;
	}

	public String getMsclcbr() {
		return msclcbr;
	}

	public void setMsclcbr(String msclcbr) {
		this.msclcbr = msclcbr;
	}

	public String getWpqdmx_table_rows() {
		return wpqdmx_table_rows;
	}

	public void setWpqdmx_table_rows(String wpqdmx_table_rows) {
		this.wpqdmx_table_rows = wpqdmx_table_rows;
	}

	/**
	 * @Description wpqdmxid的中文含义是： 物品清单明细ID
	 */
	public void setWpqdmxid(String wpqdmxid){
		this.wpqdmxid = wpqdmxid;
	}
	/**
	 * @Description wpqdmxid的中文含义是： 物品清单明细ID
	 */
	public String getWpqdmxid(){
		return wpqdmxid;
	}
	/**
	 * @Description wpqdid的中文含义是： 表37主键物品清单ID
	 */
	public void setWpqdid(String wpqdid){
		this.wpqdid = wpqdid;
	}
	/**
	 * @Description wpqdid的中文含义是： 表37主键物品清单ID
	 */
	public String getWpqdid(){
		return wpqdid;
	}
	/**
	 * @Description wpmxpm的中文含义是： 品名
	 */
	public void setWpmxpm(String wpmxpm){
		this.wpmxpm = wpmxpm;
	}
	/**
	 * @Description wpmxpm的中文含义是： 品名
	 */
	public String getWpmxpm(){
		return wpmxpm;
	}
	/**
	 * @Description wpmxbsscqy的中文含义是： 标示生产企业或经营单位
	 */
	public void setWpmxbsscqy(String wpmxbsscqy){
		this.wpmxbsscqy = wpmxbsscqy;
	}
	/**
	 * @Description wpmxbsscqy的中文含义是： 标示生产企业或经营单位
	 */
	public String getWpmxbsscqy(){
		return wpmxbsscqy;
	}
	/**
	 * @Description wpmxgg的中文含义是： 规格
	 */
	public void setWpmxgg(String wpmxgg){
		this.wpmxgg = wpmxgg;
	}
	/**
	 * @Description wpmxgg的中文含义是： 规格
	 */
	public String getWpmxgg(){
		return wpmxgg;
	}
	/**
	 * @Description wpmxscpc的中文含义是： 生产批号或生产日期
	 */
	public void setWpmxscpc(String wpmxscpc){
		this.wpmxscpc = wpmxscpc;
	}
	/**
	 * @Description wpmxscpc的中文含义是： 生产批号或生产日期
	 */
	public String getWpmxscpc(){
		return wpmxscpc;
	}
	/**
	 * @Description wpmxsl的中文含义是： 数量
	 */
	public void setWpmxsl(String wpmxsl){
		this.wpmxsl = wpmxsl;
	}
	/**
	 * @Description wpmxsl的中文含义是： 数量
	 */
	public String getWpmxsl(){
		return wpmxsl;
	}
	/**
	 * @Description wpmxdj的中文含义是： 单价
	 */
	public void setWpmxdj(String wpmxdj){
		this.wpmxdj = wpmxdj;
	}
	/**
	 * @Description wpmxdj的中文含义是： 单价
	 */
	public String getWpmxdj(){
		return wpmxdj;
	}
	/**
	 * @Description wpmxbz的中文含义是： 包装
	 */
	public void setWpmxbz(String wpmxbz){
		this.wpmxbz = wpmxbz;
	}
	/**
	 * @Description wpmxbz的中文含义是： 包装
	 */
	public String getWpmxbz(){
		return wpmxbz;
	}
	/**
	 * @Description wpmxbeiz的中文含义是： 备注
	 */
	public void setWpmxbeiz(String wpmxbeiz){
		this.wpmxbeiz = wpmxbeiz;
	}
	/**
	 * @Description wpmxbeiz的中文含义是： 备注
	 */
	public String getWpmxbeiz(){
		return wpmxbeiz;
	}
	public String getFjcszfwstitle() {
		return fjcszfwstitle;
	}
	public void setFjcszfwstitle(String fjcszfwstitle) {
		this.fjcszfwstitle = fjcszfwstitle;
	}
	public String getSjordn() {
		return sjordn;
	}
	public void setSjordn(String sjordn) {
		this.sjordn = sjordn;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}
}