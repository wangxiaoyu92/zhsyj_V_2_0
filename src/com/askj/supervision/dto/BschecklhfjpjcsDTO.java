package com.askj.supervision.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  BSCHECKLHFJPJCS的中文含义是: 量化分级评级参数表; InnoDB free: 784384 kBDTO
 * @Creation     2017/02/22 11:40:09
 * @Written      Create Tool By zjf 
 **/
public class BschecklhfjpjcsDTO {
	/**
	 * @Description bschecklhfjpjcsid的中文含义是： 量化分级评级参数表ID
	 */
	private String bschecklhfjpjcsid;

	/**
	 * @Description lhfjpdlx的中文含义是： 量化分级评定类型0动态评定1年度评定
	 */
	private String lhfjpdlx;

	/**
	 * @Description lhfjpddj的中文含义是： 量化分级评定等级
	 */
	private String lhfjpddj;

	/**
	 * @Description lhfjpdqsf的中文含义是： 量化分级评定起始分
	 */
	private String lhfjpdqsf;

	/**
	 * @Description lhfjpdjsf的中文含义是： 量化分级评定结束分
	 */
	private String lhfjpdjsf;

	/**
	 * @Description lhfjpdksrq的中文含义是： 量化分级评定开始日期
	 */
	private String lhfjpdksrq;

	/**
	 * @Description lhfjpdjsrq的中文含义是： 量化分级评定结束日期
	 */
	private String lhfjpdjsrq;

	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	private String aae036;

	/**
	 * @Description aae013的中文含义是： 备注
	 */
	private String aae013;

	/**
	 * @Description lhfjpdndyjccs的中文含义是： 量化分级评定年度应检查次数
	 */
	private String lhfjpdndyjccs;

	
		/**
	 * @Description bschecklhfjpjcsid的中文含义是： 量化分级评级参数表ID
	 */
	public void setBschecklhfjpjcsid(String bschecklhfjpjcsid){ 
		this.bschecklhfjpjcsid = bschecklhfjpjcsid;
	}
	/**
	 * @Description bschecklhfjpjcsid的中文含义是： 量化分级评级参数表ID
	 */
	public String getBschecklhfjpjcsid(){
		return bschecklhfjpjcsid;
	}
	/**
	 * @Description lhfjpdlx的中文含义是： 量化分级评定类型0动态评定1年度评定
	 */
	public void setLhfjpdlx(String lhfjpdlx){ 
		this.lhfjpdlx = lhfjpdlx;
	}
	/**
	 * @Description lhfjpdlx的中文含义是： 量化分级评定类型0动态评定1年度评定
	 */
	public String getLhfjpdlx(){
		return lhfjpdlx;
	}
	/**
	 * @Description lhfjpddj的中文含义是： 量化分级评定等级
	 */
	public void setLhfjpddj(String lhfjpddj){ 
		this.lhfjpddj = lhfjpddj;
	}
	/**
	 * @Description lhfjpddj的中文含义是： 量化分级评定等级
	 */
	public String getLhfjpddj(){
		return lhfjpddj;
	}
	/**
	 * @Description lhfjpdqsf的中文含义是： 量化分级评定起始分
	 */
	public void setLhfjpdqsf(String lhfjpdqsf){ 
		this.lhfjpdqsf = lhfjpdqsf;
	}
	/**
	 * @Description lhfjpdqsf的中文含义是： 量化分级评定起始分
	 */
	public String getLhfjpdqsf(){
		return lhfjpdqsf;
	}
	/**
	 * @Description lhfjpdjsf的中文含义是： 量化分级评定结束分
	 */
	public void setLhfjpdjsf(String lhfjpdjsf){ 
		this.lhfjpdjsf = lhfjpdjsf;
	}
	/**
	 * @Description lhfjpdjsf的中文含义是： 量化分级评定结束分
	 */
	public String getLhfjpdjsf(){
		return lhfjpdjsf;
	}
	/**
	 * @Description lhfjpdksrq的中文含义是： 量化分级评定开始日期
	 */
	public void setLhfjpdksrq(String lhfjpdksrq){ 
		this.lhfjpdksrq = lhfjpdksrq;
	}
	/**
	 * @Description lhfjpdksrq的中文含义是： 量化分级评定开始日期
	 */
	public String getLhfjpdksrq(){
		return lhfjpdksrq;
	}
	/**
	 * @Description lhfjpdjsrq的中文含义是： 量化分级评定结束日期
	 */
	public void setLhfjpdjsrq(String lhfjpdjsrq){ 
		this.lhfjpdjsrq = lhfjpdjsrq;
	}
	/**
	 * @Description lhfjpdjsrq的中文含义是： 量化分级评定结束日期
	 */
	public String getLhfjpdjsrq(){
		return lhfjpdjsrq;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 操作员
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 操作时间
	 */
	public String getAae036(){
		return aae036;
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
	 * @Description lhfjpdndyjccs的中文含义是： 量化分级评定年度应检查次数
	 */
	public void setLhfjpdndyjccs(String lhfjpdndyjccs){ 
		this.lhfjpdndyjccs = lhfjpdndyjccs;
	}
	/**
	 * @Description lhfjpdndyjccs的中文含义是： 量化分级评定年度应检查次数
	 */
	public String getLhfjpdndyjccs(){
		return lhfjpdndyjccs;
	}

	
}