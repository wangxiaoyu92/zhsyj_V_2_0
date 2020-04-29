package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OtsExamsMate的中文含义是: 考试功能信息表
 * @Creation     2017/03/08 14:23:23
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_exams_mate")
public class OtsExamsMate {
	/**
	 * @Description examsInfoId的中文含义是： 关联考试信息ID
	 */
	@Column ( value = "exams_info_id" )
	@Name
	private String examsInfoId;

	/**
	 * @Description examsName的中文含义是： 考试名称
	 */
	@Column ( value = "exams_name" )
	private String examsName;

	/**
	 * @Description examsType的中文含义是： 考试类型,0=练习,1=考试
	 */
	@Column ( value = "exams_type" )
	private String examsType;

	/**
	 * @Description examsNotice的中文含义是： 考试须知
	 */
	@Column ( value = "exams_notice" )
	private String examsNotice;

	/**
	 * @Description examsCategory的中文含义是： 考试分类(与基本信息表关联)
	 */
	@Column ( value = "exams_category" )
	private String examsCategory;

	/**
	 * @Description duration的中文含义是： 考试限时，0等于不限时
	 */
	@Column
	private String duration;

	/**
	 * @Description startTime的中文含义是： 开始时间
	 */
	@Column
	private String startTime;

	/**
	 * @Description endTime的中文含义是： 结束时间
	 */
	@Column
	private String endTime;

	/**
	 * @Description examMode的中文含义是： 考试方式,1=整卷,2=逐题
	 */
	@Column
	private String examMode;

	/**
	 * @Description maxTimes的中文含义是： 最大参考次数，默认=0不限次数
	 */
	@Column
	private String maxTimes;

	/**
	 * @Description unityPoint的中文含义是： 统一总分,0=使用卷面总分
	 */
	@Column
	private String unityPoint;

	/**
	 * @Description resultPublishTime的中文含义是： 考试结果发布时间,"1970-01-01 00:00:00"为永不发布“1970-01-01 01:01:01”=交卷后立即发布
	 */
	@Column
	private String resultPublishTime;

	/**
	 * @Description allowIp的中文含义是： 限制学习IP段,'ip1-ip2,ip3-ip4'
	 */
	@Column
	private String allowIp;

	/**
	 * @Description unityDuration的中文含义是： 统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时
	 */
	@Column
	private String unityDuration;

	/**
	 * @Description isResultRank的中文含义是： 是否显示排行榜,0=不显示,1=显示
	 */
	@Column
	private String isResultRank;

	/**
	 * @Description isAntiCheat的中文含义是： 是否防作弊,0=开卷考试,1=防作弊考试
	 */
	@Column
	private String isAntiCheat;

	/**
	 * @Description isListShow的中文含义是： 是否在考试列表中显示,0=不显示,1=显示
	 */
	@Column
	private String isListShow;

	/**
	 * @Description isQuestionsRandom的中文含义是： 是否随机显示试题,0=正常显示,1=随机显示
	 */
	@Column
	private String isQuestionsRandom;

	/**
	 * @Description isSurveillance的中文含义是： 是否启用考试监控,0=不开起,1=启用
	 */
	@Column
	private String isSurveillance;

	/**
	 * @Description signUpStartTime的中文含义是： 报名起始时间
	 */
	@Column
	private String signUpStartTime;

	/**
	 * @Description signUpEndTime的中文含义是： 报名结束时间,"1970-01-01 00:00:00"=考试无需报名,"1970-01-01 00:00:01"=以考试结束时间为报名截止时间
	 */
	@Column
	private String signUpEndTime;

	/**
	 * @Description disableExam的中文含义是： 禁止进入考场时间(m),0=不限制
	 */
	@Column
	private String disableExam;

	/**
	 * @Description disablesubmit的中文含义是： 禁止提前交卷时间
	 */
	@Column
	private String disablesubmit;

	/**
	 * @Description coverImg的中文含义是： 考试封面
	 */
	@Column ( value = "cover_img" )
	private String coverImg;

	/**
	 * @Description credit的中文含义是： 考试所需金额
	 */
	@Column
	private String credit;

	/**
	 * @Description unPass的中文含义是： 及格后不能再考，0=不限制，1及格后不能再考
	 */
	@Column
	private String unPass;

	/**
	 * @Description publishAnswerFlg的中文含义是： 是否允许考生查看答案(1:是;0:否;)
	 */
	@Column
	private String publishAnswerFlg;

	/**
	 * @Description examModePrev的中文含义是： 逐题模式，是否允许查看上一题0=不允许，1=允许
	 */
	@Column
	private String examModePrev;

	/**
	 * @Description examManual的中文含义是： 是否需要人工评卷
	 */
	@Column
	private String examManual;

	/**
	 * @Description isDisableUserInfo的中文含义是： 评卷时是否屏蔽考生信息
	 */
	@Column
	private String isDisableUserInfo;

	/**
	 * @Description examWay的中文含义是： 线上/线下
	 */
	@Column
	private String examWay;

	/**
	 * @Description offlineScore的中文含义是： 线下总分
	 */
	@Column
	private String offlineScore;

	/**
	 * @Description offlinePass的中文含义是： 线下及格分
	 */
	@Column
	private String offlinePass;

	/**
	 * @Description examModeAnswer的中文含义是： 逐题查看答案（0-不允许，1-允许）
	 */
	@Column
	private String examModeAnswer;

	/**
	 * @Description noAll的中文含义是： 禁止右键、剪切、复制、粘贴
	 */
	@Column
	private String noAll;

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
	 * @Description examsInfoId的中文含义是： 关联考试信息ID
	 */
	public void setExamsInfoId(String examsInfoId){ 
		this.examsInfoId = examsInfoId;
	}
	/**
	 * @Description examsInfoId的中文含义是： 关联考试信息ID
	 */
	public String getExamsInfoId(){
		return examsInfoId;
	}
	/**
	 * @Description examsName的中文含义是： 考试名称
	 */
	public void setExamsName(String examsName){ 
		this.examsName = examsName;
	}
	/**
	 * @Description examsName的中文含义是： 考试名称
	 */
	public String getExamsName(){
		return examsName;
	}
	/**
	 * @Description examsType的中文含义是： 考试类型,0=练习,1=考试
	 */
	public void setExamsType(String examsType){ 
		this.examsType = examsType;
	}
	/**
	 * @Description examsType的中文含义是： 考试类型,0=练习,1=考试
	 */
	public String getExamsType(){
		return examsType;
	}
	/**
	 * @Description examsNotice的中文含义是： 考试须知
	 */
	public void setExamsNotice(String examsNotice){ 
		this.examsNotice = examsNotice;
	}
	/**
	 * @Description examsNotice的中文含义是： 考试须知
	 */
	public String getExamsNotice(){
		return examsNotice;
	}
	/**
	 * @Description examsCategory的中文含义是： 考试分类(与基本信息表关联)
	 */
	public void setExamsCategory(String examsCategory){ 
		this.examsCategory = examsCategory;
	}
	/**
	 * @Description examsCategory的中文含义是： 考试分类(与基本信息表关联)
	 */
	public String getExamsCategory(){
		return examsCategory;
	}
	/**
	 * @Description duration的中文含义是： 考试限时，0等于不限时
	 */
	public void setDuration(String duration){ 
		this.duration = duration;
	}
	/**
	 * @Description duration的中文含义是： 考试限时，0等于不限时
	 */
	public String getDuration(){
		return duration;
	}
	/**
	 * @Description startTime的中文含义是： 开始时间
	 */
	public void setStartTime(String startTime){ 
		this.startTime = startTime;
	}
	/**
	 * @Description startTime的中文含义是： 开始时间
	 */
	public String getStartTime(){
		return startTime;
	}
	/**
	 * @Description endTime的中文含义是： 结束时间
	 */
	public void setEndTime(String endTime){ 
		this.endTime = endTime;
	}
	/**
	 * @Description endtime的中文含义是： 结束时间
	 */
	public String getEndTime(){
		return endTime;
	}
	/**
	 * @Description examMode的中文含义是： 考试方式,1=整卷,2=逐题
	 */
	public void setExamMode(String examMode){ 
		this.examMode = examMode;
	}
	/**
	 * @Description exammode的中文含义是： 考试方式,1=整卷,2=逐题
	 */
	public String getExamMode(){
		return examMode;
	}
	/**
	 * @Description maxTimes的中文含义是： 最大参考次数，默认=0不限次数
	 */
	public void setMaxTimes(String maxTimes){ 
		this.maxTimes = maxTimes;
	}
	/**
	 * @Description maxTimes的中文含义是： 最大参考次数，默认=0不限次数
	 */
	public String getMaxTimes(){
		return maxTimes;
	}
	/**
	 * @Description unityPoint的中文含义是： 统一总分,0=使用卷面总分
	 */
	public void setUnityPoint(String unityPoint){ 
		this.unityPoint = unityPoint;
	}
	/**
	 * @Description unityPoint的中文含义是： 统一总分,0=使用卷面总分
	 */
	public String getUnityPoint(){
		return unityPoint;
	}
	/**
	 * @Description resultPublishTime的中文含义是： 考试结果发布时间,"1970-01-01 00:00:00"为永不发布“1970-01-01 01:01:01”=交卷后立即发布
	 */
	public void setResultPublishTime(String resultPublishTime){ 
		this.resultPublishTime = resultPublishTime;
	}
	/**
	 * @Description resultPublishTime的中文含义是： 考试结果发布时间,"1970-01-01 00:00:00"为永不发布“1970-01-01 01:01:01”=交卷后立即发布
	 */
	public String getResultPublishTime(){
		return resultPublishTime;
	}
	/**
	 * @Description allowip的中文含义是： 限制学习IP段,'ip1-ip2,ip3-ip4'
	 */
	public void setAllowIp(String allowIp){ 
		this.allowIp = allowIp;
	}
	/**
	 * @Description allowip的中文含义是： 限制学习IP段,'ip1-ip2,ip3-ip4'
	 */
	public String getAllowIp(){
		return allowIp;
	}
	/**
	 * @Description unityDuration的中文含义是： 统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时
	 */
	public void setUnityDuration(String unityDuration){ 
		this.unityDuration = unityDuration;
	}
	/**
	 * @Description unityDuration的中文含义是： 统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时
	 */
	public String getUnityDuration(){
		return unityDuration;
	}
	/**
	 * @Description isresultrank的中文含义是： 是否显示排行榜,0=不显示,1=显示
	 */
	public void setIsResultRank(String isResultRank){ 
		this.isResultRank = isResultRank;
	}
	/**
	 * @Description isResultRank的中文含义是： 是否显示排行榜,0=不显示,1=显示
	 */
	public String getIsResultRank(){
		return isResultRank;
	}
	/**
	 * @Description isAntiCheat的中文含义是： 是否防作弊,0=开卷考试,1=防作弊考试
	 */
	public void setIsAntiCheat(String isAntiCheat){ 
		this.isAntiCheat = isAntiCheat;
	}
	/**
	 * @Description isAntiCheat的中文含义是： 是否防作弊,0=开卷考试,1=防作弊考试
	 */
	public String getIsAntiCheat(){
		return isAntiCheat;
	}
	/**
	 * @Description isListShow的中文含义是： 是否在考试列表中显示,0=不显示,1=显示
	 */
	public void setIsListShow(String isListShow){ 
		this.isListShow = isListShow;
	}
	/**
	 * @Description isListShow的中文含义是： 是否在考试列表中显示,0=不显示,1=显示
	 */
	public String getIsListShow(){
		return isListShow;
	}
	/**
	 * @Description isQuestionsRandom的中文含义是： 是否随机显示试题,0=正常显示,1=随机显示
	 */
	public void setIsQuestionsRandom(String isQuestionsRandom){ 
		this.isQuestionsRandom = isQuestionsRandom;
	}
	/**
	 * @Description isQuestionsRandom的中文含义是： 是否随机显示试题,0=正常显示,1=随机显示
	 */
	public String getIsQuestionsRandom(){
		return isQuestionsRandom;
	}
	/**
	 * @Description isSurveillance的中文含义是： 是否启用考试监控,0=不开起,1=启用
	 */
	public void setIsSurveillance(String isSurveillance){ 
		this.isSurveillance = isSurveillance;
	}
	/**
	 * @Description isSurveillance的中文含义是： 是否启用考试监控,0=不开起,1=启用
	 */
	public String getIsSurveillance(){
		return isSurveillance;
	}
	/**
	 * @Description signUpStartTime的中文含义是： 报名起始时间
	 */
	public void setSignUpStartTime(String signUpStartTime){ 
		this.signUpStartTime = signUpStartTime;
	}
	/**
	 * @Description signUpStartTime的中文含义是： 报名起始时间
	 */
	public String getSignUpStartTime(){
		return signUpStartTime;
	}
	/**
	 * @Description signUpEndTime的中文含义是： 报名结束时间,"1970-01-01 00:00:00"=考试无需报名,"1970-01-01 00:00:01"=以考试结束时间为报名截止时间
	 */
	public void setSignUpEndTime(String signUpEndTime){ 
		this.signUpEndTime = signUpEndTime;
	}
	/**
	 * @Description signUpEndTime的中文含义是： 报名结束时间,"1970-01-01 00:00:00"=考试无需报名,"1970-01-01 00:00:01"=以考试结束时间为报名截止时间
	 */
	public String getSignUpEndTime(){
		return signUpEndTime;
	}
	/**
	 * @Description disableExam的中文含义是： 禁止进入考场时间(m),0=不限制
	 */
	public void setDisableExam(String disableExam){ 
		this.disableExam = disableExam;
	}
	/**
	 * @Description disableExam的中文含义是： 禁止进入考场时间(m),0=不限制
	 */
	public String getDisableExam(){
		return disableExam;
	}
	/**
	 * @Description disablesubmit的中文含义是： 禁止提前交卷时间
	 */
	public void setDisablesubmit(String disablesubmit){ 
		this.disablesubmit = disablesubmit;
	}
	/**
	 * @Description disablesubmit的中文含义是： 禁止提前交卷时间
	 */
	public String getDisablesubmit(){
		return disablesubmit;
	}
	/**
	 * @Description coverImg的中文含义是： 考试封面
	 */
	public void setCoverImg(String coverImg){ 
		this.coverImg = coverImg;
	}
	/**
	 * @Description coverImg的中文含义是： 考试封面
	 */
	public String getCoverImg(){
		return coverImg;
	}
	/**
	 * @Description credit的中文含义是： 考试所需金额
	 */
	public void setCredit(String credit){ 
		this.credit = credit;
	}
	/**
	 * @Description credit的中文含义是： 考试所需金额
	 */
	public String getCredit(){
		return credit;
	}
	/**
	 * @Description unPass的中文含义是： 及格后不能再考，0=不限制，1及格后不能再考
	 */
	public void setUnPass(String unPass){ 
		this.unPass = unPass;
	}
	/**
	 * @Description unPass的中文含义是： 及格后不能再考，0=不限制，1及格后不能再考
	 */
	public String getUnPass(){
		return unPass;
	}
	/**
	 * @Description publishAnswerFlg的中文含义是： 是否允许考生查看答案(1:是;0:否;)
	 */
	public void setPublishAnswerFlg(String publishAnswerFlg){ 
		this.publishAnswerFlg = publishAnswerFlg;
	}
	/**
	 * @Description publishAnswerFlg的中文含义是： 是否允许考生查看答案(1:是;0:否;)
	 */
	public String getPublishAnswerFlg(){
		return publishAnswerFlg;
	}
	/**
	 * @Description examModePrev的中文含义是： 逐题模式，是否允许查看上一题0=不允许，1=允许
	 */
	public void setExamModePrev(String examModePrev){ 
		this.examModePrev = examModePrev;
	}
	/**
	 * @Description examModePrev的中文含义是： 逐题模式，是否允许查看上一题0=不允许，1=允许
	 */
	public String getExamModePrev(){
		return examModePrev;
	}
	/**
	 * @Description examManual的中文含义是： 是否需要人工评卷
	 */
	public void setExamManual(String examManual){ 
		this.examManual = examManual;
	}
	/**
	 * @Description examManual的中文含义是： 是否需要人工评卷
	 */
	public String getExamManual(){
		return examManual;
	}
	/**
	 * @Description isDisableUserInfo的中文含义是： 评卷时是否屏蔽考生信息
	 */
	public void setIsDisableUserInfo(String isDisableUserInfo){ 
		this.isDisableUserInfo = isDisableUserInfo;
	}
	/**
	 * @Description isDisableUserInfo的中文含义是： 评卷时是否屏蔽考生信息
	 */
	public String getIsDisableUserInfo(){
		return isDisableUserInfo;
	}
	/**
	 * @Description examWay的中文含义是： 线上/线下
	 */
	public void setExamWay(String examWay){ 
		this.examWay = examWay;
	}
	/**
	 * @Description examWay的中文含义是： 线上/线下
	 */
	public String getExamWay(){
		return examWay;
	}
	/**
	 * @Description offlineScore的中文含义是： 线下总分
	 */
	public void setOfflineScore(String offlineScore){ 
		this.offlineScore = offlineScore;
	}
	/**
	 * @Description offlineScore的中文含义是： 线下总分
	 */
	public String getOfflineScore(){
		return offlineScore;
	}
	/**
	 * @Description offlinePass的中文含义是： 线下及格分
	 */
	public void setOfflinePass(String offlinePass){ 
		this.offlinePass = offlinePass;
	}
	/**
	 * @Description offlinePass的中文含义是： 线下及格分
	 */
	public String getOfflinePass(){
		return offlinePass;
	}
	/**
	 * @Description examModeAnswer的中文含义是： 逐题查看答案（0-不允许，1-允许）
	 */
	public void setExamModeAnswer(String examModeAnswer){ 
		this.examModeAnswer = examModeAnswer;
	}
	/**
	 * @Description examModeAnswer的中文含义是： 逐题查看答案（0-不允许，1-允许）
	 */
	public String getExamModeAnswer(){
		return examModeAnswer;
	}
	/**
	 * @Description noAll的中文含义是： 禁止右键、剪切、复制、粘贴
	 */
	public void setNoAll(String noAll){ 
		this.noAll = noAll;
	}
	/**
	 * @Description noAll的中文含义是： 禁止右键、剪切、复制、粘贴
	 */
	public String getNoAll(){
		return noAll;
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
		return " { 'examsInfoId' : '" + examsInfoId + "', 'examsName' : '"
				+ examsName + "', 'examsType' : '" + examsType + "', 'examsNotice' : '"
				+ examsNotice + "', 'examsCategory' : '" + examsCategory
				+ "', 'duration' : '" + duration + "', 'startTime' : '" + startTime
				+ "', 'endTime' : '" + endTime + "', 'examMode' : '" + examMode
				+ "', 'maxTimes' : '" + maxTimes + "', 'unityPoint' : '" + unityPoint
				+ "', 'resultPublishTime' : '" + resultPublishTime + "', 'allowIp' : '"
				+ allowIp + "', 'unityDuration' : '" + unityDuration
				+ "', 'isResultRank' : '" + isResultRank + "', 'isAntiCheat' : '"
				+ isAntiCheat + "', 'isListShow' : '" + isListShow
				+ "', 'isQuestionsRandom' : '" + isQuestionsRandom
				+ "', 'isSurveillance' : '" + isSurveillance + "', 'signUpStartTime' : '"
				+ signUpStartTime + "', 'signUpEndTime' : '" + signUpEndTime
				+ "', 'disableExam' : '" + disableExam + "', 'disablesubmit' : '"
				+ disablesubmit + "', 'coverImg' : '" + coverImg + "', 'credit' : '"
				+ credit + "', 'unPass' : '" + unPass + "', 'publishAnswerFlg' : '"
				+ publishAnswerFlg + "', 'examModePrev' : '" + examModePrev
				+ "', 'examManual' : '" + examManual + "', 'isDisableUserInfo' : '"
				+ isDisableUserInfo + "', 'examWay' : '" + examWay
				+ "', 'offlineScore' : '" + offlineScore + "', 'offlinePass' : '"
				+ offlinePass + "', 'examModeAnswer' : '" + examModeAnswer
				+ "', 'noAll' : '" + noAll + "', 'aae011' : '" + aae011 + "', 'aae036' : '"
				+ aae036 + "' } ";
	}
	
}