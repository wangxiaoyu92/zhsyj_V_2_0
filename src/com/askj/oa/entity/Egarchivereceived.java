package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  EGARCHIVERECEIVED的中文含义是: 电子政务--收文信息表; InnoDB free: 2725888 kB
 * @Creation     2016/06/27 11:00:10
 * @Written      Create Tool By zjf 
 **/
@Table(value = "EGARCHIVERECEIVED")
public class Egarchivereceived {
	/**
	 * @Description rcarchiveid的中文含义是： 收文id
	 */
	@Column
	@Name
	private String rcarchiveid;

	/**
	 * @Description rcarchivecode的中文含义是： 收文编号
	 */
	@Column
	private String rcarchivecode;

	/**
	 * @Description rcarchivetitle的中文含义是： 收文标题
	 */
	@Column
	private String rcarchivetitle;

	/**
	 * @Description rcarchivekey的中文含义是： 收文关键词
	 */
	@Column
	private String rcarchivekey;

	/**
	 * @Description rcarchivecontent的中文含义是： 收文正文
	 */
	@Column
	private String rcarchivecontent;

	/**
	 * @Description rcarchiveremark的中文含义是： 收文备注
	 */
	@Column
	private String rcarchiveremark;

	/**
	 * @Description rcarchivestate的中文含义是： 收文状态 0:添加 1:归档
	 */
	@Column
	private String rcarchivestate;

	/**
	 * @Description rcarchiveopperuser的中文含义是： 操作人
	 */
	@Column
	private String rcarchiveopperuser;

	/**
	 * @Description rcarchiveopperdate的中文含义是： 操作日期
	 */
	@Column
	private String rcarchiveopperdate;

	/**
	 * @Description rcarchiveopperuserid的中文含义是： 
	 */
	@Column
	private String rcarchiveopperuserid;

	/**
	 * @Description rcarchiveuserid的中文含义是：收文人ID
	 */
	@Column
	private String rcarchiveuserid;

	/**
	 * @Description rcarchiveusername的中文含义是：收文人姓名
	 */
	@Column
	private String rcarchiveusername;

	/**
	 * @Description archiveid的中文含义是：公文ID
	 */
	@Column
	private String archiveid;

	
		/**
	 * @Description rcarchiveid的中文含义是： 收文id
	 */
	public void setRcarchiveid(String rcarchiveid){ 
		this.rcarchiveid = rcarchiveid;
	}
	/**
	 * @Description rcarchiveid的中文含义是： 收文id
	 */
	public String getRcarchiveid(){
		return rcarchiveid;
	}
	/**
	 * @Description rcarchivecode的中文含义是： 收文编号
	 */
	public void setRcarchivecode(String rcarchivecode){ 
		this.rcarchivecode = rcarchivecode;
	}
	/**
	 * @Description rcarchivecode的中文含义是： 收文编号
	 */
	public String getRcarchivecode(){
		return rcarchivecode;
	}
	/**
	 * @Description rcarchivetitle的中文含义是： 收文标题
	 */
	public void setRcarchivetitle(String rcarchivetitle){ 
		this.rcarchivetitle = rcarchivetitle;
	}
	/**
	 * @Description rcarchivetitle的中文含义是： 收文标题
	 */
	public String getRcarchivetitle(){
		return rcarchivetitle;
	}
	/**
	 * @Description rcarchivekey的中文含义是： 收文关键词
	 */
	public void setRcarchivekey(String rcarchivekey){ 
		this.rcarchivekey = rcarchivekey;
	}
	/**
	 * @Description rcarchivekey的中文含义是： 收文关键词
	 */
	public String getRcarchivekey(){
		return rcarchivekey;
	}
	/**
	 * @Description rcarchivecontent的中文含义是： 收文正文
	 */
	public void setRcarchivecontent(String rcarchivecontent){ 
		this.rcarchivecontent = rcarchivecontent;
	}
	/**
	 * @Description rcarchivecontent的中文含义是： 收文正文
	 */
	public String getRcarchivecontent(){
		return rcarchivecontent;
	}
	/**
	 * @Description rcarchiveremark的中文含义是： 收文备注
	 */
	public void setRcarchiveremark(String rcarchiveremark){ 
		this.rcarchiveremark = rcarchiveremark;
	}
	/**
	 * @Description rcarchiveremark的中文含义是： 收文备注
	 */
	public String getRcarchiveremark(){
		return rcarchiveremark;
	}
	/**
	 * @Description rcarchivestate的中文含义是： 收文状态 0:添加 1:归档
	 */
	public void setRcarchivestate(String rcarchivestate){ 
		this.rcarchivestate = rcarchivestate;
	}
	/**
	 * @Description rcarchivestate的中文含义是： 收文状态 0:添加 1:归档
	 */
	public String getRcarchivestate(){
		return rcarchivestate;
	}
	/**
	 * @Description rcarchiveopperuser的中文含义是： 操作人
	 */
	public void setRcarchiveopperuser(String rcarchiveopperuser){ 
		this.rcarchiveopperuser = rcarchiveopperuser;
	}
	/**
	 * @Description rcarchiveopperuser的中文含义是： 操作人
	 */
	public String getRcarchiveopperuser(){
		return rcarchiveopperuser;
	}
	/**
	 * @Description rcarchiveopperdate的中文含义是： 操作日期
	 */
	public void setRcarchiveopperdate(String rcarchiveopperdate){ 
		this.rcarchiveopperdate = rcarchiveopperdate;
	}
	/**
	 * @Description rcarchiveopperdate的中文含义是： 操作日期
	 */
	public String getRcarchiveopperdate(){
		return rcarchiveopperdate;
	}
	/**
	 * @Description rcarchiveopperuserid的中文含义是： 
	 */
	public void setRcarchiveopperuserid(String rcarchiveopperuserid){ 
		this.rcarchiveopperuserid = rcarchiveopperuserid;
	}
	/**
	 * @Description rcarchiveopperuserid的中文含义是： 
	 */
	public String getRcarchiveopperuserid(){
		return rcarchiveopperuserid;
	}

	public String getRcarchiveuserid() {
		return rcarchiveuserid;
	}

	public void setRcarchiveuserid(String rcarchiveuserid) {
		this.rcarchiveuserid = rcarchiveuserid;
	}

	public String getRcarchiveusername() {
		return rcarchiveusername;
	}

	public void setRcarchiveusername(String rcarchiveusername) {
		this.rcarchiveusername = rcarchiveusername;
	}

	public String getArchiveid() {
		return archiveid;
	}

	public void setArchiveid(String archiveid) {
		this.archiveid = archiveid;
	}
}