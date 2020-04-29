package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;
/**
 * @Description  SYSFUNCTION 的中文含义是： 功能权限表
 * @Creation     2013/10/24 10:19:06
 * @Written      Create Tool By ZhengZhou HuaDong Software 
 **/
@Table(value = "SYSFUNCTION")
public class Sysfunction {	
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
	
	//父菜单名称
	@Column
	@Readonly
	private String parentname;
	
	/**
	 * @Description functionid的中文含义是： 功能代码
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_functionid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_functionid.nextval from dual"))
	private String functionid;

	/**
	 * @Description location的中文含义是： 连接
	 */
	@Column
	private String location;

	/**
	 * @Description title的中文含义是： 菜单的中文描述
	 */
	@Column
	private String title;

	/**
	 * @Description parent的中文含义是： 菜单的父节点
	 */
	@Column
	private String parent;

	/**
	 * @Description orderno的中文含义是： 在同一级菜单中的序号
	 */
	@Column
	private Integer orderno;

	/**
	 * @Description type的中文含义是： 结点类型：菜单节点是1，菜单叶子是0，按钮是2
	 */
	@Column
	private String type;

	/**
	 * @Description description的中文含义是： 功能的中文描述
	 */
	@Column
	private String description;

	/**
	 * @Description log的中文含义是： 在action中是否记日志，1为记，其它不记
	 */
	@Column
	private String log;

	/**
	 * @Description owner的中文含义是： 开发人员
	 */
	@Column
	private String owner;

	/**
	 * @Description active的中文含义是： 是否可用，0为不可用1为可用
	 */
	@Column
	private String active;

	/**
	 * @Description functioncode的中文含义是： 功能号
	 */
	@Column
	private String functioncode;

	/**
	 * @Description visible的中文含义是： 是否可见 0 不可见，1 可见。 例如有增加权限肯定有保存权限，则增加权限可设置为可见，保存权限设置为隶属于增加权限，但不可见，只要选择了增加，也默认选择了保存
	 */
	@Column
	private String visible;

	/**
	 * @Description bizid的中文含义是： 业务ID
	 */
	@Column
	private String bizid;

	/**
	 * @Description rolbizclass的中文含义是： 自定义回退类名
	 */
	@Column
	private String rolbizclass;

	/**
	 * @Description imageurl的中文含义是： 自定义菜单树显示图标
	 */
	@Column
	private String imageurl;

	/**
	 * @Description expandedimageurl的中文含义是： 自定义菜单树展开图标
	 */
	@Column
	private String expandedimageurl;

	/**
	 * @Description aaa102的中文含义是： 业务类型编码
	 */
	@Column
	private String aaa102;

	/**
	 * @Description cae005的中文含义是： 是否过月模块
	 */
	@Column
	private String cae005;

	/**
	 * @Description rolbizable的中文含义是： 是否允许使用通用回退0为不可用1为可用
	 */
	@Column
	private String rolbizable;
	/**
	 * @Description target的中文含义是：： 菜单打开方式
	 */
	@Column
	private String target;

	/**
	 * @Description systemcode的中文含义是：： 子系统编码
	 */
	@Column
	private String systemcode;
	
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
	 * @Description functionid的中文含义是： 功能代码
	 */
	public void setFunctionid(String functionid){ 
		this.functionid = functionid;
	}
	/**
	 * @Description functionid的中文含义是： 功能代码
	 */
	public String getFunctionid(){
		return functionid;
	}
	/**
	 * @Description location的中文含义是： 连接
	 */
	public void setLocation(String location){ 
		this.location = location;
	}
	/**
	 * @Description location的中文含义是： 连接
	 */
	public String getLocation(){
		return location;
	}
	/**
	 * @Description title的中文含义是： 菜单的中文描述
	 */
	public void setTitle(String title){ 
		this.title = title;
	}
	/**
	 * @Description title的中文含义是： 菜单的中文描述
	 */
	public String getTitle(){
		return title;
	}
	/**
	 * @Description parent的中文含义是： 菜单的父节点
	 */
	public void setParent(String parent){ 
		this.parent = parent;
	}
	/**
	 * @Description parent的中文含义是： 菜单的父节点
	 */
	public String getParent(){
		return parent;
	}
	/**
	 * @Description orderno的中文含义是： 在同一级菜单中的序号
	 */
	public void setOrderno(Integer orderno){ 
		this.orderno = orderno;
	}
	/**
	 * @Description orderno的中文含义是： 在同一级菜单中的序号
	 */
	public Integer getOrderno(){
		return orderno;
	}
	/**
	 * @Description type的中文含义是： 结点类型：菜单节点是1，菜单叶子是0，按钮是2
	 */
	public void setType(String type){ 
		this.type = type;
	}
	/**
	 * @Description type的中文含义是： 结点类型：菜单节点是1，菜单叶子是0，按钮是2
	 */
	public String getType(){
		return type;
	}
	/**
	 * @Description description的中文含义是： 功能的中文描述
	 */
	public void setDescription(String description){ 
		this.description = description;
	}
	/**
	 * @Description description的中文含义是： 功能的中文描述
	 */
	public String getDescription(){
		return description;
	}
	/**
	 * @Description log的中文含义是： 在action中是否记日志，1为记，其它不记
	 */
	public void setLog(String log){ 
		this.log = log;
	}
	/**
	 * @Description log的中文含义是： 在action中是否记日志，1为记，其它不记
	 */
	public String getLog(){
		return log;
	}
	/**
	 * @Description owner的中文含义是： 开发人员
	 */
	public void setOwner(String owner){ 
		this.owner = owner;
	}
	/**
	 * @Description owner的中文含义是： 开发人员
	 */
	public String getOwner(){
		return owner;
	}
	/**
	 * @Description active的中文含义是： 是否可用，0为不可用1为可用
	 */
	public void setActive(String active){ 
		this.active = active;
	}
	/**
	 * @Description active的中文含义是： 是否可用，0为不可用1为可用
	 */
	public String getActive(){
		return active;
	}
	/**
	 * @Description functioncode的中文含义是： 功能号
	 */
	public void setFunctioncode(String functioncode){ 
		this.functioncode = functioncode;
	}
	/**
	 * @Description functioncode的中文含义是： 功能号
	 */
	public String getFunctioncode(){
		return functioncode;
	}
	/**
	 * @Description visible的中文含义是： 是否可见 0 不可见，1 可见。 例如有增加权限肯定有保存权限，则增加权限可设置为可见，保存权限设置为隶属于增加权限，但不可见，只要选择了增加，也默认选择了保存
	 */
	public void setVisible(String visible){ 
		this.visible = visible;
	}
	/**
	 * @Description visible的中文含义是： 是否可见 0 不可见，1 可见。 例如有增加权限肯定有保存权限，则增加权限可设置为可见，保存权限设置为隶属于增加权限，但不可见，只要选择了增加，也默认选择了保存
	 */
	public String getVisible(){
		return visible;
	}
	/**
	 * @Description bizid的中文含义是： 业务ID
	 */
	public void setBizid(String bizid){ 
		this.bizid = bizid;
	}
	/**
	 * @Description bizid的中文含义是： 业务ID
	 */
	public String getBizid(){
		return bizid;
	}
	/**
	 * @Description rolbizclass的中文含义是： 自定义回退类名
	 */
	public void setRolbizclass(String rolbizclass){ 
		this.rolbizclass = rolbizclass;
	}
	/**
	 * @Description rolbizclass的中文含义是： 自定义回退类名
	 */
	public String getRolbizclass(){
		return rolbizclass;
	}
	/**
	 * @Description imageurl的中文含义是： 自定义菜单树显示图标
	 */
	public void setImageurl(String imageurl){ 
		this.imageurl = imageurl;
	}
	/**
	 * @Description imageurl的中文含义是： 自定义菜单树显示图标
	 */
	public String getImageurl(){
		return imageurl;
	}
	/**
	 * @Description expandedimageurl的中文含义是： 自定义菜单树展开图标
	 */
	public void setExpandedimageurl(String expandedimageurl){ 
		this.expandedimageurl = expandedimageurl;
	}
	/**
	 * @Description expandedimageurl的中文含义是： 自定义菜单树展开图标
	 */
	public String getExpandedimageurl(){
		return expandedimageurl;
	}
	/**
	 * @Description aaa102的中文含义是： 业务类型编码
	 */
	public void setAaa102(String aaa102){ 
		this.aaa102 = aaa102;
	}
	/**
	 * @Description aaa102的中文含义是： 业务类型编码
	 */
	public String getAaa102(){
		return aaa102;
	}
	/**
	 * @Description cae005的中文含义是： 是否过月模块
	 */
	public void setCae005(String cae005){ 
		this.cae005 = cae005;
	}
	/**
	 * @Description cae005的中文含义是： 是否过月模块
	 */
	public String getCae005(){
		return cae005;
	}
	/**
	 * @Description rolbizable的中文含义是： 是否允许使用通用回退0为不可用1为可用
	 */
	public void setRolbizable(String rolbizable){ 
		this.rolbizable = rolbizable;
	}
	/**
	 * @Description rolbizable的中文含义是： 是否允许使用通用回退0为不可用1为可用
	 */
	public String getRolbizable(){
		return rolbizable;
	}
	/**
	 * @Description target的中文含义是： 菜单打开方式
	 */
	public void setTarget(String target){ 
		this.target = target;
	}
	/**
	 * @Description target的中文含义是： 菜单打开方式
	 */
	public String getTarget(){
		return target;
	}
	/**
	 * @Description systemcode的中文含义是： 子系统编码
	 */
	public void setSystemcode(String systemcode){ 
		this.systemcode = systemcode;
	}
	/**
	 * @Description systemcode的中文含义是： 子系统编码
	 */
	public String getSystemcode(){
		return systemcode;
	}
	
}