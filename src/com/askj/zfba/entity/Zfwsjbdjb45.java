package com.askj.zfba.entity;
import org.nutz.dao.entity.annotation.*; 
/**
 * @Description  ZFWSJBDJB45的中文含义是: 举报登记表
 * @Creation     2016/09/26 18:21:04
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSJBDJB45")
public class Zfwsjbdjb45 {
	/**
	 * @Description jbdjbid的中文含义是： 登记表id
	 */
	@Name
	@Column
	private String jbdjbid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description jbdjbh的中文含义是： 举报登记编号
	 */
	@Column
	private String jbdjbh;

	/**
	 * @Description jbdjjbr的中文含义是： 举报人
	 */
	@Column
	private String jbdjjbr;

	/**
	 * @Description jbdjlxfs的中文含义是： 联系方式
	 */
	@Column
	private String jbdjlxfs;

	/**
	 * @Description jbdjjbxs的中文含义是： 举报形式
	 */
	@Column
	private String jbdjjbxs;

	/**
	 * @Description jbdjjbsj的中文含义是： 举报时间
	 */
	@Column
	private String jbdjjbsj;

	/**
	 * @Description jbdjjbnr的中文含义是： 举报内容
	 */
	@Column
	private String jbdjjbnr;

	/**
	 * @Description jbdjjlrqz的中文含义是： 记录人签字
	 */
	@Column
	private String jbdjjlrqz;

	/**
	 * @Description jbdjjlrqzrq的中文含义是： 记录人签字日期
	 */
	@Column
	private String jbdjjlrqzrq;

	/**
	 * @Description jbdjclyj的中文含义是： 处理意见
	 */
	@Column
	private String jbdjclyj;

	/**
	 * @Description jbdjfzrqz的中文含义是： 负责人签字
	 */
	@Column
	private String jbdjfzrqz;

	/**
	 * @Description jbdjfzrqzrq的中文含义是： 负责人签字日期
	 */
	@Column
	private String jbdjfzrqzrq;

	
		/**
	 * @Description jbdjbid的中文含义是： 登记表id
	 */
	public void setJbdjbid(String jbdjbid){ 
		this.jbdjbid = jbdjbid;
	}
	/**
	 * @Description jbdjbid的中文含义是： 登记表id
	 */
	public String getJbdjbid(){
		return jbdjbid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记id
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description jbdjbh的中文含义是： 举报登记编号
	 */
	public void setJbdjbh(String jbdjbh){ 
		this.jbdjbh = jbdjbh;
	}
	/**
	 * @Description jbdjbh的中文含义是： 举报登记编号
	 */
	public String getJbdjbh(){
		return jbdjbh;
	}
	/**
	 * @Description jbdjjbr的中文含义是： 举报人
	 */
	public void setJbdjjbr(String jbdjjbr){ 
		this.jbdjjbr = jbdjjbr;
	}
	/**
	 * @Description jbdjjbr的中文含义是： 举报人
	 */
	public String getJbdjjbr(){
		return jbdjjbr;
	}
	/**
	 * @Description jbdjlxfs的中文含义是： 联系方式
	 */
	public void setJbdjlxfs(String jbdjlxfs){ 
		this.jbdjlxfs = jbdjlxfs;
	}
	/**
	 * @Description jbdjlxfs的中文含义是： 联系方式
	 */
	public String getJbdjlxfs(){
		return jbdjlxfs;
	}
	/**
	 * @Description jbdjjbxs的中文含义是： 举报形式
	 */
	public void setJbdjjbxs(String jbdjjbxs){ 
		this.jbdjjbxs = jbdjjbxs;
	}
	/**
	 * @Description jbdjjbxs的中文含义是： 举报形式
	 */
	public String getJbdjjbxs(){
		return jbdjjbxs;
	}
	/**
	 * @Description jbdjjbsj的中文含义是： 举报时间
	 */
	public void setJbdjjbsj(String jbdjjbsj){ 
		this.jbdjjbsj = jbdjjbsj;
	}
	/**
	 * @Description jbdjjbsj的中文含义是： 举报时间
	 */
	public String getJbdjjbsj(){
		return jbdjjbsj;
	}
	/**
	 * @Description jbdjjbnr的中文含义是： 举报内容
	 */
	public void setJbdjjbnr(String jbdjjbnr){ 
		this.jbdjjbnr = jbdjjbnr;
	}
	/**
	 * @Description jbdjjbnr的中文含义是： 举报内容
	 */
	public String getJbdjjbnr(){
		return jbdjjbnr;
	}
	/**
	 * @Description jbdjjlrqz的中文含义是： 记录人签字
	 */
	public void setJbdjjlrqz(String jbdjjlrqz){ 
		this.jbdjjlrqz = jbdjjlrqz;
	}
	/**
	 * @Description jbdjjlrqz的中文含义是： 记录人签字
	 */
	public String getJbdjjlrqz(){
		return jbdjjlrqz;
	}
	/**
	 * @Description jbdjjlrqzrq的中文含义是： 记录人签字日期
	 */
	public void setJbdjjlrqzrq(String jbdjjlrqzrq){ 
		this.jbdjjlrqzrq = jbdjjlrqzrq;
	}
	/**
	 * @Description jbdjjlrqzrq的中文含义是： 记录人签字日期
	 */
	public String getJbdjjlrqzrq(){
		return jbdjjlrqzrq;
	}
	/**
	 * @Description jbdjclyj的中文含义是： 处理意见
	 */
	public void setJbdjclyj(String jbdjclyj){ 
		this.jbdjclyj = jbdjclyj;
	}
	/**
	 * @Description jbdjclyj的中文含义是： 处理意见
	 */
	public String getJbdjclyj(){
		return jbdjclyj;
	}
	/**
	 * @Description jbdjfzrqz的中文含义是： 负责人签字
	 */
	public void setJbdjfzrqz(String jbdjfzrqz){ 
		this.jbdjfzrqz = jbdjfzrqz;
	}
	/**
	 * @Description jbdjfzrqz的中文含义是： 负责人签字
	 */
	public String getJbdjfzrqz(){
		return jbdjfzrqz;
	}
	/**
	 * @Description jbdjfzrqzrq的中文含义是： 负责人签字日期
	 */
	public void setJbdjfzrqzrq(String jbdjfzrqzrq){ 
		this.jbdjfzrqzrq = jbdjfzrqzrq;
	}
	/**
	 * @Description jbdjfzrqzrq的中文含义是： 负责人签字日期
	 */
	public String getJbdjfzrqzrq(){
		return jbdjfzrqzrq;
	}

	
}