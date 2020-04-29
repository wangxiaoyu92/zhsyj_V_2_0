package com.askj.zfba.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  ZFWSCFKYJDS12的中文含义是: 查封扣押决定书; InnoDB free: 2723840 kB
 * @Creation     2016/06/02 18:25:23
 * @Written      Create Tool By zjf 
 **/
@Table(value = "ZFWSCFKYJDS12")
public class Zfwscfkyjds12 {
	/**
	 * @Description cfkyjdsid的中文含义是： 查封扣押决定书ID
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_cfkyjdsid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_cfkyjdsid.nextval from dual"))
	private String cfkyjdsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	@Column
	private String ajdjid;

	/**
	 * @Description cfkyflmc的中文含义是： 查封扣押物品法律名称
	 */
	@Column
	private String cfkyflmc;

	/**
	 * @Description cfkyflt的中文含义是： 条
	 */
	@Column
	private String cfkyflt;

	/**
	 * @Description cfkyflk的中文含义是： 款
	 */
	@Column
	private String cfkyflk;

	/**
	 * @Description cfkyflx的中文含义是： 项
	 */
	@Column
	private String cfkyflx;

	/**
	 * @Description cfkysxczwt的中文含义是： 涉嫌存在问题
	 */
	@Column
	private String cfkysxczwt;

	/**
	 * @Description cfkybcdd的中文含义是： 保存地点
	 */
	@Column
	private String cfkybcdd;

	/**
	 * @Description cfkybctj的中文含义是： 保存条件
	 */
	@Column
	private String cfkybctj;

	/**
	 * @Description cfkygzrq的中文含义是： 盖章日期
	 */
	@Column
	private String cfkygzrq;

	/**
	 * @Description cfkyksrq的中文含义是： 查封扣押开始日期
	 */
	@Column
	private String cfkyksrq;

	/**
	 * @Description cfkyjsrq的中文含义是： 查封扣押结束日期
	 */
	@Column
	private String cfkyjsrq;

	/**
	 * @Description cfkywsbh的中文含义是： 文书编号
	 */
	@Column
	private String cfkywsbh;

	/**
	 * @Description cfkydsr的中文含义是： 当事人
	 */
	@Column
	private String cfkydsr;

	/**
	 * @Description cfkyfddbr的中文含义是： 法定代表人(负责人)
	 */
	@Column
	private String cfkyfddbr;

	/**
	 * @Description cfkydz的中文含义是： 地址
	 */
	@Column
	private String cfkydz;

	/**
	 * @Description cfkylxfs的中文含义是： 联系方式
	 */
	@Column
	private String cfkylxfs;

	/**
	 * @Description cfkyndwhr的中文含义是： 你单位（人）
	 */
	@Column
	private String cfkyndwhr;

	/**
	 * @Description cfkywpqdwsbh的中文含义是： 查封扣押物品清单文书编号
	 */
	@Column
	private String cfkywpqdwsbh;

	/**
	 * @Description cfkyyfxsyj的中文含义是： 依法向食药局
	 */
	@Column
	private String cfkyyfxsyj;

	/**
	 * @Description cfkyyfxrmzf的中文含义是： 依法向人民政府
	 */
	@Column
	private String cfkyyfxrmzf;

	/**
	 * @Description cfkyyfxrmfy的中文含义是： 依法向人民法院
	 */
	@Column
	private String cfkyyfxrmfy;

	
		/**
	 * @Description cfkyjdsid的中文含义是： 查封扣押决定书ID
	 */
	public void setCfkyjdsid(String cfkyjdsid){ 
		this.cfkyjdsid = cfkyjdsid;
	}
	/**
	 * @Description cfkyjdsid的中文含义是： 查封扣押决定书ID
	 */
	public String getCfkyjdsid(){
		return cfkyjdsid;
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
	 * @Description cfkyflmc的中文含义是： 查封扣押物品法律名称
	 */
	public void setCfkyflmc(String cfkyflmc){ 
		this.cfkyflmc = cfkyflmc;
	}
	/**
	 * @Description cfkyflmc的中文含义是： 查封扣押物品法律名称
	 */
	public String getCfkyflmc(){
		return cfkyflmc;
	}
	/**
	 * @Description cfkyflt的中文含义是： 条
	 */
	public void setCfkyflt(String cfkyflt){ 
		this.cfkyflt = cfkyflt;
	}
	/**
	 * @Description cfkyflt的中文含义是： 条
	 */
	public String getCfkyflt(){
		return cfkyflt;
	}
	/**
	 * @Description cfkyflk的中文含义是： 款
	 */
	public void setCfkyflk(String cfkyflk){ 
		this.cfkyflk = cfkyflk;
	}
	/**
	 * @Description cfkyflk的中文含义是： 款
	 */
	public String getCfkyflk(){
		return cfkyflk;
	}
	/**
	 * @Description cfkyflx的中文含义是： 项
	 */
	public void setCfkyflx(String cfkyflx){ 
		this.cfkyflx = cfkyflx;
	}
	/**
	 * @Description cfkyflx的中文含义是： 项
	 */
	public String getCfkyflx(){
		return cfkyflx;
	}
	/**
	 * @Description cfkysxczwt的中文含义是： 涉嫌存在问题
	 */
	public void setCfkysxczwt(String cfkysxczwt){ 
		this.cfkysxczwt = cfkysxczwt;
	}
	/**
	 * @Description cfkysxczwt的中文含义是： 涉嫌存在问题
	 */
	public String getCfkysxczwt(){
		return cfkysxczwt;
	}
	/**
	 * @Description cfkybcdd的中文含义是： 保存地点
	 */
	public void setCfkybcdd(String cfkybcdd){ 
		this.cfkybcdd = cfkybcdd;
	}
	/**
	 * @Description cfkybcdd的中文含义是： 保存地点
	 */
	public String getCfkybcdd(){
		return cfkybcdd;
	}
	/**
	 * @Description cfkybctj的中文含义是： 保存条件
	 */
	public void setCfkybctj(String cfkybctj){ 
		this.cfkybctj = cfkybctj;
	}
	/**
	 * @Description cfkybctj的中文含义是： 保存条件
	 */
	public String getCfkybctj(){
		return cfkybctj;
	}
	/**
	 * @Description cfkygzrq的中文含义是： 盖章日期
	 */
	public void setCfkygzrq(String cfkygzrq){ 
		this.cfkygzrq = cfkygzrq;
	}
	/**
	 * @Description cfkygzrq的中文含义是： 盖章日期
	 */
	public String getCfkygzrq(){
		return cfkygzrq;
	}
	/**
	 * @Description cfkyksrq的中文含义是： 查封扣押开始日期
	 */
	public void setCfkyksrq(String cfkyksrq){ 
		this.cfkyksrq = cfkyksrq;
	}
	/**
	 * @Description cfkyksrq的中文含义是： 查封扣押开始日期
	 */
	public String getCfkyksrq(){
		return cfkyksrq;
	}
	/**
	 * @Description cfkyjsrq的中文含义是： 查封扣押结束日期
	 */
	public void setCfkyjsrq(String cfkyjsrq){ 
		this.cfkyjsrq = cfkyjsrq;
	}
	/**
	 * @Description cfkyjsrq的中文含义是： 查封扣押结束日期
	 */
	public String getCfkyjsrq(){
		return cfkyjsrq;
	}
	/**
	 * @Description cfkywsbh的中文含义是： 文书编号
	 */
	public void setCfkywsbh(String cfkywsbh){ 
		this.cfkywsbh = cfkywsbh;
	}
	/**
	 * @Description cfkywsbh的中文含义是： 文书编号
	 */
	public String getCfkywsbh(){
		return cfkywsbh;
	}
	/**
	 * @Description cfkydsr的中文含义是： 当事人
	 */
	public void setCfkydsr(String cfkydsr){ 
		this.cfkydsr = cfkydsr;
	}
	/**
	 * @Description cfkydsr的中文含义是： 当事人
	 */
	public String getCfkydsr(){
		return cfkydsr;
	}
	/**
	 * @Description cfkyfddbr的中文含义是： 法定代表人(负责人)
	 */
	public void setCfkyfddbr(String cfkyfddbr){ 
		this.cfkyfddbr = cfkyfddbr;
	}
	/**
	 * @Description cfkyfddbr的中文含义是： 法定代表人(负责人)
	 */
	public String getCfkyfddbr(){
		return cfkyfddbr;
	}
	/**
	 * @Description cfkydz的中文含义是： 地址
	 */
	public void setCfkydz(String cfkydz){ 
		this.cfkydz = cfkydz;
	}
	/**
	 * @Description cfkydz的中文含义是： 地址
	 */
	public String getCfkydz(){
		return cfkydz;
	}
	/**
	 * @Description cfkylxfs的中文含义是： 联系方式
	 */
	public void setCfkylxfs(String cfkylxfs){ 
		this.cfkylxfs = cfkylxfs;
	}
	/**
	 * @Description cfkylxfs的中文含义是： 联系方式
	 */
	public String getCfkylxfs(){
		return cfkylxfs;
	}
	/**
	 * @Description cfkyndwhr的中文含义是： 你单位（人）
	 */
	public void setCfkyndwhr(String cfkyndwhr){ 
		this.cfkyndwhr = cfkyndwhr;
	}
	/**
	 * @Description cfkyndwhr的中文含义是： 你单位（人）
	 */
	public String getCfkyndwhr(){
		return cfkyndwhr;
	}
	/**
	 * @Description cfkywpqdwsbh的中文含义是： 查封扣押物品清单文书编号
	 */
	public void setCfkywpqdwsbh(String cfkywpqdwsbh){ 
		this.cfkywpqdwsbh = cfkywpqdwsbh;
	}
	/**
	 * @Description cfkywpqdwsbh的中文含义是： 查封扣押物品清单文书编号
	 */
	public String getCfkywpqdwsbh(){
		return cfkywpqdwsbh;
	}
	/**
	 * @Description cfkyyfxsyj的中文含义是： 依法向食药局
	 */
	public void setCfkyyfxsyj(String cfkyyfxsyj){ 
		this.cfkyyfxsyj = cfkyyfxsyj;
	}
	/**
	 * @Description cfkyyfxsyj的中文含义是： 依法向食药局
	 */
	public String getCfkyyfxsyj(){
		return cfkyyfxsyj;
	}
	/**
	 * @Description cfkyyfxrmzf的中文含义是： 依法向人民政府
	 */
	public void setCfkyyfxrmzf(String cfkyyfxrmzf){ 
		this.cfkyyfxrmzf = cfkyyfxrmzf;
	}
	/**
	 * @Description cfkyyfxrmzf的中文含义是： 依法向人民政府
	 */
	public String getCfkyyfxrmzf(){
		return cfkyyfxrmzf;
	}
	/**
	 * @Description cfkyyfxrmfy的中文含义是： 依法向人民法院
	 */
	public void setCfkyyfxrmfy(String cfkyyfxrmfy){ 
		this.cfkyyfxrmfy = cfkyyfxrmfy;
	}
	/**
	 * @Description cfkyyfxrmfy的中文含义是： 依法向人民法院
	 */
	public String getCfkyyfxrmfy(){
		return cfkyyfxrmfy;
	}

	
}