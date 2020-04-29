package com.askj.jyjc.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  JYCJSSXZJCXM的中文含义是: 安全监督抽检实施细则对应的检测项目表;
 * Created by ce on 2018/5/18.
 */
@Table(value = "JYCJSSXZJCXM")
public class Jycjssxzjcxm {

    /**
     * @Description jycjssxzjcxmid的中文含义是： 安全监督抽检实施细则对应的检测项目表id
     */
    @Column
    @Name
    private String jycjssxzjcxmid;

    /**
     * @Description jycjssxzid的中文含义是： 安全监督抽检实施细则id
     */
    @Column
    private String jycjssxzid;

    /**
     * @Description jyjcxmid的中文含义是： 检验检测项目表id
     */
    @Column
    private String jyjcxmid;

    /**
     * @Description aae011的中文含义是： 操作员
     */
    @Column
    private String aae011;

    /**
     * @Description aae036的中文含义是： 操作时间
     */
    @Column
    private String aae036;

    public String getJycjssxzjcxmid() {
        return jycjssxzjcxmid;
    }

    public void setJycjssxzjcxmid(String jycjssxzjcxmid) {
        this.jycjssxzjcxmid = jycjssxzjcxmid;
    }

    public String getJycjssxzid() {
        return jycjssxzid;
    }

    public void setJycjssxzid(String jycjssxzid) {
        this.jycjssxzid = jycjssxzid;
    }

    public String getJyjcxmid() {
        return jyjcxmid;
    }

    public void setJyjcxmid(String jyjcxmid) {
        this.jyjcxmid = jyjcxmid;
    }

    public String getAae011() {
        return aae011;
    }

    public void setAae011(String aae011) {
        this.aae011 = aae011;
    }

    public String getAae036() {
        return aae036;
    }

    public void setAae036(String aae036) {
        this.aae036 = aae036;
    }
}
