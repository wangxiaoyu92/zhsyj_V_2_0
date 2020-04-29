package com.zzhdsoft.siweb.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description AA13 的中文含义是 国别（地区）代码表
 * @Creation 2014/09/01 15:31:29
 * @Written Create Tool By ZhengZhou HuaDong Software
 **/
@Table(value = "AA13")
public class Aa13 {
	// 子节点数量,非映射字段
	@Column
	@Readonly
	private int childnum;
	// 是否父节点,非映射字段
	@Column
	@Readonly
	private boolean isparent;
	// 是否展开,非映射字段
	@Column
	@Readonly
	private boolean isopen;

	@Column
	@Readonly
	private String aaa027name;

	@Column
	@Readonly
	private String aaa148name;

	public int getChildnum() {
		return childnum;
	}

	public void setChildnum(int childnum) {
		this.childnum = childnum;
	}

	public boolean getIsparent() {
		return isparent;
	}

	public void setIsparent(boolean isparent) {
		this.isparent = isparent;
	}

	public boolean getIsopen() {
		return isopen;
	}

	public void setIsopen(boolean isopen) {
		this.isopen = isopen;
	}

	public String getAaa027name() {
		return aaa027name;
	}

	public void setAaa027name(String aaa027name) {
		this.aaa027name = aaa027name;
	}

	public String getAaa148name() {
		return aaa148name;
	}

	public void setAaa148name(String aaa148name) {
		this.aaa148name = aaa148name;
	}

	/**
	 * @Description baz001的中文含义是： 记录编号
	 */
	@Column
	private String baz001;

	/**
	 * @Description baz002的中文含义是： 排列序号
	 */
	@Column
	private String baz002;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_aaa027')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_aaa027.nextval from dual"))
	private String aaa027;

	/**
	 * @Description aaa129的中文含义是： 统筹区名称
	 */
	@Column
	private String aaa129;

	/**
	 * @Description aaa148的中文含义是： 上级统筹区编码
	 */
	@Column
	private String aaa148;

	/**
	 * @Description aae383的中文含义是： 统筹区级别（1省、2市、3县、4乡、5村）
	 */
	@Column
	private String aae383;

	/**
	 * @Description aae007的中文含义是： 邮政编码
	 */
	@Column
	private String aae007;

	/**
	 * @Description aaa013的中文含义是： 备注
	 */
	@Column
	private String aaa013;

	/**
	 * @Description baz001的中文含义是： 记录编号
	 */
	public void setBaz001(String baz001) {
		this.baz001 = baz001;
	}

	/**
	 * @Description baz001的中文含义是： 记录编号
	 */
	public String getBaz001() {
		return baz001;
	}

	/**
	 * @Description baz002的中文含义是： 排列序号
	 */
	public void setBaz002(String baz002) {
		this.baz002 = baz002;
	}

	/**
	 * @Description baz002的中文含义是： 排列序号
	 */
	public String getBaz002() {
		return baz002;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027() {
		return aaa027;
	}

	/**
	 * @Description aaa129的中文含义是： 统筹区名称
	 */
	public void setAaa129(String aaa129) {
		this.aaa129 = aaa129;
	}

	/**
	 * @Description aaa129的中文含义是： 统筹区名称
	 */
	public String getAaa129() {
		return aaa129;
	}

	/**
	 * @Description aaa148的中文含义是： 上级统筹区编码
	 */
	public void setAaa148(String aaa148) {
		this.aaa148 = aaa148;
	}

	/**
	 * @Description aaa148的中文含义是： 上级统筹区编码
	 */
	public String getAaa148() {
		return aaa148;
	}

	/**
	 * @Description aae383的中文含义是： 统筹区级别（1省、2市、3县、4乡、5村）
	 */
	public void setAae383(String aae383) {
		this.aae383 = aae383;
	}

	/**
	 * @Description aae383的中文含义是： 统筹区级别（1省、2市、3县、4乡、5村）
	 */
	public String getAae383() {
		return aae383;
	}

	/**
	 * @Description aae007的中文含义是： 邮政编码
	 */
	public void setAae007(String aae007) {
		this.aae007 = aae007;
	}

	/**
	 * @Description aae007的中文含义是： 邮政编码
	 */
	public String getAae007() {
		return aae007;
	}

	/**
	 * @Description aaa013的中文含义是： 备注
	 */
	public void setAaa013(String aaa013) {
		this.aaa013 = aaa013;
	}

	/**
	 * @Description aaa013的中文含义是： 备注
	 */
	public String getAaa013() {
		return aaa013;
	}

}