package com.zzhdsoft.siweb.dto;

import java.util.List;

/**
 * 
 * ResultDto的中文名称：通用查询返回结果DTO
 * 
 * ResultDto的描述：
 * 
 * Written by : zjf
 */
public class ResultDTO {

	/**
	 * 总条数，此属性值在分页情况下存在
	 */
	private int totalnum = 0;

	/**
	 * 记录数
	 */
	private int recnum = 0;
	/**
	 * 执行结果消息
	 */
	private String msg = "";
	/**
	 * 执行结果代码 0执行成功，其他代码为执行失败的各种情况 100 ...
	 */
	private String code = "";

	/**
	 * 记录集
	 */
	private List result;

	public int getRecnum() {
		return recnum;
	}

	public void setRecnum(int recnum) {
		this.recnum = recnum;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List getResult() {
		return result;
	}

	public void setResult(List result) {
		this.result = result;
	}

	public int getTotalnum() {
		return totalnum;
	}

	public void setTotalnum(int totalnum) {
		this.totalnum = totalnum;
	}

}
