package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  SYSORG 的中文含义是： 用户组
 * @Creation     2014/09/19 14:49:50
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "SYSORG")
public class Sysorg {
	//子节点数量,非映射字段
	@Column
	@Readonly
	private int childnum;
	//是否父节点,非映射字段
	@Column
	@Readonly
	private boolean isparent;
	//是否展开,非映射字段
	@Column
	@Readonly
	private boolean isopen;
	
	//父机构名称
	@Column
	@Readonly
	private String parentname;
	
	/**
	 * @Description orgid的中文含义是： 机构id(系统生成,唯一关键字)
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_orgid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_orgid.nextval from dual"))
	private String orgid;

	/**
	 * @Description orgname的中文含义是： 机构名称
	 */
	@Column
	private String orgname;

	/**
	 * @Description shortname的中文含义是： 机构简称
	 */
	@Column
	private String shortname;

	/**
	 * @Description orgdesc的中文含义是： 机构描述
	 */
	@Column
	private String orgdesc;

	/**
	 * @Description parent的中文含义是： 父机构id
	 */
	@Column
	private String parent;

	/**
	 * @Description address的中文含义是： 机构地址
	 */
	@Column
	private String address;

	/**
	 * @Description principal的中文含义是： 机构负责人
	 */
	@Column
	private String principal;

	/**
	 * @Description linkman的中文含义是： 联系人
	 */
	@Column
	private String linkman;

	/**
	 * @Description tel的中文含义是： 电话
	 */
	@Column
	private String tel;

	/**
	 * @Description orgkind的中文含义是： 机构类别,1机构,2部门
	 */
	@Column
	private String orgkind;

	/**
	 * @Description orgcode的中文含义是： 机构代码(即机构的编号)
	 */
	@Column
	private String orgcode;

	/**
	 * @Description orderno的中文含义是： 在同一级机构中的序号
	 */
	@Column
	private Integer orderno;
	
	/**
	 * @Description cpfz的中文含义是： 产品分组
	 */
	@Column
	private String fz;
	
	public int getChildnum() {
		return childnum;
	}
	public void setChildnum(int childnum) {
		this.childnum = childnum;
	}
	
	public boolean getIsparent() {
		return isparent;
	}
	public void setIsparent(boolean isparent) {
		this.isparent = isparent;
	}
	public boolean getIsopen() {
		return isopen;
	}
	public void setIsopen(boolean isopen) {
		this.isopen = isopen;
	}
	
	public String getParentname() {
		return parentname;
	}
	public void setParentname(String parentname) {
		this.parentname = parentname;
	}
	/**
	 * @Description orgid的中文含义是： 机构id(系统生成,唯一关键字)
	 */
	public void setOrgid(String orgid){ 
		this.orgid = orgid;
	}
	/**
	 * @Description orgid的中文含义是： 机构id(系统生成,唯一关键字)
	 */
	public String getOrgid(){
		return orgid;
	}
	/**
	 * @Description orgname的中文含义是： 机构名称
	 */
	public void setOrgname(String orgname){ 
		this.orgname = orgname;
	}
	/**
	 * @Description orgname的中文含义是： 机构名称
	 */
	public String getOrgname(){
		return orgname;
	}
	/**
	 * @Description shortname的中文含义是： 机构简称
	 */
	public void setShortname(String shortname){ 
		this.shortname = shortname;
	}
	/**
	 * @Description shortname的中文含义是： 机构简称
	 */
	public String getShortname(){
		return shortname;
	}
	/**
	 * @Description orgdesc的中文含义是： 机构描述
	 */
	public void setOrgdesc(String orgdesc){ 
		this.orgdesc = orgdesc;
	}
	/**
	 * @Description orgdesc的中文含义是： 机构描述
	 */
	public String getOrgdesc(){
		return orgdesc;
	}
	/**
	 * @Description parent的中文含义是： 父机构id
	 */
	public void setParent(String parent){ 
		this.parent = parent;
	}
	/**
	 * @Description parent的中文含义是： 父机构id
	 */
	public String getParent(){
		return parent;
	}
	/**
	 * @Description address的中文含义是： 机构地址
	 */
	public void setAddress(String address){ 
		this.address = address;
	}
	/**
	 * @Description address的中文含义是： 机构地址
	 */
	public String getAddress(){
		return address;
	}
	/**
	 * @Description principal的中文含义是： 机构负责人
	 */
	public void setPrincipal(String principal){ 
		this.principal = principal;
	}
	/**
	 * @Description principal的中文含义是： 机构负责人
	 */
	public String getPrincipal(){
		return principal;
	}
	/**
	 * @Description linkman的中文含义是： 联系人
	 */
	public void setLinkman(String linkman){ 
		this.linkman = linkman;
	}
	/**
	 * @Description linkman的中文含义是： 联系人
	 */
	public String getLinkman(){
		return linkman;
	}
	/**
	 * @Description tel的中文含义是： 电话
	 */
	public void setTel(String tel){ 
		this.tel = tel;
	}
	/**
	 * @Description tel的中文含义是： 电话
	 */
	public String getTel(){
		return tel;
	}
	/**
	 * @Description orgkind的中文含义是： 机构类别,1机构,2部门
	 */
	public void setOrgkind(String orgkind){ 
		this.orgkind = orgkind;
	}
	/**
	 * @Description orgkind的中文含义是： 机构类别,1机构,2部门
	 */
	public String getOrgkind(){
		return orgkind;
	}
	/**
	 * @Description orgcode的中文含义是： 机构代码(即机构的编号)
	 */
	public void setOrgcode(String orgcode){ 
		this.orgcode = orgcode;
	}
	/**
	 * @Description orgcode的中文含义是： 机构代码(即机构的编号)
	 */
	public String getOrgcode(){
		return orgcode;
	}
	/**
	 * @Description orderno的中文含义是： 在同一级机构中的序号
	 */
	public void setOrderno(Integer orderno){ 
		this.orderno = orderno;
	}
	/**
	 * @Description orderno的中文含义是： 在同一级机构中的序号
	 */
	public Integer getOrderno(){
		return orderno;
	}
	/**
	 * @Description fz的中文含义是： 分组
	 */
	public void setFz(String fz){ 
		this.fz = fz;
	}
	/**
	 * @Description fz的中文含义是： 分组
	 */
	public String getFz(){
		return fz;
	}
}