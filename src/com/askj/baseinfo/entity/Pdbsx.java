package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  PDBSX的中文含义是: 待办事项表; InnoDB free: 9216 kB
 * @Creation     2016/10/09 17:15:08
 * @Written      Create Tool By zjf 
 **/
@Table(value = "PDBSX")
public class Pdbsx {
	/**
	 * @Description pdbsxid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_pdbsxid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_pdbsxid.nextval from dual"))
	private String pdbsxid;

	/**
	 * @Description qtbid的中文含义是： 
	 */
	@Column
	private String qtbid;

	/**
	 * @Description fsuserid的中文含义是： 
	 */
	@Column
	private String fsuserid;

	/**
	 * @Description fsusername的中文含义是： 
	 */
	@Column
	private String fsusername;

	/**
	 * @Description fssj的中文含义是： 
	 */
	@Column
	private String fssj;

	/**
	 * @Description fsnr的中文含义是： 
	 */
	@Column
	private String fsnr;

	/**
	 * @Description fsxtbz的中文含义是： 
	 */
	@Column
	private String fsxtbz;
	
	/**
	 * @Description hfid的中文含义是： 回复id
	 */
	@Column
	private String hfid;	

	
		/**
	 * @Description pdbsxid的中文含义是： 
	 */
	public void setPdbsxid(String pdbsxid){ 
		this.pdbsxid = pdbsxid;
	}
	/**
	 * @Description pdbsxid的中文含义是： 
	 */
	public String getPdbsxid(){
		return pdbsxid;
	}
	/**
	 * @Description qtbid的中文含义是： 
	 */
	public void setQtbid(String qtbid){ 
		this.qtbid = qtbid;
	}
	/**
	 * @Description qtbid的中文含义是： 
	 */
	public String getQtbid(){
		return qtbid;
	}
	/**
	 * @Description fsuserid的中文含义是： 
	 */
	public void setFsuserid(String fsuserid){ 
		this.fsuserid = fsuserid;
	}
	/**
	 * @Description fsuserid的中文含义是： 
	 */
	public String getFsuserid(){
		return fsuserid;
	}
	/**
	 * @Description fsusername的中文含义是： 
	 */
	public void setFsusername(String fsusername){ 
		this.fsusername = fsusername;
	}
	/**
	 * @Description fsusername的中文含义是： 
	 */
	public String getFsusername(){
		return fsusername;
	}
	/**
	 * @Description fssj的中文含义是： 
	 */
	public void setFssj(String fssj){ 
		this.fssj = fssj;
	}
	/**
	 * @Description fssj的中文含义是： 
	 */
	public String getFssj(){
		return fssj;
	}
	/**
	 * @Description fsnr的中文含义是： 
	 */
	public void setFsnr(String fsnr){ 
		this.fsnr = fsnr;
	}
	/**
	 * @Description fsnr的中文含义是： 
	 */
	public String getFsnr(){
		return fsnr;
	}
	/**
	 * @Description fsxtbz的中文含义是： 
	 */
	public void setFsxtbz(String fsxtbz){ 
		this.fsxtbz = fsxtbz;
	}
	/**
	 * @Description fsxtbz的中文含义是： 
	 */
	public String getFsxtbz(){
		return fsxtbz;
	}
	public String getHfid() {
		return hfid;
	}
	public void setHfid(String hfid) {
		this.hfid = hfid;
	}

	
}