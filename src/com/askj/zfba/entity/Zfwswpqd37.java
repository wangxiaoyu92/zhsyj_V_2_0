package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSWPQD37的中文含义是: 食品药品行政处罚文书物品清单37; InnoDB free: 2725888 kB
 * @Creation     2016/06/24 17:47:27
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSWPQD37")
public class Zfwswpqd37 {
	
	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	@Column
	private String xzjgmc;
	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	public String getXzjgmc() {
		return xzjgmc;
	}
	/**
	 * @Description xzjgmc的中文含义是：行政机关名称
	 */
	public void setXzjgmc(String xzjgmc) {
		this.xzjgmc = xzjgmc;
	}
	/**
	 * @Description wpqdid的中文含义是： 物品清单ID
	 */
	@Column
	@Name
	private String wpqdid;

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
	 * @Description wpqdwsbh的中文含义是： 文书编号
	 */
	@Column
	private String wpqdwsbh;

	/**
	 * @Description wpqddsrqz的中文含义是： 当事人签字
	 */
	@Column
	private String wpqddsrqz;

	/**
	 * @Description wpqddsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String wpqddsrqzrq;

	/**
	 * @Description wpqdzfry1qz的中文含义是： 执法人员1签字
	 */
	@Column
	private String wpqdzfry1qz;

	/**
	 * @Description wpqdzfry2qz的中文含义是： 执法人员2签字
	 */
	@Column
	private String wpqdzfry2qz;

	/**
	 * @Description wpqdzfryqzrq的中文含义是： 执法人员签字日期
	 */
	@Column
	private String wpqdzfryqzrq;

	/**
	 * @Description wpqdqtwp的中文含义是： 其它物品
	 */
	@Column
	private String wpqdqtwp;

	/**
	 * @Description wppddsr的中文含义是： 当事人
	 */
	@Column
	private String wppddsr;

	/**
	 * @Description wppddz的中文含义是： 地址
	 */
	@Column
	private String wppddz;

	
		/**
	 * @Description wpqdid的中文含义是： 物品清单ID
	 */
	public void setWpqdid(String wpqdid){ 
		this.wpqdid = wpqdid;
	}
	/**
	 * @Description wpqdid的中文含义是： 物品清单ID
	 */
	public String getWpqdid(){
		return wpqdid;
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
	 * @Description wpqdwsbh的中文含义是： 文书编号
	 */
	public void setWpqdwsbh(String wpqdwsbh){ 
		this.wpqdwsbh = wpqdwsbh;
	}
	/**
	 * @Description wpqdwsbh的中文含义是： 文书编号
	 */
	public String getWpqdwsbh(){
		return wpqdwsbh;
	}
	/**
	 * @Description wpqddsrqz的中文含义是： 当事人签字
	 */
	public void setWpqddsrqz(String wpqddsrqz){ 
		this.wpqddsrqz = wpqddsrqz;
	}
	/**
	 * @Description wpqddsrqz的中文含义是： 当事人签字
	 */
	public String getWpqddsrqz(){
		return wpqddsrqz;
	}
	/**
	 * @Description wpqddsrqzrq的中文含义是： 当事人签字日期
	 */
	public void setWpqddsrqzrq(String wpqddsrqzrq){ 
		this.wpqddsrqzrq = wpqddsrqzrq;
	}
	/**
	 * @Description wpqddsrqzrq的中文含义是： 当事人签字日期
	 */
	public String getWpqddsrqzrq(){
		return wpqddsrqzrq;
	}
	/**
	 * @Description wpqdzfry1qz的中文含义是： 执法人员1签字
	 */
	public void setWpqdzfry1qz(String wpqdzfry1qz){ 
		this.wpqdzfry1qz = wpqdzfry1qz;
	}
	/**
	 * @Description wpqdzfry1qz的中文含义是： 执法人员1签字
	 */
	public String getWpqdzfry1qz(){
		return wpqdzfry1qz;
	}
	/**
	 * @Description wpqdzfry2qz的中文含义是： 执法人员2签字
	 */
	public void setWpqdzfry2qz(String wpqdzfry2qz){ 
		this.wpqdzfry2qz = wpqdzfry2qz;
	}
	/**
	 * @Description wpqdzfry2qz的中文含义是： 执法人员2签字
	 */
	public String getWpqdzfry2qz(){
		return wpqdzfry2qz;
	}
	/**
	 * @Description wpqdzfryqzrq的中文含义是： 执法人员签字日期
	 */
	public void setWpqdzfryqzrq(String wpqdzfryqzrq){ 
		this.wpqdzfryqzrq = wpqdzfryqzrq;
	}
	/**
	 * @Description wpqdzfryqzrq的中文含义是： 执法人员签字日期
	 */
	public String getWpqdzfryqzrq(){
		return wpqdzfryqzrq;
	}
	/**
	 * @Description wpqdqtwp的中文含义是： 其它物品
	 */
	public void setWpqdqtwp(String wpqdqtwp){ 
		this.wpqdqtwp = wpqdqtwp;
	}
	/**
	 * @Description wpqdqtwp的中文含义是： 其它物品
	 */
	public String getWpqdqtwp(){
		return wpqdqtwp;
	}
	/**
	 * @Description wppddsr的中文含义是： 当事人
	 */
	public void setWppddsr(String wppddsr){ 
		this.wppddsr = wppddsr;
	}
	/**
	 * @Description wppddsr的中文含义是： 当事人
	 */
	public String getWppddsr(){
		return wppddsr;
	}
	/**
	 * @Description wppddz的中文含义是： 地址
	 */
	public void setWppddz(String wppddz){ 
		this.wppddz = wppddz;
	}
	/**
	 * @Description wppddz的中文含义是： 地址
	 */
	public String getWppddz(){
		return wppddz;
	}

	
}