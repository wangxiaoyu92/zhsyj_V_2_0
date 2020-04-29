package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSXZCFJDS28的中文含义是: 行政处罚决定书; InnoDB free: 2726912 kB
 * @Creation     2016/06/14 11:52:27
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXZCFJDS28")
public class Zfwsxzcfjds28 {
	/**
	 * @Description xzcfjdsid的中文含义是： 行政处罚决定书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xzcfjdsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xzcfjdsid.nextval from dual"))
	private String xzcfjdsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description cfjdwfss的中文含义是： 违法事实
	 */
	@Column
	private String cfjdwfss;

	/**
	 * @Description cfjdxgzj的中文含义是： 相关证据
	 */
	@Column
	private String cfjdxgzj;

	/**
	 * @Description cfjdwfgd的中文含义是： 违法的规定
	 */
	@Column
	private String cfjdwfgd;

	/**
	 * @Description cfjdwfgdtk的中文含义是： 违法的规定的条款
	 */
	@Column
	private String cfjdwfgdtk;

	/**
	 * @Description cfjdyjgd的中文含义是： 依据的规定
	 */
	@Column
	private String cfjdyjgd;

	/**
	 * @Description cfjdyjgdtk的中文含义是： 依据的规定的条款
	 */
	@Column
	private String cfjdyjgdtk;

	/**
	 * @Description cfjdxzcf的中文含义是： 行政处罚内容
	 */
	@Column
	private String cfjdxzcf;

	/**
	 * @Description cfjdjkyh的中文含义是： 罚没款缴款银行,见AA01表FMKJKYH
	 */
	@Column
	private String cfjdjkyh;

	/**
	 * @Description cfjdgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String cfjdgzrq;

	/**
	 * @Description cfjdwsbh的中文含义是： 文书编号
	 */
	@Column
	private String cfjdwsbh;

	/**
	 * @Description cfjddsr的中文含义是： 当事人
	 */
	@Column
	private String cfjddsr;

	/**
	 * @Description cfjddz的中文含义是： 地址（住址）
	 */
	@Column
	private String cfjddz;

	/**
	 * @Description cfjdyb的中文含义是： 邮编
	 */
	@Column
	private String cfjdyb;

	/**
	 * @Description cfjdyyzz的中文含义是： 营业执照或其他资质证明
	 */
	@Column
	private String cfjdyyzz;

	/**
	 * @Description cfjdyyzzbh的中文含义是： 营业执照或其他资质证明编号
	 */
	@Column
	private String cfjdyyzzbh;

	/**
	 * @Description cfjdzzjgdm的中文含义是： 组织机构代码（身份证）号
	 */
	@Column
	private String cfjdzzjgdm;

	/**
	 * @Description cfjdfddbr的中文含义是： 法定代表人（负责人）
	 */
	@Column
	private String cfjdfddbr;

	/**
	 * @Description cfjdfddbrxb的中文含义是： 法定代表人（负责人）性别
	 */
	@Column
	private String cfjdfddbrxb;

	/**
	 * @Description cfjdfddbrzw的中文含义是： 法定代表人（负责人）职务
	 */
	@Column
	private String cfjdfddbrzw;

	/**
	 * @Description sjspypjdglj的中文含义是： 上级食品药品监督管理局
	 */
	@Column
	private String sjspypjdglj;

	/**
	 * @Description sjrmzf的中文含义是： 上级人民政府aaa100=SJRMZF
	 */
	@Column
	private String sjrmzf;

	/**
	 * @Description sjrmfy的中文含义是： 上级人民法院aaa100=SJRMFY
	 */
	@Column
	private String sjrmfy;

	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人员法院aaa100=QZZZRMFY
	 */
	@Column
	private String qzzzrmfy;

	/**
	 * @Description cfjdbcfrzrrxm的中文含义是： 被处罚人（自然人）姓名
	 */
	@Column
	private String cfjdbcfrzrrxm;

	/**
	 * @Description cfjdbcfrzrrxb的中文含义是： 被处罚人（自然人）性别
	 */
	@Column
	private String cfjdbcfrzrrxb;

	/**
	 * @Description cfjdbcfrzrrnl的中文含义是： 被处罚人（自然人）年龄
	 */
	@Column
	private String cfjdbcfrzrrnl;

	/**
	 * @Description cfjdbcfrzrrszdw的中文含义是： 被处罚人（自然人）所在单位
	 */
	@Column
	private String cfjdbcfrzrrszdw;

	/**
	 * @Description cfjdbcfrzrrszdwdz的中文含义是： 被处罚人（自然人）所在单位地址
	 */
	@Column
	private String cfjdbcfrzrrszdwdz;

	/**
	 * @Description cfjdbcfrdwmc的中文含义是： 被处罚人（单位）名称
	 */
	@Column
	private String cfjdbcfrdwmc;

	/**
	 * @Description cfjdbcfrdwdz的中文含义是： 被处罚人（单位）地址
	 */
	@Column
	private String cfjdbcfrdwdz;

	/**
	 * @Description cfjdbcfrdwyyzz的中文含义是： 被处罚人（单位）营业执照或其他资质证明
	 */
	@Column
	private String cfjdbcfrdwyyzz;

	/**
	 * @Description cfjdbcfrdwyyzzbh的中文含义是： 被处罚人（单位）营业执照或其他资质证明编号
	 */
	@Column
	private String cfjdbcfrdwyyzzbh;

	/**
	 * @Description cfjdbcfrdwfddbr的中文含义是： 被处罚人（单位）法定代表人
	 */
	@Column
	private String cfjdbcfrdwfddbr;

	/**
	 * @Description cfjdbcfrdwfddbrxb的中文含义是： 被处罚人（单位）法定代表人性别
	 */
	@Column
	private String cfjdbcfrdwfddbrxb;

	/**
	 * @Description cfjdbcfrdwfddbrzw的中文含义是： 被处罚人（单位）法定代表人职务
	 */
	@Column
	private String cfjdbcfrdwfddbrzw;

	/**
	 * @Description cfjdlarq的中文含义是： 立案日期
	 */
	@Column
	private String cfjdlarq;

	/**
	 * @Description cfjdajmc的中文含义是： 案件名称
	 */
	@Column
	private String cfjdajmc;

	/**
	 * @Description cfjdwfxwksrq的中文含义是： 违法行为开始日期
	 */
	@Column
	private String cfjdwfxwksrq;

	/**
	 * @Description cfjdwfxwjsrq的中文含义是： 违法行为结束日期
	 */
	@Column
	private String cfjdwfxwjsrq;

	/**
	 * @Description cfjdwfxw的中文含义是： 违法行为
	 */
	@Column
	private String cfjdwfxw;

	/**
	 * @Description wfxwdc的中文含义是： 违法行为等次aaa100=WFXWDC
	 */
	@Column
	private String wfxwdc;

	/**
	 * @Description zxjgmc的中文含义是：行政机关名称
	 */
	@Column
	private String zxjgmc;
	/**
	 * @Description gmsfhm的中文含义是： 公民身份号码
	 */
	@Column
	private String gmsfhm;
	/**
	 * @Description syzmnr的中文含义是：所要证明内容
	 */
	@Column
	private String syzmnr;
	/**
	 * @Description xzcfclbz的中文含义是： 行政处罚裁量标准
	 */
	@Column
	private String xzcfclbz;
	/**
	 * @Description yhzh的中文含义是： 银行账号
	 */
	@Column
	private String yhzh;
	
	/**
	 * @Description xzcfjdsid的中文含义是： 行政处罚决定书ID
	 */
	public void setXzcfjdsid(String xzcfjdsid){ 
		this.xzcfjdsid = xzcfjdsid;
	}
	/**
	 * @Description xzcfjdsid的中文含义是： 行政处罚决定书ID
	 */
	public String getXzcfjdsid(){
		return xzcfjdsid;
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
	 * @Description cfjdwfss的中文含义是： 违法事实
	 */
	public void setCfjdwfss(String cfjdwfss){ 
		this.cfjdwfss = cfjdwfss;
	}
	/**
	 * @Description cfjdwfss的中文含义是： 违法事实
	 */
	public String getCfjdwfss(){
		return cfjdwfss;
	}
	/**
	 * @Description cfjdxgzj的中文含义是： 相关证据
	 */
	public void setCfjdxgzj(String cfjdxgzj){ 
		this.cfjdxgzj = cfjdxgzj;
	}
	/**
	 * @Description cfjdxgzj的中文含义是： 相关证据
	 */
	public String getCfjdxgzj(){
		return cfjdxgzj;
	}
	/**
	 * @Description cfjdwfgd的中文含义是： 违法的规定
	 */
	public void setCfjdwfgd(String cfjdwfgd){ 
		this.cfjdwfgd = cfjdwfgd;
	}
	/**
	 * @Description cfjdwfgd的中文含义是： 违法的规定
	 */
	public String getCfjdwfgd(){
		return cfjdwfgd;
	}
	/**
	 * @Description cfjdwfgdtk的中文含义是： 违法的规定的条款
	 */
	public void setCfjdwfgdtk(String cfjdwfgdtk){ 
		this.cfjdwfgdtk = cfjdwfgdtk;
	}
	/**
	 * @Description cfjdwfgdtk的中文含义是： 违法的规定的条款
	 */
	public String getCfjdwfgdtk(){
		return cfjdwfgdtk;
	}
	/**
	 * @Description cfjdyjgd的中文含义是： 依据的规定
	 */
	public void setCfjdyjgd(String cfjdyjgd){ 
		this.cfjdyjgd = cfjdyjgd;
	}
	/**
	 * @Description cfjdyjgd的中文含义是： 依据的规定
	 */
	public String getCfjdyjgd(){
		return cfjdyjgd;
	}
	/**
	 * @Description cfjdyjgdtk的中文含义是： 依据的规定的条款
	 */
	public void setCfjdyjgdtk(String cfjdyjgdtk){ 
		this.cfjdyjgdtk = cfjdyjgdtk;
	}
	/**
	 * @Description cfjdyjgdtk的中文含义是： 依据的规定的条款
	 */
	public String getCfjdyjgdtk(){
		return cfjdyjgdtk;
	}
	/**
	 * @Description cfjdxzcf的中文含义是： 行政处罚内容
	 */
	public void setCfjdxzcf(String cfjdxzcf){ 
		this.cfjdxzcf = cfjdxzcf;
	}
	/**
	 * @Description cfjdxzcf的中文含义是： 行政处罚内容
	 */
	public String getCfjdxzcf(){
		return cfjdxzcf;
	}
	/**
	 * @Description cfjdjkyh的中文含义是： 罚没款缴款银行,见AA01表FMKJKYH
	 */
	public void setCfjdjkyh(String cfjdjkyh){ 
		this.cfjdjkyh = cfjdjkyh;
	}
	/**
	 * @Description cfjdjkyh的中文含义是： 罚没款缴款银行,见AA01表FMKJKYH
	 */
	public String getCfjdjkyh(){
		return cfjdjkyh;
	}
	/**
	 * @Description cfjdgzrq的中文含义是： 盖章日期
	 */
	public void setCfjdgzrq(String cfjdgzrq){ 
		this.cfjdgzrq = cfjdgzrq;
	}
	/**
	 * @Description cfjdgzrq的中文含义是： 盖章日期
	 */
	public String getCfjdgzrq(){
		return cfjdgzrq;
	}
	/**
	 * @Description cfjdwsbh的中文含义是： 文书编号
	 */
	public void setCfjdwsbh(String cfjdwsbh){ 
		this.cfjdwsbh = cfjdwsbh;
	}
	/**
	 * @Description cfjdwsbh的中文含义是： 文书编号
	 */
	public String getCfjdwsbh(){
		return cfjdwsbh;
	}
	/**
	 * @Description cfjddsr的中文含义是： 当事人
	 */
	public void setCfjddsr(String cfjddsr){ 
		this.cfjddsr = cfjddsr;
	}
	/**
	 * @Description cfjddsr的中文含义是： 当事人
	 */
	public String getCfjddsr(){
		return cfjddsr;
	}
	/**
	 * @Description cfjddz的中文含义是： 地址（住址）
	 */
	public void setCfjddz(String cfjddz){ 
		this.cfjddz = cfjddz;
	}
	/**
	 * @Description cfjddz的中文含义是： 地址（住址）
	 */
	public String getCfjddz(){
		return cfjddz;
	}
	/**
	 * @Description cfjdyb的中文含义是： 邮编
	 */
	public void setCfjdyb(String cfjdyb){ 
		this.cfjdyb = cfjdyb;
	}
	/**
	 * @Description cfjdyb的中文含义是： 邮编
	 */
	public String getCfjdyb(){
		return cfjdyb;
	}
	/**
	 * @Description cfjdyyzz的中文含义是： 营业执照或其他资质证明
	 */
	public void setCfjdyyzz(String cfjdyyzz){ 
		this.cfjdyyzz = cfjdyyzz;
	}
	/**
	 * @Description cfjdyyzz的中文含义是： 营业执照或其他资质证明
	 */
	public String getCfjdyyzz(){
		return cfjdyyzz;
	}
	/**
	 * @Description cfjdyyzzbh的中文含义是： 营业执照或其他资质证明编号
	 */
	public void setCfjdyyzzbh(String cfjdyyzzbh){ 
		this.cfjdyyzzbh = cfjdyyzzbh;
	}
	/**
	 * @Description cfjdyyzzbh的中文含义是： 营业执照或其他资质证明编号
	 */
	public String getCfjdyyzzbh(){
		return cfjdyyzzbh;
	}
	/**
	 * @Description cfjdzzjgdm的中文含义是： 组织机构代码（身份证）号
	 */
	public void setCfjdzzjgdm(String cfjdzzjgdm){ 
		this.cfjdzzjgdm = cfjdzzjgdm;
	}
	/**
	 * @Description cfjdzzjgdm的中文含义是： 组织机构代码（身份证）号
	 */
	public String getCfjdzzjgdm(){
		return cfjdzzjgdm;
	}
	/**
	 * @Description cfjdfddbr的中文含义是： 法定代表人（负责人）
	 */
	public void setCfjdfddbr(String cfjdfddbr){ 
		this.cfjdfddbr = cfjdfddbr;
	}
	/**
	 * @Description cfjdfddbr的中文含义是： 法定代表人（负责人）
	 */
	public String getCfjdfddbr(){
		return cfjdfddbr;
	}
	/**
	 * @Description cfjdfddbrxb的中文含义是： 法定代表人（负责人）性别
	 */
	public void setCfjdfddbrxb(String cfjdfddbrxb){ 
		this.cfjdfddbrxb = cfjdfddbrxb;
	}
	/**
	 * @Description cfjdfddbrxb的中文含义是： 法定代表人（负责人）性别
	 */
	public String getCfjdfddbrxb(){
		return cfjdfddbrxb;
	}
	/**
	 * @Description cfjdfddbrzw的中文含义是： 法定代表人（负责人）职务
	 */
	public void setCfjdfddbrzw(String cfjdfddbrzw){ 
		this.cfjdfddbrzw = cfjdfddbrzw;
	}
	/**
	 * @Description cfjdfddbrzw的中文含义是： 法定代表人（负责人）职务
	 */
	public String getCfjdfddbrzw(){
		return cfjdfddbrzw;
	}
	/**
	 * @Description sjspypjdglj的中文含义是： 上级食品药品监督管理局
	 */
	public void setSjspypjdglj(String sjspypjdglj){ 
		this.sjspypjdglj = sjspypjdglj;
	}
	/**
	 * @Description sjspypjdglj的中文含义是： 上级食品药品监督管理局
	 */
	public String getSjspypjdglj(){
		return sjspypjdglj;
	}
	/**
	 * @Description sjrmzf的中文含义是： 上级人民政府aaa100=SJRMZF
	 */
	public void setSjrmzf(String sjrmzf){ 
		this.sjrmzf = sjrmzf;
	}
	/**
	 * @Description sjrmzf的中文含义是： 上级人民政府aaa100=SJRMZF
	 */
	public String getSjrmzf(){
		return sjrmzf;
	}
	/**
	 * @Description sjrmfy的中文含义是： 上级人民法院aaa100=SJRMFY
	 */
	public void setSjrmfy(String sjrmfy){ 
		this.sjrmfy = sjrmfy;
	}
	/**
	 * @Description sjrmfy的中文含义是： 上级人民法院aaa100=SJRMFY
	 */
	public String getSjrmfy(){
		return sjrmfy;
	}
	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人员法院aaa100=QZZZRMFY
	 */
	public void setQzzzrmfy(String qzzzrmfy){ 
		this.qzzzrmfy = qzzzrmfy;
	}
	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人员法院aaa100=QZZZRMFY
	 */
	public String getQzzzrmfy(){
		return qzzzrmfy;
	}
	/**
	 * @Description cfjdbcfrzrrxm的中文含义是： 被处罚人（自然人）姓名
	 */
	public void setCfjdbcfrzrrxm(String cfjdbcfrzrrxm){ 
		this.cfjdbcfrzrrxm = cfjdbcfrzrrxm;
	}
	/**
	 * @Description cfjdbcfrzrrxm的中文含义是： 被处罚人（自然人）姓名
	 */
	public String getCfjdbcfrzrrxm(){
		return cfjdbcfrzrrxm;
	}
	/**
	 * @Description cfjdbcfrzrrxb的中文含义是： 被处罚人（自然人）性别
	 */
	public void setCfjdbcfrzrrxb(String cfjdbcfrzrrxb){ 
		this.cfjdbcfrzrrxb = cfjdbcfrzrrxb;
	}
	/**
	 * @Description cfjdbcfrzrrxb的中文含义是： 被处罚人（自然人）性别
	 */
	public String getCfjdbcfrzrrxb(){
		return cfjdbcfrzrrxb;
	}
	/**
	 * @Description cfjdbcfrzrrnl的中文含义是： 被处罚人（自然人）年龄
	 */
	public void setCfjdbcfrzrrnl(String cfjdbcfrzrrnl){ 
		this.cfjdbcfrzrrnl = cfjdbcfrzrrnl;
	}
	/**
	 * @Description cfjdbcfrzrrnl的中文含义是： 被处罚人（自然人）年龄
	 */
	public String getCfjdbcfrzrrnl(){
		return cfjdbcfrzrrnl;
	}
	/**
	 * @Description cfjdbcfrzrrszdw的中文含义是： 被处罚人（自然人）所在单位
	 */
	public void setCfjdbcfrzrrszdw(String cfjdbcfrzrrszdw){ 
		this.cfjdbcfrzrrszdw = cfjdbcfrzrrszdw;
	}
	/**
	 * @Description cfjdbcfrzrrszdw的中文含义是： 被处罚人（自然人）所在单位
	 */
	public String getCfjdbcfrzrrszdw(){
		return cfjdbcfrzrrszdw;
	}
	/**
	 * @Description cfjdbcfrzrrszdwdz的中文含义是： 被处罚人（自然人）所在单位地址
	 */
	public void setCfjdbcfrzrrszdwdz(String cfjdbcfrzrrszdwdz){ 
		this.cfjdbcfrzrrszdwdz = cfjdbcfrzrrszdwdz;
	}
	/**
	 * @Description cfjdbcfrzrrszdwdz的中文含义是： 被处罚人（自然人）所在单位地址
	 */
	public String getCfjdbcfrzrrszdwdz(){
		return cfjdbcfrzrrszdwdz;
	}
	/**
	 * @Description cfjdbcfrdwmc的中文含义是： 被处罚人（单位）名称
	 */
	public void setCfjdbcfrdwmc(String cfjdbcfrdwmc){ 
		this.cfjdbcfrdwmc = cfjdbcfrdwmc;
	}
	/**
	 * @Description cfjdbcfrdwmc的中文含义是： 被处罚人（单位）名称
	 */
	public String getCfjdbcfrdwmc(){
		return cfjdbcfrdwmc;
	}
	/**
	 * @Description cfjdbcfrdwdz的中文含义是： 被处罚人（单位）地址
	 */
	public void setCfjdbcfrdwdz(String cfjdbcfrdwdz){ 
		this.cfjdbcfrdwdz = cfjdbcfrdwdz;
	}
	/**
	 * @Description cfjdbcfrdwdz的中文含义是： 被处罚人（单位）地址
	 */
	public String getCfjdbcfrdwdz(){
		return cfjdbcfrdwdz;
	}
	/**
	 * @Description cfjdbcfrdwyyzz的中文含义是： 被处罚人（单位）营业执照或其他资质证明
	 */
	public void setCfjdbcfrdwyyzz(String cfjdbcfrdwyyzz){ 
		this.cfjdbcfrdwyyzz = cfjdbcfrdwyyzz;
	}
	/**
	 * @Description cfjdbcfrdwyyzz的中文含义是： 被处罚人（单位）营业执照或其他资质证明
	 */
	public String getCfjdbcfrdwyyzz(){
		return cfjdbcfrdwyyzz;
	}
	/**
	 * @Description cfjdbcfrdwyyzzbh的中文含义是： 被处罚人（单位）营业执照或其他资质证明编号
	 */
	public void setCfjdbcfrdwyyzzbh(String cfjdbcfrdwyyzzbh){ 
		this.cfjdbcfrdwyyzzbh = cfjdbcfrdwyyzzbh;
	}
	/**
	 * @Description cfjdbcfrdwyyzzbh的中文含义是： 被处罚人（单位）营业执照或其他资质证明编号
	 */
	public String getCfjdbcfrdwyyzzbh(){
		return cfjdbcfrdwyyzzbh;
	}
	/**
	 * @Description cfjdbcfrdwfddbr的中文含义是： 被处罚人（单位）法定代表人
	 */
	public void setCfjdbcfrdwfddbr(String cfjdbcfrdwfddbr){ 
		this.cfjdbcfrdwfddbr = cfjdbcfrdwfddbr;
	}
	/**
	 * @Description cfjdbcfrdwfddbr的中文含义是： 被处罚人（单位）法定代表人
	 */
	public String getCfjdbcfrdwfddbr(){
		return cfjdbcfrdwfddbr;
	}
	/**
	 * @Description cfjdbcfrdwfddbrxb的中文含义是： 被处罚人（单位）法定代表人性别
	 */
	public void setCfjdbcfrdwfddbrxb(String cfjdbcfrdwfddbrxb){ 
		this.cfjdbcfrdwfddbrxb = cfjdbcfrdwfddbrxb;
	}
	/**
	 * @Description cfjdbcfrdwfddbrxb的中文含义是： 被处罚人（单位）法定代表人性别
	 */
	public String getCfjdbcfrdwfddbrxb(){
		return cfjdbcfrdwfddbrxb;
	}
	/**
	 * @Description cfjdbcfrdwfddbrzw的中文含义是： 被处罚人（单位）法定代表人职务
	 */
	public void setCfjdbcfrdwfddbrzw(String cfjdbcfrdwfddbrzw){ 
		this.cfjdbcfrdwfddbrzw = cfjdbcfrdwfddbrzw;
	}
	/**
	 * @Description cfjdbcfrdwfddbrzw的中文含义是： 被处罚人（单位）法定代表人职务
	 */
	public String getCfjdbcfrdwfddbrzw(){
		return cfjdbcfrdwfddbrzw;
	}
	/**
	 * @Description cfjdlarq的中文含义是： 立案日期
	 */
	public void setCfjdlarq(String cfjdlarq){ 
		this.cfjdlarq = cfjdlarq;
	}
	/**
	 * @Description cfjdlarq的中文含义是： 立案日期
	 */
	public String getCfjdlarq(){
		return cfjdlarq;
	}
	/**
	 * @Description cfjdajmc的中文含义是： 案件名称
	 */
	public void setCfjdajmc(String cfjdajmc){ 
		this.cfjdajmc = cfjdajmc;
	}
	/**
	 * @Description cfjdajmc的中文含义是： 案件名称
	 */
	public String getCfjdajmc(){
		return cfjdajmc;
	}
	/**
	 * @Description cfjdwfxwksrq的中文含义是： 违法行为开始日期
	 */
	public void setCfjdwfxwksrq(String cfjdwfxwksrq){ 
		this.cfjdwfxwksrq = cfjdwfxwksrq;
	}
	/**
	 * @Description cfjdwfxwksrq的中文含义是： 违法行为开始日期
	 */
	public String getCfjdwfxwksrq(){
		return cfjdwfxwksrq;
	}
	/**
	 * @Description cfjdwfxwjsrq的中文含义是： 违法行为结束日期
	 */
	public void setCfjdwfxwjsrq(String cfjdwfxwjsrq){ 
		this.cfjdwfxwjsrq = cfjdwfxwjsrq;
	}
	/**
	 * @Description cfjdwfxwjsrq的中文含义是： 违法行为结束日期
	 */
	public String getCfjdwfxwjsrq(){
		return cfjdwfxwjsrq;
	}
	/**
	 * @Description cfjdwfxw的中文含义是： 违法行为
	 */
	public void setCfjdwfxw(String cfjdwfxw){ 
		this.cfjdwfxw = cfjdwfxw;
	}
	/**
	 * @Description cfjdwfxw的中文含义是： 违法行为
	 */
	public String getCfjdwfxw(){
		return cfjdwfxw;
	}
	/**
	 * @Description wfxwdc的中文含义是： 违法行为等次aaa100=WFXWDC
	 */
	public void setWfxwdc(String wfxwdc){ 
		this.wfxwdc = wfxwdc;
	}
	/**
	 * @Description wfxwdc的中文含义是： 违法行为等次aaa100=WFXWDC
	 */
	public String getWfxwdc(){
		return wfxwdc;
	}
	/**
	 * @Description zxjgmc的中文含义是：行政机关名称
	 */
	public String getZxjgmc() {
		return zxjgmc;
	}
	/**
	 * @Description zxjgmc的中文含义是：行政机关名称
	 */
	public void setZxjgmc(String zxjgmc) {
		this.zxjgmc = zxjgmc;
	}
	/**
	 * @Description gmsfhm的中文含义是： 公民身份号码
	 */
	public String getGmsfhm() {
		return gmsfhm;
	}
	/**
	 * @Description gmsfhm的中文含义是： 公民身份号码
	 */
	public void setGmsfhm(String gmsfhm) {
		this.gmsfhm = gmsfhm;
	}
	/**
	 * @Description syzmnr的中文含义是：所要证明内容
	 */
	public String getSyzmnr() {
		return syzmnr;
	}
	/**
	 * @Description syzmnr的中文含义是：所要证明内容
	 */
	public void setSyzmnr(String syzmnr) {
		this.syzmnr = syzmnr;
	}
	/**
	 * @Description xzcfclbz的中文含义是： 行政处罚裁量标准
	 */
	public String getXzcfclbz() {
		return xzcfclbz;
	}
	/**
	 * @Description xzcfclbz的中文含义是： 行政处罚裁量标准
	 */
	public void setXzcfclbz(String xzcfclbz) {
		this.xzcfclbz = xzcfclbz;
	}
	/**
	 * @Description yhzh的中文含义是： 银行账号
	 */
	public String getYhzh() {
		return yhzh;
	}
	/**
	 * @Description yhzh的中文含义是： 银行账号
	 */
	public void setYhzh(String yhzh) {
		this.yhzh = yhzh;
	}
	
}