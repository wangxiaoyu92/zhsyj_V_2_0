package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSXWDCBL7的中文含义是: 询问调查笔录
 * @Creation     2016/09/03 09:23:49
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXWDCBL7")
public class Zfwsxwdcbl7 {
	/**
	 * @Description xwdcblid的中文含义是： 询问调查笔录ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xwdcblid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xwdcblid.nextval from dual"))
	private String xwdcblid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description dcblzfry1的中文含义是： 执法人员1
	 */
	@Column
	private String dcblzfry1;

	/**
	 * @Description dcblzfry2的中文含义是： 执法人员2
	 */
	@Column
	private String dcblzfry2;

	/**
	 * @Description dcblbxwdwmc的中文含义是： 被询问单位名称
	 */
	@Column
	private String dcblbxwdwmc;

	/**
	 * @Description dcblbxwdwfddbr的中文含义是： 被询问单位法定代表人(负责人)
	 */
	@Column
	private String dcblbxwdwfddbr;

	/**
	 * @Description dcblbxwdwdh的中文含义是： 被询问单位电话
	 */
	@Column
	private String dcblbxwdwdh;

	/**
	 * @Description dcblbxwrxb的中文含义是： 被询问人性别
	 */
	@Column
	private String dcblbxwrxb;

	/**
	 * @Description dcblbxwrnl的中文含义是： 被询问人年龄
	 */
	@Column
	private String dcblbxwrnl;

	/**
	 * @Description dcblbxwzrrxm的中文含义是： 被询问自然人姓名
	 */
	@Column
	private String dcblbxwzrrxm;

	/**
	 * @Description dcblbxwzrrxb的中文含义是： 被询问自然人性别
	 */
	@Column
	private String dcblbxwzrrxb;

	/**
	 * @Description dcblbxwzrrdh的中文含义是： 被询问自然人电话
	 */
	@Column
	private String dcblbxwzrrdh;

	/**
	 * @Description dcblbxwzrrszdw的中文含义是： 被询问自然人所在单位
	 */
	@Column
	private String dcblbxwzrrszdw;

	/**
	 * @Description dcblbxwzrrzz的中文含义是： 被询问自然人住址
	 */
	@Column
	private String dcblbxwzrrzz;

	/**
	 * @Description dcblbxwzrrybagx的中文含义是： 被询问自然人与本案关系(加AA100=YBAGX)
	 */
	@Column
	private String dcblbxwzrrybagx;

	/**
	 * @Description dcbldcdd的中文含义是： 调查地点
	 */
	@Column
	private String dcbldcdd;

	/**
	 * @Description dcblbdcr的中文含义是： 被调查人(被询问人姓名)
	 */
	@Column
	private String dcblbdcr;

	/**
	 * @Description dcblzw的中文含义是： 被调查人职务(被询问人职务)
	 */
	@Column
	private String dcblzw;

	/**
	 * @Description dcblmz的中文含义是： 被调查人民族
	 */
	@Column
	private String dcblmz;

	/**
	 * @Description dcblsfzh的中文含义是： 被调查人身份证号
	 */
	@Column
	private String dcblsfzh;

	/**
	 * @Description dcblgzdw的中文含义是： 被调查人工作单位
	 */
	@Column
	private String dcblgzdw;

	/**
	 * @Description dcbllxfs的中文含义是： 被调查人联系方式(被询问人电话)
	 */
	@Column
	private String dcbllxfs;

	/**
	 * @Description dcbldz的中文含义是： 被调查人地址
	 */
	@Column
	private String dcbldz;

	/**
	 * @Description dcbldcr1的中文含义是： 调查人1(询问人，汤阴用)
	 */
	@Column
	private String dcbldcr1;

	/**
	 * @Description dcbldcrqz2的中文含义是： 调查人签字2(执法人员签字)2
	 */
	@Column
	private String dcbldcrqz2;

	/**
	 * @Description dcbldcr2的中文含义是： 调查人2
	 */
	@Column
	private String dcbldcr2;

	/**
	 * @Description dcbljlr的中文含义是： 记录人
	 */
	@Column
	private String dcbljlr;

	/**
	 * @Description dcbljdjclb的中文含义是： 监督检查类别,见代码表dcbljdjclb
	 */
	@Column
	private String dcbljdjclb;

	/**
	 * @Description dcbldckssj的中文含义是： 调查开始时间
	 */
	@Column
	private String dcbldckssj;

	/**
	 * @Description dcbldcjssj的中文含义是： 调查结束时间
	 */
	@Column
	private String dcbldcjssj;

	/**
	 * @Description spypjdgljmcqc的中文含义是： 食品药品监督管理局名称全称SPYPJDGLJMCQC，见aa01表aaa001=SPYPJDGLJMCQC
	 */
	@Column
	private String spypjdgljmcqc;

	/**
	 * @Description zfzjmc的中文含义是： 执法证件名称，见aa01表aaa001=ZFZJMC
	 */
	@Column
	private String zfzjmc;

	/**
	 * @Description dcbldcr1zjbh的中文含义是： 执法人员1证件编号
	 */
	@Column
	private String dcbldcr1zjbh;

	/**
	 * @Description dcbldcr2zjbh的中文含义是： 执法人员2证件编号
	 */
	@Column
	private String dcbldcr2zjbh;

	/**
	 * @Description dcblsfkqc的中文含义是： 是否看清楚
	 */
	@Column
	private String dcblsfkqc;

	/**
	 * @Description dcblygwt的中文含义是： 有关问题
	 */
	@Column
	private String dcblygwt;

	/**
	 * @Description dcblsfsqdcryhb的中文含义是： 是否申请调查人员回避
	 */
	@Column
	private String dcblsfsqdcryhb;

	/**
	 * @Description dcblsfmbbnzwz的中文含义是： 是否明白不能做伪证
	 */
	@Column
	private String dcblsfmbbnzwz;

	/**
	 * @Description dcbldcjl的中文含义是： 调查记录
	 */
	@Column
	private String dcbldcjl;

	/**
	 * @Description dcblbdcrqz的中文含义是： 被调查人签字(被询问人签字)
	 */
	@Column
	private String dcblbdcrqz;

	/**
	 * @Description dcblbdcrqzrq的中文含义是： 被调查人签字日期(被询问人签字)
	 */
	@Column
	private String dcblbdcrqzrq;

	/**
	 * @Description dcbldcrqz1的中文含义是： 调查人签字1(执法人员签字)1
	 */
	@Column
	private String dcbldcrqz1;

	/**
	 * @Description dcbldcrqzrq的中文含义是： 调查人签字日期(执法人员签字日期)
	 */
	@Column
	private String dcbldcrqzrq;

	/**
	 * @Description dcbljlrqz的中文含义是： 调查记录人签字
	 */
	@Column
	private String dcbljlrqz;

	/**
	 * @Description dcbljlrqzrq的中文含义是： 调查记录人签字日期
	 */
	@Column
	private String dcbljlrqzrq;  
	/**
	 * @Description dcblbdcryb的中文含义是： 被调查人邮编
	 */
	@Column
	private String dcblbdcryb;

	
		/**
	 * @Description xwdcblid的中文含义是： 询问调查笔录ID
	 */
	public void setXwdcblid(String xwdcblid){ 
		this.xwdcblid = xwdcblid;
	}
	/**
	 * @Description xwdcblid的中文含义是： 询问调查笔录ID
	 */
	public String getXwdcblid(){
		return xwdcblid;
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
	 * @Description dcblzfry1的中文含义是： 执法人员1
	 */
	public void setDcblzfry1(String dcblzfry1){ 
		this.dcblzfry1 = dcblzfry1;
	}
	/**
	 * @Description dcblzfry1的中文含义是： 执法人员1
	 */
	public String getDcblzfry1(){
		return dcblzfry1;
	}
	/**
	 * @Description dcblzfry2的中文含义是： 执法人员2
	 */
	public void setDcblzfry2(String dcblzfry2){ 
		this.dcblzfry2 = dcblzfry2;
	}
	/**
	 * @Description dcblzfry2的中文含义是： 执法人员2
	 */
	public String getDcblzfry2(){
		return dcblzfry2;
	}
	/**
	 * @Description dcblbxwdwmc的中文含义是： 被询问单位名称
	 */
	public void setDcblbxwdwmc(String dcblbxwdwmc){ 
		this.dcblbxwdwmc = dcblbxwdwmc;
	}
	/**
	 * @Description dcblbxwdwmc的中文含义是： 被询问单位名称
	 */
	public String getDcblbxwdwmc(){
		return dcblbxwdwmc;
	}
	/**
	 * @Description dcblbxwdwfddbr的中文含义是： 被询问单位法定代表人(负责人)
	 */
	public void setDcblbxwdwfddbr(String dcblbxwdwfddbr){ 
		this.dcblbxwdwfddbr = dcblbxwdwfddbr;
	}
	/**
	 * @Description dcblbxwdwfddbr的中文含义是： 被询问单位法定代表人(负责人)
	 */
	public String getDcblbxwdwfddbr(){
		return dcblbxwdwfddbr;
	}
	/**
	 * @Description dcblbxwdwdh的中文含义是： 被询问单位电话
	 */
	public void setDcblbxwdwdh(String dcblbxwdwdh){ 
		this.dcblbxwdwdh = dcblbxwdwdh;
	}
	/**
	 * @Description dcblbxwdwdh的中文含义是： 被询问单位电话
	 */
	public String getDcblbxwdwdh(){
		return dcblbxwdwdh;
	}
	/**
	 * @Description dcblbxwrxb的中文含义是： 被询问人性别
	 */
	public void setDcblbxwrxb(String dcblbxwrxb){ 
		this.dcblbxwrxb = dcblbxwrxb;
	}
	/**
	 * @Description dcblbxwrxb的中文含义是： 被询问人性别
	 */
	public String getDcblbxwrxb(){
		return dcblbxwrxb;
	}
	/**
	 * @Description dcblbxwrnl的中文含义是： 被询问人年龄
	 */
	public void setDcblbxwrnl(String dcblbxwrnl){ 
		this.dcblbxwrnl = dcblbxwrnl;
	}
	/**
	 * @Description dcblbxwrnl的中文含义是： 被询问人年龄
	 */
	public String getDcblbxwrnl(){
		return dcblbxwrnl;
	}
	/**
	 * @Description dcblbxwzrrxm的中文含义是： 被询问自然人姓名
	 */
	public void setDcblbxwzrrxm(String dcblbxwzrrxm){ 
		this.dcblbxwzrrxm = dcblbxwzrrxm;
	}
	/**
	 * @Description dcblbxwzrrxm的中文含义是： 被询问自然人姓名
	 */
	public String getDcblbxwzrrxm(){
		return dcblbxwzrrxm;
	}
	/**
	 * @Description dcblbxwzrrxb的中文含义是： 被询问自然人性别
	 */
	public void setDcblbxwzrrxb(String dcblbxwzrrxb){ 
		this.dcblbxwzrrxb = dcblbxwzrrxb;
	}
	/**
	 * @Description dcblbxwzrrxb的中文含义是： 被询问自然人性别
	 */
	public String getDcblbxwzrrxb(){
		return dcblbxwzrrxb;
	}
	/**
	 * @Description dcblbxwzrrdh的中文含义是： 被询问自然人电话
	 */
	public void setDcblbxwzrrdh(String dcblbxwzrrdh){ 
		this.dcblbxwzrrdh = dcblbxwzrrdh;
	}
	/**
	 * @Description dcblbxwzrrdh的中文含义是： 被询问自然人电话
	 */
	public String getDcblbxwzrrdh(){
		return dcblbxwzrrdh;
	}
	/**
	 * @Description dcblbxwzrrszdw的中文含义是： 被询问自然人所在单位
	 */
	public void setDcblbxwzrrszdw(String dcblbxwzrrszdw){ 
		this.dcblbxwzrrszdw = dcblbxwzrrszdw;
	}
	/**
	 * @Description dcblbxwzrrszdw的中文含义是： 被询问自然人所在单位
	 */
	public String getDcblbxwzrrszdw(){
		return dcblbxwzrrszdw;
	}
	/**
	 * @Description dcblbxwzrrzz的中文含义是： 被询问自然人住址
	 */
	public void setDcblbxwzrrzz(String dcblbxwzrrzz){ 
		this.dcblbxwzrrzz = dcblbxwzrrzz;
	}
	/**
	 * @Description dcblbxwzrrzz的中文含义是： 被询问自然人住址
	 */
	public String getDcblbxwzrrzz(){
		return dcblbxwzrrzz;
	}
	/**
	 * @Description dcblbxwzrrybagx的中文含义是： 被询问自然人与本案关系(加AA100=YBAGX)
	 */
	public void setDcblbxwzrrybagx(String dcblbxwzrrybagx){ 
		this.dcblbxwzrrybagx = dcblbxwzrrybagx;
	}
	/**
	 * @Description dcblbxwzrrybagx的中文含义是： 被询问自然人与本案关系(加AA100=YBAGX)
	 */
	public String getDcblbxwzrrybagx(){
		return dcblbxwzrrybagx;
	}
	/**
	 * @Description dcbldcdd的中文含义是： 调查地点
	 */
	public void setDcbldcdd(String dcbldcdd){ 
		this.dcbldcdd = dcbldcdd;
	}
	/**
	 * @Description dcbldcdd的中文含义是： 调查地点
	 */
	public String getDcbldcdd(){
		return dcbldcdd;
	}
	/**
	 * @Description dcblbdcr的中文含义是： 被调查人(被询问人姓名)
	 */
	public void setDcblbdcr(String dcblbdcr){ 
		this.dcblbdcr = dcblbdcr;
	}
	/**
	 * @Description dcblbdcr的中文含义是： 被调查人(被询问人姓名)
	 */
	public String getDcblbdcr(){
		return dcblbdcr;
	}
	/**
	 * @Description dcblzw的中文含义是： 被调查人职务(被询问人职务)
	 */
	public void setDcblzw(String dcblzw){ 
		this.dcblzw = dcblzw;
	}
	/**
	 * @Description dcblzw的中文含义是： 被调查人职务(被询问人职务)
	 */
	public String getDcblzw(){
		return dcblzw;
	}
	/**
	 * @Description dcblmz的中文含义是： 被调查人民族
	 */
	public void setDcblmz(String dcblmz){ 
		this.dcblmz = dcblmz;
	}
	/**
	 * @Description dcblmz的中文含义是： 被调查人民族
	 */
	public String getDcblmz(){
		return dcblmz;
	}
	/**
	 * @Description dcblsfzh的中文含义是： 被调查人身份证号
	 */
	public void setDcblsfzh(String dcblsfzh){ 
		this.dcblsfzh = dcblsfzh;
	}
	/**
	 * @Description dcblsfzh的中文含义是： 被调查人身份证号
	 */
	public String getDcblsfzh(){
		return dcblsfzh;
	}
	/**
	 * @Description dcblgzdw的中文含义是： 被调查人工作单位
	 */
	public void setDcblgzdw(String dcblgzdw){ 
		this.dcblgzdw = dcblgzdw;
	}
	/**
	 * @Description dcblgzdw的中文含义是： 被调查人工作单位
	 */
	public String getDcblgzdw(){
		return dcblgzdw;
	}
	/**
	 * @Description dcbllxfs的中文含义是： 被调查人联系方式(被询问人电话)
	 */
	public void setDcbllxfs(String dcbllxfs){ 
		this.dcbllxfs = dcbllxfs;
	}
	/**
	 * @Description dcbllxfs的中文含义是： 被调查人联系方式(被询问人电话)
	 */
	public String getDcbllxfs(){
		return dcbllxfs;
	}
	/**
	 * @Description dcbldz的中文含义是： 被调查人地址
	 */
	public void setDcbldz(String dcbldz){ 
		this.dcbldz = dcbldz;
	}
	/**
	 * @Description dcbldz的中文含义是： 被调查人地址
	 */
	public String getDcbldz(){
		return dcbldz;
	}
	/**
	 * @Description dcbldcr1的中文含义是： 调查人1(询问人，汤阴用)
	 */
	public void setDcbldcr1(String dcbldcr1){ 
		this.dcbldcr1 = dcbldcr1;
	}
	/**
	 * @Description dcbldcr1的中文含义是： 调查人1(询问人，汤阴用)
	 */
	public String getDcbldcr1(){
		return dcbldcr1;
	}
	/**
	 * @Description dcbldcrqz2的中文含义是： 调查人签字2(执法人员签字)2
	 */
	public void setDcbldcrqz2(String dcbldcrqz2){ 
		this.dcbldcrqz2 = dcbldcrqz2;
	}
	/**
	 * @Description dcbldcrqz2的中文含义是： 调查人签字2(执法人员签字)2
	 */
	public String getDcbldcrqz2(){
		return dcbldcrqz2;
	}
	/**
	 * @Description dcbldcr2的中文含义是： 调查人2
	 */
	public void setDcbldcr2(String dcbldcr2){ 
		this.dcbldcr2 = dcbldcr2;
	}
	/**
	 * @Description dcbldcr2的中文含义是： 调查人2
	 */
	public String getDcbldcr2(){
		return dcbldcr2;
	}
	/**
	 * @Description dcbljlr的中文含义是： 记录人
	 */
	public void setDcbljlr(String dcbljlr){ 
		this.dcbljlr = dcbljlr;
	}
	/**
	 * @Description dcbljlr的中文含义是： 记录人
	 */
	public String getDcbljlr(){
		return dcbljlr;
	}
	/**
	 * @Description dcbljdjclb的中文含义是： 监督检查类别,见代码表dcbljdjclb
	 */
	public void setDcbljdjclb(String dcbljdjclb){ 
		this.dcbljdjclb = dcbljdjclb;
	}
	/**
	 * @Description dcbljdjclb的中文含义是： 监督检查类别,见代码表dcbljdjclb
	 */
	public String getDcbljdjclb(){
		return dcbljdjclb;
	}
	/**
	 * @Description dcbldckssj的中文含义是： 调查开始时间
	 */
	public void setDcbldckssj(String dcbldckssj){ 
		this.dcbldckssj = dcbldckssj;
	}
	/**
	 * @Description dcbldckssj的中文含义是： 调查开始时间
	 */
	public String getDcbldckssj(){
		return dcbldckssj;
	}
	/**
	 * @Description dcbldcjssj的中文含义是： 调查结束时间
	 */
	public void setDcbldcjssj(String dcbldcjssj){ 
		this.dcbldcjssj = dcbldcjssj;
	}
	/**
	 * @Description dcbldcjssj的中文含义是： 调查结束时间
	 */
	public String getDcbldcjssj(){
		return dcbldcjssj;
	}
	/**
	 * @Description spypjdgljmcqc的中文含义是： 食品药品监督管理局名称全称SPYPJDGLJMCQC，见aa01表aaa001=SPYPJDGLJMCQC
	 */
	public void setSpypjdgljmcqc(String spypjdgljmcqc){ 
		this.spypjdgljmcqc = spypjdgljmcqc;
	}
	/**
	 * @Description spypjdgljmcqc的中文含义是： 食品药品监督管理局名称全称SPYPJDGLJMCQC，见aa01表aaa001=SPYPJDGLJMCQC
	 */
	public String getSpypjdgljmcqc(){
		return spypjdgljmcqc;
	}
	/**
	 * @Description zfzjmc的中文含义是： 执法证件名称，见aa01表aaa001=ZFZJMC
	 */
	public void setZfzjmc(String zfzjmc){ 
		this.zfzjmc = zfzjmc;
	}
	/**
	 * @Description zfzjmc的中文含义是： 执法证件名称，见aa01表aaa001=ZFZJMC
	 */
	public String getZfzjmc(){
		return zfzjmc;
	}
	/**
	 * @Description dcbldcr1zjbh的中文含义是： 执法人员1证件编号
	 */
	public void setDcbldcr1zjbh(String dcbldcr1zjbh){ 
		this.dcbldcr1zjbh = dcbldcr1zjbh;
	}
	/**
	 * @Description dcbldcr1zjbh的中文含义是： 执法人员1证件编号
	 */
	public String getDcbldcr1zjbh(){
		return dcbldcr1zjbh;
	}
	/**
	 * @Description dcbldcr2zjbh的中文含义是： 执法人员2证件编号
	 */
	public void setDcbldcr2zjbh(String dcbldcr2zjbh){ 
		this.dcbldcr2zjbh = dcbldcr2zjbh;
	}
	/**
	 * @Description dcbldcr2zjbh的中文含义是： 执法人员2证件编号
	 */
	public String getDcbldcr2zjbh(){
		return dcbldcr2zjbh;
	}
	/**
	 * @Description dcblsfkqc的中文含义是： 是否看清楚
	 */
	public void setDcblsfkqc(String dcblsfkqc){ 
		this.dcblsfkqc = dcblsfkqc;
	}
	/**
	 * @Description dcblsfkqc的中文含义是： 是否看清楚
	 */
	public String getDcblsfkqc(){
		return dcblsfkqc;
	}
	/**
	 * @Description dcblygwt的中文含义是： 有关问题
	 */
	public void setDcblygwt(String dcblygwt){ 
		this.dcblygwt = dcblygwt;
	}
	/**
	 * @Description dcblygwt的中文含义是： 有关问题
	 */
	public String getDcblygwt(){
		return dcblygwt;
	}
	/**
	 * @Description dcblsfsqdcryhb的中文含义是： 是否申请调查人员回避
	 */
	public void setDcblsfsqdcryhb(String dcblsfsqdcryhb){ 
		this.dcblsfsqdcryhb = dcblsfsqdcryhb;
	}
	/**
	 * @Description dcblsfsqdcryhb的中文含义是： 是否申请调查人员回避
	 */
	public String getDcblsfsqdcryhb(){
		return dcblsfsqdcryhb;
	}
	/**
	 * @Description dcblsfmbbnzwz的中文含义是： 是否明白不能做伪证
	 */
	public void setDcblsfmbbnzwz(String dcblsfmbbnzwz){ 
		this.dcblsfmbbnzwz = dcblsfmbbnzwz;
	}
	/**
	 * @Description dcblsfmbbnzwz的中文含义是： 是否明白不能做伪证
	 */
	public String getDcblsfmbbnzwz(){
		return dcblsfmbbnzwz;
	}
	/**
	 * @Description dcbldcjl的中文含义是： 调查记录
	 */
	public void setDcbldcjl(String dcbldcjl){ 
		this.dcbldcjl = dcbldcjl;
	}
	/**
	 * @Description dcbldcjl的中文含义是： 调查记录
	 */
	public String getDcbldcjl(){
		return dcbldcjl;
	}
	/**
	 * @Description dcblbdcrqz的中文含义是： 被调查人签字(被询问人签字)
	 */
	public void setDcblbdcrqz(String dcblbdcrqz){ 
		this.dcblbdcrqz = dcblbdcrqz;
	}
	/**
	 * @Description dcblbdcrqz的中文含义是： 被调查人签字(被询问人签字)
	 */
	public String getDcblbdcrqz(){
		return dcblbdcrqz;
	}
	/**
	 * @Description dcblbdcrqzrq的中文含义是： 被调查人签字日期(被询问人签字)
	 */
	public void setDcblbdcrqzrq(String dcblbdcrqzrq){ 
		this.dcblbdcrqzrq = dcblbdcrqzrq;
	}
	/**
	 * @Description dcblbdcrqzrq的中文含义是： 被调查人签字日期(被询问人签字)
	 */
	public String getDcblbdcrqzrq(){
		return dcblbdcrqzrq;
	}
	/**
	 * @Description dcbldcrqz1的中文含义是： 调查人签字1(执法人员签字)1
	 */
	public void setDcbldcrqz1(String dcbldcrqz1){ 
		this.dcbldcrqz1 = dcbldcrqz1;
	}
	/**
	 * @Description dcbldcrqz1的中文含义是： 调查人签字1(执法人员签字)1
	 */
	public String getDcbldcrqz1(){
		return dcbldcrqz1;
	}
	/**
	 * @Description dcbldcrqzrq的中文含义是： 调查人签字日期(执法人员签字日期)
	 */
	public void setDcbldcrqzrq(String dcbldcrqzrq){ 
		this.dcbldcrqzrq = dcbldcrqzrq;
	}
	/**
	 * @Description dcbldcrqzrq的中文含义是： 调查人签字日期(执法人员签字日期)
	 */
	public String getDcbldcrqzrq(){
		return dcbldcrqzrq;
	}
	/**
	 * @Description dcbljlrqz的中文含义是： 调查记录人签字
	 */
	public void setDcbljlrqz(String dcbljlrqz){ 
		this.dcbljlrqz = dcbljlrqz;
	}
	/**
	 * @Description dcbljlrqz的中文含义是： 调查记录人签字
	 */
	public String getDcbljlrqz(){
		return dcbljlrqz;
	}
	/**
	 * @Description dcbljlrqzrq的中文含义是： 调查记录人签字日期
	 */
	public void setDcbljlrqzrq(String dcbljlrqzrq){ 
		this.dcbljlrqzrq = dcbljlrqzrq;
	}
	/**
	 * @Description dcbljlrqzrq的中文含义是： 调查记录人签字日期
	 */
	public String getDcbljlrqzrq(){
		return dcbljlrqzrq;
	} 
	/**
	 * @Description dcblbdcryb的中文含义是： 被调查人邮编
	 */
	public void setDcblbdcryb(String dcblbdcryb){ 
		this.dcblbdcryb = dcblbdcryb;
	}
	/**
	 * @Description dcblbdcryb的中文含义是： 被调查人邮编
	 */
	public String getDcblbdcryb(){
		return dcblbdcryb;
	}

	
}