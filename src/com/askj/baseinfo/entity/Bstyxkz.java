package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(value = "Bstyxkz")
public class Bstyxkz {
/** 通用许可证表; InnoDB free: 315392 kB  */
	/** ID 的中文含义是：*/
	@Name
	@Column(value="ID")
	private String id;

	/** COM_DM 的中文含义是：企业代码*/
	@Column(value="COM_DM")
	private String comDm;

	/** XKZBH 的中文含义是：许可证编号*/
	@Column(value="XKZBH")
	private String xkzbh;

	/** SQ_SQBH 的中文含义是：对应申请编号*/
	@Column(value="SQ_SQBH")
	private String sqSqbh;

	/** YYZZH 的中文含义是：营业执照号*/
	@Column(value="YYZZH")
	private String yyzzh;

	/** COM_MC 的中文含义是：企业名称*/
	@Column(value="COM_MC")
	private String comMc;

	/** ZZJGDM 的中文含义是：组织机构代码*/
	@Column(value="ZZJGDM")
	private String zzjgdm;

	/** XKZ_FZRQ 的中文含义是：发证日期*/
	@Column(value="XKZ_FZRQ")
	private Date xkzFzrq;

	/** XKZ_YXQ 的中文含义是：有效期*/
	@Column(value="XKZ_YXQ")
	private Integer xkzYxq;

	/** XKZ_YXQZ 的中文含义是：有效期止*/
	@Column(value="XKZ_YXQZ")
	private Date xkzYxqz;

	/** XKZ_SFZX 的中文含义是：是否注销 Y是 N否*/
	@Column(value="XKZ_SFZX")
	private String xkzSfzx;

	/** XKZ_ZXYY 的中文含义是：注销原因*/
	@Column(value="XKZ_ZXYY")
	private String xkzZxyy;

	/** XKZ_ZXSJ 的中文含义是：注销时间*/
	@Column(value="XKZ_ZXSJ")
	private Timestamp xkzZxsj;

	/** XKZ_XKLB 的中文含义是：许可类别（对应代码表 dm_dmlb=XKZLB）*/
	@Column(value="XKZ_XKLB")
	private String xkzXklb;

	/** xkz_xkzlbbz 的中文含义是：许可证类别标注(1,食品添加剂 2 食品 .....)*/
	@Column(value="xkz_xkzlbbz")
	private String xkzXkzlbbz;

	/** XKZ_BZ 的中文含义是：备注*/
	@Column(value="XKZ_BZ")
	private String xkzBz;

	/** CPMC 的中文含义是：产品名称*/
	@Column(value="CPMC")
	private String cpmc;

	/** CPGG 的中文含义是：产品规格、型号*/
	@Column(value="CPGG")
	private String cpgg;

	/** YLQXXNJGJZC 的中文含义是：结构及组成*/
	@Column(value="YLQXXNJGJZC")
	private String ylqxxnjgjzc;

	/** CPSYFW 的中文含义是：适用范围*/
	@Column(value="CPSYFW")
	private String cpsyfw;

	/** CPJSYQ 的中文含义是：产品技术要求*/
	@Column(value="CPJSYQ")
	private String cpjsyq;

	/** QY_SCDZ 的中文含义是：企业生产地址*/
	@Column(value="QY_SCDZ")
	private String qyScdz;

	/** qy_lxdh 的中文含义是：企业联系电话*/
	@Column(value="qy_lxdh")
	private String qyLxdh;

	/** QY_SCDZ_YZBM 的中文含义是：企业生产地址邮政编码*/
	@Column(value="QY_SCDZ_YZBM")
	private String qyScdzYzbm;

	/** BJP_SCPZ 的中文含义是：保健品生产品种*/
	@Column(value="BJP_SCPZ")
	private String bjpScpz;

	/** BJP_XKFW 的中文含义是：保健品许可范围*/
	@Column(value="BJP_XKFW")
	private String bjpXkfw;

	/** CCTJ 的中文含义是：存储条件*/
	@Column(value="CCTJ")
	private String cctj;

	/** CPYQYT 的中文含义是：产品预期用途*/
	@Column(value="CPYQYT")
	private String cpyqyt;

	/** CPYXQ 的中文含义是：产品有效期*/
	@Column(value="CPYXQ")
	private String cpyxq;

	/** SQ_HZ_SZDYBH 的中文含义是：经核准后的申请单元编号(申请单元编号) 多个以,分隔*/
	@Column(value="SQ_HZ_SZDYBH")
	private String sqHzSzdybh;

	/** SFJYSQ 的中文含义是：是否检验申请*/
	@Column(value="SFJYSQ")
	private String sfjysq;

	/** OS_VER 的中文含义是：操作版本号*/
	@Column(value="OS_VER")
	private Long osVer;

	/** OS_YXBZ 的中文含义是：有效标志 1有  0无*/
	@Column(value="OS_YXBZ")
	private String osYxbz;

	/** OS_SJ 的中文含义是：操作时间*/
	@Column(value="OS_SJ")
	private Date osSj;

	/** BG_VER 的中文含义是：检测报告版本号*/
	@Column(value="BG_VER")
	private String bgVer;

	/** OS_VER_LAST 的中文含义是：上一步操作版本号*/
	@Column(value="OS_VER_LAST")
	private Long osVerLast;

	/** xkz_fzjg 的中文含义是：许可证发证机关*/
	@Column(value="xkz_fzjg")
	private String xkzFzjg;

	/** JYXM 的中文含义是：认证/经营项目或经营范围*/
	@Column(value="JYXM")
	private String jyxm;

	/** jyxmyw 的中文含义是：认证/经营范围或项目-英文*/
	@Column
	private String jyxmyw;

	/** ZTXT 的中文含义是：主体业态*/
	@Column(value="ZTXT")
	private String ztxt;

	/** FZRQ 的中文含义是：发证日期*/
	@Column(value="FZRQ")
	private Date fzrq;

	/** FZJG 的中文含义是：发证机关*/
	@Column(value="FZJG")
	private String fzjg;

	/** qfr 的中文含义是：签发人*/
	@Column
	private String qfr;

	/** FBS 的中文含义是：副本数*/
	@Column(value="FBS")
	private Integer fbs;

	/** YXQXZ 的中文含义是：有效期限自(食品生产签发人下面的)*/
	@Column(value="YXQXZ")
	private Date yxqxz;

	/** YXQXZ01 的中文含义是：有效期限至*/
	@Column(value="YXQXZ01")
	private Date yxqxz01;

	/** SFSQJTYCPS 的中文含义是：是否申请集体用餐配送*/
	@Column(value="SFSQJTYCPS")
	private int sfsqjtycps;

	/** SFSQWLJY 的中文含义是：是否申请网络经营*/
	@Column(value="SFSQWLJY")
	private String sfsqwljy;

	/** SFSQJLZYCF 的中文含义是：是否申请建立中央厨房*/
	@Column(value="SFSQJLZYCF")
	private int sfsqjlzycf;

	/** JYCS 的中文含义是：经营场所*/
	@Column(value="JYCS")
	private String jycs;

	/** ZS 的中文含义是：住所*/
	@Column(value="ZS")
	private String zs;

	/** zsyw 的中文含义是：住所英文*/
	@Column
	private String zsyw;

	/** FDDBR 的中文含义是：法定代表人*/
	@Column(value="FDDBR")
	private String fddbr;

	/** fddbr_id 的中文含义是：法定代表人id*/
	@Column(value="fddbr_id")
	private Long fddbrId;

	/** fddbrsfzh 的中文含义是：法定代表人身份证号*/
	@Column
	private String fddbrsfzh;

	/** fddbrlxdh 的中文含义是：法定代表人联系电话*/
	@Column
	private String fddbrlxdh;

	/** fax 的中文含义是：传真电话*/
	@Column
	private String fax;

	/** zip 的中文含义是：邮政编码*/
	@Column
	private String zip;

	/** COM_MCYW 的中文含义是：企业名称英文*/
	@Column(value="COM_MCYW")
	private String comMcyw;

	/** QYWZ 的中文含义是：企业网址*/
	@Column(value="QYWZ")
	private String qywz;

	/** rcjdgljg 的中文含义是：日常监督管理机构*/
	@Column
	private String rcjdgljg;

	/** rcjdglry 的中文含义是：日常监督管理人员*/
	@Column
	private String rcjdglry;

	/** xkz_zxzt 的中文含义是：*/
	@Column(value="xkz_zxzt")
	private String xkzZxzt;

	/** spjy_jycs 的中文含义是：食品经营，经营场所地址*/
	@Column(value="spjy_jycs")
	private String spjyJycs;

	/** spjy_ckdz 的中文含义是：食品经营，仓库地址*/
	@Column(value="spjy_ckdz")
	private String spjyCkdz;

	/** spjy_fzr_id 的中文含义是：食品经营，负责人id*/
	@Column(value="spjy_fzr_id")
	private String spjyFzrId;

	/** spjy_ztlx 的中文含义是：食品经营,主体类型*/
	@Column(value="spjy_ztlx")
	private String spjyZtlx;

	/** spjy_jylb 的中文含义是：食品经营，经营类别*/
	@Column(value="spjy_jylb")
	private String spjyJylb;

	/** spjy_jyqx 的中文含义是：食品经营，经营期限*/
	@Column(value="spjy_jyqx")
	private String spjyJyqx;

	/** spjy_jymj 的中文含义是：食品经营，经营面积*/
	@Column(value="spjy_jymj")
	private String spjyJymj;

	/** spjy_jyxm 的中文含义是：食品经营，经营项目*/
	@Column(value="spjy_jyxm")
	private String spjyJyxm;

	/** xkz_tjdylcbz 的中文含义是：提交打印流程标志0否1是*/
	@Column(value="xkz_tjdylcbz")
	private String xkzTjdylcbz;

	/** YPJY_JYFW 的中文含义是：药品经营,经营范围*/
	@Column(value="YPJY_JYFW")
	private String ypjyJyfw;

	/** YPJY_FDDBR 的中文含义是：药品经营,法定代表人*/
	@Column(value="YPJY_FDDBR")
	private String ypjyFddbr;

	/** YPJY_QYFZR 的中文含义是：药品经营，企业负责人*/
	@Column(value="YPJY_QYFZR")
	private String ypjyQyfzr;

	/** YPJY_ZLFZR 的中文含义是：药品经营，质量负责人*/
	@Column(value="YPJY_ZLFZR")
	private String ypjyZlfzr;

	/** YPJY_JYFS 的中文含义是：药品经营，经营方式*/
	@Column(value="YPJY_JYFS")
	private String ypjyJyfs;

	/** YPJY_ZCDZ 的中文含义是：药品经营，注册地址*/
	@Column(value="YPJY_ZCDZ")
	private String ypjyZcdz;

	/** YPJY_CKDZ 的中文含义是：药品经营，仓库地址*/
	@Column(value="YPJY_CKDZ")
	private String ypjyCkdz;

	/** YPJY_QYMC 的中文含义是：药品经营，企业名称*/
	@Column(value="YPJY_QYMC")
	private String ypjyQymc;

	/** qyfzr 的中文含义是：企业负责人*/
	@Column
	private String qyfzr;

	/** ylqxjy_ckdz 的中文含义是：医疗器械经营仓库地址*/
	@Column(value="ylqxjy_ckdz")
	private String ylqxjyCkdz;

	/** zlglr 的中文含义是：质量管理人*/
	@Column
	private String zlglr;

	/** ylqxsc_zcdz 的中文含义是：医疗器械生产注册地址*/
	@Column(value="ylqxsc_zcdz")
	private String ylqxscZcdz;

	/** xkz_qylx 的中文含义是：企业类型*/
	@Column(value="xkz_qylx")
	private String xkzQylx;

	/** JYFS 的中文含义是：经营方式*/
	@Column(value="JYFS")
	private String jyfs;

	/** JYMS 的中文含义是：经营模式*/
	@Column(value="JYMS")
	private String jyms;

	/** ZCZB 的中文含义是：注册资本（万元）*/
	@Column(value="ZCZB")
	private Integer zczb;

	/** yljgzjxk_yljgmc 的中文含义是：医疗机构名称*/
	@Column(value="yljgzjxk_yljgmc")
	private String yljgzjxkYljgmc;

	/** yljgzjxk_zcdz 的中文含义是：注册地址*/
	@Column(value="yljgzjxk_zcdz")
	private String yljgzjxkZcdz;

	/** yljgzjxk_lxr 的中文含义是：联系人*/
	@Column(value="yljgzjxk_lxr")
	private String yljgzjxkLxr;

	/** yljgzjxk_lxr_dh 的中文含义是：联系人电话*/
	@Column(value="yljgzjxk_lxr_dh")
	private String yljgzjxkLxrDh;

	/** yljgzjxk_jglx 的中文含义是：机构类型*/
	@Column(value="yljgzjxk_jglx")
	private String yljgzjxkJglx;

	/** yljgzjxk_fddbr 的中文含义是：法定代表人*/
	@Column(value="yljgzjxk_fddbr")
	private String yljgzjxkFddbr;

	/** yljgzjxk_fgyz 的中文含义是：分管院长*/
	@Column(value="yljgzjxk_fgyz")
	private String yljgzjxkFgyz;

	/** yljgzjxk_pzdz 的中文含义是：配制地址*/
	@Column(value="yljgzjxk_pzdz")
	private String yljgzjxkPzdz;

	/** yljgzjxk_pzfw 的中文含义是：配置范围*/
	@Column(value="yljgzjxk_pzfw")
	private String yljgzjxkPzfw;

	/** spjy_ybzsp 的中文含义是：食品经营预包装食品详细*/
	@Column(value="spjy_ybzsp")
	private String spjyYbzsp;

	/** spjy_szsp 的中文含义是：食品经营散装食品详细*/
	@Column(value="spjy_szsp")
	private String spjySzsp;

	/** spjy_tssp 的中文含义是：食品经营特殊食品详细*/
	@Column(value="spjy_tssp")
	private String spjyTssp;

	/** spjy_szss 的中文含义是：食品经营散装熟食*/
	@Column(value="spjy_szss")
	private String spjySzss;

	/** spjy_zzyp 的中文含义是：食品经营自制饮品酿酒*/
	@Column(value="spjy_zzyp")
	private String spjyZzyp;

	/** spjy_sxryp 的中文含义是：食品经营生鲜乳饮品*/
	@Column(value="spjy_sxryp")
	private String spjySxryp;

	/** spjy_bhdg 的中文含义是：食品经营裱花蛋糕*/
	@Column(value="spjy_bhdg")
	private String spjyBhdg;

	/** spjy_qtsp 的中文含义是：食品经营其他食品销售*/
	@Column(value="spjy_qtsp")
	private String spjyQtsp;

	/** spjy_qtzs 的中文含义是：食品经营其他食品制售*/
	@Column(value="spjy_qtzs")
	private String spjyQtzs;

	/** spjy_rslnr 的中文含义是：*/
	@Column(value="spjy_rslnr")
	private String spjyRslnr;

	/** spjy_lslnr 的中文含义是：*/
	@Column(value="spjy_lslnr")
	private String spjyLslnr;

	/** spjy_sslnr 的中文含义是：*/
	@Column(value="spjy_sslnr")
	private String spjySslnr;

	/** spjy_gdlnr 的中文含义是：*/
	@Column(value="spjy_gdlnr")
	private String spjyGdlnr;

	/** spjy_zzypnr 的中文含义是：*/
	@Column(value="spjy_zzypnr")
	private String spjyZzypnr;

	/** zjlx 的中文含义是：证件类型 01 社会信用代码 02 营业执照号 03身份证*/
	@Column
	private String zjlx;

	/** sfks 的中文含义是：是否快速申请 Y是 N否*/
	@Column
	private String sfks;

	/** xzqh 的中文含义是：行政区划*/
	@Column
	private String xzqh;

	/** sfxx 的中文含义是：是否学校*/
	@Column
	private String sfxx;

	/** yxkzbh 的中文含义是：原许可证号*/
	@Column
	private String yxkzbh;

	/** sqtjdqx 的中文含义是：申请提交地区县区*/
	@Column
	private String sqtjdqx;

	/** sqtjdqs 的中文含义是：申请提交地区市区*/
	@Column
	private String sqtjdqs;

	/** yjsj 的中文含义是：永杰数据1 非永杰数据0*/
	@Column
	private String yjsj;

	/** yljgzjxk_zjsfzr 的中文含义是：医疗机构制剂制剂室负责人*/
	@Column(value="yljgzjxk_zjsfzr")
	private String yljgzjxkZjsfzr;

	/** zzywlx 的中文含义是：最终业务类型 记录业务类型 新办 1  变更 2  延续3   补发 4 注销 5*/
	@Column
	private String zzywlx;

	/** DYZT 的中文含义是：打印状态  0 默认（未打印） 1 已打印 2老数据*/
	@Column(value="DYZT")
	private String dyzt;

	/** SPXKZBGRQ 的中文含义是：食品生产许可证变更日期*/
	@Column(value="SPXKZBGRQ")
	private Date spxkzbgrq;

	/** bz_zb 的中文含义是：正本打印状态：0、未打印；1、打印完成*/
	@Column(value="bz_zb")
	private Integer bzZb;

	/** bz_fb 的中文含义是：副本打印状态：0、未打印；1、打印完成*/
	@Column(value="bz_fb")
	private Integer bzFb;

	/** bz_mx 的中文含义是：明细打印状态：0、未打印；1、打印完成*/
	@Column(value="bz_mx")
	private Integer bzMx;

	/** qy_location 的中文含义是：企业位置*/
	@Column(value="qy_location")
	private String qyLocation;

	/** xkzbh_xh 的中文含义是：许可证编号的序号-取得序列号*/
	@Column(value="xkzbh_xh")
	private String xkzbhXh;

	/** spjy_sfdj 的中文含义是：食品经营数据是否对接 0 未对接  1 已对接 2 变更未更新  3 延续未更新  4 注销未更新*/
	@Column(value="spjy_sfdj")
	private String spjySfdj;

	/** qrcode 的中文含义是：证书二维码串*/
	@Column
	private String qrcode;

	/** tsbz 的中文含义是：推送标志 默认0, 河南信用食品经营已推送1, 失败2,河南信用食品生产已推送3, 失败4,药品生产已推送5, 失败6, 药品批发已推送7, 失败8, 器生产已推送9, 失败10,器械注册已推送11, 失败12,化妆品已推送13, 失败14,*/
	@Column
	private String tsbz;

	/** qrcode_id 的中文含义是：化妆品qrcode_id 二维码url的id*/
	@Column(value="qrcode_id")
	private String qrcodeId;

	/** shzt 的中文含义是：*/
	@Column
	private String shzt;

	/** sjc 的中文含义是：更新时间戳*/
	@Column
	private Timestamp sjc;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setComDm(String comDm){
		this.comDm=comDm;
	}

	public String getComDm(){
		return comDm;
	}

	public void setXkzbh(String xkzbh){
		this.xkzbh=xkzbh;
	}

	public String getXkzbh(){
		return xkzbh;
	}

	public void setSqSqbh(String sqSqbh){
		this.sqSqbh=sqSqbh;
	}

	public String getSqSqbh(){
		return sqSqbh;
	}

	public void setYyzzh(String yyzzh){
		this.yyzzh=yyzzh;
	}

	public String getYyzzh(){
		return yyzzh;
	}

	public void setComMc(String comMc){
		this.comMc=comMc;
	}

	public String getComMc(){
		return comMc;
	}

	public void setZzjgdm(String zzjgdm){
		this.zzjgdm=zzjgdm;
	}

	public String getZzjgdm(){
		return zzjgdm;
	}

	public void setXkzFzrq(Date xkzFzrq){
		this.xkzFzrq=xkzFzrq;
	}

	public Date getXkzFzrq(){
		return xkzFzrq;
	}

	public void setXkzYxq(Integer xkzYxq){
		this.xkzYxq=xkzYxq;
	}

	public Integer getXkzYxq(){
		return xkzYxq;
	}

	public void setXkzYxqz(Date xkzYxqz){
		this.xkzYxqz=xkzYxqz;
	}

	public Date getXkzYxqz(){
		return xkzYxqz;
	}

	public void setXkzSfzx(String xkzSfzx){
		this.xkzSfzx=xkzSfzx;
	}

	public String getXkzSfzx(){
		return xkzSfzx;
	}

	public void setXkzZxyy(String xkzZxyy){
		this.xkzZxyy=xkzZxyy;
	}

	public String getXkzZxyy(){
		return xkzZxyy;
	}

	public void setXkzZxsj(Timestamp xkzZxsj){
		this.xkzZxsj=xkzZxsj;
	}

	public Timestamp getXkzZxsj(){
		return xkzZxsj;
	}

	public void setXkzXklb(String xkzXklb){
		this.xkzXklb=xkzXklb;
	}

	public String getXkzXklb(){
		return xkzXklb;
	}

	public void setXkzXkzlbbz(String xkzXkzlbbz){
		this.xkzXkzlbbz=xkzXkzlbbz;
	}

	public String getXkzXkzlbbz(){
		return xkzXkzlbbz;
	}

	public void setXkzBz(String xkzBz){
		this.xkzBz=xkzBz;
	}

	public String getXkzBz(){
		return xkzBz;
	}

	public void setCpmc(String cpmc){
		this.cpmc=cpmc;
	}

	public String getCpmc(){
		return cpmc;
	}

	public void setCpgg(String cpgg){
		this.cpgg=cpgg;
	}

	public String getCpgg(){
		return cpgg;
	}

	public void setYlqxxnjgjzc(String ylqxxnjgjzc){
		this.ylqxxnjgjzc=ylqxxnjgjzc;
	}

	public String getYlqxxnjgjzc(){
		return ylqxxnjgjzc;
	}

	public void setCpsyfw(String cpsyfw){
		this.cpsyfw=cpsyfw;
	}

	public String getCpsyfw(){
		return cpsyfw;
	}

	public void setCpjsyq(String cpjsyq){
		this.cpjsyq=cpjsyq;
	}

	public String getCpjsyq(){
		return cpjsyq;
	}

	public void setQyScdz(String qyScdz){
		this.qyScdz=qyScdz;
	}

	public String getQyScdz(){
		return qyScdz;
	}

	public void setQyLxdh(String qyLxdh){
		this.qyLxdh=qyLxdh;
	}

	public String getQyLxdh(){
		return qyLxdh;
	}

	public void setQyScdzYzbm(String qyScdzYzbm){
		this.qyScdzYzbm=qyScdzYzbm;
	}

	public String getQyScdzYzbm(){
		return qyScdzYzbm;
	}

	public void setBjpScpz(String bjpScpz){
		this.bjpScpz=bjpScpz;
	}

	public String getBjpScpz(){
		return bjpScpz;
	}

	public void setBjpXkfw(String bjpXkfw){
		this.bjpXkfw=bjpXkfw;
	}

	public String getBjpXkfw(){
		return bjpXkfw;
	}

	public void setCctj(String cctj){
		this.cctj=cctj;
	}

	public String getCctj(){
		return cctj;
	}

	public void setCpyqyt(String cpyqyt){
		this.cpyqyt=cpyqyt;
	}

	public String getCpyqyt(){
		return cpyqyt;
	}

	public void setCpyxq(String cpyxq){
		this.cpyxq=cpyxq;
	}

	public String getCpyxq(){
		return cpyxq;
	}

	public void setSqHzSzdybh(String sqHzSzdybh){
		this.sqHzSzdybh=sqHzSzdybh;
	}

	public String getSqHzSzdybh(){
		return sqHzSzdybh;
	}

	public void setSfjysq(String sfjysq){
		this.sfjysq=sfjysq;
	}

	public String getSfjysq(){
		return sfjysq;
	}

	public void setOsVer(Long osVer){
		this.osVer=osVer;
	}

	public Long getOsVer(){
		return osVer;
	}

	public void setOsYxbz(String osYxbz){
		this.osYxbz=osYxbz;
	}

	public String getOsYxbz(){
		return osYxbz;
	}

	public void setOsSj(Date osSj){
		this.osSj=osSj;
	}

	public Date getOsSj(){
		return osSj;
	}

	public void setBgVer(String bgVer){
		this.bgVer=bgVer;
	}

	public String getBgVer(){
		return bgVer;
	}

	public void setOsVerLast(Long osVerLast){
		this.osVerLast=osVerLast;
	}

	public Long getOsVerLast(){
		return osVerLast;
	}

	public void setXkzFzjg(String xkzFzjg){
		this.xkzFzjg=xkzFzjg;
	}

	public String getXkzFzjg(){
		return xkzFzjg;
	}

	public void setJyxm(String jyxm){
		this.jyxm=jyxm;
	}

	public String getJyxm(){
		return jyxm;
	}

	public void setJyxmyw(String jyxmyw){
		this.jyxmyw=jyxmyw;
	}

	public String getJyxmyw(){
		return jyxmyw;
	}

	public void setZtxt(String ztxt){
		this.ztxt=ztxt;
	}

	public String getZtxt(){
		return ztxt;
	}

	public void setFzrq(Date fzrq){
		this.fzrq=fzrq;
	}

	public Date getFzrq(){
		return fzrq;
	}

	public void setFzjg(String fzjg){
		this.fzjg=fzjg;
	}

	public String getFzjg(){
		return fzjg;
	}

	public void setQfr(String qfr){
		this.qfr=qfr;
	}

	public String getQfr(){
		return qfr;
	}

	public void setFbs(Integer fbs){
		this.fbs=fbs;
	}

	public Integer getFbs(){
		return fbs;
	}

	public void setYxqxz(Date yxqxz){
		this.yxqxz=yxqxz;
	}

	public Date getYxqxz(){
		return yxqxz;
	}

	public void setYxqxz01(Date yxqxz01){
		this.yxqxz01=yxqxz01;
	}

	public Date getYxqxz01(){
		return yxqxz01;
	}

	public void setSfsqjtycps(int sfsqjtycps){
		this.sfsqjtycps=sfsqjtycps;
	}

	public int getSfsqjtycps(){
		return sfsqjtycps;
	}

	public void setSfsqwljy(String sfsqwljy){
		this.sfsqwljy=sfsqwljy;
	}

	public String getSfsqwljy(){
		return sfsqwljy;
	}

	public void setSfsqjlzycf(int sfsqjlzycf){
		this.sfsqjlzycf=sfsqjlzycf;
	}

	public int getSfsqjlzycf(){
		return sfsqjlzycf;
	}

	public void setJycs(String jycs){
		this.jycs=jycs;
	}

	public String getJycs(){
		return jycs;
	}

	public void setZs(String zs){
		this.zs=zs;
	}

	public String getZs(){
		return zs;
	}

	public void setZsyw(String zsyw){
		this.zsyw=zsyw;
	}

	public String getZsyw(){
		return zsyw;
	}

	public void setFddbr(String fddbr){
		this.fddbr=fddbr;
	}

	public String getFddbr(){
		return fddbr;
	}

	public void setFddbrId(Long fddbrId){
		this.fddbrId=fddbrId;
	}

	public Long getFddbrId(){
		return fddbrId;
	}

	public void setFddbrsfzh(String fddbrsfzh){
		this.fddbrsfzh=fddbrsfzh;
	}

	public String getFddbrsfzh(){
		return fddbrsfzh;
	}

	public void setFddbrlxdh(String fddbrlxdh){
		this.fddbrlxdh=fddbrlxdh;
	}

	public String getFddbrlxdh(){
		return fddbrlxdh;
	}

	public void setFax(String fax){
		this.fax=fax;
	}

	public String getFax(){
		return fax;
	}

	public void setZip(String zip){
		this.zip=zip;
	}

	public String getZip(){
		return zip;
	}

	public void setComMcyw(String comMcyw){
		this.comMcyw=comMcyw;
	}

	public String getComMcyw(){
		return comMcyw;
	}

	public void setQywz(String qywz){
		this.qywz=qywz;
	}

	public String getQywz(){
		return qywz;
	}

	public void setRcjdgljg(String rcjdgljg){
		this.rcjdgljg=rcjdgljg;
	}

	public String getRcjdgljg(){
		return rcjdgljg;
	}

	public void setRcjdglry(String rcjdglry){
		this.rcjdglry=rcjdglry;
	}

	public String getRcjdglry(){
		return rcjdglry;
	}

	public void setXkzZxzt(String xkzZxzt){
		this.xkzZxzt=xkzZxzt;
	}

	public String getXkzZxzt(){
		return xkzZxzt;
	}

	public void setSpjyJycs(String spjyJycs){
		this.spjyJycs=spjyJycs;
	}

	public String getSpjyJycs(){
		return spjyJycs;
	}

	public void setSpjyCkdz(String spjyCkdz){
		this.spjyCkdz=spjyCkdz;
	}

	public String getSpjyCkdz(){
		return spjyCkdz;
	}

	public void setSpjyFzrId(String spjyFzrId){
		this.spjyFzrId=spjyFzrId;
	}

	public String getSpjyFzrId(){
		return spjyFzrId;
	}

	public void setSpjyZtlx(String spjyZtlx){
		this.spjyZtlx=spjyZtlx;
	}

	public String getSpjyZtlx(){
		return spjyZtlx;
	}

	public void setSpjyJylb(String spjyJylb){
		this.spjyJylb=spjyJylb;
	}

	public String getSpjyJylb(){
		return spjyJylb;
	}

	public void setSpjyJyqx(String spjyJyqx){
		this.spjyJyqx=spjyJyqx;
	}

	public String getSpjyJyqx(){
		return spjyJyqx;
	}

	public void setSpjyJymj(String spjyJymj){
		this.spjyJymj=spjyJymj;
	}

	public String getSpjyJymj(){
		return spjyJymj;
	}

	public void setSpjyJyxm(String spjyJyxm){
		this.spjyJyxm=spjyJyxm;
	}

	public String getSpjyJyxm(){
		return spjyJyxm;
	}

	public void setXkzTjdylcbz(String xkzTjdylcbz){
		this.xkzTjdylcbz=xkzTjdylcbz;
	}

	public String getXkzTjdylcbz(){
		return xkzTjdylcbz;
	}

	public void setYpjyJyfw(String ypjyJyfw){
		this.ypjyJyfw=ypjyJyfw;
	}

	public String getYpjyJyfw(){
		return ypjyJyfw;
	}

	public void setYpjyFddbr(String ypjyFddbr){
		this.ypjyFddbr=ypjyFddbr;
	}

	public String getYpjyFddbr(){
		return ypjyFddbr;
	}

	public void setYpjyQyfzr(String ypjyQyfzr){
		this.ypjyQyfzr=ypjyQyfzr;
	}

	public String getYpjyQyfzr(){
		return ypjyQyfzr;
	}

	public void setYpjyZlfzr(String ypjyZlfzr){
		this.ypjyZlfzr=ypjyZlfzr;
	}

	public String getYpjyZlfzr(){
		return ypjyZlfzr;
	}

	public void setYpjyJyfs(String ypjyJyfs){
		this.ypjyJyfs=ypjyJyfs;
	}

	public String getYpjyJyfs(){
		return ypjyJyfs;
	}

	public void setYpjyZcdz(String ypjyZcdz){
		this.ypjyZcdz=ypjyZcdz;
	}

	public String getYpjyZcdz(){
		return ypjyZcdz;
	}

	public void setYpjyCkdz(String ypjyCkdz){
		this.ypjyCkdz=ypjyCkdz;
	}

	public String getYpjyCkdz(){
		return ypjyCkdz;
	}

	public void setYpjyQymc(String ypjyQymc){
		this.ypjyQymc=ypjyQymc;
	}

	public String getYpjyQymc(){
		return ypjyQymc;
	}

	public void setQyfzr(String qyfzr){
		this.qyfzr=qyfzr;
	}

	public String getQyfzr(){
		return qyfzr;
	}

	public void setYlqxjyCkdz(String ylqxjyCkdz){
		this.ylqxjyCkdz=ylqxjyCkdz;
	}

	public String getYlqxjyCkdz(){
		return ylqxjyCkdz;
	}

	public void setZlglr(String zlglr){
		this.zlglr=zlglr;
	}

	public String getZlglr(){
		return zlglr;
	}

	public void setYlqxscZcdz(String ylqxscZcdz){
		this.ylqxscZcdz=ylqxscZcdz;
	}

	public String getYlqxscZcdz(){
		return ylqxscZcdz;
	}

	public void setXkzQylx(String xkzQylx){
		this.xkzQylx=xkzQylx;
	}

	public String getXkzQylx(){
		return xkzQylx;
	}

	public void setJyfs(String jyfs){
		this.jyfs=jyfs;
	}

	public String getJyfs(){
		return jyfs;
	}

	public void setJyms(String jyms){
		this.jyms=jyms;
	}

	public String getJyms(){
		return jyms;
	}

	public void setZczb(Integer zczb){
		this.zczb=zczb;
	}

	public Integer getZczb(){
		return zczb;
	}

	public void setYljgzjxkYljgmc(String yljgzjxkYljgmc){
		this.yljgzjxkYljgmc=yljgzjxkYljgmc;
	}

	public String getYljgzjxkYljgmc(){
		return yljgzjxkYljgmc;
	}

	public void setYljgzjxkZcdz(String yljgzjxkZcdz){
		this.yljgzjxkZcdz=yljgzjxkZcdz;
	}

	public String getYljgzjxkZcdz(){
		return yljgzjxkZcdz;
	}

	public void setYljgzjxkLxr(String yljgzjxkLxr){
		this.yljgzjxkLxr=yljgzjxkLxr;
	}

	public String getYljgzjxkLxr(){
		return yljgzjxkLxr;
	}

	public void setYljgzjxkLxrDh(String yljgzjxkLxrDh){
		this.yljgzjxkLxrDh=yljgzjxkLxrDh;
	}

	public String getYljgzjxkLxrDh(){
		return yljgzjxkLxrDh;
	}

	public void setYljgzjxkJglx(String yljgzjxkJglx){
		this.yljgzjxkJglx=yljgzjxkJglx;
	}

	public String getYljgzjxkJglx(){
		return yljgzjxkJglx;
	}

	public void setYljgzjxkFddbr(String yljgzjxkFddbr){
		this.yljgzjxkFddbr=yljgzjxkFddbr;
	}

	public String getYljgzjxkFddbr(){
		return yljgzjxkFddbr;
	}

	public void setYljgzjxkFgyz(String yljgzjxkFgyz){
		this.yljgzjxkFgyz=yljgzjxkFgyz;
	}

	public String getYljgzjxkFgyz(){
		return yljgzjxkFgyz;
	}

	public void setYljgzjxkPzdz(String yljgzjxkPzdz){
		this.yljgzjxkPzdz=yljgzjxkPzdz;
	}

	public String getYljgzjxkPzdz(){
		return yljgzjxkPzdz;
	}

	public void setYljgzjxkPzfw(String yljgzjxkPzfw){
		this.yljgzjxkPzfw=yljgzjxkPzfw;
	}

	public String getYljgzjxkPzfw(){
		return yljgzjxkPzfw;
	}

	public void setSpjyYbzsp(String spjyYbzsp){
		this.spjyYbzsp=spjyYbzsp;
	}

	public String getSpjyYbzsp(){
		return spjyYbzsp;
	}

	public void setSpjySzsp(String spjySzsp){
		this.spjySzsp=spjySzsp;
	}

	public String getSpjySzsp(){
		return spjySzsp;
	}

	public void setSpjyTssp(String spjyTssp){
		this.spjyTssp=spjyTssp;
	}

	public String getSpjyTssp(){
		return spjyTssp;
	}

	public void setSpjySzss(String spjySzss){
		this.spjySzss=spjySzss;
	}

	public String getSpjySzss(){
		return spjySzss;
	}

	public void setSpjyZzyp(String spjyZzyp){
		this.spjyZzyp=spjyZzyp;
	}

	public String getSpjyZzyp(){
		return spjyZzyp;
	}

	public void setSpjySxryp(String spjySxryp){
		this.spjySxryp=spjySxryp;
	}

	public String getSpjySxryp(){
		return spjySxryp;
	}

	public void setSpjyBhdg(String spjyBhdg){
		this.spjyBhdg=spjyBhdg;
	}

	public String getSpjyBhdg(){
		return spjyBhdg;
	}

	public void setSpjyQtsp(String spjyQtsp){
		this.spjyQtsp=spjyQtsp;
	}

	public String getSpjyQtsp(){
		return spjyQtsp;
	}

	public void setSpjyQtzs(String spjyQtzs){
		this.spjyQtzs=spjyQtzs;
	}

	public String getSpjyQtzs(){
		return spjyQtzs;
	}

	public void setSpjyRslnr(String spjyRslnr){
		this.spjyRslnr=spjyRslnr;
	}

	public String getSpjyRslnr(){
		return spjyRslnr;
	}

	public void setSpjyLslnr(String spjyLslnr){
		this.spjyLslnr=spjyLslnr;
	}

	public String getSpjyLslnr(){
		return spjyLslnr;
	}

	public void setSpjySslnr(String spjySslnr){
		this.spjySslnr=spjySslnr;
	}

	public String getSpjySslnr(){
		return spjySslnr;
	}

	public void setSpjyGdlnr(String spjyGdlnr){
		this.spjyGdlnr=spjyGdlnr;
	}

	public String getSpjyGdlnr(){
		return spjyGdlnr;
	}

	public void setSpjyZzypnr(String spjyZzypnr){
		this.spjyZzypnr=spjyZzypnr;
	}

	public String getSpjyZzypnr(){
		return spjyZzypnr;
	}

	public void setZjlx(String zjlx){
		this.zjlx=zjlx;
	}

	public String getZjlx(){
		return zjlx;
	}

	public void setSfks(String sfks){
		this.sfks=sfks;
	}

	public String getSfks(){
		return sfks;
	}

	public void setXzqh(String xzqh){
		this.xzqh=xzqh;
	}

	public String getXzqh(){
		return xzqh;
	}

	public void setSfxx(String sfxx){
		this.sfxx=sfxx;
	}

	public String getSfxx(){
		return sfxx;
	}

	public void setYxkzbh(String yxkzbh){
		this.yxkzbh=yxkzbh;
	}

	public String getYxkzbh(){
		return yxkzbh;
	}

	public void setSqtjdqx(String sqtjdqx){
		this.sqtjdqx=sqtjdqx;
	}

	public String getSqtjdqx(){
		return sqtjdqx;
	}

	public void setSqtjdqs(String sqtjdqs){
		this.sqtjdqs=sqtjdqs;
	}

	public String getSqtjdqs(){
		return sqtjdqs;
	}

	public void setYjsj(String yjsj){
		this.yjsj=yjsj;
	}

	public String getYjsj(){
		return yjsj;
	}

	public void setYljgzjxkZjsfzr(String yljgzjxkZjsfzr){
		this.yljgzjxkZjsfzr=yljgzjxkZjsfzr;
	}

	public String getYljgzjxkZjsfzr(){
		return yljgzjxkZjsfzr;
	}

	public void setZzywlx(String zzywlx){
		this.zzywlx=zzywlx;
	}

	public String getZzywlx(){
		return zzywlx;
	}

	public void setDyzt(String dyzt){
		this.dyzt=dyzt;
	}

	public String getDyzt(){
		return dyzt;
	}

	public void setSpxkzbgrq(Date spxkzbgrq){
		this.spxkzbgrq=spxkzbgrq;
	}

	public Date getSpxkzbgrq(){
		return spxkzbgrq;
	}

	public void setBzZb(Integer bzZb){
		this.bzZb=bzZb;
	}

	public Integer getBzZb(){
		return bzZb;
	}

	public void setBzFb(Integer bzFb){
		this.bzFb=bzFb;
	}

	public Integer getBzFb(){
		return bzFb;
	}

	public void setBzMx(Integer bzMx){
		this.bzMx=bzMx;
	}

	public Integer getBzMx(){
		return bzMx;
	}

	public void setQyLocation(String qyLocation){
		this.qyLocation=qyLocation;
	}

	public String getQyLocation(){
		return qyLocation;
	}

	public void setXkzbhXh(String xkzbhXh){
		this.xkzbhXh=xkzbhXh;
	}

	public String getXkzbhXh(){
		return xkzbhXh;
	}

	public void setSpjySfdj(String spjySfdj){
		this.spjySfdj=spjySfdj;
	}

	public String getSpjySfdj(){
		return spjySfdj;
	}

	public void setQrcode(String qrcode){
		this.qrcode=qrcode;
	}

	public String getQrcode(){
		return qrcode;
	}

	public void setTsbz(String tsbz){
		this.tsbz=tsbz;
	}

	public String getTsbz(){
		return tsbz;
	}

	public void setQrcodeId(String qrcodeId){
		this.qrcodeId=qrcodeId;
	}

	public String getQrcodeId(){
		return qrcodeId;
	}

	public void setShzt(String shzt){
		this.shzt=shzt;
	}

	public String getShzt(){
		return shzt;
	}

	public Timestamp getSjc() {
		return sjc;
	}

	public void setSjc(Timestamp sjc) {
		this.sjc = sjc;
	}

}

