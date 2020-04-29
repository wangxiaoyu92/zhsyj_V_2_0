package com.askj.jyjc.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  JYJCCYBGXMB的中文含义是: 检验检测抽样报告项目表DTO
 * @Creation     2017/01/10 08:56:27
 * @Written      Create Tool By zjf 
 **/
public class JyjccybgxmbDTO {
	/**
	 * @Description jyjcbgxmid的中文含义是： 报告项目ID
	 */
	private String jyjcbgxmid;

	/**
	 * @Description bgid的中文含义是： 报告ID
	 */
	private String bgid;

	/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	private String cydjid;

	/**
	 * @Description jcxmid的中文含义是： 检测项目ID
	 */
	private String jcxmid;

	/**
	 * @Description jxjcxmmc的中文含义是： 检测项目名称
	 */
	private String jxjcxmmc;

	/**
	 * @Description bzz的中文含义是： 标准值
	 */
	private String bzz;

	/**
	 * @Description jyjcjg的中文含义是： 检验检测结果
	 */
	private String jyjcjg;

	/**
	 * @Description dw的中文含义是： 单位
	 */
	private String dw;

	/**
	 * @Description sfhg的中文含义是： 是否合格
	 */
	private String sfhg;

	/**
	 * @Description yjqk的中文含义是： 移交情况
	 */
	private String yjqk;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	private String aae036;

	
		/**
	 * @Description jyjcbgxmid的中文含义是： 报告项目ID
	 */
	public void setJyjcbgxmid(String jyjcbgxmid){ 
		this.jyjcbgxmid = jyjcbgxmid;
	}
	/**
	 * @Description jyjcbgxmid的中文含义是： 报告项目ID
	 */
	public String getJyjcbgxmid(){
		return jyjcbgxmid;
	}
	/**
	 * @Description bgid的中文含义是： 报告ID
	 */
	public void setBgid(String bgid){ 
		this.bgid = bgid;
	}
	/**
	 * @Description bgid的中文含义是： 报告ID
	 */
	public String getBgid(){
		return bgid;
	}
	/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	public void setCydjid(String cydjid){ 
		this.cydjid = cydjid;
	}
	/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	public String getCydjid(){
		return cydjid;
	}
	/**
	 * @Description jcxmid的中文含义是： 检测项目ID
	 */
	public void setJcxmid(String jcxmid){ 
		this.jcxmid = jcxmid;
	}
	/**
	 * @Description jcxmid的中文含义是： 检测项目ID
	 */
	public String getJcxmid(){
		return jcxmid;
	}
	/**
	 * @Description jxjcxmmc的中文含义是： 检测项目名称
	 */
	public void setJxjcxmmc(String jxjcxmmc){ 
		this.jxjcxmmc = jxjcxmmc;
	}
	/**
	 * @Description jxjcxmmc的中文含义是： 检测项目名称
	 */
	public String getJxjcxmmc(){
		return jxjcxmmc;
	}
	/**
	 * @Description bzz的中文含义是： 标准值
	 */
	public void setBzz(String bzz){ 
		this.bzz = bzz;
	}
	/**
	 * @Description bzz的中文含义是： 标准值
	 */
	public String getBzz(){
		return bzz;
	}
	/**
	 * @Description jyjcjg的中文含义是： 检验检测结果
	 */
	public void setJyjcjg(String jyjcjg){ 
		this.jyjcjg = jyjcjg;
	}
	/**
	 * @Description jyjcjg的中文含义是： 检验检测结果
	 */
	public String getJyjcjg(){
		return jyjcjg;
	}
	/**
	 * @Description dw的中文含义是： 单位
	 */
	public void setDw(String dw){ 
		this.dw = dw;
	}
	/**
	 * @Description dw的中文含义是： 单位
	 */
	public String getDw(){
		return dw;
	}
	/**
	 * @Description sfhg的中文含义是： 是否合格
	 */
	public void setSfhg(String sfhg){ 
		this.sfhg = sfhg;
	}
	/**
	 * @Description sfhg的中文含义是： 是否合格
	 */
	public String getSfhg(){
		return sfhg;
	}
	/**
	 * @Description yjqk的中文含义是： 移交情况
	 */
	public void setYjqk(String yjqk){ 
		this.yjqk = yjqk;
	}
	/**
	 * @Description yjqk的中文含义是： 移交情况
	 */
	public String getYjqk(){
		return yjqk;
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