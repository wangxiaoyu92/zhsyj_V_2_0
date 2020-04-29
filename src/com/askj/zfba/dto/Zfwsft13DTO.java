package com.askj.zfba.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSFT13的中文含义是: 封条; InnoDB free: 76800 kBDTO
 * @Creation     2016/03/16 11:00:39
 * @Written      Create Tool By wanghao
 **/
public class Zfwsft13DTO {
	/**
	 * @Description ftid的中文含义是： 封条ID
	 */
	private String ftid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description spypjdgljmc的中文含义是： 从aa01中aaa100=SPYPJDGLJMC取
	 */
	private String spypjdgljmc;

	/**
	 * @Description ftyzrq的中文含义是： 封条印章日期
	 */
	private String ftyzrq;
	
	/**
	 * @Description dczjajcbrqzrq的中文含义是： 执法文书编号
	 */
	private String zfwsdmz;
	
	
	
	public String getZfwsdmz() {
		return zfwsdmz;
	}
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
		/**
	 * @Description ftid的中文含义是： 封条ID
	 */
	public void setFtid(String ftid){ 
		this.ftid = ftid;
	}
	/**
	 * @Description ftid的中文含义是： 封条ID
	 */
	public String getFtid(){
		return ftid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description spypjdgljmc的中文含义是： 从aa01中aaa100=SPYPJDGLJMC取
	 */
	public void setSpypjdgljmc(String spypjdgljmc){ 
		this.spypjdgljmc = spypjdgljmc;
	}
	/**
	 * @Description spypjdgljmc的中文含义是： 从aa01中aaa100=SPYPJDGLJMC取
	 */
	public String getSpypjdgljmc(){
		return spypjdgljmc;
	}
	/**
	 * @Description ftyzrq的中文含义是： 封条印章日期
	 */
	public void setFtyzrq(String ftyzrq){ 
		this.ftyzrq = ftyzrq;
	}
	/**
	 * @Description ftyzrq的中文含义是： 封条印章日期
	 */
	public String getFtyzrq(){
		return ftyzrq;
	}

	
}