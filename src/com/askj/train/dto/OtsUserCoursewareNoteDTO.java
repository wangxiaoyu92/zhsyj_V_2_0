package com.askj.train.dto;

import java.sql.Timestamp;

public class OtsUserCoursewareNoteDTO {
/** 用户课程笔记  */
	/** note_id 的中文含义是：课程笔记ID*/
	private String noteId;

	/** ware_id 的中文含义是：课件ID*/
	private String wareId;

	/** content 的中文含义是：课程笔记内容*/
	private String content;

	/** aae011 的中文含义是：经办人*/
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	private Timestamp aae036;


	public void setNoteId(String noteId){
		this.noteId=noteId;
	}

	public String getNoteId(){
		return noteId;
	}

	public void setWareId(String wareId){
		this.wareId=wareId;
	}

	public String getWareId(){
		return wareId;
	}

	public void setContent(String content){
		this.content=content;
	}

	public String getContent(){
		return content;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(Timestamp aae036){
		this.aae036=aae036;
	}

	public Timestamp getAae036(){
		return aae036;
	}

}

