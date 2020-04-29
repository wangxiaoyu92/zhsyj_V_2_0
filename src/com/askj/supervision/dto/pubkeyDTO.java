package com.askj.supervision.dto;
/**
 * 
 * 
 *pubkeyDTO中文名称：键值对DTO
 *pubkeyDTO概要描述：键值对DTO
 * 2016-6-20
 * written by : lfy
 */
public class pubkeyDTO {
	//名字
	private String name ;
	//值
	private String value ;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	private String sqjctjstdate;
	private String sqjctjeddate;

	public String getSqjctjstdate() {
		return sqjctjstdate;
	}

	public void setSqjctjstdate(String sqjctjstdate) {
		this.sqjctjstdate = sqjctjstdate;
	}

	public String getSqjctjeddate() {
		return sqjctjeddate;
	}

	public void setSqjctjeddate(String sqjctjeddate) {
		this.sqjctjeddate = sqjctjeddate;
	}
}
