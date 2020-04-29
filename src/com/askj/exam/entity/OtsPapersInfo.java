package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OTS_PAPERS_INFO的中文含义是: 试卷信息表
 * @Creation     2017/02/24 16:17:15
 * @Written      Create Tool By zjf 
 **/
@Table(value = "OTS_PAPERS_INFO")
public class OtsPapersInfo {
	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	@Column(value = "paper_info_id")
	@Name
	private String paperInfoId;

	/**
	 * @Description paperInfoState的中文含义是： 试卷状态,0=禁用,1=启用
	 */
	@Column(value = "paper_info_state")
	private String paperInfoState;

	/**
	 * @Description paperInfoPass的中文含义是： 及格分数
	 */
	@Column(value = "paper_info_pass")
	private String paperInfoPass;

	/**
	 * @Description paperInfoName的中文含义是： 试卷名称
	 */
	@Column(value = "paper_info_name")
	private String paperInfoName;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	@Column
	private String aae013;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
	private String aae036;

	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	public String getPaperInfoId() {
		return paperInfoId;
	}
	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	public void setPaperInfoId(String paperInfoId) {
		this.paperInfoId = paperInfoId;
	}
	/**
	 * @Description paperInfoState的中文含义是： 试卷状态,0=禁用,1=启用
	 */
	public String getPaperInfoState() {
		return paperInfoState;
	}
	/**
	 * @Description paperInfoState的中文含义是： 试卷状态,0=禁用,1=启用
	 */
	public void setPaperInfoState(String paperInfoState) {
		this.paperInfoState = paperInfoState;
	}
	/**
	 * @Description paperInfoPass的中文含义是： 及格分数
	 */
	public String getPaperInfoPass() {
		return paperInfoPass;
	}
	/**
	 * @Description paperInfoPass的中文含义是： 及格分数
	 */
	public void setPaperInfoPass(String paperInfoPass) {
		this.paperInfoPass = paperInfoPass;
	}
	/**
	 * @Description paperInfoName的中文含义是： 试卷名称
	 */
	public String getPaperInfoName() {
		return paperInfoName;
	}
	/**
	 * @Description paperInfoName的中文含义是： 试卷名称
	 */
	public void setPaperInfoName(String paperInfoName) {
		this.paperInfoName = paperInfoName;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public void setAae013(String aae013){ 
		this.aae013 = aae013;
	}
	/**
	 * @Description aae013的中文含义是： 备注
	 */
	public String getAae013(){
		return aae013;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public String getAae036(){
		return aae036;
	}
	@Override
	public String toString() {
		return "{ 'paperInfoId' : '" + paperInfoId
				+ "', 'paperInfoState' : '" + paperInfoState
				+ "', 'paperInfoPass' : '" + paperInfoPass + "', 'paperInfoName' :"
				+ paperInfoName + "', 'aae013' : '" + aae013 + "', 'aae011' : '" + aae011
				+ "', 'aae036' : '" + aae036 + "' }";
	}
	
	
}