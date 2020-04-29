package com.zzhdsoft.siweb.dto.news;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;

/**
 * @Description NEWS的中文含义是: 新闻表
 * @Creation 2015/07/16 15:14:21
 * @Written Create Tool By zjf
 **/
public class NewsDTO {

	/**
	 * @Description cateid的中文含义是： 新闻分类ID
	 */
	private String cateid;

	/**
	 * @Description catename的中文含义是： 新闻分类名称
	 */
	private String catename;

	/**
	 * @Description cateadddate的中文含义是： 新闻分类添加时间
	 */
	private Timestamp cateadddate;

	/**
	 * @Description catejc的中文含义是： 新闻分类简称
	 */
	private String catejc;

	/**
	 * @Description cateparentid的中文含义是： 父类id
	 */
	private String cateparentid;

	/**
	 * @Description catename的中文含义是： 新闻分类级别
	 */
	private String catelevel;

	/**
	 * @Description catesfyxtjxw的中文含义是： 是否允许添加新闻内容(1允许;0不允许)
	 */
	private String catesfyxtjxw;

	/**
	 * @Description cateid的中文含义是： 新闻分类ID
	 */
	public void setCateid(String cateid) {
		this.cateid = cateid;
	}

	/**
	 * @Description cateid的中文含义是： 新闻分类ID
	 */
	public String getCateid() {
		return cateid;
	}

	/**
	 * @Description catename的中文含义是： 新闻分类名称
	 */
	public void setCatename(String catename) {
		this.catename = catename;
	}

	/**
	 * @Description catename的中文含义是： 新闻分类名称
	 */
	public String getCatename() {
		return catename;
	}

	/**
	 * @Description cateadddate的中文含义是： 新闻分类添加时间
	 */
	public void setCateadddate(Timestamp cateadddate) {
		this.cateadddate = cateadddate;
	}

	/**
	 * @Description cateadddate的中文含义是： 新闻分类添加时间
	 */
	public Timestamp getCateadddate() {
		return cateadddate;
	}

	/**
	 * @Description catejc的中文含义是： 新闻分类简称
	 */
	public void setCatejc(String catejc) {
		this.catejc = catejc;
	}

	/**
	 * @Description catejc的中文含义是： 新闻分类简称
	 */
	public String getCatejc() {
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

	/**
	 * @Description newsid的中文含义是 新闻ID
	 */
	private String newsid;

	/**
	 * @Description newstitle的中文含义是 新闻标题
	 */
	private String newstitle;

	/**
	 * @Description newsauthor的中文含义是 新闻编辑人
	 */
	private String newsauthor;

	/**
	 * @Description newsfrom的中文含义是 新闻来源
	 */
	private String newsfrom;

	/**
	 * @Description newstjsj的中文含义是 添加时间
	 */
	private Timestamp newstjsj;

	/**
	 * @Description newsispicture的中文含义是 是否图片新闻
	 */
	private String newsispicture;

	/**
	 * @Description newscontent的中文含义是 新闻内容
	 */
	private String newscontent;

	/**
	 * @Description newssfyx的中文含义是 是否有效（删除标志）
	 */
	private String sfyx;

	/**
	 * @Description newsid的中文含义是 新闻ID
	 */
	public void setNewsid(String newsid) {
		this.newsid = newsid;
	}

	/**
	 * @Description newsid的中文含义是 新闻ID
	 */
	public String getNewsid() {
		return newsid;
	}

	/**
	 * @Description newstitle的中文含义是 新闻标题
	 */
	public void setNewstitle(String newstitle) {
		this.newstitle = newstitle;
	}

	/**
	 * @Description newstitle的中文含义是 新闻标题
	 */
	public String getNewstitle() {
		return newstitle;
	}

	/**
	 * @Description newsauthor的中文含义是 新闻编辑人
	 */
	public void setNewsauthor(String newsauthor) {
		this.newsauthor = newsauthor;
	}

	/**
	 * @Description newsauthor的中文含义是 新闻编辑人
	 */
	public String getNewsauthor() {
		return newsauthor;
	}

	/**
	 * @Description newsfrom的中文含义是 新闻来源
	 */
	public void setNewsfrom(String newsfrom) {
		this.newsfrom = newsfrom;
	}

	/**
	 * @Description newsfrom的中文含义是 新闻来源
	 */
	public String getNewsfrom() {
		return newsfrom;
	}

	/**
	 * @Description newstjsj的中文含义是 添加时间
	 */
	public void setNewstjsj(Timestamp newstjsj) {
		this.newstjsj = newstjsj;
	}

	/**
	 * @Description newstjsj的中文含义是 添加时间
	 */
	public Timestamp getNewstjsj() {
		return newstjsj;
	}

	/**
	 * @Description newsispicture的中文含义是 是否图片新闻
	 */
	public void setNewsispicture(String newsispicture) {
		this.newsispicture = newsispicture;
	}

	/**
	 * @Description newsispicture的中文含义是 是否图片新闻
	 */
	public String getNewsispicture() {
		return newsispicture;
	}

	/**
	 * @Description newscontent的中文含义是 新闻内容
	 */
	public void setNewscontent(String newscontent) {
		this.newscontent = newscontent;
	}

	/**
	 * @Description newscontent的中文含义是 新闻内容
	 */
	public String getNewscontent() {
		return newscontent;
	}

	/**
	 * @Description newssfyx的中文含义是 是否有效
	 */
	public void setSfyx(String sfyx) {
		this.sfyx = sfyx;
	}

	/**
	 * @Description newssfyx的中文含义是 是否有效
	 */
	public String getSfyx() {
		return sfyx;
	}

	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	private Long fjid;

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	private String fjpath;

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	private String fjcontent;

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	private String fjtype;

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	private String fjname;

	/**
	 * @Description fjid的中文含义是： 附件ID
	 */
	public Long getFjid() {
		return fjid;
	}

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
	}

	/**
	 * @Description fjpath的中文含义是： 附件保存路径
	 */
	public String getFjpath() {
		return fjpath;
	}

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public void setFjcontent(String fjcontent) {
		this.fjcontent = fjcontent;
	}

	/**
	 * @Description fjcontent的中文含义是： 附件内容
	 */
	public String getFjcontent() {
		return fjcontent;
	}

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	public void setFjtype(String fjtype) {
		this.fjtype = fjtype;
	}

	/**
	 * @Description fjtype的中文含义是： 附件类型 1图片 2文档
	 */
	public String getFjtype() {
		return fjtype;
	}

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	public void setFjname(String fjname) {
		this.fjname = fjname;
	}

	/**
	 * @Description fjname的中文含义是： 附件名称
	 */
	public String getFjname() {
		return fjname;
	}

	private int currPage;
	private int totalPage;
	private int pageSize;
	private int totalCount;

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

}
