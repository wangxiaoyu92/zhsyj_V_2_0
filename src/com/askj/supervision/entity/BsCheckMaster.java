package com.askj.supervision.entity;

import java.sql.Timestamp;
import java.util.Date;
import org.nutz.dao.entity.annotation.*;


/**
 * Bscheckmaster的中文名称：检查结果摘要类
 * Written by:syf
 */
@Table(value = "BSCHECKMASTER")
public class BsCheckMaster{
	/**
	 * aaa027 的中文名称：地区编码
	 */
	 @Column
	private String aaa027;
	/**
	 * aae140 的中文名称：四品一械大类
	 */
	 @Column
	private String aae140;
	/**
	 * userid 的中文名称：经办人id
	 */
	 @Column
	private String userid;
	/**
	 * orgid 的中文名称：机构id
	 */
	 @Column
	private String orgid;
	/**
	 * aae011 的中文名称：经办人姓名
	 */
	 @Column
	private String aae011;

	/**
	 * aae011 的中文名称：经办time
	 */
	@Column
	private Timestamp aae036;
	 
	public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}
	public String getAae140() {
		return aae140;
	}
	public void setAae140(String aae140) {
		this.aae140 = aae140;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getAae011() {
		return aae011;
	}
	public void setAae011(String aae011) {
		this.aae011 = aae011;
	}
	

	/**
	 * checkavgscore 的中文名称：检查平均分
	 */
	@Column 
	private double checkavgscore;
	/**
	 * lhfjdtpddj 的中文名称：量化分级动态评定等级A优秀B良好C一般
	 */
	@Column 
	private String lhfjdtpddj;
	
	/**
	 * lhfjdtpddjstr 的中文名称：量化分级动态评定等级A优秀B良好C一般
	 */
	@Readonly
	private String lhfjdtpddjstr;	
	
	/**
	 * checkyear 的中文名称：量化分级动态评定等级A优秀B良好C一般
	 */
	@Column
	private String checkyear;	
	
	
	
	/**
	 * resultid 的中文名称：结果ID
	 */
	 @Column 
	 @Name
	private String resultid;
	 
	/**
	 * comid 的中文名称：单位ID
	 */
	@Column 
	private String planid;

	/**
	 * comid 的中文名称：单位ID
	 */
	 @Column 
	private String comid;

	/**
	 * resultdecision 的中文名称：结果判定
	 */
	 @Column 
	private String resultdecision;

	/**
	 * resultng 的中文名称：结果不符合项说明
	 */
	 @Column 
	private String resultng;

	/**
	 * resultremark 的中文名称：结果备注
	 */
	 @Column 
	private String resultremark;

	/**
	 * resultscore 的中文名称：结果得分
	 */
	 @Column 
	private double resultscore;
	/**
	 * operatedate 的中文名称：项目经办日期
	 */
	 @Column 
	private Timestamp operatedate;

	/**
	 * operateperson 的中文名称：项目经办人
	 */
	 @Column 
	private String operateperson;

	/**
	 * resultdate 的中文名称：结果检查日期
	 */
	 @Column 
	private Date resultdate;

	/**
	 * resultperson 的中文名称：结果检查人
	 */
	 @Column 
	private String resultperson;
	 /**
		 * resultstate 的中文名称：结果完成标识
		 */
		 @Column 
		private String resultstate;
	 /**
		 * resultinfo 的中文名称：结果明细
		 */
		 @Column 
		private String detailinfo;
	 /**
		 * resultinfo 的中文名称：核查结果信息
		 */
		 @Column 
		private String checkresultinfo;
	 /**
		 * checkgroupstate 的中文名称：检查项目类别标识
		 */
		 @Column 
		private String checkgroupstate;
		 /**
			 * location 的中文名称：地理位置信息
			 */
			 @Column 
			private String location;
			 /**
		 * latitude 的中文名称：纬度信息
		 */
		 @Column 
		private String latitude;
		 /**
			 * longitude 的中文名称：经度信息
			 */
			 @Column 
			private String longitude;
			 
	 /**
		 * qtbwid 的中文名称：其他表外id
		 */
		 @Column 
		private String qtbwid;
	 /**
		 * checkdatakind 的中文名称：检查数据类型1企业检查2农村集体聚餐3重大活动
		 */
		 @Column 
		private String checkdatakind;	
	 /**
		 * lxr 的中文名称：联系人
		 */
		 @Column 
		private String lxr;
	 /**
		 * lxdh 的中文名称：联系电话
		 */
		 @Column 
		private String lxdh;			 
				 
				 
	/**
	 * 
	 * setResultid的中文名称：设置结果ID
	 *
	 * @param resultid  结果ID 
	 * Written by:syf
	 */
	public void setResultid(String resultid){
		this.resultid=resultid;
	}

	/**
	 * 
	 * getResultid的中文名称：获取结果ID
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getResultid(){
		return resultid;
	}
	
	/**
	 * 
	 * setPlanid的中文名称：设置计划ID
	 *
	 * @param planid  计划ID 
	 * Written by:syf
	 */
	public void setPlanid(String planid) {
		this.planid = planid;
	}
	
	/**
	 * 
	 * getPlanid的中文名称：获取计划ID
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getPlanid() {
		return planid;
	}

	/**
	 * 
	 * setComid的中文名称：设置单位ID
	 *
	 * @param comid  单位ID 
	 * Written by:syf
	 */
	public void setComid(String comid){
		this.comid=comid;
	}

	/**
	 * 
	 * getComid的中文名称：获取单位ID
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getComid(){
		return comid;
	}

	/**
	 * 
	 * setResultdecision的中文名称：设置结果判定
	 *
	 * @param resultdecision  结果判定 
	 * Written by:syf
	 */
	public void setResultdecision(String resultdecision){
		this.resultdecision=resultdecision;
	}

	/**
	 * 
	 * getResultdecision的中文名称：获取结果判定
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getResultdecision(){
		return resultdecision;
	}

	/**
	 * 
	 * setResultng的中文名称：设置结果不符合项说明
	 *
	 * @param resultng  结果不符合项说明 
	 * Written by:syf
	 */
	public void setResultng(String resultng){
		this.resultng=resultng;
	}

	/**
	 * 
	 * getResultng的中文名称：获取结果不符合项说明
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getResultng(){
		return resultng;
	}

	/**
	 * 
	 * setResultremark的中文名称：设置结果备注
	 *
	 * @param resultremark  结果备注 
	 * Written by:syf
	 */
	public void setResultremark(String resultremark){
		this.resultremark=resultremark;
	}

	/**
	 * 
	 * getResultremark的中文名称：获取结果备注
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getResultremark(){
		return resultremark;
	}

	/**
	 * 
	 * setResultscore的中文名称：设置结果得分
	 *
	 * @param resultscore  结果得分 
	 * Written by:syf
	 */
	public void setResultscore(double resultscore){
		this.resultscore=resultscore;
	}

	/**
	 * 
	 * getResultscore的中文名称：获取结果得分
	 *
	 * @return double
	 * Written by:syf
	 */
	public double getResultscore(){
		return resultscore;
	}

	/**
	 * 
	 * setOperatedate的中文名称：设置项目经办日期
	 *
	 * @param operatedate  项目经办日期 
	 * Written by:syf
	 */
	public void setOperatedate(Timestamp operatedate){
		this.operatedate=operatedate;
	}

	/**
	 * 
	 * getOperatedate的中文名称：获取项目经办日期
	 *
	 * @return Date
	 * Written by:syf
	 */
	public Date getOperatedate(){
		return operatedate;
	}

	/**
	 * 
	 * setOperateperson的中文名称：设置项目经办人
	 *
	 * @param operateperson  项目经办人 
	 * Written by:syf
	 */
	public void setOperateperson(String operateperson){
		this.operateperson=operateperson;
	}

	/**
	 * 
	 * getOperateperson的中文名称：获取项目经办人
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getOperateperson(){
		return operateperson;
	}

	/**
	 * 
	 * setResultdate的中文名称：设置结果检查日期
	 *
	 * @param resultdate  结果检查日期 
	 * Written by:syf
	 */
	public void setResultdate(Date resultdate){
		this.resultdate=resultdate;
	}

	/**
	 * 
	 * getResultdate的中文名称：获取结果检查日期
	 *
	 * @return Date
	 * Written by:syf
	 */
	public Date getResultdate(){
		return resultdate;
	}

	/**
	 * 
	 * setResultperson的中文名称：设置结果检查人
	 *
	 * @param resultperson  结果检查人 
	 * Written by:syf
	 */
	public void setResultperson(String resultperson){
		this.resultperson=resultperson;
	}

	/**
	 * 
	 * getResultperson的中文名称：获取结果检查人
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getResultperson(){
		return resultperson;
	}

	public String getResultstate() {
		return resultstate;
	}

	public void setResultstate(String resultstate) {
		this.resultstate = resultstate;
	}

	public String getDetailinfo() {
		return detailinfo;
	}

	public void setDetailinfo(String detailinfo) {
		this.detailinfo = detailinfo;
	}

	public String getCheckresultinfo() {
		return checkresultinfo;
	}

	public void setCheckresultinfo(String checkresultinfo) {
		this.checkresultinfo = checkresultinfo;
	}

	public String getCheckgroupstate() {
		return checkgroupstate;
	}

	public void setCheckgroupstate(String checkgroupstate) {
		this.checkgroupstate = checkgroupstate;
	}


	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getQtbwid() {
		return qtbwid;
	}

	public void setQtbwid(String qtbwid) {
		this.qtbwid = qtbwid;
	}

	public String getCheckdatakind() {
		return checkdatakind;
	}

	public void setCheckdatakind(String checkdatakind) {
		this.checkdatakind = checkdatakind;
	}

	public String getLxr() {
		return lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}


	public double getCheckavgscore() {
		return checkavgscore;
	}

	public void setCheckavgscore(double checkavgscore) {
		this.checkavgscore = checkavgscore;
	}

	public String getLhfjdtpddj() {
		return lhfjdtpddj;
	}

	public void setLhfjdtpddj(String lhfjdtpddj) {
		this.lhfjdtpddj = lhfjdtpddj;
	}

	public String getLhfjdtpddjstr() {
		return lhfjdtpddjstr;
	}

	public void setLhfjdtpddjstr(String lhfjdtpddjstr) {
		this.lhfjdtpddjstr = lhfjdtpddjstr;
	}

	public String getCheckyear() {
		return checkyear;
	}

	public void setCheckyear(String checkyear) {
		this.checkyear = checkyear;
	}

	public Timestamp getAae036() {
		return aae036;
	}

	public void setAae036(Timestamp aae036) {
		this.aae036 = aae036;
	}
}
