package com.askj.baseinfo.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Readonly;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Date;

/**
 * @Description  PcompanyComdalei的中文含义是: 企业分类对照表
 * @Creation     2016/09/28 11:28:27
 * @Written      Create Tool By sunyifeng
 **/
@Table(value = "pcompanycomdalei")
public class PcompanyComdalei {
	//扩展开始
    
    /**
     * @Description comdaleiname 的中文含义是：所属大类汉字描述
     */
    @Column
    @Readonly
    private String comdaleiname ;   
    
	//扩展结束
    /**
     * @Description comdaleiid 的中文含义是： 企业所属大类ID
     */
    @Column
    @Name
    private String comdaleiid ;
    /**
     * @Description comid的中文含义是： 企业ID
     */
    @Column
    private String comid;
    /**
     * @Description comdalei 的中文含义是：所属大类编号
     */
    @Column
    private String comdalei ;

    /**
     * @Description comdalei 的中文含义是：代码ID
     */
    @Column
    private String aaz093;

    public String getAaz093() {
        return aaz093;
    }

    public void setAaz093(String aaz093) {
        this.aaz093 = aaz093;
    }

    public String getComdaleiid() {
        return comdaleiid;
    }

    public void setComdaleiid(String comdaleiid) {
        this.comdaleiid = comdaleiid;
    }

    public String getComid() {
        return comid;
    }

    public void setComid(String comid) {
        this.comid = comid;
    }

    public String getComdalei() {
        return comdalei;
    }

    public void setComdalei(String comdalei) {
        this.comdalei = comdalei;
    }

	public String getComdaleiname() {
		return comdaleiname;
	}

	public void setComdaleiname(String comdaleiname) {
		this.comdaleiname = comdaleiname;
	}
    
    
}
