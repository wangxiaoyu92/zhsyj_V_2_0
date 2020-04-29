package com.zzhdsoft.siweb.entity.news;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  NEWS 的中文含义是 新闻表
 * @Creation     2014/10/28 10:20:50
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "NEWS")
public class News {
	//扩展开始
	/**
	 * @Description newsfjpath的中文含义是： 新闻附件路径
	 */
	@Column
	@Readonly
	private String newsfjpath;
	//扩展结束
	
	/**
	 * @Description newsid的中文含义是： 新闻ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_newsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_newsid.nextval from dual"))
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

	/**
	 * @Description newsfrom的中文含义是： 新闻来源
	 */
	@Column
	private String newsfrom;

	/**
	 * @Description newstjsj的中文含义是： 添加时间
	 */
	@Column
	private Timestamp newstjsj;

	/**
	 * @Description newsispicture的中文含义是： 是否图片新闻
	 */
	@Column
	private String newsispicture;

	/**
	 * @Description newscontent的中文含义是： 新闻内容
	 */
	@Column
	private String newscontent;

	/**
	 * @Description newssfyx的中文含义是： 是否有效（删除标志）
	 */
	@Column
	private String sfyx;


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
	/**
	 * @Description newsfrom的中文含义是： 新闻来源
	 */
	public void setNewsfrom(String newsfrom){ 
		this.newsfrom = newsfrom;
	}
	/**
	 * @Description newsfrom的中文含义是： 新闻来源
	 */
	public String getNewsfrom(){
		return newsfrom;
	}
	/**
	 * @Description newstjsj的中文含义是： 添加时间
	 */
	public void setNewstjsj(Timestamp newstjsj){ 
		this.newstjsj = newstjsj;
	}
	/**
	 * @Description newstjsj的中文含义是： 添加时间
	 */
	public Timestamp getNewstjsj(){
		return newstjsj;
	}
	/**
	 * @Description newsispicture的中文含义是： 是否图片新闻
	 */
	public void setNewsispicture(String newsispicture){ 
		this.newsispicture = newsispicture;
	}
	/**
	 * @Description newsispicture的中文含义是： 是否图片新闻
	 */
	public String getNewsispicture(){
		return newsispicture;
	}
	/**
	 * @Description newscontent的中文含义是： 新闻内容
	 */
	public void setNewscontent(String newscontent){ 
		this.newscontent = newscontent;
	}
	/**
	 * @Description newscontent的中文含义是： 新闻内容
	 */
	public String getNewscontent(){
		return newscontent;
	}
	/**
	 * @Description newssfyx的中文含义是： 是否有效
	 */
	public void setSfyx(String sfyx){ 
		this.sfyx = sfyx;
	}
	/**
	 * @Description newssfyx的中文含义是： 是否有效
	 */
	public String getSfyx(){
		return sfyx;
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
	public String getNewsfjpath() {
		return newsfjpath;
	}
	public void setNewsfjpath(String newsfjpath) {
		this.newsfjpath = newsfjpath;
	}
	
	
}