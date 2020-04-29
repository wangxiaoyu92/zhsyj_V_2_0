package com.askj.supervision.rule;

/**
 * Created by sunyifeng on 2017/9/13.
 */
public interface CheckRuleDivision {

    /**
     * 获取判定结果
     * @param impfailitems 重点项
     * @param generalItems 一般项
     * @return "1":"符合"  "2":"不符合" "3":"基本符合"
     */
    public String getState(int impfailitems, int generalItems);

}
