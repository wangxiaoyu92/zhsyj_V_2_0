package com.askj.baseinfo.dto;

/**
 * @Description  PCOMQRCODE的中文含义是: 企业二维码DTO
 * @Creation     2016/11/09 14:39:02
 * @Written      Create Tool By zjf 
 **/
public class PcomqrcodeDTO {
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	private String comid;

	/**
	 * @Description commc的中文含义是： 公司名称
	 */
	private String commc;
	
	/**
	 * @Description qrcodecontent的中文含义是： 二维码内容
	 */
	private String qrcodecontent;
	
	/**
	 * @Description qrcodepath的中文含义是： 二维码路径
	 */
	private String qrcodepath;
	
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public String getComid(){
		return comid;
	}
	
	/**
	 * @Description commc的中文含义是： 公司名称
	 */
	public String getCommc() {
		return commc;
	}
	/**
	 * @Description commc的中文含义是： 公司名称
	 */
	public void setCommc(String commc) {
		this.commc = commc;
	}
	/**
	 * @Description qrcodecontent的中文含义是： 二维码内容
	 */
	public void setQrcodecontent(String qrcodecontent){ 
		this.qrcodecontent = qrcodecontent;
	}
	/**
	 * @Description qrcodecontent的中文含义是： 二维码内容
	 */
	public String getQrcodecontent(){
		return qrcodecontent;
	}
	/**
	 * @Description qrcodepath的中文含义是： 二维码路径
	 */
	public String getQrcodepath() {
		return qrcodepath;
	}
	/**
	 * @Description qrcodepath的中文含义是： 二维码路径
	 */
	public void setQrcodepath(String qrcodepath) {
		this.qrcodepath = qrcodepath;
	}
	
	

	
}