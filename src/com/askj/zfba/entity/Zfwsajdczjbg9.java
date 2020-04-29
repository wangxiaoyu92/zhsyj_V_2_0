package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSAJDCZJBG9的中文含义是: 案件调查终结报告; InnoDB free: 2723840 kB
 * @Creation     2016/06/03 14:44:50
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSAJDCZJBG9")
public class Zfwsajdczjbg9 {
	/**
	 * @Description ajdczjbgid的中文含义是： 案件调查终结报告ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_ajdczjbgid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_ajdczjbgid.nextval from dual"))
	private String ajdczjbgid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description dczjdsrjbqk的中文含义是： 当事人基本情况
	 */
	@Column
	private String dczjdsrjbqk;

	/**
	 * @Description dczjwfss的中文含义是： 违法事实
	 */
	@Column
	private String dczjwfss;

	/**
	 * @Description dczjzjcl的中文含义是： 证据材料
	 */
	@Column
	private String dczjzjcl;

	/**
	 * @Description dczjcfyj的中文含义是： 处罚依据
	 */
	@Column
	private String dczjcfyj;

	/**
	 * @Description dczjcfjy的中文含义是： 处罚建议
	 */
	@Column
	private String dczjcfjy;

	/**
	 * @Description dczjajcbrqz的中文含义是： 案件承办人签字1
	 */
	@Column
	private String dczjajcbrqz;

	/**
	 * @Description dczjajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	@Column
	private String dczjajcbrqzrq;

	/**
	 * @Description dczjwfflfgtk的中文含义是： 违法法律法规条款
	 */
	@Column
	private String dczjwfflfgtk;

	/**
	 * @Description dczjwfxwdc的中文含义是： 违法行为等次
	 */
	@Column
	private String dczjwfxwdc;

	/**
	 * @Description dczjysxzcfdyjhzl的中文含义是： 应受行政处罚的依据和种类
	 */
	@Column
	private String dczjysxzcfdyjhzl;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description dczjajcbrqz2的中文含义是： 案件承办人签字2
	 */
	@Column
	private String dczjajcbrqz2;

	
		/**
	 * @Description ajdczjbgid的中文含义是： 案件调查终结报告ID
	 */
	public void setAjdczjbgid(String ajdczjbgid){ 
		this.ajdczjbgid = ajdczjbgid;
	}
	/**
	 * @Description ajdczjbgid的中文含义是： 案件调查终结报告ID
	 */
	public String getAjdczjbgid(){
		return ajdczjbgid;
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
	 * @Description dczjdsrjbqk的中文含义是： 当事人基本情况
	 */
	public void setDczjdsrjbqk(String dczjdsrjbqk){ 
		this.dczjdsrjbqk = dczjdsrjbqk;
	}
	/**
	 * @Description dczjdsrjbqk的中文含义是： 当事人基本情况
	 */
	public String getDczjdsrjbqk(){
		return dczjdsrjbqk;
	}
	/**
	 * @Description dczjwfss的中文含义是： 违法事实
	 */
	public void setDczjwfss(String dczjwfss){ 
		this.dczjwfss = dczjwfss;
	}
	/**
	 * @Description dczjwfss的中文含义是： 违法事实
	 */
	public String getDczjwfss(){
		return dczjwfss;
	}
	/**
	 * @Description dczjzjcl的中文含义是： 证据材料
	 */
	public void setDczjzjcl(String dczjzjcl){ 
		this.dczjzjcl = dczjzjcl;
	}
	/**
	 * @Description dczjzjcl的中文含义是： 证据材料
	 */
	public String getDczjzjcl(){
		return dczjzjcl;
	}
	/**
	 * @Description dczjcfyj的中文含义是： 处罚依据
	 */
	public void setDczjcfyj(String dczjcfyj){ 
		this.dczjcfyj = dczjcfyj;
	}
	/**
	 * @Description dczjcfyj的中文含义是： 处罚依据
	 */
	public String getDczjcfyj(){
		return dczjcfyj;
	}
	/**
	 * @Description dczjcfjy的中文含义是： 处罚建议
	 */
	public void setDczjcfjy(String dczjcfjy){ 
		this.dczjcfjy = dczjcfjy;
	}
	/**
	 * @Description dczjcfjy的中文含义是： 处罚建议
	 */
	public String getDczjcfjy(){
		return dczjcfjy;
	}
	/**
	 * @Description dczjajcbrqz的中文含义是： 案件承办人签字1
	 */
	public void setDczjajcbrqz(String dczjajcbrqz){ 
		this.dczjajcbrqz = dczjajcbrqz;
	}
	/**
	 * @Description dczjajcbrqz的中文含义是： 案件承办人签字1
	 */
	public String getDczjajcbrqz(){
		return dczjajcbrqz;
	}
	/**
	 * @Description dczjajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	public void setDczjajcbrqzrq(String dczjajcbrqzrq){ 
		this.dczjajcbrqzrq = dczjajcbrqzrq;
	}
	/**
	 * @Description dczjajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	public String getDczjajcbrqzrq(){
		return dczjajcbrqzrq;
	}
	/**
	 * @Description dczjwfflfgtk的中文含义是： 违法法律法规条款
	 */
	public void setDczjwfflfgtk(String dczjwfflfgtk){ 
		this.dczjwfflfgtk = dczjwfflfgtk;
	}
	/**
	 * @Description dczjwfflfgtk的中文含义是： 违法法律法规条款
	 */
	public String getDczjwfflfgtk(){
		return dczjwfflfgtk;
	}
	/**
	 * @Description dczjwfxwdc的中文含义是： 违法行为等次
	 */
	public void setDczjwfxwdc(String dczjwfxwdc){ 
		this.dczjwfxwdc = dczjwfxwdc;
	}
	/**
	 * @Description dczjwfxwdc的中文含义是： 违法行为等次
	 */
	public String getDczjwfxwdc(){
		return dczjwfxwdc;
	}
	/**
	 * @Description dczjysxzcfdyjhzl的中文含义是： 应受行政处罚的依据和种类
	 */
	public void setDczjysxzcfdyjhzl(String dczjysxzcfdyjhzl){ 
		this.dczjysxzcfdyjhzl = dczjysxzcfdyjhzl;
	}
	/**
	 * @Description dczjysxzcfdyjhzl的中文含义是： 应受行政处罚的依据和种类
	 */
	public String getDczjysxzcfdyjhzl(){
		return dczjysxzcfdyjhzl;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public void setAjdjay(String ajdjay){ 
		this.ajdjay = ajdjay;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public String getAjdjay(){
		return ajdjay;
	}
	/**
	 * @Description dczjajcbrqz2的中文含义是： 案件承办人签字2
	 */
	public void setDczjajcbrqz2(String dczjajcbrqz2){ 
		this.dczjajcbrqz2 = dczjajcbrqz2;
	}
	/**
	 * @Description dczjajcbrqz2的中文含义是： 案件承办人签字2
	 */
	public String getDczjajcbrqz2(){
		return dczjajcbrqz2;
	}

	
}