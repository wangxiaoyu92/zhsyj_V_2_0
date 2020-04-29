package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSSXFZAJYSSPB4的中文含义是: 涉嫌犯罪案件移送审批表; InnoDB free: 2723840 kB
 * @Creation     2016/06/02 10:16:30
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSSXFZAJYSSPB4")
public class Zfwssxfzajysspb4 {
	/**
	 * @Description fzysspid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_fzysspid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_fzysspid.nextval from dual"))
	private String fzysspid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description sysjg的中文含义是： 受移送机关
	 */
	@Column
	private String sysjg;

	/**
	 * @Description zyaqjysyy的中文含义是： 主要案情及移送原因
	 */
	@Column
	private String zyaqjysyy;

	/**
	 * @Description jbr的中文含义是： 经办人
	 */
	@Column
	private String jbr;

	/**
	 * @Description jbrqzrq的中文含义是： 经办人签字日期
	 */
	@Column
	private String jbrqzrq;

	/**
	 * @Description cbbmyj的中文含义是： 承办部门意见
	 */
	@Column
	private String cbbmyj;

	/**
	 * @Description cbbmfzr的中文含义是： 承办部门负责人
	 */
	@Column
	private String cbbmfzr;

	/**
	 * @Description cbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	@Column
	private String cbbmfzrqzrq;

	/**
	 * @Description spyj的中文含义是： 审批意见
	 */
	@Column
	private String spyj;

	/**
	 * @Description spfzr的中文含义是： 审批负责人
	 */
	@Column
	private String spfzr;

	/**
	 * @Description spfzrqzrq的中文含义是： 审批负责人签字日期
	 */
	@Column
	private String spfzrqzrq;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	@Column
	private String ajdjajly;
	/**
	 * @Description ajdjfgfzr的中文含义是：分管负责人意见
	 */
	@Column
	private String fgfzryj;
	/**
	 * @Description  fgfzrqz的中文含义是： 分管负责人签字
	 */
	@Column
	private String fgfzrqz;
	/**
	 * @Description fgfzrqzrq的中文含义是： 分管负责人签字日期
	 */
	@Column
	private String fgfzrqzrq;

	
	 
	public String getFgfzryj() {
		return fgfzryj;
	}
	public String getFgfzrqz() {
		return fgfzrqz;
	}
	public String getFgfzrqzrq() {
		return fgfzrqzrq;
	}
	public void setFgfzryj(String fgfzryj) {
		this.fgfzryj = fgfzryj;
	}
	public void setFgfzrqz(String fgfzrqz) {
		this.fgfzrqz = fgfzrqz;
	}
	public void setFgfzrqzrq(String fgfzrqzrq) {
		this.fgfzrqzrq = fgfzrqzrq;
	}
		/**
	 * @Description fzysspid的中文含义是： 
	 */
	public void setFzysspid(String fzysspid){ 
		this.fzysspid = fzysspid;
	}
	/**
	 * @Description fzysspid的中文含义是： 
	 */
	public String getFzysspid(){
		return fzysspid;
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
	 * @Description sysjg的中文含义是： 受移送机关
	 */
	public void setSysjg(String sysjg){ 
		this.sysjg = sysjg;
	}
	/**
	 * @Description sysjg的中文含义是： 受移送机关
	 */
	public String getSysjg(){
		return sysjg;
	}
	/**
	 * @Description zyaqjysyy的中文含义是： 主要案情及移送原因
	 */
	public void setZyaqjysyy(String zyaqjysyy){ 
		this.zyaqjysyy = zyaqjysyy;
	}
	/**
	 * @Description zyaqjysyy的中文含义是： 主要案情及移送原因
	 */
	public String getZyaqjysyy(){
		return zyaqjysyy;
	}
	/**
	 * @Description jbr的中文含义是： 经办人
	 */
	public void setJbr(String jbr){ 
		this.jbr = jbr;
	}
	/**
	 * @Description jbr的中文含义是： 经办人
	 */
	public String getJbr(){
		return jbr;
	}
	/**
	 * @Description jbrqzrq的中文含义是： 经办人签字日期
	 */
	public void setJbrqzrq(String jbrqzrq){ 
		this.jbrqzrq = jbrqzrq;
	}
	/**
	 * @Description jbrqzrq的中文含义是： 经办人签字日期
	 */
	public String getJbrqzrq(){
		return jbrqzrq;
	}
	/**
	 * @Description cbbmyj的中文含义是： 承办部门意见
	 */
	public void setCbbmyj(String cbbmyj){ 
		this.cbbmyj = cbbmyj;
	}
	/**
	 * @Description cbbmyj的中文含义是： 承办部门意见
	 */
	public String getCbbmyj(){
		return cbbmyj;
	}
	/**
	 * @Description cbbmfzr的中文含义是： 承办部门负责人
	 */
	public void setCbbmfzr(String cbbmfzr){ 
		this.cbbmfzr = cbbmfzr;
	}
	/**
	 * @Description cbbmfzr的中文含义是： 承办部门负责人
	 */
	public String getCbbmfzr(){
		return cbbmfzr;
	}
	/**
	 * @Description cbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	public void setCbbmfzrqzrq(String cbbmfzrqzrq){ 
		this.cbbmfzrqzrq = cbbmfzrqzrq;
	}
	/**
	 * @Description cbbmfzrqzrq的中文含义是： 承办部门负责人签字日期
	 */
	public String getCbbmfzrqzrq(){
		return cbbmfzrqzrq;
	}
	/**
	 * @Description spyj的中文含义是： 审批意见
	 */
	public void setSpyj(String spyj){ 
		this.spyj = spyj;
	}
	/**
	 * @Description spyj的中文含义是： 审批意见
	 */
	public String getSpyj(){
		return spyj;
	}
	/**
	 * @Description spfzr的中文含义是： 审批负责人
	 */
	public void setSpfzr(String spfzr){ 
		this.spfzr = spfzr;
	}
	/**
	 * @Description spfzr的中文含义是： 审批负责人
	 */
	public String getSpfzr(){
		return spfzr;
	}
	/**
	 * @Description spfzrqzrq的中文含义是： 审批负责人签字日期
	 */
	public void setSpfzrqzrq(String spfzrqzrq){ 
		this.spfzrqzrq = spfzrqzrq;
	}
	/**
	 * @Description spfzrqzrq的中文含义是： 审批负责人签字日期
	 */
	public String getSpfzrqzrq(){
		return spfzrqzrq;
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
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	public void setAjdjajly(String ajdjajly){ 
		this.ajdjajly = ajdjajly;
	}
	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	public String getAjdjajly(){
		return ajdjajly;
	}

	
}