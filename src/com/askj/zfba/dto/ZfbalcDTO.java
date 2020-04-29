package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PFJCS的中文含义是: 附件参数表; InnoDB free: 11264 kBDTO
 * @Creation     2016/02/01 15:56:05
 * @Written      Create Tool By zjf 
 **/
public class ZfbalcDTO {
	/**
	 * @Description zxxmcsbm的中文含义是：征信项目参数编码
	 */
	private String zxxmcsbm;

	/**
	 * @Description ajdjid的中文含义是： 
	 */
	private String ajdjid;
	

	public String getZxxmcsbm() {
		return zxxmcsbm;
	}

	public void setZxxmcsbm(String zxxmcsbm) {
		this.zxxmcsbm = zxxmcsbm;
	}

	public String getAjdjid() {
		return ajdjid;
	}

	public void setAjdjid(String ajdjid) {
		this.ajdjid = ajdjid;
	}
	
}