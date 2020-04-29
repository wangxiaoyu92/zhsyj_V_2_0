package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCASPB21的中文含义是: 撤案审批表21; InnoDB free: 2723840 kB
 * @Creation     2016/06/07 14:35:45
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSCASPB21")
public class Zfwscaspb21 {
	/**
	 * @Description caspbid的中文含义是： 撤案审批表
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_caspbid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_caspbid.nextval from dual"))
	private String caspbid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description caspaqdczy的中文含义是： 案情调查摘要
	 */
	@Column
	private String caspaqdczy;

	/**
	 * @Description caspcaly的中文含义是： 撤案理由
	 */
	@Column
	private String caspcaly;

	/**
	 * @Description caspcbrqz的中文含义是： 承办人1
	 */
	@Column
	private String caspcbrqz;

	/**
	 * @Description caspcbrqzrq的中文含义是： 承办人签字日期
	 */
	@Column
	private String caspcbrqzrq;

	/**
	 * @Description caspcbbmfzr的中文含义是： 承办部门负责人签字
	 */
	@Column
	private String caspcbbmfzr;

	/**
	 * @Description caspcbbmfzrrq的中文含义是： 承办部门负责人签字日期
	 */
	@Column
	private String caspcbbmfzrrq;

	/**
	 * @Description caspshbmyj的中文含义是： 审核部门意见
	 */
	@Column
	private String caspshbmyj;

	/**
	 * @Description caspshfzr的中文含义是： 审核部门负责人
	 */
	@Column
	private String caspshfzr;

	/**
	 * @Description caspshfzrrq的中文含义是： 审核部门负责人签字日期
	 */
	@Column
	private String caspshfzrrq;

	/**
	 * @Description caspspyj的中文含义是： 审批意见
	 */
	@Column
	private String caspspyj;

	/**
	 * @Description caspfzfzr的中文含义是： 分管负责人
	 */
	@Column
	private String caspfzfzr;

	/**
	 * @Description caspfzfzrrq的中文含义是： 分管负责人签字日期
	 */
	@Column
	private String caspfzfzrrq;

	/**
	 * @Description ajdjay的中文含义是： 案件登记案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description caspdsr的中文含义是： 当事人
	 */
	@Column
	private String caspdsr;

	/**
	 * @Description caspfddbr的中文含义是： 法定代表人(负责人)
	 */
	@Column
	private String caspfddbr;

	/**
	 * @Description caspdz的中文含义是： 地址
	 */
	@Column
	private String caspdz;

	/**
	 * @Description casplxfs的中文含义是： 联系方式
	 */
	@Column
	private String casplxfs;

	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	@Column
	private String ajdjajly;

	/**
	 * @Description casplasj的中文含义是： 立案时间
	 */
	@Column
	private String casplasj;

	/**
	 * @Description caspcbrqz2的中文含义是： 承办人签字2
	 */
	@Column
	private String caspcbrqz2;

	
		/**
	 * @Description caspbid的中文含义是： 撤案审批表
	 */
	public void setCaspbid(String caspbid){ 
		this.caspbid = caspbid;
	}
	/**
	 * @Description caspbid的中文含义是： 撤案审批表
	 */
	public String getCaspbid(){
		return caspbid;
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
	 * @Description caspaqdczy的中文含义是： 案情调查摘要
	 */
	public void setCaspaqdczy(String caspaqdczy){ 
		this.caspaqdczy = caspaqdczy;
	}
	/**
	 * @Description caspaqdczy的中文含义是： 案情调查摘要
	 */
	public String getCaspaqdczy(){
		return caspaqdczy;
	}
	/**
	 * @Description caspcaly的中文含义是： 撤案理由
	 */
	public void setCaspcaly(String caspcaly){ 
		this.caspcaly = caspcaly;
	}
	/**
	 * @Description caspcaly的中文含义是： 撤案理由
	 */
	public String getCaspcaly(){
		return caspcaly;
	}
	/**
	 * @Description caspcbrqz的中文含义是： 承办人1
	 */
	public void setCaspcbrqz(String caspcbrqz){ 
		this.caspcbrqz = caspcbrqz;
	}
	/**
	 * @Description caspcbrqz的中文含义是： 承办人1
	 */
	public String getCaspcbrqz(){
		return caspcbrqz;
	}
	/**
	 * @Description caspcbrqzrq的中文含义是： 承办人签字日期
	 */
	public void setCaspcbrqzrq(String caspcbrqzrq){ 
		this.caspcbrqzrq = caspcbrqzrq;
	}
	/**
	 * @Description caspcbrqzrq的中文含义是： 承办人签字日期
	 */
	public String getCaspcbrqzrq(){
		return caspcbrqzrq;
	}
	/**
	 * @Description caspcbbmfzr的中文含义是： 承办部门负责人签字
	 */
	public void setCaspcbbmfzr(String caspcbbmfzr){ 
		this.caspcbbmfzr = caspcbbmfzr;
	}
	/**
	 * @Description caspcbbmfzr的中文含义是： 承办部门负责人签字
	 */
	public String getCaspcbbmfzr(){
		return caspcbbmfzr;
	}
	/**
	 * @Description caspcbbmfzrrq的中文含义是： 承办部门负责人签字日期
	 */
	public void setCaspcbbmfzrrq(String caspcbbmfzrrq){ 
		this.caspcbbmfzrrq = caspcbbmfzrrq;
	}
	/**
	 * @Description caspcbbmfzrrq的中文含义是： 承办部门负责人签字日期
	 */
	public String getCaspcbbmfzrrq(){
		return caspcbbmfzrrq;
	}
	/**
	 * @Description caspshbmyj的中文含义是： 审核部门意见
	 */
	public void setCaspshbmyj(String caspshbmyj){ 
		this.caspshbmyj = caspshbmyj;
	}
	/**
	 * @Description caspshbmyj的中文含义是： 审核部门意见
	 */
	public String getCaspshbmyj(){
		return caspshbmyj;
	}
	/**
	 * @Description caspshfzr的中文含义是： 审核部门负责人
	 */
	public void setCaspshfzr(String caspshfzr){ 
		this.caspshfzr = caspshfzr;
	}
	/**
	 * @Description caspshfzr的中文含义是： 审核部门负责人
	 */
	public String getCaspshfzr(){
		return caspshfzr;
	}
	/**
	 * @Description caspshfzrrq的中文含义是： 审核部门负责人签字日期
	 */
	public void setCaspshfzrrq(String caspshfzrrq){ 
		this.caspshfzrrq = caspshfzrrq;
	}
	/**
	 * @Description caspshfzrrq的中文含义是： 审核部门负责人签字日期
	 */
	public String getCaspshfzrrq(){
		return caspshfzrrq;
	}
	/**
	 * @Description caspspyj的中文含义是： 审批意见
	 */
	public void setCaspspyj(String caspspyj){ 
		this.caspspyj = caspspyj;
	}
	/**
	 * @Description caspspyj的中文含义是： 审批意见
	 */
	public String getCaspspyj(){
		return caspspyj;
	}
	/**
	 * @Description caspfzfzr的中文含义是： 分管负责人
	 */
	public void setCaspfzfzr(String caspfzfzr){ 
		this.caspfzfzr = caspfzfzr;
	}
	/**
	 * @Description caspfzfzr的中文含义是： 分管负责人
	 */
	public String getCaspfzfzr(){
		return caspfzfzr;
	}
	/**
	 * @Description caspfzfzrrq的中文含义是： 分管负责人签字日期
	 */
	public void setCaspfzfzrrq(String caspfzfzrrq){ 
		this.caspfzfzrrq = caspfzfzrrq;
	}
	/**
	 * @Description caspfzfzrrq的中文含义是： 分管负责人签字日期
	 */
	public String getCaspfzfzrrq(){
		return caspfzfzrrq;
	}
	/**
	 * @Description ajdjay的中文含义是： 案件登记案由
	 */
	public void setAjdjay(String ajdjay){ 
		this.ajdjay = ajdjay;
	}
	/**
	 * @Description ajdjay的中文含义是： 案件登记案由
	 */
	public String getAjdjay(){
		return ajdjay;
	}
	/**
	 * @Description caspdsr的中文含义是： 当事人
	 */
	public void setCaspdsr(String caspdsr){ 
		this.caspdsr = caspdsr;
	}
	/**
	 * @Description caspdsr的中文含义是： 当事人
	 */
	public String getCaspdsr(){
		return caspdsr;
	}
	/**
	 * @Description caspfddbr的中文含义是： 法定代表人(负责人)
	 */
	public void setCaspfddbr(String caspfddbr){ 
		this.caspfddbr = caspfddbr;
	}
	/**
	 * @Description caspfddbr的中文含义是： 法定代表人(负责人)
	 */
	public String getCaspfddbr(){
		return caspfddbr;
	}
	/**
	 * @Description caspdz的中文含义是： 地址
	 */
	public void setCaspdz(String caspdz){ 
		this.caspdz = caspdz;
	}
	/**
	 * @Description caspdz的中文含义是： 地址
	 */
	public String getCaspdz(){
		return caspdz;
	}
	/**
	 * @Description casplxfs的中文含义是： 联系方式
	 */
	public void setCasplxfs(String casplxfs){ 
		this.casplxfs = casplxfs;
	}
	/**
	 * @Description casplxfs的中文含义是： 联系方式
	 */
	public String getCasplxfs(){
		return casplxfs;
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
	/**
	 * @Description casplasj的中文含义是： 立案时间
	 */
	public void setCasplasj(String casplasj){ 
		this.casplasj = casplasj;
	}
	/**
	 * @Description casplasj的中文含义是： 立案时间
	 */
	public String getCasplasj(){
		return casplasj;
	}
	/**
	 * @Description caspcbrqz2的中文含义是： 承办人签字2
	 */
	public void setCaspcbrqz2(String caspcbrqz2){ 
		this.caspcbrqz2 = caspcbrqz2;
	}
	/**
	 * @Description caspcbrqz2的中文含义是： 承办人签字2
	 */
	public String getCaspcbrqz2(){
		return caspcbrqz2;
	}

	
}