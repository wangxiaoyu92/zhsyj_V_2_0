package com.zzhdsoft.siweb.dto;

/**
 * 
 * ParamDto的中文名称：通用查询入参DTO
 * 
 * ParamDto的描述：
 * 
 * Written by : zjf
 */

public class ParamDTO {

	/*
	 * 查询类型(sql,proc)
	 */
	private String t;
	/*
	 * 传入的SQL语句
	 */
	private String sql;
	/*
	 * 传入的存储过程参数(Map的json格式)
	 */
	private String param;

	public String getT() {
		return t;
	}

	public void setT(String t) {
		this.t = t;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

}
