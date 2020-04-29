package com.askj.zfba.dto;

/**
 * @Description  ZFAJZFWS的中文含义是: 案件对应的执法文书; InnoDB free: 11264 kBDTO
 * @Creation     2016/02/22 15:25:12
 * @Written      Create Tool By zjf 
 **/
public class ZfajzfwsDTO {
	/**
	 * @Description baoqingyiyuebz的中文含义是： 
	 */
	private String baoqingyiyuebz;		
	
	/**
	 * @Description userid的中文含义是： 
	 */
	private String userid;	
	
	/**
	 * @Description zfwsmbid的中文含义是： 
	 */
	private String zfwsmbid;	
	
	
	
	/**
	 * @Description zfwsurl的中文含义是： 执法文书编辑界面对应的URL
	 */
	private String zfwsurl;	
	
	/**
	 * @Description zfwsycfjzs的中文含义是已传附件张数： 
	 */
	private Integer zfwsycfjzs;	
	/**
	 * @Description fjcsidlist的中文含义是： 添加文书时用
	 */
	private String fjcsdmzlist;	
	/**
	 * @Description fjcszfwstitle的中文含义是： 执法文书标题，一些公用文书用到
	 */
	private String fjcszfwstitle;	
	
	/**
	 * @Description zfwsuserid的中文含义是： 操作员ID
	 */
	private String zfwsuserid;

	/**
	 * @Description zfwsczyxm的中文含义是： 操作员姓名
	 */
	private String zfwsczyxm;

	/**
	 * @Description zfwsczsj的中文含义是： 操作时间
	 */
	private String zfwsczsj;

	/**
	 * @Description psbh的中文含义是： 流程编码
	 */
	private String psbh;

	/**
	 * @Description nodeid的中文含义是： 流程节点ID
	 */
	private String nodeid;	
	
	/**
	 * @Description nodename的中文含义是： 流程节点名称
	 */
	private String nodename;

	/**
	 * @Description ajzfwsid的中文含义是： 
	 */
	private String ajzfwsid;

	/**
	 * @Description ajdjid的中文含义是： 案件登记ID
	 */
	private String ajdjid;

	/**
	 * @Description zfwsbh的中文含义是： 执法文书编号，代码表中的编号
	 */
	private String zfwsdmz;

	/**
	 * @Description zfwsqtbid的中文含义是： 执法文书所在表ID
	 */
	private String zfwsqtbid;

	/**
	 * @Description zfwstzbz的中文含义是： 执法文书填写标志0未1已
	 */
	private String zfwstzbz;
	private String fytzbz;

	public String getFytzbz() {
		return fytzbz;
	}

	public void setFytzbz(String fytzbz) {
		this.fytzbz = fytzbz;
	}

	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	private Integer fjcsid;

	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	private String fjcsdmlb;

	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	private String fjcsdmlbmc;

	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	private String fjcsdmz;

	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	private String fjcsdmmc;

	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	private String fjcsksrq;

	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	private String fjcszzrq;

	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	private String fjcsqyflag;

	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	private String fjcsfjbc;					
	
	
	

	
		/**
	 * @Description ajzfwsid的中文含义是： 
	 */
	public void setAjzfwsid(String ajzfwsid){ 
		this.ajzfwsid = ajzfwsid;
	}
	/**
	 * @Description ajzfwsid的中文含义是： 
	 */
	public String getAjzfwsid(){
		return ajzfwsid;
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

	public String getZfwsdmz() {
		return zfwsdmz;
	}
	public void setZfwsdmz(String zfwsdmz) {
		this.zfwsdmz = zfwsdmz;
	}
	public String getZfwsqtbid() {
		return zfwsqtbid;
	}
	public void setZfwsqtbid(String zfwsqtbid) {
		this.zfwsqtbid = zfwsqtbid;
	}
	/**
	 * @Description zfwstzbz的中文含义是： 执法文书填写标志0未1已
	 */
	public void setZfwstzbz(String zfwstzbz){ 
		this.zfwstzbz = zfwstzbz;
	}
	/**
	 * @Description zfwstzbz的中文含义是： 执法文书填写标志0未1已
	 */
	public String getZfwstzbz(){
		return zfwstzbz;
	}
	public Integer getFjcsid() {
		return fjcsid;
	}
	public void setFjcsid(Integer fjcsid) {
		this.fjcsid = fjcsid;
	}
	public String getFjcsdmlb() {
		return fjcsdmlb;
	}
	public void setFjcsdmlb(String fjcsdmlb) {
		this.fjcsdmlb = fjcsdmlb;
	}
	public String getFjcsdmlbmc() {
		return fjcsdmlbmc;
	}
	public void setFjcsdmlbmc(String fjcsdmlbmc) {
		this.fjcsdmlbmc = fjcsdmlbmc;
	}
	public String getFjcsdmz() {
		return fjcsdmz;
	}
	public void setFjcsdmz(String fjcsdmz) {
		this.fjcsdmz = fjcsdmz;
	}
	public String getFjcsdmmc() {
		return fjcsdmmc;
	}
	public void setFjcsdmmc(String fjcsdmmc) {
		this.fjcsdmmc = fjcsdmmc;
	}
	public String getFjcsksrq() {
		return fjcsksrq;
	}
	public void setFjcsksrq(String fjcsksrq) {
		this.fjcsksrq = fjcsksrq;
	}
	public String getFjcszzrq() {
		return fjcszzrq;
	}
	public void setFjcszzrq(String fjcszzrq) {
		this.fjcszzrq = fjcszzrq;
	}
	public String getFjcsqyflag() {
		return fjcsqyflag;
	}
	public void setFjcsqyflag(String fjcsqyflag) {
		this.fjcsqyflag = fjcsqyflag;
	}
	public String getFjcsfjbc() {
		return fjcsfjbc;
	}
	public void setFjcsfjbc(String fjcsfjbc) {
		this.fjcsfjbc = fjcsfjbc;
	}
	public Integer getZfwsycfjzs() {
		return zfwsycfjzs;
	}
	public void setZfwsycfjzs(Integer zfwsycfjzs) {
		this.zfwsycfjzs = zfwsycfjzs;
	}
	public String getFjcsdmzlist() {
		return fjcsdmzlist;
	}
	public void setFjcsdmzlist(String fjcsdmzlist) {
		this.fjcsdmzlist = fjcsdmzlist;
	}
	public String getZfwsurl() {
		return zfwsurl;
	}
	public void setZfwsurl(String zfwsurl) {
		this.zfwsurl = zfwsurl;
	}
	public String getFjcszfwstitle() {
		return fjcszfwstitle;
	}
	public void setFjcszfwstitle(String fjcszfwstitle) {
		this.fjcszfwstitle = fjcszfwstitle;
	}
	public String getZfwsuserid() {
		return zfwsuserid;
	}
	public void setZfwsuserid(String zfwsuserid) {
		this.zfwsuserid = zfwsuserid;
	}
	public String getZfwsczyxm() {
		return zfwsczyxm;
	}
	public void setZfwsczyxm(String zfwsczyxm) {
		this.zfwsczyxm = zfwsczyxm;
	}
	public String getZfwsczsj() {
		return zfwsczsj;
	}
	public void setZfwsczsj(String zfwsczsj) {
		this.zfwsczsj = zfwsczsj;
	}
	public String getPsbh() {
		return psbh;
	}
	public void setPsbh(String psbh) {
		this.psbh = psbh;
	}
	public String getNodeid() {
		return nodeid;
	}
	public void setNodeid(String nodeid) {
		this.nodeid = nodeid;
	}
	public String getNodename() {
		return nodename;
	}
	public void setNodename(String nodename) {
		this.nodename = nodename;
	}
	public String getZfwsmbid() {
		return zfwsmbid;
	}
	public void setZfwsmbid(String zfwsmbid) {
		this.zfwsmbid = zfwsmbid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getBaoqingyiyuebz() {
		return baoqingyiyuebz;
	}
	public void setBaoqingyiyuebz(String baoqingyiyuebz) {
		this.baoqingyiyuebz = baoqingyiyuebz;
	}

}