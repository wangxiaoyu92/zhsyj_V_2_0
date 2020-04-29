package com.askj.tmsyj.tmsyj.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class HsptmDTO {
	/** 监管主体客户关系表; InnoDB free: 231424 kB  */
	/** hjgztkhgxid 的中文含义是：监管主体客户关系表id*/
	private String hjgztkhgxid;

	/** jgztkhgx 的中文含义是：客户关系*/
	private String jgztkhgx;

	/** hviewjgztid 的中文含义是：监管主体ID*/
	private String hviewjgztid;

	/** jgztkhbh 的中文含义是：客户编号*/
	private String jgztkhbh;

	/** jgztkhmc 的中文含义是：客户名称*/
	private String jgztkhmc;

	/** jgztkhmcjc 的中文含义是：客户名称简称*/
	private String jgztkhmcjc;

	/** jgztkhlxr 的中文含义是：联系人*/
	private String jgztkhlxr;

	/** jgztkhyddh 的中文含义是：移动电话*/
	private String jgztkhyddh;

	/** jgztkhgddh 的中文含义是：固定电话*/
	private String jgztkhgddh;

	/** jgztkhlxdz 的中文含义是：联系地址*/
	private String jgztkhlxdz;

	/** jgztkhzzzmmc 的中文含义是：资质证明名称*/
	private String jgztkhzzzmmc;

	/** jgztkhzzzmbh 的中文含义是：资质证明编号*/
	private String jgztkhzzzmbh;

	/** jgztfwnfww 的中文含义是：客户范围内范围外*/
	private String jgztfwnfww;

	/** jgztfwnztid 的中文含义是：范围内客户主体id，对应主体表id*/
	private String jgztfwnztid;

	/** aaa027 的中文含义是：统筹区*/
	private String aaa027;


	public void setHjgztkhgxid(String hjgztkhgxid){
		this.hjgztkhgxid=hjgztkhgxid;
	}

	public String getHjgztkhgxid(){
		return hjgztkhgxid;
	}

	public void setJgztkhgx(String jgztkhgx){
		this.jgztkhgx=jgztkhgx;
	}

	public String getJgztkhgx(){
		return jgztkhgx;
	}

	public void setHviewjgztid(String hviewjgztid){
		this.hviewjgztid=hviewjgztid;
	}

	public String getHviewjgztid(){
		return hviewjgztid;
	}

	public void setJgztkhbh(String jgztkhbh){
		this.jgztkhbh=jgztkhbh;
	}

	public String getJgztkhbh(){
		return jgztkhbh;
	}

	public void setJgztkhmc(String jgztkhmc){
		this.jgztkhmc=jgztkhmc;
	}

	public String getJgztkhmc(){
		return jgztkhmc;
	}

	public void setJgztkhmcjc(String jgztkhmcjc){
		this.jgztkhmcjc=jgztkhmcjc;
	}

	public String getJgztkhmcjc(){
		return jgztkhmcjc;
	}

	public void setJgztkhlxr(String jgztkhlxr){
		this.jgztkhlxr=jgztkhlxr;
	}

	public String getJgztkhlxr(){
		return jgztkhlxr;
	}

	public void setJgztkhyddh(String jgztkhyddh){
		this.jgztkhyddh=jgztkhyddh;
	}

	public String getJgztkhyddh(){
		return jgztkhyddh;
	}

	public void setJgztkhgddh(String jgztkhgddh){
		this.jgztkhgddh=jgztkhgddh;
	}

	public String getJgztkhgddh(){
		return jgztkhgddh;
	}

	public void setJgztkhlxdz(String jgztkhlxdz){
		this.jgztkhlxdz=jgztkhlxdz;
	}

	public String getJgztkhlxdz(){
		return jgztkhlxdz;
	}

	public void setJgztkhzzzmmc(String jgztkhzzzmmc){
		this.jgztkhzzzmmc=jgztkhzzzmmc;
	}

	public String getJgztkhzzzmmc(){
		return jgztkhzzzmmc;
	}

	public void setJgztkhzzzmbh(String jgztkhzzzmbh){
		this.jgztkhzzzmbh=jgztkhzzzmbh;
	}

	public String getJgztkhzzzmbh(){
		return jgztkhzzzmbh;
	}

	public void setJgztfwnfww(String jgztfwnfww){
		this.jgztfwnfww=jgztfwnfww;
	}

	public String getJgztfwnfww(){
		return jgztfwnfww;
	}

	public void setJgztfwnztid(String jgztfwnztid){
		this.jgztfwnztid=jgztfwnztid;
	}

	public String getJgztfwnztid(){
		return jgztfwnztid;
	}

	public void setAaa027(String aaa027){
		this.aaa027=aaa027;
	}

	public String getAaa027(){
		return aaa027;
	}

	
	/** 进货表; InnoDB free: 60416 kB  */
	//扩展开始
	/** jhgysmc 的中文含义是：进出货供应商名称*/
	private String jhgysmc;
	/** jhscsmc 的中文含义是：进出货生产商名称*/
	private String jhscsmc;	
	//企业门头照路径
    private String jchhgzmpath;
	//企业门头照名称
    private String jchhgzmname;	
	//开始操作时间
    private Timestamp aae036start;	
	//结束操作时间
    private Timestamp aae036end;
	//检测样品名称
    private String jcypmc;	
	//监管主体名称
    private String jgztmc;	    

	//扩展结束
    
    
	/** hjhbid 的中文含义是：进货表id*/
	private String hjhbid;

	/** jcypid 的中文含义是：商品id*/
	private String jcypid;

	/** jhsl 的中文含义是：进货数量*/
	private BigDecimal jhsl;

	/** jhspjldw 的中文含义是：进货计量单位aaa100=spjldw，首次进货记录有*/
	private String jhspjldw;

	/** jhscd 的中文含义是：生产地，首次进货记录有*/
	private String jhscd;

	/** jhsjfxid 的中文含义是：上级分销id，根据这个号，能知道是有那条记录分销过来的*/
	private String jhsjfxid;

	/** jcfs 的中文含义是：检测方式1自检2上游流转，首次进货记录有*/
	private String jcfs;

	/** jhprice 的中文含义是：单价*/
	private BigDecimal jhprice;

	/** jhtotal 的中文含义是：合计*/
	private BigDecimal jhtotal;

	/** jhscrq 的中文含义是：生产日期，首次进货记录有*/
	private Timestamp jhscrq;

	/** jhscpcm 的中文含义是：生产批次码，首次进货记录有*/
	private String jhscpcm;

	/** jhhgzmlx 的中文含义是：合格证明类型aaa100=jchhgzmlx，首次进货记录有*/
	private String jhhgzmlx;

	/** jhscjyjl 的中文含义是：生产检验结论aaa100=jchscjyjl，首次进货记录有*/
	private String jhscjyjl;

	/** jhqycyjl 的中文含义是：企业查验结论aaa100=jchqycyjl，首次进货记录有*/
	private String jhqycyjl;

	/** jhgysid 的中文含义是：供应商id，对应客户关系表主键，首次进货记录有*/
	private String jhgysid;

	/** jhscsid 的中文含义是：生产商id，对应客户关系表主键，首次进货记录有*/
	private String jhscsid;

	/** jhsptm 的中文含义是：商品条码，首次进货记录有*/
	private String jhsptm;


	/** eptbh 的中文含义是：e票通编号，根据这个号能拉取所有的本次进货的分销信息*/
	private String eptbh;

	/** aae011 的中文含义是：操作员*/
	private String aae011;

	/** aae036 的中文含义是：操作时间*/
	private Timestamp aae036;

	/** jhkcl 的中文含义是：进货库存量*/
	private BigDecimal jhkcl;
	/** jhqrbz 的中文含义是：进货确认标志0未1已*/
	private String jhqrbz;	

	public void setHjhbid(String hjhbid){
		this.hjhbid=hjhbid;
	}

	public String getHjhbid(){
		return hjhbid;
	}

	public void setJcypid(String jcypid){
		this.jcypid=jcypid;
	}

	public String getJcypid(){
		return jcypid;
	}

	public void setJhsl(BigDecimal jhsl){
		this.jhsl=jhsl;
	}

	public BigDecimal getJhsl(){
		return jhsl;
	}

	public void setJhspjldw(String jhspjldw){
		this.jhspjldw=jhspjldw;
	}

	public String getJhspjldw(){
		return jhspjldw;
	}

	public void setJhscd(String jhscd){
		this.jhscd=jhscd;
	}

	public String getJhscd(){
		return jhscd;
	}

	public void setJhsjfxid(String jhsjfxid){
		this.jhsjfxid=jhsjfxid;
	}

	public String getJhsjfxid(){
		return jhsjfxid;
	}

	public void setJcfs(String jcfs){
		this.jcfs=jcfs;
	}

	public String getJcfs(){
		return jcfs;
	}

	public void setJhprice(BigDecimal jhprice){
		this.jhprice=jhprice;
	}

	public BigDecimal getJhprice(){
		return jhprice;
	}

	public void setJhtotal(BigDecimal jhtotal){
		this.jhtotal=jhtotal;
	}

	public BigDecimal getJhtotal(){
		return jhtotal;
	}

	public void setJhscrq(Timestamp jhscrq){
		this.jhscrq=jhscrq;
	}

	public Timestamp getJhscrq(){
		return jhscrq;
	}

	public void setJhscpcm(String jhscpcm){
		this.jhscpcm=jhscpcm;
	}

	public String getJhscpcm(){
		return jhscpcm;
	}

	public void setJhhgzmlx(String jhhgzmlx){
		this.jhhgzmlx=jhhgzmlx;
	}

	public String getJhhgzmlx(){
		return jhhgzmlx;
	}

	public void setJhscjyjl(String jhscjyjl){
		this.jhscjyjl=jhscjyjl;
	}

	public String getJhscjyjl(){
		return jhscjyjl;
	}

	public void setJhqycyjl(String jhqycyjl){
		this.jhqycyjl=jhqycyjl;
	}

	public String getJhqycyjl(){
		return jhqycyjl;
	}

	public void setJhgysid(String jhgysid){
		this.jhgysid=jhgysid;
	}

	public String getJhgysid(){
		return jhgysid;
	}

	public void setJhscsid(String jhscsid){
		this.jhscsid=jhscsid;
	}

	public String getJhscsid(){
		return jhscsid;
	}

	public void setJhsptm(String jhsptm){
		this.jhsptm=jhsptm;
	}

	public String getJhsptm(){
		return jhsptm;
	}

	public void setEptbh(String eptbh){
		this.eptbh=eptbh;
	}

	public String getEptbh(){
		return eptbh;
	}

	public void setAae011(String aae011){
		this.aae011=aae011;
	}

	public String getAae011(){
		return aae011;
	}

	public void setAae036(Timestamp aae036){
		this.aae036=aae036;
	}

	public Timestamp getAae036(){
		return aae036;
	}

	public void setJhkcl(BigDecimal jhkcl){
		this.jhkcl=jhkcl;
	}

	public BigDecimal getJhkcl(){
		return jhkcl;
	}

	public String getJhgysmc() {
		return jhgysmc;
	}

	public void setJhgysmc(String jhgysmc) {
		this.jhgysmc = jhgysmc;
	}

	public String getJhscsmc() {
		return jhscsmc;
	}

	public void setJhscsmc(String jhscsmc) {
		this.jhscsmc = jhscsmc;
	}

	public String getJchhgzmpath() {
		return jchhgzmpath;
	}

	public void setJchhgzmpath(String jchhgzmpath) {
		this.jchhgzmpath = jchhgzmpath;
	}

	public String getJchhgzmname() {
		return jchhgzmname;
	}

	public void setJchhgzmname(String jchhgzmname) {
		this.jchhgzmname = jchhgzmname;
	}

	public Timestamp getAae036start() {
		return aae036start;
	}

	public void setAae036start(Timestamp aae036start) {
		this.aae036start = aae036start;
	}

	public Timestamp getAae036end() {
		return aae036end;
	}

	public void setAae036end(Timestamp aae036end) {
		this.aae036end = aae036end;
	}

	public String getJcypmc() {
		return jcypmc;
	}

	public void setJcypmc(String jcypmc) {
		this.jcypmc = jcypmc;
	}

	public String getJhqrbz() {
		return jhqrbz;
	}

	public void setJhqrbz(String jhqrbz) {
		this.jhqrbz = jhqrbz;
	}

	public String getJgztmc() {
		return jgztmc;
	}

	public void setJgztmc(String jgztmc) {
		this.jgztmc = jgztmc;
	}

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

	/** jcyplb 的中文含义是：检查样品类别,见AA10表JCYPLB*/
	private String jcyplb;

	/** jcypbh 的中文含义是：商品编号*/
	private String jcypbh;

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
	
	
}
