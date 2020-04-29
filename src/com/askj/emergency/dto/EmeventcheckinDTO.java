package com.askj.emergency.dto;

import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Readonly;

/**
 * @Description EMEVENTCHECKIN的中文含义是: 突发事件登记表; InnoDB free: 2731008 kBDTO
 * @Creation 2016/05/25 15:58:04
 * @Written Create Tool By zjf
 **/
public class EmeventcheckinDTO {
	//扩展开始
	/**
	 * usergridstr 批量选择的
	 */
	private String usergridstr;

	/**
	 * @Description jpushmingling的中文含义是：极光推送命令
	 */
	private String jpushmingling;
	/**
	 * @Description jpushtitle的中文含义是：极光推送命令
	 */
	private String jpushtitle;
	/**
	 * @Description jpushcontent的中文含义是：极光推送命令
	 */
	private String jpushcontent;


	/**
	 * @Description onerowflag的中文含义是： 单条标志
	 */
	private String onerowflag;
	/**
	 * @Description eventstateaaa103的中文含义是： 事件处理状态汉字描述
	 */
	private String eventstateaaa103;
	/**
	 * @Description eventlevelaaa103的中文含义是： 事件等级汉字描述
	 */
	private String eventlevelaaa103;
	/**
	 * @Description aaa027aaa103的中文含义是：统筹区编码汉字描述
	 */
	private String aaa027aaa103;

	//扩展结束
	/**
	 * @Description eventid的中文含义是： 事件ID
	 */
	private String eventid;

	/**
	 * @Description newsid的中文含义是： 备案信息ID
	 */
	private String newsid;

	/**
	 * @Description texts： 聊天信息
	 */
	private String texts;

	/**
	 * @Description newsinitiator的中文含义是： 事件上报人
	 */
	private String newsinitiator;

	/**
	 * @Description eventaddress的中文含义是： 事件发生地点
	 */
	private String eventaddress;

	/**
	 * @Description eventwdzb的中文含义是： 事件发生地经度坐标
	 */
	private String eventjdzb;

	/**
	 * @Description eventwdzb的中文含义是： 事件发生地纬度坐标
	 */
	private String eventwdzb;

	/**
	 * @Description eventfinder的中文含义是： 事件上报人联系方式
	 */
	private String eventfinder;

	/**
	 * @Description eventdate的中文含义是： 事件发生时间
	 */
	private String eventdate;

	/**
	 * @Description eventcontent的中文含义是： 事件内容
	 */
	private String eventcontent;

	/**
	 * @Description eventlevel的中文含义是： 事件等级
	 */
	private String eventlevel;

	/**
	 * @Description remark的中文含义是： 备注
	 */
	private String remark;

	/**
	 * @Description eventstate的中文含义是： 事件处理状态
	 */
	private String eventstate;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	private String aaa027;
	/**
	 * @Description orgname的中文含义是： 统筹区名称
	 */
	private String aaa027name;

	/**
	 * @Description operateperson的中文含义是： 经办人
	 */
	private String operateperson;

	/**
	 * @Description operatedate的中文含义是： 经办时间
	 */
	private String operatedate;

	/**
	 * @Description eventid的中文含义是： 事件ID
	 */
	public void setEventid(String eventid) {
		this.eventid = eventid;
	}

	/**
	 * @Description eventid的中文含义是： 事件ID
	 */
	public String getEventid() {
		return eventid;
	}

	/**
	 * @Description newsid的中文含义是： 备案信息ID
	 */
	public void setNewsid(String newsid) {
		this.newsid = newsid;
	}

	/**
	 * @Description newsid的中文含义是： 备案信息ID
	 */
	public String getNewsid() {
		return newsid;
	}

	/**
	 * @Description newsinitiator的中文含义是： 事件上报人
	 */
	public void setNewsinitiator(String newsinitiator) {
		this.newsinitiator = newsinitiator;
	}

	/**
	 * @Description newsinitiator的中文含义是： 事件上报人
	 */
	public String getNewsinitiator() {
		return newsinitiator;
	}

	/**
	 * @Description eventaddress的中文含义是： 事件发生地点
	 */
	public void setEventaddress(String eventaddress) {
		this.eventaddress = eventaddress;
	}

	/**
	 * @Description eventaddress的中文含义是： 事件发生地点
	 */
	public String getEventaddress() {
		return eventaddress;
	}

	/**
	 * @Description eventjdzb的中文含义是： 事件发生地经度坐标
	 */
	public void setEventjdzb(String eventjdzb) {
		this.eventjdzb = eventjdzb;
	}

	/**
	 * @Description eventlevel的中文含义是： 事件发生地经度坐标
	 */
	public String getEventjdzb() {
		return eventjdzb;
	}

	/**
	 * @Description eventwdzb的中文含义是： 事件发生地纬度坐标
	 */
	public void setEventwdzb(String eventwdzb) {
		this.eventwdzb = eventwdzb;
	}

	/**
	 * @Description eventlevel的中文含义是： 事件发生地纬度坐标
	 */
	public String getEventwdzb() {
		return eventwdzb;
	}

	/**
	 * @Description eventfinder的中文含义是： 事件上报人联系方式
	 */
	public void setEventfinder(String eventfinder) {
		this.eventfinder = eventfinder;
	}

	/**
	 * @Description eventfinder的中文含义是： 事件上报人联系方式
	 */
	public String getEventfinder() {
		return eventfinder;
	}

	/**
	 * @Description eventdate的中文含义是： 事件发生时间
	 */
	public void setEventdate(String eventdate) {
		this.eventdate = eventdate;
	}

	/**
	 * @Description eventdate的中文含义是： 事件发生时间
	 */
	public String getEventdate() {
		return eventdate;
	}

	/**
	 * @Description eventcontent的中文含义是： 事件内容
	 */
	public void setEventcontent(String eventcontent) {
		this.eventcontent = eventcontent;
	}

	/**
	 * @Description eventcontent的中文含义是： 事件内容
	 */
	public String getEventcontent() {
		return eventcontent;
	}

	/**
	 * @Description eventlevel的中文含义是： 事件等级
	 */
	public void setEventlevel(String eventlevel) {
		this.eventlevel = eventlevel;
	}

	/**
	 * @Description eventlevel的中文含义是： 事件等级
	 */
	public String getEventlevel() {
		return eventlevel;
	}

	/**
	 * @Description remark的中文含义是： 备注
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @Description remark的中文含义是： 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @Description eventstate的中文含义是： 事件处理状态
	 */
	public void setEventstate(String eventstate) {
		this.eventstate = eventstate;
	}

	/**
	 * @Description eventstate的中文含义是： 事件处理状态
	 */
	public String getEventstate() {
		return eventstate;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027() {
		return aaa027;
	}

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public String getAaa027name() {
		return aaa027name;
	}

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public void setAaa027name(String aaa027name) {
		this.aaa027name = aaa027name;
	}

	/**
	 * @Description operateperson的中文含义是： 经办人
	 */
	public void setOperateperson(String operateperson) {
		this.operateperson = operateperson;
	}

	/**
	 * @Description operateperson的中文含义是： 经办人
	 */
	public String getOperateperson() {
		return operateperson;
	}

	/**
	 * @Description operatedate的中文含义是： 经办时间
	 */
	public void setOperatedate(String operatedate) {
		this.operatedate = operatedate;
	}

	/**
	 * @Description operatedate的中文含义是： 经办时间
	 */
	public String getOperatedate() {
		return operatedate;
	}

	/**
	 * @Description cateid的中文含义是： 新闻分类ID
	 */
	private String cateid;

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

	public String getOnerowflag() {
		return onerowflag;
	}

	public void setOnerowflag(String onerowflag) {
		this.onerowflag = onerowflag;
	}

	public String getEventstateaaa103() {
		return eventstateaaa103;
	}

	public void setEventstateaaa103(String eventstateaaa103) {
		this.eventstateaaa103 = eventstateaaa103;
	}

	public String getEventlevelaaa103() {
		return eventlevelaaa103;
	}

	public void setEventlevelaaa103(String eventlevelaaa103) {
		this.eventlevelaaa103 = eventlevelaaa103;
	}

	public String getAaa027aaa103() {
		return aaa027aaa103;
	}

	public void setAaa027aaa103(String aaa027aaa103) {
		this.aaa027aaa103 = aaa027aaa103;
	}

	public String getTexts() {
		return texts;
	}

	public void setTexts(String texts) {
		this.texts = texts;
	}

	public String getJpushmingling() {
		return jpushmingling;
	}

	public void setJpushmingling(String jpushmingling) {
		this.jpushmingling = jpushmingling;
	}

	public String getJpushtitle() {
		return jpushtitle;
	}

	public void setJpushtitle(String jpushtitle) {
		this.jpushtitle = jpushtitle;
	}

	public String getJpushcontent() {
		return jpushcontent;
	}

	public void setJpushcontent(String jpushcontent) {
		this.jpushcontent = jpushcontent;
	}

	public String getUsergridstr() {
		return usergridstr;
	}

	public void setUsergridstr(String usergridstr) {
		this.usergridstr = usergridstr;
	}
}