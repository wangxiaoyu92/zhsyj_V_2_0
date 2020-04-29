package com.askj.supervision.entity;

import java.util.Date;
import org.nutz.dao.entity.annotation.*;


/**
 * Omcheckcontent的中文名称：检查内容
 * Written by:syf
 */
@Table(value = "OMCHECKCONTENT")
public class CheckContent {

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
	 * contentimpt 的中文名称：内容重要性
	 */
	 @Column 
	private long contentimpt;

	/**
	 * contentscore 的中文名称：内容评级分值
	 */
	 @Column 
	private double contentscore;

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
	 * Written by:syf
	 */
	public void setContentid(String contentid){
		this.contentid=contentid;
	}

	/**
	 * 
	 * getContentid的中文名称：获取内容ID
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getContentid(){
		return contentid;
	}

	/**
	 * 
	 * setItemid的中文名称：设置项目ID
	 *
	 * @param itemid  项目ID 
	 * Written by:syf
	 */
	public void setItemid(String itemid){
		this.itemid=itemid;
	}

	/**
	 * 
	 * getItemid的中文名称：获取项目ID
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getItemid(){
		return itemid;
	}

	/**
	 * 
	 * setContent的中文名称：设置内容
	 *
	 * @param content  内容 
	 * Written by:syf
	 */
	public void setContent(String content){
		this.content=content;
	}

	/**
	 * 
	 * getContent的中文名称：获取内容
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getContent(){
		return content;
	}

	/**
	 * 
	 * setContentcode的中文名称：设置内容编号
	 *
	 * @param contentcode  内容编号 
	 * Written by:syf
	 */
	public void setContentcode(String contentcode){
		this.contentcode=contentcode;
	}

	/**
	 * 
	 * getContentcode的中文名称：获取内容编号
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getContentcode(){
		return contentcode;
	}

	/**
	 * 
	 * setContentimpt的中文名称：设置内容重要性
	 *
	 * @param contentimpt  内容重要性 
	 * Written by:syf
	 */
	public void setContentimpt(long contentimpt){
		this.contentimpt=contentimpt;
	}

	/**
	 * 
	 * getContentimpt的中文名称：获取内容重要性
	 *
	 * @return long
	 * Written by:syf
	 */
	public long getContentimpt(){
		return contentimpt;
	}

	/**
	 * 
	 * setContentscore的中文名称：设置内容评级分值
	 *
	 * @param contentscore  内容评级分值 
	 * Written by:syf
	 */
	public void setContentscore(double contentscore){
		this.contentscore=contentscore;
	}

	/**
	 * 
	 * getContentscore的中文名称：获取内容评级分值
	 *
	 * @return long
	 * Written by:syf
	 */
	public double getContentscore(){
		return contentscore;
	}

	/**
	 * 
	 * setContentoperatedate的中文名称：设置内容经办日期
	 *
	 * @param contentoperatedate  内容经办日期 
	 * Written by:syf
	 */
	public void setContentoperatedate(Date contentoperatedate){
		this.contentoperatedate=contentoperatedate;
	}

	/**
	 * 
	 * getContentoperatedate的中文名称：获取内容经办日期
	 *
	 * @return Date
	 * Written by:syf
	 */
	public Date getContentoperatedate(){
		return contentoperatedate;
	}

	/**
	 * 
	 * setContentoperateperson的中文名称：设置内容经办人
	 *
	 * @param contentoperateperson  内容经办人 
	 * Written by:syf
	 */
	public void setContentoperateperson(String contentoperateperson){
		this.contentoperateperson=contentoperateperson;
	}

	/**
	 * 
	 * getContentoperateperson的中文名称：获取内容经办人
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getContentoperateperson(){
		return contentoperateperson;
	}

	/**
	 * 
	 * setContentsortid的中文名称：设置内容排序号
	 *
	 * @param contentsortid  内容排序号 
	 * Written by:syf
	 */
	public void setContentsortid(long contentsortid){
		this.contentsortid=contentsortid;
	}

	/**
	 * 
	 * getContentsortid的中文名称：获取内容排序号
	 *
	 * @return long
	 * Written by:syf
	 */
	public long getContentsortid(){
		return contentsortid;
	}

}
