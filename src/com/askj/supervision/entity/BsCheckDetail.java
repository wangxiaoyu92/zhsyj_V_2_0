package com.askj.supervision.entity;

import java.util.Date;
import org.nutz.dao.entity.annotation.*;


/**
 * Bscheckdetail的中文名称：检查结果明细类
 * Written by:syf
 */
@Table(value = "BSCHECKDETAIL")
public class BsCheckDetail {
	/**扩展开始*/
	/**
	 * operatetype 的中文名称：操作类型
	 */
	@Readonly
	private String operatetype;
	//扩展结束

	/**
	 * detailid 的中文名称：明细ID
	 */
	 @Column 
	 @Name
	private String detailid;

	/**
	 * taskdetailid 的中文名称：任务明细主键
	 */
	private String taskdetailid;
	 
	/**
	 * resultid 的中文名称：结果ID
	 */
	 @Column 
	private String resultid;

	/**
	 * contentid 的中文名称：内容ID
	 */
	 @Column 
	private String contentid;

	/**
	 * detaildecide 的中文名称：明细结果判定
	 */
	 @Column 
	private String detaildecide;

	/**
	 * detailscore 的中文名称：明细得分
	 */
	 @Column 
	private double detailscore;

	/**
	 * detailng 的中文名称：明细不符合项说明
	 */
	 @Column 
	private String detailng;

	/**
	 * detailattachment 的中文名称：明细附件
	 */
	 @Column 
	private String detailattachment;

	/**
	 * detailremark 的中文名称：明细备注
	 */
	 @Column 
	private String detailremark;

	/**
	 * detailoperatedate 的中文名称：明细经办日期
	 */
	 @Column 
	private Date detailoperatedate;

	/**
	 * detailoperateperson 的中文名称：明细经办人
	 */
	 @Column 
	private String detailoperateperson;

	/**
	 * detailcheckdate 的中文名称：明细核查日期
	 */
	 @Column 
	private Date detailcheckdate;

	/**
	 * detailcheckperson 的中文名称：明细检查人
	 */
	 @Column 
	private String detailcheckperson;


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
	public void setDetailoperatedate(Date detailoperatedate){
		this.detailoperatedate=detailoperatedate;
	}

	/**
	 * 
	 * getDetailoperatedate的中文名称：获取明细经办日期
	 *
	 * @return Date
	 * Written by:syf
	 */
	public Date getDetailoperatedate(){
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
	public void setDetailcheckdate(Date detailcheckdate){
		this.detailcheckdate=detailcheckdate;
	}

	/**
	 * 
	 * getDetailcheckdate的中文名称：获取明细核查日期
	 *
	 * @return Date
	 * Written by:syf
	 */
	public Date getDetailcheckdate(){
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

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}
}
