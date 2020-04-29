package com.askj.jyjc.dto;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;

import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  JYJCYP的中文含义是: 检验检测样品; InnoDB free: 2757632 kBDTO
 * @Creation     2016/05/05 10:17:39
 * @Written      Create Tool By zjf 
 **/
public class JyjcypDTO {
	/** 检验检测样品; InnoDB free: 231424 kB  */
	/** querykind 的中文含义是：querykind 查询数据类型 空或0 不加其他条件 为1 加只查本企业商品*/
	private String querykind;	
	
	/** parentid 的中文含义是：构建产品数*/
	private String parentid;	
	//是否父节点,非映射字段
	private boolean isparent;
	//是否展开,非映射字段
	private boolean isopen;		
		
	/** sppicpath 的中文含义是：商品图片路径*/
	private String sppicpath;
	/** sppicname 的中文含义是：商品图片名称*/
	private String sppicname;	
	
	/** jcypid 的中文含义是：检测样品ID*/
	private String jcypid;

	/** jcyplb 的中文含义是：检查样品类别,见AA10表JCYPLB*/
	private String jcyplb;

	/** jcypbh 的中文含义是：商品编号*/
	private String jcypbh;

	/** jcypmc 的中文含义是：检查样品名称*/
	private String jcypmc;

	/** jcypjc 的中文含义是：商品简称*/
	private String jcypjc;

	/** jcypczy 的中文含义是：操作员*/
	private String jcypczy;

	/** jcypczsj 的中文含义是：操作时间*/
	private Timestamp jcypczsj;

	/** jcypgl 的中文含义是：商品归类aaa100=jcypgl*/
	private String jcypgl;

	/** jcypsspp 的中文含义是：所属品牌*/
	private String jcypsspp;

	/** impcpgg 的中文含义是：规格*/
	private String impcpgg;

	/** spsb 的中文含义是：商品商标*/
	private String spsb;

	/** spggxh 的中文含义是：商品规格型号*/
	private String spggxh;

	/** spjldw 的中文含义是：商品计量单位*/
	private String spjldw;

	/** spzxbzh 的中文含义是：商品执行标准号*/
	private String spzxbzh;

	/** spbzq 的中文含义是：商品保质期*/
	private String spbzq;

	/** jcyptp 的中文含义是：检查样品图片*/
	private String jcyptp;

	/** jcyptpwjm 的中文含义是：检查样品图片文件名*/
	private String jcyptpwjm;
	
	/** spfenlei 的中文含义是：商品分类aaa100=spfenlei*/
	private String spfenlei;
	
	/** spsjlx 的中文含义是：商品数据类型aaa100=spsjlx0商品1生产企业产品2生产企业原材料*/
	private String spsjlx;
	
	/** hviewjgztid 的中文含义是：监管主体表主键,生产企业设置自己的产品或原料时用到*/
	private String hviewjgztid;
	
	/** userid 的中文含义是：操作员id控制编辑和删除用*/
	private String userid;	
	
	public String getJcypid() {
		return jcypid;
	}

	public void setJcypid(String jcypid) {
		this.jcypid = jcypid;
	}

	public String getJcyplb() {
		return jcyplb;
	}

	public void setJcyplb(String jcyplb) {
		this.jcyplb = jcyplb;
	}

	public String getJcypbh() {
		return jcypbh;
	}

	public void setJcypbh(String jcypbh) {
		this.jcypbh = jcypbh;
	}

	public String getJcypmc() {
		return jcypmc;
	}

	public void setJcypmc(String jcypmc) {
		this.jcypmc = jcypmc;
	}

	public String getJcypjc() {
		return jcypjc;
	}

	public void setJcypjc(String jcypjc) {
		this.jcypjc = jcypjc;
	}

	public String getJcypczy() {
		return jcypczy;
	}

	public void setJcypczy(String jcypczy) {
		this.jcypczy = jcypczy;
	}

	public Timestamp getJcypczsj() {
		return jcypczsj;
	}

	public void setJcypczsj(Timestamp jcypczsj) {
		this.jcypczsj = jcypczsj;
	}

	public String getJcypgl() {
		return jcypgl;
	}

	public void setJcypgl(String jcypgl) {
		this.jcypgl = jcypgl;
	}

	public String getJcypsspp() {
		return jcypsspp;
	}

	public void setJcypsspp(String jcypsspp) {
		this.jcypsspp = jcypsspp;
	}

	public String getImpcpgg() {
		return impcpgg;
	}

	public void setImpcpgg(String impcpgg) {
		this.impcpgg = impcpgg;
	}

	public String getSpsb() {
		return spsb;
	}

	public void setSpsb(String spsb) {
		this.spsb = spsb;
	}

	public String getSpggxh() {
		return spggxh;
	}

	public void setSpggxh(String spggxh) {
		this.spggxh = spggxh;
	}

	public String getSpjldw() {
		return spjldw;
	}

	public void setSpjldw(String spjldw) {
		this.spjldw = spjldw;
	}

	public String getSpzxbzh() {
		return spzxbzh;
	}

	public void setSpzxbzh(String spzxbzh) {
		this.spzxbzh = spzxbzh;
	}

	public String getSpbzq() {
		return spbzq;
	}

	public void setSpbzq(String spbzq) {
		this.spbzq = spbzq;
	}

	public String getJcyptp() {
		return jcyptp;
	}

	public void setJcyptp(String jcyptp) {
		this.jcyptp = jcyptp;
	}

	public String getJcyptpwjm() {
		return jcyptpwjm;
	}

	public void setJcyptpwjm(String jcyptpwjm) {
		this.jcyptpwjm = jcyptpwjm;
	}

	public String getSppicpath() {
		return sppicpath;
	}

	public void setSppicpath(String sppicpath) {
		this.sppicpath = sppicpath;
	}

	public String getSppicname() {
		return sppicname;
	}

	public void setSppicname(String sppicname) {
		this.sppicname = sppicname;
	}

	public String getSpfenlei() {
		return spfenlei;
	}

	public void setSpfenlei(String spfenlei) {
		this.spfenlei = spfenlei;
	}

	public String getSpsjlx() {
		return spsjlx;
	}

	public void setSpsjlx(String spsjlx) {
		this.spsjlx = spsjlx;
	}

	public String getHviewjgztid() {
		return hviewjgztid;
	}

	public void setHviewjgztid(String hviewjgztid) {
		this.hviewjgztid = hviewjgztid;
	}

	public String getQuerykind() {
		return querykind;
	}

	public void setQuerykind(String querykind) {
		this.querykind = querykind;
	}

	public String getParentid() {
		return parentid;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}

	public boolean isIsparent() {
		return isparent;
	}

	public void setIsparent(boolean isparent) {
		this.isparent = isparent;
	}

	public boolean isIsopen() {
		return isopen;
	}

	public void setIsopen(boolean isopen) {
		this.isopen = isopen;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
	
}