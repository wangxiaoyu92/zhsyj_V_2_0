package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCSSBFHYJS35的中文含义是: 陈述申辩复核意见书; InnoDB free: 2725888 kB
 * @Creation     2016/06/24 16:53:25
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSCSSBFHYJS35")
public class Zfwscssbfhyjs35 {
	/**
	 * @Description cssbfhyjsid的中文含义是： 陈述申辩复核意见书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cssbfhyjsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_cssbfhyjsid.nextval from dual"))
	private String cssbfhyjsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description sbfhncfyj的中文含义是： 拟处罚意见
	 */
	@Column
	private String sbfhncfyj;

	/**
	 * @Description sbfhcssbjbqk的中文含义是： 陈述申辩基本情况
	 */
	@Column
	private String sbfhcssbjbqk;

	/**
	 * @Description sbfhbmyj的中文含义是： 复核部门意见
	 */
	@Column
	private String sbfhbmyj;

	/**
	 * @Description sbfhfzrqz的中文含义是： 负责人签字
	 */
	@Column
	private String sbfhfzrqz;

	/**
	 * @Description sbfhfzrqzrq的中文含义是： 负责人签字日期
	 */
	@Column
	private String sbfhfzrqzrq;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description sbfhdsr的中文含义是： 当事人
	 */
	@Column
	private String sbfhdsr;

	/**
	 * @Description sbfhfddbr的中文含义是： 法定代表人（负责人）
	 */
	@Column
	private String sbfhfddbr;

	
		/**
	 * @Description cssbfhyjsid的中文含义是： 陈述申辩复核意见书ID
	 */
	public void setCssbfhyjsid(String cssbfhyjsid){ 
		this.cssbfhyjsid = cssbfhyjsid;
	}
	/**
	 * @Description cssbfhyjsid的中文含义是： 陈述申辩复核意见书ID
	 */
	public String getCssbfhyjsid(){
		return cssbfhyjsid;
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
	 * @Description sbfhncfyj的中文含义是： 拟处罚意见
	 */
	public void setSbfhncfyj(String sbfhncfyj){ 
		this.sbfhncfyj = sbfhncfyj;
	}
	/**
	 * @Description sbfhncfyj的中文含义是： 拟处罚意见
	 */
	public String getSbfhncfyj(){
		return sbfhncfyj;
	}
	/**
	 * @Description sbfhcssbjbqk的中文含义是： 陈述申辩基本情况
	 */
	public void setSbfhcssbjbqk(String sbfhcssbjbqk){ 
		this.sbfhcssbjbqk = sbfhcssbjbqk;
	}
	/**
	 * @Description sbfhcssbjbqk的中文含义是： 陈述申辩基本情况
	 */
	public String getSbfhcssbjbqk(){
		return sbfhcssbjbqk;
	}
	/**
	 * @Description sbfhbmyj的中文含义是： 复核部门意见
	 */
	public void setSbfhbmyj(String sbfhbmyj){ 
		this.sbfhbmyj = sbfhbmyj;
	}
	/**
	 * @Description sbfhbmyj的中文含义是： 复核部门意见
	 */
	public String getSbfhbmyj(){
		return sbfhbmyj;
	}
	/**
	 * @Description sbfhfzrqz的中文含义是： 负责人签字
	 */
	public void setSbfhfzrqz(String sbfhfzrqz){ 
		this.sbfhfzrqz = sbfhfzrqz;
	}
	/**
	 * @Description sbfhfzrqz的中文含义是： 负责人签字
	 */
	public String getSbfhfzrqz(){
		return sbfhfzrqz;
	}
	/**
	 * @Description sbfhfzrqzrq的中文含义是： 负责人签字日期
	 */
	public void setSbfhfzrqzrq(String sbfhfzrqzrq){ 
		this.sbfhfzrqzrq = sbfhfzrqzrq;
	}
	/**
	 * @Description sbfhfzrqzrq的中文含义是： 负责人签字日期
	 */
	public String getSbfhfzrqzrq(){
		return sbfhfzrqzrq;
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
	 * @Description sbfhdsr的中文含义是： 当事人
	 */
	public void setSbfhdsr(String sbfhdsr){ 
		this.sbfhdsr = sbfhdsr;
	}
	/**
	 * @Description sbfhdsr的中文含义是： 当事人
	 */
	public String getSbfhdsr(){
		return sbfhdsr;
	}
	/**
	 * @Description sbfhfddbr的中文含义是： 法定代表人（负责人）
	 */
	public void setSbfhfddbr(String sbfhfddbr){ 
		this.sbfhfddbr = sbfhfddbr;
	}
	/**
	 * @Description sbfhfddbr的中文含义是： 法定代表人（负责人）
	 */
	public String getSbfhfddbr(){
		return sbfhfddbr;
	}

	
}