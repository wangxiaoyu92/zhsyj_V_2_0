package com.askj.jyjc.dto;

/**
 * @Description  JyjccybgDTO的中文含义是: 检验检测抽样报告DTO
 **/
public class JyjccybgDTO {
	
	private String message;
	private String succJsonStr;
	private String errorJsonStr;
	
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
	 * @Description cybh的中文含义是： 抽样编号(抽验编号)
	 */
	private String cybh;

	/**
	 * @Description bcydw的中文含义是： 被抽样单位(受检单位)
	 */
	private String bcydw;

	/**
	 * @Description bcydwdz的中文含义是： 被抽样单位地址(受检单位地址)
	 */
	private String bcydwdz;

	/**
	 * @Description scdw的中文含义是： 生产单位
	 */
	private String scdw;
	
	/**
	 * @Description ypmc的中文含义是： 样品名称
	 */
	private String ypmc;

	/**
	 * @Description countcy的中文含义是： 抽样数量(样品规格数量)
	 */
	private String countcy;

	/**
	 * @Description bgbh的中文含义是： 报告书编号
	 */
	private String bgbh;
	
	/**
	 * @Description jsbgrq的中文含义是： 收到报告日期
	 */
	private String jsbgrq;
	
	/**
	 * @Description bgsdrq的中文含义是： 报告送达日期
	 */
	private String bgsdrq;
	
	/**
	 * @Description jcrq的中文含义是： 检测日期
	 */
	private String jcrq;
	
	/**
	 * @Description lah的中文含义是： 立案号
	 */
	private String lah;
	
	/**
	 * @Description jcdwmc的中文含义是： 检测单位名称
	 */
	private String jcdwmc;
	
	/**
	 * @Description jxjcxmmc的中文含义是： 检测项目
	 */
	private String jxjcxmmc;
	
	/**
	 * @Description sfhg的中文含义是： 是否合格
	 */
	private String sfhg;
	
	/**
	 * @Description dw的中文含义是： 单位
	 */
	private String dw;
	
	/**
	 * @Description jyjcjg的中文含义是： 结果
	 */
	private String jyjcjg;
	
	/**
	 * @Description bzz的中文含义是： 标准值
	 */
	private String bzz;
	
	/**
	 * @Description yjqk的中文含义是： 移交情况
	 */
	private String yjqk;

	/**
	 * @Description cybh的中文含义是： 抽样编号
	 */
	public void setCybh(String cybh){ 
		this.cybh = cybh;
	}
	/**
	 * @Description cybh的中文含义是： 抽样编号
	 */
	public String getCybh(){
		return cybh;
	}
	/**
	 * @Description bcydw的中文含义是： 被抽样单位
	 */
	public void setBcydw(String bcydw){ 
		this.bcydw = bcydw;
	}
	/**
	 * @Description bcydw的中文含义是： 被抽样单位
	 */
	public String getBcydw(){
		return bcydw;
	}
	/**
	 * @Description bcydwdz的中文含义是： 被抽样单位地址
	 */
	public void setBcydwdz(String bcydwdz){ 
		this.bcydwdz = bcydwdz;
	}
	/**
	 * @Description bcydwdz的中文含义是： 被抽样单位地址
	 */
	public String getBcydwdz(){
		return bcydwdz;
	}
	/**
	 * @Description ypmc的中文含义是： 样品名称
	 */
	public void setYpmc(String ypmc){ 
		this.ypmc = ypmc;
	}
	/**
	 * @Description ypmc的中文含义是： 样品名称
	 */
	public String getYpmc(){
		return ypmc;
	}
	/**
	 * @Description countcy的中文含义是： 抽样数量
	 */
	public void setCountcy(String countcy){ 
		this.countcy = countcy;
	}
	/**
	 * @Description countcy的中文含义是： 抽样数量
	 */
	public String getCountcy(){
		return countcy;
	}
	/**
	 * @Description scdw的中文含义是： 生产单位
	 */
	public void setScdw(String scdw){ 
		this.scdw = scdw;
	}
	/**
	 * @Description scdw的中文含义是： 生产单位
	 */
	public String getScdw(){
		return scdw;
	}
	/**
	 * @Description bgbh的中文含义是： 报告书编号
	 */
	public String getBgbh() {
		return bgbh;
	}
	/**
	 * @Description bgbh的中文含义是： 报告书编号
	 */
	public void setBgbh(String bgbh) {
		this.bgbh = bgbh;
	}
	/**
	 * @Description jsbgrq的中文含义是： 收到报告日期
	 */
	public String getJsbgrq() {
		return jsbgrq;
	}
	/**
	 * @Description jsbgrq的中文含义是： 收到报告日期
	 */
	public void setJsbgrq(String jsbgrq) {
		this.jsbgrq = jsbgrq;
	}
	/**
	 * @Description bgsdrq的中文含义是： 报告送达日期
	 */
	public String getBgsdrq() {
		return bgsdrq;
	}
	/**
	 * @Description bgsdrq的中文含义是： 报告送达日期
	 */
	public void setBgsdrq(String bgsdrq) {
		this.bgsdrq = bgsdrq;
	}
	/**
	 * @Description jcrq的中文含义是： 检测日期
	 */
	public String getJcrq() {
		return jcrq;
	}
	/**
	 * @Description jcrq的中文含义是： 检测日期
	 */
	public void setJcrq(String jcrq) {
		this.jcrq = jcrq;
	}
	/**
	 * @Description lah的中文含义是： 立案号
	 */
	public String getLah() {
		return lah;
	}
	/**
	 * @Description lah的中文含义是： 立案号
	 */
	public void setLah(String lah) {
		this.lah = lah;
	}
	/**
	 * @Description jcdwmc的中文含义是： 检测单位名称
	 */
	public String getJcdwmc() {
		return jcdwmc;
	}
	/**
	 * @Description jcdwmc的中文含义是： 检测单位名称
	 */
	public void setJcdwmc(String jcdwmc) {
		this.jcdwmc = jcdwmc;
	}
	/**
	 * @Description jxjcxmmc的中文含义是： 检测项目
	 */
	public String getJxjcxmmc() {
		return jxjcxmmc;
	}
	/**
	 * @Description jxjcxmmc的中文含义是： 检测项目
	 */
	public void setJxjcxmmc(String jxjcxmmc) {
		this.jxjcxmmc = jxjcxmmc;
	}
	/**
	 * @Description sfhg的中文含义是： 是否合格
	 */
	public String getSfhg() {
		return sfhg;
	}
	/**
	 * @Description sfhg的中文含义是： 是否合格
	 */
	public void setSfhg(String sfhg) {
		this.sfhg = sfhg;
	}
	/**
	 * @Description dw的中文含义是： 单位
	 */
	public String getDw() {
		return dw;
	}
	/**
	 * @Description dw的中文含义是： 单位
	 */
	public void setDw(String dw) {
		this.dw = dw;
	}
	/**
	 * @Description jyjcjg的中文含义是： 结果
	 */
	public String getJyjcjg() {
		return jyjcjg;
	}
	/**
	 * @Description jyjcjg的中文含义是： 结果
	 */
	public void setJyjcjg(String jyjcjg) {
		this.jyjcjg = jyjcjg;
	}
	/**
	 * @Description bzz的中文含义是： 标准值
	 */
	public String getBzz() {
		return bzz;
	}
	/**
	 * @Description bzz的中文含义是： 标准值
	 */
	public void setBzz(String bzz) {
		this.bzz = bzz;
	}
	/**
	 * @Description yjqk的中文含义是： 移交情况
	 */
	public String getYjqk() {
		return yjqk;
	}
	/**
	 * @Description yjqk的中文含义是： 移交情况
	 */
	public void setYjqk(String yjqk) {
		this.yjqk = yjqk;
	}
}