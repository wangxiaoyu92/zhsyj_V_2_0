package com.askj.baseinfo.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PWFXWCS的中文含义是: 违法行为参数表; InnoDB free: 2757632 kBDTO
 * @Creation     2016/04/26 14:54:44
 * @Written      Create Tool By zjf 
 **/
public class PwfxwcsDTO {
	/**
	 * @Description pwfxwcsid的中文含义是： 违法行为参数ID
	 */
	private String pwfxwcsid;

	/**
	 * @Description ajdjajdl的中文含义是： 案件登记案件大类,见aa10表ajdjajdl
	 */
	private String ajdjajdl;

	/**
	 * @Description wfxwbh的中文含义是： 违法行为编号
	 */
	private String wfxwbh;

	/**
	 * @Description wfxwms的中文含义是： 违法行为描述
	 */
	private String wfxwms;

	/**
	 * @Description wfxwwffg的中文含义是： 违反法规
	 */
	private String wfxwwffg;

	/**
	 * @Description wfxwwftk的中文含义是： 违反条款
	 */
	private String wfxwwftk;

	/**
	 * @Description wfxwwftknr的中文含义是： 违反条款内容
	 */
	private String wfxwwftknr;

	/**
	 * @Description wfxwcffg的中文含义是： 处罚法规
	 */
	private String wfxwcffg;

	/**
	 * @Description wfxwcffgtk的中文含义是： 处罚法规条款
	 */
	private String wfxwcffgtk;

	/**
	 * @Description wfxwcffgtknr的中文含义是： 处罚法规条款内容
	 */
	private String wfxwcffgtknr;

	/**
	 * @Description wfxwcfnr的中文含义是： 处罚内容
	 */
	private String wfxwcfnr;

	/**
	 * @Description wfxwbz的中文含义是： 备注
	 */
	private String wfxwbz;

	
		/**
	 * @Description pwfxwcsid的中文含义是： 违法行为参数ID
	 */
	public void setPwfxwcsid(String pwfxwcsid){ 
		this.pwfxwcsid = pwfxwcsid;
	}
	/**
	 * @Description pwfxwcsid的中文含义是： 违法行为参数ID
	 */
	public String getPwfxwcsid(){
		return pwfxwcsid;
	}
	/**
	 * @Description ajdjajdl的中文含义是： 案件登记案件大类,见aa10表ajdjajdl
	 */
	public void setAjdjajdl(String ajdjajdl){ 
		this.ajdjajdl = ajdjajdl;
	}
	/**
	 * @Description ajdjajdl的中文含义是： 案件登记案件大类,见aa10表ajdjajdl
	 */
	public String getAjdjajdl(){
		return ajdjajdl;
	}
	/**
	 * @Description wfxwbh的中文含义是： 违法行为编号
	 */
	public void setWfxwbh(String wfxwbh){ 
		this.wfxwbh = wfxwbh;
	}
	/**
	 * @Description wfxwbh的中文含义是： 违法行为编号
	 */
	public String getWfxwbh(){
		return wfxwbh;
	}
	/**
	 * @Description wfxwms的中文含义是： 违法行为描述
	 */
	public void setWfxwms(String wfxwms){ 
		this.wfxwms = wfxwms;
	}
	/**
	 * @Description wfxwms的中文含义是： 违法行为描述
	 */
	public String getWfxwms(){
		return wfxwms;
	}
	/**
	 * @Description wfxwwffg的中文含义是： 违反法规
	 */
	public void setWfxwwffg(String wfxwwffg){ 
		this.wfxwwffg = wfxwwffg;
	}
	/**
	 * @Description wfxwwffg的中文含义是： 违反法规
	 */
	public String getWfxwwffg(){
		return wfxwwffg;
	}
	/**
	 * @Description wfxwwftk的中文含义是： 违反条款
	 */
	public void setWfxwwftk(String wfxwwftk){ 
		this.wfxwwftk = wfxwwftk;
	}
	/**
	 * @Description wfxwwftk的中文含义是： 违反条款
	 */
	public String getWfxwwftk(){
		return wfxwwftk;
	}
	/**
	 * @Description wfxwwftknr的中文含义是： 违反条款内容
	 */
	public void setWfxwwftknr(String wfxwwftknr){ 
		this.wfxwwftknr = wfxwwftknr;
	}
	/**
	 * @Description wfxwwftknr的中文含义是： 违反条款内容
	 */
	public String getWfxwwftknr(){
		return wfxwwftknr;
	}
	/**
	 * @Description wfxwcffg的中文含义是： 处罚法规
	 */
	public void setWfxwcffg(String wfxwcffg){ 
		this.wfxwcffg = wfxwcffg;
	}
	/**
	 * @Description wfxwcffg的中文含义是： 处罚法规
	 */
	public String getWfxwcffg(){
		return wfxwcffg;
	}
	/**
	 * @Description wfxwcffgtk的中文含义是： 处罚法规条款
	 */
	public void setWfxwcffgtk(String wfxwcffgtk){ 
		this.wfxwcffgtk = wfxwcffgtk;
	}
	/**
	 * @Description wfxwcffgtk的中文含义是： 处罚法规条款
	 */
	public String getWfxwcffgtk(){
		return wfxwcffgtk;
	}
	/**
	 * @Description wfxwcffgtknr的中文含义是： 处罚法规条款内容
	 */
	public void setWfxwcffgtknr(String wfxwcffgtknr){ 
		this.wfxwcffgtknr = wfxwcffgtknr;
	}
	/**
	 * @Description wfxwcffgtknr的中文含义是： 处罚法规条款内容
	 */
	public String getWfxwcffgtknr(){
		return wfxwcffgtknr;
	}
	/**
	 * @Description wfxwcfnr的中文含义是： 处罚内容
	 */
	public void setWfxwcfnr(String wfxwcfnr){ 
		this.wfxwcfnr = wfxwcfnr;
	}
	/**
	 * @Description wfxwcfnr的中文含义是： 处罚内容
	 */
	public String getWfxwcfnr(){
		return wfxwcfnr;
	}
	/**
	 * @Description wfxwbz的中文含义是： 备注
	 */
	public void setWfxwbz(String wfxwbz){ 
		this.wfxwbz = wfxwbz;
	}
	/**
	 * @Description wfxwbz的中文含义是： 备注
	 */
	public String getWfxwbz(){
		return wfxwbz;
	}

	
}