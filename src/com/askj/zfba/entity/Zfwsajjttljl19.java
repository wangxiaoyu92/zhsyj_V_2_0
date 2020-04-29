package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSAJJTTLJL19的中文含义是: 案件集体讨论记录
 * @Creation     2016/09/02 20:33:26
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSAJJTTLJL19")
public class Zfwsajjttljl19 {
	/**
	 * @Description ajjttljlid的中文含义是： 案件集体讨论记录ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_ajjttljlid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_ajjttljlid.nextval from dual"))
	private String ajjttljlid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description jttlsj的中文含义是： 讨论时间
	 */
	@Column
	private String jttlsj;

	/**
	 * @Description jttldd的中文含义是： 地点
	 */
	@Column
	private String jttldd;

	/**
	 * @Description jttlzcr的中文含义是： 主持人
	 */
	@Column
	private String jttlzcr;

	/**
	 * @Description jttlhbr的中文含义是： 汇报人
	 */
	@Column
	private String jttlhbr;

	/**
	 * @Description jttljlr的中文含义是： 记录人
	 */
	@Column
	private String jttljlr;

	/**
	 * @Description jttlcjr的中文含义是： 参加人
	 */
	@Column
	private String jttlcjr;

	/**
	 * @Description jttlzywfss的中文含义是： 主要违法事实
	 */
	@Column
	private String jttlzywfss;

	/**
	 * @Description jttljl的中文含义是： 讨论记录
	 */
	@Column
	private String jttljl;

	/**
	 * @Description jttljdyj的中文含义是： 决定意见
	 */
	@Column
	private String jttljdyj;

	/**
	 * @Description jttlzcrqz的中文含义是： 主持人签字
	 */
	@Column
	private String jttlzcrqz;

	/**
	 * @Description jttljlrqz的中文含义是： 记录人签字
	 */
	@Column
	private String jttljlrqz;

	/**
	 * @Description jttlcjryqz的中文含义是： 参加人员签字
	 */
	@Column
	private String jttlcjryqz;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description jttldsr的中文含义是： 当事人
	 */
	@Column
	private String jttldsr;

	/**
	 * @Description jttljssj的中文含义是： 集体讨论结束时间
	 */
	@Column
	private String jttljssj;

	/**
	 * @Description jttlzcrzw的中文含义是： 主持人职务
	 */
	@Column
	private String jttlzcrzw;

	/**
	 * @Description jttljlrzw的中文含义是： 记录人职务
	 */
	@Column
	private String jttljlrzw;

	
		/**
	 * @Description ajjttljlid的中文含义是： 案件集体讨论记录ID
	 */
	public void setAjjttljlid(String ajjttljlid){ 
		this.ajjttljlid = ajjttljlid;
	}
	/**
	 * @Description ajjttljlid的中文含义是： 案件集体讨论记录ID
	 */
	public String getAjjttljlid(){
		return ajjttljlid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description jttlsj的中文含义是： 讨论时间
	 */
	public void setJttlsj(String jttlsj){ 
		this.jttlsj = jttlsj;
	}
	/**
	 * @Description jttlsj的中文含义是： 讨论时间
	 */
	public String getJttlsj(){
		return jttlsj;
	}
	/**
	 * @Description jttldd的中文含义是： 地点
	 */
	public void setJttldd(String jttldd){ 
		this.jttldd = jttldd;
	}
	/**
	 * @Description jttldd的中文含义是： 地点
	 */
	public String getJttldd(){
		return jttldd;
	}
	/**
	 * @Description jttlzcr的中文含义是： 主持人
	 */
	public void setJttlzcr(String jttlzcr){ 
		this.jttlzcr = jttlzcr;
	}
	/**
	 * @Description jttlzcr的中文含义是： 主持人
	 */
	public String getJttlzcr(){
		return jttlzcr;
	}
	/**
	 * @Description jttlhbr的中文含义是： 汇报人
	 */
	public void setJttlhbr(String jttlhbr){ 
		this.jttlhbr = jttlhbr;
	}
	/**
	 * @Description jttlhbr的中文含义是： 汇报人
	 */
	public String getJttlhbr(){
		return jttlhbr;
	}
	/**
	 * @Description jttljlr的中文含义是： 记录人
	 */
	public void setJttljlr(String jttljlr){ 
		this.jttljlr = jttljlr;
	}
	/**
	 * @Description jttljlr的中文含义是： 记录人
	 */
	public String getJttljlr(){
		return jttljlr;
	}
	/**
	 * @Description jttlcjr的中文含义是： 参加人
	 */
	public void setJttlcjr(String jttlcjr){ 
		this.jttlcjr = jttlcjr;
	}
	/**
	 * @Description jttlcjr的中文含义是： 参加人
	 */
	public String getJttlcjr(){
		return jttlcjr;
	}
	/**
	 * @Description jttlzywfss的中文含义是： 主要违法事实
	 */
	public void setJttlzywfss(String jttlzywfss){ 
		this.jttlzywfss = jttlzywfss;
	}
	/**
	 * @Description jttlzywfss的中文含义是： 主要违法事实
	 */
	public String getJttlzywfss(){
		return jttlzywfss;
	}
	/**
	 * @Description jttljl的中文含义是： 讨论记录
	 */
	public void setJttljl(String jttljl){ 
		this.jttljl = jttljl;
	}
	/**
	 * @Description jttljl的中文含义是： 讨论记录
	 */
	public String getJttljl(){
		return jttljl;
	}
	/**
	 * @Description jttljdyj的中文含义是： 决定意见
	 */
	public void setJttljdyj(String jttljdyj){ 
		this.jttljdyj = jttljdyj;
	}
	/**
	 * @Description jttljdyj的中文含义是： 决定意见
	 */
	public String getJttljdyj(){
		return jttljdyj;
	}
	/**
	 * @Description jttlzcrqz的中文含义是： 主持人签字
	 */
	public void setJttlzcrqz(String jttlzcrqz){ 
		this.jttlzcrqz = jttlzcrqz;
	}
	/**
	 * @Description jttlzcrqz的中文含义是： 主持人签字
	 */
	public String getJttlzcrqz(){
		return jttlzcrqz;
	}
	/**
	 * @Description jttljlrqz的中文含义是： 记录人签字
	 */
	public void setJttljlrqz(String jttljlrqz){ 
		this.jttljlrqz = jttljlrqz;
	}
	/**
	 * @Description jttljlrqz的中文含义是： 记录人签字
	 */
	public String getJttljlrqz(){
		return jttljlrqz;
	}
	/**
	 * @Description jttlcjryqz的中文含义是： 参加人员签字
	 */
	public void setJttlcjryqz(String jttlcjryqz){ 
		this.jttlcjryqz = jttlcjryqz;
	}
	/**
	 * @Description jttlcjryqz的中文含义是： 参加人员签字
	 */
	public String getJttlcjryqz(){
		return jttlcjryqz;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public void setAjdjay(String ajdjay){ 
		this.ajdjay = ajdjay;
	}
	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	public String getAjdjay(){
		return ajdjay;
	}
	/**
	 * @Description jttldsr的中文含义是： 当事人
	 */
	public void setJttldsr(String jttldsr){ 
		this.jttldsr = jttldsr;
	}
	/**
	 * @Description jttldsr的中文含义是： 当事人
	 */
	public String getJttldsr(){
		return jttldsr;
	}
	/**
	 * @Description jttljssj的中文含义是： 集体讨论结束时间
	 */
	public void setJttljssj(String jttljssj){ 
		this.jttljssj = jttljssj;
	}
	/**
	 * @Description jttljssj的中文含义是： 集体讨论结束时间
	 */
	public String getJttljssj(){
		return jttljssj;
	}
	/**
	 * @Description jttlzcrzw的中文含义是： 主持人职务
	 */
	public void setJttlzcrzw(String jttlzcrzw){ 
		this.jttlzcrzw = jttlzcrzw;
	}
	/**
	 * @Description jttlzcrzw的中文含义是： 主持人职务
	 */
	public String getJttlzcrzw(){
		return jttlzcrzw;
	}
	/**
	 * @Description jttljlrzw的中文含义是： 记录人职务
	 */
	public void setJttljlrzw(String jttljlrzw){ 
		this.jttljlrzw = jttljlrzw;
	}
	/**
	 * @Description jttljlrzw的中文含义是： 记录人职务
	 */
	public String getJttljlrzw(){
		return jttljlrzw;
	}

	
}