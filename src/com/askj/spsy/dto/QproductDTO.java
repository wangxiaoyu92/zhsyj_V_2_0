package com.askj.spsy.dto;

import java.math.BigDecimal;

public class QproductDTO {
	
	//产品图片路径
	private String cppicpath;	
	
	//是否父节点,非映射字段
	private boolean isparent;
	//是否展开,非映射字段
	private boolean isopen;
	

	private int parentid;
	
	private int num;
	/**
	 * @Description fjpath的中文含义是： 附件保存路径（手动添加），对应fj表保存路径
	 */
	private String fjpath;
	public String getFjpath() {
		return fjpath;
	}
	public void setFjpath(String fjpath) {
		this.fjpath = fjpath;
	}
	/**
	 * @Description cphyclid的中文含义是：产品或原材料id
	 */ 
	private String cphyclid;
	public String getCphyclid() {
		return cphyclid;
	}
	public void setCphyclid(String cphyclid) {
		this.cphyclid = cphyclid;
	}
	/**
	 * @Description qjhkchzb的中文含义是：库存汇总id
	 */ 
	private String qjhkchzb;	
	/**
	 * @Description jhkcjhsl的中文含义是：进货数量
	 */ 
	private String jhkcjhsl;	
	/**
	 * @Description jhkcchsl的中文含义是：出货数量
	 */ 
	private String jhkcchsl;	
	/**
	 * @Description jhkcjysl的中文含义是： 结余数量
	 */ 
	private String jhkcjysl;	
	/**
	 * @Description procjdh的中文含义是： 厂家电话
	 */ 
	private String procjdh;	 
	
	/**
	 * @Description procjdz的中文含义是： 厂家地址
	 */ 
	private String procjdz;		
	
	/**
	 * @Description cppcpch的中文含义是： 商品批次号
	 */ 
	private String cppcpch;
	/**
	 * @Description cppcscrq的中文含义是： 商品生产日期
	 */ 
	private String cppcscrq;
	/**
	 * @Description cppcscsl的中文含义是： 商品生产数量
	 */ 
	private String cppcscsl;
	/**
	 * @Description cppcscdwdmstr的中文含义是： 商品生产单位对应汉字
	 */ 
	private String cppcscdwdmstr;
	
	/**
	 * @Description cpclid的中文含义是： 商品材料id
	 */ 
	private String cpclid;
	/**
	 * @Description proid的中文含义是： 商品ID
	 */ 
	private String proid;

	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	private String procomid;
	
	/**
	 * @Description commc的中文含义是： 商品所属公司名称
	 */
	private String commc;
	
	/**
	 * @Description comdz的中文含义是： 商品所属公司地址 
	 */
	private String comdz;
	
	/**
	 * @Description comyddh的中文含义是： 商品所属公司移动电话
	 */
	private String comyddh;

	/**
	 * @Description proname的中文含义是： 商品名称
	 */
	
	private String proname;

	/**
	 * @Description prosb的中文含义是： 商标
	 */
	
	private String prosb;

	/**
	 * @Description prosptm的中文含义是： 商品条码
	 */
	
	private String prosptm;

	/**
	 * @Description progg的中文含义是： 规格型号
	 */
	
	private String progg;

	/**
	 * @Description prosccj的中文含义是： 生产厂家
	 */
	
	private String prosccj;

	/**
	 * @Description propm的中文含义是： 品名
	 */
	
	private String propm;

	/**
	 * @Description probzq的中文含义是： 保质期
	 */
	
	private String probzq;

	/**
	 * @Description procdjd的中文含义是： 产地/基地名称
	 */
	
	private String procdjd;

	/**
	 * @Description proplxx的中文含义是： 配料信息
	 */
	
	private String proplxx;

	/**
	 * @Description procpbzh的中文含义是： 产品标准号
	 */
	
	private String procpbzh;

	/**
	 * @Description prozl的中文含义是： 产品种类 1一般产品  2养殖业有耳标脚环类产品aaa100=PROZL
	 */
	
	private String prozl;
	/**
	 * @Description prozl的中文含义是： 产品种类 1一般产品  2养殖业有耳标脚环类产品aaa100=PROZL
	 */
	
	private String prozlstr;

	/**
	 * @Description progtin14的中文含义是： 产品溯源码。包装符为1
	 */
	
	private String progtin14;

	/**
	 * @Description bzgtin14的中文含义是： 包装溯源码。 包装符为2
	 */
	
	private String bzgtin14;

	/**
	 * @Description probzqdwcode的中文含义是： 保质期单位代码aaa100=BZQDWMC 
	 */
	
	private String probzqdwcode;

	/**
	 * @Description probzqdwmc的中文含义是： 保质期单位名称
	 */
	
	private String probzqdwmc;

	/**
	 * @Description probzgg的中文含义是： 包装规格
	 */
	
	private String probzgg;
	
	/**
	 * @Description cphyclbz的中文含义是：产品或原材料标志1产品2原材料
	 */
	private String cphyclbz;
	
	/**
	 * @Description cppcsysl的中文含义是：剩余数量
	 */
	private BigDecimal cppcsysl;	

	/**
	 * @Description projj的中文含义是：产品简介
	 */
	private String projj;
	
	/**
	 * @Description proprice的中文含义是：产品价格
	 */
	private String proprice;	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getQjhkchzb() {
		return qjhkchzb;
	}
	public void setQjhkchzb(String qjhkchzb) {
		this.qjhkchzb = qjhkchzb;
	}
	public String getJhkcjhsl() {
		return jhkcjhsl;
	}
	public void setJhkcjhsl(String jhkcjhsl) {
		this.jhkcjhsl = jhkcjhsl;
	}
	public String getJhkcchsl() {
		return jhkcchsl;
	}
	public void setJhkcchsl(String jhkcchsl) {
		this.jhkcchsl = jhkcchsl;
	}
	public String getJhkcjysl() {
		return jhkcjysl;
	}
	public void setJhkcjysl(String jhkcjysl) {
		this.jhkcjysl = jhkcjysl;
	}
	public String getProzlstr() {
		return prozlstr;
	}
	public void setProzlstr(String prozlstr) {
		this.prozlstr = prozlstr;
	}
		/**
	 * @Description proid的中文含义是： 商品ID
	 */
	public void setProid(String proid){ 
		this.proid = proid;
	}
	/**
	 * @Description proid的中文含义是： 商品ID
	 */
	public String getProid(){
		return proid;
	}
	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	public void setProcomid(String procomid){ 
		this.procomid = procomid;
	}
	/**
	 * @Description procomid的中文含义是： 商品所属公司ID
	 */
	public String getProcomid(){
		return procomid;
	}
	/**
	 * @Description proname的中文含义是： 商品名称
	 */
	public void setProname(String proname){ 
		this.proname = proname;
	}
	/**
	 * @Description proname的中文含义是： 商品名称
	 */
	public String getProname(){
		return proname;
	}
	/**
	 * @Description prosb的中文含义是： 商标
	 */
	public void setProsb(String prosb){ 
		this.prosb = prosb;
	}
	/**
	 * @Description prosb的中文含义是： 商标
	 */
	public String getProsb(){
		return prosb;
	}
	/**
	 * @Description prosptm的中文含义是： 商品条码
	 */
	public void setProsptm(String prosptm){ 
		this.prosptm = prosptm;
	}
	/**
	 * @Description prosptm的中文含义是： 商品条码
	 */
	public String getProsptm(){
		return prosptm;
	}
	/**
	 * @Description progg的中文含义是： 规格型号
	 */
	public void setProgg(String progg){ 
		this.progg = progg;
	}
	/**
	 * @Description progg的中文含义是： 规格型号
	 */
	public String getProgg(){
		return progg;
	}
	/**
	 * @Description prosccj的中文含义是： 生产厂家
	 */
	public void setProsccj(String prosccj){ 
		this.prosccj = prosccj;
	}
	/**
	 * @Description prosccj的中文含义是： 生产厂家
	 */
	public String getProsccj(){
		return prosccj;
	}
	/**
	 * @Description propm的中文含义是： 品名
	 */
	public void setPropm(String propm){ 
		this.propm = propm;
	}
	/**
	 * @Description propm的中文含义是： 品名
	 */
	public String getPropm(){
		return propm;
	}
	/**
	 * @Description probzq的中文含义是： 保质期
	 */
	public void setProbzq(String probzq){ 
		this.probzq = probzq;
	}
	/**
	 * @Description probzq的中文含义是： 保质期
	 */
	public String getProbzq(){
		return probzq;
	}
	/**
	 * @Description procdjd的中文含义是： 产地/基地名称
	 */
	public void setProcdjd(String procdjd){ 
		this.procdjd = procdjd;
	}
	/**
	 * @Description procdjd的中文含义是： 产地/基地名称
	 */
	public String getProcdjd(){
		return procdjd;
	}
	/**
	 * @Description proplxx的中文含义是： 配料信息
	 */
	public void setProplxx(String proplxx){ 
		this.proplxx = proplxx;
	}
	/**
	 * @Description proplxx的中文含义是： 配料信息
	 */
	public String getProplxx(){
		return proplxx;
	}
	/**
	 * @Description procpbzh的中文含义是： 产品标准号
	 */
	public void setProcpbzh(String procpbzh){ 
		this.procpbzh = procpbzh;
	}
	/**
	 * @Description procpbzh的中文含义是： 产品标准号
	 */
	public String getProcpbzh(){
		return procpbzh;
	}
	/**
	 * @Description prozl的中文含义是： 产品种类 1一般产品  2养殖业有耳标脚环类产品aaa100=PROZL
	 */
	public void setProzl(String prozl){ 
		this.prozl = prozl;
	}
	/**
	 * @Description prozl的中文含义是： 产品种类 1一般产品  2养殖业有耳标脚环类产品aaa100=PROZL
	 */
	public String getProzl(){
		return prozl;
	}
	/**
	 * @Description progtin14的中文含义是： 产品溯源码。包装符为1
	 */
	public void setProgtin14(String progtin14){ 
		this.progtin14 = progtin14;
	}
	/**
	 * @Description progtin14的中文含义是： 产品溯源码。包装符为1
	 */
	public String getProgtin14(){
		return progtin14;
	}
	/**
	 * @Description bzgtin14的中文含义是： 包装溯源码。 包装符为2
	 */
	public void setBzgtin14(String bzgtin14){ 
		this.bzgtin14 = bzgtin14;
	}
	/**
	 * @Description bzgtin14的中文含义是： 包装溯源码。 包装符为2
	 */
	public String getBzgtin14(){
		return bzgtin14;
	}
	/**
	 * @Description probzqdwcode的中文含义是： 保质期单位代码aaa100=BZQDWMC 
	 */
	public void setProbzqdwcode(String probzqdwcode){ 
		this.probzqdwcode = probzqdwcode;
	}
	/**
	 * @Description probzqdwcode的中文含义是： 保质期单位代码aaa100=BZQDWMC 
	 */
	public String getProbzqdwcode(){
		return probzqdwcode;
	}
	/**
	 * @Description probzqdwmc的中文含义是： 保质期单位名称
	 */
	public void setProbzqdwmc(String probzqdwmc){ 
		this.probzqdwmc = probzqdwmc;
	}
	/**
	 * @Description probzqdwmc的中文含义是： 保质期单位名称
	 */
	public String getProbzqdwmc(){
		return probzqdwmc;
	}
	/**
	 * @Description probzgg的中文含义是： 包装规格
	 */
	public void setProbzgg(String probzgg){ 
		this.probzgg = probzgg;
	}
	/**
	 * @Description probzgg的中文含义是： 包装规格
	 */
	public String getProbzgg(){
		return probzgg;
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
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	public String getProcjdh() {
		return procjdh;
	}
	public void setProcjdh(String procjdh) {
		this.procjdh = procjdh;
	}
	public String getProcjdz() {
		return procjdz;
	}
	public void setProcjdz(String procjdz) {
		this.procjdz = procjdz;
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
	public String getComyddh() {
		return comyddh;
	}
	public void setComyddh(String comyddh) {
		this.comyddh = comyddh;
	}
	public String getCppcpch() {
		return cppcpch;
	}
	public void setCppcpch(String cppcpch) {
		this.cppcpch = cppcpch;
	}
	public String getCppcscrq() {
		return cppcscrq;
	}
	public void setCppcscrq(String cppcscrq) {
		this.cppcscrq = cppcscrq;
	}
	public String getCphyclbz() {
		return cphyclbz;
	}
	public void setCphyclbz(String cphyclbz) {
		this.cphyclbz = cphyclbz;
	}
	public String getCpclid() {
		return cpclid;
	}
	public void setCpclid(String cpclid) {
		this.cpclid = cpclid;
	}

	public BigDecimal getCppcsysl() {
		return cppcsysl;
	}
	public void setCppcsysl(BigDecimal cppcsysl) {
		this.cppcsysl = cppcsysl;
	}

	public String getCppcscsl() {
		return cppcscsl;
	}
	public void setCppcscsl(String cppcscsl) {
		this.cppcscsl = cppcscsl;
	}
	public String getCppcscdwdmstr() {
		return cppcscdwdmstr;
	}
	public void setCppcscdwdmstr(String cppcscdwdmstr) {
		this.cppcscdwdmstr = cppcscdwdmstr;
	}
	public String getCppicpath() {
		return cppicpath;
	}
	public void setCppicpath(String cppicpath) {
		this.cppicpath = cppicpath;
	}
	public String getProjj() {
		return projj;
	}
	public void setProjj(String projj) {
		this.projj = projj;
	}
	public String getProprice() {
		return proprice;
	}
	public void setProprice(String proprice) {
		this.proprice = proprice;
	}
	
	

}