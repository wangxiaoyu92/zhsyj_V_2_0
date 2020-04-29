package com.askj.spsy.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  QCOMPANYGX的中文含义是: 客户关系表; InnoDB free: 2715648 kB
 * @Creation     2016/07/03 15:45:25
 * @Written      Create Tool By zjf 
 **/
@Table(value = "QCOMPANYGX")
public class Qcompanygx {
	/**
	 * @Description gxid的中文含义是： ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_gxid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_gxid.nextval from dual"))
	private String gxid;

	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	@Column
	private String comid;

	/**
	 * @Description csid的中文含义是： 客户ID
	 */
	@Column
	private String csid;

	/**
	 * @Description csproid的中文含义是： 商品ID
	 */
	@Column
	private String csproid;

	/**
	 * @Description cominoutlx的中文含义是： 公司系统内外类型. 0:系统内；1系统外aaa100=COMINOUTLX
	 */
	@Column
	private String cominoutlx;

	/**
	 * @Description comgxlx的中文含义是： 公司供销类型. 1:供货商；2:销货商aaa100=COMGXLX
	 */
	@Column
	private String comgxlx;

	/**
	 * @Description comgxtime的中文含义是： 客户关系建立时间
	 */
	@Column
	private String comgxtime;

	/**
	 * @Description cphyclid的中文含义是： 产品或原材料ID
	 */
	@Column
	private String cphyclid;

	
	/**
	 * @Description gxid的中文含义是： ID
	 */
	public void setGxid(String gxid){ 
		this.gxid = gxid;
	}
	/**
	 * @Description gxid的中文含义是： ID
	 */
	public String getGxid(){
		return gxid;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public void setComid(String comid){ 
		this.comid = comid;
	}
	/**
	 * @Description comid的中文含义是： 企业ID
	 */
	public String getComid(){
		return comid;
	}
	/**
	 * @Description csid的中文含义是： 客户ID
	 */
	public void setCsid(String csid){ 
		this.csid = csid;
	}
	/**
	 * @Description csid的中文含义是： 客户ID
	 */
	public String getCsid(){
		return csid;
	}
	/**
	 * @Description csproid的中文含义是： 商品ID
	 */
	public void setCsproid(String csproid){ 
		this.csproid = csproid;
	}
	/**
	 * @Description csproid的中文含义是： 商品ID
	 */
	public String getCsproid(){
		return csproid;
	}
	/**
	 * @Description cominoutlx的中文含义是： 公司系统内外类型. 0:系统内；1系统外aaa100=COMINOUTLX
	 */
	public void setCominoutlx(String cominoutlx){ 
		this.cominoutlx = cominoutlx;
	}
	/**
	 * @Description cominoutlx的中文含义是： 公司系统内外类型. 0:系统内；1系统外aaa100=COMINOUTLX
	 */
	public String getCominoutlx(){
		return cominoutlx;
	}
	/**
	 * @Description comgxlx的中文含义是： 公司供销类型. 1:供货商；2:销货商aaa100=COMGXLX
	 */
	public void setComgxlx(String comgxlx){ 
		this.comgxlx = comgxlx;
	}
	/**
	 * @Description comgxlx的中文含义是： 公司供销类型. 1:供货商；2:销货商aaa100=COMGXLX
	 */
	public String getComgxlx(){
		return comgxlx;
	}
	/**
	 * @Description comgxtime的中文含义是： 客户关系建立时间
	 */
	public void setComgxtime(String comgxtime){ 
		this.comgxtime = comgxtime;
	}
	/**
	 * @Description comgxtime的中文含义是： 客户关系建立时间
	 */
	public String getComgxtime(){
		return comgxtime;
	}
	/**
	 * @Description cphyclid的中文含义是： 产品或原材料ID
	 */
	public void setCphyclid(String cphyclid){ 
		this.cphyclid = cphyclid;
	}
	/**
	 * @Description cphyclid的中文含义是： 产品或原材料ID
	 */
	public String getCphyclid(){
		return cphyclid;
	}
	
}