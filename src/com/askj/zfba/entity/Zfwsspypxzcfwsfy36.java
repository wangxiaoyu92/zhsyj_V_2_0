package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  ZFWSSPYPXZCFWSFY36的中文含义是: 食品药品行政处罚文书副页; InnoDB free: 76800 kB
 * @Creation     2016/03/19 11:29:00
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSSPYPXZCFWSFY36")
public class Zfwsspypxzcfwsfy36 {
	/**
	 * id
	 * 
	 */
	private String zfwsqtbid;
	
	/**
	 * @Description spypxzcfwsfyid的中文含义是： 食品药品行政处罚文书副页ID
	 */
	
	@Column
	@Name
	private String spypxzcfwsfyid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	@Column
	private String zfwsdmz;

	/**
	 * @Description fybdcrqz的中文含义是： 被调查人签字
	 */
	@Column
	private String fybdcrqz;

	/**
	 * @Description fybdcrqzrq的中文含义是： 被调查人签字日期
	 */
	@Column
	private String fybdcrqzrq;

	/**
	 * @Description fyzfryqz的中文含义是： 执法人员签字
	 */
	@Column
	private String fyzfryqz;

	/**
	 * @Description fyzfryqzrq的中文含义是： 执法人员签字日期
	 */
	@Column
	private String fyzfryqzrq;

	@Column
	private String fytitle;
	@Column
	private String fydjy;
	@Column
	private String fygjy;
	@Column
	private String aae011;
	@Column
	private String aae036;
	@Column
	private String zybid;
	@Column
	private String fycontent;

	public String getFytitle() {
		return fytitle;
	}

	public void setFytitle(String fytitle) {
		this.fytitle = fytitle;
	}

	public String getFydjy() {
		return fydjy;
	}

	public void setFydjy(String fydjy) {
		this.fydjy = fydjy;
	}

	public String getFygjy() {
		return fygjy;
	}

	public void setFygjy(String fygjy) {
		this.fygjy = fygjy;
	}

	public String getAae011() {
		return aae011;
	}

	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}

	public String getAae036() {
		return aae036;
	}

	public void setAae036(String aae036) {
		this.aae036 = aae036;
	}

	public String getZybid() {
		return zybid;
	}

	public void setZybid(String zybid) {
		this.zybid = zybid;
	}

	public String getFycontent() {
		return fycontent;
	}

	public void setFycontent(String fycontent) {
		this.fycontent = fycontent;
	}

	/**
	 * @Description spypxzcfwsfyid的中文含义是： 食品药品行政处罚文书副页ID
	 */
	public void setSpypxzcfwsfyid(String spypxzcfwsfyid){ 
		this.spypxzcfwsfyid = spypxzcfwsfyid;
	}
	/**
	 * @Description spypxzcfwsfyid的中文含义是： 食品药品行政处罚文书副页ID
	 */
	public String getSpypxzcfwsfyid(){
		return spypxzcfwsfyid;
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
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public void setZfwsdmz(String zfwsdmz){ 
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public String getZfwsdmz(){
		return zfwsdmz;
	}
	/**
	 * @Description fybdcrqz的中文含义是： 被调查人签字
	 */
	public void setFybdcrqz(String fybdcrqz){ 
		this.fybdcrqz = fybdcrqz;
	}
	/**
	 * @Description fybdcrqz的中文含义是： 被调查人签字
	 */
	public String getFybdcrqz(){
		return fybdcrqz;
	}
	/**
	 * @Description fybdcrqzrq的中文含义是： 被调查人签字日期
	 */
	public void setFybdcrqzrq(String fybdcrqzrq){ 
		this.fybdcrqzrq = fybdcrqzrq;
	}
	/**
	 * @Description fybdcrqzrq的中文含义是： 被调查人签字日期
	 */
	public String getFybdcrqzrq(){
		return fybdcrqzrq;
	}
	/**
	 * @Description fyzfryqz的中文含义是： 执法人员签字
	 */
	public void setFyzfryqz(String fyzfryqz){ 
		this.fyzfryqz = fyzfryqz;
	}
	/**
	 * @Description fyzfryqz的中文含义是： 执法人员签字
	 */
	public String getFyzfryqz(){
		return fyzfryqz;
	}
	/**
	 * @Description fyzfryqzrq的中文含义是： 执法人员签字日期
	 */
	public void setFyzfryqzrq(String fyzfryqzrq){ 
		this.fyzfryqzrq = fyzfryqzrq;
	}
	/**
	 * @Description fyzfryqzrq的中文含义是： 执法人员签字日期
	 */
	public String getFyzfryqzrq(){
		return fyzfryqzrq;
	}
	public String getZfwsqtbid() {
		return zfwsqtbid;
	}
	public void setZfwsqtbid(String zfwsqtbid) {
		this.zfwsqtbid = zfwsqtbid;
	}

	
}