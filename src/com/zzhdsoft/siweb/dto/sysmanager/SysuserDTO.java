package com.zzhdsoft.siweb.dto.sysmanager;

import org.nutz.dao.entity.annotation.Column;

import java.sql.Time;
import java.sql.Timestamp;

/**
 * @Description SysuserDTO的中文含义是: 系统用户表DTO
 * @Creation 2015/07/30 15:57:14
 * @Written Create Tool By zjf
 **/
public class SysuserDTO {
	/**
	 * @Description signintime的中文含义是： 签到时间设置
	 */
	private Time signintime;

	/**
	 * @Description allowsignintime的中文含义是： 允许签到开始时间设置
	 */
	private Time allowsignintime;
	/**
	 * userposition
	 */
	private String userposition;

	/**
	 * gu20180519userkind=7快检人员userkind=8商户，这样的操作员都有归属的comdalei
	 */
	private String usercomdalei;
	/**
	 * gu20180519userkind=7快检人员userkind=8商户，这样的操作员都有归属的commc
	 */
	private String usercommc;

	/**
	 * gu20180519userkind=7快检人员userkind=8商户，这样的操作员都有归属的comid
	 */
	private String usercomid;
	/**
	 * @Description userdwmc的中文含义是： 用户单位名称
	 */
	private String userdwmc;

	/**
	 * @Description userlxdz的中文含义是： 用户联系地址
	 */
	private String userlxdz;

	/**
	 * @Description useremail的中文含义是： email
	 */
	private String useremail;
	/**
	 * @Description comdalei 企业大类
	 */
	private String comdalei;

	/**
	 * @Description gu20170110 用户签字图片存放路径
	 */
	private String qzpicpath;

	/**
	 * @Description userid的中文含义是： 用户ID（关键字）
	 */
	private String userid;

	/**
	 * @Description username的中文含义是： 用户名
	 */
	private String username;

	/**
	 * @Description passwd的中文含义是： 密码
	 */
	private String passwd;

	/**
	 * @Description description的中文含义是： 用户描述
	 */
	private String description;

	/**
	 * @Description createtime的中文含义是： 注册时间
	 */
	private Timestamp createtime;

	/**
	 * @Description lastlogontime的中文含义是： 上次登陆时间
	 */
	private Timestamp lastlogontime;

	/**
	 * @Description lastlogofftime的中文含义是： 上次离开时间
	 */
	private Timestamp lastlogofftime;

	/**
	 * @Description lockstate的中文含义是： 账户锁定状态：0正常，1账户停用
	 */

	private String lockstate;

	/**
	 * @Description locktime的中文含义是： 账户锁定时间
	 */

	private Timestamp locktime;

	/**
	 * @Description unlocktime的中文含义是： 账户解锁时间
	 */

	private Timestamp unlocktime;

	/**
	 * @Description lockreason的中文含义是： 账户锁定原因
	 */

	private String lockreason;

	/**
	 * @Description userexpiredate的中文含义是： 账户过期时间
	 */

	private Timestamp userexpiredate;

	/**
	 * @Description mustmodifypasswd的中文含义是： 下次登陆是否修改密码
	 */

	private String mustmodifypasswd;

	/**
	 * @Description passwdexpirepolicy的中文含义是： 密码过期策略：1系统配置周期，2永不过期，3指定日期
	 */

	private String passwdexpirepolicy;

	/**
	 * @Description passwdexpiredate的中文含义是： 密码过期时间
	 */

	private Timestamp passwdexpiredate;

	/**
	 * @Description passwdlastchange的中文含义是： 密码上次修改时间
	 */

	private Timestamp passwdlastchange;

	/**
	 * @Description loginedcount的中文含义是： 已登陆次数
	 */

	private Integer loginedcount;

	/**
	 * @Description allowloginedcount的中文含义是： 授权登陆总次数
	 */

	private Integer allowloginedcount;

	/**
	 * @Description allowloginperiod的中文含义是： 授权登陆时间段
	 */

	private String allowloginperiod;

	/**
	 * @Description checkip的中文含义是： 是否限制ip
	 */

	private String checkip;

	/**
	 * @Description allowip的中文含义是： 登陆ip限制范围
	 */

	private String allowip;

	/**
	 * @Description rejectip的中文含义是： 拒绝登陆ip列表
	 */

	private String rejectip;

	/**
	 * @Description remark的中文含义是： 备注
	 */

	private String remark;

	/**
	 * @Description orgid的中文含义是： 机构id，对应社保机构、社区、单位的ID，取AE10.aaz001
	 */

	private String orgid;

	/**
	 * @Description userkind的中文含义是： 用户类别,1社保机构用户,2参保单位用户,3个人用户,4社区用户
	 */

	private String userkind;

	/**
	 * @Description reprole的中文含义是：演示数据权限,1不控制
	 */

	private String reprole;

	/**
	 * @Description aaz010的中文含义是： 当事人ID
	 */

	private String aaz010;

	/**
	 * @Description aaz001的中文含义是： 组织ID
	 */

	private String aaz001;

	/**
	 * @Description aac002的中文含义是： 身份证号码
	 */

	private String aac002;

	/**
	 * @Description aac154的中文含义是： 社保号
	 */

	private String aac154;

	/**
	 * @Description mobile的中文含义是： 手机号（注册时绑定），所有用户不可为空
	 */

	private String mobile;
	/**
	 * @Description mobile2的中文含义是： 手机号2
	 */
	private String mobile2;
	/**
	 * @Description telephone的中文含义是：电话号码
	 */
	private String telephone;
	/**
	 * @Description aac003的中文含义是： 姓名
	 */

	private String aac003;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	private String aaa027;

	/**
	 * @Description aae383的中文含义是： 统筹区级别
	 */
	private String aae383;

	/**
	 * 注册验证码
	 */
	private String yzm;

	/**
	 * 注册验证码ID
	 */
	private Long yzmId;

	/**
	 * @Description orgcode的中文含义是： 机构代码(即机构的编号)
	 */

	private String orgcode;

	/**
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	private String orgname;

	/**
	 * @Description orgname的中文含义是： 统筹区名称
	 */
	private String aaa027name;
	/**
	 * @Description userid的中文含义是： 邮政编码
	 */
	private String aae007;
	/**
	 * @Description dwfs的中文含义是： 定位方式
	 */
	private String dwfs;   //补充手机签到查询时用到   即sysoperatelogService.qiandaoquery(SysuserDTO dto)

	/**
	 * @Description selfcomflag的中文含义是： 是否只能查看自己监管的企业0否1是
	 */
	private String selfcomflag;

	/**
	 * @Description userjc的中文含义是： 用户汉字名称拼音简称
	 */
	private String userjc;

	/**
	 * @Description easemobflag的中文含义是： 环信用户标志0否1是
	 */
	private String easemobflag;


	public String getDwfs() {
		return dwfs;
	}

	public void setDwfs(String dwfs) {
		this.dwfs = dwfs;
	}

	/**
	 * @Description userid的中文含义是： 用户ID（关键字）
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

	/**
	 * @Description userid的中文含义是： 用户ID（关键字）
	 */
	public String getUserid() {
		return userid;
	}

	/**
	 * @Description username的中文含义是： 用户名
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * @Description username的中文含义是： 用户名
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @Description passwd的中文含义是： 密码
	 */
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	/**
	 * @Description passwd的中文含义是： 密码
	 */
	public String getPasswd() {
		return passwd;
	}

	/**
	 * @Description description的中文含义是： 用户描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @Description description的中文含义是： 用户描述
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @Description createtime的中文含义是： 注册时间
	 */
	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}

	/**
	 * @Description createtime的中文含义是： 注册时间
	 */
	public Timestamp getCreatetime() {
		return createtime;
	}

	/**
	 * @Description lastlogontime的中文含义是： 上次登陆时间
	 */
	public void setLastlogontime(Timestamp lastlogontime) {
		this.lastlogontime = lastlogontime;
	}

	/**
	 * @Description lastlogontime的中文含义是： 上次登陆时间
	 */
	public Timestamp getLastlogontime() {
		return lastlogontime;
	}

	/**
	 * @Description lastlogofftime的中文含义是： 上次离开时间
	 */
	public void setLastlogofftime(Timestamp lastlogofftime) {
		this.lastlogofftime = lastlogofftime;
	}

	/**
	 * @Description lastlogofftime的中文含义是： 上次离开时间
	 */
	public Timestamp getLastlogofftime() {
		return lastlogofftime;
	}

	/**
	 * @Description lockstate的中文含义是： 账户锁定状态：0正常，1账户停用
	 */
	public void setLockstate(String lockstate) {
		this.lockstate = lockstate;
	}

	/**
	 * @Description lockstate的中文含义是： 账户锁定状态：0正常，1账户停用
	 */
	public String getLockstate() {
		return lockstate;
	}

	/**
	 * @Description locktime的中文含义是： 账户锁定时间
	 */
	public void setLocktime(Timestamp locktime) {
		this.locktime = locktime;
	}

	/**
	 * @Description locktime的中文含义是： 账户锁定时间
	 */
	public Timestamp getLocktime() {
		return locktime;
	}

	/**
	 * @Description unlocktime的中文含义是： 账户解锁时间
	 */
	public void setUnlocktime(Timestamp unlocktime) {
		this.unlocktime = unlocktime;
	}

	/**
	 * @Description unlocktime的中文含义是： 账户解锁时间
	 */
	public Timestamp getUnlocktime() {
		return unlocktime;
	}

	/**
	 * @Description lockreason的中文含义是： 账户锁定原因
	 */
	public void setLockreason(String lockreason) {
		this.lockreason = lockreason;
	}

	/**
	 * @Description lockreason的中文含义是： 账户锁定原因
	 */
	public String getLockreason() {
		return lockreason;
	}

	/**
	 * @Description userexpiredate的中文含义是： 账户过期时间
	 */
	public void setUserexpiredate(Timestamp userexpiredate) {
		this.userexpiredate = userexpiredate;
	}

	/**
	 * @Description userexpiredate的中文含义是： 账户过期时间
	 */
	public Timestamp getUserexpiredate() {
		return userexpiredate;
	}

	/**
	 * @Description mustmodifypasswd的中文含义是： 下次登陆是否修改密码
	 */
	public void setMustmodifypasswd(String mustmodifypasswd) {
		this.mustmodifypasswd = mustmodifypasswd;
	}

	/**
	 * @Description mustmodifypasswd的中文含义是： 下次登陆是否修改密码
	 */
	public String getMustmodifypasswd() {
		return mustmodifypasswd;
	}

	/**
	 * @Description passwdexpirepolicy的中文含义是： 密码过期策略：1系统配置周期，2永不过期，3指定日期
	 */
	public void setPasswdexpirepolicy(String passwdexpirepolicy) {
		this.passwdexpirepolicy = passwdexpirepolicy;
	}

	/**
	 * @Description passwdexpirepolicy的中文含义是： 密码过期策略：1系统配置周期，2永不过期，3指定日期
	 */
	public String getPasswdexpirepolicy() {
		return passwdexpirepolicy;
	}

	/**
	 * @Description passwdexpiredate的中文含义是： 密码过期时间
	 */
	public void setPasswdexpiredate(Timestamp passwdexpiredate) {
		this.passwdexpiredate = passwdexpiredate;
	}

	/**
	 * @Description passwdexpiredate的中文含义是： 密码过期时间
	 */
	public Timestamp getPasswdexpiredate() {
		return passwdexpiredate;
	}

	/**
	 * @Description passwdlastchange的中文含义是： 密码上次修改时间
	 */
	public void setPasswdlastchange(Timestamp passwdlastchange) {
		this.passwdlastchange = passwdlastchange;
	}

	/**
	 * @Description passwdlastchange的中文含义是： 密码上次修改时间
	 */
	public Timestamp getPasswdlastchange() {
		return passwdlastchange;
	}

	/**
	 * @Description loginedcount的中文含义是： 已登陆次数
	 */
	public void setLoginedcount(Integer loginedcount) {
		this.loginedcount = loginedcount;
	}

	/**
	 * @Description loginedcount的中文含义是： 已登陆次数
	 */
	public Integer getLoginedcount() {
		return loginedcount;
	}

	/**
	 * @Description allowloginedcount的中文含义是： 授权登陆总次数
	 */
	public void setAllowloginedcount(Integer allowloginedcount) {
		this.allowloginedcount = allowloginedcount;
	}

	/**
	 * @Description allowloginedcount的中文含义是： 授权登陆总次数
	 */
	public Integer getAllowloginedcount() {
		return allowloginedcount;
	}

	/**
	 * @Description allowloginperiod的中文含义是： 授权登陆时间段
	 */
	public void setAllowloginperiod(String allowloginperiod) {
		this.allowloginperiod = allowloginperiod;
	}

	/**
	 * @Description allowloginperiod的中文含义是： 授权登陆时间段
	 */
	public String getAllowloginperiod() {
		return allowloginperiod;
	}

	/**
	 * @Description checkip的中文含义是： 是否限制ip
	 */
	public void setCheckip(String checkip) {
		this.checkip = checkip;
	}

	/**
	 * @Description checkip的中文含义是： 是否限制ip
	 */
	public String getCheckip() {
		return checkip;
	}

	/**
	 * @Description allowip的中文含义是： 登陆ip限制范围
	 */
	public void setAllowip(String allowip) {
		this.allowip = allowip;
	}

	/**
	 * @Description allowip的中文含义是： 登陆ip限制范围
	 */
	public String getAllowip() {
		return allowip;
	}

	/**
	 * @Description rejectip的中文含义是： 拒绝登陆ip列表
	 */
	public void setRejectip(String rejectip) {
		this.rejectip = rejectip;
	}

	/**
	 * @Description rejectip的中文含义是： 拒绝登陆ip列表
	 */
	public String getRejectip() {
		return rejectip;
	}

	/**
	 * @Description remark的中文含义是： 备注
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}

	/**
	 * @Description remark的中文含义是： 备注
	 */
	public String getRemark() {
		return remark;
	}

	/**
	 * @Description orgid的中文含义是： 机构id，对应社保机构、社区、单位的ID，取AE10.aaz001
	 */
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	/**
	 * @Description orgid的中文含义是： 机构id，对应社保机构、社区、单位的ID，取AE10.aaz001
	 */
	public String getOrgid() {
		return orgid;
	}

	/**
	 * @Description userkind的中文含义是： 用户类别,1社保机构用户,2参保单位用户3个人用户4社区用户
	 */
	public void setUserkind(String userkind) {
		this.userkind = userkind;
	}

	/**
	 * @Description userkind的中文含义是： 用户类别,1社保机构用户,2参保单位用户3个人用户4社区用户
	 */
	public String getUserkind() {
		return userkind;
	}

	/**
	 * @Description reprole的中文含义是： 演示数据权限,1不控制
	 */
	public void setReprole(String reprole) {
		this.reprole = reprole;
	}

	/**
	 * @Description reprole的中文含义是：演示数据权限,1不控制
	 */
	public String getReprole() {
		return reprole;
	}

	/**
	 * @Description aaz010的中文含义是： 当事人ID
	 */
	public void setAaz010(String aaz010) {
		this.aaz010 = aaz010;
	}

	/**
	 * @Description aaz010的中文含义是： 当事人ID
	 */
	public String getAaz010() {
		return aaz010;
	}

	/**
	 * @Description aaz001的中文含义是： 组织ID
	 */
	public void setAaz001(String aaz001) {
		this.aaz001 = aaz001;
	}

	/**
	 * @Description aaz001的中文含义是： 组织ID
	 */
	public String getAaz001() {
		return aaz001;
	}

	/**
	 * @Description aac002的中文含义是： 身份证号码
	 */
	public void setAac002(String aac002) {
		this.aac002 = aac002;
	}

	/**
	 * @Description aac002的中文含义是： 身份证号码
	 */
	public String getAac002() {
		return aac002;
	}

	/**
	 * @Description aac154的中文含义是： 社保号
	 */
	public void setAac154(String aac154) {
		this.aac154 = aac154;
	}

	/**
	 * @Description aac154的中文含义是： 社保号
	 */
	public String getAac154() {
		return aac154;
	}

	/**
	 * @Description mobile的中文含义是： 手机号（注册时绑定），所有用户不可为空
	 */
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	/**
	 * @Description mobile的中文含义是： 手机号（注册时绑定），所有用户不可为空
	 */
	public String getMobile() {
		return mobile;
	}
	/**
	 * @Description mobile2的中文含义是： 手机号2
	 */
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}

	/**
	 * @Description mobile2的中文含义是： 手机号2
	 */
	public String getMobile2() {
		return mobile2;
	}

	/**
	 * @Description telephone的中文含义是： 电话号码
	 */
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	/**
	 * @Description telephone的中文含义是：电话号码
	 */
	public String getTelephone() {
		return telephone;
	}
	/**
	 * @Description aac003的中文含义是： 姓名
	 */
	public void setAac003(String aac003) {
		this.aac003 = aac003;
	}

	/**
	 * @Description aac003的中文含义是： 姓名
	 */
	public String getAac003() {
		return aac003;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027) {
		this.aaa027 = aaa027;
	}

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027() {
		return aaa027;
	}

	/**
	 * @Description aae383的中文含义是： 统筹区级别
	 */
	public String getAae383() {
		return aae383;
	}

	/**
	 * @Description aae383的中文含义是： 统筹区级别
	 */
	public void setAae383(String aae383) {
		this.aae383 = aae383;
	}

	public String getYzm() {
		return yzm;
	}

	public void setYzm(String yzm) {
		this.yzm = yzm;
	}

	public Long getYzmId() {
		return yzmId;
	}

	public void setYzmId(Long yzmId) {
		this.yzmId = yzmId;
	}

	/**
	 * @Description orgcode的中文含义是： 机构代码(即机构的编号)
	 */
	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}

	/**
	 * @Description orgcode的中文含义是： 机构代码(即机构的编号)
	 */
	public String getOrgcode() {
		return orgcode;
	}

	/**
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	/**
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	public String getOrgname() {
		return orgname;
	}

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public String getAaa027name() {
		return aaa027name;
	}

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public void setAaa027name(String aaa027name) {
		this.aaa027name = aaa027name;
	}

	public String getAae007() {
		return aae007;
	}

	public void setAae007(String aae007) {
		this.aae007 = aae007;
	}

	/**
	 * @Description lszpid的中文含义是： 系统用户照片ID
	 */
	private String sysuserzpid;
	/**
	 * @Description sysuserzp的中文含义是： 系统用户照片
	 */
	private String sysuserzp;

	/**
	 * @Description sysuserzpid的中文含义是： 系统用户照片ID
	 */
	public void setSysuserzpid(String sysuserzpid) {
		this.sysuserzpid = sysuserzpid;
	}

	/**
	 * @Description sysuserzpid的中文含义是： 系统用户照片ID
	 */
	public String getSysuserzpid() {
		return sysuserzpid;
	}

	/**
	 * @Description sysuserzp的中文含义是： 系统用户照片
	 */
	public void setSysuserzp(String sysuserzp) {
		this.sysuserzp = sysuserzp;
	}

	/**
	 * @Description sysuserzp的中文含义是： 系统用户照片
	 */
	public String getSysuserzp() {
		return sysuserzp;
	}

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	private String roleid;

	/**
	 * @Description roledesc的中文含义是： 角色描述
	 */
	private String roledesc;

	/**
	 * @Description rolename的中文含义是： 角色名称
	 */
	private String rolename;

	/**
	 * @Description sysroleflag的中文含义是： 系统角色标识 1:系统角色; 0:非系统角色
	 */
	private String sysroleflag;

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	/**
	 * @Description roleid的中文含义是： 角色ID
	 */
	public String getRoleid() {
		return roleid;
	}

	/**
	 * @Description roledesc的中文含义是： 角色描述
	 */
	public void setRoledesc(String roledesc) {
		this.roledesc = roledesc;
	}

	/**
	 * @Description roledesc的中文含义是： 角色描述
	 */
	public String getRoledesc() {
		return roledesc;
	}

	/**
	 * @Description rolename的中文含义是： 角色名称
	 */
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	/**
	 * @Description rolename的中文含义是： 角色名称
	 */
	public String getRolename() {
		return rolename;
	}

	/**
	 * @Description sysroleflag的中文含义是： 系统角色标识 1:系统角色; 0:非系统角色
	 */
	public void setSysroleflag(String sysroleflag) {
		this.sysroleflag = sysroleflag;
	}

	/**
	 * @Description sysroleflag的中文含义是： 系统角色标识 1:系统角色; 0:非系统角色
	 */
	public String getSysroleflag() {
		return sysroleflag;
	}


	/**
	 * @Description logonlogid的中文含义是： 登录日志ID
	 */
	private String logonlogid;

	/**
	 * @Description logontime的中文含义是： 上线时间
	 */
	private Timestamp logontime;

	/**
	 * @Description logofftime的中文含义是： 下线时间
	 */
	private Timestamp logofftime;
	/**
	 * @Description logonflag的中文含义是： 登录成功标志，1为平台登录，0为手机登录
	 */
	private String logonflag;
	/**
	 * @Description logonappvision的中文含义是： 登录APP版本号
	 */
	private String logonappvision;

	/**
	 * @Description findpwsn的中文含义是： 找回密码时生成的随机数
	 */
	private String findpwsn;

	/**
	 * @Description logonlogid的中文含义是： 登录日志ID
	 */
	public void setLogonlogid(String logonlogid){
		this.logonlogid = logonlogid;
	}
	/**
	 * @Description logonlogid的中文含义是： 登录日志ID
	 */
	public String getLogonlogid(){
		return logonlogid;
	}
	/**
	 * @Description logontime的中文含义是： 上线时间
	 */
	public void setLogontime(Timestamp logontime){
		this.logontime = logontime;
	}
	/**
	 * @Description logontime的中文含义是： 上线时间
	 */
	public Timestamp getLogontime(){
		return logontime;
	}
	/**
	 * @Description logofftime的中文含义是： 下线时间
	 */
	public void setLogofftime(Timestamp logofftime){
		this.logofftime = logofftime;
	}
	/**
	 * @Description logofftime的中文含义是： 下线时间
	 */
	public Timestamp getLogofftime(){
		return logofftime;
	}
	/**
	 * @Description logonflag的中文含义是： 登录成功标志，1为平台登录，0为手机登录
	 */
	public void setLogonflag(String logonflag){
		this.logonflag = logonflag;
	}
	/**
	 * @Description logonflag的中文含义是： 登录成功标志，1为平台登录，0为手机登录
	 */
	public String getLogonflag(){
		return logonflag;
	}

	/**
	 * @Description logonappvision的中文含义是： 登录APP版本号
	 */
	public void setLogonappvision(String logonappvision){
		this.logonappvision = logonappvision;
	}
	/**
	 * @Description logonappvision的中文含义是： 登录APP版本号
	 */
	public String getLogonappvision(){
		return logonappvision;
	}

	public String getQzpicpath() {
		return qzpicpath;
	}

	public void setQzpicpath(String qzpicpath) {
		this.qzpicpath = qzpicpath;
	}

	public String getComdalei() {
		return comdalei;
	}

	public void setComdalei(String comdalei) {
		this.comdalei = comdalei;
	}

	public String getSelfcomflag() {
		return selfcomflag;
	}

	public void setSelfcomflag(String selfcomflag) {
		this.selfcomflag = selfcomflag;
	}

	public String getUserjc() {
		return userjc;
	}

	public void setUserjc(String userjc) {
		this.userjc = userjc;
	}

	public String getUserdwmc() {
		return userdwmc;
	}

	public void setUserdwmc(String userdwmc) {
		this.userdwmc = userdwmc;
	}

	public String getUserlxdz() {
		return userlxdz;
	}

	public void setUserlxdz(String userlxdz) {
		this.userlxdz = userlxdz;
	}

	public String getUseremail() {
		return useremail;
	}

	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public String getFindpwsn() {
		return findpwsn;
	}

	public void setFindpwsn(String findpwsn) {
		this.findpwsn = findpwsn;
	}

	public String getUsercomid() {
		return usercomid;
	}

	public void setUsercomid(String usercomid) {
		this.usercomid = usercomid;
	}

	public String getUsercommc() {
		return usercommc;
	}

	public void setUsercommc(String usercommc) {
		this.usercommc = usercommc;
	}

	public String getUsercomdalei() {
		return usercomdalei;
	}

	public void setUsercomdalei(String usercomdalei) {
		this.usercomdalei = usercomdalei;
	}

	public String getUserposition() {
		return userposition;
	}

	public void setUserposition(String userposition) {
		this.userposition = userposition;
	}

	public Time getSignintime() {
		return signintime;
	}

	public void setSignintime(Time signintime) {
		this.signintime = signintime;
	}

	public Time getAllowsignintime() {
		return allowsignintime;
	}

	public void setAllowsignintime(Time allowsignintime) {
		this.allowsignintime = allowsignintime;
	}

	public String getEasemobflag() {
		return easemobflag;
	}

	public void setEasemobflag(String easemobflag) {
		this.easemobflag = easemobflag;
	}
}
