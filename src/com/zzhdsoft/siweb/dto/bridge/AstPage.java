package com.zzhdsoft.siweb.dto.bridge;



import com.zzhdsoft.utils.bridge.JsonUtils;

import java.io.Serializable;

/**
 * web分页请求的包装对象
 * 避免依赖JPA的Pageable对象
 */
public class AstPage implements Serializable {
    //指定页（返回第几页的数据, 从1开始）
    private int pageIndex = 1;

    //指定每页几行数据
    private int pageSize = 10;

    //指定排序字段
    private String sort = "";

    //指定排序方向
    private String order = "";

    public AstPage() {
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }


    /**
     * 从Json字符串中解析出AstPage
     *
     * @param jsonString
     * @return
     */
    public static AstPage parse(String jsonString) {
        AstPage page = new AstPage();
        page.pageIndex = JsonUtils.getInt(jsonString, "pageIndex", 1);
        page.pageSize = JsonUtils.getInt(jsonString, "pageSize", 10);
        page.sort = JsonUtils.getString(jsonString, "sort", "");
        page.order = JsonUtils.getString(jsonString, "order", "");

        return page;
    }
}
