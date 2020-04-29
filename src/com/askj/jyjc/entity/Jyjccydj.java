package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  JYJCCYDJ的中文含义是: 检验检测抽样登记表
 * @Creation     2017/01/10 09:43:48
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JYJCCYDJ")
public class Jyjccydj {

	/******************************************* 扩展字段 strat **************************************/

	/**
	 * @Description jyjccjrwbid 的中文含义是： 检验检测抽检任务表id
	 */
	@Column
	private String jyjccjrwbid;
	/**
	 * @Description cydjrwly 的中文含义是： 任务来源
	 */
	@Column
	private String cydjrwly;
	/**
	 * @Description cydjrwlb 的中文含义是： 任务类别
	 */
	@Column
	private String cydjrwlb;
	/**
	 * @Description cydjqylx 的中文含义是： 区域类型
	 */
	@Column
	private String cydjqylx;
	/**
	 * @Description comfrhyz 的中文含义是： 法定代表人
	 */
	@Column
	private String comfrhyz;
	/**
	 * @Description nsxe 的中文含义是： 年销售额
	 */
	@Column
	private String nsxe;
	/**
	 * @Description yyzhh 的中文含义是： 营业执照号
	 */
	@Column
	private String yyzhh;
	/**
	 * @Description xlr 的中文含义是： 联系人
	 */
	@Column
	private String xlr;
	/**
	 * @Description comcz 的中文含义是： 传真
	 */
	@Column
	private String comcz;
	/**
	 * @Description comyzbm 的中文含义是： 邮编
	 */
	@Column
	private String comyzbm;
	/**
	 * @Description comsfyy 的中文含义是： 企业是否有异议
	 */
	@Column
	private String comsfyy;
	/**
	 * @Description qiyezylx 的中文含义是： 企业质疑类型
	 */
	@Column
	private String qiyezylx;
	/**
	 * @Description comyydesc 的中文含义是： 企业异议描述
	 */
	@Column
	private String comyydesc;
	/**
	 * @Description comyycljg 的中文含义是： 企业异议处理结果
	 */
	@Column
	private String comyycljg;
	/**
	 * @Description sfxyfj 的中文含义是： 是否需要复检
	 */
	@Column
	private String sfxyfj;
	/**
	 * @Description fjcomid 的中文含义是： 复检机构id
	 */
	@Column
	private String fjcomid;
	/**
	 * @Description fjcommc 的中文含义是： 复检机构名称
	 */
	@Column
	private String fjcommc;
	/**
	 * @Description cjresult 的中文含义是： 复检结果
	 */
	@Column
	private String cjresult;

	public String getJyjccjrwbid() {
		return jyjccjrwbid;
	}

	public void setJyjccjrwbid(String jyjccjrwbid) {
		this.jyjccjrwbid = jyjccjrwbid;
	}

	public String getCydjrwly() {
		return cydjrwly;
	}

	public void setCydjrwly(String cydjrwly) {
		this.cydjrwly = cydjrwly;
	}

	public String getCydjrwlb() {
		return cydjrwlb;
	}

	public void setCydjrwlb(String cydjrwlb) {
		this.cydjrwlb = cydjrwlb;
	}

	public String getCydjqylx() {
		return cydjqylx;
	}

	public void setCydjqylx(String cydjqylx) {
		this.cydjqylx = cydjqylx;
	}

	public String getComfrhyz() {
		return comfrhyz;
	}

	public void setComfrhyz(String comfrhyz) {
		this.comfrhyz = comfrhyz;
	}

	public String getNsxe() {
		return nsxe;
	}

	public void setNsxe(String nsxe) {
		this.nsxe = nsxe;
	}

	public String getYyzhh() {
		return yyzhh;
	}

	public void setYyzhh(String yyzhh) {
		this.yyzhh = yyzhh;
	}

	public String getXlr() {
		return xlr;
	}

	public void setXlr(String xlr) {
		this.xlr = xlr;
	}

	public String getComcz() {
		return comcz;
	}

	public void setComcz(String comcz) {
		this.comcz = comcz;
	}

	public String getComyzbm() {
		return comyzbm;
	}

	public void setComyzbm(String comyzbm) {
		this.comyzbm = comyzbm;
	}

	public String getComsfyy() {
		return comsfyy;
	}

	public void setComsfyy(String comsfyy) {
		this.comsfyy = comsfyy;
	}

	public String getQiyezylx() {
		return qiyezylx;
	}

	public void setQiyezylx(String qiyezylx) {
		this.qiyezylx = qiyezylx;
	}

	public String getComyydesc() {
		return comyydesc;
	}

	public void setComyydesc(String comyydesc) {
		this.comyydesc = comyydesc;
	}

	public String getComyycljg() {
		return comyycljg;
	}

	public void setComyycljg(String comyycljg) {
		this.comyycljg = comyycljg;
	}

	public String getSfxyfj() {
		return sfxyfj;
	}

	public void setSfxyfj(String sfxyfj) {
		this.sfxyfj = sfxyfj;
	}

	public String getFjcomid() {
		return fjcomid;
	}

	public void setFjcomid(String fjcomid) {
		this.fjcomid = fjcomid;
	}

	public String getFjcommc() {
		return fjcommc;
	}

	public void setFjcommc(String fjcommc) {
		this.fjcommc = fjcommc;
	}

	public String getCjresult() {
		return cjresult;
	}

	public void setCjresult(String cjresult) {
		this.cjresult = cjresult;
	}

	/**************************************** 扩展字段 end******************************************/


	/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cydjid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_cydjid.nextval from dual"))
	private String cydjid;

	/**
	 * @Description jcypid的中文含义是： 检测样品ID
	 */
	@Column
	private String jcypid;

	/**
	 * @Description cybh的中文含义是： 抽样编号
	 */
	@Column
	private String cybh;

	/**
	 * @Description cyfl的中文含义是： 抽样分类
	 */
	@Column
	private String cyfl;

	/**
	 * @Description bcydwcomid的中文含义是： 被抽样单位ID
	 */
	@Column
	private String bcydwcomid;

	/**
	 * @Description bcydw的中文含义是： 被抽样单位
	 */
	@Column
	private String bcydw;

	/**
	 * @Description bcydwfl的中文含义是： 被抽样单位分类
	 */
	@Column
	private String bcydwfl;

	/**
	 * @Description bcydwdz的中文含义是： 被抽样单位地址
	 */
	@Column
	private String bcydwdz;

	/**
	 * @Description tel的中文含义是： 被抽样单位联系电话
	 */
	@Column
	private String tel;

	/**
	 * @Description ypmc的中文含义是： 样品名称
	 */
	@Column
	private String ypmc;

	/**
	 * @Description ypbh的中文含义是： 样品批号或生产日期
	 */
	@Column
	private String ypbh;

	/**
	 * @Description countcy的中文含义是： 抽样数量
	 */
	@Column
	private String countcy;

	/**
	 * @Description ypgg的中文含义是： 样品规格
	 */
	@Column
	private String ypgg;

	/**
	 * @Description scdwcomid的中文含义是： 生产单位ID
	 */
	@Column
	private String scdwcomid;

	/**
	 * @Description scdw的中文含义是： 生产单位
	 */
	@Column
	private String scdw;

	/**
	 * @Description cyjsr的中文含义是： 抽样经手人
	 */
	@Column
	private String cyjsr;

	/**
	 * @Description cysj的中文含义是： 抽样时间
	 */
	@Column
	private String cysj;

	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	@Column
	private String aae011;

	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	@Column
	private String aae036;

	
		/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	public void setCydjid(String cydjid){ 
		this.cydjid = cydjid;
	}
	/**
	 * @Description cydjid的中文含义是： 抽样登记ID
	 */
	public String getCydjid(){
		return cydjid;
	}
	/**
	 * @Description jcypid的中文含义是： 检测样品ID
	 */
	public void setJcypid(String jcypid){ 
		this.jcypid = jcypid;
	}
	/**
	 * @Description jcypid的中文含义是： 检测样品ID
	 */
	public String getJcypid(){
		return jcypid;
	}
	/**
	 * @Description cybh的中文含义是： 抽样编号
	 */
	public void setCybh(String cybh){ 
		this.cybh = cybh;
	}
	/**
	 * @Description cybh的中文含义是： 抽样编号
	 */
	public String getCybh(){
		return cybh;
	}
	/**
	 * @Description cyfl的中文含义是： 抽样分类
	 */
	public void setCyfl(String cyfl){ 
		this.cyfl = cyfl;
	}
	/**
	 * @Description cyfl的中文含义是： 抽样分类
	 */
	public String getCyfl(){
		return cyfl;
	}
	/**
	 * @Description bcydwcomid的中文含义是： 被抽样单位ID
	 */
	public void setBcydwcomid(String bcydwcomid){ 
		this.bcydwcomid = bcydwcomid;
	}
	/**
	 * @Description bcydwcomid的中文含义是： 被抽样单位ID
	 */
	public String getBcydwcomid(){
		return bcydwcomid;
	}
	/**
	 * @Description bcydw的中文含义是： 被抽样单位
	 */
	public void setBcydw(String bcydw){ 
		this.bcydw = bcydw;
	}
	/**
	 * @Description bcydw的中文含义是： 被抽样单位
	 */
	public String getBcydw(){
		return bcydw;
	}
	/**
	 * @Description bcydwfl的中文含义是： 被抽样单位分类
	 */
	public void setBcydwfl(String bcydwfl){ 
		this.bcydwfl = bcydwfl;
	}
	/**
	 * @Description bcydwfl的中文含义是： 被抽样单位分类
	 */
	public String getBcydwfl(){
		return bcydwfl;
	}
	/**
	 * @Description bcydwdz的中文含义是： 被抽样单位地址
	 */
	public void setBcydwdz(String bcydwdz){ 
		this.bcydwdz = bcydwdz;
	}
	/**
	 * @Description bcydwdz的中文含义是： 被抽样单位地址
	 */
	public String getBcydwdz(){
		return bcydwdz;
	}
	/**
	 * @Description tel的中文含义是： 被抽样单位联系电话
	 */
	public void setTel(String tel){ 
		this.tel = tel;
	}
	/**
	 * @Description tel的中文含义是： 被抽样单位联系电话
	 */
	public String getTel(){
		return tel;
	}
	/**
	 * @Description ypmc的中文含义是： 样品名称
	 */
	public void setYpmc(String ypmc){ 
		this.ypmc = ypmc;
	}
	/**
	 * @Description ypmc的中文含义是： 样品名称
	 */
	public String getYpmc(){
		return ypmc;
	}
	/**
	 * @Description ypbh的中文含义是： 样品批号或生产日期
	 */
	public void setYpbh(String ypbh){ 
		this.ypbh = ypbh;
	}
	/**
	 * @Description ypbh的中文含义是： 样品批号或生产日期
	 */
	public String getYpbh(){
		return ypbh;
	}
	/**
	 * @Description countcy的中文含义是： 抽样数量
	 */
	public void setCountcy(String countcy){ 
		this.countcy = countcy;
	}
	/**
	 * @Description countcy的中文含义是： 抽样数量
	 */
	public String getCountcy(){
		return countcy;
	}
	/**
	 * @Description ypgg的中文含义是： 样品规格
	 */
	public void setYpgg(String ypgg){ 
		this.ypgg = ypgg;
	}
	/**
	 * @Description ypgg的中文含义是： 样品规格
	 */
	public String getYpgg(){
		return ypgg;
	}
	/**
	 * @Description scdwcomid的中文含义是： 生产单位ID
	 */
	public void setScdwcomid(String scdwcomid){ 
		this.scdwcomid = scdwcomid;
	}
	/**
	 * @Description scdwcomid的中文含义是： 生产单位ID
	 */
	public String getScdwcomid(){
		return scdwcomid;
	}
	/**
	 * @Description scdw的中文含义是： 生产单位
	 */
	public void setScdw(String scdw){ 
		this.scdw = scdw;
	}
	/**
	 * @Description scdw的中文含义是： 生产单位
	 */
	public String getScdw(){
		return scdw;
	}
	/**
	 * @Description cyjsr的中文含义是： 抽样经手人
	 */
	public void setCyjsr(String cyjsr){ 
		this.cyjsr = cyjsr;
	}
	/**
	 * @Description cyjsr的中文含义是： 抽样经手人
	 */
	public String getCyjsr(){
		return cyjsr;
	}
	/**
	 * @Description cysj的中文含义是： 抽样时间
	 */
	public void setCysj(String cysj){ 
		this.cysj = cysj;
	}
	/**
	 * @Description cysj的中文含义是： 抽样时间
	 */
	public String getCysj(){
		return cysj;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public void setAae011(String aae011){ 
		this.aae011 = aae011;
	}
	/**
	 * @Description aae011的中文含义是： 经办人
	 */
	public String getAae011(){
		return aae011;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public void setAae036(String aae036){ 
		this.aae036 = aae036;
	}
	/**
	 * @Description aae036的中文含义是： 经办时间
	 */
	public String getAae036(){
		return aae036;
	}

	
}