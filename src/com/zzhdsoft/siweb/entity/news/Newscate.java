package com.zzhdsoft.siweb.entity.news;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  NEWSCATE 的中文含义是 新闻分类表
 * @Creation     2014/10/27 18:30:12
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "NEWSCATE")
public class Newscate {
	//子节点数量,非映射字段
	@Column
	@Readonly
	private int childnum;
	//是否父节点,非映射字段
	@Column
	@Readonly
	private boolean isparent;
	//是否展开,非映射字段
	@Column
	@Readonly
	private boolean isopen;
	
	/**
	 * @Description cateid的中文含义是： 新闻分类ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cateid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_cateid.nextval from dual"))
	private String cateid;

	/**
	 * @Description catename的中文含义是： 新闻分类名称
	 */
	@Column
	private String catename;

	/**
	 * @Description cateadddate的中文含义是： 新闻分类添加时间
	 */
	@Column
	private Timestamp cateadddate;

	/**
	 * @Description catejc的中文含义是： 新闻分类简称
	 */
	@Column
	private String catejc;

	/**
	 * @Description cateparentid的中文含义是： 父类id
	 */
	@Column
	private String cateparentid;
	
	/**
	 * @Description catename的中文含义是： 新闻分类级别
	 */
	@Column
	private String catelevel;
	
	/**
	 * @Description catesfyxtjxw的中文含义是： 是否允许添加新闻内容(1允许;0不允许)
	 */
	@Column
	private String catesfyxtjxw;
	
	public int getChildnum() {
		return childnum;
	}
	public void setChildnum(int childnum) {
		this.childnum = childnum;
	}
	
	public boolean getIsparent() {
		return isparent;
	}
	public void setIsparent(boolean isparent) {
		this.isparent = isparent;
	}
	public boolean getIsopen() {
		return isopen;
	}
	public void setIsopen(boolean isopen) {
		this.isopen = isopen;
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
	 * @Description catename的中文含义是： 新闻分类名称
	 */
	public void setCatename(String catename){ 
		this.catename = catename;
	}
	/**
	 * @Description catename的中文含义是： 新闻分类名称
	 */
	public String getCatename(){
		return catename;
	}
	/**
	 * @Description cateadddate的中文含义是： 新闻分类添加时间
	 */
	public void setCateadddate(Timestamp cateadddate){ 
		this.cateadddate = cateadddate;
	}
	/**
	 * @Description cateadddate的中文含义是： 新闻分类添加时间
	 */
	public Timestamp getCateadddate(){
		return cateadddate;
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
	/**
	 * @Description cateparentid的中文含义是： 父类id
	 */
	public String getCateparentid() {
		return cateparentid;
	}
	/**
	 * @Description cateparentid的中文含义是： 父类id
	 */
	public void setCateparentid(String cateparentid) {
		this.cateparentid = cateparentid;
	}
	/**
	 * @Description catename的中文含义是： 新闻分类级别
	 */
	public String getCatelevel() {
		return catelevel;
	}
	/**
	 * @Description catename的中文含义是： 新闻分类级别
	 */
	public void setCatelevel(String catelevel) {
		this.catelevel = catelevel;
	}
	/**
	 * @Description catesfyxtjxw的中文含义是： 是否允许添加新闻内容(1允许;0不允许)
	 */
	public String getCatesfyxtjxw() {
		return catesfyxtjxw;
	}
	/**
	 * @Description catesfyxtjxw的中文含义是： 是否允许添加新闻内容(1允许;0不允许)
	 */
	public void setCatesfyxtjxw(String catesfyxtjxw) {
		this.catesfyxtjxw = catesfyxtjxw;
	}

	
}