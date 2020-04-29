package com.askj.baseinfo.dto;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * @Description  PcompanyXkzDTO的中文含义是: 企业许可或者资质证DTO
 * @Creation     2016/09/28 11:28:27
 * @Written      Create Tool By sunyifeng
 **/
public class PcompanyXkzDTO {
	//扩展开始
	/**
	 * 一个方法被多个地方调用，这个表示是那个地方用，以区别处理
	 */
	private String operatetype;
	//commc
	private String userid;
	//commc
	private String sjordnbz;
	//commc
	private String rcjdglry;
	//commc
	private String jycs;
	//commc
	private String fddbr;
	//commc
	private String commc;
	//qrcodecontent手机扫描的许可证上二维码内容
	private String qrcodecontent;
	//资质证明照路径
    private String zzzmpath;
	//资质证明头照名称
    private String zzzmname;
    //扩展结束
    
    /**
     * @Description comxkzid的中文含义是： 企业许可或者资质证ID
     */
    private String comxkzid;
    /**
     * @Description comid的中文含义是： 企业ID
     */
    private String comid;
    /**
     * @Description comxkzbh的中文含义是： 编号
     */
    private String comxkzbh;
    /**
     * @Description comxkfw的中文含义是： 范围
     */
    private String comxkfw;
    /**
     * @Description comxkyxqq的中文含义是： 有效期起
     */
    private Date comxkyxqq;
    /**
     * @Description comxkyxqz的中文含义是： 许可有效期止
     */
    private Date comxkyxqz;

    /**
     * @Description comxkzlx的中文含义是： 许可类型
     */
    private String comxkzlx;
    
    /**
     * @Description comxkzlxstr的中文含义是： 许可类型对应汉字
     */
    private String comxkzlxstr;

	/**
	 * @Description comxkzztytstr的中文含义是： 主体业态对应汉字
	 */
	private String comxkzztytstr;
    
    /**
     * @Description comxkzzcxs的中文含义是： 许可组成形式
     */
    private String comxkzzcxs;   
    
    /**
     * @Description comxkzztyt的中文含义是： 主题业态
     */
    private String comxkzztyt;   
    
    /**
     * @Description comxkzjycs的中文含义是： 经营场所
     */
    private String comxkzjycs;   
    
	/**
	 * @Description sjdatatime的中文含义是：省局数据同步时间
	 */
	private Timestamp sjdatatime;
	
	/**
	 * @Description sjdataid的中文含义是：省局数据主键
	 */
	private String sjdataid;	
	
	/**
	 * @Description sjdatacomdm的中文含义是：省局数据企业代码
	 */
	private String sjdatacomdm;	    

    public String getComxkzlx() {
        return comxkzlx;
    }

    public void setComxkzlx(String comxkzlx) {
        this.comxkzlx = comxkzlx;
    }

    public String getComxkzid() {
        return comxkzid;
    }

    public void setComxkzid(String comxkzid) {
        this.comxkzid = comxkzid;
    }

    public String getComid() {
        return comid;
    }

    public void setComid(String comid) {
        this.comid = comid;
    }

    public String getComxkzbh() {
        return comxkzbh;
    }

    public void setComxkzbh(String comxkzbh) {
        this.comxkzbh = comxkzbh;
    }

    public String getComxkfw() {
        return comxkfw;
    }

    public void setComxkfw(String comxkfw) {
        this.comxkfw = comxkfw;
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

	public String getComxkzlxstr() {
		return comxkzlxstr;
	}

	public void setComxkzlxstr(String comxkzlxstr) {
		this.comxkzlxstr = comxkzlxstr;
	}

	public String getComxkzjycs() {
		return comxkzjycs;
	}

	public void setComxkzjycs(String comxkzjycs) {
		this.comxkzjycs = comxkzjycs;
	}

	public String getZzzmpath() {
		return zzzmpath;
	}

	public void setZzzmpath(String zzzmpath) {
		this.zzzmpath = zzzmpath;
	}

	public String getZzzmname() {
		return zzzmname;
	}

	public void setZzzmname(String zzzmname) {
		this.zzzmname = zzzmname;
	}

	public Date getComxkyxqq() {
		return comxkyxqq;
	}

	public void setComxkyxqq(Date comxkyxqq) {
		this.comxkyxqq = comxkyxqq;
	}

	public Date getComxkyxqz() {
		return comxkyxqz;
	}

	public void setComxkyxqz(Date comxkyxqz) {
		this.comxkyxqz = comxkyxqz;
	}



	public Timestamp getSjdatatime() {
		return sjdatatime;
	}

	public void setSjdatatime(Timestamp sjdatatime) {
		this.sjdatatime = sjdatatime;
	}

	public String getSjdataid() {
		return sjdataid;
	}

	public void setSjdataid(String sjdataid) {
		this.sjdataid = sjdataid;
	}

	public String getSjdatacomdm() {
		return sjdatacomdm;
	}

	public void setSjdatacomdm(String sjdatacomdm) {
		this.sjdatacomdm = sjdatacomdm;
	}

	public String getComxkzztytstr() {
		return comxkzztytstr;
	}

	public void setComxkzztytstr(String comxkzztytstr) {
		this.comxkzztytstr = comxkzztytstr;
	}

	public String getQrcodecontent() {
		return qrcodecontent;
	}

	public void setQrcodecontent(String qrcodecontent) {
		this.qrcodecontent = qrcodecontent;
	}

	public String getCommc() {
		return commc;
	}

	public void setCommc(String commc) {
		this.commc = commc;
	}

	public String getFddbr() {
		return fddbr;
	}

	public void setFddbr(String fddbr) {
		this.fddbr = fddbr;
	}

	public String getJycs() {
		return jycs;
	}

	public void setJycs(String jycs) {
		this.jycs = jycs;
	}

	public String getRcjdglry() {
		return rcjdglry;
	}

	public void setRcjdglry(String rcjdglry) {
		this.rcjdglry = rcjdglry;
	}

	public String getSjordnbz() {
		return sjordnbz;
	}

	public void setSjordnbz(String sjordnbz) {
		this.sjordnbz = sjordnbz;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getOperatetype() {
		return operatetype;
	}

	public void setOperatetype(String operatetype) {
		this.operatetype = operatetype;
	}
}