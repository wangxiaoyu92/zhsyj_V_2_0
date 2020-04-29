package com.askj.supervision.dto;

import java.util.List;
import java.util.Map;

/**
 * 
 * @author tang
 *
 */
public class CheckGroupDTO {

	
	private String itemname ;
	private List<Map>  list;
	public String getItemname() {
		return itemname;
	}
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	public List<Map> getList() {
		return list;
	}
	public void setList(List<Map> list) {
		this.list = list;
	}
	
	
}
