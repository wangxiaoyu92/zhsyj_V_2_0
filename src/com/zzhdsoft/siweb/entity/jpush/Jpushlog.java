package com.zzhdsoft.siweb.entity.jpush;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  JPUSHLOG的中文含义是: 处理事件协作日志表
 * @Creation     2016/11/30 14:22:53
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JPUSHLOG")
public class Jpushlog {
	/**
	 * @Description logid的中文含义是： 日志ID
	 */
	@Column
	@Name
	private String logid;

	/**
	 * @Description accertuserid的中文含义是： 接收人ID
	 */
	@Column
	private String accertuserid;

	/**
	 * @Description message的中文含义是： 推送信息内容
	 */
	@Column
	private String message;

	/**
	 * @Description title的中文含义是： 标题
	 */
	@Column
	private String title;

	/**
	 * @Description senduserid的中文含义是： 推送人id
	 */
	@Column
	private String senduserid;

	/**
	 * @Description sendtime的中文含义是： 推送时间
	 */
	@Column
	private String sendtime;

	/**
	 * @Description type的中文含义是： 消息类型：0：系统消息；1：个人消息
	 */
	@Column
	private String type;
	
	/**
	 * @Description logid的中文含义是： 日志ID
	 */
	public void setLogid(String logid){ 
		this.logid = logid;
	}
	/**
	 * @Description logid的中文含义是： 日志ID
	 */
	public String getLogid(){
		return logid;
	}
	/**
	 * @Description accertuserid的中文含义是： 接收人ID
	 */
	public void setAccertuserid(String accertuserid){ 
		this.accertuserid = accertuserid;
	}
	/**
	 * @Description accertuserid的中文含义是： 接收人ID
	 */
	public String getAccertuserid(){
		return accertuserid;
	}
	/**
	 * @Description message的中文含义是： 推送信息内容
	 */
	public void setMessage(String message){ 
		this.message = message;
	}
	/**
	 * @Description message的中文含义是： 推送信息内容
	 */
	public String getMessage(){
		return message;
	}
	/**
	 * @Description title的中文含义是： 标题
	 */
	public void setTitle(String title){ 
		this.title = title;
	}
	/**
	 * @Description title的中文含义是： 标题
	 */
	public String getTitle(){
		return title;
	}
	/**
	 * @Description senduserid的中文含义是： 推送人id
	 */
	public void setSenduserid(String senduserid){ 
		this.senduserid = senduserid;
	}
	/**
	 * @Description senduserid的中文含义是： 推送人id
	 */
	public String getSenduserid(){
		return senduserid;
	}
	/**
	 * @Description sendtime的中文含义是： 推送时间
	 */
	public void setSendtime(String sendtime){ 
		this.sendtime = sendtime;
	}
	/**
	 * @Description sendtime的中文含义是： 推送时间
	 */
	public String getSendtime(){
		return sendtime;
	}
	/**
	 * @Description type的中文含义是： 消息类型：0：系统消息；1：个人消息
	 */
	public String getType() {
		return type;
	}
	/**
	 * @Description type的中文含义是： 消息类型：0：系统消息；1：个人消息
	 */
	public void setType(String type) {
		this.type = type;
	}
	
	

	
}