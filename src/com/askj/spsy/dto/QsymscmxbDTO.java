package com.askj.spsy.dto;

/**
 * @Description  QSYMSCMXB的中文含义是: 溯源码生产明细表; InnoDB free: 2715648 kBDTO
 * @Creation     2016/07/03 16:41:21
 * @Written      Create Tool By zjf 
 **/
public class QsymscmxbDTO {
	/**
	 * @Description qsymscmxbid的中文含义是： 
	 */
	private String qsymscmxbid;

	/**
	 * @Description qsymscbid的中文含义是： 溯源码生成表主键
	 */
	private String qsymscbid;

	/**
	 * @Description sym的中文含义是： 溯源码
	 */
	private String sym;
	
	/**
	 * @Description qrcodepath的中文含义是：二维码图片存放路径
	 */
	private String qrcodepath;	

	
		/**
	 * @Description qsymscmxbid的中文含义是： 
	 */
	public void setQsymscmxbid(String qsymscmxbid){ 
		this.qsymscmxbid = qsymscmxbid;
	}
	/**
	 * @Description qsymscmxbid的中文含义是： 
	 */
	public String getQsymscmxbid(){
		return qsymscmxbid;
	}
	/**
	 * @Description qsymscbid的中文含义是： 溯源码生成表主键
	 */
	public void setQsymscbid(String qsymscbid){ 
		this.qsymscbid = qsymscbid;
	}
	/**
	 * @Description qsymscbid的中文含义是： 溯源码生成表主键
	 */
	public String getQsymscbid(){
		return qsymscbid;
	}
	/**
	 * @Description sym的中文含义是： 溯源码
	 */
	public void setSym(String sym){ 
		this.sym = sym;
	}
	/**
	 * @Description sym的中文含义是： 溯源码
	 */
	public String getSym(){
		return sym;
	}
	public String getQrcodepath() {
		return qrcodepath;
	}
	public void setQrcodepath(String qrcodepath) {
		this.qrcodepath = qrcodepath;
	}

	
	
}