package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Oanoticemanager")
public class Oanoticemanager {
/** oa通知管理; InnoDB free: 9216 kB  */
	/** oanoticemanagerid 的中文含义是：oa通知管理id*/
	@Name
	@Column
	private String oanoticemanagerid;

	/** noticetype 的中文含义是：通知类型aaa100=noticetype*/
	@Column
	private String noticetype;

	/** othertableid 的中文含义是：其他表主键*/
	@Column
	private String othertableid;

	/** receivemanid 的中文含义是：接收人id*/
	@Column
	private String receivemanid;

	/** noticetitle 的中文含义是：通知标题*/
	@Column
	private String noticetitle;

	/** noticecontent 的中文含义是：通知内容*/
	@Column
	private String noticecontent;

	/** havereadflag 的中文含义是：已读标志aaa100=shifoubz*/
	@Column
	private String havereadflag;

	/** sendflag 的中文含义是：发送标志aaa100=shifou*/
	@Column
	private String sendflag;

	/** sendokflag 的中文含义是：发送成功标志aaa100=shifou*/
	@Column
	private String sendokflag;

	/** czyid 的中文含义是：操作员id*/
	@Column
	private String czyid;

	/** czyname 的中文含义是：操作员名称*/
	@Column
	private String czyname;

	/** aae036 的中文含义是：操作时间*/
	@Column
	private String aae036;


	public void setOanoticemanagerid(String oanoticemanagerid){
		this.oanoticemanagerid=oanoticemanagerid;
	}

	public String getOanoticemanagerid(){
		return oanoticemanagerid;
	}

	public void setNoticetype(String noticetype){
		this.noticetype=noticetype;
	}

	public String getNoticetype(){
		return noticetype;
	}

	public void setOthertableid(String othertableid){
		this.othertableid=othertableid;
	}

	public String getOthertableid(){
		return othertableid;
	}

	public void setReceivemanid(String receivemanid){
		this.receivemanid=receivemanid;
	}

	public String getReceivemanid(){
		return receivemanid;
	}

	public void setNoticecontent(String noticecontent){
		this.noticecontent=noticecontent;
	}

	public String getNoticecontent(){
		return noticecontent;
	}

	public void setHavereadflag(String havereadflag){
		this.havereadflag=havereadflag;
	}

	public String getHavereadflag(){
		return havereadflag;
	}

	public void setSendflag(String sendflag){
		this.sendflag=sendflag;
	}

	public String getSendflag(){
		return sendflag;
	}

	public void setSendokflag(String sendokflag){
		this.sendokflag=sendokflag;
	}

	public String getSendokflag(){
		return sendokflag;
	}

	public void setCzyid(String czyid){
		this.czyid=czyid;
	}

	public String getCzyid(){
		return czyid;
	}

	public void setCzyname(String czyname){
		this.czyname=czyname;
	}

	public String getCzyname(){
		return czyname;
	}

	public void setAae036(String aae036){
		this.aae036=aae036;
	}

	public String getAae036(){
		return aae036;
	}

	public String getNoticetitle() {
		return noticetitle;
	}

	public void setNoticetitle(String noticetitle) {
		this.noticetitle = noticetitle;
	}
}

