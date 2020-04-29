package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.util.Date;

/**
 *
 *  OmLawContent的中文名称：法律法规内容表
 *
 *  @author : zy
 */
@Table(value = "omlawcontent")
public class OmLawContent {

	/**
	 * contentid 的中文名称：内容ID
	 */
	 @Column 
	 @Name
	private String contentid;

	/**
	 * itemid 的中文名称：项目ID
	 */
	 @Column 
	private String itemid;

	/**
	 * content 的中文名称：内容
	 */
	 @Column 
	private String content;

	/**
	 * contentcode 的中文名称：内容编号
	 */
	 @Column 
	private String contentcode;

	/**
	 * contentoperatedate 的中文名称：内容经办日期
	 */
	 @Column 
	private Date contentoperatedate;

	/**
	 * contentoperateperson 的中文名称：内容经办人
	 */
	 @Column 
	private String contentoperateperson;

	/**
	 * contentsortid 的中文名称：内容排序号
	 */
	 @Column 
	private long contentsortid;


	/**
	 * 
	 * setContentid的中文名称：设置内容ID
	 *
	 * @param contentid  内容ID 
	 */
	public void setContentid(String contentid){
		this.contentid=contentid;
	}

	/**
	 * 
	 * getContentid的中文名称：获取内容ID
	 *
	 * @return String
	 */
	public String getContentid(){
		return contentid;
	}

	/**
	 * 
	 * setItemid的中文名称：设置项目ID
	 *
	 * @param itemid  项目ID 
	 */
	public void setItemid(String itemid){
		this.itemid=itemid;
	}

	/**
	 * 
	 * getItemid的中文名称：获取项目ID
	 *
	 * @return String
	 */
	public String getItemid(){
		return itemid;
	}

	/**
	 * 
	 * setContent的中文名称：设置内容
	 *
	 * @param content  内容 
	 */
	public void setContent(String content){
		this.content=content;
	}

	/**
	 * 
	 * getContent的中文名称：获取内容
	 *
	 * @return String
	 */
	public String getContent(){
		return content;
	}

	/**
	 * 
	 * setContentcode的中文名称：设置内容编号
	 *
	 * @param contentcode  内容编号 
	 */
	public void setContentcode(String contentcode){
		this.contentcode=contentcode;
	}

	/**
	 * 
	 * getContentcode的中文名称：获取内容编号
	 *
	 * @return String
	 */
	public String getContentcode(){
		return contentcode;
	}

	/**
	 * 
	 * setContentoperatedate的中文名称：设置内容经办日期
	 *
	 * @param contentoperatedate  内容经办日期 
	 */
	public void setContentoperatedate(Date contentoperatedate){
		this.contentoperatedate=contentoperatedate;
	}

	/**
	 * 
	 * getContentoperatedate的中文名称：获取内容经办日期
	 *
	 * @return Date
	 */
	public Date getContentoperatedate(){
		return contentoperatedate;
	}

	/**
	 * 
	 * setContentoperateperson的中文名称：设置内容经办人
	 *
	 * @param contentoperateperson  内容经办人 
	 */
	public void setContentoperateperson(String contentoperateperson){
		this.contentoperateperson=contentoperateperson;
	}

	/**
	 * 
	 * getContentoperateperson的中文名称：获取内容经办人
	 *
	 * @return String
	 */
	public String getContentoperateperson(){
		return contentoperateperson;
	}

	/**
	 * 
	 * setContentsortid的中文名称：设置内容排序号
	 *
	 * @param contentsortid  内容排序号 
	 */
	public void setContentsortid(long contentsortid){
		this.contentsortid=contentsortid;
	}

	/**
	 * 
	 * getContentsortid的中文名称：获取内容排序号
	 *
	 * @return long
	 */
	public long getContentsortid(){
		return contentsortid;
	}

}
