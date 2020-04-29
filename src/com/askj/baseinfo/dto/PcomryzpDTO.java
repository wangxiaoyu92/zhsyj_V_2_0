package com.askj.baseinfo.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PCOMRYZP的中文含义是: 单位人员照片; InnoDB free: 2754560 kBDTO
 * @Creation     2016/05/12 17:52:10
 * @Written      Create Tool By zjf 
 **/
public class PcomryzpDTO {
	/**
	 * @Description pcomryzpid的中文含义是： 单位人员照片ID
	 */
	private String pcomryzpid;

	/**
	 * @Description ryid的中文含义是： 单位人员ID
	 */
	private String ryid;

	/**
	 * @Description ryzp的中文含义是： 照片
	 */
	private String ryzp;

	/**
	 * @Description ryzpwjm的中文含义是： 单位人员照片文件名
	 */
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
	public void setRyzp(String ryzp){ 
		this.ryzp = ryzp;
	}
	/**
	 * @Description ryzp的中文含义是： 照片
	 */
	public String getRyzp(){
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