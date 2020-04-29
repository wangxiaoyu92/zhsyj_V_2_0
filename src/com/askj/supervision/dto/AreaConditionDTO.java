package com.askj.supervision.dto;

/**
 * Created by ce on 2018/5/12.
 */
public class AreaConditionDTO {
    /** aaa027 的中文含义是：区域编码*/
    private String aaa027;
    /** text 的中文含义是：描述*/
    private String text;
    /** jdzb 的中文含义是：经度坐标*/
    private String jdzb;
    /** wdzb 的中文含义是：纬度坐标*/
    private String wdzb;

    public String getAdd() {
        return add;
    }

    public void setAdd(String add) {
        this.add = add;
    }

    private String add;

    public String getAaa027name() {
        return aaa027name;
    }

    public void setAaa027name(String aaa027name) {
        this.aaa027name = aaa027name;
    }

    /** aaa027name 的中文含义是：区域名称*/
    private String aaa027name;

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
