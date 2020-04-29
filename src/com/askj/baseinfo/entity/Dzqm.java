package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  DZQM的中文含义是: 电子签名
 * @Creation     2016/12/08 13:41:29
 * @Written      Create Tool By zjf 
 **/
@Table(value = "DZQM")
public class Dzqm {
	/**
	 * @Description dzqmid的中文含义是： id
	 */
	@Column
	@Name
	private String dzqmid;

	/**
	 * @Description dzqmuser的中文含义是： 用户id
	 */
	@Column
	private String dzqmuser;

	/**
	 * @Description dzqmpwd的中文含义是： 电子签名密码
	 */
	@Column
	private String dzqmpwd;

	/**
	 * @Description dzqmtp的中文含义是： 电子签名照
	 */
	@Column
	private String dzqmtp;

	/**
	 * @Description dzqmpath的中文含义是： 路片路径
	 */
	@Column
	private String dzqmpath;

	/**
	 * @Description tpname的中文含义是： 照片名字
	 */
	@Column
	private String tpname;

	
		/**
	 * @Description dzqmid的中文含义是： id
	 */
	public void setDzqmid(String dzqmid){ 
		this.dzqmid = dzqmid;
	}
	/**
	 * @Description dzqmid的中文含义是： id
	 */
	public String getDzqmid(){
		return dzqmid;
	}
	/**
	 * @Description dzqmuser的中文含义是： 用户id
	 */
	public void setDzqmuser(String dzqmuser){ 
		this.dzqmuser = dzqmuser;
	}
	/**
	 * @Description dzqmuser的中文含义是： 用户id
	 */
	public String getDzqmuser(){
		return dzqmuser;
	}
	/**
	 * @Description dzqmpwd的中文含义是： 电子签名密码
	 */
	public void setDzqmpwd(String dzqmpwd){ 
		this.dzqmpwd = dzqmpwd;
	}
	/**
	 * @Description dzqmpwd的中文含义是： 电子签名密码
	 */
	public String getDzqmpwd(){
		return dzqmpwd;
	}
	/**
	 * @Description dzqmtp的中文含义是： 电子签名照
	 */
	public void setDzqmtp(String dzqmtp){ 
		this.dzqmtp = dzqmtp;
	}
	/**
	 * @Description dzqmtp的中文含义是： 电子签名照
	 */
	public String getDzqmtp(){
		return dzqmtp;
	}
	/**
	 * @Description dzqmpath的中文含义是： 路片路径
	 */
	public void setDzqmpath(String dzqmpath){ 
		this.dzqmpath = dzqmpath;
	}
	/**
	 * @Description dzqmpath的中文含义是： 路片路径
	 */
	public String getDzqmpath(){
		return dzqmpath;
	}
	/**
	 * @Description tpname的中文含义是： 照片名字
	 */
	public void setTpname(String tpname){ 
		this.tpname = tpname;
	}
	/**
	 * @Description tpname的中文含义是： 照片名字
	 */
	public String getTpname(){
		return tpname;
	}

	
}