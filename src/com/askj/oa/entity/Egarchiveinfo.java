package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

/**
 * 
 *egarchiveinfo中文名称：公文管理
 *egarchiveinfo概要描述：公文管理
 * 2016-6-21
 * written by : lfy
 */
@Table(value = "EGARCHIVEINFO")
public class Egarchiveinfo {
	@Column
	@Name
	private  String archiveid;  
	@Column
	private  String archivecode; 
	@Column
	private  String archivetitle;     
	@Column
	private  String archivekey;   
	@Column
	private  String archivecontent; 
	@Column
	private  String archiveremark;   
	@Column
	private  String archivestate; 
	@Column
	private  String archiveopperuser;
	@Column
	private  String archiveopperuserid;
	@Column
	private  String archiveopperdate;
	@Column
	private  String slbz;
	@Column
	private  String lwjg;
	@Column
	private String huigao;
	@Column
	private String rank;
	@Column
	private String term;
	@Column
	private String fixedbasis;
	@Column
	private String maindelivery;
	@Column
	private String copy;
	@Column
	private String typing;
	@Column
	private String proofreading;
	@Column
	private String number;
	@Column
	private String writing1;
	@Column
	private String writing2;
	@Column
	private String writing3;
	@Column
	private Timestamp sealtime;
	@Column
	private String thematicwords;
	@Column
	private String messagetype;
	@Column
	private String swzbh;

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

	public String getSlbz() {
		return slbz;
	}

	public void setSlbz(String slbz) {
		this.slbz = slbz;
	}

	public String getArchiveopperuserid() {
		return archiveopperuserid;
	}

	public void setArchiveopperuserid(String archiveopperuserid) {
		this.archiveopperuserid = archiveopperuserid;
	}
}
