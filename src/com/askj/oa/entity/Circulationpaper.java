package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  CIRCULATIONPAPER的中文含义是: 公文管理-传阅; InnoDB free: 2724864 kB
 * @Creation     2016/06/30 14:20:25
 * @Written      Create Tool By zjf 
 **/
@Table(value = "CIRCULATIONPAPER")
public class Circulationpaper {
	/**
	 * @Description paperid的中文含义是： 传阅id
	 */
	@Column
	@Name
	private String paperid;

	/**
	 * @Description fileid的中文含义是： 归档id
	 */
	@Column
	private String fileid;

	/**
	 * @Description paperuserid的中文含义是： 传阅者id
	 */
	@Column
	private String paperuserid;

	/**
	 * @Description paperusername的中文含义是： 传阅者的名字
	 */
	@Column
	private String paperusername;

	/**
	 * @Description recuserid的中文含义是： 接受者id
	 */
	@Column
	private String recuserid;

	/**
	 * @Description recusername的中文含义是： 接受者的名字
	 */
	@Column
	private String recusername;

	/**
	 * @Description paperstate的中文含义是： 查看状态  0是未查看   1是查看
	 */
	@Column
	private String paperstate;

	/**
	 * @Description filetitle的中文含义是： 公文标题
	 */
	@Column
	private String filetitle;

	
		/**
	 * @Description paperid的中文含义是： 传阅id
	 */
	public void setPaperid(String paperid){ 
		this.paperid = paperid;
	}
	/**
	 * @Description paperid的中文含义是： 传阅id
	 */
	public String getPaperid(){
		return paperid;
	}
	/**
	 * @Description fileid的中文含义是： 归档id
	 */
	public void setFileid(String fileid){ 
		this.fileid = fileid;
	}
	/**
	 * @Description fileid的中文含义是： 归档id
	 */
	public String getFileid(){
		return fileid;
	}
	/**
	 * @Description paperuserid的中文含义是： 传阅者id
	 */
	public void setPaperuserid(String paperuserid){ 
		this.paperuserid = paperuserid;
	}
	/**
	 * @Description paperuserid的中文含义是： 传阅者id
	 */
	public String getPaperuserid(){
		return paperuserid;
	}
	/**
	 * @Description paperusername的中文含义是： 传阅者的名字
	 */
	public void setPaperusername(String paperusername){ 
		this.paperusername = paperusername;
	}
	/**
	 * @Description paperusername的中文含义是： 传阅者的名字
	 */
	public String getPaperusername(){
		return paperusername;
	}
	/**
	 * @Description recuserid的中文含义是： 接受者id
	 */
	public void setRecuserid(String recuserid){ 
		this.recuserid = recuserid;
	}
	/**
	 * @Description recuserid的中文含义是： 接受者id
	 */
	public String getRecuserid(){
		return recuserid;
	}
	/**
	 * @Description recusername的中文含义是： 接受者的名字
	 */
	public void setRecusername(String recusername){ 
		this.recusername = recusername;
	}
	/**
	 * @Description recusername的中文含义是： 接受者的名字
	 */
	public String getRecusername(){
		return recusername;
	}
	/**
	 * @Description paperstate的中文含义是： 查看状态  0是未查看   1是查看
	 */
	public void setPaperstate(String paperstate){ 
		this.paperstate = paperstate;
	}
	/**
	 * @Description paperstate的中文含义是： 查看状态  0是未查看   1是查看
	 */
	public String getPaperstate(){
		return paperstate;
	}
	/**
	 * @Description filetitle的中文含义是： 公文标题
	 */
	public void setFiletitle(String filetitle){ 
		this.filetitle = filetitle;
	}
	/**
	 * @Description filetitle的中文含义是： 公文标题
	 */
	public String getFiletitle(){
		return filetitle;
	}

	
}