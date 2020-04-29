package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  USERREG 的中文含义是 用户注册信息表
 * @Creation     2013/11/12 11:08:53
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "USERREG")
public class Userreg {
	/**
	 * @Description userregid的中文含义是： ID
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_sysuserreg')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_sysuserreg.nextval from dual"))
	private String userregid;

	/**
	 * @Description username的中文含义是： 用户名
	 */
	@Column
	private String username;

	/**
	 * @Description passwd的中文含义是： 密码
	 */
	@Column
	private String passwd;

	/**
	 * @Description aac154的中文含义是： 社会保障号
	 */
	@Column
	private String aac154;

	/**
	 * @Description mobile的中文含义是： 绑定手机号
	 */
	@Column
	private String mobile;

	/**
	 * @Description aac003的中文含义是： 姓名
	 */
	@Column
	private String aac003;

	/**
	 * @Description aac002的中文含义是： 身份证号
	 */
	@Column
	private String aac002;

	/**
	 * @Description createtime的中文含义是： 注册时间
	 */
	@Column
	private String createtime;

	/**
	 * @Description userkind的中文含义是： 用户类别,1社保机构用户,2参保单位用户3个人用户4社区用户
	 */
	@Column
	private String userkind;

	
		/**
	 * @Description userregid的中文含义是： ID
	 */
	public void setUserregid(String userregid){ 
		this.userregid = userregid;
	}
	/**
	 * @Description userregid的中文含义是： ID
	 */
	public String getUserregid(){
		return userregid;
	}
	/**
	 * @Description username的中文含义是： 用户名
	 */
	public void setUsername(String username){ 
		this.username = username;
	}
	/**
	 * @Description username的中文含义是： 用户名
	 */
	public String getUsername(){
		return username;
	}
	/**
	 * @Description passwd的中文含义是： 密码
	 */
	public void setPasswd(String passwd){ 
		this.passwd = passwd;
	}
	/**
	 * @Description passwd的中文含义是： 密码
	 */
	public String getPasswd(){
		return passwd;
	}
	/**
	 * @Description aac154的中文含义是： 社会保障号
	 */
	public void setAac154(String aac154){ 
		this.aac154 = aac154;
	}
	/**
	 * @Description aac154的中文含义是： 社会保障号
	 */
	public String getAac154(){
		return aac154;
	}
	/**
	 * @Description mobile的中文含义是： 绑定手机号
	 */
	public void setMobile(String mobile){ 
		this.mobile = mobile;
	}
	/**
	 * @Description mobile的中文含义是： 绑定手机号
	 */
	public String getMobile(){
		return mobile;
	}
	/**
	 * @Description aac003的中文含义是： 姓名
	 */
	public void setAac003(String aac003){ 
		this.aac003 = aac003;
	}
	/**
	 * @Description aac003的中文含义是： 姓名
	 */
	public String getAac003(){
		return aac003;
	}
	/**
	 * @Description aac002的中文含义是： 身份证号
	 */
	public void setAac002(String aac002){ 
		this.aac002 = aac002;
	}
	/**
	 * @Description aac002的中文含义是： 身份证号
	 */
	public String getAac002(){
		return aac002;
	}
	/**
	 * @Description createtime的中文含义是： 注册时间
	 */
	public void setCreatetime(String createtime){ 
		this.createtime = createtime;
	}
	/**
	 * @Description createtime的中文含义是： 注册时间
	 */
	public String getCreatetime(){
		return createtime;
	}
	/**
	 * @Description userkind的中文含义是： 用户类别,1社保机构用户,2参保单位用户3个人用户4社区用户
	 */
	public void setUserkind(String userkind){ 
		this.userkind = userkind;
	}
	/**
	 * @Description userkind的中文含义是： 用户类别,1社保机构用户,2参保单位用户3个人用户4社区用户
	 */
	public String getUserkind(){
		return userkind;
	}

	
}