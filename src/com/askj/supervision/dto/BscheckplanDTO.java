package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.Column;

/**
 * @Description  BSCHECKPLAN的中文含义是: 检查计划表; InnoDB free: 2689024 kBDTO
 * @Creation     2016/05/17 09:30:15
 * @Written      Create Tool By zjf 
 **/
public class BscheckplanDTO {
	//扩展开始
	private String querytype;

	private String comdalei;//企业大类

	/**
	 * @Description plancheckingcount的中文含义是： 正在检查中的记录数
	 */

	private String plancheckingcount;
	//扩展结束
	/**
	 * @Description planid的中文含义是： 计划主键
	 */
	
	private String planid;

	/**
	 * @Description plancode的中文含义是： 计划编号
	 */
	private String plancode;

	/**
	 * @Description plantitle的中文含义是： 计划标题
	 */
	private String plantitle;

	/**
	 * @Description planchecktype的中文含义是： 计划检查类别
	 */
	private String planchecktype;

	/**
	 * @Description plantype的中文含义是： 计划类型
	 */
	private String plantype;

	/**
	 * @Description plantypearea的中文含义是： 计划适用范围
	 */
	private String plantypearea;

	/**
	 * @Description planstdate的中文含义是： 计划开始时间
	 */
	private String planstdate;

	/**
	 * @Description planeddate的中文含义是： 计划结束时间
	 */
	private String planeddate;

	/**
	 * @Description plancontent的中文含义是： 计划内容
	 */
	private String plancontent;

	/**
	 * @Description planremark的中文含义是： 计划备注
	 */
	private String planremark;

	/**
	 * @Description planoperatedate的中文含义是： 计划经办时间
	 */
	private String planoperatedate;

	/**
	 * @Description planoperator的中文含义是： 计划经办人
	 */
	private String planoperator;
	/**
	 * @Description picid的中文含义是： 计划项主键
	 */
	private String picid;
	/**
	 * @Description itemid的中文含义是： 项目ID
	 */
	private String itemid;

	/**
	 * @Description contentid的中文含义是： 内容ID
	 */
	private String contentid;

	/**
	 * @Description picoperator的中文含义是： 计划项经办人
	 */
	private String picoperator;

	/**
	 * @Description picoperatedate的中文含义是： 计划项经办时间
	 */
	private String picoperatedate;

	private String[] items;
	/**
	 * @Description checkitem的中文含义是： 审核标识
	 */
	private String checkitem;
	/**
	 * @Description comid的中文含义是： 企业id
	 */

	/**
	 * @Description planoperator的中文含义是： 评定等级
	 */
	private String lhfjndpddj;

	/**
	 * @Description planmobankind的中文含义是： 计划模板类型aa10=PLANMOBANKIND
	 */
	private String planmobankind;


	private String comid;
	/**
	 * @Description resultstate的中文含义是：结果状态
	 */
	
	private String resultstate;
	private String aaz093;
	private String year;
	private String resultid;

	// 计划检查的企业类别所属的科室（原有的四品一械）
	private String aaa104;
	// 计划检查的企业类别
	private String aaa102;
	/**
	 * @Description unchecked的中文含义是： 未检查数量
	 */
	private String unchecked;
	/**
	 * @Description checked的中文含义是： 已检查数量
	 */
	private String checked;
	/**
	 * @Description checking的中文含义是： 检查中数量
	 */
	private String checking;

		/**
	 * @Description planid的中文含义是： 计划主键
	 */
	public void setPlanid(String planid){ 
		this.planid = planid;
	}
	/**
	 * @Description planid的中文含义是： 计划主键
	 */
	public String getPlanid(){
		return planid;
	}
	/**
	 * @Description plancode的中文含义是： 计划编号
	 */
	public void setPlancode(String plancode){ 
		this.plancode = plancode;
	}
	/**
	 * @Description plancode的中文含义是： 计划编号
	 */
	public String getPlancode(){
		return plancode;
	}
	/**
	 * @Description plantitle的中文含义是： 计划标题
	 */
	public void setPlantitle(String plantitle){ 
		this.plantitle = plantitle;
	}
	/**
	 * @Description plantitle的中文含义是： 计划标题
	 */
	public String getPlantitle(){
		return plantitle;
	}
	/**
	 * @Description planchecktype的中文含义是： 计划检查类别
	 */
	public void setPlanchecktype(String planchecktype){ 
		this.planchecktype = planchecktype;
	}
	/**
	 * @Description planchecktype的中文含义是： 计划检查类别
	 */
	public String getPlanchecktype(){
		return planchecktype;
	}
	/**
	 * @Description plantype的中文含义是： 计划类型
	 */
	public void setPlantype(String plantype){ 
		this.plantype = plantype;
	}
	/**
	 * @Description plantype的中文含义是： 计划类型
	 */
	public String getPlantype(){
		return plantype;
	}
	/**
	 * @Description plantypearea的中文含义是： 计划适用范围
	 */
	public void setPlantypearea(String plantypearea){ 
		this.plantypearea = plantypearea;
	}
	/**
	 * @Description plantypearea的中文含义是： 计划适用范围
	 */
	public String getPlantypearea(){
		return plantypearea;
	}
	/**
	 * @Description planstdate的中文含义是： 计划开始时间
	 */
	public void setPlanstdate(String planstdate){ 
		this.planstdate = planstdate;
	}
	/**
	 * @Description planstdate的中文含义是： 计划开始时间
	 */
	public String getPlanstdate(){
		return planstdate;
	}
	/**
	 * @Description planeddate的中文含义是： 计划结束时间
	 */
	public void setPlaneddate(String planeddate){ 
		this.planeddate = planeddate;
	}
	/**
	 * @Description planeddate的中文含义是： 计划结束时间
	 */
	public String getPlaneddate(){
		return planeddate;
	}
	/**
	 * @Description plancontent的中文含义是： 计划内容
	 */
	public void setPlancontent(String plancontent){ 
		this.plancontent = plancontent;
	}
	/**
	 * @Description plancontent的中文含义是： 计划内容
	 */
	public String getPlancontent(){
		return plancontent;
	}
	/**
	 * @Description planremark的中文含义是： 计划备注
	 */
	public void setPlanremark(String planremark){ 
		this.planremark = planremark;
	}
	/**
	 * @Description planremark的中文含义是： 计划备注
	 */
	public String getPlanremark(){
		return planremark;
	}
	/**
	 * @Description planoperatedate的中文含义是： 计划经办时间
	 */
	public void setPlanoperatedate(String planoperatedate){ 
		this.planoperatedate = planoperatedate;
	}
	/**
	 * @Description planoperatedate的中文含义是： 计划经办时间
	 */
	public String getPlanoperatedate(){
		return planoperatedate;
	}
	/**
	 * @Description planoperator的中文含义是： 计划经办人
	 */
	public void setPlanoperator(String planoperator){ 
		this.planoperator = planoperator;
	}
	/**
	 * @Description planoperator的中文含义是： 计划经办人
	 */
	public String getPlanoperator(){
		return planoperator;
	}
	public String getPicid() {
		return picid;
	}
	public void setPicid(String picid) {
		this.picid = picid;
	}
	public String getItemid() {
		return itemid;
	}
	public void setItemid(String itemid) {
		this.itemid = itemid;
	}
	public String getContentid() {
		return contentid;
	}
	public void setContentid(String contentid) {
		this.contentid = contentid;
	}
	public String getPicoperator() {
		return picoperator;
	}
	public void setPicoperator(String picoperator) {
		this.picoperator = picoperator;
	}
	public String getPicoperatedate() {
		return picoperatedate;
	}
	public void setPicoperatedate(String picoperatedate) {
		this.picoperatedate = picoperatedate;
	}
	public String[] getItems() {
		return items;
	}
	public void setItems(String[] items) {
		this.items = items;
	}
	public String getCheckitem() {
		return checkitem;
	}
	public void setCheckitem(String checkitem) {
		this.checkitem = checkitem;
	}
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}
	public String getResultstate() {
		return resultstate;
	}
	public void setResultstate(String resultstate) {
		this.resultstate = resultstate;
	}
	public String getAaz093() {
		return aaz093;
	}
	public void setAaz093(String aaz093) {
		this.aaz093 = aaz093;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getResultid() {
		return resultid;
	}
	public void setResultid(String resultid) {
		this.resultid = resultid;
	}

	public String getLhfjndpddj() {
		return lhfjndpddj;
	}

	public void setLhfjndpddj(String lhfjndpddj) {
		this.lhfjndpddj = lhfjndpddj;
	}

	public String getAaa104() {
		return aaa104;
	}

	public void setAaa104(String aaa104) {
		this.aaa104 = aaa104;
	}

	public String getAaa102() {
		return aaa102;
	}

	public void setAaa102(String aaa102) {
		this.aaa102 = aaa102;
	}

	public String getUnchecked() {
		return unchecked;
	}

	public void setUnchecked(String unchecked) {
		this.unchecked = unchecked;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getChecking() {
		return checking;
	}

	public void setChecking(String checking) {
		this.checking = checking;
	}

	public String getPlanmobankind() {
		return planmobankind;
	}

	public void setPlanmobankind(String planmobankind) {
		this.planmobankind = planmobankind;
	}

	public String getPlancheckingcount() {
		return plancheckingcount;
	}

	public void setPlancheckingcount(String plancheckingcount) {
		this.plancheckingcount = plancheckingcount;
	}

	public String getComdalei() {
		return comdalei;
	}

	public void setComdalei(String comdalei) {
		this.comdalei = comdalei;
	}

	public String getQuerytype() {
		return querytype;
	}

	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}
}