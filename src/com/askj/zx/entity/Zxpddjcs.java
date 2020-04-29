package com.askj.zx.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZXPDDJCS的中文含义是: 征信评定等级参数; InnoDB free: 10240 kB
 * @Creation     2016/02/24 15:36:15
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZXPDDJCS")
public class Zxpddjcs {
	/**
	 * @Description djcsid的中文含义是： 
	 */
	@Column
	@Name
	private String djcsid;

	/**
	 * @Description djcsbm的中文含义是： 等级参数编码
	 */
	@Column
	private String djcsbm;

	/**
	 * @Description djcsmc的中文含义是： 等级参数名称
	 */
	@Column
	private String djcsmc;

	/**
	 * @Description djcsqsfz的中文含义是： 起始分值
	 */
	@Column
	private Integer djcsqsfz;

	/**
	 * @Description djcsjsfz的中文含义是： 结束分值
	 */
	@Column
	private Integer djcsjsfz;

	/**
	 * @Description djcsksrq的中文含义是： 等级参数开始日期
	 */
	@Column
	private String djcsksrq;

	/**
	 * @Description djcsjsrq的中文含义是： 等级参数结束日期
	 */
	@Column
	private String djcsjsrq;

	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	@Column
	private String czyxm;

	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	@Column
	private String czsj;

	/**
	 * @Description djcshh的中文含义是： 所属红黑0正常1红2黑
	 */
	@Column
	private String djcshh;

	
		/**
	 * @Description djcsid的中文含义是： 
	 */
	public void setDjcsid(String djcsid){ 
		this.djcsid = djcsid;
	}
	/**
	 * @Description djcsid的中文含义是： 
	 */
	public String getDjcsid(){
		return djcsid;
	}
	/**
	 * @Description djcsbm的中文含义是： 等级参数编码
	 */
	public void setDjcsbm(String djcsbm){ 
		this.djcsbm = djcsbm;
	}
	/**
	 * @Description djcsbm的中文含义是： 等级参数编码
	 */
	public String getDjcsbm(){
		return djcsbm;
	}
	/**
	 * @Description djcsmc的中文含义是： 等级参数名称
	 */
	public void setDjcsmc(String djcsmc){ 
		this.djcsmc = djcsmc;
	}
	/**
	 * @Description djcsmc的中文含义是： 等级参数名称
	 */
	public String getDjcsmc(){
		return djcsmc;
	}
	/**
	 * @Description djcsqsfz的中文含义是： 起始分值
	 */
	public void setDjcsqsfz(Integer djcsqsfz){ 
		this.djcsqsfz = djcsqsfz;
	}
	/**
	 * @Description djcsqsfz的中文含义是： 起始分值
	 */
	public Integer getDjcsqsfz(){
		return djcsqsfz;
	}
	/**
	 * @Description djcsjsfz的中文含义是： 结束分值
	 */
	public void setDjcsjsfz(Integer djcsjsfz){ 
		this.djcsjsfz = djcsjsfz;
	}
	/**
	 * @Description djcsjsfz的中文含义是： 结束分值
	 */
	public Integer getDjcsjsfz(){
		return djcsjsfz;
	}
	/**
	 * @Description djcsksrq的中文含义是： 等级参数开始日期
	 */
	public void setDjcsksrq(String djcsksrq){ 
		this.djcsksrq = djcsksrq;
	}
	/**
	 * @Description djcsksrq的中文含义是： 等级参数开始日期
	 */
	public String getDjcsksrq(){
		return djcsksrq;
	}
	/**
	 * @Description djcsjsrq的中文含义是： 等级参数结束日期
	 */
	public void setDjcsjsrq(String djcsjsrq){ 
		this.djcsjsrq = djcsjsrq;
	}
	/**
	 * @Description djcsjsrq的中文含义是： 等级参数结束日期
	 */
	public String getDjcsjsrq(){
		return djcsjsrq;
	}
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	public void setCzyxm(String czyxm){ 
		this.czyxm = czyxm;
	}
	/**
	 * @Description czyxm的中文含义是： 操作员姓名
	 */
	public String getCzyxm(){
		return czyxm;
	}
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	public void setCzsj(String czsj){ 
		this.czsj = czsj;
	}
	/**
	 * @Description czsj的中文含义是： 操作时间
	 */
	public String getCzsj(){
		return czsj;
	}
	/**
	 * @Description djcshh的中文含义是： 所属红黑0正常1红2黑
	 */
	public void setDjcshh(String djcshh){ 
		this.djcshh = djcshh;
	}
	/**
	 * @Description djcshh的中文含义是： 所属红黑0正常1红2黑
	 */
	public String getDjcshh(){
		return djcshh;
	}

	
}