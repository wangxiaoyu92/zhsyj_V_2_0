package com.askj.jyjc.dto;
 
public class JyjctjfxDTO {
	/*
	 * 样品名称
	 */
	private String ypmc;
	/*
	 * 项目名称
	 */
	private String jcxmmc;
	/*
	 * 检查次数
	 */
	private String jccs;
	/*
	 * 合格次数
	 */
	private String hgcs;
	/*
	 * 超标次数
	 */
	private String cbcs;
	/*
	 * 合格率
	 */
	private String hgl;
	/*
	 * 超标率
	 */
	private String cbl;
	/*
	 * 开始时间
	 */
	private String kssj;
	/*
	 * 结束时间
	 */
	private String jssj;
	/*
	 * 统计方式
	 */
	private String tjfs;
	/*
	 * 企业名称
	 */
	private String comdm;
	/*
	 * 企业id
	 */
	private String comid;
	/*
	 * 检测检验类别
	 */
	private String jcjylb;

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}

	public String getJcxmmc() {
		return jcxmmc;
	}
	public void setJcxmmc(String jcxmmc) {
		this.jcxmmc = jcxmmc;
	}
	public String getJcjylb() {
		return jcjylb;
	}
	public void setJcjylb(String jcjylb) {
		this.jcjylb = jcjylb;
	}
	public void setComdm(String comdm) {
		this.comdm = comdm;
	}
	public String getYpmc() {
		return ypmc;
	}
	public void setYpmc(String ypmc) {
		this.ypmc = ypmc;
	}
	public String getJccs() {
		return jccs;
	}
	public void setJccs(String jccs) {
		this.jccs = jccs;
	}
	public String getHgcs() {
		return hgcs;
	}
	public void setHgcs(String hgcs) {
		this.hgcs = hgcs;
	}
	public String getCbcs() {
		return cbcs;
	}
	public void setCbcs(String cbcs) {
		this.cbcs = cbcs;
	}
	public String getHgl() {
		return hgl;
	}
	public void setHgl(String hgl) {
		this.hgl = hgl;
	}
	public String getCbl() {
		return cbl;
	}
	public void setCbl(String cbl) {
		this.cbl = cbl;
	}
	public String getKssj() {
		return kssj;
	}
	public void setKssj(String kssj) {
		this.kssj = kssj;
	}
	public String getJssj() {
		return jssj;
	}
	public void setJssj(String jssj) {
		this.jssj = jssj;
	}
	public String getTjfs() {
		return tjfs;
	}
	public void setTjfs(String tjfs) {
		this.tjfs = tjfs;
	}
	public String getComdm() {
		return comdm;
	}
	public void setCommc(String comdm) {
		this.comdm = comdm;
	}  
}