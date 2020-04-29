package com.zzhdsoft.siweb.dto.sysmanager;

import java.sql.Date;
import java.sql.Timestamp;

public class SysuserhuanxinfriendDTO {
/** 操作员环信好友表; InnoDB free: 10240 kB  */
	/** sysuserhuanxinfriendid 的中文含义是：操作员环信好友表id*/
	private String sysuserhuanxinfriendid;

	/** userid 的中文含义是：用户id*/
	private String userid;

	/** frienduserid 的中文含义是：好友id*/
	private String frienduserid;

	/** czyname 的中文含义是：操作员*/
	private String czyname;

	/** czsj 的中文含义是：操作时间*/
	private Timestamp czsj;


	public void setSysuserhuanxinfriendid(String sysuserhuanxinfriendid){
		this.sysuserhuanxinfriendid=sysuserhuanxinfriendid;
	}

	public String getSysuserhuanxinfriendid(){
		return sysuserhuanxinfriendid;
	}

	public void setUserid(String userid){
		this.userid=userid;
	}

	public String getUserid(){
		return userid;
	}

	public void setFrienduserid(String frienduserid){
		this.frienduserid=frienduserid;
	}

	public String getFrienduserid(){
		return frienduserid;
	}

	public void setCzyname(String czyname){
		this.czyname=czyname;
	}

	public String getCzyname(){
		return czyname;
	}

	public void setCzsj(Timestamp czsj){
		this.czsj=czsj;
	}

	public Timestamp getCzsj(){
		return czsj;
	}

}

