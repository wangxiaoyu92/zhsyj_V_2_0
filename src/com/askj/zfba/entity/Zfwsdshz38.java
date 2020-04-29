package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSDSHZ38的中文含义是: 送达回执; InnoDB free: 2725888 kB
 * @Creation     2016/06/26 10:13:44
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSDSHZ38")
public class Zfwsdshz38 {
	
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	@Column
	private String xzjgmc;
	
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public String getXzjgmc() {
		return xzjgmc;
	}
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public void setXzjgmc(String xzjgmc) {
		this.xzjgmc = xzjgmc;
	}
	/**
	 * @Description sdhzid的中文含义是： 送达回执ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_sdhzid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_sdhzid.nextval from dual"))
	private String sdhzid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description sdhzwsmcbh的中文含义是： 送达文书名称及文书编号
	 */
	@Column
	private String sdhzwsmcbh;

	/**
	 * @Description sdhzsdfs的中文含义是： 送达方式，见aa10，aaa100=SDHZSDFS
	 */
	@Column
	private String sdhzsdfs;

	/**
	 * @Description sdhzsddd的中文含义是： 送达地点
	 */
	@Column
	private String sdhzsddd;

	/**
	 * @Description sdhzsdr的中文含义是： 送达人
	 */
	@Column
	private String sdhzsdr;

	/**
	 * @Description sdhzsdqzrq的中文含义是： 送达签字日期
	 */
	@Column
	private String sdhzsdqzrq;

	/**
	 * @Description sdhzssddwqz的中文含义是： 受送达单位( 人)签字
	 */
	@Column
	private String sdhzssddwqz;

	/**
	 * @Description sdhzssddwqzrq的中文含义是： 受送达单位( 人)签字日期
	 */
	@Column
	private String sdhzssddwqzrq;

	/**
	 * @Description sdhzbz的中文含义是： 备注
	 */
	@Column
	private String sdhzbz;

	/**
	 * @Description sdhzssddw的中文含义是： 受送达单位（人）
	 */
	@Column
	private String sdhzssddw;

	/**
	 * @Description sdhzgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String sdhzgzrq;

	
		/**
	 * @Description sdhzid的中文含义是： 送达回执ID
	 */
	public void setSdhzid(String sdhzid){ 
		this.sdhzid = sdhzid;
	}
	/**
	 * @Description sdhzid的中文含义是： 送达回执ID
	 */
	public String getSdhzid(){
		return sdhzid;
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
	 * @Description sdhzwsmcbh的中文含义是： 送达文书名称及文书编号
	 */
	public void setSdhzwsmcbh(String sdhzwsmcbh){ 
		this.sdhzwsmcbh = sdhzwsmcbh;
	}
	/**
	 * @Description sdhzwsmcbh的中文含义是： 送达文书名称及文书编号
	 */
	public String getSdhzwsmcbh(){
		return sdhzwsmcbh;
	}
	/**
	 * @Description sdhzsdfs的中文含义是： 送达方式，见aa10，aaa100=SDHZSDFS
	 */
	public void setSdhzsdfs(String sdhzsdfs){ 
		this.sdhzsdfs = sdhzsdfs;
	}
	/**
	 * @Description sdhzsdfs的中文含义是： 送达方式，见aa10，aaa100=SDHZSDFS
	 */
	public String getSdhzsdfs(){
		return sdhzsdfs;
	}
	/**
	 * @Description sdhzsddd的中文含义是： 送达地点
	 */
	public void setSdhzsddd(String sdhzsddd){ 
		this.sdhzsddd = sdhzsddd;
	}
	/**
	 * @Description sdhzsddd的中文含义是： 送达地点
	 */
	public String getSdhzsddd(){
		return sdhzsddd;
	}
	/**
	 * @Description sdhzsdr的中文含义是： 送达人
	 */
	public void setSdhzsdr(String sdhzsdr){ 
		this.sdhzsdr = sdhzsdr;
	}
	/**
	 * @Description sdhzsdr的中文含义是： 送达人
	 */
	public String getSdhzsdr(){
		return sdhzsdr;
	}
	/**
	 * @Description sdhzsdqzrq的中文含义是： 送达签字日期
	 */
	public void setSdhzsdqzrq(String sdhzsdqzrq){ 
		this.sdhzsdqzrq = sdhzsdqzrq;
	}
	/**
	 * @Description sdhzsdqzrq的中文含义是： 送达签字日期
	 */
	public String getSdhzsdqzrq(){
		return sdhzsdqzrq;
	}
	/**
	 * @Description sdhzssddwqz的中文含义是： 受送达单位( 人)签字
	 */
	public void setSdhzssddwqz(String sdhzssddwqz){ 
		this.sdhzssddwqz = sdhzssddwqz;
	}
	/**
	 * @Description sdhzssddwqz的中文含义是： 受送达单位( 人)签字
	 */
	public String getSdhzssddwqz(){
		return sdhzssddwqz;
	}
	/**
	 * @Description sdhzssddwqzrq的中文含义是： 受送达单位( 人)签字日期
	 */
	public void setSdhzssddwqzrq(String sdhzssddwqzrq){ 
		this.sdhzssddwqzrq = sdhzssddwqzrq;
	}
	/**
	 * @Description sdhzssddwqzrq的中文含义是： 受送达单位( 人)签字日期
	 */
	public String getSdhzssddwqzrq(){
		return sdhzssddwqzrq;
	}
	/**
	 * @Description sdhzbz的中文含义是： 备注
	 */
	public void setSdhzbz(String sdhzbz){ 
		this.sdhzbz = sdhzbz;
	}
	/**
	 * @Description sdhzbz的中文含义是： 备注
	 */
	public String getSdhzbz(){
		return sdhzbz;
	}
	/**
	 * @Description sdhzssddw的中文含义是： 受送达单位（人）
	 */
	public void setSdhzssddw(String sdhzssddw){ 
		this.sdhzssddw = sdhzssddw;
	}
	/**
	 * @Description sdhzssddw的中文含义是： 受送达单位（人）
	 */
	public String getSdhzssddw(){
		return sdhzssddw;
	}
	/**
	 * @Description sdhzgzrq的中文含义是： 盖章日期
	 */
	public void setSdhzgzrq(String sdhzgzrq){ 
		this.sdhzgzrq = sdhzgzrq;
	}
	/**
	 * @Description sdhzgzrq的中文含义是： 盖章日期
	 */
	public String getSdhzgzrq(){
		return sdhzgzrq;
	}

	
}