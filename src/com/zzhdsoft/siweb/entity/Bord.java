package com.zzhdsoft.siweb.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Readonly;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

/**
 * @Description  NEWS 的中文含义是 新闻表
 * @Creation     2014/10/28 10:20:50
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "NEWS")
public class Bord {
	/**
	 * @Description sfxsmxflag的中文含义是：是否显示明细标志 2不显示
	 */
	@Column
	@Name
	@Readonly
	private String sfxsmxflag;	
	
	/**
	 * @Description aaa104的中文含义是：企业大类
	 */
	@Column
	@Name
	@Readonly
	private String aaa104;	
	
	/**
	 * @Description newsid的中文含义是： 新闻ID
	 */
	@Column
	@Name
	private String newsid;
	


	/**
	 * @Description cateid的中文含义是： 新闻分类ID
	 */
	@Column
	private String cateid;

	/**
	 * @Description newstitle的中文含义是： 新闻标题
	 */
	@Column
	private String newstitle;

	/**
	 * @Description newsauthor的中文含义是： 新闻编辑人
	 */
	@Column
	private String newsauthor;

	private int currPage;
	private int totalPage;
	private int pageSize;
	private int totalCount;
	/**
	 * 新闻记录数（非映射字段）
	 */
	private String newscount;

	/**
	 * 新闻分类简称（非映射字段）
	 */
	private String catejc;
	
		/**
	 * @Description newsid的中文含义是： 新闻ID
	 */
	public void setNewsid(String newsid){ 
		this.newsid = newsid;
	}
	/**
	 * @Description newsid的中文含义是： 新闻ID
	 */
	public String getNewsid(){
		return newsid;
	}
	/**
	 * @Description cateid的中文含义是： 新闻分类ID
	 */
	public void setCateid(String cateid){ 
		this.cateid = cateid;
	}
	/**
	 * @Description cateid的中文含义是： 新闻分类ID
	 */
	public String getCateid(){
		return cateid;
	}
	/**
	 * @Description newstitle的中文含义是： 新闻标题
	 */
	public void setNewstitle(String newstitle){ 
		this.newstitle = newstitle;
	}
	/**
	 * @Description newstitle的中文含义是： 新闻标题
	 */
	public String getNewstitle(){
		return newstitle;
	}
	/**
	 * @Description newsauthor的中文含义是： 新闻编辑人
	 */
	public void setNewsauthor(String newsauthor){ 
		this.newsauthor = newsauthor;
	}
	/**
	 * @Description newsauthor的中文含义是： 新闻编辑人
	 */
	public String getNewsauthor(){
		return newsauthor;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	public String getNewscount() {
		return newscount;
	}
	public void setNewscount(String newscount) {
		this.newscount = newscount;
	}
	/**
	 * @Description catejc的中文含义是： 新闻分类简称
	 */
	public void setCatejc(String catejc){ 
		this.catejc = catejc;
	}
	/**
	 * @Description catejc的中文含义是： 新闻分类简称
	 */
	public String getCatejc(){
		return catejc;
	}
	public String getAaa104() {
		return aaa104;
	}
	public void setAaa104(String aaa104) {
		this.aaa104 = aaa104;
	}
	public String getSfxsmxflag() {
		return sfxsmxflag;
	}
	public void setSfxsmxflag(String sfxsmxflag) {
		this.sfxsmxflag = sfxsmxflag;
	}
	
	
	
}