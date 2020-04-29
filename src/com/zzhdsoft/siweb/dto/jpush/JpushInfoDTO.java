package com.zzhdsoft.siweb.dto.jpush;

/**
 * @Description  JPUSHLOG的中文含义是: 处理事件协作日志表DTO
 * @Creation     2016/11/30 14:22:24
 * @Written      Create Tool By zjf 
 **/
public class JpushInfoDTO {

	/**
	 * @Description accertuserid_rows的中文含义是： 接收人ID_组合
	 */
	private String accertuserid_rows;
	
	/**
	 * @Description message的中文含义是： 推送信息内容
	 */
	private String message;

	/**
	 * @Description title的中文含义是： 标题
	 */
	private String title;

	/**
	 * @Description type的中文含义是： 消息类型：0：系统消息；1：个人消息
	 */
	private String type;

	/**
	 * @Description userid的中文含义是：用户ID
	 */
	private String userid;

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
	 * @Description accertuserid_rows的中文含义是： 接收人ID_组合
	 */
	public String getAccertuserid_rows() {
		return accertuserid_rows;
	}
	/**
	 * @Description accertuserid_rows的中文含义是： 接收人ID_组合
	 */
	public void setAccertuserid_rows(String accertuserid_rows) {
		this.accertuserid_rows = accertuserid_rows;
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


	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
}