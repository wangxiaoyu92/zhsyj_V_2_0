package com.askj.exam.dto;

/**
 * @Description  OtsExamsDataDTO 的中文含义是: 考试数据表
 * @Creation     2017/03/08 14:22:32
 * @Written      Create Tool By zjf 
 **/
public class OtsExamsDataDTO {
	
	/**
	 * @Description points的中文含义是： 试卷总分（手动添加）
	 */
	private String points;
	
	/**
	 * @Description total的中文含义是： 试卷总题数（手动添加）
	 */
	private String total;
	
	/**
	 * @Description paperInfoState的中文含义是： 试卷状态（启用/禁用）(手动添加)
	 */
	private String paperInfoState;
	
	/**
	 * @Description paperInfoPass的中文含义是： 试卷及格分数（手动添加）
	 */
	private String paperInfoPass;
	
	/**
	 * @Description paperInfoName的中文含义是： 试卷名称（手动添加）
	 */
	private String paperInfoName;
	
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
	public String getPaperInfoState() {
		return paperInfoState;
	}
	public void setPaperInfoState(String paperInfoState) {
		this.paperInfoState = paperInfoState;
	}
	public String getPaperInfoPass() {
		return paperInfoPass;
	}
	public void setPaperInfoPass(String paperInfoPass) {
		this.paperInfoPass = paperInfoPass;
	}
	public String getPaperInfoName() {
		return paperInfoName;
	}
	public void setPaperInfoName(String paperInfoName) {
		this.paperInfoName = paperInfoName;
	}
	/**
	 * @Description examsDataId的中文含义是： 考试数据ID
	 */
	private String examsDataId;

	/**
	 * @Description examsInfoId的中文含义是： 关联考试信息ID
	 */
	private String examsInfoId;

	/**
	 * @Description paperInfoId的中文含义是： 关联试卷ID
	 */
	private String paperInfoId;

	/**
	 * @Description examsDataSort的中文含义是： 当前结构在整体的位置
	 */
	private String examsDataSort;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	private String aae036;

	/**
	 * @Description examsDataId的中文含义是： 考试数据ID
	 */
	public void setExamsDataId(String examsDataId){ 
		this.examsDataId = examsDataId;
	}
	/**
	 * @Description examsDataId的中文含义是： 考试数据ID
	 */
	public String getExamsDataId(){
		return examsDataId;
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
	 * @Description paperInfoId的中文含义是： 关联试卷ID
	 */
	public void setPaperInfoId(String paperInfoId){ 
		this.paperInfoId = paperInfoId;
	}
	/**
	 * @Description paperInfoId的中文含义是： 关联试卷ID
	 */
	public String getPaperInfoId(){
		return paperInfoId;
	}
	/**
	 * @Description examsDataSort的中文含义是： 当前结构在整体的位置
	 */
	public void setExamsDataSort(String examsDataSort){ 
		this.examsDataSort = examsDataSort;
	}
	/**
	 * @Description examsDataSort的中文含义是： 当前结构在整体的位置
	 */
	public String getExamsDataSort(){
		return examsDataSort;
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