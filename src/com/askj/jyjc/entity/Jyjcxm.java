package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  JYJCXM的中文含义是: 检验检查项目表; InnoDB free: 2757632 kB
 * @Creation     2016/05/05 10:19:23
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JYJCXM")
public class Jyjcxm {
	/**
	 * @Description jcxmid的中文含义是： 检测项目ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jcxmid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jcxmid.nextval from dual"))
	private String jyjcxmid;

	/**
	 * @Description jyjcxmlx的中文含义是： 检验检测项目类型
	 */
	@Column
	private String jyjcxmlx;

	/**
	 * @Description sfmumu的中文含义是： 是否目录
	 */
	@Column
	private String sfmulu;

	/**
	 * @Description jcxmbh的中文含义是： 检查项目编号
	 */
	@Column
	private String jcxmbh;

	/**
	 * @Description jcxmmc的中文含义是： 检查项目名称
	 */
	@Column
	private String jcxmmc;

	/**
	 * @Description jcxmbzz的中文含义是： 标准值
	 */
	@Column
	private String jcxmbzz;

	/**
	 * @Description sfyx： 是否有效
	 */
	@Column
	private String sfyx;

	/**
	 * @Description jcxmczy的中文含义是： 操作员
	 */
	@Column
	private String jcxmczy;

	/**
	 * @Description jcxmczsj的中文含义是： 操作时间
	 */
	@Column
	private String jcxmczsj;

	public String getJcxmparentid() {
		return jcxmparentid;
	}

	public void setJcxmparentid(String jcxmparentid) {
		this.jcxmparentid = jcxmparentid;
	}

	@Column
	private String jcxmparentid;

	public String getJyjcxmid() {
		return jyjcxmid;
	}

	public void setJyjcxmid(String jyjcxmid) {
		this.jyjcxmid = jyjcxmid;
	}
	@Column
	private String jcxmmcjc;

	public String getJcxmmcjc() {
		return jcxmmcjc;
	}

	public void setJcxmmcjc(String jcxmmcjc) {
		this.jcxmmcjc = jcxmmcjc;
	}

	/**
	 * @Description jcxmbh的中文含义是： 检查项目编号
	 */
	public void setJcxmbh(String jcxmbh){ 
		this.jcxmbh = jcxmbh;
	}
	/**
	 * @Description jcxmbh的中文含义是： 检查项目编号
	 */
	public String getJcxmbh(){
		return jcxmbh;
	}
	/**
	 * @Description jcxmmc的中文含义是： 检查项目名称
	 */
	public void setJcxmmc(String jcxmmc){ 
		this.jcxmmc = jcxmmc;
	}
	/**
	 * @Description jcxmmc的中文含义是： 检查项目名称
	 */
	public String getJcxmmc(){
		return jcxmmc;
	}
	/**
	 * @Description jcxmbzz的中文含义是： 标准值
	 */
	public void setJcxmbzz(String jcxmbzz){ 
		this.jcxmbzz = jcxmbzz;
	}
	/**
	 * @Description jcxmbzz的中文含义是： 标准值
	 */
	public String getJcxmbzz(){
		return jcxmbzz;
	}
	/**
	 * @Description jcxmczy的中文含义是： 操作员
	 */
	public void setJcxmczy(String jcxmczy){ 
		this.jcxmczy = jcxmczy;
	}
	/**
	 * @Description jcxmczy的中文含义是： 操作员
	 */
	public String getJcxmczy(){
		return jcxmczy;
	}
	/**
	 * @Description jcxmczsj的中文含义是： 操作时间
	 */
	public void setJcxmczsj(String jcxmczsj){ 
		this.jcxmczsj = jcxmczsj;
	}
	/**
	 * @Description jcxmczsj的中文含义是： 操作时间
	 */
	public String getJcxmczsj(){
		return jcxmczsj;
	}

	public String getSfyx() {
		return sfyx;
	}

	public void setSfyx(String sfyx) {
		this.sfyx = sfyx;
	}

	public String getJyjcxmlx() {
		return jyjcxmlx;
	}

	public void setJyjcxmlx(String jyjcxmlx) {
		this.jyjcxmlx = jyjcxmlx;
	}

	public String getSfmulu() {
		return sfmulu;
	}

	public void setSfmulu(String sfmulu) {
		this.sfmulu = sfmulu;
	}
}