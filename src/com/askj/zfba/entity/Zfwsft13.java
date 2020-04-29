package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSFT13的中文含义是: 封条; InnoDB free: 76800 kB
 * @Creation     2016/03/16 10:58:30
 * @Written      Create Tool By wanghao 
 **/
@Table(value = "ZFWSFT13")
public class Zfwsft13 {
	/**
	 * @Description ftid的中文含义是： 封条ID
	 */
	@Name
	@Column
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_ftid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_ftid.nextval from dual"))
	private String ftid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description spypjdgljmc的中文含义是： 从aa01中aaa100=SPYPJDGLJMC取
	 */
	@Column
	private String spypjdgljmc;

	/**
	 * @Description ftyzrq的中文含义是： 封条印章日期
	 */
	@Column
	private String ftyzrq;

	
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