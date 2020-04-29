package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  EGARCHIVEFILE的中文含义是: 电子政务--归档信息表; InnoDB free: 2725888 kB
 * @Creation     2016/06/27 11:00:03
 * @Written      Create Tool By zjf 
 **/
@Table(value = "EGARCHIVEFILE")
public class Egarchivefile {
	/**
	 * @Description fileid的中文含义是： 归档id
	 */
	@Column
	@Name
	private String fileid;

	/**
	 * @Description filecode的中文含义是： 归档编号
	 */
	@Column
	private String filecode;

	/**
	 * @Description filetitle的中文含义是： 归档标题
	 */
	@Column
	private String filetitle;

	/**
	 * @Description filekey的中文含义是： 归档关键词
	 */
	@Column
	private String filekey;

	/**
	 * @Description filecontent的中文含义是： 归档正文
	 */
	@Column
	private String filecontent;

	/**
	 * @Description fileremark的中文含义是： 归档备注
	 */
	@Column
	private String fileremark;

	/**
	 * @Description filestate的中文含义是： 归档状态 0:添加 1:归档
	 */
	@Column
	private String filestate;

	/**
	 * @Description fileopperuser的中文含义是： 操作人
	 */
	@Column
	private String fileopperuser;

	/**
	 * @Description fileopperdate的中文含义是： 操作日期
	 */
	@Column
	private String fileopperdate;

	/**
	 * @Description fileopperuserid的中文含义是： 
	 */
	@Column
	private String fileopperuserid;

	
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
	 * @Description filecode的中文含义是： 归档编号
	 */
	public void setFilecode(String filecode){ 
		this.filecode = filecode;
	}
	/**
	 * @Description filecode的中文含义是： 归档编号
	 */
	public String getFilecode(){
		return filecode;
	}
	/**
	 * @Description filetitle的中文含义是： 归档标题
	 */
	public void setFiletitle(String filetitle){ 
		this.filetitle = filetitle;
	}
	/**
	 * @Description filetitle的中文含义是： 归档标题
	 */
	public String getFiletitle(){
		return filetitle;
	}
	/**
	 * @Description filekey的中文含义是： 归档关键词
	 */
	public void setFilekey(String filekey){ 
		this.filekey = filekey;
	}
	/**
	 * @Description filekey的中文含义是： 归档关键词
	 */
	public String getFilekey(){
		return filekey;
	}
	/**
	 * @Description filecontent的中文含义是： 归档正文
	 */
	public void setFilecontent(String filecontent){ 
		this.filecontent = filecontent;
	}
	/**
	 * @Description filecontent的中文含义是： 归档正文
	 */
	public String getFilecontent(){
		return filecontent;
	}
	/**
	 * @Description fileremark的中文含义是： 归档备注
	 */
	public void setFileremark(String fileremark){ 
		this.fileremark = fileremark;
	}
	/**
	 * @Description fileremark的中文含义是： 归档备注
	 */
	public String getFileremark(){
		return fileremark;
	}
	/**
	 * @Description filestate的中文含义是： 归档状态 0:添加 1:归档
	 */
	public void setFilestate(String filestate){ 
		this.filestate = filestate;
	}
	/**
	 * @Description filestate的中文含义是： 归档状态 0:添加 1:归档
	 */
	public String getFilestate(){
		return filestate;
	}
	/**
	 * @Description fileopperuser的中文含义是： 操作人
	 */
	public void setFileopperuser(String fileopperuser){ 
		this.fileopperuser = fileopperuser;
	}
	/**
	 * @Description fileopperuser的中文含义是： 操作人
	 */
	public String getFileopperuser(){
		return fileopperuser;
	}
	/**
	 * @Description fileopperdate的中文含义是： 操作日期
	 */
	public void setFileopperdate(String fileopperdate){ 
		this.fileopperdate = fileopperdate;
	}
	/**
	 * @Description fileopperdate的中文含义是： 操作日期
	 */
	public String getFileopperdate(){
		return fileopperdate;
	}
	/**
	 * @Description fileopperuserid的中文含义是： 
	 */
	public void setFileopperuserid(String fileopperuserid){ 
		this.fileopperuserid = fileopperuserid;
	}
	/**
	 * @Description fileopperuserid的中文含义是： 
	 */
	public String getFileopperuserid(){
		return fileopperuserid;
	}

	
}