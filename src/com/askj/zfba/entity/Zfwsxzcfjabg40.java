package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSXZCFJABG40的中文含义是: 行政处罚结案报告; InnoDB free: 2725888 kB
 * @Creation     2016/06/26 17:23:17
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXZCFJABG40")
public class Zfwsxzcfjabg40 {
	/**
	 * @Description xzcfjabgid的中文含义是： 行政处罚结案报告ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xzcfjabgid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xzcfjabgid.nextval from dual"))
	private String xzcfjabgid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description jabgjarq的中文含义是： 结案日期
	 */
	@Column
	private String jabgjarq;

	/**
	 * @Description jabgtxr的中文含义是： 填写人
	 */
	@Column
	private String jabgtxr;

	/**
	 * @Description jabgcfzlhfd的中文含义是： 处罚种类和幅度
	 */
	@Column
	private String jabgcfzlhfd;

	/**
	 * @Description jagdzxjg的中文含义是： 执行结果
	 */
	@Column
	private String jagdzxjg;

	/**
	 * @Description jagdjafs的中文含义是： 结案方式见aa10,aaa100=JAFS
	 */
	@Column
	private String jagdjafs;

	/**
	 * @Description jagdrq的中文含义是： 归档日期
	 */
	@Column
	private String jagdrq;

	/**
	 * @Description jagddagl的中文含义是： 档案归类见aa10,aaa100=JAGDDAGL
	 */
	@Column
	private String jagddagl;

	/**
	 * @Description jagdbcqx的中文含义是： 保存期限
	 */
	@Column
	private String jagdbcqx;

	/**
	 * @Description jagdspyj的中文含义是： 领导审批意见
	 */
	@Column
	private String jagdspyj;

	/**
	 * @Description jagdfgfzrqz的中文含义是： 分管负责人签字
	 */
	@Column
	private String jagdfgfzrqz;

	/**
	 * @Description jagdfgfzrqzrq的中文含义是： 分管负责人签字日期
	 */
	@Column
	private String jagdfgfzrqzrq;

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
	 * @Description jabgbcfdwr的中文含义是： 被处罚单位（人）
	 */
	@Column
	private String jabgbcfdwr;

	/**
	 * @Description jabgfddbr的中文含义是： 法定代表人
	 */
	@Column
	private String jabgfddbr;

	/**
	 * @Description jabglarq的中文含义是： 立案日期
	 */
	@Column
	private String jabglarq;

	/**
	 * @Description jabgcfrq的中文含义是： 处罚日期
	 */
	@Column
	private String jabgcfrq;

	/**
	 * @Description jabgcfwsh的中文含义是： 处罚文书号
	 */
	@Column
	private String jabgcfwsh;

	/**
	 * @Description jabgcbr的中文含义是： 承办人
	 */
	@Column
	private String jabgcbr;

	/**
	 * @Description jabgaqjyqk的中文含义是： 案情简要情况
	 */
	@Column
	private String jabgaqjyqk;

	/**
	 * @Description jabgajcbrqz1的中文含义是： 案件承办人签字1
	 */
	@Column
	private String jabgajcbrqz1;

	/**
	 * @Description jabgajcbrqz2的中文含义是： 案件承办人签字2
	 */
	@Column
	private String jabgajcbrqz2;

	/**
	 * @Description jabgajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	@Column
	private String jabgajcbrqzrq;

	/**
	 * @Description jabgcbjgshyj的中文含义是： 承办机构审核意见
	 */
	@Column
	private String jabgcbjgshyj;

	/**
	 * @Description jabgcbjgfzrqz的中文含义是： 承办机构负责人签字
	 */
	@Column
	private String jabgcbjgfzrqz;

	/**
	 * @Description jabgcbjgfzrqzrq的中文含义是： 承办机构负责人签字日期
	 */
	@Column
	private String jabgcbjgfzrqzrq;

	
		/**
	 * @Description xzcfjabgid的中文含义是： 行政处罚结案报告ID
	 */
	public void setXzcfjabgid(String xzcfjabgid){ 
		this.xzcfjabgid = xzcfjabgid;
	}
	/**
	 * @Description xzcfjabgid的中文含义是： 行政处罚结案报告ID
	 */
	public String getXzcfjabgid(){
		return xzcfjabgid;
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
	 * @Description jabgjarq的中文含义是： 结案日期
	 */
	public void setJabgjarq(String jabgjarq){ 
		this.jabgjarq = jabgjarq;
	}
	/**
	 * @Description jabgjarq的中文含义是： 结案日期
	 */
	public String getJabgjarq(){
		return jabgjarq;
	}
	/**
	 * @Description jabgtxr的中文含义是： 填写人
	 */
	public void setJabgtxr(String jabgtxr){ 
		this.jabgtxr = jabgtxr;
	}
	/**
	 * @Description jabgtxr的中文含义是： 填写人
	 */
	public String getJabgtxr(){
		return jabgtxr;
	}
	/**
	 * @Description jabgcfzlhfd的中文含义是： 处罚种类和幅度
	 */
	public void setJabgcfzlhfd(String jabgcfzlhfd){ 
		this.jabgcfzlhfd = jabgcfzlhfd;
	}
	/**
	 * @Description jabgcfzlhfd的中文含义是： 处罚种类和幅度
	 */
	public String getJabgcfzlhfd(){
		return jabgcfzlhfd;
	}
	/**
	 * @Description jagdzxjg的中文含义是： 执行结果
	 */
	public void setJagdzxjg(String jagdzxjg){ 
		this.jagdzxjg = jagdzxjg;
	}
	/**
	 * @Description jagdzxjg的中文含义是： 执行结果
	 */
	public String getJagdzxjg(){
		return jagdzxjg;
	}
	/**
	 * @Description jagdjafs的中文含义是： 结案方式见aa10,aaa100=JAFS
	 */
	public void setJagdjafs(String jagdjafs){ 
		this.jagdjafs = jagdjafs;
	}
	/**
	 * @Description jagdjafs的中文含义是： 结案方式见aa10,aaa100=JAFS
	 */
	public String getJagdjafs(){
		return jagdjafs;
	}
	/**
	 * @Description jagdrq的中文含义是： 归档日期
	 */
	public void setJagdrq(String jagdrq){ 
		this.jagdrq = jagdrq;
	}
	/**
	 * @Description jagdrq的中文含义是： 归档日期
	 */
	public String getJagdrq(){
		return jagdrq;
	}
	/**
	 * @Description jagddagl的中文含义是： 档案归类见aa10,aaa100=JAGDDAGL
	 */
	public void setJagddagl(String jagddagl){ 
		this.jagddagl = jagddagl;
	}
	/**
	 * @Description jagddagl的中文含义是： 档案归类见aa10,aaa100=JAGDDAGL
	 */
	public String getJagddagl(){
		return jagddagl;
	}
	/**
	 * @Description jagdbcqx的中文含义是： 保存期限
	 */
	public void setJagdbcqx(String jagdbcqx){ 
		this.jagdbcqx = jagdbcqx;
	}
	/**
	 * @Description jagdbcqx的中文含义是： 保存期限
	 */
	public String getJagdbcqx(){
		return jagdbcqx;
	}
	/**
	 * @Description jagdspyj的中文含义是： 领导审批意见
	 */
	public void setJagdspyj(String jagdspyj){ 
		this.jagdspyj = jagdspyj;
	}
	/**
	 * @Description jagdspyj的中文含义是： 领导审批意见
	 */
	public String getJagdspyj(){
		return jagdspyj;
	}
	/**
	 * @Description jagdfgfzrqz的中文含义是： 分管负责人签字
	 */
	public void setJagdfgfzrqz(String jagdfgfzrqz){ 
		this.jagdfgfzrqz = jagdfgfzrqz;
	}
	/**
	 * @Description jagdfgfzrqz的中文含义是： 分管负责人签字
	 */
	public String getJagdfgfzrqz(){
		return jagdfgfzrqz;
	}
	/**
	 * @Description jagdfgfzrqzrq的中文含义是： 分管负责人签字日期
	 */
	public void setJagdfgfzrqzrq(String jagdfgfzrqzrq){ 
		this.jagdfgfzrqzrq = jagdfgfzrqzrq;
	}
	/**
	 * @Description jagdfgfzrqzrq的中文含义是： 分管负责人签字日期
	 */
	public String getJagdfgfzrqzrq(){
		return jagdfgfzrqzrq;
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
	/**
	 * @Description jabgbcfdwr的中文含义是： 被处罚单位（人）
	 */
	public void setJabgbcfdwr(String jabgbcfdwr){ 
		this.jabgbcfdwr = jabgbcfdwr;
	}
	/**
	 * @Description jabgbcfdwr的中文含义是： 被处罚单位（人）
	 */
	public String getJabgbcfdwr(){
		return jabgbcfdwr;
	}
	/**
	 * @Description jabgfddbr的中文含义是： 法定代表人
	 */
	public void setJabgfddbr(String jabgfddbr){ 
		this.jabgfddbr = jabgfddbr;
	}
	/**
	 * @Description jabgfddbr的中文含义是： 法定代表人
	 */
	public String getJabgfddbr(){
		return jabgfddbr;
	}
	/**
	 * @Description jabglarq的中文含义是： 立案日期
	 */
	public void setJabglarq(String jabglarq){ 
		this.jabglarq = jabglarq;
	}
	/**
	 * @Description jabglarq的中文含义是： 立案日期
	 */
	public String getJabglarq(){
		return jabglarq;
	}
	/**
	 * @Description jabgcfrq的中文含义是： 处罚日期
	 */
	public void setJabgcfrq(String jabgcfrq){ 
		this.jabgcfrq = jabgcfrq;
	}
	/**
	 * @Description jabgcfrq的中文含义是： 处罚日期
	 */
	public String getJabgcfrq(){
		return jabgcfrq;
	}
	/**
	 * @Description jabgcfwsh的中文含义是： 处罚文书号
	 */
	public void setJabgcfwsh(String jabgcfwsh){ 
		this.jabgcfwsh = jabgcfwsh;
	}
	/**
	 * @Description jabgcfwsh的中文含义是： 处罚文书号
	 */
	public String getJabgcfwsh(){
		return jabgcfwsh;
	}
	/**
	 * @Description jabgcbr的中文含义是： 承办人
	 */
	public void setJabgcbr(String jabgcbr){ 
		this.jabgcbr = jabgcbr;
	}
	/**
	 * @Description jabgcbr的中文含义是： 承办人
	 */
	public String getJabgcbr(){
		return jabgcbr;
	}
	/**
	 * @Description jabgaqjyqk的中文含义是： 案情简要情况
	 */
	public void setJabgaqjyqk(String jabgaqjyqk){ 
		this.jabgaqjyqk = jabgaqjyqk;
	}
	/**
	 * @Description jabgaqjyqk的中文含义是： 案情简要情况
	 */
	public String getJabgaqjyqk(){
		return jabgaqjyqk;
	}
	/**
	 * @Description jabgajcbrqz1的中文含义是： 案件承办人签字1
	 */
	public void setJabgajcbrqz1(String jabgajcbrqz1){ 
		this.jabgajcbrqz1 = jabgajcbrqz1;
	}
	/**
	 * @Description jabgajcbrqz1的中文含义是： 案件承办人签字1
	 */
	public String getJabgajcbrqz1(){
		return jabgajcbrqz1;
	}
	/**
	 * @Description jabgajcbrqz2的中文含义是： 案件承办人签字2
	 */
	public void setJabgajcbrqz2(String jabgajcbrqz2){ 
		this.jabgajcbrqz2 = jabgajcbrqz2;
	}
	/**
	 * @Description jabgajcbrqz2的中文含义是： 案件承办人签字2
	 */
	public String getJabgajcbrqz2(){
		return jabgajcbrqz2;
	}
	/**
	 * @Description jabgajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	public void setJabgajcbrqzrq(String jabgajcbrqzrq){ 
		this.jabgajcbrqzrq = jabgajcbrqzrq;
	}
	/**
	 * @Description jabgajcbrqzrq的中文含义是： 案件承办人签字日期
	 */
	public String getJabgajcbrqzrq(){
		return jabgajcbrqzrq;
	}
	/**
	 * @Description jabgcbjgshyj的中文含义是： 承办机构审核意见
	 */
	public void setJabgcbjgshyj(String jabgcbjgshyj){ 
		this.jabgcbjgshyj = jabgcbjgshyj;
	}
	/**
	 * @Description jabgcbjgshyj的中文含义是： 承办机构审核意见
	 */
	public String getJabgcbjgshyj(){
		return jabgcbjgshyj;
	}
	/**
	 * @Description jabgcbjgfzrqz的中文含义是： 承办机构负责人签字
	 */
	public void setJabgcbjgfzrqz(String jabgcbjgfzrqz){ 
		this.jabgcbjgfzrqz = jabgcbjgfzrqz;
	}
	/**
	 * @Description jabgcbjgfzrqz的中文含义是： 承办机构负责人签字
	 */
	public String getJabgcbjgfzrqz(){
		return jabgcbjgfzrqz;
	}
	/**
	 * @Description jabgcbjgfzrqzrq的中文含义是： 承办机构负责人签字日期
	 */
	public void setJabgcbjgfzrqzrq(String jabgcbjgfzrqzrq){ 
		this.jabgcbjgfzrqzrq = jabgcbjgfzrqzrq;
	}
	/**
	 * @Description jabgcbjgfzrqzrq的中文含义是： 承办机构负责人签字日期
	 */
	public String getJabgcbjgfzrqzrq(){
		return jabgcbjgfzrqzrq;
	}

	
}