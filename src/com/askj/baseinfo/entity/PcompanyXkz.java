package com.askj.baseinfo.entity;

import java.sql.Date;
import java.sql.Timestamp;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  PcompanyXkzDTO的中文含义是: 企业许可或者资质证DTO
 * @Creation     2016/09/28 11:28:27
 * @Written      Create Tool By sunyifeng
 **/
@Table(value = "pcompanyxkz")
public class PcompanyXkz {
    /**
     * @Description comxkzid的中文含义是： 企业许可或者资质证ID
     */
    @Column
    @Name
    private String comxkzid;
    /**
     * @Description comid的中文含义是： 企业ID
     */
    @Column
    private String comid;
    /**
     * @Description comxkzbh的中文含义是： 编号
     */
    @Column
    private String comxkzbh;
    /**
     * @Description comxkfw的中文含义是： 范围
     */
    @Column
    private String comxkfw;
    /**
     * @Description comxkyxqq的中文含义是： 有效期起
     */
    @Column
    private Date comxkyxqq;
    /**
     * @Description comxkyxqz的中文含义是： 许可有效期止
     */
    @Column
    private Date comxkyxqz;

    /**
     * @Description comxkzlx的中文含义是： 许可类型
     */
    @Column
    private String comxkzlx;
    
    /**
     * @Description comxkzzcxs的中文含义是： 许可组成形式
     */
    @Column
    private String comxkzzcxs;   
    
    /**
     * @Description comxkzztyt的中文含义是： 主题业态
     */
    @Column
    private String comxkzztyt; 
    
    /**
     * @Description comxkzztyt的中文含义是： 主体业态
     */
    @Column
    private String comxkzjycs;    
    
	/**
	 * @Description sjdatatime的中文含义是：省局数据同步时间
	 */
	@Column
	private Timestamp sjdatatime;
	
	/**
	 * @Description sjdataid的中文含义是：省局数据主键
	 */
	@Column
	private String sjdataid;	
	
	/**
	 * @Description sjdatacomdm的中文含义是：省局数据企业代码
	 */
	@Column
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
    
    
}
