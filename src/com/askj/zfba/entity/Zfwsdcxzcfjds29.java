package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;

/**
 * @Description  ZFWSDCXZCFJDS29的中文含义是: 当场行政处罚决定书; InnoDB free: 2726912 kB
 * @Creation     2016/06/13 09:36:07
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSDCXZCFJDS29")
public class Zfwsdcxzcfjds29 {
	/**
	 * @Description dcxzcfjdsid的中文含义是： 当场行政处罚决定书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_dcxzcfjdsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_dcxzcfjdsid.nextval from dual"))
	private String dcxzcfjdsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description dccfwsbh的中文含义是： 文书编号
	 */
	@Column
	private String dccfwsbh;

	/**
	 * @Description dccfwfxw的中文含义是： 违法行为
	 */
	@Column
	private String dccfwfxw;

	/**
	 * @Description dccfwfgd的中文含义是： 违反的法律法规规定
	 */
	@Column
	private String dccfwfgd;

	/**
	 * @Description dccfyjgd的中文含义是： 依据规定
	 */
	@Column
	private String dccfyjgd;

	/**
	 * @Description dccfxzcf1的中文含义是： 行政处罚
	 */
	@Column
	private String dccfxzcf1;

	/**
	 * @Description fmkjkyh的中文含义是： 缴款银行aaa100=FMKJKYH
	 */
	@Column
	private String fmkjkyh;

	/**
	 * @Description dccfdd的中文含义是： 处罚地点
	 */
	@Column
	private String dccfdd;

	/**
	 * @Description dccfdsrqz的中文含义是： 当事人签字
	 */
	@Column
	private String dccfdsrqz;

	/**
	 * @Description dccfdsrqzrq的中文含义是： 当事人签字日期
	 */
	@Column
	private String dccfdsrqzrq;

	/**
	 * @Description dccfzfryqz的中文含义是： 执法人员签字
	 */
	@Column
	private String dccfzfryqz;

	/**
	 * @Description dccfgzrq的中文含义是： 盖章日期
	 */
	@Column
	private String dccfgzrq;

	/**
	 * @Description dccfdsr的中文含义是： 当事人
	 */
	@Column
	private String dccfdsr;

	/**
	 * @Description dccfyyzz的中文含义是： 营业执照或其他资质证明
	 */
	@Column
	private String dccfyyzz;

	/**
	 * @Description dccfzzjgdm的中文含义是： 组织结构代码（身份证）号
	 */
	@Column
	private String dccfzzjgdm;

	/**
	 * @Description dccffddbr的中文含义是： 法定代表人（负责人）
	 */
	@Column
	private String dccffddbr;

	/**
	 * @Description dccffddbrxb的中文含义是： 法定代表人（负责人）性别
	 */
	@Column
	private String dccffddbrxb;

	/**
	 * @Description dccffddbrzw的中文含义是： 法定代表人（负责人）职务
	 */
	@Column
	private String dccffddbrzw;

	/**
	 * @Description dccfdz的中文含义是： 地址
	 */
	@Column
	private String dccfdz;

	/**
	 * @Description dccfyb的中文含义是： 邮编
	 */
	@Column
	private String dccfyb;

	/**
	 * @Description dccfdh的中文含义是： 电话
	 */
	@Column
	private String dccfdh;

	/**
	 * @Description sjspypjdglj的中文含义是： 上级食品药品监督管理局aa01,aaa001=SJSPYPJDGLJ
	 */
	@Column
	private String sjspypjdglj;

	/**
	 * @Description sjrmzf的中文含义是： 上级人民政府aa01,aaa001=SJRMZF
	 */
	@Column
	private String sjrmzf;

	/**
	 * @Description sjrmfy的中文含义是： 上级人民法院aa01,aaa001=SJRMFY
	 */
	@Column
	private String sjrmfy;

	/**
	 * @Description qzzzrmfy的中文含义是：强制执行人民法院aa01,aaa001=QZZZRMFY
	 */
	@Column
	private String qzzzrmfy;
	
	/**
	 * @Description dccfzfryqz2的中文含义是： 执法人员签字2
	 */
	@Column
	private String dccfzfryqz2;

	/**
	 * @Description dccfyyzzbh的中文含义是：营业执照或其他资质证明编号
	 */
	@Column
	private String dccfyyzzbh;

	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	@Column
	private String xzjgmc;
	/**
	 * @Description gmsfhm的中文含义是： 公民身份号码
	 */
	@Column
	private String gmsfhm;
	/**
	 * @Description fkrmbdxqian的中文含义是： 罚款人民币大写千
	 */
	@Column
	private String fkrmbdxqian;
	/**
	 * @Description fkrmbdxbai的中文含义是：罚款人民币大写百
	 */
	@Column
	private String fkrmbdxbai;
	/**
	 * @Description fkrmbdxshi的中文含义是： 罚款人民币大写拾
	 */
	@Column
	private String fkrmbdxshi;
	/**
	 * @Description fkrmbdxyuan的中文含义是： 罚款人民币大写元
	 */
	@Column
	private String fkrmbdxyuan;
	/**
	 * @Description fkrmbxx的中文含义是： 罚款人民币小写
	 */
	@Column
	private String fkrmbxx;
	/**
	 * @Description yhzh的中文含义是： 银行账号
	 */
	@Column
	private String yhzh;
	/**
	 * @Description yhhm的中文含义是： 银行户名
	 */
	@Column
	private String yhhm;
	
	/**
	 * @Description dcxzcfjdsid的中文含义是： 当场行政处罚决定书ID
	 */
	public void setDcxzcfjdsid(String dcxzcfjdsid){ 
		this.dcxzcfjdsid = dcxzcfjdsid;
	}
	/**
	 * @Description dcxzcfjdsid的中文含义是： 当场行政处罚决定书ID
	 */
	public String getDcxzcfjdsid(){
		return dcxzcfjdsid;
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
	 * @Description dccfwsbh的中文含义是： 文书编号
	 */
	public void setDccfwsbh(String dccfwsbh){ 
		this.dccfwsbh = dccfwsbh;
	}
	/**
	 * @Description dccfwsbh的中文含义是： 文书编号
	 */
	public String getDccfwsbh(){
		return dccfwsbh;
	}
	/**
	 * @Description dccfwfxw的中文含义是： 违法行为
	 */
	public void setDccfwfxw(String dccfwfxw){ 
		this.dccfwfxw = dccfwfxw;
	}
	/**
	 * @Description dccfwfxw的中文含义是： 违法行为
	 */
	public String getDccfwfxw(){
		return dccfwfxw;
	}
	/**
	 * @Description dccfwfgd的中文含义是： 违反的法律法规规定
	 */
	public void setDccfwfgd(String dccfwfgd){ 
		this.dccfwfgd = dccfwfgd;
	}
	/**
	 * @Description dccfwfgd的中文含义是： 违反的法律法规规定
	 */
	public String getDccfwfgd(){
		return dccfwfgd;
	}
	/**
	 * @Description dccfyjgd的中文含义是： 依据规定
	 */
	public void setDccfyjgd(String dccfyjgd){ 
		this.dccfyjgd = dccfyjgd;
	}
	/**
	 * @Description dccfyjgd的中文含义是： 依据规定
	 */
	public String getDccfyjgd(){
		return dccfyjgd;
	}
	/**
	 * @Description dccfxzcf1的中文含义是： 行政处罚
	 */
	public void setDccfxzcf1(String dccfxzcf1){ 
		this.dccfxzcf1 = dccfxzcf1;
	}
	/**
	 * @Description dccfxzcf1的中文含义是： 行政处罚
	 */
	public String getDccfxzcf1(){
		return dccfxzcf1;
	}
	/**
	 * @Description fmkjkyh的中文含义是： 缴款银行aaa100=FMKJKYH
	 */
	public void setFmkjkyh(String fmkjkyh){ 
		this.fmkjkyh = fmkjkyh;
	}
	/**
	 * @Description fmkjkyh的中文含义是： 缴款银行aaa100=FMKJKYH
	 */
	public String getFmkjkyh(){
		return fmkjkyh;
	}
	/**
	 * @Description dccfdd的中文含义是： 处罚地点
	 */
	public void setDccfdd(String dccfdd){ 
		this.dccfdd = dccfdd;
	}
	/**
	 * @Description dccfdd的中文含义是： 处罚地点
	 */
	public String getDccfdd(){
		return dccfdd;
	}
	/**
	 * @Description dccfdsrqz的中文含义是： 当事人签字
	 */
	public void setDccfdsrqz(String dccfdsrqz){ 
		this.dccfdsrqz = dccfdsrqz;
	}
	/**
	 * @Description dccfdsrqz的中文含义是： 当事人签字
	 */
	public String getDccfdsrqz(){
		return dccfdsrqz;
	}
	/**
	 * @Description dccfdsrqzrq的中文含义是： 当事人签字日期
	 */
	public void setDccfdsrqzrq(String dccfdsrqzrq){ 
		this.dccfdsrqzrq = dccfdsrqzrq;
	}
	/**
	 * @Description dccfdsrqzrq的中文含义是： 当事人签字日期
	 */
	public String getDccfdsrqzrq(){
		return dccfdsrqzrq;
	}
	/**
	 * @Description dccfzfry的中文含义是： 执法人员签字
	 */
	public void setDccfzfryqz(String dccfzfryqz){ 
		this.dccfzfryqz = dccfzfryqz;
	}
	/**
	 * @Description dccfzfry的中文含义是： 执法人员签字
	 */
	public String getDccfzfryqz(){
		return dccfzfryqz;
	}
	/**
	 * @Description dccfgzrq的中文含义是： 盖章日期
	 */
	public void setDccfgzrq(String dccfgzrq){ 
		this.dccfgzrq = dccfgzrq;
	}
	/**
	 * @Description dccfgzrq的中文含义是： 盖章日期
	 */
	public String getDccfgzrq(){
		return dccfgzrq;
	}
	/**
	 * @Description dccfdsr的中文含义是： 当事人
	 */
	public void setDccfdsr(String dccfdsr){ 
		this.dccfdsr = dccfdsr;
	}
	/**
	 * @Description dccfdsr的中文含义是： 当事人
	 */
	public String getDccfdsr(){
		return dccfdsr;
	}
	/**
	 * @Description dccfyyzz的中文含义是： 营业执照或其他资质证明
	 */
	public void setDccfyyzz(String dccfyyzz){ 
		this.dccfyyzz = dccfyyzz;
	}
	/**
	 * @Description dccfyyzz的中文含义是： 营业执照或其他资质证明
	 */
	public String getDccfyyzz(){
		return dccfyyzz;
	}
	/**
	 * @Description dccfzzjgdm的中文含义是： 组织结构代码（身份证）号
	 */
	public void setDccfzzjgdm(String dccfzzjgdm){ 
		this.dccfzzjgdm = dccfzzjgdm;
	}
	/**
	 * @Description dccfzzjgdm的中文含义是： 组织结构代码（身份证）号
	 */
	public String getDccfzzjgdm(){
		return dccfzzjgdm;
	}
	/**
	 * @Description dccffddbr的中文含义是： 法定代表人（负责人）
	 */
	public void setDccffddbr(String dccffddbr){ 
		this.dccffddbr = dccffddbr;
	}
	/**
	 * @Description dccffddbr的中文含义是： 法定代表人（负责人）
	 */
	public String getDccffddbr(){
		return dccffddbr;
	}
	/**
	 * @Description dccffddbrxb的中文含义是： 法定代表人（负责人）性别
	 */
	public void setDccffddbrxb(String dccffddbrxb){ 
		this.dccffddbrxb = dccffddbrxb;
	}
	/**
	 * @Description dccffddbrxb的中文含义是： 法定代表人（负责人）性别
	 */
	public String getDccffddbrxb(){
		return dccffddbrxb;
	}
	/**
	 * @Description dccffddbrzw的中文含义是： 法定代表人（负责人）职务
	 */
	public void setDccffddbrzw(String dccffddbrzw){ 
		this.dccffddbrzw = dccffddbrzw;
	}
	/**
	 * @Description dccffddbrzw的中文含义是： 法定代表人（负责人）职务
	 */
	public String getDccffddbrzw(){
		return dccffddbrzw;
	}
	/**
	 * @Description dccfdz的中文含义是： 地址
	 */
	public void setDccfdz(String dccfdz){ 
		this.dccfdz = dccfdz;
	}
	/**
	 * @Description dccfdz的中文含义是： 地址
	 */
	public String getDccfdz(){
		return dccfdz;
	}
	/**
	 * @Description dccfyb的中文含义是： 邮编
	 */
	public void setDccfyb(String dccfyb){ 
		this.dccfyb = dccfyb;
	}
	/**
	 * @Description dccfyb的中文含义是： 邮编
	 */
	public String getDccfyb(){
		return dccfyb;
	}
	/**
	 * @Description dccfdh的中文含义是： 电话
	 */
	public void setDccfdh(String dccfdh){ 
		this.dccfdh = dccfdh;
	}
	/**
	 * @Description dccfdh的中文含义是： 电话
	 */
	public String getDccfdh(){
		return dccfdh;
	}
	/**
	 * @Description sjspypjdglj的中文含义是： 上级食品药品监督管理局aaa100=SJSPYPJDGLJ
	 */
	public void setSjspypjdglj(String sjspypjdglj){ 
		this.sjspypjdglj = sjspypjdglj;
	}
	/**
	 * @Description sjspypjdglj的中文含义是： 上级食品药品监督管理局aaa100=SJSPYPJDGLJ
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
	 * @Description qzzzrmfy的中文含义是： 强制执行人民法院aaa100=QZZZRMFY
	 */
	public void setQzzzrmfy(String qzzzrmfy){ 
		this.qzzzrmfy = qzzzrmfy;
	}
	/**
	 * @Description qzzzrmfy的中文含义是： 强制执行人民法院aaa100=QZZZRMFY
	 */
	public String getQzzzrmfy(){
		return qzzzrmfy;
	}
	/**
	 * @Description dccfzfryqz2的中文含义是： 执法人员签字2
	 */
	public String getDccfzfryqz2() {
		return dccfzfryqz2;
	}
	/**
	 * @Description dccfzfryqz2的中文含义是： 执法人员签字2
	 */
	public void setDccfzfryqz2(String dccfzfryqz2) {
		this.dccfzfryqz2 = dccfzfryqz2;
	}
	/**
	 * @Description dccfyyzzbh的中文含义是：营业执照或其他资质证明编号
	 */
	public String getDccfyyzzbh() {
		return dccfyyzzbh;
	}
	/**
	 * @Description dccfyyzzbh的中文含义是：营业执照或其他资质证明编号
	 */
	public void setDccfyyzzbh(String dccfyyzzbh) {
		this.dccfyyzzbh = dccfyyzzbh;
	}
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public String getXzjgmc() {
		return xzjgmc;
	}
	/**
	 * @Description xzjgmc的中文含义是： 行政机关名称
	 */
	public void setXzjgmc(String xzjgmc) {
		this.xzjgmc = xzjgmc;
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
	 * @Description fkrmbdxqian的中文含义是： 罚款人民币大写千
	 */
	public String getFkrmbdxqian() {
		return fkrmbdxqian;
	}
	/**
	 * @Description fkrmbdxqian的中文含义是： 罚款人民币大写千
	 */
	public void setFkrmbdxqian(String fkrmbdxqian) {
		this.fkrmbdxqian = fkrmbdxqian;
	}
	/**
	 * @Description fkrmbdxbai的中文含义是：罚款人民币大写百
	 */
	public String getFkrmbdxbai() {
		return fkrmbdxbai;
	}
	/**
	 * @Description fkrmbdxbai的中文含义是：罚款人民币大写百
	 */
	public void setFkrmbdxbai(String fkrmbdxbai) {
		this.fkrmbdxbai = fkrmbdxbai;
	}
	/**
	 * @Description fkrmbdxshi的中文含义是： 罚款人民币大写拾
	 */
	public String getFkrmbdxshi() {
		return fkrmbdxshi;
	}
	/**
	 * @Description fkrmbdxshi的中文含义是： 罚款人民币大写拾
	 */
	public void setFkrmbdxshi(String fkrmbdxshi) {
		this.fkrmbdxshi = fkrmbdxshi;
	}
	/**
	 * @Description fkrmbdxyuan的中文含义是： 罚款人民币大写元
	 */
	public String getFkrmbdxyuan() {
		return fkrmbdxyuan;
	}
	/**
	 * @Description fkrmbdxyuan的中文含义是： 罚款人民币大写元
	 */
	public void setFkrmbdxyuan(String fkrmbdxyuan) {
		this.fkrmbdxyuan = fkrmbdxyuan;
	}
	/**
	 * @Description fkrmbxx的中文含义是： 罚款人民币小写
	 */
	public String getFkrmbxx() {
		return fkrmbxx;
	}
	/**
	 * @Description fkrmbxx的中文含义是： 罚款人民币小写
	 */
	public void setFkrmbxx(String fkrmbxx) {
		this.fkrmbxx = fkrmbxx;
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
	/**
	 * @Description yhhm的中文含义是： 银行户名
	 */
	public String getYhhm() {
		return yhhm;
	}
	/**
	 * @Description yhhm的中文含义是： 银行户名
	 */
	public void setYhhm(String yhhm) {
		this.yhhm = yhhm;
	}

	
}