package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import java.io.InputStream;

/**
 * @Description  PCOMQRCODE的中文含义是: 企业二维码
 * @Creation     2016/11/09 14:39:41
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PCOMQRCODE")
public class Pcomqrcode {
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_comid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_comid.nextval from dual"))
	private String comid;

	/**
	 * @Description qrcodecontent的中文含义是： 二维码内容
	 */
	@Column
	private InputStream qrcodecontent;

	/**
	 * @Description qrcodepath的中文含义是： 二维码存放路径
	 */
	@Column
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
	 * @Description qrcodecontent的中文含义是： 二维码内容
	 */
	public void setQrcodecontent(InputStream qrcodecontent){ 
		this.qrcodecontent = qrcodecontent;
	}
	/**
	 * @Description qrcodecontent的中文含义是： 二维码内容
	 */
	public InputStream getQrcodecontent(){
		return qrcodecontent;
	}
	/**
	 * @Description qrcodepath的中文含义是：二维码存放路径
	 */
	public String getQrcodepath() {
		return qrcodepath;
	}
	/**
	 * @Description qrcodepath的中文含义是： 二维码存放路径
	 */
	public void setQrcodepath(String qrcodepath) {
		this.qrcodepath = qrcodepath;
	}

	
}