package com.askj.oa.dto;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;

import java.sql.Timestamp;

/**
 * 
 *EgarchiveinfoDTO中文名称：公文管理Dto
 *EgarchiveinfoDTO概要描述：公文管理Dto
 * 2016-6-21
 * written by : lfy
 */

public class EgarchiveinfoDTO {
	private  String archiveid;  
	private  String archivecode; 
	private  String archivetitle;     
	private  String archivekey;   
	private  String archivecontent; 
	private  String archiveremark;   
	private  String archivestate; 
	private  String archiveopperuser; 
	private  String archiveopperdate;
	private  String archiveopperuserid;
	private  String slbz;
	private  String lwjg;
	//会搞
	private String huigao;
	//密级
	private String rank;
	//期限
	private String term;
	//定密依据
	private String fixedbasis;
	//主送
	private String maindelivery;
	//抄送
	private String copy;
	//打字
	private String typing;
	//校对
	private String proofreading;
	//份数
	private String number;
	//发文1
	private String writing1;
	//发文2
	private String writing2;
	//发文3
	private String writing3;
	//日期
	private Timestamp sealtime;
	//主题词
	private String thematicwords;
	//1:发文2.收文
	private String messagetype;
	//收文总编号
	private String swzbh;
	//收文人ID
	private String  rcarchiveuserid;


	public String getRcarchiveuserid() {
		return rcarchiveuserid;
	}

	public void setRcarchiveuserid(String rcarchiveuserid) {
		this.rcarchiveuserid = rcarchiveuserid;
	}

	public String getSwzbh() {
		return swzbh;
	}

	public void setSwzbh(String swzbh) {
		this.swzbh = swzbh;
	}

	public String getHuigao() {
		return huigao;
	}

	public void setHuigao(String huigao) {
		this.huigao = huigao;
	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getFixedbasis() {
		return fixedbasis;
	}

	public void setFixedbasis(String fixedbasis) {
		this.fixedbasis = fixedbasis;
	}

	public String getMaindelivery() {
		return maindelivery;
	}

	public void setMaindelivery(String maindelivery) {
		this.maindelivery = maindelivery;
	}

	public String getCopy() {
		return copy;
	}

	public void setCopy(String copy) {
		this.copy = copy;
	}

	public String getTyping() {
		return typing;
	}

	public void setTyping(String typing) {
		this.typing = typing;
	}

	public String getProofreading() {
		return proofreading;
	}

	public void setProofreading(String proofreading) {
		this.proofreading = proofreading;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getWriting1() {
		return writing1;
	}

	public void setWriting1(String writing1) {
		this.writing1 = writing1;
	}

	public String getWriting2() {
		return writing2;
	}

	public void setWriting2(String writing2) {
		this.writing2 = writing2;
	}

	public String getWriting3() {
		return writing3;
	}

	public void setWriting3(String writing3) {
		this.writing3 = writing3;
	}

	public Timestamp getSealtime() {
		return sealtime;
	}

	public void setSealtime(Timestamp sealtime) {
		this.sealtime = sealtime;
	}

	public String getThematicwords() {
		return thematicwords;
	}

	public void setThematicwords(String thematicwords) {
		this.thematicwords = thematicwords;
	}

	public String getMessagetype() {
		return messagetype;
	}

	public void setMessagetype(String messagetype) {
		this.messagetype = messagetype;
	}

	public String getLwjg() {
		return lwjg;
	}

	public void setLwjg(String lwjg) {
		this.lwjg = lwjg;
	}
	/**
	 * @Description rcarchiveid的中文含义是： 收文id
	 */
	private String rcarchiveid;

	/**
	 * @Description rcarchivecode的中文含义是： 收文编号
	 */
	
	private String rcarchivecode;

	/**
	 * @Description rcarchivetitle的中文含义是： 收文标题
	 */
	
	private String rcarchivetitle;

	/**
	 * @Description rcarchivekey的中文含义是： 收文关键词
	 */
	
	private String rcarchivekey;

	/**
	 * @Description rcarchivecontent的中文含义是： 收文正文
	 */
	
	private String rcarchivecontent;

	/**
	 * @Description rcarchiveremark的中文含义是： 收文备注
	 */
	
	private String rcarchiveremark;

	/**
	 * @Description rcarchivestate的中文含义是： 收文状态 0:添加 1:归档
	 */
	
	private String rcarchivestate;

	/**
	 * @Description rcarchiveopperuser的中文含义是： 操作人
	 */
	
	private String rcarchiveopperuser;

	/**
	 * @Description rcarchiveopperdate的中文含义是： 操作日期
	 */
	
	private String rcarchiveopperdate;

	/**
	 * @Description rcarchiveopperuserid的中文含义是： 
	 */
	
	private String rcarchiveopperuserid;
	/**
	 * @Description fileid的中文含义是： 归档id
	 */
	private String fileid;

	/**
	 * @Description filecode的中文含义是： 归档编号
	 */
	
	private String filecode;

	/**
	 * @Description filetitle的中文含义是： 归档标题
	 */
	
	private String filetitle;

	/**
	 * @Description filekey的中文含义是： 归档关键词
	 */
	
	private String filekey;

	/**
	 * @Description filecontent的中文含义是： 归档正文
	 */
	
	private String filecontent;

	/**
	 * @Description fileremark的中文含义是： 归档备注
	 */
	
	private String fileremark;

	/**
	 * @Description filestate的中文含义是： 归档状态 0:添加 1:归档
	 */
	
	private String filestate;

	/**
	 * @Description fileopperuser的中文含义是： 操作人
	 */
	
	private String fileopperuser;

	/**
	 * @Description fileopperdate的中文含义是： 操作日期
	 */
	
	private String fileopperdate;

	/**
	 * @Description fileopperuserid的中文含义是： 
	 */
	
	private String fileopperuserid;

	
	public String getArchiveid() {
		return archiveid;
	}
	public void setArchiveid(String archiveid) {
		this.archiveid = archiveid;
	}
	public String getArchivecode() {
		return archivecode;
	}
	public void setArchivecode(String archivecode) {
		this.archivecode = archivecode;
	}
	public String getArchivetitle() {
		return archivetitle;
	}
	public void setArchivetitle(String archivetitle) {
		this.archivetitle = archivetitle;
	}
	public String getArchivekey() {
		return archivekey;
	}
	public void setArchivekey(String archivekey) {
		this.archivekey = archivekey;
	}
	public String getArchivecontent() {
		return archivecontent;
	}
	public void setArchivecontent(String archivecontent) {
		this.archivecontent = archivecontent;
	}
	public String getArchiveremark() {
		return archiveremark;
	}
	public void setArchiveremark(String archiveremark) {
		this.archiveremark = archiveremark;
	}
	public String getArchivestate() {
		return archivestate;
	}
	public void setArchivestate(String archivestate) {
		this.archivestate = archivestate;
	}
	public String getArchiveopperuser() {
		return archiveopperuser;
	}
	public void setArchiveopperuser(String archiveopperuser) {
		this.archiveopperuser = archiveopperuser;
	}
	public String getArchiveopperdate() {
		return archiveopperdate;
	}
	public void setArchiveopperdate(String archiveopperdate) {
		this.archiveopperdate = archiveopperdate;
	}
	public String getArchiveopperuserid() {
		return archiveopperuserid;
	}
	public void setArchiveopperuserid(String archiveopperuserid) {
		this.archiveopperuserid = archiveopperuserid;
	}
	public String getRcarchiveid() {
		return rcarchiveid;
	}
	public void setRcarchiveid(String rcarchiveid) {
		this.rcarchiveid = rcarchiveid;
	}
	public String getRcarchivecode() {
		return rcarchivecode;
	}
	public void setRcarchivecode(String rcarchivecode) {
		this.rcarchivecode = rcarchivecode;
	}
	public String getRcarchivetitle() {
		return rcarchivetitle;
	}
	public void setRcarchivetitle(String rcarchivetitle) {
		this.rcarchivetitle = rcarchivetitle;
	}
	public String getRcarchivekey() {
		return rcarchivekey;
	}
	public void setRcarchivekey(String rcarchivekey) {
		this.rcarchivekey = rcarchivekey;
	}
	public String getRcarchivecontent() {
		return rcarchivecontent;
	}
	public void setRcarchivecontent(String rcarchivecontent) {
		this.rcarchivecontent = rcarchivecontent;
	}
	public String getRcarchiveremark() {
		return rcarchiveremark;
	}
	public void setRcarchiveremark(String rcarchiveremark) {
		this.rcarchiveremark = rcarchiveremark;
	}
	public String getRcarchivestate() {
		return rcarchivestate;
	}
	public void setRcarchivestate(String rcarchivestate) {
		this.rcarchivestate = rcarchivestate;
	}
	public String getRcarchiveopperuser() {
		return rcarchiveopperuser;
	}
	public void setRcarchiveopperuser(String rcarchiveopperuser) {
		this.rcarchiveopperuser = rcarchiveopperuser;
	}
	public String getRcarchiveopperdate() {
		return rcarchiveopperdate;
	}
	public void setRcarchiveopperdate(String rcarchiveopperdate) {
		this.rcarchiveopperdate = rcarchiveopperdate;
	}
	public String getRcarchiveopperuserid() {
		return rcarchiveopperuserid;
	}
	public void setRcarchiveopperuserid(String rcarchiveopperuserid) {
		this.rcarchiveopperuserid = rcarchiveopperuserid;
	}
	public String getFileid() {
		return fileid;
	}
	public void setFileid(String fileid) {
		this.fileid = fileid;
	}
	public String getFilecode() {
		return filecode;
	}
	public void setFilecode(String filecode) {
		this.filecode = filecode;
	}
	public String getFiletitle() {
		return filetitle;
	}
	public void setFiletitle(String filetitle) {
		this.filetitle = filetitle;
	}
	public String getFilekey() {
		return filekey;
	}
	public void setFilekey(String filekey) {
		this.filekey = filekey;
	}
	public String getFilecontent() {
		return filecontent;
	}
	public void setFilecontent(String filecontent) {
		this.filecontent = filecontent;
	}
	public String getFileremark() {
		return fileremark;
	}
	public void setFileremark(String fileremark) {
		this.fileremark = fileremark;
	}
	public String getFilestate() {
		return filestate;
	}
	public void setFilestate(String filestate) {
		this.filestate = filestate;
	}
	public String getFileopperuser() {
		return fileopperuser;
	}
	public void setFileopperuser(String fileopperuser) {
		this.fileopperuser = fileopperuser;
	}
	public String getFileopperdate() {
		return fileopperdate;
	}
	public void setFileopperdate(String fileopperdate) {
		this.fileopperdate = fileopperdate;
	}
	public String getFileopperuserid() {
		return fileopperuserid;
	}
	public void setFileopperuserid(String fileopperuserid) {
		this.fileopperuserid = fileopperuserid;
	}


	public String getSlbz() {
		return slbz;
	}

	public void setSlbz(String slbz) {
		this.slbz = slbz;
	}
}
