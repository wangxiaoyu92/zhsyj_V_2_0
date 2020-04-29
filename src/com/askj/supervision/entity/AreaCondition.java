package com.askj.supervision.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * @Description  AreaCondition 的中文含义是： 区域情况
 * Created by ce on 2018/5/12.
 */
@Table(value = "AREACONDITION")
public class AreaCondition {

    //区域编码
    @Column(value="aaa027")
    @Name
    private String aaa027;
    //描述
    @Column(value="text")
    private String text;
    //经度坐标
    @Column(value="jdzb")
    private String jdzb;
    //纬度坐标
    @Column(value="wdzb")
    private String wdzb;

    public String getAaa027() {
        return aaa027;
    }

    public void setAaa027(String aaa027) {
        this.aaa027 = aaa027;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getJdzb() {
        return jdzb;
    }

    public void setJdzb(String jdzb) {
        this.jdzb = jdzb;
    }

    public String getWdzb() {
        return wdzb;
    }

    public void setWdzb(String wdzb) {
        this.wdzb = wdzb;
    }
}
