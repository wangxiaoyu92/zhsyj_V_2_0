package com.askj.zfba.dto;

/**
 * @Description  ZFWSXCJCBL8的中文含义是: 现场检查笔录; InnoDB free: 75776 kBDTO
 * @Creation     2016/03/15 14:37:14
 * @Written      Create Tool By zjf 
 **/
public class Zfwsxcjcbl8DTO {
	//扩展开始
	/**
	 * 一个方法被多个地方调用，这个表示是那个地方用，以区别处理
	 */
	private String fjwid;
	private String applyqm;
	private String checkedqm;
	private String checkqm;
	private String witnessqm;
	private String recordqm;
	private String noticeqm;
	private String print;

	public String getPrint() {
		return print;
	}

	public void setPrint(String print) {
		this.print = print;
	}

	public String getNoticeqm() {
		return noticeqm;
	}

	public void setNoticeqm(String noticeqm) {
		this.noticeqm = noticeqm;
	}

	public String getApplyqm() {
		return applyqm;
	}

	public void setApplyqm(String applyqm) {
		this.applyqm = applyqm;
	}

	public String getCheckedqm() {
		return checkedqm;
	}

	public void setCheckedqm(String checkedqm) {
		this.checkedqm = checkedqm;
	}

	public String getCheckqm() {
		return checkqm;
	}

	public void setCheckqm(String checkqm) {
		this.checkqm = checkqm;
	}

	public String getWitnessqm() {
		return witnessqm;
	}

	public void setWitnessqm(String witnessqm) {
		this.witnessqm = witnessqm;
	}

	public String getRecordqm() {
		return recordqm;
	}

	public void setRecordqm(String recordqm) {
		this.recordqm = recordqm;
	}

	public String getFjwid() {
		return fjwid;
	}

	public void setFjwid(String fjwid) {
		this.fjwid = fjwid;
	}

	private String operatetype;
	/**
	 * comid
	 */
	private String comid;

	//扩展结束
	/**
	 * 案件执法文书表主键
	 */
	private String ajzfwsid;

	/**
	 * 手机或是电脑1电脑2手机
	 */
	private String sjordn;		
	/**
	 * 
	 */
	private String userid;	
	
	/**
	 * 监督检查类别
	 */
	private String dcbljdjclbstr;
	/**
	 * @Description xcjcblid的中文含义是： 现场检查笔录ID
	 */
	private String xcjcblid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记编号
	 */
	private String ajdjid;

	/**
	 * @Description xcjcjcr的中文含义是： 检查人
	 */
	private String xcjcjcr;

	/**
	 * @Description cxjcjlr的中文含义是： 记录人
	 */
	private String cxjcjlr;

	/**
	 * @Description spypjdgljmcqc的中文含义是： 食品药品监督管理局名称全称见aa01表aaa001=SPYPJDGLJMCQC
	 */
	private String spypjdgljmcqc;

	/**
	 * @Description xcjczfry1的中文含义是： 执法人员1
	 */
	private String xcjczfry1;

	/**
	 * @Description xcjczfry2的中文含义是： 执法人员2
	 */
	private String xcjczfry2;

	/**
	 * @Description zfzjmc的中文含义是： 执法证件名称
	 */
	private String zfzjmc;

	/**
	 * @Description xcjczfryzjbh1的中文含义是： 执法人员证件编号1
	 */
	private String xcjczfryzjbh1;

	/**
	 * @Description xcjczfryzjbh2的中文含义是： 执法人员证件编号2
	 */
	private String xcjczfryzjbh2;

	/**
	 * @Description cxjcptrzw的中文含义是： 陪同人职务
	 */
	private String cxjcptrzw;

	/**
	 * @Description cxjcptrxm的中文含义是： 陪同人姓名
	 */
	private String cxjcptrxm;

	/**
	 * @Description xcjcsfsqhb的中文含义是： 是否申请调查人员回避
	 */
	private String xcjcsfsqhb;

	/**
	 * @Description xcjcsfsqhbqz的中文含义是： 是否申请调查人员回避签字
	 */
	private String xcjcsfsqhbqz;

	/**
	 * @Description xcjcbl的中文含义是： 现场检查笔录
	 */
	private String xcjcbl;

	/**
	 * @Description xcjcbjcr的中文含义是： 被检查人
	 */
	private String xcjcbjcr;

	/**
	 * @Description xcjcbjcrzw的中文含义是： 被检查人职务
	 */
	private String xcjcbjcrzw;

	/**
	 * @Description xcjcbjcrqzrq的中文含义是： 被检查人签字日期
	 */
	private String xcjcbjcrqzrq;

	/**
	 * @Description xcjcjzr的中文含义是： 见证人
	 */
	private String xcjcjzr;

	/**
	 * @Description xcjcjzrsfzh的中文含义是： 见证人身份证号
	 */
	private String xcjcjzrsfzh;

	/**
	 * @Description xcjcjzrqzrq的中文含义是： 见证人签字日期
	 */
	private String xcjcjzrqzrq;

	/**
	 * @Description xcjczfry的中文含义是： 执法人员
	 */
	private String xcjczfry;

	/**
	 * @Description xcjczfryqzrq的中文含义是： 执法人员签字日期
	 */
	private String xcjczfryqzrq;

	/**
	 * @Description dcbljdjclb的中文含义是： 监督检查类别对应aa10中aaa100=DCBLJDJCLB
	 */
	private String dcbljdjclb;

	/**
	 * @Description xcjcjcsjksrq的中文含义是： 检查开始时间
	 */
	private String xcjcjcsjksrq;

	/**
	 * @Description xcjcjcsjjsrq的中文含义是： 检查结束时间
	 */
	private String xcjcjcsjjsrq;

	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	private String zfwsdmz;
	
	/**
	 * @Description zfwsqtbid的中文含义是：执法文书所在表ID
	 */
	private String zfwsqtbid;
	
	/**
	 * @Description ajdjay的中文含义是：案由，对应案件登记表，手动添加
	 */
	private String ajdjay;
	
	/**
	 * @Description commc的中文含义是：被检查单位(人)，对应案件登记表企业名称，手动添加
	 */
	private String commc;
	
	/**
	 * @Description comdz的中文含义是：企业地址，对应案件登记表企业地址，手动添加
	 */
	private String comdz;
	
	/**
	 * @Description comfrhyz的中文含义是：企业法人/业主，对应案件登记表企业法人/业主，手动添加
	 */
	private String comfrhyz;
	
	/**
	 * @Description comyddh的中文含义是：电话，对应案件登记表联系方式，手动添加
	 */
	private String comyddh;
	
	/**
	 * @Description xcjcjlrqz的中文含义是： 记录人签字
	 */ 
	private String xcjcjlrqz;
	/**
	 * @Description xcjcjlrqzrq的中文含义是： 记录人签字日期
	 */ 
	private String xcjcjlrqzrq;

	
	public String getXcjcjlrqz() {
		return xcjcjlrqz;
	}
	public void setXcjcjlrqz(String xcjcjlrqz) {
		this.xcjcjlrqz = xcjcjlrqz;
	}
	public String getXcjcjlrqzrq() {
		return xcjcjlrqzrq;
	}
	public void setXcjcjlrqzrq(String xcjcjlrqzrq) {
		this.xcjcjlrqzrq = xcjcjlrqzrq;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public String getZfwsdmz() {
		return zfwsdmz;
	}
	/**
	 * @Description zfwsdmz的中文含义是： 执法文书代码值
	 */
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	public String getZfwsqtbid() {
		return zfwsqtbid;
	}
	/**
	 * @Description zfwsqtbid的中文含义是：执法文书所在表ID
	 */
	public void setZfwsqtbid(String zfwsqtbid) {
		this.zfwsqtbid = zfwsqtbid;
	}
	public String getAjdjay() {
		return ajdjay;
	}
	public void setAjdjay(String ajdjay) {
		this.ajdjay = ajdjay;
	}
	public String getCommc() {
		return commc;
	}
	public void setCommc(String commc) {
		this.commc = commc;
	}
	public String getComdz() {
		return comdz;
	}
	public void setComdz(String comdz) {
		this.comdz = comdz;
	}
	public String getComfrhyz() {
		return comfrhyz;
	}
	public void setComfrhyz(String comfrhyz) {
		this.comfrhyz = comfrhyz;
	}
	public String getComyddh() {
		return comyddh;
	}
	public void setComyddh(String comyddh) {
		this.comyddh = comyddh;
	}
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
	 * @Description xcjczfry的中文含义是： 执法人员
	 */
	public void setXcjczfry(String xcjczfry){ 
		this.xcjczfry = xcjczfry;
	}
	/**
	 * @Description xcjczfry的中文含义是： 执法人员
	 */
	public String getXcjczfry(){
		return xcjczfry;
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
	public String getDcbljdjclbstr() {
		return dcbljdjclbstr;
	}
	public void setDcbljdjclbstr(String dcbljdjclbstr) {
		this.dcbljdjclbstr = dcbljdjclbstr;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSjordn() {
		return sjordn;
	}
	public void setSjordn(String sjordn) {
		this.sjordn = sjordn;
	}

	public String getAjzfwsid() {
		return ajzfwsid;
	}

	public void setAjzfwsid(String ajzfwsid) {
		this.ajzfwsid = ajzfwsid;
	}

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}

	public String getComid() {
		return comid;
	}

	public void setComid(String comid) {
		this.comid = comid;
	}
}