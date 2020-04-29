package com.zzhdsoft.tag;

import com.zzhdsoft.utils.SysmanageUtil;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.io.StringWriter;

public class CheckPermission extends SimpleTagSupport {

    private String biz;

    public void setBiz(String biz) {
        this.biz = biz;
    }


    StringWriter sw = new StringWriter();

    public void doTag() throws JspException, IOException {
        String menuDataSysAll = SysmanageUtil.getMenuDataAll();
/*        if (menuDataSysAll.indexOf(biz) > -1) {
            getJspBody().invoke(sw);
            getJspContext().getOut().println(sw.toString());
        }*/
//gu20180704 对于 bizid = delcom delcomry 这样的控制的权限不准
        String v_biz_two="\""+biz+"\"";
        if (menuDataSysAll.indexOf(v_biz_two) > -1) {
            getJspBody().invoke(sw);
            getJspContext().getOut().println(sw.toString());
        }
    }
}