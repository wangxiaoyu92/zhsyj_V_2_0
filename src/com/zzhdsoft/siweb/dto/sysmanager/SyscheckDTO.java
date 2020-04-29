package com.zzhdsoft.siweb.dto.sysmanager;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * 
 * SyscheckDTO的中文名称：通用业务审核DTO
 *
 * SyscheckDTO的描述：
 *
 * @author ：zjf 
 * @version ：V1.0
 */
public class SyscheckDTO
{

	/**
	 * @Description aaa121的中文含义是 业务类型编码
	 */
	private String aaa121;

	/**
	 * @Description aaz002的中文含义是 业务日志ID
	 */
	private String aaz002;

	/**
	 * @Description digest的中文含义是 数据摘要
	 */
	private String digest;

	/**
	 * @Description aae013的中文含义是 经办备注
	 */
	private String aae013;

	/**
	 * @Description cae088的中文含义是 经办人ID
	 */
	private String cae088;

	/**
	 * @Description aae011的中文含义是 经办人
	 */
	private String aae011;

	/**
	 * @Description cae082的中文含义是 经办开始时间
	 */
	private Timestamp cae082;

	/**
	 * @Description cae083的中文含义是 经办结束时间
	 */
	private Timestamp cae083;

	/**
	 * @Description cae101的中文含义是 经办所属期
	 */
	private Integer cae101;

	/**
	 * @Description aae089的中文含义是 审核人ID
	 */
	private String aae089;

	/**
	 * @Description aae014的中文含义是 审核人
	 */
	private String aae014;

	/**
	 * @Description cae084的中文含义是 审核开始时间
	 */
	private Timestamp cae084;

	/**
	 * @Description cae085的中文含义是 审核结束时间
	 */
	private Timestamp cae085;

	/**
	 * @Description cae080的中文含义是 审核意见
	 */
	private String cae080;

	/**
	 * @Description cae094的中文含义是 审核所属期
	 */
	private Integer cae094;

	/**
	 * @Description cae092的中文含义是 业务状态（待审核、正在审核、已审核、审核未通过）
	 */
	private String cae092;

	/**
	 * @Description cae103的中文含义是 复核人ID
	 */
	private String cae103;

	/**
	 * @Description cae104的中文含义是 复核人
	 */
	private String cae104;

	/**
	 * @Description cae105的中文含义是 复核开始时间
	 */
	private Timestamp cae105;

	/**
	 * @Description cae106的中文含义是 复核结束时间
	 */
	private Timestamp cae106;

	/**
	 * @Description cae107的中文含义是 复核意见
	 */
	private String cae107;

	/**
	 * @Description cae108的中文含义是 复核所属期
	 */
	private Integer cae108;

	/**
	 * @Description cae109的中文含义是 业务状态（待复核、正在复核、已复核、复核未通过）
	 */
	private String cae109;

	/**
	 * @Description cae095的中文含义是 回退人ID
	 */
	private String cae095;

	/**
	 * @Description cae096的中文含义是 回退人
	 */
	private String cae096;

	/**
	 * @Description cae097的中文含义是 回退原因
	 */
	private String cae097;

	/**
	 * @Description cae098的中文含义是 回退时间
	 */
	private Timestamp cae098;

	/**
	 * @Description cae099的中文含义是 回退所属期
	 */
	private Integer cae099;

	/**
	 * @Description cae090的中文含义是 稽核人ID
	 */
	private String cae090;

	/**
	 * @Description aae012的中文含义是 稽核人
	 */
	private String aae012;

	/**
	 * @Description cae086的中文含义是 稽核开始时间
	 */
	private Timestamp cae086;

	/**
	 * @Description cae087的中文含义是 稽核结束时间
	 */
	private Timestamp cae087;

	/**
	 * @Description cae093的中文含义是 稽核状态（待稽核、正在稽核、已稽核、稽核未通过）
	 */
	private String cae093;

	/**
	 * @Description cae081的中文含义是 稽核意见
	 */
	private String cae081;

	/**
	 * @Description cae100的中文含义是 稽核所属期
	 */
	private Integer cae100;

	/**
	 * @Description aaz010的中文含义是 当事人ID
	 */
	private String aaz010;

	/**
	 * @Description aaa028的中文含义是 当事人类别
	 */
	private String aaa028;

	/**
	 * @Description cae102的中文含义是 业务受理结果
	 */
	private String cae102;

	/**
	 * @Description cae110的中文含义是 关键业务标识（1、一般业务2、关键业务）
	 */
	private String cae110;

	/**
	 * @Description aae318的中文含义是 回退标志
	 */
	private String aae318;

		
	private String aaa121Name;
	private String aaz001;
	private Integer aae002;
	private Timestamp aae036;
	public String getAaa121() {
		return aaa121;
	}
	public void setAaa121(String aaa121) {
		this.aaa121 = aaa121;
	}
	public String getAaz002() {
		return aaz002;
	}
	public void setAaz002(String aaz002) {
		this.aaz002 = aaz002;
	}
	public String getDigest() {
		return digest;
	}
	public void setDigest(String digest) {
		this.digest = digest;
	}
	public String getAae013() {
		return aae013;
	}
	public void setAae013(String aae013) {
		this.aae013 = aae013;
	}
	public String getCae088() {
		return cae088;
	}
	public void setCae088(String cae088) {
		this.cae088 = cae088;
	}
	public String getAae011() {
		return aae011;
	}
	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}
	public Timestamp getCae082() {
		return cae082;
	}
	public void setCae082(Timestamp cae082) {
		this.cae082 = cae082;
	}
	public Timestamp getCae083() {
		return cae083;
	}
	public void setCae083(Timestamp cae083) {
		this.cae083 = cae083;
	}
	public Integer getCae101() {
		return cae101;
	}
	public void setCae101(Integer cae101) {
		this.cae101 = cae101;
	}
	public String getAae089() {
		return aae089;
	}
	public void setAae089(String aae089) {
		this.aae089 = aae089;
	}
	public String getAae014() {
		return aae014;
	}
	public void setAae014(String aae014) {
		this.aae014 = aae014;
	}
	public Timestamp getCae084() {
		return cae084;
	}
	public void setCae084(Timestamp cae084) {
		this.cae084 = cae084;
	}
	public Timestamp getCae085() {
		return cae085;
	}
	public void setCae085(Timestamp cae085) {
		this.cae085 = cae085;
	}
	public String getCae080() {
		return cae080;
	}
	public void setCae080(String cae080) {
		this.cae080 = cae080;
	}
	public Integer getCae094() {
		return cae094;
	}
	public void setCae094(Integer cae094) {
		this.cae094 = cae094;
	}
	public String getCae092() {
		return cae092;
	}
	public void setCae092(String cae092) {
		this.cae092 = cae092;
	}
	public String getCae103() {
		return cae103;
	}
	public void setCae103(String cae103) {
		this.cae103 = cae103;
	}
	public String getCae104() {
		return cae104;
	}
	public void setCae104(String cae104) {
		this.cae104 = cae104;
	}
	public Timestamp getCae105() {
		return cae105;
	}
	public void setCae105(Timestamp cae105) {
		this.cae105 = cae105;
	}
	public Timestamp getCae106() {
		return cae106;
	}
	public void setCae106(Timestamp cae106) {
		this.cae106 = cae106;
	}
	public String getCae107() {
		return cae107;
	}
	public void setCae107(String cae107) {
		this.cae107 = cae107;
	}
	public Integer getCae108() {
		return cae108;
	}
	public void setCae108(Integer cae108) {
		this.cae108 = cae108;
	}
	public String getCae109() {
		return cae109;
	}
	public void setCae109(String cae109) {
		this.cae109 = cae109;
	}
	public String getCae095() {
		return cae095;
	}
	public void setCae095(String cae095) {
		this.cae095 = cae095;
	}
	public String getCae096() {
		return cae096;
	}
	public void setCae096(String cae096) {
		this.cae096 = cae096;
	}
	public String getCae097() {
		return cae097;
	}
	public void setCae097(String cae097) {
		this.cae097 = cae097;
	}
	public Timestamp getCae098() {
		return cae098;
	}
	public void setCae098(Timestamp cae098) {
		this.cae098 = cae098;
	}
	public Integer getCae099() {
		return cae099;
	}
	public void setCae099(Integer cae099) {
		this.cae099 = cae099;
	}
	public String getCae090() {
		return cae090;
	}
	public void setCae090(String cae090) {
		this.cae090 = cae090;
	}
	public String getAae012() {
		return aae012;
	}
	public void setAae012(String aae012) {
		this.aae012 = aae012;
	}
	public Timestamp getCae086() {
		return cae086;
	}
	public void setCae086(Timestamp cae086) {
		this.cae086 = cae086;
	}
	public Timestamp getCae087() {
		return cae087;
	}
	public void setCae087(Timestamp cae087) {
		this.cae087 = cae087;
	}
	public String getCae093() {
		return cae093;
	}
	public void setCae093(String cae093) {
		this.cae093 = cae093;
	}
	public String getCae081() {
		return cae081;
	}
	public void setCae081(String cae081) {
		this.cae081 = cae081;
	}
	public Integer getCae100() {
		return cae100;
	}
	public void setCae100(Integer cae100) {
		this.cae100 = cae100;
	}
	public String getAaz010() {
		return aaz010;
	}
	public void setAaz010(String aaz010) {
		this.aaz010 = aaz010;
	}
	public String getAaa028() {
		return aaa028;
	}
	public void setAaa028(String aaa028) {
		this.aaa028 = aaa028;
	}
	public String getCae102() {
		return cae102;
	}
	public void setCae102(String cae102) {
		this.cae102 = cae102;
	}
	public String getCae110() {
		return cae110;
	}
	public void setCae110(String cae110) {
		this.cae110 = cae110;
	}
	public String getAae318() {
		return aae318;
	}
	public void setAae318(String aae318) {
		this.aae318 = aae318;
	}
	public String getAaa121Name() {
		return aaa121Name;
	}
	public void setAaa121Name(String aaa121Name) {
		this.aaa121Name = aaa121Name;
	}
	public String getAaz001() {
		return aaz001;
	}
	public void setAaz001(String aaz001) {
		this.aaz001 = aaz001;
	}
	public Integer getAae002() {
		return aae002;
	}
	public void setAae002(Integer aae002) {
		this.aae002 = aae002;
	}
	public Timestamp getAae036() {
		return aae036;
	}
	public void setAae036(Timestamp aae036) {
		this.aae036 = aae036;
	}
	
	
}