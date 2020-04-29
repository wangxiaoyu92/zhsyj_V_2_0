package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  W_SYSORC 的中文含义是 业务流程控制
 * @Creation     2014/10/24 18:02:16
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "Syscheck")
public class Syscheck {
	/**
	 * @Description aaa121的中文含义是： 业务类型编码
	 */
	@Column
	private String aaa121;

	/**
	 * @Description aaz002的中文含义是： 业务日志ID
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_aaz002')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_aaz002.nextval from dual"))
	private String aaz002;

	/**
	 * @Description digest的中文含义是： 数据摘要
	 */
	@Column
	private String digest;

	/**
	 * @Description aae013的中文含义是： 经办备注
	 */
	@Column
	private String aae013;

	/**
	 * @Description cae088的中文含义是： 经办人ID
	 */
	@Column
	private String cae088;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description cae082的中文含义是： 经办开始时间
	 */
	@Column
	private Timestamp cae082;

	/**
	 * @Description cae083的中文含义是： 经办结束时间
	 */
	@Column
	private Timestamp cae083;

	/**
	 * @Description cae101的中文含义是： 经办所属期
	 */
	@Column
	private Integer cae101;

	/**
	 * @Description aae089的中文含义是： 审核人ID
	 */
	@Column
	private String aae089;

	/**
	 * @Description aae014的中文含义是： 审核人
	 */
	@Column
	private String aae014;

	/**
	 * @Description cae084的中文含义是： 审核开始时间
	 */
	@Column
	private Timestamp cae084;

	/**
	 * @Description cae085的中文含义是： 审核结束时间
	 */
	@Column
	private Timestamp cae085;

	/**
	 * @Description cae080的中文含义是： 审核意见
	 */
	@Column
	private String cae080;

	/**
	 * @Description cae094的中文含义是： 审核所属期
	 */
	@Column
	private Integer cae094;

	/**
	 * @Description cae092的中文含义是： 业务状态（待审核、正在审核、已审核、审核未通过）
	 */
	@Column
	private String cae092;

	/**
	 * @Description cae103的中文含义是： 复核人ID
	 */
	@Column
	private String cae103;

	/**
	 * @Description cae104的中文含义是： 复核人
	 */
	@Column
	private String cae104;

	/**
	 * @Description cae105的中文含义是： 复核开始时间
	 */
	@Column
	private Timestamp cae105;

	/**
	 * @Description cae106的中文含义是： 复核结束时间
	 */
	@Column
	private Timestamp cae106;

	/**
	 * @Description cae107的中文含义是： 复核意见
	 */
	@Column
	private String cae107;

	/**
	 * @Description cae108的中文含义是： 复核所属期
	 */
	@Column
	private Integer cae108;

	/**
	 * @Description cae109的中文含义是： 业务状态（待复核、正在复核、已复核、复核未通过）
	 */
	@Column
	private String cae109;

	/**
	 * @Description cae095的中文含义是： 回退人ID
	 */
	@Column
	private String cae095;

	/**
	 * @Description cae096的中文含义是： 回退人
	 */
	@Column
	private String cae096;

	/**
	 * @Description cae097的中文含义是： 回退原因
	 */
	@Column
	private String cae097;

	/**
	 * @Description cae098的中文含义是： 回退时间
	 */
	@Column
	private Timestamp cae098;

	/**
	 * @Description cae099的中文含义是： 回退所属期
	 */
	@Column
	private Integer cae099;

	/**
	 * @Description cae090的中文含义是： 稽核人ID
	 */
	@Column
	private String cae090;

	/**
	 * @Description aae012的中文含义是： 稽核人
	 */
	@Column
	private String aae012;

	/**
	 * @Description cae086的中文含义是： 稽核开始时间
	 */
	@Column
	private Timestamp cae086;

	/**
	 * @Description cae087的中文含义是： 稽核结束时间
	 */
	@Column
	private Timestamp cae087;

	/**
	 * @Description cae093的中文含义是： 稽核状态（待稽核、正在稽核、已稽核、稽核未通过）
	 */
	@Column
	private String cae093;

	/**
	 * @Description cae081的中文含义是： 稽核意见
	 */
	@Column
	private String cae081;

	/**
	 * @Description cae100的中文含义是： 稽核所属期
	 */
	@Column
	private Integer cae100;

	/**
	 * @Description aaz010的中文含义是： 当事人ID
	 */
	@Column
	private String aaz010;

	/**
	 * @Description aaa028的中文含义是： 当事人类别
	 */
	@Column
	private String aaa028;

	/**
	 * @Description cae102的中文含义是： 业务受理结果
	 */
	@Column
	private String cae102;

	/**
	 * @Description cae110的中文含义是： 关键业务标识（1、一般业务2、关键业务）
	 */
	@Column
	private String cae110;

	/**
	 * @Description aae318的中文含义是： 回退标志
	 */
	@Column
	private String aae318;

	
		/**
	 * @Description aaa121的中文含义是： 业务类型编码
	 */
	public void setAaa121(String aaa121){ 
		this.aaa121 = aaa121;
	}
	/**
	 * @Description aaa121的中文含义是： 业务类型编码
	 */
	public String getAaa121(){
		return aaa121;
	}
	/**
	 * @Description aaz002的中文含义是： 业务日志ID
	 */
	public void setAaz002(String aaz002){ 
		this.aaz002 = aaz002;
	}
	/**
	 * @Description aaz002的中文含义是： 业务日志ID
	 */
	public String getAaz002(){
		return aaz002;
	}
	/**
	 * @Description digest的中文含义是： 数据摘要
	 */
	public void setDigest(String digest){ 
		this.digest = digest;
	}
	/**
	 * @Description digest的中文含义是： 数据摘要
	 */
	public String getDigest(){
		return digest;
	}
	/**
	 * @Description aae013的中文含义是： 经办备注
	 */
	public void setAae013(String aae013){ 
		this.aae013 = aae013;
	}
	/**
	 * @Description aae013的中文含义是： 经办备注
	 */
	public String getAae013(){
		return aae013;
	}
	/**
	 * @Description cae088的中文含义是： 经办人ID
	 */
	public void setCae088(String cae088){ 
		this.cae088 = cae088;
	}
	/**
	 * @Description cae088的中文含义是： 经办人ID
	 */
	public String getCae088(){
		return cae088;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description cae082的中文含义是： 经办开始时间
	 */
	public void setCae082(Timestamp cae082){ 
		this.cae082 = cae082;
	}
	/**
	 * @Description cae082的中文含义是： 经办开始时间
	 */
	public Timestamp getCae082(){
		return cae082;
	}
	/**
	 * @Description cae083的中文含义是： 经办结束时间
	 */
	public void setCae083(Timestamp cae083){ 
		this.cae083 = cae083;
	}
	/**
	 * @Description cae083的中文含义是： 经办结束时间
	 */
	public Timestamp getCae083(){
		return cae083;
	}
	/**
	 * @Description cae101的中文含义是： 经办所属期
	 */
	public void setCae101(Integer cae101){ 
		this.cae101 = cae101;
	}
	/**
	 * @Description cae101的中文含义是： 经办所属期
	 */
	public Integer getCae101(){
		return cae101;
	}
	/**
	 * @Description aae089的中文含义是： 审核人ID
	 */
	public void setAae089(String aae089){ 
		this.aae089 = aae089;
	}
	/**
	 * @Description aae089的中文含义是： 审核人ID
	 */
	public String getAae089(){
		return aae089;
	}
	/**
	 * @Description aae014的中文含义是： 审核人
	 */
	public void setAae014(String aae014){ 
		this.aae014 = aae014;
	}
	/**
	 * @Description aae014的中文含义是： 审核人
	 */
	public String getAae014(){
		return aae014;
	}
	/**
	 * @Description cae084的中文含义是： 审核开始时间
	 */
	public void setCae084(Timestamp cae084){ 
		this.cae084 = cae084;
	}
	/**
	 * @Description cae084的中文含义是： 审核开始时间
	 */
	public Timestamp getCae084(){
		return cae084;
	}
	/**
	 * @Description cae085的中文含义是： 审核结束时间
	 */
	public void setCae085(Timestamp cae085){ 
		this.cae085 = cae085;
	}
	/**
	 * @Description cae085的中文含义是： 审核结束时间
	 */
	public Timestamp getCae085(){
		return cae085;
	}
	/**
	 * @Description cae080的中文含义是： 审核意见
	 */
	public void setCae080(String cae080){ 
		this.cae080 = cae080;
	}
	/**
	 * @Description cae080的中文含义是： 审核意见
	 */
	public String getCae080(){
		return cae080;
	}
	/**
	 * @Description cae094的中文含义是： 审核所属期
	 */
	public void setCae094(Integer cae094){ 
		this.cae094 = cae094;
	}
	/**
	 * @Description cae094的中文含义是： 审核所属期
	 */
	public Integer getCae094(){
		return cae094;
	}
	/**
	 * @Description cae092的中文含义是： 业务状态（待审核、正在审核、已审核、审核未通过）
	 */
	public void setCae092(String cae092){ 
		this.cae092 = cae092;
	}
	/**
	 * @Description cae092的中文含义是： 业务状态（待审核、正在审核、已审核、审核未通过）
	 */
	public String getCae092(){
		return cae092;
	}
	/**
	 * @Description cae103的中文含义是： 复核人ID
	 */
	public void setCae103(String cae103){ 
		this.cae103 = cae103;
	}
	/**
	 * @Description cae103的中文含义是： 复核人ID
	 */
	public String getCae103(){
		return cae103;
	}
	/**
	 * @Description cae104的中文含义是： 复核人
	 */
	public void setCae104(String cae104){ 
		this.cae104 = cae104;
	}
	/**
	 * @Description cae104的中文含义是： 复核人
	 */
	public String getCae104(){
		return cae104;
	}
	/**
	 * @Description cae105的中文含义是： 复核开始时间
	 */
	public void setCae105(Timestamp cae105){ 
		this.cae105 = cae105;
	}
	/**
	 * @Description cae105的中文含义是： 复核开始时间
	 */
	public Timestamp getCae105(){
		return cae105;
	}
	/**
	 * @Description cae106的中文含义是： 复核结束时间
	 */
	public void setCae106(Timestamp cae106){ 
		this.cae106 = cae106;
	}
	/**
	 * @Description cae106的中文含义是： 复核结束时间
	 */
	public Timestamp getCae106(){
		return cae106;
	}
	/**
	 * @Description cae107的中文含义是： 复核意见
	 */
	public void setCae107(String cae107){ 
		this.cae107 = cae107;
	}
	/**
	 * @Description cae107的中文含义是： 复核意见
	 */
	public String getCae107(){
		return cae107;
	}
	/**
	 * @Description cae108的中文含义是： 复核所属期
	 */
	public void setCae108(Integer cae108){ 
		this.cae108 = cae108;
	}
	/**
	 * @Description cae108的中文含义是： 复核所属期
	 */
	public Integer getCae108(){
		return cae108;
	}
	/**
	 * @Description cae109的中文含义是： 业务状态（待复核、正在复核、已复核、复核未通过）
	 */
	public void setCae109(String cae109){ 
		this.cae109 = cae109;
	}
	/**
	 * @Description cae109的中文含义是： 业务状态（待复核、正在复核、已复核、复核未通过）
	 */
	public String getCae109(){
		return cae109;
	}
	/**
	 * @Description cae095的中文含义是： 回退人ID
	 */
	public void setCae095(String cae095){ 
		this.cae095 = cae095;
	}
	/**
	 * @Description cae095的中文含义是： 回退人ID
	 */
	public String getCae095(){
		return cae095;
	}
	/**
	 * @Description cae096的中文含义是： 回退人
	 */
	public void setCae096(String cae096){ 
		this.cae096 = cae096;
	}
	/**
	 * @Description cae096的中文含义是： 回退人
	 */
	public String getCae096(){
		return cae096;
	}
	/**
	 * @Description cae097的中文含义是： 回退原因
	 */
	public void setCae097(String cae097){ 
		this.cae097 = cae097;
	}
	/**
	 * @Description cae097的中文含义是： 回退原因
	 */
	public String getCae097(){
		return cae097;
	}
	/**
	 * @Description cae098的中文含义是： 回退时间
	 */
	public void setCae098(Timestamp cae098){ 
		this.cae098 = cae098;
	}
	/**
	 * @Description cae098的中文含义是： 回退时间
	 */
	public Timestamp getCae098(){
		return cae098;
	}
	/**
	 * @Description cae099的中文含义是： 回退所属期
	 */
	public void setCae099(Integer cae099){ 
		this.cae099 = cae099;
	}
	/**
	 * @Description cae099的中文含义是： 回退所属期
	 */
	public Integer getCae099(){
		return cae099;
	}
	/**
	 * @Description cae090的中文含义是： 稽核人ID
	 */
	public void setCae090(String cae090){ 
		this.cae090 = cae090;
	}
	/**
	 * @Description cae090的中文含义是： 稽核人ID
	 */
	public String getCae090(){
		return cae090;
	}
	/**
	 * @Description aae012的中文含义是： 稽核人
	 */
	public void setAae012(String aae012){ 
		this.aae012 = aae012;
	}
	/**
	 * @Description aae012的中文含义是： 稽核人
	 */
	public String getAae012(){
		return aae012;
	}
	/**
	 * @Description cae086的中文含义是： 稽核开始时间
	 */
	public void setCae086(Timestamp cae086){ 
		this.cae086 = cae086;
	}
	/**
	 * @Description cae086的中文含义是： 稽核开始时间
	 */
	public Timestamp getCae086(){
		return cae086;
	}
	/**
	 * @Description cae087的中文含义是： 稽核结束时间
	 */
	public void setCae087(Timestamp cae087){ 
		this.cae087 = cae087;
	}
	/**
	 * @Description cae087的中文含义是： 稽核结束时间
	 */
	public Timestamp getCae087(){
		return cae087;
	}
	/**
	 * @Description cae093的中文含义是： 稽核状态（待稽核、正在稽核、已稽核、稽核未通过）
	 */
	public void setCae093(String cae093){ 
		this.cae093 = cae093;
	}
	/**
	 * @Description cae093的中文含义是： 稽核状态（待稽核、正在稽核、已稽核、稽核未通过）
	 */
	public String getCae093(){
		return cae093;
	}
	/**
	 * @Description cae081的中文含义是： 稽核意见
	 */
	public void setCae081(String cae081){ 
		this.cae081 = cae081;
	}
	/**
	 * @Description cae081的中文含义是： 稽核意见
	 */
	public String getCae081(){
		return cae081;
	}
	/**
	 * @Description cae100的中文含义是： 稽核所属期
	 */
	public void setCae100(Integer cae100){ 
		this.cae100 = cae100;
	}
	/**
	 * @Description cae100的中文含义是： 稽核所属期
	 */
	public Integer getCae100(){
		return cae100;
	}
	/**
	 * @Description aaz010的中文含义是： 当事人ID
	 */
	public void setAaz010(String aaz010){ 
		this.aaz010 = aaz010;
	}
	/**
	 * @Description aaz010的中文含义是： 当事人ID
	 */
	public String getAaz010(){
		return aaz010;
	}
	/**
	 * @Description aaa028的中文含义是： 当事人类别
	 */
	public void setAaa028(String aaa028){ 
		this.aaa028 = aaa028;
	}
	/**
	 * @Description aaa028的中文含义是： 当事人类别
	 */
	public String getAaa028(){
		return aaa028;
	}
	/**
	 * @Description cae102的中文含义是： 业务受理结果
	 */
	public void setCae102(String cae102){ 
		this.cae102 = cae102;
	}
	/**
	 * @Description cae102的中文含义是： 业务受理结果
	 */
	public String getCae102(){
		return cae102;
	}
	/**
	 * @Description cae110的中文含义是： 关键业务标识（1、一般业务2、关键业务）
	 */
	public void setCae110(String cae110){ 
		this.cae110 = cae110;
	}
	/**
	 * @Description cae110的中文含义是： 关键业务标识（1、一般业务2、关键业务）
	 */
	public String getCae110(){
		return cae110;
	}
	/**
	 * @Description aae318的中文含义是： 回退标志
	 */
	public void setAae318(String aae318){ 
		this.aae318 = aae318;
	}
	/**
	 * @Description aae318的中文含义是： 回退标志
	 */
	public String getAae318(){
		return aae318;
	}

	
}