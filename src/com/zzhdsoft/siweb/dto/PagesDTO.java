package com.zzhdsoft.siweb.dto;

/**
 * 
 * PagesDto的中文名称：分页数据传输对象
 * 
 * PagesDto的描述：
 * 
 * Written by : zjf
 */
public class PagesDTO {

	private int page;
	private int pageSize;
	private int rows;
	private String sort;// 排序字段
	private String order = "asc";// asc/desc

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	@Override
	public String toString() {
		return "PagesDTO [page=" + page + ", rows=" + rows + ", sort=" + sort
				+ ", order=" + order + "]";
	}

}
