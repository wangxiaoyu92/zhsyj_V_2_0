package com.askj.baseinfo.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * @Description  PCOMPANY的中文含义是: 公司企业表; InnoDB free: 7168 kBDTO
 * @Creation     2016/01/27 10:32:29
 * @Written      Create Tool By zjf 
 **/
public class PcompanyDTO {
	//扩展开始

	//企业量化等级
	private String lhfjndpddj;

	//camorgid 力天的企业id
	private String camorgid;

	//havepdlevel 是否做过本年度 登记评定 0未1已
	private String havepdlevel;

	//yyzzh 营业执照号
	private String yyzzh;

	//querytype y有些时候需要根据不同的业务场景，查询不同的企业，通过这个字段来区分业务场景
	private String querytype;

	//是否有证无证
	private String ishavezzzm;
	//扩展结束

	//执法人员证件号码
	private String zfryzjhm;

	//有些时候 企业用户也需要查其他企业信息 0或空，1查所有
    private String queryall;

	// 企业是否含有资质证明 0：没有

	private String havezzzm;
    
	//许可证有效期起
    private Timestamp comxkyxqq;	
	//许可证有效期起
    private Timestamp comxkyxqz;	    
	
	//企业许可范围
    private String comxkfw;	
    
	//企业日常监督管理人员id 类似1222222,888889,7888888
    private String comrcjdglryid;
	//企业日常监督管理人员名称 类似张三,李四1
	private String comrcjdglrymc;

	//企业门头照路径
    private String qymtzpath;
	//企业门头照名称
    private String qymtzname;
    
	//手机或电脑 2手机 其他电脑
    private String sjordnbz;	
	//单位资质证明列表 手机传用
    private String comzzzmlist;
	//许可证类型
    private String comxkzlx;  
	//组成形式
    private String comxkzzcxs; 
	//主题业态
    private String comxkzztyt;   
	//经营场所
    private String comxkzjycs;     
	//密码
    private String passwd;      
    
	// 文件上传
    private String zhengquegriddata;//单位excel上传，验证后正确的数据

	private String filepath;
	private String message;
	private String succJsonStr;
	private String errorJsonStr;
	//子节点数量,非映射字段
	private int childnum;
	//是否父节点,非映射字段
	private boolean isparent;
	//是否展开,非映射字段
	private boolean isopen;
	//企业大类对应汉字
	private String comdaleistr;

	//校园周边
	private String comxyzb;

	//门店编号
	private String commdbh;

	//视频监控标致
	private String comcameraflag;

	// 超范围


	public String getComcfw() {
		return comcfw;
	}

	public void setComcfw(String comcfw) {
		this.comcfw = comcfw;
	}

	private String comcfw;

	//酒类专兼
	private String comjlzj;

	//酒类有无
	private String comjlyw;

	public String getComjlyw() {
		return comjlyw;
	}

	public void setComjlyw(String comjlyw) {
		this.comjlyw = comjlyw;
	}

	public String getComjlzj() {
		return comjlzj;
	}

	public void setComjlzj(String comjlzj) {
		this.comjlzj = comjlzj;
	}

	public String getCommdbh() {
		return commdbh;
	}

	public void setCommdbh(String commdbh) {
		this.commdbh = commdbh;
	}

	/**
	 * @Description parentid的中文含义是： 
	 */
	private String parentid;	
	/**
	 * @Description comdalei2的中文含义是： 企业分类,代码表comdalei2如食品生产，食品经营，药品生产，药品经营
	 */
	private String comdalei2;
	
	/**
	 * @Description orgname的中文含义是： 统筹区名称
	 */
	private String aaa027name;
	/**
	 * @Description comfjpath的中文含义是： 企业附件路径，见pcompanyfj
	 */
	private String comfjpath;
	/**
	 * @Description comfjfile的中文含义是： 企业附件内容，见pcompanyfj
	 */
	private String comfjfile;
	/**
	 * @Description itemid的中文含义是：检查项大类
	 */
	private String itemid;
	/**
	 * @Description itemname的中文含义是：检查项项目大标题
	 */
	private String itemname;
	/**
	 * @Description operatedate的中文含义是：检查经办时间
	 */
	private String operatedate;
	/**
	 * @Description resultdate的中文含义是：检查结束时间
	 */
	private String resultdate;
	/**
	 * @Description aaz093的中文含义是：企业大类id
	 */
	private String aaz093;
	
	
	/**
	 * @Description comlrcommc的中文含义是： 如果是范围外企业对应的添加该企业的企业名称
	 */
	private String comlrcommc;	
	
	/**
	 * @Description aae140的中文含义是：查询大类
	 */
	private String aae140;
	/**
	 * @Description userid的中文含义是：用户id
	 */
	private String userid;
	/**
	 * @Description sn的中文含义是：数据版本号
	 */
	private String sn;



	/**
	 * @Description outercomid的中文含义是：外部系统主键
	 */
	private String outercomid;
	
	private String year;
	private String planchecktype;
	private String resultcount;
	private String planresult;
	private String planid;

	
	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public String getAaa027name() {
		return aaa027name;
	}

	/**
	 * @Description aaa027name的中文含义是： 统筹区名称
	 */
	public void setAaa027name(String aaa027name) {
		this.aaa027name = aaa027name;
	}
	
	
	public String getComfjpath() {
		return comfjpath;
	}
	public void setComfjpath(String comfjpath) {
		this.comfjpath = comfjpath;
	}
	public String getComfjfile() {
		return comfjfile;
	}
	public void setComfjfile(String comfjfile) {
		this.comfjfile = comfjfile;
	}
	public String getItemid() {
		return itemid;
	}
	public void setItemid(String itemid) {
		this.itemid = itemid;
	}
	public String getAaz093() {
		return aaz093;
	}
	public void setAaz093(String aaz093) {
		this.aaz093 = aaz093;
	}
	public String getItemname() {
		return itemname;
	}
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	public String getOperatedate() {
		return operatedate;
	}
	public void setOperatedate(String operatedate) {
		this.operatedate = operatedate;
	}
	public String getResultdate() {
		return resultdate;
	}
	public void setResultdate(String resultdate) {
		this.resultdate = resultdate;
	}
	public String getComlrcommc() {
		return comlrcommc;
	}
	public void setComlrcommc(String comlrcommc) {
		this.comlrcommc = comlrcommc;
	}
	public int getChildnum() {
		return childnum;
	}
	public void setChildnum(int childnum) {
		this.childnum = childnum;
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
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getPlanchecktype() {
		return planchecktype;
	}
	public void setPlanchecktype(String planchecktype) {
		this.planchecktype = planchecktype;
	}
	public String getResultcount() {
		return resultcount;
	}
	public void setResultcount(String resultcount) {
		this.resultcount = resultcount;
	}
	public String getComdaleistr() {
		return comdaleistr;
	}
	public void setComdaleistr(String comdaleistr) {
		this.comdaleistr = comdaleistr;
	}
	public String getPlanresult() {
		return planresult;
	}
	public void setPlanresult(String planresult) {
		this.planresult = planresult;
	}
	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSuccJsonStr() {
		return succJsonStr;
	}

	public void setSuccJsonStr(String succJsonStr) {
		this.succJsonStr = succJsonStr;
	}

	public String getErrorJsonStr() {
		return errorJsonStr;
	}

	public void setErrorJsonStr(String errorJsonStr) {
		this.errorJsonStr = errorJsonStr;
	}
	public String getZhengquegriddata() {
		return zhengquegriddata;
	}
	public void setZhengquegriddata(String zhengquegriddata) {
		this.zhengquegriddata = zhengquegriddata;
	}
	public String getAae140() {
		return aae140;
	}
	public void setAae140(String aae140) {
		this.aae140 = aae140;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getComdalei2() {
		return comdalei2;
	}

	public void setComdalei2(String comdalei2) {
		this.comdalei2 = comdalei2;
	}
	public String getComzzzmlist() {
		return comzzzmlist;
	}
	public void setComzzzmlist(String comzzzmlist) {
		this.comzzzmlist = comzzzmlist;
	}
	public String getSjordnbz() {
		return sjordnbz;
	}
	public void setSjordnbz(String sjordnbz) {
		this.sjordnbz = sjordnbz;
	}
	public String getComxkzlx() {
		return comxkzlx;
	}
	public void setComxkzlx(String comxkzlx) {
		this.comxkzlx = comxkzlx;
	}
	public String getComxkzzcxs() {
		return comxkzzcxs;
	}
	public void setComxkzzcxs(String comxkzzcxs) {
		this.comxkzzcxs = comxkzzcxs;
	}
	public String getComxkzztyt() {
		return comxkzztyt;
	}
	public void setComxkzztyt(String comxkzztyt) {
		this.comxkzztyt = comxkzztyt;
	}
	public String getComxkzjycs() {
		return comxkzjycs;
	}
	public void setComxkzjycs(String comxkzjycs) {
		this.comxkzjycs = comxkzjycs;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getQymtzpath() {
		return qymtzpath;
	}
	public void setQymtzpath(String qymtzpath) {
		this.qymtzpath = qymtzpath;
	}
	public String getQymtzname() {
		return qymtzname;
	}
	public void setQymtzname(String qymtzname) {
		this.qymtzname = qymtzname;
	}
	public String getComrcjdglryid() {
		return comrcjdglryid;
	}
	public void setComrcjdglryid(String comrcjdglryid) {
		this.comrcjdglryid = comrcjdglryid;
	}
	
	/////////////////////////////////////////


	/** comid 的中文含义是：企业ID*/
	private String comid;

	/** comdm 的中文含义是：企业代码：企业类型字母+6位行政区域代码+9位序列号*/
	private String comdm;

	/** comdalei 的中文含义是：企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营*/
	private String comdalei;

	/** comxkzbh 的中文含义是：许可证编号*/
	private String comxkzbh;

	/** comxkzbhall 的中文含义是：许可证编号*/
	private String comxkzbhall;

	/** commc 的中文含义是：企业名称*/
	private String commc;

	/** comfrhyz 的中文含义是：企业法人/业主*/
	private String comfrhyz;

	/** comfrsfzh 的中文含义是：企业法人/业主身份证号*/
	private String comfrsfzh;

	/** comfrxb 的中文含义是：企业法人/业主性别*/
	private String comfrxb;

	/** comfrzw 的中文含义是：企业法人/业主职务*/
	private String comfrzw;

	/** comfzr 的中文含义是：企业负责人*/
	private String comfzr;

	/** comgddh 的中文含义是：固定电话*/
	private String comgddh;

	/** comyddh 的中文含义是：移动电话*/
	private String comyddh;

	/** comdz 的中文含义是：企业地址*/
	private String comdz;

	/** comqq 的中文含义是：企业QQ*/
	private String comqq;

	/** comemail 的中文含义是：企业电子邮件*/
	private String comemail;

	/** comyzbm 的中文含义是：企业邮政编码*/
	private String comyzbm;

	/** comwz 的中文含义是：网址*/
	private String comwz;

	/** comcz 的中文含义是：传真*/
	private String comcz;

	/** comctmj 的中文含义是：餐厅面积*/
	private BigDecimal comctmj;

	/** comcfmj 的中文含义是：厨房面积*/
	private BigDecimal comcfmj;

	/** comzmj 的中文含义是：总面积*/
	private BigDecimal comzmj;

	/** comjcrs 的中文含义是：就餐人数*/
	private Integer comjcrs;

	/** comcyrs 的中文含义是：从业人数*/
	private Integer comcyrs;

	/** comcjkzrs 的中文含义是：持健康证人数*/
	private Integer comcjkzrs;

	/** comzjzglrs 的中文含义是：专（兼）职管理人员数*/
	private Integer comzjzglrs;

	/** comxiaolei 的中文含义是：企业小类，代码表comxiaolei如特大型餐馆*/
	private String comxiaolei;

	/** comdmlx 的中文含义是：店面类型，代码表comdmlx如蛋糕店、火锅店*/
	private String comdmlx;

	/** comtscx 的中文含义是：特色菜系，代表表comtscx如豫菜*/
	private String comtscx;

	/** comtsc 的中文含义是：特色菜*/
	private String comtsc;

	/** comzzjgdm 的中文含义是：组织机构代码*/
	private String comzzjgdm;

	/** comclrq 的中文含义是：企业成立日期*/
	private Timestamp comclrq;

	/** comzczj 的中文含义是：注册资金（万元）*/
	private Long comzczj;

	/** comzclb 的中文含义是：1企业自行注册2 操作员添加注册*/
	private String comzclb;

	/** comdzcczymc 的中文含义是：代企业注册的操作人*/
	private String comdzcczymc;

	/** comdzcsj 的中文含义是：代注册时间*/
	private Timestamp comdzcsj;

	/** comshbz 的中文含义是：审核标志 1通过 2未通过 0 等待审核*/
	private String comshbz;

	/** comshr 的中文含义是：审核人*/
	private String comshr;

	/** comshsj 的中文含义是：审核时间*/
	private Timestamp comshsj;

	/** comshwtgyy 的中文含义是：审核未通过原因*/
	private String comshwtgyy;

	/** comjianjie 的中文含义是：企业简介*/
	private String comjianjie;

	/** comqyxz 的中文含义是：企业性质*/
	private String comqyxz;

	/** aaa027 的中文含义是：地区编码*/
	private String aaa027;

	/** comjdzb 的中文含义是：经度坐标*/
	private String comjdzb;

	/** comwdzb 的中文含义是：纬度坐标*/
	private String comwdzb;

	/** comfwnfww 的中文含义是：0范围内1范围外aaa100=COMFWNFWW*/
	private String comfwnfww;

	/** comlrcomid 的中文含义是：如果是范围外企业对应的添加该企业的企业ID*/
	private String comlrcomid;

	/** comghsorxhs 的中文含义是：0供货商1销货商是供货商还是销货商AAA100=COMGHSORXHS*/
	private String comghsorxhs;

	/** comjyjcbz 的中文含义是：检验检测单位标志，见aaa100=COMJYJCBZ*/
	private String comjyjcbz;

	/** combxbz 的中文含义是：保险标志*/
	private String combxbz;

	/** comspjkbz 的中文含义是：视频监控标志*/
	private String comspjkbz;

	/** comhhbbz 的中文含义是：红黑榜标志*/
	private String comhhbbz;

	/** comsyqylx 的中文含义是：溯源企业类型0非溯源企业1生成2流通3餐饮aaa100=COMSYQYLX*/
	private String comsyqylx;

	/** comywtz 的中文含义是：有无台账*/
	private String comywtz;

	/** combeizhu 的中文含义是：备注*/
	private String combeizhu;

	/** comrcjdglry 的中文含义是：日常监督管理人员*/
	private String comrcjdglry;

	/** orgid 的中文含义是：机构ID*/
	private String orgid;

	/** comcssbm 的中文含义是：厂商识别码*/
	private String comcssbm;

	/** comtsdh 的中文含义是：企业投诉电话*/
	private String comtsdh;

	/** comscdz 的中文含义是：企业生产地址*/
	private String comscdz;

	/** comzmfx 的中文含义是：企业正门方向*/
	private String comzmfx;

	/** comqyndgdzcxz 的中文含义是：前一年度固定资产（现值*/
	private BigDecimal comqyndgdzcxz;

	/** comqyndldzj 的中文含义是：前一年度流动资金*/
	private BigDecimal comqyndldzj;

	/** comqyndzcz 的中文含义是：前一年度总产值*/
	private BigDecimal comqyndzcz;

	/** comqyndnxse 的中文含义是：前一年度年销售额*/
	private BigDecimal comqyndnxse;

	/** comqyndyjse 的中文含义是：前一年度缴税金额*/
	private BigDecimal comqyndyjse;

	/** comqyndnlr 的中文含义是：前一年度年利润*/
	private BigDecimal comqyndnlr;

	/** comsftghaccp 的中文含义是：是否通过HACCP认证0否1是*/
	private String comsftghaccp;

	/** comhaccpbh 的中文含义是：HACCP认证证书编号*/
	private String comhaccpbh;

	/** comhaccpfzdw 的中文含义是：HACCP发证单位名*/
	private String comhaccpfzdw;

	/** comiso9000bh 的中文含义是：ISO9000证书编号*/
	private String comiso9000bh;

	/** comiso9000fzdw 的中文含义是：ISO9000发证单位名*/
	private String comiso9000fzdw;

	/** comzdmj 的中文含义是：占地面积*/
	private BigDecimal comzdmj;

	/** comjzmj 的中文含义是：建筑面积*/
	private BigDecimal comjzmj;

	/** comyysj 的中文含义是：营业时间*/
	private String comyysj;

	/** comfxdj 的中文含义是：企业风险等级aaa100=comfxdj*/
	private String comfxdj;

	/** commcjc 的中文含义是：企业名称简称*/
	private String commcjc;

	/** comdaleiname 的中文含义是：企业大类汉字描述*/
	private String comdaleiname;

	/** comxiaoleiname 的中文含义是：企业小类汉字描述*/
	private String comxiaoleiname;
	
	/** orderno 的中文含义是：显示序号*/
	private String orderno;
	
	/**
	 * @Description sjdatatime的中文含义是：省局数据同步时间
	 */
	private Timestamp sjdatatime;
	
	/**
	 * @Description sjdatacomid的中文含义是：省局数据主键
	 */
	private String sjdatacomid;	
	
	/**
	 * @Description sjdatacomdm的中文含义是：省局数据企业代码
	 */
	private String sjdatacomdm;		


	public void setComid(String comid){
		this.comid=comid;
	}

	public String getComid(){
		return comid;
	}

	public void setComdm(String comdm){
		this.comdm=comdm;
	}

	public String getComdm(){
		return comdm;
	}

	public void setComdalei(String comdalei){
		this.comdalei=comdalei;
	}

	public String getComdalei(){
		return comdalei;
	}

	public void setComxkzbh(String comxkzbh){
		this.comxkzbh=comxkzbh;
	}

	public String getComxkzbh(){
		return comxkzbh;
	}

	public void setCommc(String commc){
		this.commc=commc;
	}

	public String getCommc(){
		return commc;
	}

	public void setComfrhyz(String comfrhyz){
		this.comfrhyz=comfrhyz;
	}

	public String getComfrhyz(){
		return comfrhyz;
	}

	public void setComfrsfzh(String comfrsfzh){
		this.comfrsfzh=comfrsfzh;
	}

	public String getComfrsfzh(){
		return comfrsfzh;
	}

	public void setComfrxb(String comfrxb){
		this.comfrxb=comfrxb;
	}

	public String getComfrxb(){
		return comfrxb;
	}

	public void setComfrzw(String comfrzw){
		this.comfrzw=comfrzw;
	}

	public String getComfrzw(){
		return comfrzw;
	}

	public void setComfzr(String comfzr){
		this.comfzr=comfzr;
	}

	public String getComfzr(){
		return comfzr;
	}

	public void setComgddh(String comgddh){
		this.comgddh=comgddh;
	}

	public String getComgddh(){
		return comgddh;
	}

	public void setComyddh(String comyddh){
		this.comyddh=comyddh;
	}

	public String getComyddh(){
		return comyddh;
	}

	public void setComdz(String comdz){
		this.comdz=comdz;
	}

	public String getComdz(){
		return comdz;
	}

	public void setComqq(String comqq){
		this.comqq=comqq;
	}

	public String getComqq(){
		return comqq;
	}

	public void setComemail(String comemail){
		this.comemail=comemail;
	}

	public String getComemail(){
		return comemail;
	}

	public void setComyzbm(String comyzbm){
		this.comyzbm=comyzbm;
	}

	public String getComyzbm(){
		return comyzbm;
	}

	public void setComwz(String comwz){
		this.comwz=comwz;
	}

	public String getComwz(){
		return comwz;
	}

	public void setComcz(String comcz){
		this.comcz=comcz;
	}

	public String getComcz(){
		return comcz;
	}

	public void setComctmj(BigDecimal comctmj){
		this.comctmj=comctmj;
	}

	public BigDecimal getComctmj(){
		return comctmj;
	}

	public void setComcfmj(BigDecimal comcfmj){
		this.comcfmj=comcfmj;
	}

	public BigDecimal getComcfmj(){
		return comcfmj;
	}

	public void setComzmj(BigDecimal comzmj){
		this.comzmj=comzmj;
	}

	public BigDecimal getComzmj(){
		return comzmj;
	}

	public void setComjcrs(Integer comjcrs){
		this.comjcrs=comjcrs;
	}

	public Integer getComjcrs(){
		return comjcrs;
	}

	public void setComcyrs(Integer comcyrs){
		this.comcyrs=comcyrs;
	}

	public Integer getComcyrs(){
		return comcyrs;
	}

	public void setComcjkzrs(Integer comcjkzrs){
		this.comcjkzrs=comcjkzrs;
	}

	public Integer getComcjkzrs(){
		return comcjkzrs;
	}

	public void setComzjzglrs(Integer comzjzglrs){
		this.comzjzglrs=comzjzglrs;
	}

	public Integer getComzjzglrs(){
		return comzjzglrs;
	}

	public void setComxiaolei(String comxiaolei){
		this.comxiaolei=comxiaolei;
	}

	public String getComxiaolei(){
		return comxiaolei;
	}

	public void setComdmlx(String comdmlx){
		this.comdmlx=comdmlx;
	}

	public String getComdmlx(){
		return comdmlx;
	}

	public void setComtscx(String comtscx){
		this.comtscx=comtscx;
	}

	public String getComtscx(){
		return comtscx;
	}

	public void setComtsc(String comtsc){
		this.comtsc=comtsc;
	}

	public String getComtsc(){
		return comtsc;
	}

	public void setComzzjgdm(String comzzjgdm){
		this.comzzjgdm=comzzjgdm;
	}

	public String getComzzjgdm(){
		return comzzjgdm;
	}

	public void setComclrq(Timestamp comclrq){
		this.comclrq=comclrq;
	}

	public Timestamp getComclrq(){
		return comclrq;
	}

	public void setComzczj(Long comzczj){
		this.comzczj=comzczj;
	}

	public Long getComzczj(){
		return comzczj;
	}

	public void setComzclb(String comzclb){
		this.comzclb=comzclb;
	}

	public String getComzclb(){
		return comzclb;
	}

	public void setComdzcczymc(String comdzcczymc){
		this.comdzcczymc=comdzcczymc;
	}

	public String getComdzcczymc(){
		return comdzcczymc;
	}

	public void setComdzcsj(Timestamp comdzcsj){
		this.comdzcsj=comdzcsj;
	}

	public Timestamp getComdzcsj(){
		return comdzcsj;
	}

	public void setComshbz(String comshbz){
		this.comshbz=comshbz;
	}

	public String getComshbz(){
		return comshbz;
	}

	public void setComshr(String comshr){
		this.comshr=comshr;
	}

	public String getComshr(){
		return comshr;
	}

	public void setComshsj(Timestamp comshsj){
		this.comshsj=comshsj;
	}

	public Timestamp getComshsj(){
		return comshsj;
	}

	public void setComshwtgyy(String comshwtgyy){
		this.comshwtgyy=comshwtgyy;
	}

	public String getComshwtgyy(){
		return comshwtgyy;
	}

	public void setComjianjie(String comjianjie){
		this.comjianjie=comjianjie;
	}

	public String getComjianjie(){
		return comjianjie;
	}

	public void setComqyxz(String comqyxz){
		this.comqyxz=comqyxz;
	}

	public String getComqyxz(){
		return comqyxz;
	}

	public void setAaa027(String aaa027){
		this.aaa027=aaa027;
	}

	public String getAaa027(){
		return aaa027;
	}

	public void setComjdzb(String comjdzb){
		this.comjdzb=comjdzb;
	}

	public String getComjdzb(){
		return comjdzb;
	}

	public void setComwdzb(String comwdzb){
		this.comwdzb=comwdzb;
	}

	public String getComwdzb(){
		return comwdzb;
	}

	public void setComfwnfww(String comfwnfww){
		this.comfwnfww=comfwnfww;
	}

	public String getComfwnfww(){
		return comfwnfww;
	}

	public void setComlrcomid(String comlrcomid){
		this.comlrcomid=comlrcomid;
	}

	public String getComlrcomid(){
		return comlrcomid;
	}

	public void setComghsorxhs(String comghsorxhs){
		this.comghsorxhs=comghsorxhs;
	}

	public String getComghsorxhs(){
		return comghsorxhs;
	}

	public void setComjyjcbz(String comjyjcbz){
		this.comjyjcbz=comjyjcbz;
	}

	public String getComjyjcbz(){
		return comjyjcbz;
	}

	public void setCombxbz(String combxbz){
		this.combxbz=combxbz;
	}

	public String getCombxbz(){
		return combxbz;
	}

	public void setComspjkbz(String comspjkbz){
		this.comspjkbz=comspjkbz;
	}

	public String getComspjkbz(){
		return comspjkbz;
	}

	public void setComhhbbz(String comhhbbz){
		this.comhhbbz=comhhbbz;
	}

	public String getComhhbbz(){
		return comhhbbz;
	}

	public void setComsyqylx(String comsyqylx){
		this.comsyqylx=comsyqylx;
	}

	public String getComsyqylx(){
		return comsyqylx;
	}

	public void setComywtz(String comywtz){
		this.comywtz=comywtz;
	}

	public String getComywtz(){
		return comywtz;
	}

	public void setCombeizhu(String combeizhu){
		this.combeizhu=combeizhu;
	}

	public String getCombeizhu(){
		return combeizhu;
	}

	public void setComrcjdglry(String comrcjdglry){
		this.comrcjdglry=comrcjdglry;
	}

	public String getComrcjdglry(){
		return comrcjdglry;
	}

	public void setOrgid(String orgid){
		this.orgid=orgid;
	}

	public String getOrgid(){
		return orgid;
	}

	public void setComcssbm(String comcssbm){
		this.comcssbm=comcssbm;
	}

	public String getComcssbm(){
		return comcssbm;
	}

	public void setComtsdh(String comtsdh){
		this.comtsdh=comtsdh;
	}

	public String getComtsdh(){
		return comtsdh;
	}

	public void setComscdz(String comscdz){
		this.comscdz=comscdz;
	}

	public String getComscdz(){
		return comscdz;
	}

	public void setComzmfx(String comzmfx){
		this.comzmfx=comzmfx;
	}

	public String getComzmfx(){
		return comzmfx;
	}

	public void setComqyndgdzcxz(BigDecimal comqyndgdzcxz){
		this.comqyndgdzcxz=comqyndgdzcxz;
	}

	public BigDecimal getComqyndgdzcxz(){
		return comqyndgdzcxz;
	}

	public void setComqyndldzj(BigDecimal comqyndldzj){
		this.comqyndldzj=comqyndldzj;
	}

	public BigDecimal getComqyndldzj(){
		return comqyndldzj;
	}

	public void setComqyndzcz(BigDecimal comqyndzcz){
		this.comqyndzcz=comqyndzcz;
	}

	public BigDecimal getComqyndzcz(){
		return comqyndzcz;
	}

	public void setComqyndnxse(BigDecimal comqyndnxse){
		this.comqyndnxse=comqyndnxse;
	}

	public BigDecimal getComqyndnxse(){
		return comqyndnxse;
	}

	public void setComqyndyjse(BigDecimal comqyndyjse){
		this.comqyndyjse=comqyndyjse;
	}

	public BigDecimal getComqyndyjse(){
		return comqyndyjse;
	}

	public void setComqyndnlr(BigDecimal comqyndnlr){
		this.comqyndnlr=comqyndnlr;
	}

	public BigDecimal getComqyndnlr(){
		return comqyndnlr;
	}

	public void setComsftghaccp(String comsftghaccp){
		this.comsftghaccp=comsftghaccp;
	}

	public String getComsftghaccp(){
		return comsftghaccp;
	}

	public void setComhaccpbh(String comhaccpbh){
		this.comhaccpbh=comhaccpbh;
	}

	public String getComhaccpbh(){
		return comhaccpbh;
	}

	public void setComhaccpfzdw(String comhaccpfzdw){
		this.comhaccpfzdw=comhaccpfzdw;
	}

	public String getComhaccpfzdw(){
		return comhaccpfzdw;
	}

	public void setComiso9000bh(String comiso9000bh){
		this.comiso9000bh=comiso9000bh;
	}

	public String getComiso9000bh(){
		return comiso9000bh;
	}

	public void setComiso9000fzdw(String comiso9000fzdw){
		this.comiso9000fzdw=comiso9000fzdw;
	}

	public String getComiso9000fzdw(){
		return comiso9000fzdw;
	}

	public void setComzdmj(BigDecimal comzdmj){
		this.comzdmj=comzdmj;
	}

	public BigDecimal getComzdmj(){
		return comzdmj;
	}

	public void setComjzmj(BigDecimal comjzmj){
		this.comjzmj=comjzmj;
	}

	public BigDecimal getComjzmj(){
		return comjzmj;
	}

	public void setComyysj(String comyysj){
		this.comyysj=comyysj;
	}

	public String getComyysj(){
		return comyysj;
	}

	public void setComfxdj(String comfxdj){
		this.comfxdj=comfxdj;
	}

	public String getComfxdj(){
		return comfxdj;
	}

	public void setCommcjc(String commcjc){
		this.commcjc=commcjc;
	}

	public String getCommcjc(){
		return commcjc;
	}

	public void setComdaleiname(String comdaleiname){
		this.comdaleiname=comdaleiname;
	}

	public String getComdaleiname(){
		return comdaleiname;
	}

	public void setComxiaoleiname(String comxiaoleiname){
		this.comxiaoleiname=comxiaoleiname;
	}

	public String getComxiaoleiname(){
		return comxiaoleiname;
	}
	
	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getComxkfw() {
		return comxkfw;
	}

	public void setComxkfw(String comxkfw) {
		this.comxkfw = comxkfw;
	}

	public Timestamp getComxkyxqq() {
		return comxkyxqq;
	}

	public void setComxkyxqq(Timestamp comxkyxqq) {
		this.comxkyxqq = comxkyxqq;
	}

	public Timestamp getComxkyxqz() {
		return comxkyxqz;
	}

	public void setComxkyxqz(Timestamp comxkyxqz) {
		this.comxkyxqz = comxkyxqz;
	}

	public String getOutercomid() {
		return outercomid;
	}

	public void setOutercomid(String outercomid) {
		this.outercomid = outercomid;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getQueryall() {
		return queryall;
	}

	public void setQueryall(String queryall) {
		this.queryall = queryall;
	}

	public Timestamp getSjdatatime() {
		return sjdatatime;
	}

	public void setSjdatatime(Timestamp sjdatatime) {
		this.sjdatatime = sjdatatime;
	}

	public String getSjdatacomid() {
		return sjdatacomid;
	}

	public void setSjdatacomid(String sjdatacomid) {
		this.sjdatacomid = sjdatacomid;
	}

	public String getSjdatacomdm() {
		return sjdatacomdm;
	}

	public void setSjdatacomdm(String sjdatacomdm) {
		this.sjdatacomdm = sjdatacomdm;
	}
	public String getComxyzb() {
		return comxyzb;
	}

	public void setComxyzb(String comxyzb) {
		this.comxyzb = comxyzb;
	}

	public String getHavezzzm() {
		return havezzzm;
	}

	public void setHavezzzm(String havezzzm) {
		this.havezzzm = havezzzm;
	}

	public String getPlanid() {
		return planid;
	}

	public void setPlanid(String planid) {
		this.planid = planid;
	}

	public String getZfryzjhm() {
		return zfryzjhm;
	}

	public void setZfryzjhm(String zfryzjhm) {
		this.zfryzjhm = zfryzjhm;
	}

	public String getComxkzbhall() {
		return comxkzbhall;
	}

	public void setComxkzbhall(String comxkzbhall) {
		this.comxkzbhall = comxkzbhall;
	}

	public String getIshavezzzm() {
		return ishavezzzm;
	}

	public void setIshavezzzm(String ishavezzzm) {
		this.ishavezzzm = ishavezzzm;
	}

	public String getQuerytype() {
		return querytype;
	}

	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}

	public String getYyzzh() {
		return yyzzh;
	}

	public void setYyzzh(String yyzzh) {
		this.yyzzh = yyzzh;
	}

	public String getHavepdlevel() {
		return havepdlevel;
	}

	public void setHavepdlevel(String havepdlevel) {
		this.havepdlevel = havepdlevel;
	}

	public String getCamorgid() {
		return camorgid;
	}

	public void setCamorgid(String camorgid) {
		this.camorgid = camorgid;
	}

	public String getComcameraflag() {
		return comcameraflag;
	}

	public void setComcameraflag(String comcameraflag) {
		this.comcameraflag = comcameraflag;
	}

	public String getComrcjdglrymc() {
		return comrcjdglrymc;
	}

	public void setComrcjdglrymc(String comrcjdglrymc) {
		this.comrcjdglrymc = comrcjdglrymc;
	}

	public String getLhfjndpddj() {
		return lhfjndpddj;
	}

	public void setLhfjndpddj(String lhfjndpddj) {
		this.lhfjndpddj = lhfjndpddj;
	}
}