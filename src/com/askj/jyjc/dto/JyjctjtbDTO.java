package com.askj.jyjc.dto;

/**
 * 
 * JyjctjtbDTO的中文名称：检验检测统计图表中用到的属性
 *
 * JyjctjtbDTO的描述
 *
 * Written by CatchU 2016年5月12日上午10:51:34
 */
public class JyjctjtbDTO {

	//检测检验类别
	private String jcjylb;
	//检测检验时长（月报表、季报表）
	private  String jyjcsc;
	//合格率
	private String hgl;
	//检测检验开始时间
	private String startTime;
	//检测检验结束时间
	private String endTime;
	//检测日期
	private String jcrq;  
	//标准值合计
	private String bzzTotal;
	//结果值合计
	private String jgzTotal;
	
	public String getJcjylb() {
		return jcjylb;
	}
	public void setJcjylb(String jcjylb) {
		this.jcjylb = jcjylb;
	}
	public String getJyjcsc() {
		return jyjcsc;
	}
	public void setJyjcsc(String jyjcsc) {
		this.jyjcsc = jyjcsc;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getJcrq() {
		return jcrq;
	}
	public void setJcrq(String jcrq) {
		this.jcrq = jcrq;
	}
	
	public String getBzzTotal() {
		return bzzTotal;
	}
	public void setBzzTotal(String bzzTotal) {
		this.bzzTotal = bzzTotal;
	}
	public String getJgzTotal() {
		return jgzTotal;
	}
	public void setJgzTotal(String jgzTotal) {
		this.jgzTotal = jgzTotal;
	}
	public String getHgl() {
		return hgl;
	}
	public void setHgl(String hgl) {
		this.hgl = hgl;
	}
	
}
