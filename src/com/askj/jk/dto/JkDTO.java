package com.askj.jk.dto;

/**
 * @Description  JK的中文含义是: 监控表DTO
 * @Creation     2016/02/25 11:39:52
 * @Written      Create Tool By zjf 
 **/
public class JkDTO {
	//扩展开始
	/**
	 * @Description comspjkbz的中文含义是： 视频监控标志
	 */
	private String comspjkbz;
	/**
	 * @Description comcameraflag的中文含义是： 摄像头标志
	 */
	private String querytype;
	/**
	 * @Description outercomid： 舌尖安全网对应的企业id
	 */
	private String outercomid;
	//扩展结束

	/**
	 * @Description comcameraflag的中文含义是： 摄像头标志
	 */
	private String comcameraflag;
	/**
	 * @Description jkid的中文含义是： 监控ID
	 */
	private String jkid;

	/**
	 * @Description jkymc的中文含义是： 监控源名称
	 */
	private String jkymc;

	/**
	 * @Description jkybh的中文含义是： 监控源编号
	 */
	private String jkybh;

	/**
	 * @Description jkqybh的中文含义是： 监控企业编号
	 */
	private String jkqybh;

	/**
	 * @Description jkqymc的中文含义是： 监控企业名称
	 */
	private String jkqymc;
	
	/**
	 * @Description jklx的中文含义是： 监控类型
	 */
	private String jklx;
	
	/**
	 * @Description jksppath的中文含义是： 离线监控视频文件路径
	 */
	private String jksppath;

	/**
	 * @Description orderno的中文含义是：排序
	 */
	private Integer orderno;

	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	private String aaa027;
	
	/**
	 * @Description orgname的中文含义是： 统筹区名称
	 */
	private String aaa027name;
	/**
	 * @Description aaa027的中文含义是： 明厨亮灶监控对象id
	 */
	private String camorgid;
	
	private String message;

	private String succJsonStr;

	private String errorJsonStr;

	private String filepath;
	private String comdz;
	
	/**
	 * 是否指派监管员，手动添加
	 */
	private String ishavejgy;
	
	public String getIshavejgy() {
		return ishavejgy;
	}
	public void setIshavejgy(String ishavejgy) {
		this.ishavejgy = ishavejgy;
	}


	/**
	 * @Description comdalei的中文含义是： 企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营
	 */
	private String comdalei;
	
		/**
	 * @Description jkid的中文含义是： 监控ID
	 */
	public void setJkid(String jkid){ 
		this.jkid = jkid;
	}
	/**
	 * @Description jkid的中文含义是： 监控ID
	 */
	public String getJkid(){
		return jkid;
	}
	/**
	 * @Description jkymc的中文含义是： 监控源名称
	 */
	public void setJkymc(String jkymc){ 
		this.jkymc = jkymc;
	}
	/**
	 * @Description jkymc的中文含义是： 监控源名称
	 */
	public String getJkymc(){
		return jkymc;
	}
	/**
	 * @Description jkybh的中文含义是： 监控源编号
	 */
	public void setJkybh(String jkybh){ 
		this.jkybh = jkybh;
	}
	/**
	 * @Description jkybh的中文含义是： 监控源编号
	 */
	public String getJkybh(){
		return jkybh;
	}
	/**
	 * @Description jkqybh的中文含义是： 监控企业编号
	 */
	public void setJkqybh(String jkqybh){ 
		this.jkqybh = jkqybh;
	}
	/**
	 * @Description jkqybh的中文含义是： 监控企业编号
	 */
	public String getJkqybh(){
		return jkqybh;
	}
	/**
	 * @Description jkqymc的中文含义是： 监控企业名称
	 */
	public void setJkqymc(String jkqymc){ 
		this.jkqymc = jkqymc;
	}
	/**
	 * @Description jkqymc的中文含义是： 监控企业名称
	 */
	public String getJkqymc(){
		return jkqymc;
	}
	/**
	 * @Description jklx的中文含义是： 监控类型
	 */
	public String getJklx() {
		return jklx;
	}
	/**
	 * @Description jklx的中文含义是： 监控类型
	 */
	public void setJklx(String jklx) {
		this.jklx = jklx;
	}
	/**
	 * @Description jksppath的中文含义是： 离线监控视频文件路径
	 */
	public String getJksppath() {
		return jksppath;
	}
	/**
	 * @Description jksppath的中文含义是： 离线监控视频文件路径
	 */
	public void setJksppath(String jksppath) {
		this.jksppath = jksppath;
	}
	/**
	 * @Description orderno的中文含义是：排序
	 */
	public Integer getOrderno() {
		return orderno;
	}
	/**
	 * @Description orderno的中文含义是：排序
	 */
	public void setOrderno(Integer orderno) {
		this.orderno = orderno;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public void setAaa027(String aaa027){ 
		this.aaa027 = aaa027;
	}
	/**
	 * @Description aaa027的中文含义是： 统筹区编码
	 */
	public String getAaa027(){
		return aaa027;
	}
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
	/**
	 * @Description aaa027的中文含义是： 明厨亮灶监控对象id
	 */
	public String getCamorgid() {
		return camorgid;
	}
	/**
	 * @Description aaa027的中文含义是： 明厨亮灶监控对象id
	 */
	public void setCamorgid(String camorgid) {
		this.camorgid = camorgid;
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

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	
	/**
	 * @Description comdalei的中文含义是： 企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营
	 */
	public void setComdalei(String comdalei){ 
		this.comdalei = comdalei;
	}
	/**
	 * @Description comdalei的中文含义是： 企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营
	 */
	public String getComdalei(){
		return comdalei;
	}
	public String getComdz() {
		return comdz;
	}
	public void setComdz(String comdz) {
		this.comdz = comdz;
	}


	/**
	 * @Description state的中文含义是： 摄像头状态
	 */
	private String state;
	
	/**
	 * @Description synchtime的中文含义是： 对方系统企业同步时间
	 */
	private String synchtime;
	
	/**
	 * @Description state的中文含义是： 摄像头状态
	 */
	public void setState(String state){ 
		this.state = state;
	}
	/**
	 * @Description state的中文含义是： 摄像头状态
	 */
	public String getState(){
		return state;
	}
	/**
	 * @Description synchtime的中文含义是： 对方系统企业同步时间
	 */
	public void setSynchtime(String synchtime){ 
		this.synchtime = synchtime;
	}
	/**
	 * @Description synchtime的中文含义是： 对方系统企业同步时间
	 */
	public String getSynchtime(){
		return synchtime;
	}

	public String getComcameraflag() {
		return comcameraflag;
	}
	public void setComcameraflag(String comcameraflag) {
		this.comcameraflag = comcameraflag;
	}

	public String getQuerytype() {
		return querytype;
	}

	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}

	public String getOutercomid() {
		return outercomid;
	}

	public void setOutercomid(String outercomid) {
		this.outercomid = outercomid;
	}

	public String getComspjkbz() {
		return comspjkbz;
	}

	public void setComspjkbz(String comspjkbz) {
		this.comspjkbz = comspjkbz;
	}
}