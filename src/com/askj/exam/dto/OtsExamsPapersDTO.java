package com.askj.exam.dto;

/**
 * @Description  OtsExamsPapersDTO 的中文含义是: 考试缓存试卷表
 * @Creation     2017/03/08 14:23:45
 * @Written      Create Tool By zjf 
 **/
public class OtsExamsPapersDTO {
	/**
	 * @Description examsPapersId的中文含义是： 数据ID
	 */
	private String examsPapersId;

	/**
	 * @Description examsInfoId的中文含义是： 关联考试信息ID
	 */
	private String examsInfoId;

	/**
	 * @Description paperInfoId的中文含义是： 所使用的试卷ID
	 */
	private String paperInfoId;

	/**
	 * @Description points的中文含义是： 试卷总分
	 */
	private String points;

	/**
	 * @Description data的中文含义是： 缓存的试卷数据
	 */
	private String data;

	/**
	 * @Description modified的中文含义是： 修改时间
	 */
	private String modified;

	/**
	 * @Description examsPapersId的中文含义是： 数据ID
	 */
	public void setExamsPapersId(String examsPapersId){ 
		this.examsPapersId = examsPapersId;
	}
	/**
	 * @Description examsPapersId的中文含义是： 数据ID
	 */
	public String getExamsPapersId(){
		return examsPapersId;
	}
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
	 * @Description paperInfoId的中文含义是： 所使用的试卷ID
	 */
	public void setPaperInfoId(String paperInfoId){ 
		this.paperInfoId = paperInfoId;
	}
	/**
	 * @Description paperInfoId的中文含义是： 所使用的试卷ID
	 */
	public String getPaperInfoId(){
		return paperInfoId;
	}
	/**
	 * @Description points的中文含义是： 试卷总分
	 */
	public void setPoints(String points){ 
		this.points = points;
	}
	/**
	 * @Description points的中文含义是： 试卷总分
	 */
	public String getPoints(){
		return points;
	}
	/**
	 * @Description data的中文含义是： 缓存的试卷数据
	 */
	public void setData(String data){ 
		this.data = data;
	}
	/**
	 * @Description data的中文含义是： 缓存的试卷数据
	 */
	public String getData(){
		return data;
	}
	/**
	 * @Description modified的中文含义是： 修改时间
	 */
	public void setModified(String modified){ 
		this.modified = modified;
	}
	/**
	 * @Description modified的中文含义是： 修改时间
	 */
	public String getModified(){
		return modified;
	}

	
}