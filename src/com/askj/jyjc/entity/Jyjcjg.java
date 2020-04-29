package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.*;
import org.nutz.dao.DB;
import java.sql.Date;
import java.sql.Timestamp;
import java.math.BigDecimal;

/**
 * @Description  JYJCJG的中文含义是: 检验检测结果表; InnoDB free: 9216 kB
 * @Creation     2016/10/20 16:57:52
 * @Written      Create Tool By zjf 
 **/
@Table(value = "JYJCJG")
public class Jyjcjg {
	/**
	 * @Description jcjgid的中文含义是： 
	 */
	@Column
	@Name
	//@Prev(@SQL(db=DB.MYSQL,value="select nextval('sq_jcjgid')"))
	//@Prev(@SQL(db=DB.ORACLE,value="select sq_jcjgid.nextval from dual"))
	private String jcjgid;
	
	/**
	 * @Description comid 的中文含义是： 
	 */
	@Column
	private String comid ;	
	
	/**
	 * @Description jcypid 的中文含义是： 
	 */
	@Column
	private String jcypid ;
	
	/**
	 * @Description jcxmid的中文含义是： 
	 */
	@Column
	private String jcxmid;
	/**
	 * @Description jcxmid的中文含义是：
	 */
	@Column
	private String jcztbzjid;
	/**
	 * @Description jcjylb的中文含义是： 
	 */
	@Column
	private String jcjylb;

	/**
	 * @Description jcxmbzz的中文含义是： 
	 */
	@Column
	private String jcxmbzz;

	/**
	 * @Description jcczsj的中文含义是： 
	 */
	@Column
	private String jcczsj;

	/**
	 * @Description fjjg的中文含义是： 
	 */
	@Column
	private String fjjg;

	/**
	 * @Description jcjyshbz的中文含义是： 
	 */
	@Column
	private String jcjyshbz;

	/**
	 * @Description jcjycljg的中文含义是： 
	 */
	@Column
	private String jcjycljg;

	/**
	 * @Description impyqlb的中文含义是： 
	 */
	@Column
	private String impyqlb;

	/**
	 * @Description impbh的中文含义是： 
	 */
	@Column
	private String impbh;

	/**
	 * @Description impypzl的中文含义是： 
	 */
	@Column
	private String impypzl;

	/**
	 * @Description impypmc的中文含义是： 
	 */
	@Column
	private String impypmc;

	/**
	 * @Description impjcxm的中文含义是： 
	 */
	@Column
	private String impjcxm;

	/**
	 * @Description imphl的中文含义是： 
	 */
	@Column
	private String imphl;

	/**
	 * @Description impjcjg的中文含义是： 
	 */
	@Column
	private String impjcjg;

	/**
	 * @Description impssqy的中文含义是： 
	 */
	@Column
	private String impssqy;

	/**
	 * @Description impyhmc的中文含义是： 
	 */
	@Column
	private String impyhmc;

	/**
	 * @Description impbjqy的中文含义是： 
	 */
	@Column
	private String impbjqy;

	/**
	 * @Description impcpsb的中文含义是： 
	 */
	@Column
	private String impcpsb;

	/**
	 * @Description impcppc的中文含义是： 
	 */
	@Column
	private String impcppc;

	/**
	 * @Description impcpgg的中文含义是： 
	 */
	@Column
	private String impcpgg;

	/**
	 * @Description impsccj的中文含义是： 
	 */
	@Column
	private String impsccj;

	/**
	 * @Description impcysj的中文含义是： 
	 */
	@Column
	private String impcysj;

	/**
	 * @Description impjcsj的中文含义是： 
	 */
	@Column
	private String impjcsj;

	/**
	 * @Description impjcry的中文含义是： 
	 */
	@Column
	private String impjcry;

	/**
	 * @Description impbz的中文含义是： 
	 */
	@Column
	private String impbz;

	/**
	 * @Description impbc1的中文含义是： 
	 */
	@Column
	private String impbc1;

	/**
	 * @Description impbc2的中文含义是： 
	 */
	@Column
	private String impbc2;

	/**
	 * @Description imprkrq的中文含义是： 
	 */
	@Column
	private String imprkrq;

	/**
	 * @Description impbatchno的中文含义是： 
	 */
	@Column
	private String impbatchno;

	/**
	 * @Description impczy的中文含义是： 
	 */
	//@Column
	//private String impczy;

	/**
	 * @Description impczsj的中文含义是： 
	 */
	//@Column
	//private String impczsj;
	
	/**
	 * @Description userid的中文含义是： 操作员id
	 */
	//@Column
	//private String userid;	

	
		/**
	 * @Description jcjgid的中文含义是： 
	 */
	public void setJcjgid(String jcjgid){ 
		this.jcjgid = jcjgid;
	}
	/**
	 * @Description jcjgid的中文含义是： 
	 */
	public String getJcjgid(){
		return jcjgid;
	}
	/**
	 * @Description jcjylb的中文含义是： 
	 */
	public void setJcjylb(String jcjylb){ 
		this.jcjylb = jcjylb;
	}
	/**
	 * @Description jcjylb的中文含义是： 
	 */
	public String getJcjylb(){
		return jcjylb;
	}
	/**
	 * @Description jcxmbzz的中文含义是： 
	 */
	public void setJcxmbzz(String jcxmbzz){ 
		this.jcxmbzz = jcxmbzz;
	}
	/**
	 * @Description jcxmbzz的中文含义是： 
	 */
	public String getJcxmbzz(){
		return jcxmbzz;
	}
	/**
	 * @Description jcczsj的中文含义是： 
	 */
	public void setJcczsj(String jcczsj){ 
		this.jcczsj = jcczsj;
	}
	/**
	 * @Description jcczsj的中文含义是： 
	 */
	public String getJcczsj(){
		return jcczsj;
	}
	/**
	 * @Description fjjg的中文含义是： 
	 */
	public void setFjjg(String fjjg){ 
		this.fjjg = fjjg;
	}
	/**
	 * @Description fjjg的中文含义是： 
	 */
	public String getFjjg(){
		return fjjg;
	}
	/**
	 * @Description jcjyshbz的中文含义是： 
	 */
	public void setJcjyshbz(String jcjyshbz){ 
		this.jcjyshbz = jcjyshbz;
	}
	/**
	 * @Description jcjyshbz的中文含义是： 
	 */
	public String getJcjyshbz(){
		return jcjyshbz;
	}
	/**
	 * @Description jcjycljg的中文含义是： 
	 */
	public void setJcjycljg(String jcjycljg){ 
		this.jcjycljg = jcjycljg;
	}
	/**
	 * @Description jcjycljg的中文含义是： 
	 */
	public String getJcjycljg(){
		return jcjycljg;
	}
	/**
	 * @Description impyqlb的中文含义是： 
	 */
	public void setImpyqlb(String impyqlb){ 
		this.impyqlb = impyqlb;
	}
	/**
	 * @Description impyqlb的中文含义是： 
	 */
	public String getImpyqlb(){
		return impyqlb;
	}
	/**
	 * @Description impbh的中文含义是： 
	 */
	public void setImpbh(String impbh){ 
		this.impbh = impbh;
	}
	/**
	 * @Description impbh的中文含义是： 
	 */
	public String getImpbh(){
		return impbh;
	}
	/**
	 * @Description impypzl的中文含义是： 
	 */
	public void setImpypzl(String impypzl){ 
		this.impypzl = impypzl;
	}
	/**
	 * @Description impypzl的中文含义是： 
	 */
	public String getImpypzl(){
		return impypzl;
	}
	/**
	 * @Description impypmc的中文含义是： 
	 */
	public void setImpypmc(String impypmc){ 
		this.impypmc = impypmc;
	}
	/**
	 * @Description impypmc的中文含义是： 
	 */
	public String getImpypmc(){
		return impypmc;
	}
	/**
	 * @Description impjcxm的中文含义是： 
	 */
	public void setImpjcxm(String impjcxm){ 
		this.impjcxm = impjcxm;
	}
	/**
	 * @Description impjcxm的中文含义是： 
	 */
	public String getImpjcxm(){
		return impjcxm;
	}
	/**
	 * @Description imphl的中文含义是： 
	 */
	public void setImphl(String imphl){ 
		this.imphl = imphl;
	}
	/**
	 * @Description imphl的中文含义是： 
	 */
	public String getImphl(){
		return imphl;
	}
	/**
	 * @Description impjcjg的中文含义是： 
	 */
	public void setImpjcjg(String impjcjg){ 
		this.impjcjg = impjcjg;
	}
	/**
	 * @Description impjcjg的中文含义是： 
	 */
	public String getImpjcjg(){
		return impjcjg;
	}
	/**
	 * @Description impssqy的中文含义是： 
	 */
	public void setImpssqy(String impssqy){ 
		this.impssqy = impssqy;
	}
	/**
	 * @Description impssqy的中文含义是： 
	 */
	public String getImpssqy(){
		return impssqy;
	}
	/**
	 * @Description impyhmc的中文含义是： 
	 */
	public void setImpyhmc(String impyhmc){ 
		this.impyhmc = impyhmc;
	}
	/**
	 * @Description impyhmc的中文含义是： 
	 */
	public String getImpyhmc(){
		return impyhmc;
	}
	/**
	 * @Description impbjqy的中文含义是： 
	 */
	public void setImpbjqy(String impbjqy){ 
		this.impbjqy = impbjqy;
	}
	/**
	 * @Description impbjqy的中文含义是： 
	 */
	public String getImpbjqy(){
		return impbjqy;
	}
	/**
	 * @Description impcpsb的中文含义是： 
	 */
	public void setImpcpsb(String impcpsb){ 
		this.impcpsb = impcpsb;
	}
	/**
	 * @Description impcpsb的中文含义是： 
	 */
	public String getImpcpsb(){
		return impcpsb;
	}
	/**
	 * @Description impcppc的中文含义是： 
	 */
	public void setImpcppc(String impcppc){ 
		this.impcppc = impcppc;
	}
	/**
	 * @Description impcppc的中文含义是： 
	 */
	public String getImpcppc(){
		return impcppc;
	}
	/**
	 * @Description impcpgg的中文含义是： 
	 */
	public void setImpcpgg(String impcpgg){ 
		this.impcpgg = impcpgg;
	}
	/**
	 * @Description impcpgg的中文含义是： 
	 */
	public String getImpcpgg(){
		return impcpgg;
	}
	/**
	 * @Description impsccj的中文含义是： 
	 */
	public void setImpsccj(String impsccj){ 
		this.impsccj = impsccj;
	}
	/**
	 * @Description impsccj的中文含义是： 
	 */
	public String getImpsccj(){
		return impsccj;
	}
	/**
	 * @Description impcysj的中文含义是： 
	 */
	public void setImpcysj(String impcysj){ 
		this.impcysj = impcysj;
	}
	/**
	 * @Description impcysj的中文含义是： 
	 */
	public String getImpcysj(){
		return impcysj;
	}
	/**
	 * @Description impjcsj的中文含义是： 
	 */
	public void setImpjcsj(String impjcsj){ 
		this.impjcsj = impjcsj;
	}
	/**
	 * @Description impjcsj的中文含义是： 
	 */
	public String getImpjcsj(){
		return impjcsj;
	}
	/**
	 * @Description impjcry的中文含义是： 
	 */
	public void setImpjcry(String impjcry){ 
		this.impjcry = impjcry;
	}
	/**
	 * @Description impjcry的中文含义是： 
	 */
	public String getImpjcry(){
		return impjcry;
	}
	/**
	 * @Description impbz的中文含义是： 
	 */
	public void setImpbz(String impbz){ 
		this.impbz = impbz;
	}
	/**
	 * @Description impbz的中文含义是： 
	 */
	public String getImpbz(){
		return impbz;
	}
	/**
	 * @Description impbc1的中文含义是： 
	 */
	public void setImpbc1(String impbc1){ 
		this.impbc1 = impbc1;
	}
	/**
	 * @Description impbc1的中文含义是： 
	 */
	public String getImpbc1(){
		return impbc1;
	}
	/**
	 * @Description impbc2的中文含义是： 
	 */
	public void setImpbc2(String impbc2){ 
		this.impbc2 = impbc2;
	}
	/**
	 * @Description impbc2的中文含义是： 
	 */
	public String getImpbc2(){
		return impbc2;
	}
	/**
	 * @Description imprkrq的中文含义是： 
	 */
	public void setImprkrq(String imprkrq){ 
		this.imprkrq = imprkrq;
	}
	/**
	 * @Description imprkrq的中文含义是： 
	 */
	public String getImprkrq(){
		return imprkrq;
	}
	/**
	 * @Description impbatchno的中文含义是： 
	 */
	public void setImpbatchno(String impbatchno){ 
		this.impbatchno = impbatchno;
	}
	/**
	 * @Description impbatchno的中文含义是： 
	 */
	public String getImpbatchno(){
		return impbatchno;
	}
	public String getJcypid() {
		return jcypid;
	}
	public void setJcypid(String jcypid) {
		this.jcypid = jcypid;
	}
	public String getJcxmid() {
		return jcxmid;
	}
	public void setJcxmid(String jcxmid) {
		this.jcxmid = jcxmid;
	}
	public String getComid() {
		return comid;
	}
	public void setComid(String comid) {
		this.comid = comid;
	}

	public String getJcztbzjid() {
		return jcztbzjid;
	}

	public void setJcztbzjid(String jcztbzjid) {
		this.jcztbzjid = jcztbzjid;
	}
}