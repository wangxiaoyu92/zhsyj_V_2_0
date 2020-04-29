package com.askj.train.dto;

import java.sql.Timestamp;

public class OtsHomeworkDTO {
/** 作业信息表  */
	/** homework_id 的中文含义是：作业ID*/
	private String homeworkId;

	/** title 的中文含义是：作业名称*/
	private String title;

	/** type 的中文含义是：1-附件，2-问答*/
	private Integer type;

	/** content 的中文含义是：作业内容*/
	private String content;

	/** doc_id 的中文含义是：附件id*/
	private Integer docId;

	/** score 的中文含义是：满分*/
	private Integer score;

	/** pass 的中文含义是：及格*/
	private Integer pass;

	/** aae011 的中文含义是：经办人*/
	private String aae011;

	/** aae036 的中文含义是：经办时间*/
	private Timestamp aae036;


	public void setHomeworkId(String homeworkId){
		this.homeworkId=homeworkId;
	}

	public String getHomeworkId(){
		return homeworkId;
	}

	public void setTitle(String title){
		this.title=title;
	}

	public String getTitle(){
		return title;
	}

	public void setType(Integer type){
		this.type=type;
	}

	public Integer getType(){
		return type;
	}

	public void setContent(String content){
		this.content=content;
	}

	public String getContent(){
		return content;
	}

	public void setDocId(Integer docId){
		this.docId=docId;
	}

	public Integer getDocId(){
		return docId;
	}

	public void setScore(Integer score){
		this.score=score;
	}

	public Integer getScore(){
		return score;
	}

	public void setPass(Integer pass){
		this.pass=pass;
	}

	public Integer getPass(){
		return pass;
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

