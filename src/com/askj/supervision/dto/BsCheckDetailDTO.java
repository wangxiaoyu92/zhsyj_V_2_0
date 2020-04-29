package com.askj.supervision.dto;

import java.util.List;

/**
 * Bscheckdetail的中文名称：检查结果明细类
 * Written by:syf
 */
public class BsCheckDetailDTO {
	//扩展开始
	/**操作type  如operatetype='shengchandongtai'*/
	private String operatetype;
	/**comid*/
	private String comid;

	private String location;
	/**
	 * latitude 的中文名称：纬度信息
	 */
	private String latitude;
	/**
	 * longitude 的中文名称：经度信息
	 */
	private String longitude;

	//扩展结束
	/**
	 * checkavgscore 的中文名称：检查平均分
	 */
	private float checkavgscore;
	/**
	 * lhfjdtpddj 的中文名称：量化分级动态评定等级A优秀B良好C一般
	 */
	private String lhfjdtpddj;
	/**
	 * lhfjdtpddjstr 的中文名称：量化分级动态评定等级A优秀B良好C一般 代码加表示
	 */
	private String lhfjdtpddjstr;	
	

	/**
	 * detailid 的中文名称：明细ID
	 */
	private String detailid;
	
	/**
	 * taskdetailid 的中文名称：任务明细主键
	 */
	private String taskdetailid;

	/**
	 * resultid 的中文名称：结果ID
	 */
	 
	private String resultid;

	/**
	 * contentid 的中文名称：内容ID
	 */
	 
	private String contentid;

	/**
	 * detaildecide 的中文名称：明细结果判定
	 */
	 
	private String detaildecide;

	/**
	 * detailscore 的中文名称：明细得分
	 */
	 
	private double detailscore;

	/**
	 * detailng 的中文名称：明细不符合项说明
	 */
	 
	private String detailng;

	/**
	 * detailattachment 的中文名称：明细附件
	 */
	 
	private String detailattachment;

	/**
	 * detailremark 的中文名称：明细备注
	 */
	 
	private String detailremark;

	/**
	 * detailoperatedate 的中文名称：明细经办日期
	 */
	 
	private String detailoperatedate;

	/**
	 * detailoperateperson 的中文名称：明细经办人
	 */
	 
	private String detailoperateperson;

	/**
	 * detailcheckdate 的中文名称：明细核查日期
	 */
	 
	private String detailcheckdate;

	/**
	 * detailcheckperson 的中文名称：明细检查人
	 */
	 
	private String detailcheckperson;

	private List<BsCheckDetailDTO> detaillist   ;
	
	private String contentcode;
	private String contentimpt;
	private String contentimptaaa103;//gu20180413
	private String contentsortid;
	private String contentscore;
	private String itemname;
	private String content;
	private String itemid;
	private String itempid;
	private String count;
	/**
	 * 
	 * setDetailid的中文名称：设置明细ID
	 *
	 * @param detailid  明细ID 
	 * Written by:syf
	 */
	public void setDetailid(String detailid){
		this.detailid=detailid;
	}

	/**
	 * 
	 * getDetailid的中文名称：获取明细ID
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getDetailid(){
		return detailid;
	}
	
	/**
	 * taskdetailid 的中文名称：任务明细主键
	 */
	public String getTaskdetailid() {
		return taskdetailid;
	}

	/**
	 * taskdetailid 的中文名称：任务明细主键
	 */
	public void setTaskdetailid(String taskdetailid) {
		this.taskdetailid = taskdetailid;
	}

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
	 * setContentid的中文名称：设置内容ID
	 *
	 * @param contentid  内容ID 
	 * Written by:syf
	 */
	public void setContentid(String contentid){
		this.contentid=contentid;
	}

	/**
	 * 
	 * getContentid的中文名称：获取内容ID
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getContentid(){
		return contentid;
	}

	/**
	 * 
	 * setDetaildecide的中文名称：设置明细结果判定
	 *
	 * @param detaildecide  明细结果判定 
	 * Written by:syf
	 */
	public void setDetaildecide(String detaildecide){
		this.detaildecide=detaildecide;
	}

	/**
	 * 
	 * getDetaildecide的中文名称：获取明细结果判定
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getDetaildecide(){
		return detaildecide;
	}

	/**
	 * 
	 * setDetailscore的中文名称：设置明细得分
	 *
	 * @param detailscore  明细得分 
	 * Written by:syf
	 */
	public void setDetailscore(double detailscore){
		this.detailscore=detailscore;
	}

	/**
	 * 
	 * getDetailscore的中文名称：获取明细得分
	 *
	 * @return long
	 * Written by:syf
	 */
	public double getDetailscore(){
		return detailscore;
	}

	/**
	 * 
	 * setDetailng的中文名称：设置明细不符合项说明
	 *
	 * @param detailng  明细不符合项说明 
	 * Written by:syf
	 */
	public void setDetailng(String detailng){
		this.detailng=detailng;
	}

	/**
	 * 
	 * getDetailng的中文名称：获取明细不符合项说明
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getDetailng(){
		return detailng;
	}

	/**
	 * 
	 * setDetailattachment的中文名称：设置明细附件
	 *
	 * @param detailattachment  明细附件 
	 * Written by:syf
	 */
	public void setDetailattachment(String detailattachment){
		this.detailattachment=detailattachment;
	}

	/**
	 * 
	 * getDetailattachment的中文名称：获取明细附件
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getDetailattachment(){
		return detailattachment;
	}

	/**
	 * 
	 * setDetailremark的中文名称：设置明细备注
	 *
	 * @param detailremark  明细备注 
	 * Written by:syf
	 */
	public void setDetailremark(String detailremark){
		this.detailremark=detailremark;
	}

	/**
	 * 
	 * getDetailremark的中文名称：获取明细备注
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getDetailremark(){
		return detailremark;
	}

	/**
	 * 
	 * setDetailoperatedate的中文名称：设置明细经办日期
	 *
	 * @param detailoperatedate  明细经办日期 
	 * Written by:syf
	 */
	public void setDetailoperatedate(String detailoperatedate){
		this.detailoperatedate=detailoperatedate;
	}

	/**
	 * 
	 * getDetailoperatedate的中文名称：获取明细经办日期
	 *
	 * @return Date
	 * Written by:syf
	 */
	public String getDetailoperatedate(){
		return detailoperatedate;
	}

	/**
	 * 
	 * setDetailoperateperson的中文名称：设置明细经办人
	 *
	 * @param detailoperateperson  明细经办人 
	 * Written by:syf
	 */
	public void setDetailoperateperson(String detailoperateperson){
		this.detailoperateperson=detailoperateperson;
	}

	/**
	 * 
	 * getDetailoperateperson的中文名称：获取明细经办人
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getDetailoperateperson(){
		return detailoperateperson;
	}

	/**
	 * 
	 * setDetailcheckdate的中文名称：设置明细核查日期
	 *
	 * @param detailcheckdate  明细核查日期 
	 * Written by:syf
	 */
	public void setDetailcheckdate(String detailcheckdate){
		this.detailcheckdate=detailcheckdate;
	}

	/**
	 * 
	 * getDetailcheckdate的中文名称：获取明细核查日期
	 *
	 * @return Date
	 * Written by:syf
	 */
	public String getDetailcheckdate(){
		return detailcheckdate;
	}

	/**
	 * 
	 * setDetailcheckperson的中文名称：设置明细检查人
	 *
	 * @param detailcheckperson  明细检查人 
	 * Written by:syf
	 */
	public void setDetailcheckperson(String detailcheckperson){
		this.detailcheckperson=detailcheckperson;
	}

	/**
	 * 
	 * getDetailcheckperson的中文名称：获取明细检查人
	 *
	 * @return String
	 * Written by:syf
	 */
	public String getDetailcheckperson(){
		return detailcheckperson;
	}

	public List<BsCheckDetailDTO> getDetaillist() {
		return detaillist;
	}

	public void setDetaillist(List<BsCheckDetailDTO> detaillist) {
		this.detaillist = detaillist;
	}

	public String getContentcode() {
		return contentcode;
	}

	public void setContentcode(String contentcode) {
		this.contentcode = contentcode;
	}

	public String getContentimpt() {
		return contentimpt;
	}

	public void setContentimpt(String contentimpt) {
		this.contentimpt = contentimpt;
	}

	public String getContentsortid() {
		return contentsortid;
	}

	public void setContentsortid(String contentsortid) {
		this.contentsortid = contentsortid;
	}

	public String getContentscore() {
		return contentscore;
	}

	public void setContentscore(String contentscore) {
		this.contentscore = contentscore;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getItemid() {
		return itemid;
	}

	public void setItemid(String itemid) {
		this.itemid = itemid;
	}

	public String getItempid() {
		return itempid;
	}

	public void setItempid(String itempid) {
		this.itempid = itempid;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public float getCheckavgscore() {
		return checkavgscore;
	}

	public void setCheckavgscore(float checkavgscore) {
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

	public String getContentimptaaa103() {
		return contentimptaaa103;
	}

	public void setContentimptaaa103(String contentimptaaa103) {
		this.contentimptaaa103 = contentimptaaa103;
	}

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
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
}
