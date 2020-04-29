package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFAJDJ的中文含义是: 案件登记表; InnoDB free: 2731008 kB
 * @Creation     2016/06/01 10:53:38
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFAJDJ")
public class Zfajdj {
	/**
	 * @Description ajdjid的中文含义是： 
	 */
	@Column
	@Name
	private String ajdjid;

	/**
	 * @Description ajdjbh的中文含义是： 案件登记编号，手工填写
	 */
	@Column
	private String ajdjbh;

	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	@Column
	private String comdm;

	/**
	 * @Description commc的中文含义是： 企业名称
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
	 * @Description ajzt的中文含义是： 案件状态如0登记1立案3调查取证4结案归档,见代表表ajzt
	 */
	@Column
	private String ajzt;

	/**
	 * @Description comfrsfzh的中文含义是： 企业法人/业主身份证号
	 */
	@Column
	private String comfrsfzh;

	/**
	 * @Description comyddh的中文含义是： 联系电话
	 */
	@Column
	private String comyddh;

	/**
	 * @Description comyzbm的中文含义是： 企业邮政编码
	 */
	@Column
	private String comyzbm;

	/**
	 * @Description ajdjafsj的中文含义是： 案发时间
	 */
	@Column
	private String ajdjafsj;

	/**
	 * @Description ajdjay的中文含义是： 案由
	 */
	@Column
	private String ajdjay;

	/**
	 * @Description ajdjajly的中文含义是： 案件来源,对应代码表案件登记案件来源
	 */
	@Column
	private String ajdjajly;

	/**
	 * @Description ajdjjbqk的中文含义是： 案件基本情况介绍(负责人、案发时间、地点、重要证据、危害后果及其影响等)
	 */
	@Column
	private String ajdjjbqk;

	/**
	 * @Description ajdjclyj的中文含义是： 处理意见
	 */
	@Column
	private String ajdjclyj;

	/**
	 * @Description ajdjczy的中文含义是： 案件登记操作员姓名
	 */
	@Column
	private String ajdjczy;

	/**
	 * @Description ajdjczsj的中文含义是： 案件登记操作时间
	 */
	@Column
	private String ajdjczsj;

	/**
	 * @Description lianczy的中文含义是： 立案操作员
	 */
	@Column
	private String lianczy;

	/**
	 * @Description liansj的中文含义是： 立案时间
	 */
	@Column
	private String liansj;

	/**
	 * @Description dcqzczy的中文含义是： 调查取证操作员
	 */
	@Column
	private String dcqzczy;

	/**
	 * @Description dcqzsj的中文含义是： 调查取证时间
	 */
	@Column
	private String dcqzsj;

	/**
	 * @Description cfjdcx的中文含义是： 处罚决定程序1一般程序2听证程序3简易程序
	 */
	@Column
	private String cfjdcx;

	/**
	 * @Description cfjdczy的中文含义是： 处罚决定操作员
	 */
	@Column
	private String cfjdczy;

	/**
	 * @Description cfjdsj的中文含义是： 处罚决定时间
	 */
	@Column
	private String cfjdsj;

	/**
	 * @Description jagdczy的中文含义是： 结案归档操作员
	 */
	@Column
	private String jagdczy;

	/**
	 * @Description jagdsj的中文含义是： 结案归档时间
	 */
	@Column
	private String jagdsj;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	@Column
	private String aaa027;

	/**
	 * @Description ajdjsfgx的中文含义是： 案件登记是否归本部门管辖1是0否
	 */
	@Column
	private String ajdjsfgx;

	/**
	 * @Description ajjsbz的中文含义是： 案件结束标志0否1是
	 */
	@Column
	private String ajjsbz;

	/**
	 * @Description aae140的中文含义是： 案件登记案件大类,见aa10表aae140
	 */
	@Column
	private String aae140;

	/**
	 * @Description ajdjajbhnf的中文含义是： 案件登记案件编号年份
	 */
	@Column
	private String ajdjajbhnf;

	/**
	 * @Description ajdjajbhxh的中文含义是： 案件登记案件编号序号
	 */
	@Column
	private String ajdjajbhxh;

	/**
	 * @Description comzzzm的中文含义是： 资质证明,见aa10中aaa100=COMZZZM
	 */
	@Column
	private String comzzzm;

	/**
	 * @Description comzzzmbh的中文含义是： 资质证明编号
	 */
	@Column
	private String comzzzmbh;

	/**
	 * @Description comzzjgdm的中文含义是： 组织机构代码
	 */
	@Column
	private String comzzjgdm;

	/**
	 * @Description comfrxb的中文含义是： 企业法人性别
	 */
	@Column
	private String comfrxb;

	/**
	 * @Description comfrzw的中文含义是： 企业法人职务
	 */
	@Column
	private String comfrzw;

	/**
	 * @Description comfrnl的中文含义是： 企业法人年龄
	 */
	@Column
	private Integer comfrnl;

	/**
	 * @Description slbz的中文含义是： 受理标志见aaa100=SLBZ
	 */
	@Column
	private String slbz;

	/**
	 * @Description slczy的中文含义是： 受理操作员
	 */
	@Column
	private String slczy;

	/**
	 * @Description slsj的中文含义是： 受理时间
	 */
	@Column
	private String slsj;

	/**
	 * @Description zxxmcsbm的中文含义是： 征信项目参数编码,对应zxpdcmcs表
	 */
	@Column
	private String zxxmcsbm;

	/**
	 * @Description wfxwbh的中文含义是： 违法行为编号
	 */
	@Column
	private String wfxwbh;


	
	

	/**
	 * @Description ajdjwfss的中文含义是： 违法事实
	 */
	@Column
	private String ajdjwfss;

	/**
	 * @Description orgid的中文含义是： 机构ID
	 */
	@Column
	private String orgid;
	
	/**
	 * @Description 操作员ID的中文含义是： 操作员ID
	 */
	@Column
	private String userid;	
	
	/**
	 * @Description comid的中文含义是：企业表主键
	 */
	@Column
	private String comid;		

	
		/**
	 * @Description ajdjid的中文含义是： 
	 */
	public void setAjdjid(String ajdjid){ 
		this.ajdjid = ajdjid;
	}
	/**
	 * @Description ajdjid的中文含义是： 
	 */
	public String getAjdjid(){
		return ajdjid;
	}
	/**
	 * @Description ajdjbh的中文含义是： 案件登记编号，手工填写
	 */
	public void setAjdjbh(String ajdjbh){ 
		this.ajdjbh = ajdjbh;
	}
	/**
	 * @Description ajdjbh的中文含义是： 案件登记编号，手工填写
	 */
	public String getAjdjbh(){
		return ajdjbh;
	}
	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	public void setComdm(String comdm){ 
		this.comdm = comdm;
	}
	/**
	 * @Description comdm的中文含义是： 企业代码：企业类型字母+6位行政区域代码+9位序列号
	 */
	public String getComdm(){
		return comdm;
	}
	/**
	 * @Description commc的中文含义是： 企业名称
	 */
	public void setCommc(String commc){ 
		this.commc = commc;
	}
	/**
	 * @Description commc的中文含义是： 企业名称
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
	 * @Description ajzt的中文含义是： 案件状态如0登记1立案3调查取证4结案归档,见代表表ajzt
	 */
	public void setAjzt(String ajzt){ 
		this.ajzt = ajzt;
	}
	/**
	 * @Description ajzt的中文含义是： 案件状态如0登记1立案3调查取证4结案归档,见代表表ajzt
	 */
	public String getAjzt(){
		return ajzt;
	}
	/**
	 * @Description comfrsfzh的中文含义是： 企业法人/业主身份证号
	 */
	public void setComfrsfzh(String comfrsfzh){ 
		this.comfrsfzh = comfrsfzh;
	}
	/**
	 * @Description comfrsfzh的中文含义是： 企业法人/业主身份证号
	 */
	public String getComfrsfzh(){
		return comfrsfzh;
	}
	/**
	 * @Description comyddh的中文含义是： 联系电话
	 */
	public void setComyddh(String comyddh){ 
		this.comyddh = comyddh;
	}
	/**
	 * @Description comyddh的中文含义是： 联系电话
	 */
	public String getComyddh(){
		return comyddh;
	}
	/**
	 * @Description comyzbm的中文含义是： 企业邮政编码
	 */
	public void setComyzbm(String comyzbm){ 
		this.comyzbm = comyzbm;
	}
	/**
	 * @Description comyzbm的中文含义是： 企业邮政编码
	 */
	public String getComyzbm(){
		return comyzbm;
	}
	/**
	 * @Description ajdjafsj的中文含义是： 案发时间
	 */
	public void setAjdjafsj(String ajdjafsj){ 
		this.ajdjafsj = ajdjafsj;
	}
	/**
	 * @Description ajdjafsj的中文含义是： 案发时间
	 */
	public String getAjdjafsj(){
		return ajdjafsj;
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
	 * @Description ajdjajly的中文含义是： 案件来源,对应代码表案件登记案件来源
	 */
	public void setAjdjajly(String ajdjajly){ 
		this.ajdjajly = ajdjajly;
	}
	/**
	 * @Description ajdjajly的中文含义是： 案件来源,对应代码表案件登记案件来源
	 */
	public String getAjdjajly(){
		return ajdjajly;
	}
	/**
	 * @Description ajdjjbqk的中文含义是： 案件基本情况介绍(负责人、案发时间、地点、重要证据、危害后果及其影响等)
	 */
	public void setAjdjjbqk(String ajdjjbqk){ 
		this.ajdjjbqk = ajdjjbqk;
	}
	/**
	 * @Description ajdjjbqk的中文含义是： 案件基本情况介绍(负责人、案发时间、地点、重要证据、危害后果及其影响等)
	 */
	public String getAjdjjbqk(){
		return ajdjjbqk;
	}
	/**
	 * @Description ajdjclyj的中文含义是： 处理意见
	 */
	public void setAjdjclyj(String ajdjclyj){ 
		this.ajdjclyj = ajdjclyj;
	}
	/**
	 * @Description ajdjclyj的中文含义是： 处理意见
	 */
	public String getAjdjclyj(){
		return ajdjclyj;
	}
	/**
	 * @Description ajdjczy的中文含义是： 案件登记操作员姓名
	 */
	public void setAjdjczy(String ajdjczy){ 
		this.ajdjczy = ajdjczy;
	}
	/**
	 * @Description ajdjczy的中文含义是： 案件登记操作员姓名
	 */
	public String getAjdjczy(){
		return ajdjczy;
	}
	/**
	 * @Description ajdjczsj的中文含义是： 案件登记操作时间
	 */
	public void setAjdjczsj(String ajdjczsj){ 
		this.ajdjczsj = ajdjczsj;
	}
	/**
	 * @Description ajdjczsj的中文含义是： 案件登记操作时间
	 */
	public String getAjdjczsj(){
		return ajdjczsj;
	}
	/**
	 * @Description lianczy的中文含义是： 立案操作员
	 */
	public void setLianczy(String lianczy){ 
		this.lianczy = lianczy;
	}
	/**
	 * @Description lianczy的中文含义是： 立案操作员
	 */
	public String getLianczy(){
		return lianczy;
	}
	/**
	 * @Description liansj的中文含义是： 立案时间
	 */
	public void setLiansj(String liansj){ 
		this.liansj = liansj;
	}
	/**
	 * @Description liansj的中文含义是： 立案时间
	 */
	public String getLiansj(){
		return liansj;
	}
	/**
	 * @Description dcqzczy的中文含义是： 调查取证操作员
	 */
	public void setDcqzczy(String dcqzczy){ 
		this.dcqzczy = dcqzczy;
	}
	/**
	 * @Description dcqzczy的中文含义是： 调查取证操作员
	 */
	public String getDcqzczy(){
		return dcqzczy;
	}
	/**
	 * @Description dcqzsj的中文含义是： 调查取证时间
	 */
	public void setDcqzsj(String dcqzsj){ 
		this.dcqzsj = dcqzsj;
	}
	/**
	 * @Description dcqzsj的中文含义是： 调查取证时间
	 */
	public String getDcqzsj(){
		return dcqzsj;
	}
	/**
	 * @Description cfjdcx的中文含义是： 处罚决定程序1一般程序2听证程序3简易程序
	 */
	public void setCfjdcx(String cfjdcx){ 
		this.cfjdcx = cfjdcx;
	}
	/**
	 * @Description cfjdcx的中文含义是： 处罚决定程序1一般程序2听证程序3简易程序
	 */
	public String getCfjdcx(){
		return cfjdcx;
	}
	/**
	 * @Description cfjdczy的中文含义是： 处罚决定操作员
	 */
	public void setCfjdczy(String cfjdczy){ 
		this.cfjdczy = cfjdczy;
	}
	/**
	 * @Description cfjdczy的中文含义是： 处罚决定操作员
	 */
	public String getCfjdczy(){
		return cfjdczy;
	}
	/**
	 * @Description cfjdsj的中文含义是： 处罚决定时间
	 */
	public void setCfjdsj(String cfjdsj){ 
		this.cfjdsj = cfjdsj;
	}
	/**
	 * @Description cfjdsj的中文含义是： 处罚决定时间
	 */
	public String getCfjdsj(){
		return cfjdsj;
	}
	/**
	 * @Description jagdczy的中文含义是： 结案归档操作员
	 */
	public void setJagdczy(String jagdczy){ 
		this.jagdczy = jagdczy;
	}
	/**
	 * @Description jagdczy的中文含义是： 结案归档操作员
	 */
	public String getJagdczy(){
		return jagdczy;
	}
	/**
	 * @Description jagdsj的中文含义是： 结案归档时间
	 */
	public void setJagdsj(String jagdsj){ 
		this.jagdsj = jagdsj;
	}
	/**
	 * @Description jagdsj的中文含义是： 结案归档时间
	 */
	public String getJagdsj(){
		return jagdsj;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027(){
		return aaa027;
	}
	/**
	 * @Description ajdjsfgx的中文含义是： 案件登记是否归本部门管辖1是0否
	 */
	public void setAjdjsfgx(String ajdjsfgx){ 
		this.ajdjsfgx = ajdjsfgx;
	}
	/**
	 * @Description ajdjsfgx的中文含义是： 案件登记是否归本部门管辖1是0否
	 */
	public String getAjdjsfgx(){
		return ajdjsfgx;
	}
	/**
	 * @Description ajjsbz的中文含义是： 案件结束标志0否1是
	 */
	public void setAjjsbz(String ajjsbz){ 
		this.ajjsbz = ajjsbz;
	}
	/**
	 * @Description ajjsbz的中文含义是： 案件结束标志0否1是
	 */
	public String getAjjsbz(){
		return ajjsbz;
	}
	/**
	 * @Description aae140的中文含义是： 案件登记案件大类,见aa10表aae140
	 */
	public void setAae140(String aae140){ 
		this.aae140 = aae140;
	}
	/**
	 * @Description aae140的中文含义是： 案件登记案件大类,见aa10表aae140
	 */
	public String getAae140(){
		return aae140;
	}
	/**
	 * @Description ajdjajbhnf的中文含义是： 案件登记案件编号年份
	 */
	public void setAjdjajbhnf(String ajdjajbhnf){ 
		this.ajdjajbhnf = ajdjajbhnf;
	}
	/**
	 * @Description ajdjajbhnf的中文含义是： 案件登记案件编号年份
	 */
	public String getAjdjajbhnf(){
		return ajdjajbhnf;
	}
	/**
	 * @Description ajdjajbhxh的中文含义是： 案件登记案件编号序号
	 */
	public void setAjdjajbhxh(String ajdjajbhxh){ 
		this.ajdjajbhxh = ajdjajbhxh;
	}
	/**
	 * @Description ajdjajbhxh的中文含义是： 案件登记案件编号序号
	 */
	public String getAjdjajbhxh(){
		return ajdjajbhxh;
	}
	/**
	 * @Description comzzzm的中文含义是： 资质证明,见aa10中aaa100=COMZZZM
	 */
	public void setComzzzm(String comzzzm){ 
		this.comzzzm = comzzzm;
	}
	/**
	 * @Description comzzzm的中文含义是： 资质证明,见aa10中aaa100=COMZZZM
	 */
	public String getComzzzm(){
		return comzzzm;
	}
	/**
	 * @Description comzzzmbh的中文含义是： 资质证明编号
	 */
	public void setComzzzmbh(String comzzzmbh){ 
		this.comzzzmbh = comzzzmbh;
	}
	/**
	 * @Description comzzzmbh的中文含义是： 资质证明编号
	 */
	public String getComzzzmbh(){
		return comzzzmbh;
	}
	/**
	 * @Description comzzjgdm的中文含义是： 组织机构代码
	 */
	public void setComzzjgdm(String comzzjgdm){ 
		this.comzzjgdm = comzzjgdm;
	}
	/**
	 * @Description comzzjgdm的中文含义是： 组织机构代码
	 */
	public String getComzzjgdm(){
		return comzzjgdm;
	}
	/**
	 * @Description comfrxb的中文含义是： 企业法人性别
	 */
	public void setComfrxb(String comfrxb){ 
		this.comfrxb = comfrxb;
	}
	/**
	 * @Description comfrxb的中文含义是： 企业法人性别
	 */
	public String getComfrxb(){
		return comfrxb;
	}
	/**
	 * @Description comfrzw的中文含义是： 企业法人职务
	 */
	public void setComfrzw(String comfrzw){ 
		this.comfrzw = comfrzw;
	}
	/**
	 * @Description comfrzw的中文含义是： 企业法人职务
	 */
	public String getComfrzw(){
		return comfrzw;
	}
	/**
	 * @Description comfrnl的中文含义是： 企业法人年龄
	 */
	public void setComfrnl(Integer comfrnl){ 
		this.comfrnl = comfrnl;
	}
	/**
	 * @Description comfrnl的中文含义是： 企业法人年龄
	 */
	public Integer getComfrnl(){
		return comfrnl;
	}
	/**
	 * @Description slbz的中文含义是： 受理标志见aaa100=SLBZ
	 */
	public void setSlbz(String slbz){ 
		this.slbz = slbz;
	}
	/**
	 * @Description slbz的中文含义是： 受理标志见aaa100=SLBZ
	 */
	public String getSlbz(){
		return slbz;
	}
	/**
	 * @Description slczy的中文含义是： 受理操作员
	 */
	public void setSlczy(String slczy){ 
		this.slczy = slczy;
	}
	/**
	 * @Description slczy的中文含义是： 受理操作员
	 */
	public String getSlczy(){
		return slczy;
	}
	/**
	 * @Description slsj的中文含义是： 受理时间
	 */
	public void setSlsj(String slsj){ 
		this.slsj = slsj;
	}
	/**
	 * @Description slsj的中文含义是： 受理时间
	 */
	public String getSlsj(){
		return slsj;
	}
	/**
	 * @Description zxxmcsbm的中文含义是： 征信项目参数编码,对应zxpdcmcs表
	 */
	public void setZxxmcsbm(String zxxmcsbm){ 
		this.zxxmcsbm = zxxmcsbm;
	}
	/**
	 * @Description zxxmcsbm的中文含义是： 征信项目参数编码,对应zxpdcmcs表
	 */
	public String getZxxmcsbm(){
		return zxxmcsbm;
	}
	/**
	 * @Description wfxwbh的中文含义是： 违法行为编号
	 */
	public void setWfxwbh(String wfxwbh){ 
		this.wfxwbh = wfxwbh;
	}
	/**
	 * @Description wfxwbh的中文含义是： 违法行为编号
	 */
	public String getWfxwbh(){
		return wfxwbh;
	}
	public String getAjdjwfss() {
		return ajdjwfss;
	}
	public void setAjdjwfss(String ajdjwfss) {
		this.ajdjwfss = ajdjwfss;
	}
	public String getOrgid() {
		return orgid;
	}
	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}

	
}