package com.askj.exam.dto;

/**
 * @Description  OtsResultInfoDTO 的中文含义是: 参加考试结果信息表
 * @Creation     2017/03/13 17:01:51
 * @Written      Create Tool By zjf 
 **/
public class OtsResultInfoDTO {
	
	/**
	 * @Description userid的中文含义是： 用户id（手动添加）
	 */
	private String userid;
	
	/**
	 * @Description description的中文含义是： 用户描述（手动添加）
	 */
	private String description;
	
	/**
	 * @Description times的中文含义是： 考试次数（手动添加）
	 */
	private String times;
	
	/**
	 * @Description costtimes的中文含义是： 答卷时长（手动添加）
	 */
	private String costtimes;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTimes() {
		return times;
	}
	public void setTimes(String times) {
		this.times = times;
	}
	public String getCosttimes() {
		return costtimes;
	}
	public void setCosttimes(String costtimes) {
		this.costtimes = costtimes;
	}
	/**
	 * @Description resultInfoId的中文含义是： 考试结果ID
	 */
	private String resultInfoId;

	/**
	 * @Description resultInfoName的中文含义是： 考试名称
	 */
	private String resultInfoName;

	/**
	 * @Description resultInfoPoints的中文含义是： 考试总分
	 */
	private String resultInfoPoints;

	/**
	 * @Description resultInfoScores的中文含义是： 考试得分
	 */
	private String resultInfoScores;

	/**
	 * @Description resultInfoPass的中文含义是： 及格分数
	 */
	private String resultInfoPass;

	/**
	 * @Description examInfoId的中文含义是： 参加考试的ID(这个考试可能被删除)
	 */
	private String examInfoId;

	/**
	 * @Description paperInfoId的中文含义是： 考试使用的试卷ID(这个试卷可能被删除)
	 */
	private String paperInfoId;

	/**
	 * @Description paperdata的中文含义是： 使用的卷子数据
	 */
	private String paperdata;

	/**
	 * @Description resultdata的中文含义是： 用户提交的数据
	 */
	private String resultdata;

	/**
	 * @Description startTime的中文含义是： 开始考试时间
	 */
	private String startTime;

	/**
	 * @Description endTime的中文含义是： 提交考试时间
	 */
	private String endTime;

	/**
	 * @Description remark的中文含义是： 考试总评
	 */
	private String remark;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	private String aae036;

	
		/**
	 * @Description resultInfoId的中文含义是： 考试结果ID
	 */
	public void setResultInfoId(String resultInfoId){ 
		this.resultInfoId = resultInfoId;
	}
	/**
	 * @Description resultInfoId的中文含义是： 考试结果ID
	 */
	public String getResultInfoId(){
		return resultInfoId;
	}
	/**
	 * @Description resultInfoName的中文含义是： 考试名称
	 */
	public void setResultInfoName(String resultInfoName){ 
		this.resultInfoName = resultInfoName;
	}
	/**
	 * @Description resultInfoName的中文含义是： 考试名称
	 */
	public String getResultInfoName(){
		return resultInfoName;
	}
	/**
	 * @Description resultInfoPoints的中文含义是： 考试总分
	 */
	public void setResultInfoPoints(String resultInfoPoints){ 
		this.resultInfoPoints = resultInfoPoints;
	}
	/**
	 * @Description resultInfoPoints的中文含义是： 考试总分
	 */
	public String getResultInfoPoints(){
		return resultInfoPoints;
	}
	/**
	 * @Description resultInfoScores的中文含义是： 考试得分
	 */
	public void setResultInfoScores(String resultInfoScores){ 
		this.resultInfoScores = resultInfoScores;
	}
	/**
	 * @Description resultInfoScores的中文含义是： 考试得分
	 */
	public String getResultInfoScores(){
		return resultInfoScores;
	}
	/**
	 * @Description resultInfoPass的中文含义是： 及格分数
	 */
	public void setResultInfoPass(String resultInfoPass){ 
		this.resultInfoPass = resultInfoPass;
	}
	/**
	 * @Description resultInfoPass的中文含义是： 及格分数
	 */
	public String getResultInfoPass(){
		return resultInfoPass;
	}
	/**
	 * @Description examInfoId的中文含义是： 参加考试的ID(这个考试可能被删除)
	 */
	public void setExamInfoId(String examInfoId){ 
		this.examInfoId = examInfoId;
	}
	/**
	 * @Description examInfoId的中文含义是： 参加考试的ID(这个考试可能被删除)
	 */
	public String getExamInfoId(){
		return examInfoId;
	}
	/**
	 * @Description paperInfoId的中文含义是： 考试使用的试卷ID(这个试卷可能被删除)
	 */
	public void setPaperInfoId(String paperInfoId){ 
		this.paperInfoId = paperInfoId;
	}
	/**
	 * @Description paperInfoId的中文含义是： 考试使用的试卷ID(这个试卷可能被删除)
	 */
	public String getPaperInfoId(){
		return paperInfoId;
	}
	/**
	 * @Description paperdata的中文含义是： 使用的卷子数据
	 */
	public void setPaperdata(String paperdata){ 
		this.paperdata = paperdata;
	}
	/**
	 * @Description paperdata的中文含义是： 使用的卷子数据
	 */
	public String getPaperdata(){
		return paperdata;
	}
	/**
	 * @Description resultdata的中文含义是： 用户提交的数据
	 */
	public void setResultdata(String resultdata){ 
		this.resultdata = resultdata;
	}
	/**
	 * @Description resultdata的中文含义是： 用户提交的数据
	 */
	public String getResultdata(){
		return resultdata;
	}
	/**
	 * @Description startTime的中文含义是： 开始考试时间
	 */
	public void setStartTime(String startTime){ 
		this.startTime = startTime;
	}
	/**
	 * @Description startTime的中文含义是： 开始考试时间
	 */
	public String getStartTime(){
		return startTime;
	}
	/**
	 * @Description endTime的中文含义是： 提交考试时间
	 */
	public void setEndTime(String endTime){ 
		this.endTime = endTime;
	}
	/**
	 * @Description endTime的中文含义是： 提交考试时间
	 */
	public String getEndTime(){
		return endTime;
	}
	/**
	 * @Description remark的中文含义是： 考试总评
	 */
	public void setRemark(String remark){ 
		this.remark = remark;
	}
	/**
	 * @Description remark的中文含义是： 考试总评
	 */
	public String getRemark(){
		return remark;
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