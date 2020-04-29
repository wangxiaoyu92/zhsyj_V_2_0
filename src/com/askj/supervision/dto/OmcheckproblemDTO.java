package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;


public class OmcheckproblemDTO {
/** 检查依据问题表; InnoDB free: 6144 kB  */
	/** problemid 的中文含义是：主键*/

	private String problemid;

	/** problemdesc 的中文含义是：问题描述*/

	private String problemdesc;

	/** selected 的中文含义是：是否选中*/

	private String selected;


	public void setProblemid(String problemid){
		this.problemid=problemid;
	}

	public String getProblemid(){
		return problemid;
	}

	public void setProblemdesc(String problemdesc){
		this.problemdesc=problemdesc;
	}

	public String getProblemdesc(){
		return problemdesc;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}
}

