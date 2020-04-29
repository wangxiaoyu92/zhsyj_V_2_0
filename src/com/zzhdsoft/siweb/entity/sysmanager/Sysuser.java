package com.zzhdsoft.siweb.entity.sysmanager;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Readonly;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Time;
import java.sql.Timestamp;

/**
 * @Description SYSUSER 的中文含义是：系统用户信息表
 * @Creation 2014/04/17 14:39:10
 * @Written Create Tool By ZhengZhou HuaDong Software
 **/
@Table(value = "SYSUSER")
public class Sysuser {
	//扩展字段开始
	/**
	 * easemobfriend 环信好友
	 */
	@Column
	@Readonly
	private String easemobfriend;

	/**
	 * usergridstr 批量选择的
	 */
	@Column
	@Readonly
	private String usergridstr;

	/**
	 * comid 企业id
	 */
	@Column
	@Readonly
	private String comid;

	/**
	 * operuserid为了区分 当前操作员id和要查询的操作员人员id
	 */
	@Column
	@Readonly
	private String operuserid;
	/**
	 * gu20180519userkind=7快检人员userkind=8商户，这样的操作员都有归属的usercomdalei
	 */
	@Column
	@Readonly
	private String usercomdalei;
	/**
	 * gu20180519userkind=7快检人员userkind=8商户，这样的操作员都有归属的commc
	 */
	@Column
	@Readonly
	private String usercommc;

	/**
	 * gu20180519userkind=7快检人员userkind=8商户，这样的操作员都有归属的comid
	 */
	@Column
	private String usercomid;

	/**
	 * gu20170915
	 * @Description 目前是选择企业日常监督管理人员时，传过来已经选择过的人员id列表，
	 * 以逗号分隔例如2016052614593110739048580,2016052614593110739048599
	 */
	@Column
	@Readonly
	private String useridstr;

	/**
	 * @Description gu20170110 用户签字图片存放路径
	 */
	@Column
	@Readonly
	private String qzpicpath;

	/**
	 * @Description querykind的中文含义是： 查询类型 all 查询所有的 no查询原来的
	 * =1 选择日常监督管理人员 时 查询已选择的人员
	 */
	@Column
	@Readonly
	private String querykind;

	/**
	 * @Description querytype：
	 */
	@Column
	@Readonly
	private String querytype;

	/**
	 * @Description userdalei的中文含义是： 用户大类 根据userkind进行划分 目前大致分为 企业用户和非企业用户
	 * userkind=6,7,8的划分为企业用户 其他的为非企业用户
	 * 1非企业用 2企业用户
	 */
	@Column
	@Readonly
	private String userdalei;

	//扩展字段结束

	/**
	 * userposition
	 */
	@Column
	private String userposition;

	/**
	 * @Description userid的中文含义是： 用户ID（关键字）
	 */
	@Column
	@Name
	// @Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_userid')"))
	// @Prev(@SQL(db=DB.ORACLE,value="select sq_userid.nextval from dual"))
	private String userid;

	//邮政编码,非映射字段
	@Column
	@Readonly
	private String aae007;

	//溯源企业类型0非溯源企业1生成2流通3餐饮aaa100=COMSYQYLX
	@Column
	@Readonly
	private String comsyqylx;

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
	 * @Description description的中文含义是： 用户描述
	 */
	@Column
	private String description;

	/**
	 * @Description createtime的中文含义是： 注册时间
	 */
	@Column
	private Timestamp createtime;

	/**
	 * @Description lastlogontime的中文含义是： 上次登陆时间
	 */
	@Column
	private Timestamp lastlogontime;

	/**
	 * @Description lastlogofftime的中文含义是： 上次离开时间
	 */
	@Column
	private Timestamp lastlogofftime;

	/**
	 * @Description lockstate的中文含义是： 账户锁定状态：0正常，1账户停用
	 */
	@Column
	private String lockstate;

	/**
	 * @Description locktime的中文含义是： 账户锁定时间
	 */
	@Column
	private Timestamp locktime;

	/**
	 * @Description unlocktime的中文含义是： 账户解锁时间
	 */
	@Column
	private Timestamp unlocktime;

	/**
	 * @Description lockreason的中文含义是： 账户锁定原因
	 */
	@Column
	private String lockreason;

	/**
	 * @Description userexpiredate的中文含义是： 账户过期时间
	 */
	@Column
	private Timestamp userexpiredate;

	/**
	 * @Description mustmodifypasswd的中文含义是： 下次登陆是否修改密码
	 */
	@Column
	private String mustmodifypasswd;

	/**
	 * @Description passwdexpirepolicy的中文含义是： 密码过期策略：1系统配置周期，2永不过期，3指定日期
	 */
	@Column
	private String passwdexpirepolicy;

	/**
	 * @Description passwdexpiredate的中文含义是： 密码过期时间
	 */
	@Column
	private Timestamp passwdexpiredate;

	/**
	 * @Description passwdlastchange的中文含义是： 密码上次修改时间
	 */
	@Column
	private Timestamp passwdlastchange;

	/**
	 * @Description loginedcount的中文含义是： 已登陆次数
	 */
	@Column
	private Integer loginedcount;

	/**
	 * @Description allowloginedcount的中文含义是： 授权登陆总次数
	 */
	@Column
	private Integer allowloginedcount;

	/**
	 * @Description allowloginperiod的中文含义是： 授权登陆时间段
	 */
	@Column
	private String allowloginperiod;

	/**
	 * @Description checkip的中文含义是： 是否限制ip
	 */
	@Column
	private String checkip;

	/**
	 * @Description allowip的中文含义是： 登陆ip限制范围
	 */
	@Column
	private String allowip;

	/**
	 * @Description rejectip的中文含义是： 拒绝登陆ip列表
	 */
	@Column
	private String rejectip;

	/**
	 * @Description remark的中文含义是： 备注
	 */
	@Column
	private String remark;

	/**
	 * @Description orgid的中文含义是： 机构id，对应社保机构、社区、单位的ID，取AE10.aaz001
	 */
	@Column
	private String orgid;

	/**
	 * @Description orgcode的中文含义是：
	 */
	@Column
	@Readonly
	private String orgcode;

	/**
	 * @Description userkind的中文含义是： 用户类别,1社保机构用户,2参保单位用户,3个人用户,4社区用户
	 */
	@Column
	private String userkind;

	/**
	 * @Description reprole的中文含义是：演示数据权限,1不控制
	 */
	@Column
	private String reprole;

	/**
	 * @Description aaz010的中文含义是： 当事人ID
	 */
	@Column
	private String aaz010;

	/**
	 * @Description aaz001的中文含义是： 组织ID
	 */
	@Column
	private String aaz001;

	/**
	 * @Description aac002的中文含义是： 身份证号码
	 */
	@Column
	private String aac002;

	/**
	 * @Description aac154的中文含义是： 社保号
	 */
	@Column
	private String aac154;

	/**
	 * @Description mobile的中文含义是： 手机号（注册时绑定），所有用户不可为空
	 */
	@Column
	private String mobile;

	/**
	 * @Description mobile2的中文含义是： 手机号2
	 */
	@Column
	private String mobile2;
	/**
	 * @Description telephone的中文含义是：电话号码
	 */
	@Column
	private String telephone;
	/**
	 * @Description aac003的中文含义是： 姓名
	 */
	@Column
	private String aac003;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;

	/**
	 * @Description aae383的中文含义是： 统筹区级别
	 */
	@Column
	@Readonly
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
	 * @Description orgname的中文含义是： 所属机构名称
	 */
	private String orgname;

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	private String aaa027name;

	/**
	 * @Description selfcomflag的中文含义是： 是否只能查看自己监管的企业0否1是
	 */
	@Column
	private String selfcomflag;

	/**
	 * @Description userjc的中文含义是： 用户汉字名称拼音简称
	 */
	@Column
	private String userjc;

	/**
	 * @Description userdwmc的中文含义是： 用户单位名称
	 */
	@Column
	private String userdwmc;

	/**
	 * @Description userlxdz的中文含义是： 用户联系地址
	 */
	@Column
	private String userlxdz;

	/**
	 * @Description useremail的中文含义是： email
	 */
	@Column
	private String useremail;

	/**
	 * @Description findpwsn的中文含义是： 找回密码时生成的随机数
	 */
	@Column
	private String findpwsn;

	/**
	 * @Description signintime的中文含义是： 签到时间设置
	 */
	@Column
	private Time signintime;

	/**
	 * @Description allowsignintime的中文含义是： 允许签到时间设置
	 */
	@Column
	private Time allowsignintime;

	/**
	 * @Description easemobflag的中文含义是： 环信用户标志0否1是
	 */
	@Column
	private String easemobflag;

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
	 * @Description reprole的中文含义是： 演示数据权限,1不控制
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

	public String getComsyqylx() {
		return comsyqylx;
	}

	public void setComsyqylx(String comsyqylx) {
		this.comsyqylx = comsyqylx;
	}

	public String getOrgcode() {
		return orgcode;
	}

	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}

	public String getQuerykind() {
		return querykind;
	}

	public void setQuerykind(String querykind) {
		this.querykind = querykind;
	}

	public String getQzpicpath() {
		return qzpicpath;
	}

	public void setQzpicpath(String qzpicpath) {
		this.qzpicpath = qzpicpath;
	}

	public String getSelfcomflag() {
		return selfcomflag;
	}

	public void setSelfcomflag(String selfcomflag) {
		this.selfcomflag = selfcomflag;
	}

	public String getUseridstr() {
		return useridstr;
	}

	public void setUseridstr(String useridstr) {
		this.useridstr = useridstr;
	}

	public String getUserjc() {
		return userjc;
	}

	public void setUserjc(String userjc) {
		this.userjc = userjc;
	}

	public String getUserdalei() {
		return userdalei;
	}

	public void setUserdalei(String userdalei) {
		this.userdalei = userdalei;
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

	public String getOperuserid() {
		return operuserid;
	}

	public void setOperuserid(String operuserid) {
		this.operuserid = operuserid;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}

	public String getUsergridstr() {
		return usergridstr;
	}

	public void setUsergridstr(String usergridstr) {
		this.usergridstr = usergridstr;
	}

	public String getQuerytype() {
		return querytype;
	}

	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}

	public String getEasemobflag() {
		return easemobflag;
	}

	public void setEasemobflag(String easemobflag) {
		this.easemobflag = easemobflag;
	}

	public String getEasemobfriend() {
		return easemobfriend;
	}

	public void setEasemobfriend(String easemobfriend) {
		this.easemobfriend = easemobfriend;
	}
}