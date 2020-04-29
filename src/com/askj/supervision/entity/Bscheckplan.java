package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  BSCHECKPLAN的中文含义是: 检查计划表; InnoDB free: 2689024 kB
 * @Creation     2016/05/17 09:30:10
 * @Written      Create Tool By zjf 
 **/
@Table(value = "BSCHECKPLAN")
public class Bscheckplan {
	/**
	 * @Description planid的中文含义是： 计划主键
	 */
	 @Column 
	 @Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_planid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_planid.nextval from dual"))
	private String planid;

	/**
	 * @Description plancode的中文含义是： 计划编号
	 */
	@Column
	private String plancode;

	/**
	 * @Description plantitle的中文含义是： 计划标题
	 */
	@Column
	private String plantitle;

	/**
	 * @Description planchecktype的中文含义是： 计划检查类别
	 */
	@Column
	private String planchecktype;

	/**
	 * @Description plantype的中文含义是： 计划类型
	 */
	@Column
	private String plantype;

	/**
	 * @Description plantypearea的中文含义是： 计划适用范围
	 */
	@Column
	private String plantypearea;

	/**
	 * @Description planstdate的中文含义是： 计划开始时间
	 */
	@Column
	private String planstdate;

	/**
	 * @Description planeddate的中文含义是： 计划结束时间
	 */
	@Column
	private String planeddate;

	/**
	 * @Description plancontent的中文含义是： 计划内容
	 */
	@Column
	private String plancontent;

	/**
	 * @Description planremark的中文含义是： 计划备注
	 */
	@Column
	private String planremark;

	/**
	 * @Description planoperatedate的中文含义是： 计划经办时间
	 */
	@Column
	private String planoperatedate;

	/**
	 * @Description planoperator的中文含义是： 计划经办人
	 */
	@Column
	private String planoperator;

	/**
	 * @Description planoperator的中文含义是： 评定等级
	 */
	@Column
	private String lhfjndpddj;

	/**
	 * @Description planmobankind的中文含义是： 计划模板类型aa10=PLANMOBANKIND
	 */
	@Column
	private String planmobankind;



	
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

	public String getLhfjndpddj() {
		return lhfjndpddj;
	}

	public void setLhfjndpddj(String lhfjndpddj) {
		this.lhfjndpddj = lhfjndpddj;
	}

	public String getPlanmobankind() {
		return planmobankind;
	}

	public void setPlanmobankind(String planmobankind) {
		this.planmobankind = planmobankind;
	}
}