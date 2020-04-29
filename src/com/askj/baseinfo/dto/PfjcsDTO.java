package com.askj.baseinfo.dto;

/**
 * @Description  PFJCS的中文含义是: 附件参数表; InnoDB free: 11264 kBDTO
 * @Creation     2016/02/01 15:56:05
 * @Written      Create Tool By zjf 
 **/
public class PfjcsDTO {
	//扩展开始
	/**
	 * @Description ajdjid的中文含义是： 案件登记
	 */
	private String ajdjid;
	/**
	 * @Description havefillcount的中文含义是： 改案件登记id已填写该文书数
	 */
	private String havefill;
	//扩展结束
	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	private String fjcsid;

	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	private String fjcsdmlb;
	
	/**
	 * @Description zfwsurl的中文含义是： 执法文书编辑界面对应的URL
	 */
	private String zfwsurl;	

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
	 * @Description fjcszfwstitle的中文含义是： 执法文书标题，一些公用文书用到
	 */
	private String fjcszfwstitle;	
	
	/**
	 * @Description zfwstabname的中文含义是： 执法文书表名
	 */
	private String zfwstabname;	
	
	/**
	 * @Description zfwstabid的中文含义是： 执法文书表主键ID
	 */
	private String zfwstabid;

	public String getZfwsqtbid() {
		return zfwsqtbid;
	}

	public void setZfwsqtbid(String zfwsqtbid) {
		this.zfwsqtbid = zfwsqtbid;
	}

	private String zfwsqtbid;
	private String ajzfwsid;
	private String havefy;

	public String getHavefy() {
		return havefy;
	}

	public void setHavefy(String havefy) {
		this.havefy = havefy;
	}

	public String getAjzfwsid() {
		return ajzfwsid;
	}

	public void setAjzfwsid(String ajzfwsid) {
		this.ajzfwsid = ajzfwsid;
	}

	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	public void setFjcsid(String fjcsid){ 
		this.fjcsid = fjcsid;
	}
	/**
	 * @Description fjcsid的中文含义是： 附件参数表ID
	 */
	public String getFjcsid(){
		return fjcsid;
	}
	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	public void setFjcsdmlb(String fjcsdmlb){ 
		this.fjcsdmlb = fjcsdmlb;
	}
	/**
	 * @Description fjcsdmlb的中文含义是： 代码类别
	 */
	public String getFjcsdmlb(){
		return fjcsdmlb;
	}
	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	public void setFjcsdmlbmc(String fjcsdmlbmc){ 
		this.fjcsdmlbmc = fjcsdmlbmc;
	}
	/**
	 * @Description fjcsdmlbmc的中文含义是： 代码类别名称
	 */
	public String getFjcsdmlbmc(){
		return fjcsdmlbmc;
	}
	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	public void setFjcsdmz(String fjcsdmz){ 
		this.fjcsdmz = fjcsdmz;
	}
	/**
	 * @Description fjcsdmz的中文含义是： 代码值
	 */
	public String getFjcsdmz(){
		return fjcsdmz;
	}
	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	public void setFjcsdmmc(String fjcsdmmc){ 
		this.fjcsdmmc = fjcsdmmc;
	}
	/**
	 * @Description fjcsdmmc的中文含义是： 代码名称
	 */
	public String getFjcsdmmc(){
		return fjcsdmmc;
	}
	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	public void setFjcsksrq(String fjcsksrq){ 
		this.fjcsksrq = fjcsksrq;
	}
	/**
	 * @Description fjcsksrq的中文含义是： 开始日期
	 */
	public String getFjcsksrq(){
		return fjcsksrq;
	}
	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	public void setFjcszzrq(String fjcszzrq){ 
		this.fjcszzrq = fjcszzrq;
	}
	/**
	 * @Description fjcszzrq的中文含义是： 终止日期
	 */
	public String getFjcszzrq(){
		return fjcszzrq;
	}
	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	public void setFjcsqyflag(String fjcsqyflag){ 
		this.fjcsqyflag = fjcsqyflag;
	}
	/**
	 * @Description fjcsqyflag的中文含义是： 启用标志1启用0未启用
	 */
	public String getFjcsqyflag(){
		return fjcsqyflag;
	}
	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	public void setFjcsfjbc(String fjcsfjbc){ 
		this.fjcsfjbc = fjcsfjbc;
	}
	/**
	 * @Description fjcsfjbc的中文含义是： 附件上传类型专用0不是必须传1必须传
	 */
	public String getFjcsfjbc(){
		return fjcsfjbc;
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
	public String getZfwstabname() {
		return zfwstabname;
	}
	public void setZfwstabname(String zfwstabname) {
		this.zfwstabname = zfwstabname;
	}
	public String getZfwstabid() {
		return zfwstabid;
	}
	public void setZfwstabid(String zfwstabid) {
		this.zfwstabid = zfwstabid;
	}


	public String getAjdjid() {
		return ajdjid;
	}

	public void setAjdjid(String ajdjid) {
		this.ajdjid = ajdjid;
	}

	public String getHavefill() {
		return havefill;
	}

	public void setHavefill(String havefill) {
		this.havefill = havefill;
	}
}