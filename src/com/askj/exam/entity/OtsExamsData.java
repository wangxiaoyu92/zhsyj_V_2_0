package com.askj.exam.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  OtsExamsData的中文含义是: 考试数据表
 * @Creation     2017/03/08 14:22:41
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ots_exams_data")
public class OtsExamsData {
	/**
	 * @Description examsDataId的中文含义是： 考试数据ID
	 */
	@Column ( value = "exams_data_id" )
	@Name
	private String examsDataId;

	/**
	 * @Description examsInfoId的中文含义是： 关联考试信息ID
	 */
	@Column ( value = "exams_info_id" )
	private String examsInfoId;

	/**
	 * @Description paperInfoId的中文含义是： 关联试卷ID
	 */
	@Column ( value = "paper_info_id" )
	private String paperInfoId;

	/**
	 * @Description examsDataSort的中文含义是： 当前结构在整体的位置
	 */
	@Column ( value = "exams_data_sort" )
	private String examsDataSort;

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
	@Override
	public String toString() {
		return " { 'examsDataId' : '" + examsDataId + "', 'examsInfoId' : '"
				+ examsInfoId + "', 'paperInfoId' : '" + paperInfoId
				+ "', 'examsDataSort' : '" + examsDataSort + "', 'aae011' : '" + aae011
				+ "', 'aae036' : '" + aae036 + "' } ";
	}
	
	
	
}