package com.askj.jyjc.dto;

/**
 * @Description  JYJCXM的中文含义是: 检验检查项目表; InnoDB free: 2757632 kBDTO
 * @Creation     2016/05/05 10:17:06
 * @Written      Create Tool By zjf 
 **/
public class JyjcxmDTO {
	private String jyjcxmjcbzid;
	private String jyjcjcbzbid;
	private String jyjcxmjcffbz;
	private String jyjcffbzbid;
	private String bzbh;
	private String jcffbzbh;
	private String jcxmmcjc;
	private String jyjcxmlx;
	private String sfmulu;

	public String getJcxmmcjc() {
		return jcxmmcjc;
	}

	public void setJcxmmcjc(String jcxmmcjc) {
		this.jcxmmcjc = jcxmmcjc;
	}

	public String getBzbh() {
		return bzbh;
	}

	public void setBzbh(String bzbh) {
		this.bzbh = bzbh;
	}

	public String getJcffbzbh() {
		return jcffbzbh;
	}

	public void setJcffbzbh(String jcffbzbh) {
		this.jcffbzbh = jcffbzbh;
	}

	public String getJyjcxmjcbzid() {
		return jyjcxmjcbzid;
	}

	public void setJyjcxmjcbzid(String jyjcxmjcbzid) {
		this.jyjcxmjcbzid = jyjcxmjcbzid;
	}

	public String getJyjcjcbzbid() {
		return jyjcjcbzbid;
	}

	public void setJyjcjcbzbid(String jyjcjcbzbid) {
		this.jyjcjcbzbid = jyjcjcbzbid;
	}

	public String getJyjcxmjcffbz() {
		return jyjcxmjcffbz;
	}

	public void setJyjcxmjcffbz(String jyjcxmjcffbz) {
		this.jyjcxmjcffbz = jyjcxmjcffbz;
	}

	public String getJyjcffbzbid() {
		return jyjcffbzbid;
	}

	public void setJyjcffbzbid(String jyjcffbzbid) {
		this.jyjcffbzbid = jyjcffbzbid;
	}

	/**
	 * 以上为追加字段
	 */
	private int childnum;
	// 是否父节点,非映射字段
	private boolean isparent;
	// 是否展开,非映射字段
	private boolean isopen;
	/**
	 * @Description jcxmid的中文含义是： 检测项目ID
	 */
	private String jyjcxmid;

	/**
	 * @Description jcxmbh的中文含义是： 检查项目编号
	 */
	private String jcxmbh;

	/**
	 * @Description jcxmmc的中文含义是： 检查项目父类名称
	 */
	private String jcxmmc;
	/**
	 * @Description jcxmmc的中文含义是： 检查项目名称
	 */
	private String parentname;

	/**
	 * @Description jcxmbzz的中文含义是： 标准值
	 */
	private String jcxmbzz;

	/**
	 * @Description jcxmczy的中文含义是： 操作员
	 */
	private String jcxmczy;

	/**
	 * @Description jcxmczsj的中文含义是： 操作时间
	 */
	private String jcxmczsj;

	private String jcxmparentid;
	/**
	 * @Description sfyx的中文含义是： 是否有效
	 */
	private String sfyx;

	public String getJcxmparentid() {
		return jcxmparentid;
	}

	public void setJcxmparentid(String jcxmparentid) {
		this.jcxmparentid = jcxmparentid;
	}

	public String getJyjcxmid() {
		return jyjcxmid;
	}

	public void setJyjcxmid(String jyjcxmid) {
		this.jyjcxmid = jyjcxmid;
	}

	/**
	 * @Description jcxmbh的中文含义是： 检查项目编号
	 */
	public void setJcxmbh(String jcxmbh){ 
		this.jcxmbh = jcxmbh;
	}
	/**
	 * @Description jcxmbh的中文含义是： 检查项目编号
	 */
	public String getJcxmbh(){
		return jcxmbh;
	}
	/**
	 * @Description jcxmmc的中文含义是： 检查项目名称
	 */
	public void setJcxmmc(String jcxmmc){ 
		this.jcxmmc = jcxmmc;
	}
	/**
	 * @Description jcxmmc的中文含义是： 检查项目名称
	 */
	public String getJcxmmc(){
		return jcxmmc;
	}
	/**
	 * @Description jcxmbzz的中文含义是： 标准值
	 */
	public void setJcxmbzz(String jcxmbzz){ 
		this.jcxmbzz = jcxmbzz;
	}
	/**
	 * @Description jcxmbzz的中文含义是： 标准值
	 */
	public String getJcxmbzz(){
		return jcxmbzz;
	}
	/**
	 * @Description jcxmczy的中文含义是： 操作员
	 */
	public void setJcxmczy(String jcxmczy){ 
		this.jcxmczy = jcxmczy;
	}
	/**
	 * @Description jcxmczy的中文含义是： 操作员
	 */
	public String getJcxmczy(){
		return jcxmczy;
	}
	/**
	 * @Description jcxmczsj的中文含义是： 操作时间
	 */
	public void setJcxmczsj(String jcxmczsj){ 
		this.jcxmczsj = jcxmczsj;
	}
	/**
	 * @Description jcxmczsj的中文含义是： 操作时间
	 */
	public String getJcxmczsj(){
		return jcxmczsj;
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
	public int getChildnum() {
		return childnum;
	}

	public void setChildnum(int childnum) {
		this.childnum = childnum;
	}

	public String getParentname() {
		return parentname;
	}

	public void setParentname(String parentname) {
		this.parentname = parentname;
	}

	public String getSfyx() {
		return sfyx;
	}

	public void setSfyx(String sfyx) {
		this.sfyx = sfyx;
	}

	public String getJyjcxmlx() {
		return jyjcxmlx;
	}

	public void setJyjcxmlx(String jyjcxmlx) {
		this.jyjcxmlx = jyjcxmlx;
	}

	public String getSfmulu() {
		return sfmulu;
	}

	public void setSfmulu(String sfmulu) {
		this.sfmulu = sfmulu;
	}
}