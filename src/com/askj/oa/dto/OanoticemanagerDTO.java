package com.askj.oa.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class OanoticemanagerDTO {
	/**********************************扩展字段开始*************************************/
	/**
	 * @Description parentoanoticemanagerid的中文含义是：操作员id
	 */
	private String userid;
	/**
	 * @Description parentoanoticemanagerid的中文含义是：通用消息通知主键
	 */
	private String parentoanoticemanagerid;

	/**
	 * @Description description 的中文含义是：操作员汉字名称
	 */
	private String description;

	/**
	 * @Description oataskid 的中文含义是：任务id
	 */
	private String oataskid;

	/**
	 * @Description oameetingid 的中文含义是：会议id
	 */
	private String oameetingid;

	/**
	 * @Description oascheduleid 的中文含义是：日程id
	 */
	private String oascheduleid;


	/**********************************扩展字段结束*************************************/


/** oa通知管理; InnoDB free: 9216 kB  */
	/** oanoticemanagerid 的中文含义是：oa通知管理id*/
	private String oanoticemanagerid;

	/** noticetype 的中文含义是：通知类型aaa100=noticetype*/
	private String noticetype;

	/** othertableid 的中文含义是：其他表主键*/
	private String othertableid;

	/** receivemanid 的中文含义是：接收人id*/
	private String receivemanid;

	/** noticetitle 的中文含义是：通知标题*/
	private String noticetitle;

	/** noticecontent 的中文含义是：通知内容*/
	private String noticecontent;

	/** havereadflag 的中文含义是：已读标志aaa100=shifoubz*/
	private String havereadflag;

	/** sendflag 的中文含义是：发送标志aaa100=shifou*/
	private String sendflag;

	/** sendokflag 的中文含义是：发送成功标志aaa100=shifou*/
	private String sendokflag;

	/** czyid 的中文含义是：操作员id*/
	private String czyid;

	/** czyname 的中文含义是：操作员名称*/
	private String czyname;

	/** aae036 的中文含义是：操作时间*/
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

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getParentoanoticemanagerid() {
		return parentoanoticemanagerid;
	}

	public void setParentoanoticemanagerid(String parentoanoticemanagerid) {
		this.parentoanoticemanagerid = parentoanoticemanagerid;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOataskid() {
		return oataskid;
	}

	public void setOataskid(String oataskid) {
		this.oataskid = oataskid;
	}

	public String getOameetingid() {
		return oameetingid;
	}

	public void setOameetingid(String oameetingid) {
		this.oameetingid = oameetingid;
	}

	public String getOascheduleid() {
		return oascheduleid;
	}

	public void setOascheduleid(String oascheduleid) {
		this.oascheduleid = oascheduleid;
	}
}

