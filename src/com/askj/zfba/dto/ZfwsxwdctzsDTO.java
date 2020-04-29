package com.askj.zfba.dto;

/**
 * @Description  ZFWSXWDCTZS的中文含义是: 询问调查通知书
 * @Creation     2016/09/02 09:51:19
 * @Written      Create Tool By zjf 
 **/ 
public class ZfwsxwdctzsDTO {
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
	 * @Description xwdctzsid的中文含义是： 询问调查通知书id
	 */ 
	private String xwdctzsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */ 
	private String ajdjid;

	/**
	 * @Description xwdcsbh的中文含义是： 询问调查通知书编号
	 */ 
	private String xwdcsbh;

	/**
	 * @Description xwdcdsr的中文含义是： 询问调查通知书当事人
	 */ 
	private String xwdcdsr;

	/**
	 * @Description xwdczynr的中文含义是： 询问调查通知书主要内容
	 */ 
	private String xwdczynr;

	/**
	 * @Description xwdcjzrq的中文含义是： 询问调查通知书截止日期
	 */ 
	private String xwdcjzrq;

	/**
	 * @Description xwdcxwdz的中文含义是： 询问调查通知书询问地址
	 */ 
	private String xwdcxwdz;

	/**
	 * @Description xwdcxdzl的中文含义是： 询问调查通知书携带资料
	 */ 
	private String xwdcxdzl;

	/**
	 * @Description xwdcqzrq的中文含义是： 询问调查通知书签字日期
	 */ 
	private String xwdcqzrq;

	/**
	 * @Description xwdcdsrqz的中文含义是： 询问调查通知书当事人签字
	 */ 
	private String xwdcdsrqz;

	/**
	 * @Description xwdcdsrqzrq的中文含义是： 询问调查通知书当事人签字日期
	 */ 
	private String xwdcdsrqzrq;
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */ 
	private String zfwsdmz;
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String ajzfwsid;

	public String getAjzfwsid() {
		return ajzfwsid;
	}

	public void setAjzfwsid(String ajzfwsid) {
		this.ajzfwsid = ajzfwsid;
	}

	public String getZfwsdmz() {
		return zfwsdmz;
	}
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
		/**
	 * @Description xwdctzsid的中文含义是： 询问调查通知书id
	 */
	public void setXwdctzsid(String xwdctzsid){ 
		this.xwdctzsid = xwdctzsid;
	}
	/**
	 * @Description xwdctzsid的中文含义是： 询问调查通知书id
	 */
	public String getXwdctzsid(){
		return xwdctzsid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description xwdcsbh的中文含义是： 询问调查通知书编号
	 */
	public void setXwdcsbh(String xwdcsbh){ 
		this.xwdcsbh = xwdcsbh;
	}
	/**
	 * @Description xwdcsbh的中文含义是： 询问调查通知书编号
	 */
	public String getXwdcsbh(){
		return xwdcsbh;
	}
	/**
	 * @Description xwdcdsr的中文含义是： 询问调查通知书当事人
	 */
	public void setXwdcdsr(String xwdcdsr){ 
		this.xwdcdsr = xwdcdsr;
	}
	/**
	 * @Description xwdcdsr的中文含义是： 询问调查通知书当事人
	 */
	public String getXwdcdsr(){
		return xwdcdsr;
	}
	/**
	 * @Description xwdczynr的中文含义是： 询问调查通知书主要内容
	 */
	public void setXwdczynr(String xwdczynr){ 
		this.xwdczynr = xwdczynr;
	}
	/**
	 * @Description xwdczynr的中文含义是： 询问调查通知书主要内容
	 */
	public String getXwdczynr(){
		return xwdczynr;
	}
	/**
	 * @Description xwdcjzrq的中文含义是： 询问调查通知书截止日期
	 */
	public void setXwdcjzrq(String xwdcjzrq){ 
		this.xwdcjzrq = xwdcjzrq;
	}
	/**
	 * @Description xwdcjzrq的中文含义是： 询问调查通知书截止日期
	 */
	public String getXwdcjzrq(){
		return xwdcjzrq;
	}
	/**
	 * @Description xwdcxwdz的中文含义是： 询问调查通知书询问地址
	 */
	public void setXwdcxwdz(String xwdcxwdz){ 
		this.xwdcxwdz = xwdcxwdz;
	}
	/**
	 * @Description xwdcxwdz的中文含义是： 询问调查通知书询问地址
	 */
	public String getXwdcxwdz(){
		return xwdcxwdz;
	}
	/**
	 * @Description xwdcxdzl的中文含义是： 询问调查通知书携带资料
	 */
	public void setXwdcxdzl(String xwdcxdzl){ 
		this.xwdcxdzl = xwdcxdzl;
	}
	/**
	 * @Description xwdcxdzl的中文含义是： 询问调查通知书携带资料
	 */
	public String getXwdcxdzl(){
		return xwdcxdzl;
	}
	/**
	 * @Description xwdcqzrq的中文含义是： 询问调查通知书签字日期
	 */
	public void setXwdcqzrq(String xwdcqzrq){ 
		this.xwdcqzrq = xwdcqzrq;
	}
	/**
	 * @Description xwdcqzrq的中文含义是： 询问调查通知书签字日期
	 */
	public String getXwdcqzrq(){
		return xwdcqzrq;
	}
	/**
	 * @Description xwdcdsrqz的中文含义是： 询问调查通知书当事人签字
	 */
	public void setXwdcdsrqz(String xwdcdsrqz){ 
		this.xwdcdsrqz = xwdcdsrqz;
	}
	/**
	 * @Description xwdcdsrqz的中文含义是： 询问调查通知书当事人签字
	 */
	public String getXwdcdsrqz(){
		return xwdcdsrqz;
	}
	/**
	 * @Description xwdcdsrqzrq的中文含义是： 询问调查通知书当事人签字日期
	 */
	public void setXwdcdsrqzrq(String xwdcdsrqzrq){ 
		this.xwdcdsrqzrq = xwdcdsrqzrq;
	}
	/**
	 * @Description xwdcdsrqzrq的中文含义是： 询问调查通知书当事人签字日期
	 */
	public String getXwdcdsrqzrq(){
		return xwdcdsrqzrq;
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

	public String getPrint() {
		return print;
	}

	public void setPrint(String print) {
		this.print = print;
	}
}
