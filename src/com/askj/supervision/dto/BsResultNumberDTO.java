package com.askj.supervision.dto;
/**
 * 结果序号dto
 * @author Administrator
 *
 */
public class BsResultNumberDTO {
	private int impcount;//所有设置了重要性的项目数
	private String impnum;//所有设置了重要性的项目的项目编码串
	private int problemcount;//发现问题项
	private String problemnum;//发现问题项目序号
    private int commocount;////一般项数
	private String commnum;//一般项项目编码串
	private int comproblemcount;//一般项发现问题项目数
	private String comproblemnum;//一般项发现问题项目编码串
	private String impDetail;//重点项发现问题项目内容串
	private String comDetail;////一般项发现问题项目内容串
	public String getImpDetail() {
		return impDetail;
	}
	public void setImpDetail(String impDetail) {
		this.impDetail = impDetail;
	}
	public String getComDetail() {
		return comDetail;
	}
	public void setComDetail(String comDetail) {
		this.comDetail = comDetail;
	}
	public int getImpcount() {
		return impcount;
	}
	public void setImpcount(int impcount) {
		this.impcount = impcount;
	}
	public String getImpnum() {
		return impnum;
	}
	public void setImpnum(String impnum) {
		this.impnum = impnum;
	}
	public int getProblemcount() {
		return problemcount;
	}
	public void setProblemcount(int problemcount) {
		this.problemcount = problemcount;
	}
	public String getProblemnum() {
		return problemnum;
	}
	public void setProblemnum(String problemnum) {
		this.problemnum = problemnum;
	}
	public int getCommocount() {
		return commocount;
	}
	public void setCommocount(int commocount) {
		this.commocount = commocount;
	}
	public String getCommnum() {
		return commnum;
	}
	public void setCommnum(String commnum) {
		this.commnum = commnum;
	}
	public int getComproblemcount() {
		return comproblemcount;
	}
	public void setComproblemcount(int comproblemcount) {
		this.comproblemcount = comproblemcount;
	}
	public String getComproblemnum() {
		return comproblemnum;
	}
	public void setComproblemnum(String comproblemnum) {
		this.comproblemnum = comproblemnum;
	}
	
}
