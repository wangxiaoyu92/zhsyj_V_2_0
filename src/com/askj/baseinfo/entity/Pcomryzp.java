package com.askj.baseinfo.entity;

import java.io.InputStream;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  PCOMRYZP的中文含义是: 单位人员照片; InnoDB free: 2754560 kB
 * @Creation     2016/05/12 17:52:27
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PCOMRYZP")
public class Pcomryzp {
	/**
	 * @Description pcomryzpid的中文含义是： 单位人员照片ID
	 */
	@Column
	@Name
	private String pcomryzpid;

	/**
	 * @Description ryid的中文含义是： 单位人员ID
	 */
	@Column
	private String ryid;

	/**
	 * @Description ryzp的中文含义是： 照片
	 */
	@Column
	private InputStream ryzp;

	/**
	 * @Description ryzpwjm的中文含义是： 单位人员照片文件名
	 */
	@Column
	private String ryzpwjm;

	
		/**
	 * @Description pcomryzpid的中文含义是： 单位人员照片ID
	 */
	public void setPcomryzpid(String pcomryzpid){ 
		this.pcomryzpid = pcomryzpid;
	}
	/**
	 * @Description pcomryzpid的中文含义是： 单位人员照片ID
	 */
	public String getPcomryzpid(){
		return pcomryzpid;
	}
	/**
	 * @Description ryid的中文含义是： 单位人员ID
	 */
	public void setRyid(String ryid){ 
		this.ryid = ryid;
	}
	/**
	 * @Description ryid的中文含义是： 单位人员ID
	 */
	public String getRyid(){
		return ryid;
	}
	/**
	 * @Description ryzp的中文含义是： 照片
	 */
	public void setRyzp(InputStream ryzp){ 
		this.ryzp = ryzp;
	}
	/**
	 * @Description ryzp的中文含义是： 照片
	 */
	public InputStream getRyzp(){
		return ryzp;
	}
	/**
	 * @Description ryzpwjm的中文含义是： 单位人员照片文件名
	 */
	public void setRyzpwjm(String ryzpwjm){ 
		this.ryzpwjm = ryzpwjm;
	}
	/**
	 * @Description ryzpwjm的中文含义是： 单位人员照片文件名
	 */
	public String getRyzpwjm(){
		return ryzpwjm;
	}

	
}