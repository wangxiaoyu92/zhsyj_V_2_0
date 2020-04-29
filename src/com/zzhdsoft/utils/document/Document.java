package com.zzhdsoft.utils.document;

import java.lang.annotation.*;

/**
 * Created by Elfy Suen on 2017/10/17.
 */
public class Document implements Comparable {
    private String name;
    private String desc;
    private String functiondesc;
    private String author;
    private String params;
    private String returndesc;
    private String date;
    private String version;
    private int sort;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getFunctiondesc() {
        return functiondesc;
    }

    public void setFunctiondesc(String functiondesc) {
        this.functiondesc = functiondesc;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getParams() {
        return params;
    }

    public void setParams(String params) {
        this.params = params;
    }

    public String getReturndesc() {
        return returndesc;
    }

    public void setReturndesc(String returndesc) {
        this.returndesc = returndesc;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public Document(DocumentInfo documentInfo) {
        this.name = documentInfo.name();
        this.desc = documentInfo.desc();
        this.functiondesc = documentInfo.functiondesc();
        this.author = documentInfo.author();
        this.params = documentInfo.params();
        this.returndesc = documentInfo.returndesc();
        this.date = documentInfo.date();
        this.version = documentInfo.version();
        this.sort = documentInfo.sort();
    }

    @Override
    public int compareTo(Object o) {
        Document temp = (Document)o;
        return this.sort-temp.sort;
    }
}
