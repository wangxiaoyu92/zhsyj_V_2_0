package com.askj.exam.dto;

/**
 * @Description  OTS_PAPERS_INFO的中文含义是: 试卷信息表DTO
 * @Creation     2017/02/24 16:17:23
 * @Written      Create Tool By zjf 
 **/
public class OtsPapersInfoDTO {
	
	/**
	 * @Description submitData的中文含义是： 用户提交数据（手动添加）
	 */
	private String submitData;

	public String getSubmitData() {
		return submitData;
	}
	public void setSubmitData(String submitData) {
		this.submitData = submitData;
	}

	/**
	 * @Description points的中文含义是： 试卷总分（手动添加）
	 */
	private String points;
	/**
	 * @Description total的中文含义是： 试卷总题数（手动添加）
	 */
	private String total;
	/**
	 * @Description examsInfoId的中文含义是： 试卷对应考试id（手动添加）
	 */
	private String examsInfoId;
	/**
	 * @Description examsName的中文含义是： 考试名称（手动添加）
	 */
	private String examsName;
	/**
	 * @Description resultMateId的中文含义是： 用户考试信息表id（手动添加）
	 */
	private String resultMateId;
	/**
	 * @Description paperInfoData的中文含义是： 试卷内容（手动添加）
	 */
	private String paperInfoData;
	
	public String getResultMateId() {
		return resultMateId;
	}
	public void setResultMateId(String resultMateId) {
		this.resultMateId = resultMateId;
	}
	public String getExamsName() {
		return examsName;
	}
	public void setExamsName(String examsName) {
		this.examsName = examsName;
	}
	public String getPaperInfoData() {
		return paperInfoData;
	}
	public void setPaperInfoData(String paperInfoData) {
		this.paperInfoData = paperInfoData;
	}
	public String getPoints() {
		return points;
	}
	public void setPoints(String points) {
		this.points = points;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getExamsInfoId() {
		return examsInfoId;
	}
	public void setExamsInfoId(String examsInfoId) {
		this.examsInfoId = examsInfoId;
	}

	/**
	 * @Description paperInfoId的中文含义是： 试卷ID
	 */
	private String paperInfoId;

	/**
	 * @Description paperInfoState的中文含义是： 试卷状态,0=禁用,1=启用
	 */
	private String paperInfoState;

	/**
	 * @Description paperInfoPass的中文含义是： 及格分数
	 */
	private String paperInfoPass;

	/**
	 * @Description paperInfoName的中文含义是： 试卷名称
	 */
	private String paperInfoName;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	private String aae013;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
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

	
}