package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PFLFGTK的中文含义是: 法律法规条款; InnoDB free: 2760704 kB
 * @Creation     2016/04/12 10:56:11
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PFLFGTK")
public class Pflfgtk {
	/**
	 * @Description pflfgtkid的中文含义是： 法律法规条款ID
	 */
	@Column
	@Name
	private String flfgtkid;

	/**
	 * @Description flfgid的中文含义是： pflfg表主键
	 */
	@Column
	private String flfgid;

	/**
	 * @Description flfgtkxm的中文含义是： 法律法规条款
	 */
	@Column
	private String flfgtkxm;

	/**
	 * @Description flfgtknr的中文含义是： 法律法规条款内容
	 */
	@Column
	private String flfgtknr;

	/**
	 * @Description flfgtkcybz的中文含义是： 法律法规条款常用标志见aaa100=FLFGTKCYBZ
	 */
	@Column
	private String flfgtkcybz;

	
		/**
	 * @Description pflfgtkid的中文含义是： 法律法规条款ID
	 */
	public void setFlfgtkid(String flfgtkid){ 
		this.flfgtkid = flfgtkid;
	}
	/**
	 * @Description pflfgtkid的中文含义是： 法律法规条款ID
	 */
	public String getFlfgtkid(){
		return flfgtkid;
	}
	/**
	 * @Description flfgid的中文含义是： pflfg表主键
	 */
	public void setFlfgid(String flfgid){ 
		this.flfgid = flfgid;
	}
	/**
	 * @Description flfgid的中文含义是： pflfg表主键
	 */
	public String getFlfgid(){
		return flfgid;
	}

	public String getFlfgtkxm() {
		return flfgtkxm;
	}
	public void setFlfgtkxm(String flfgtkxm) {
		this.flfgtkxm = flfgtkxm;
	}
	/**
	 * @Description flfgtknr的中文含义是： 法律法规条款内容
	 */
	public void setFlfgtknr(String flfgtknr){ 
		this.flfgtknr = flfgtknr;
	}
	/**
	 * @Description flfgtknr的中文含义是： 法律法规条款内容
	 */
	public String getFlfgtknr(){
		return flfgtknr;
	}
	/**
	 * @Description flfgtkcybz的中文含义是： 法律法规条款常用标志见aaa100=FLFGTKCYBZ
	 */
	public void setFlfgtkcybz(String flfgtkcybz){ 
		this.flfgtkcybz = flfgtkcybz;
	}
	/**
	 * @Description flfgtkcybz的中文含义是： 法律法规条款常用标志见aaa100=FLFGTKCYBZ
	 */
	public String getFlfgtkcybz(){
		return flfgtkcybz;
	}

	
}