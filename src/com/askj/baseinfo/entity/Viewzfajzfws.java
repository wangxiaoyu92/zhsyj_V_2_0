package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  VIEWZFAJZFWS的中文含义是: 执法案件执法文书VIEW
 * @Creation     2016/02/22 13:55:44
 * @Written      Create Tool By zjf 
 **/
@Table(value = "VIEWZFAJZFWS")
public class Viewzfajzfws {
	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	@Column
	private String fjcsid;

	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	@Column
	private String fjcsdmlb;

	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	@Column
	private String fjcsdmlbmc;

	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	@Column
	private String fjcsdmz;

	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	@Column
	private String fjcsdmmc;

	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	@Column
	private String fjcsksrq;

	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	@Column
	private String fjcszzrq;

	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	@Column
	private String fjcsqyflag;

	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	@Column
	private String fjcsfjbc;

	
		/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	public void setFjcsid(String fjcsid){ 
		this.fjcsid = fjcsid;
	}
	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	public String getFjcsid(){
		return fjcsid;
	}
	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	public void setFjcsdmlb(String fjcsdmlb){ 
		this.fjcsdmlb = fjcsdmlb;
	}
	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	public String getFjcsdmlb(){
		return fjcsdmlb;
	}
	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	public void setFjcsdmlbmc(String fjcsdmlbmc){ 
		this.fjcsdmlbmc = fjcsdmlbmc;
	}
	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	public String getFjcsdmlbmc(){
		return fjcsdmlbmc;
	}
	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	public void setFjcsdmz(String fjcsdmz){ 
		this.fjcsdmz = fjcsdmz;
	}
	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	public String getFjcsdmz(){
		return fjcsdmz;
	}
	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	public void setFjcsdmmc(String fjcsdmmc){ 
		this.fjcsdmmc = fjcsdmmc;
	}
	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	public String getFjcsdmmc(){
		return fjcsdmmc;
	}
	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	public void setFjcsksrq(String fjcsksrq){ 
		this.fjcsksrq = fjcsksrq;
	}
	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	public String getFjcsksrq(){
		return fjcsksrq;
	}
	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	public void setFjcszzrq(String fjcszzrq){ 
		this.fjcszzrq = fjcszzrq;
	}
	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	public String getFjcszzrq(){
		return fjcszzrq;
	}
	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	public void setFjcsqyflag(String fjcsqyflag){ 
		this.fjcsqyflag = fjcsqyflag;
	}
	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	public String getFjcsqyflag(){
		return fjcsqyflag;
	}
	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	public void setFjcsfjbc(String fjcsfjbc){ 
		this.fjcsfjbc = fjcsfjbc;
	}
	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	public String getFjcsfjbc(){
		return fjcsfjbc;
	}

	
}