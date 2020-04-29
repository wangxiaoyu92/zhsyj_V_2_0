package com.askj.zfba.entity;

import jxl.write.DateTime;
import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSXCJCBL8的中文含义是: 现场检查笔录
 * @Creation     2016/09/19 15:44:35
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSXCJCBL8")
public class Zfwsxcjcbl8 {
	/**
	 * @Description xcjcblid的中文含义是： 现场检查笔录ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_xcjcblid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_xcjcblid.nextval from dual"))
	private String xcjcblid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记编号
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description xcjcjcr的中文含义是： 检查人
	 */
	@Column
	private String xcjcjcr;

	/**
	 * @Description cxjcjlr的中文含义是： 记录人
	 */
	@Column
	private String cxjcjlr;

	/**
	 * @Description spypjdgljmcqc的中文含义是： 食品药品监督管理局名称全称见aa01表aaa001=SPYPJDGLJMCQC
	 */
	@Column
	private String spypjdgljmcqc;

	/**
	 * @Description xcjczfry1的中文含义是： 执法人员1
	 */
	@Column
	private String xcjczfry1;

	/**
	 * @Description xcjczfry2的中文含义是： 执法人员2
	 */
	@Column
	private String xcjczfry2;

	/**
	 * @Description zfzjmc的中文含义是： 执法证件名称
	 */
	@Column
	private String zfzjmc;

	/**
	 * @Description xcjczfryzjbh1的中文含义是： 执法人员证件编号1
	 */
	@Column
	private String xcjczfryzjbh1;

	/**
	 * @Description xcjczfryzjbh2的中文含义是： 执法人员证件编号2
	 */
	@Column
	private String xcjczfryzjbh2;

	/**
	 * @Description cxjcptrzw的中文含义是： 陪同人职务
	 */
	@Column
	private String cxjcptrzw;

	/**
	 * @Description cxjcptrxm的中文含义是： 陪同人姓名
	 */
	@Column
	private String cxjcptrxm;

	/**
	 * @Description xcjcsfsqhb的中文含义是： 是否申请调查人员回避
	 */
	@Column
	private String xcjcsfsqhb;

	/**
	 * @Description xcjcsfsqhbqz的中文含义是： 是否申请调查人员回避签字
	 */
	@Column
	private String xcjcsfsqhbqz;

	/**
	 * @Description xcjcbl的中文含义是： 现场检查笔录
	 */
	@Column
	private String xcjcbl;

	/**
	 * @Description xcjcbjcr的中文含义是： 被检查人
	 */
	@Column
	private String xcjcbjcr;

	/**
	 * @Description xcjcbjcrzw的中文含义是： 被检查人职务
	 */
	@Column
	private String xcjcbjcrzw;

	/**
	 * @Description xcjcbjcrqzrq的中文含义是： 被检查人签字日期
	 */
	@Column
	private String xcjcbjcrqzrq;

	/**
	 * @Description xcjcjzr的中文含义是： 见证人
	 */
	@Column
	private String xcjcjzr;

	/**
	 * @Description xcjcjzrsfzh的中文含义是： 见证人身份证号
	 */
	@Column
	private String xcjcjzrsfzh;

	/**
	 * @Description xcjcjzrqzrq的中文含义是： 见证人签字日期
	 */
	@Column
	private String xcjcjzrqzrq;

	/**
	 * @Description xcjczfryqz1的中文含义是： 执法人员签字1
	 */
	@Column
	private String xcjczfryqz1;

	/**
	 * @Description xcjczfryqzrq的中文含义是： 执法人员签字日期
	 */
	@Column
	private String xcjczfryqzrq;

	/**
	 * @Description dcbljdjclb的中文含义是： 监督检查类别对应aa10中aaa100=DCBLJDJCLB
	 */
	@Column
	private String dcbljdjclb;

	/**
	 * @Description xcjcjcsjksrq的中文含义是： 检查开始时间
	 */
	@Column
	private String xcjcjcsjksrq;

	/**
	 * @Description xcjcjcsjjsrq的中文含义是： 检查结束时间
	 */
	@Column
	private String xcjcjcsjjsrq;

	/**
	 * @Description xcjcjcsy的中文含义是： 检查事由
	 */
	@Column
	private String xcjcjcsy;

	/**
	 * @Description xcjcbjcdwhr的中文含义是： 被检查单位(人)
	 */
	@Column
	private String xcjcbjcdwhr;

	/**
	 * @Description xcjcjcdd的中文含义是： 检查地点
	 */
	@Column
	private String xcjcjcdd;

	/**
	 * @Description xcjcfddbr的中文含义是： 法定代表人（负责人）
	 */
	@Column
	private String xcjcfddbr;

	/**
	 * @Description xcjcfddbrlxfs的中文含义是： 法定代表人联系方式
	 */
	@Column
	private String xcjcfddbrlxfs;

	/**
	 * @Description xcjczfryqz2的中文含义是： 执法人员签字2
	 */
	@Column
	private String xcjczfryqz2;

	/**
	 * @Description xcjcjlrqz的中文含义是： 记录人签字
	 */
	@Column
	private String xcjcjlrqz;

	/**
	 * @Description xcjcjlrqzrq的中文含义是： 记录人签字日期
	 */
	@Column
	private String xcjcjlrqzrq;

	/**
	 * @Description xcjczfry的中文含义是： 
	 */
	@Column
	private String xcjczfry;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description commc的中文含义是： 被检查单位(人)
	 */
	@Column
	private String commc;

	/**
	 * @Description comdz的中文含义是： 企业地址
	 */
	@Column
	private String comdz;

	/**
	 * @Description comfrhyz的中文含义是： 企业法人/业主
	 */
	@Column
	private String comfrhyz;

	/**
	 * @Description comyddh的中文含义是： 电话
	 */
	@Column
	private String comyddh;

	
		/**
	 * @Description xcjcblid的中文含义是： 现场检查笔录ID
	 */
	public void setXcjcblid(String xcjcblid){ 
		this.xcjcblid = xcjcblid;
	}
	/**
	 * @Description xcjcblid的中文含义是： 现场检查笔录ID
	 */
	public String getXcjcblid(){
		return xcjcblid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记编号
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 案件登记编号
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description xcjcjcr的中文含义是： 检查人
	 */
	public void setXcjcjcr(String xcjcjcr){ 
		this.xcjcjcr = xcjcjcr;
	}
	/**
	 * @Description xcjcjcr的中文含义是： 检查人
	 */
	public String getXcjcjcr(){
		return xcjcjcr;
	}
	/**
	 * @Description cxjcjlr的中文含义是： 记录人
	 */
	public void setCxjcjlr(String cxjcjlr){ 
		this.cxjcjlr = cxjcjlr;
	}
	/**
	 * @Description cxjcjlr的中文含义是： 记录人
	 */
	public String getCxjcjlr(){
		return cxjcjlr;
	}
	/**
	 * @Description spypjdgljmcqc的中文含义是： 食品药品监督管理局名称全称见aa01表aaa001=SPYPJDGLJMCQC
	 */
	public void setSpypjdgljmcqc(String spypjdgljmcqc){ 
		this.spypjdgljmcqc = spypjdgljmcqc;
	}
	/**
	 * @Description spypjdgljmcqc的中文含义是： 食品药品监督管理局名称全称见aa01表aaa001=SPYPJDGLJMCQC
	 */
	public String getSpypjdgljmcqc(){
		return spypjdgljmcqc;
	}
	/**
	 * @Description xcjczfry1的中文含义是： 执法人员1
	 */
	public void setXcjczfry1(String xcjczfry1){ 
		this.xcjczfry1 = xcjczfry1;
	}
	/**
	 * @Description xcjczfry1的中文含义是： 执法人员1
	 */
	public String getXcjczfry1(){
		return xcjczfry1;
	}
	/**
	 * @Description xcjczfry2的中文含义是： 执法人员2
	 */
	public void setXcjczfry2(String xcjczfry2){ 
		this.xcjczfry2 = xcjczfry2;
	}
	/**
	 * @Description xcjczfry2的中文含义是： 执法人员2
	 */
	public String getXcjczfry2(){
		return xcjczfry2;
	}
	/**
	 * @Description zfzjmc的中文含义是： 执法证件名称
	 */
	public void setZfzjmc(String zfzjmc){ 
		this.zfzjmc = zfzjmc;
	}
	/**
	 * @Description zfzjmc的中文含义是： 执法证件名称
	 */
	public String getZfzjmc(){
		return zfzjmc;
	}
	/**
	 * @Description xcjczfryzjbh1的中文含义是： 执法人员证件编号1
	 */
	public void setXcjczfryzjbh1(String xcjczfryzjbh1){ 
		this.xcjczfryzjbh1 = xcjczfryzjbh1;
	}
	/**
	 * @Description xcjczfryzjbh1的中文含义是： 执法人员证件编号1
	 */
	public String getXcjczfryzjbh1(){
		return xcjczfryzjbh1;
	}
	/**
	 * @Description xcjczfryzjbh2的中文含义是： 执法人员证件编号2
	 */
	public void setXcjczfryzjbh2(String xcjczfryzjbh2){ 
		this.xcjczfryzjbh2 = xcjczfryzjbh2;
	}
	/**
	 * @Description xcjczfryzjbh2的中文含义是： 执法人员证件编号2
	 */
	public String getXcjczfryzjbh2(){
		return xcjczfryzjbh2;
	}
	/**
	 * @Description cxjcptrzw的中文含义是： 陪同人职务
	 */
	public void setCxjcptrzw(String cxjcptrzw){ 
		this.cxjcptrzw = cxjcptrzw;
	}
	/**
	 * @Description cxjcptrzw的中文含义是： 陪同人职务
	 */
	public String getCxjcptrzw(){
		return cxjcptrzw;
	}
	/**
	 * @Description cxjcptrxm的中文含义是： 陪同人姓名
	 */
	public void setCxjcptrxm(String cxjcptrxm){ 
		this.cxjcptrxm = cxjcptrxm;
	}
	/**
	 * @Description cxjcptrxm的中文含义是： 陪同人姓名
	 */
	public String getCxjcptrxm(){
		return cxjcptrxm;
	}
	/**
	 * @Description xcjcsfsqhb的中文含义是： 是否申请调查人员回避
	 */
	public void setXcjcsfsqhb(String xcjcsfsqhb){ 
		this.xcjcsfsqhb = xcjcsfsqhb;
	}
	/**
	 * @Description xcjcsfsqhb的中文含义是： 是否申请调查人员回避
	 */
	public String getXcjcsfsqhb(){
		return xcjcsfsqhb;
	}
	/**
	 * @Description xcjcsfsqhbqz的中文含义是： 是否申请调查人员回避签字
	 */
	public void setXcjcsfsqhbqz(String xcjcsfsqhbqz){ 
		this.xcjcsfsqhbqz = xcjcsfsqhbqz;
	}
	/**
	 * @Description xcjcsfsqhbqz的中文含义是： 是否申请调查人员回避签字
	 */
	public String getXcjcsfsqhbqz(){
		return xcjcsfsqhbqz;
	}
	/**
	 * @Description xcjcbl的中文含义是： 现场检查笔录
	 */
	public void setXcjcbl(String xcjcbl){ 
		this.xcjcbl = xcjcbl;
	}
	/**
	 * @Description xcjcbl的中文含义是： 现场检查笔录
	 */
	public String getXcjcbl(){
		return xcjcbl;
	}
	/**
	 * @Description xcjcbjcr的中文含义是： 被检查人
	 */
	public void setXcjcbjcr(String xcjcbjcr){ 
		this.xcjcbjcr = xcjcbjcr;
	}
	/**
	 * @Description xcjcbjcr的中文含义是： 被检查人
	 */
	public String getXcjcbjcr(){
		return xcjcbjcr;
	}
	/**
	 * @Description xcjcbjcrzw的中文含义是： 被检查人职务
	 */
	public void setXcjcbjcrzw(String xcjcbjcrzw){ 
		this.xcjcbjcrzw = xcjcbjcrzw;
	}
	/**
	 * @Description xcjcbjcrzw的中文含义是： 被检查人职务
	 */
	public String getXcjcbjcrzw(){
		return xcjcbjcrzw;
	}
	/**
	 * @Description xcjcbjcrqzrq的中文含义是： 被检查人签字日期
	 */
	public void setXcjcbjcrqzrq(String xcjcbjcrqzrq){
		this.xcjcbjcrqzrq = xcjcbjcrqzrq;
	}
	/**
	 * @Description xcjcbjcrqzrq的中文含义是： 被检查人签字日期
	 */
	public String getXcjcbjcrqzrq(){
		return xcjcbjcrqzrq;
	}
	/**
	 * @Description xcjcjzr的中文含义是： 见证人
	 */
	public void setXcjcjzr(String xcjcjzr){ 
		this.xcjcjzr = xcjcjzr;
	}
	/**
	 * @Description xcjcjzr的中文含义是： 见证人
	 */
	public String getXcjcjzr(){
		return xcjcjzr;
	}
	/**
	 * @Description xcjcjzrsfzh的中文含义是： 见证人身份证号
	 */
	public void setXcjcjzrsfzh(String xcjcjzrsfzh){ 
		this.xcjcjzrsfzh = xcjcjzrsfzh;
	}
	/**
	 * @Description xcjcjzrsfzh的中文含义是： 见证人身份证号
	 */
	public String getXcjcjzrsfzh(){
		return xcjcjzrsfzh;
	}
	/**
	 * @Description xcjcjzrqzrq的中文含义是： 见证人签字日期
	 */
	public void setXcjcjzrqzrq(String xcjcjzrqzrq){
		this.xcjcjzrqzrq = xcjcjzrqzrq;
	}
	/**
	 * @Description xcjcjzrqzrq的中文含义是： 见证人签字日期
	 */
	public String getXcjcjzrqzrq(){
		return xcjcjzrqzrq;
	}
	/**
	 * @Description xcjczfryqz1的中文含义是： 执法人员签字1
	 */
	public void setXcjczfryqz1(String xcjczfryqz1){ 
		this.xcjczfryqz1 = xcjczfryqz1;
	}
	/**
	 * @Description xcjczfryqz1的中文含义是： 执法人员签字1
	 */
	public String getXcjczfryqz1(){
		return xcjczfryqz1;
	}
	/**
	 * @Description xcjczfryqzrq的中文含义是： 执法人员签字日期
	 */
	public void setXcjczfryqzrq(String xcjczfryqzrq){
		this.xcjczfryqzrq = xcjczfryqzrq;
	}
	/**
	 * @Description xcjczfryqzrq的中文含义是： 执法人员签字日期
	 */
	public String getXcjczfryqzrq(){
		return xcjczfryqzrq;
	}
	/**
	 * @Description dcbljdjclb的中文含义是： 监督检查类别对应aa10中aaa100=DCBLJDJCLB
	 */
	public void setDcbljdjclb(String dcbljdjclb){ 
		this.dcbljdjclb = dcbljdjclb;
	}
	/**
	 * @Description dcbljdjclb的中文含义是： 监督检查类别对应aa10中aaa100=DCBLJDJCLB
	 */
	public String getDcbljdjclb(){
		return dcbljdjclb;
	}
	/**
	 * @Description xcjcjcsjksrq的中文含义是： 检查开始时间
	 */
	public void setXcjcjcsjksrq(String xcjcjcsjksrq){
		this.xcjcjcsjksrq = xcjcjcsjksrq;
	}
	/**
	 * @Description xcjcjcsjksrq的中文含义是： 检查开始时间
	 */
	public String getXcjcjcsjksrq(){
		return xcjcjcsjksrq;
	}
	/**
	 * @Description xcjcjcsjjsrq的中文含义是： 检查结束时间
	 */
	public void setXcjcjcsjjsrq(String xcjcjcsjjsrq){
		this.xcjcjcsjjsrq = xcjcjcsjjsrq;
	}
	/**
	 * @Description xcjcjcsjjsrq的中文含义是： 检查结束时间
	 */
	public String getXcjcjcsjjsrq(){
		return xcjcjcsjjsrq;
	}
	/**
	 * @Description xcjcjcsy的中文含义是： 检查事由
	 */
	public void setXcjcjcsy(String xcjcjcsy){ 
		this.xcjcjcsy = xcjcjcsy;
	}
	/**
	 * @Description xcjcjcsy的中文含义是： 检查事由
	 */
	public String getXcjcjcsy(){
		return xcjcjcsy;
	}
	/**
	 * @Description xcjcbjcdwhr的中文含义是： 被检查单位(人)
	 */
	public void setXcjcbjcdwhr(String xcjcbjcdwhr){ 
		this.xcjcbjcdwhr = xcjcbjcdwhr;
	}
	/**
	 * @Description xcjcbjcdwhr的中文含义是： 被检查单位(人)
	 */
	public String getXcjcbjcdwhr(){
		return xcjcbjcdwhr;
	}
	/**
	 * @Description xcjcjcdd的中文含义是： 检查地点
	 */
	public void setXcjcjcdd(String xcjcjcdd){ 
		this.xcjcjcdd = xcjcjcdd;
	}
	/**
	 * @Description xcjcjcdd的中文含义是： 检查地点
	 */
	public String getXcjcjcdd(){
		return xcjcjcdd;
	}
	/**
	 * @Description xcjcfddbr的中文含义是： 法定代表人（负责人）
	 */
	public void setXcjcfddbr(String xcjcfddbr){ 
		this.xcjcfddbr = xcjcfddbr;
	}
	/**
	 * @Description xcjcfddbr的中文含义是： 法定代表人（负责人）
	 */
	public String getXcjcfddbr(){
		return xcjcfddbr;
	}
	/**
	 * @Description xcjcfddbrlxfs的中文含义是： 法定代表人联系方式
	 */
	public void setXcjcfddbrlxfs(String xcjcfddbrlxfs){ 
		this.xcjcfddbrlxfs = xcjcfddbrlxfs;
	}
	/**
	 * @Description xcjcfddbrlxfs的中文含义是： 法定代表人联系方式
	 */
	public String getXcjcfddbrlxfs(){
		return xcjcfddbrlxfs;
	}
	/**
	 * @Description xcjczfryqz2的中文含义是： 执法人员签字2
	 */
	public void setXcjczfryqz2(String xcjczfryqz2){ 
		this.xcjczfryqz2 = xcjczfryqz2;
	}
	/**
	 * @Description xcjczfryqz2的中文含义是： 执法人员签字2
	 */
	public String getXcjczfryqz2(){
		return xcjczfryqz2;
	}
	/**
	 * @Description xcjcjlrqz的中文含义是： 记录人签字
	 */
	public void setXcjcjlrqz(String xcjcjlrqz){ 
		this.xcjcjlrqz = xcjcjlrqz;
	}
	/**
	 * @Description xcjcjlrqz的中文含义是： 记录人签字
	 */
	public String getXcjcjlrqz(){
		return xcjcjlrqz;
	}
	/**
	 * @Description xcjcjlrqzrq的中文含义是： 记录人签字日期
	 */
	public void setXcjcjlrqzrq(String xcjcjlrqzrq){
		this.xcjcjlrqzrq = xcjcjlrqzrq;
	}
	/**
	 * @Description xcjcjlrqzrq的中文含义是： 记录人签字日期
	 */
	public String getXcjcjlrqzrq(){
		return xcjcjlrqzrq;
	}
	/**
	 * @Description xcjczfry的中文含义是： 
	 */
	public void setXcjczfry(String xcjczfry){ 
		this.xcjczfry = xcjczfry;
	}
	/**
	 * @Description xcjczfry的中文含义是： 
	 */
	public String getXcjczfry(){
		return xcjczfry;
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
	 * @Description commc的中文含义是： 被检查单位(人)
	 */
	public void setCommc(String commc){ 
		this.commc = commc;
	}
	/**
	 * @Description commc的中文含义是： 被检查单位(人)
	 */
	public String getCommc(){
		return commc;
	}
	/**
	 * @Description comdz的中文含义是： 企业地址
	 */
	public void setComdz(String comdz){ 
		this.comdz = comdz;
	}
	/**
	 * @Description comdz的中文含义是： 企业地址
	 */
	public String getComdz(){
		return comdz;
	}
	/**
	 * @Description comfrhyz的中文含义是： 企业法人/业主
	 */
	public void setComfrhyz(String comfrhyz){ 
		this.comfrhyz = comfrhyz;
	}
	/**
	 * @Description comfrhyz的中文含义是： 企业法人/业主
	 */
	public String getComfrhyz(){
		return comfrhyz;
	}
	/**
	 * @Description comyddh的中文含义是： 电话
	 */
	public void setComyddh(String comyddh){ 
		this.comyddh = comyddh;
	}
	/**
	 * @Description comyddh的中文含义是： 电话
	 */
	public String getComyddh(){
		return comyddh;
	}

	
}