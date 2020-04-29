package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSAJLYDJB的中文含义是: 执法文书案件来源登记表; InnoDB free: 2721792 kB
 * @Creation     2016/06/17 17:08:30
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSAJLYDJB")
public class Zfwsajlydjb {
	/**
	 * @Description zfwslydjid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_zfwslydjid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_zfwslydjid.nextval from dual"))
	private String zfwslydjid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description ajlyfzr的中文含义是： 负责人
	 */
	@Column
	private String ajlyfzr;

	/**
	 * @Description ajlyfzrqzsj的中文含义是： 负责人签字时间
	 */
	@Column
	private String ajlyfzrqzsj;

	/**
	 * @Description ajlywsbh的中文含义是： 文书编号
	 */
	@Column
	private String ajlywsbh;

	/**
	 * @Description ajdjajly的中文含义是： 案件来源
	 */
	@Column
	private String ajdjajly;

	/**
	 * @Description ajlydsr的中文含义是： 当事人
	 */
	@Column
	private String ajlydsr;

	/**
	 * @Description ajlydz的中文含义是： 地址
	 */
	@Column
	private String ajlydz;

	/**
	 * @Description ajlyyb的中文含义是： 邮编
	 */
	@Column
	private String ajlyyb;

	/**
	 * @Description ajlyfddbr的中文含义是： 法定代表人（负责人）自然人
	 */
	@Column
	private String ajlyfddbr;

	/**
	 * @Description ajlylxdh的中文含义是： 联系电话
	 */
	@Column
	private String ajlylxdh;

	/**
	 * @Description ajlyfddbrsfzh的中文含义是： 法定代表人（负责人）自然人身份证号码
	 */
	@Column
	private String ajlyfddbrsfzh;

	/**
	 * @Description ajlydjsj的中文含义是： 登记时间
	 */
	@Column
	private String ajlydjsj;

	/**
	 * @Description ajlyjbqkjs的中文含义是： 基本情况介绍
	 */
	@Column
	private String ajlyjbqkjs;

	/**
	 * @Description ajlyfj的中文含义是： 附件
	 */
	@Column
	private String ajlyfj;

	/**
	 * @Description ajlyjlrqz的中文含义是： 记录人签字
	 */
	@Column
	private String ajlyjlrqz;

	/**
	 * @Description ajlyjlrqzrq的中文含义是： 记录人签字日期
	 */
	@Column
	private String ajlyjlrqzrq;

	/**
	 * @Description ajlyclyj的中文含义是： 处理意见
	 */
	@Column
	private String ajlyclyj;

	
		/**
	 * @Description zfwslydjid的中文含义是： 
	 */
	public void setZfwslydjid(String zfwslydjid){ 
		this.zfwslydjid = zfwslydjid;
	}
	/**
	 * @Description zfwslydjid的中文含义是： 
	 */
	public String getZfwslydjid(){
		return zfwslydjid;
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
	 * @Description ajlyfzr的中文含义是： 负责人
	 */
	public void setAjlyfzr(String ajlyfzr){ 
		this.ajlyfzr = ajlyfzr;
	}
	/**
	 * @Description ajlyfzr的中文含义是： 负责人
	 */
	public String getAjlyfzr(){
		return ajlyfzr;
	}
	/**
	 * @Description ajlyfzrqzsj的中文含义是： 负责人签字时间
	 */
	public void setAjlyfzrqzsj(String ajlyfzrqzsj){ 
		this.ajlyfzrqzsj = ajlyfzrqzsj;
	}
	/**
	 * @Description ajlyfzrqzsj的中文含义是： 负责人签字时间
	 */
	public String getAjlyfzrqzsj(){
		return ajlyfzrqzsj;
	}
	/**
	 * @Description ajlywsbh的中文含义是： 文书编号
	 */
	public void setAjlywsbh(String ajlywsbh){ 
		this.ajlywsbh = ajlywsbh;
	}
	/**
	 * @Description ajlywsbh的中文含义是： 文书编号
	 */
	public String getAjlywsbh(){
		return ajlywsbh;
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
	 * @Description ajlydsr的中文含义是： 当事人
	 */
	public void setAjlydsr(String ajlydsr){ 
		this.ajlydsr = ajlydsr;
	}
	/**
	 * @Description ajlydsr的中文含义是： 当事人
	 */
	public String getAjlydsr(){
		return ajlydsr;
	}
	/**
	 * @Description ajlydz的中文含义是： 地址
	 */
	public void setAjlydz(String ajlydz){ 
		this.ajlydz = ajlydz;
	}
	/**
	 * @Description ajlydz的中文含义是： 地址
	 */
	public String getAjlydz(){
		return ajlydz;
	}
	/**
	 * @Description ajlyyb的中文含义是： 邮编
	 */
	public void setAjlyyb(String ajlyyb){ 
		this.ajlyyb = ajlyyb;
	}
	/**
	 * @Description ajlyyb的中文含义是： 邮编
	 */
	public String getAjlyyb(){
		return ajlyyb;
	}
	/**
	 * @Description ajlyfddbr的中文含义是： 法定代表人（负责人）自然人
	 */
	public void setAjlyfddbr(String ajlyfddbr){ 
		this.ajlyfddbr = ajlyfddbr;
	}
	/**
	 * @Description ajlyfddbr的中文含义是： 法定代表人（负责人）自然人
	 */
	public String getAjlyfddbr(){
		return ajlyfddbr;
	}
	/**
	 * @Description ajlylxdh的中文含义是： 联系电话
	 */
	public void setAjlylxdh(String ajlylxdh){ 
		this.ajlylxdh = ajlylxdh;
	}
	/**
	 * @Description ajlylxdh的中文含义是： 联系电话
	 */
	public String getAjlylxdh(){
		return ajlylxdh;
	}
	/**
	 * @Description ajlyfddbrsfzh的中文含义是： 法定代表人（负责人）自然人身份证号码
	 */
	public void setAjlyfddbrsfzh(String ajlyfddbrsfzh){ 
		this.ajlyfddbrsfzh = ajlyfddbrsfzh;
	}
	/**
	 * @Description ajlyfddbrsfzh的中文含义是： 法定代表人（负责人）自然人身份证号码
	 */
	public String getAjlyfddbrsfzh(){
		return ajlyfddbrsfzh;
	}
	/**
	 * @Description ajlydjsj的中文含义是： 登记时间
	 */
	public void setAjlydjsj(String ajlydjsj){ 
		this.ajlydjsj = ajlydjsj;
	}
	/**
	 * @Description ajlydjsj的中文含义是： 登记时间
	 */
	public String getAjlydjsj(){
		return ajlydjsj;
	}
	/**
	 * @Description ajlyjbqkjs的中文含义是： 基本情况介绍
	 */
	public void setAjlyjbqkjs(String ajlyjbqkjs){ 
		this.ajlyjbqkjs = ajlyjbqkjs;
	}
	/**
	 * @Description ajlyjbqkjs的中文含义是： 基本情况介绍
	 */
	public String getAjlyjbqkjs(){
		return ajlyjbqkjs;
	}
	/**
	 * @Description ajlyfj的中文含义是： 附件
	 */
	public void setAjlyfj(String ajlyfj){ 
		this.ajlyfj = ajlyfj;
	}
	/**
	 * @Description ajlyfj的中文含义是： 附件
	 */
	public String getAjlyfj(){
		return ajlyfj;
	}
	/**
	 * @Description ajlyjlrqz的中文含义是： 记录人签字
	 */
	public void setAjlyjlrqz(String ajlyjlrqz){ 
		this.ajlyjlrqz = ajlyjlrqz;
	}
	/**
	 * @Description ajlyjlrqz的中文含义是： 记录人签字
	 */
	public String getAjlyjlrqz(){
		return ajlyjlrqz;
	}
	/**
	 * @Description ajlyjlrqzrq的中文含义是： 记录人签字日期
	 */
	public void setAjlyjlrqzrq(String ajlyjlrqzrq){ 
		this.ajlyjlrqzrq = ajlyjlrqzrq;
	}
	/**
	 * @Description ajlyjlrqzrq的中文含义是： 记录人签字日期
	 */
	public String getAjlyjlrqzrq(){
		return ajlyjlrqzrq;
	}
	/**
	 * @Description ajlyclyj的中文含义是： 处理意见
	 */
	public void setAjlyclyj(String ajlyclyj){ 
		this.ajlyclyj = ajlyclyj;
	}
	/**
	 * @Description ajlyclyj的中文含义是： 处理意见
	 */
	public String getAjlyclyj(){
		return ajlyclyj;
	}

	
}