package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  LhfjcxDTO的中文含义是: 量化分级查询; InnoDB free: 784384 kBDTO
 * @Creation     2017/02/22 11:40:09
 * @Written      Create Tool By gjf 
 **/
public class LhfjcxDTO {
	
	/**
	 * @Description operatedatestart的中文含义是： 操作开始时间
	 */
	private String operatedatestart;
	/**
	 * @Description operatedateend的中文含义是： 操作结束时间
	 */
	private String operatedateend;
	/**
	 * @Description checkyear的中文含义是： 操作结束时间
	 */
	private String checkyear;	
	
	
	
	/**
	 * @Description resultid的中文含义是： 检查主表id
	 */
	private String resultid;
	/**
	 * @Description planid的中文含义是： 检查计划id
	 */
	private String planid;
	/**
	 * @Description plantitle的中文含义是： 检查计划标题
	 */
	private String plantitle;	
	
	/**
	 * @Description comid的中文含义是： 企业id
	 */
	private String comid;
	/**
	 * @Description commc的中文含义是： 企业mc
	 */
	private String commc;
	/**
	 * @Description comdz的中文含义是： 企业地址
	 */
	private String comdz;	
	/**
	 * @Description resultdecision的中文含义是： 结果判定(101:符合；102：不符合；103：限时整改)
	 */
	private String resultdecision;		
	/**
	 * @Description resulttng的中文含义是：结果不符合项说明
	 */
	private String resulttng;	
	/**
	 * @Description resultremark的中文含义是：结果备注
	 */
	private String resultremark;
	/**
	 * @Description resultscore的中文含义是：结果得分
	 */
	private String resultscore;	
	/**
	 * @Description resultstate的中文含义是：结果完成表示（1：未完成，2：已完成，3：固化,4:结果判定固化5保存完毕）0新增检查后状态1未使用2明细保存成功后状态3明细保存成功后再提交后状态5检查意见填写完保存后状态4检查意见保存后提交后状态
	 */
	private String resultstate;		
	/**
	 * @Description operatedate的中文含义是：项目经办日期
	 */
	private String operatedate;		
	/**
	 * @Description operateperson的中文含义是：项目经办人
	 */
	private String operateperson;	
	
	/**
	 * @Description operatepersonstr的中文含义是：项目经办人姓名
	 */
	private String operatepersonstr;	
	
	
	
	/**
	 * @Description resultdate的中文含义是：结果检查日期
	 */
	private String resultdate;
	/**
	 * @Description resultperson的中文含义是：结果检查人
	 */
	private String resultperson;
	/**
	 * @Description location的中文含义是：地理位置
	 */
	private String location;
	/**
	 * @Description lxr的中文含义是：联系人
	 */
	private String lxr;	
    /**
     * lxdh 的中文名称：联系电话
     */
    private String lxdh;
    /**
     * aaa027 的中文名称：地区编码
     */
    private String aaa027; 
    /**
     * userid 的中文名称：操作员id
     */
    private String userid; 
    /**
     * orgid 的中文名称：机构id
     */
    private String orgid;
    /**
     * checkavgscore 的中文名称：检查平均分
     */
    private String checkavgscore;    
    /**
     * lhfjdtpddj 的中文名称：量化分级动态评定等级A优秀B良好C一般
     */
    private String lhfjdtpddj;    
    /**
     * jcnrcount 的中文名称：检查内容数
     */
    private String jcnrcount;  
    /**
     * ywcjcnrcount 的中文名称：已完成检查内容数
     */
    private String ywcjcnrcount; 
    /**
     * impjcnrcount 的中文名称：关键检查内容数
     */
    private String impjcnrcount;
    /**
     * fhjcnrcount 的中文名称：符合检查内容数
     */
    private String fhjcnrcount; 
    /**
     * bfhjcnrcount 的中文名称：不符合检查内容数
     */
    private String bfhjcnrcount; 
    /**
     * hlqxjcnrcount 的中文名称：合理缺项检查内容数
     */
    private String hlqxjcnrcount;  
    /**
     * impbfhjcnrcount 的中文名称：关键不符合检查内容数
     */
    private String impbfhjcnrcount;
	public String getResultid() {
		return resultid;
	}
	public void setResultid(String resultid) {
		this.resultid = resultid;
	}
	public String getPlanid() {
		return planid;
	}
	public void setPlanid(String planid) {
		this.planid = planid;
	}
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	public String getComdz() {
		return comdz;
	}
	public void setComdz(String comdz) {
		this.comdz = comdz;
	}
	public String getResultdecision() {
		return resultdecision;
	}
	public void setResultdecision(String resultdecision) {
		this.resultdecision = resultdecision;
	}
	public String getResulttng() {
		return resulttng;
	}
	public void setResulttng(String resulttng) {
		this.resulttng = resulttng;
	}
	public String getResultremark() {
		return resultremark;
	}
	public void setResultremark(String resultremark) {
		this.resultremark = resultremark;
	}
	public String getResultscore() {
		return resultscore;
	}
	public void setResultscore(String resultscore) {
		this.resultscore = resultscore;
	}
	public String getResultstate() {
		return resultstate;
	}
	public void setResultstate(String resultstate) {
		this.resultstate = resultstate;
	}
	public String getOperatedate() {
		return operatedate;
	}
	public void setOperatedate(String operatedate) {
		this.operatedate = operatedate;
	}
	public String getOperateperson() {
		return operateperson;
	}
	public void setOperateperson(String operateperson) {
		this.operateperson = operateperson;
	}
	public String getResultdate() {
		return resultdate;
	}
	public void setResultdate(String resultdate) {
		this.resultdate = resultdate;
	}
	public String getResultperson() {
		return resultperson;
	}
	public void setResultperson(String resultperson) {
		this.resultperson = resultperson;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
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
	public String getAaa027() {
		return aaa027;
	}
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
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
	public String getCheckavgscore() {
		return checkavgscore;
	}
	public void setCheckavgscore(String checkavgscore) {
		this.checkavgscore = checkavgscore;
	}
	public String getLhfjdtpddj() {
		return lhfjdtpddj;
	}
	public void setLhfjdtpddj(String lhfjdtpddj) {
		this.lhfjdtpddj = lhfjdtpddj;
	}
	public String getJcnrcount() {
		return jcnrcount;
	}
	public void setJcnrcount(String jcnrcount) {
		this.jcnrcount = jcnrcount;
	}
	public String getYwcjcnrcount() {
		return ywcjcnrcount;
	}
	public void setYwcjcnrcount(String ywcjcnrcount) {
		this.ywcjcnrcount = ywcjcnrcount;
	}
	public String getImpjcnrcount() {
		return impjcnrcount;
	}
	public void setImpjcnrcount(String impjcnrcount) {
		this.impjcnrcount = impjcnrcount;
	}
	public String getFhjcnrcount() {
		return fhjcnrcount;
	}
	public void setFhjcnrcount(String fhjcnrcount) {
		this.fhjcnrcount = fhjcnrcount;
	}
	public String getBfhjcnrcount() {
		return bfhjcnrcount;
	}
	public void setBfhjcnrcount(String bfhjcnrcount) {
		this.bfhjcnrcount = bfhjcnrcount;
	}
	public String getHlqxjcnrcount() {
		return hlqxjcnrcount;
	}
	public void setHlqxjcnrcount(String hlqxjcnrcount) {
		this.hlqxjcnrcount = hlqxjcnrcount;
	}
	public String getImpbfhjcnrcount() {
		return impbfhjcnrcount;
	}
	public void setImpbfhjcnrcount(String impbfhjcnrcount) {
		this.impbfhjcnrcount = impbfhjcnrcount;
	}
	public String getOperatedatestart() {
		return operatedatestart;
	}
	public void setOperatedatestart(String operatedatestart) {
		this.operatedatestart = operatedatestart;
	}
	public String getOperatedateend() {
		return operatedateend;
	}
	public void setOperatedateend(String operatedateend) {
		this.operatedateend = operatedateend;
	}
	public String getPlantitle() {
		return plantitle;
	}
	public void setPlantitle(String plantitle) {
		this.plantitle = plantitle;
	}
	public String getOperatepersonstr() {
		return operatepersonstr;
	}
	public void setOperatepersonstr(String operatepersonstr) {
		this.operatepersonstr = operatepersonstr;
	}
	public String getCheckyear() {
		return checkyear;
	}
	public void setCheckyear(String checkyear) {
		this.checkyear = checkyear;
	}
    

}