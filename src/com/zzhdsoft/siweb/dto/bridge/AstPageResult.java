package com.zzhdsoft.siweb.dto.bridge;

import java.io.Serializable;
import java.util.List;

/**
 * web分页请求的结果包装对象
 * 避免依赖JPA的Page对象
 */
public class AstPageResult<T> implements Serializable {
    //总条数
    private Long total;

    //数据列表
    private List<T> list;

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public AstPageResult() {
    }

    public AstPageResult(Long total, List<T> list) {
        this.total = total;
        this.list = list;
    }

//    public AstPageResult(Page<T> page){
//        this.total = page.getTotalElements();
//        this.list = page.getContent();
//    }
}
