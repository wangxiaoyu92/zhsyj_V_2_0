package com.askj.jyjc.dto;

import java.sql.Date;
import java.sql.Timestamp;

public class JyjccydDTO {
/** 检验检测抽样单; InnoDB free: 31744 kB  */
	/** jyjccydid 的中文含义是：检验检测抽样单id*/
	private String jyjccydid;

	/** cydjid 的中文含义是：检验检测抽样登记表id*/
	private String cydjid;

	/** cydbh 的中文含义是：抽样单编号*/
	private String cydbh;

	/** cydno 的中文含义是：抽样单no*/
	private String cydno;

	/** cydjrwly 的中文含义是：任务来源*/
	private String cydjrwly;

	/** cydjrwlb 的中文含义是：任务类别aaa100=cydjrwlb*/
	private String cydjrwlb;

	/** cydjqylx 的中文含义是：区域类型aaa100=cydjqylx*/
	private String cydjqylx;

	/** commc 的中文含义是：单位名称*/
	private String commc;

	/** comdz 的中文含义是：单位地址*/
	private String comdz;

	/** comfrhyz 的中文含义是：法人代表*/
	private String comfrhyz;

	/** comnxse 的中文含义是：年销售额*/
	private String comnxse;

	/** comyyzhh 的中文含义是：营业执照号*/
	private String comyyzhh;

	/** comlxr 的中文含义是：联系人*/
	private String comlxr;

	/** comyddh 的中文含义是：联系电话*/
	private String comyddh;

	/** comcz 的中文含义是：传真*/
	private String comcz;

	/** comyzbm 的中文含义是：邮编*/
	private String comyzbm;

	/** cyddschj 的中文含义是：抽样地点生产环节aaa100=cyddschj*/
	private String cyddschj;

	/** cyddschjcpk 的中文含义是：抽样地点生产环节成品库aaa100=cyddschjcpk*/
	private String cyddschjcpk;

	/** cyddlthj 的中文含义是：抽样地点流通环节aaa100=cyddlthj*/
	private String cyddlthj;

	/** cyddlthjqt 的中文含义是：抽样地点流通环节其他*/
	private String cyddlthjqt;

	/** cyddcyhj 的中文含义是：抽样地点餐饮环节aaa100=cyddcyhj*/
	private String cyddcyhj;

	/** cyddcyhjcg 的中文含义是：抽样地点餐饮环节餐馆aaa100=cyddcyhjcg*/
	private String cyddcyhjcg;

	/** cyddcyhjst 的中文含义是：抽样地点餐饮环节食堂aaa100=cyddcyhjst*/
	private String cyddcyhjst;

	/** cyddcyhjqt 的中文含义是：抽样地点餐饮环节其他*/
	private String cyddcyhjqt;

	/** ypxxyply 的中文含义是：样品信息样品来源aaa100=ypxxyply*/
	private String ypxxyply;

	/** ypxxyplyqt 的中文含义是：样品信息样品来源其他*/
	private String ypxxyplyqt;

	/** ypxxypsx 的中文含义是：样品信息样品属性aaa100=ypxxypsx*/
	private String ypxxypsx;

	/** ypxxyplx 的中文含义是：样品信息样品类型aaa100=ypxxyplx*/
	private String ypxxyplx;

	/** ypxxyplxqt 的中文含义是：样品信息样品类型其他*/
	private String ypxxyplxqt;

	/** jcypid 的中文含义是：检测样品id*/
	private String jcypid;

	/** jcypmc 的中文含义是：检测样品名称*/
	private String jcypmc;

	/** spsb 的中文含义是：检测样品商标*/
	private String spsb;

	/** ypxxscjggjrqlb 的中文含义是：样品信息生产加工购进日期类别aaa100=ypxxscjggjrqlb*/
	private String ypxxscjggjrqlb;

	/** ypxxscjggjrq 的中文含义是：样品信息生产加工购进日期*/
	private String ypxxscjggjrq;

	/** spggxh 的中文含义是：规格型号*/
	private String spggxh;

	/** ypph 的中文含义是：样品批号*/
	private String ypph;

	/** spbzq 的中文含义是：保质期*/
	private String spbzq;

	/** zxbzjswj 的中文含义是：执行标准∕技术文件*/
	private String zxbzjswj;

	/** zldj 的中文含义是：质量等级*/
	private String zldj;

	/** scxkzbh 的中文含义是：生产许可证编号*/
	private String scxkzbh;

	/** spprice 的中文含义是：单价*/
	private String spprice;

	/** sfck 的中文含义是：是否出口aaa100=AAA104，0否1是*/
	private String sfck;

	/** cyjspl 的中文含义是：抽样基数∕批量*/
	private String cyjspl;

	/** cys 的中文含义是：抽样数*/
	private String cys;

	/** bysl 的中文含义是：备样数量*/
	private String bysl;

	/** ypxxypxt 的中文含义是：样品信息样品形态aaa100=ypxxypxt*/
	private String ypxxypxt;

	/** ypxxbzfl 的中文含义是：样品信息包装分类aaa100=ypxxbzfl*/
	private String ypxxbzfl;

	/** sczmc 的中文含义是：标示生产者信息生产者名称*/
	private String sczmc;

	/** sczdz 的中文含义是：标示生产者信息生产者地址*/
	private String sczdz;

	/** sczlxr 的中文含义是：标示生产者信息生产者联系人*/
	private String sczlxr;

	/** sczlxdh 的中文含义是：标示生产者信息生产者联系电话*/
	private String sczlxdh;

	/** cysypdcc 的中文含义是：抽样时样品的存储aaa100=cysypdcc*/
	private String cysypdcc;

	/** cysypdccwd 的中文含义是：抽样时样品的存储温度*/
	private String cysypdccwd;

	/** jsypjzrq 的中文含义是：寄、送样品截止日期*/
	private String jsypjzrq;

	/** jsypdz 的中文含义是：寄送样品地址*/
	private String jsypdz;

	/** cyypbz 的中文含义是：抽样样品包装aaa100=cyypbz*/
	private String cyypbz;

	/** cyfs 的中文含义是：抽样方式aaa100=cyfs*/
	private String cyfs;

	/** cydwmc 的中文含义是：抽样单位名称*/
	private String cydwmc;

	/** cydwdz 的中文含义是：抽样单位地址*/
	private String cydwdz;

	/** cydwlxr 的中文含义是：抽样单位联系人*/
	private String cydwlxr;

	/** cydwlxdh 的中文含义是：抽样单位联系电话*/
	private String cydwlxdh;

	/** cydwcz 的中文含义是：抽样单位传真*/
	private String cydwcz;

	/** cydwyb 的中文含义是：抽样单位邮编*/
	private String cydwyb;

	/** beizhu 的中文含义是：备注*/
	private String beizhu;

	/** bcydwyj 的中文含义是：被抽样单位意见aaa100=bcydwyj*/
	private String bcydwyj;

	/** bcydwqmpic 的中文含义是：被抽样单位签名图片*/
	private String bcydwqmpic;

	/** bcydwqmrq 的中文含义是：被抽样单位签名日期*/
	private String bcydwqmrq;

	/** sczyj 的中文含义是：生产者意见aaa100=bcydwyj*/
	private String sczyj;

	/** sczqmpic 的中文含义是：生产者签名图片*/
	private String sczqmpic;

	/** sczqmrq 的中文含义是：生产者签名日期*/
	private String sczqmrq;

	/** cyrqmpic 的中文含义是：抽样人签名*/
	private String cyrqmpic;

	/** cydwgzpic 的中文含义是：抽样单位盖章*/
	private String cydwgzpic;

	/** cydwgzrq 的中文含义是：抽样单位盖章日期*/
	private String cydwgzrq;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private String aae036;


	public void setJyjccydid(String jyjccydid){
		this.jyjccydid=jyjccydid;
	}

	public String getJyjccydid(){
		return jyjccydid;
	}

	public void setCydjid(String cydjid){
		this.cydjid=cydjid;
	}

	public String getCydjid(){
		return cydjid;
	}

	public void setCydbh(String cydbh){
		this.cydbh=cydbh;
	}

	public String getCydbh(){
		return cydbh;
	}

	public void setCydno(String cydno){
		this.cydno=cydno;
	}

	public String getCydno(){
		return cydno;
	}

	public void setCydjrwly(String cydjrwly){
		this.cydjrwly=cydjrwly;
	}

	public String getCydjrwly(){
		return cydjrwly;
	}

	public void setCydjrwlb(String cydjrwlb){
		this.cydjrwlb=cydjrwlb;
	}

	public String getCydjrwlb(){
		return cydjrwlb;
	}

	public void setCydjqylx(String cydjqylx){
		this.cydjqylx=cydjqylx;
	}

	public String getCydjqylx(){
		return cydjqylx;
	}

	public void setCommc(String commc){
		this.commc=commc;
	}

	public String getCommc(){
		return commc;
	}

	public void setComdz(String comdz){
		this.comdz=comdz;
	}

	public String getComdz(){
		return comdz;
	}

	public void setComfrhyz(String comfrhyz){
		this.comfrhyz=comfrhyz;
	}

	public String getComfrhyz(){
		return comfrhyz;
	}

	public void setComnxse(String comnxse){
		this.comnxse=comnxse;
	}

	public String getComnxse(){
		return comnxse;
	}

	public void setComyyzhh(String comyyzhh){
		this.comyyzhh=comyyzhh;
	}

	public String getComyyzhh(){
		return comyyzhh;
	}

	public void setComlxr(String comlxr){
		this.comlxr=comlxr;
	}

	public String getComlxr(){
		return comlxr;
	}

	public void setComyddh(String comyddh){
		this.comyddh=comyddh;
	}

	public String getComyddh(){
		return comyddh;
	}

	public void setComcz(String comcz){
		this.comcz=comcz;
	}

	public String getComcz(){
		return comcz;
	}

	public void setComyzbm(String comyzbm){
		this.comyzbm=comyzbm;
	}

	public String getComyzbm(){
		return comyzbm;
	}

	public void setCyddschj(String cyddschj){
		this.cyddschj=cyddschj;
	}

	public String getCyddschj(){
		return cyddschj;
	}

	public void setCyddschjcpk(String cyddschjcpk){
		this.cyddschjcpk=cyddschjcpk;
	}

	public String getCyddschjcpk(){
		return cyddschjcpk;
	}

	public void setCyddlthj(String cyddlthj){
		this.cyddlthj=cyddlthj;
	}

	public String getCyddlthj(){
		return cyddlthj;
	}

	public void setCyddlthjqt(String cyddlthjqt){
		this.cyddlthjqt=cyddlthjqt;
	}

	public String getCyddlthjqt(){
		return cyddlthjqt;
	}

	public void setCyddcyhj(String cyddcyhj){
		this.cyddcyhj=cyddcyhj;
	}

	public String getCyddcyhj(){
		return cyddcyhj;
	}

	public void setCyddcyhjcg(String cyddcyhjcg){
		this.cyddcyhjcg=cyddcyhjcg;
	}

	public String getCyddcyhjcg(){
		return cyddcyhjcg;
	}

	public void setCyddcyhjst(String cyddcyhjst){
		this.cyddcyhjst=cyddcyhjst;
	}

	public String getCyddcyhjst(){
		return cyddcyhjst;
	}

	public void setCyddcyhjqt(String cyddcyhjqt){
		this.cyddcyhjqt=cyddcyhjqt;
	}

	public String getCyddcyhjqt(){
		return cyddcyhjqt;
	}

	public void setYpxxyply(String ypxxyply){
		this.ypxxyply=ypxxyply;
	}

	public String getYpxxyply(){
		return ypxxyply;
	}

	public void setYpxxyplyqt(String ypxxyplyqt){
		this.ypxxyplyqt=ypxxyplyqt;
	}

	public String getYpxxyplyqt(){
		return ypxxyplyqt;
	}

	public void setYpxxypsx(String ypxxypsx){
		this.ypxxypsx=ypxxypsx;
	}

	public String getYpxxypsx(){
		return ypxxypsx;
	}

	public void setYpxxyplx(String ypxxyplx){
		this.ypxxyplx=ypxxyplx;
	}

	public String getYpxxyplx(){
		return ypxxyplx;
	}

	public void setYpxxyplxqt(String ypxxyplxqt){
		this.ypxxyplxqt=ypxxyplxqt;
	}

	public String getYpxxyplxqt(){
		return ypxxyplxqt;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setJcypmc(String jcypmc){
		this.jcypmc=jcypmc;
	}

	public String getJcypmc(){
		return jcypmc;
	}

	public void setSpsb(String spsb){
		this.spsb=spsb;
	}

	public String getSpsb(){
		return spsb;
	}

	public void setYpxxscjggjrqlb(String ypxxscjggjrqlb){
		this.ypxxscjggjrqlb=ypxxscjggjrqlb;
	}

	public String getYpxxscjggjrqlb(){
		return ypxxscjggjrqlb;
	}

	public void setYpxxscjggjrq(String ypxxscjggjrq){
		this.ypxxscjggjrq=ypxxscjggjrq;
	}

	public String getYpxxscjggjrq(){
		return ypxxscjggjrq;
	}

	public void setSpggxh(String spggxh){
		this.spggxh=spggxh;
	}

	public String getSpggxh(){
		return spggxh;
	}

	public void setYpph(String ypph){
		this.ypph=ypph;
	}

	public String getYpph(){
		return ypph;
	}

	public void setSpbzq(String spbzq){
		this.spbzq=spbzq;
	}

	public String getSpbzq(){
		return spbzq;
	}

	public void setZxbzjswj(String zxbzjswj){
		this.zxbzjswj=zxbzjswj;
	}

	public String getZxbzjswj(){
		return zxbzjswj;
	}

	public void setZldj(String zldj){
		this.zldj=zldj;
	}

	public String getZldj(){
		return zldj;
	}

	public void setScxkzbh(String scxkzbh){
		this.scxkzbh=scxkzbh;
	}

	public String getScxkzbh(){
		return scxkzbh;
	}

	public void setSpprice(String spprice){
		this.spprice=spprice;
	}

	public String getSpprice(){
		return spprice;
	}

	public void setSfck(String sfck){
		this.sfck=sfck;
	}

	public String getSfck(){
		return sfck;
	}

	public void setCyjspl(String cyjspl){
		this.cyjspl=cyjspl;
	}

	public String getCyjspl(){
		return cyjspl;
	}

	public void setCys(String cys){
		this.cys=cys;
	}

	public String getCys(){
		return cys;
	}

	public void setBysl(String bysl){
		this.bysl=bysl;
	}

	public String getBysl(){
		return bysl;
	}

	public void setYpxxypxt(String ypxxypxt){
		this.ypxxypxt=ypxxypxt;
	}

	public String getYpxxypxt(){
		return ypxxypxt;
	}

	public void setYpxxbzfl(String ypxxbzfl){
		this.ypxxbzfl=ypxxbzfl;
	}

	public String getYpxxbzfl(){
		return ypxxbzfl;
	}

	public void setSczmc(String sczmc){
		this.sczmc=sczmc;
	}

	public String getSczmc(){
		return sczmc;
	}

	public void setSczdz(String sczdz){
		this.sczdz=sczdz;
	}

	public String getSczdz(){
		return sczdz;
	}

	public void setSczlxr(String sczlxr){
		this.sczlxr=sczlxr;
	}

	public String getSczlxr(){
		return sczlxr;
	}

	public void setSczlxdh(String sczlxdh){
		this.sczlxdh=sczlxdh;
	}

	public String getSczlxdh(){
		return sczlxdh;
	}

	public void setCysypdcc(String cysypdcc){
		this.cysypdcc=cysypdcc;
	}

	public String getCysypdcc(){
		return cysypdcc;
	}

	public void setCysypdccwd(String cysypdccwd){
		this.cysypdccwd=cysypdccwd;
	}

	public String getCysypdccwd(){
		return cysypdccwd;
	}

	public void setJsypjzrq(String jsypjzrq){
		this.jsypjzrq=jsypjzrq;
	}

	public String getJsypjzrq(){
		return jsypjzrq;
	}

	public void setJsypdz(String jsypdz){
		this.jsypdz=jsypdz;
	}

	public String getJsypdz(){
		return jsypdz;
	}

	public void setCyypbz(String cyypbz){
		this.cyypbz=cyypbz;
	}

	public String getCyypbz(){
		return cyypbz;
	}

	public void setCyfs(String cyfs){
		this.cyfs=cyfs;
	}

	public String getCyfs(){
		return cyfs;
	}

	public void setCydwmc(String cydwmc){
		this.cydwmc=cydwmc;
	}

	public String getCydwmc(){
		return cydwmc;
	}

	public void setCydwdz(String cydwdz){
		this.cydwdz=cydwdz;
	}

	public String getCydwdz(){
		return cydwdz;
	}

	public void setCydwlxr(String cydwlxr){
		this.cydwlxr=cydwlxr;
	}

	public String getCydwlxr(){
		return cydwlxr;
	}

	public void setCydwlxdh(String cydwlxdh){
		this.cydwlxdh=cydwlxdh;
	}

	public String getCydwlxdh(){
		return cydwlxdh;
	}

	public void setCydwcz(String cydwcz){
		this.cydwcz=cydwcz;
	}

	public String getCydwcz(){
		return cydwcz;
	}

	public void setCydwyb(String cydwyb){
		this.cydwyb=cydwyb;
	}

	public String getCydwyb(){
		return cydwyb;
	}

	public void setBeizhu(String beizhu){
		this.beizhu=beizhu;
	}

	public String getBeizhu(){
		return beizhu;
	}

	public void setBcydwyj(String bcydwyj){
		this.bcydwyj=bcydwyj;
	}

	public String getBcydwyj(){
		return bcydwyj;
	}

	public void setBcydwqmpic(String bcydwqmpic){
		this.bcydwqmpic=bcydwqmpic;
	}

	public String getBcydwqmpic(){
		return bcydwqmpic;
	}

	public void setBcydwqmrq(String bcydwqmrq){
		this.bcydwqmrq=bcydwqmrq;
	}

	public String getBcydwqmrq(){
		return bcydwqmrq;
	}

	public void setSczyj(String sczyj){
		this.sczyj=sczyj;
	}

	public String getSczyj(){
		return sczyj;
	}

	public void setSczqmpic(String sczqmpic){
		this.sczqmpic=sczqmpic;
	}

	public String getSczqmpic(){
		return sczqmpic;
	}

	public void setSczqmrq(String sczqmrq){
		this.sczqmrq=sczqmrq;
	}

	public String getSczqmrq(){
		return sczqmrq;
	}

	public void setCyrqmpic(String cyrqmpic){
		this.cyrqmpic=cyrqmpic;
	}

	public String getCyrqmpic(){
		return cyrqmpic;
	}

	public void setCydwgzpic(String cydwgzpic){
		this.cydwgzpic=cydwgzpic;
	}

	public String getCydwgzpic(){
		return cydwgzpic;
	}

	public void setCydwgzrq(String cydwgzrq){
		this.cydwgzrq=cydwgzrq;
	}

	public String getCydwgzrq(){
		return cydwgzrq;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(String aae036){
		this.aae036=aae036;
	}

	public String getAae036(){
		return aae036;
	}

}

