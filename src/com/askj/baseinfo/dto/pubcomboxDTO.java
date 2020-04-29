package com.askj.baseinfo.dto;

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
public class pubcomboxDTO {
	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	private String codevalue;

	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	private String codename;

	public String getCodevalue() {
		return codevalue;
	}

	public void setCodevalue(String codevalue) {
		this.codevalue = codevalue;
	}

	public String getCodename() {
		return codename;
	}

	public void setCodename(String codename) {
		this.codename = codename;
	} 
}