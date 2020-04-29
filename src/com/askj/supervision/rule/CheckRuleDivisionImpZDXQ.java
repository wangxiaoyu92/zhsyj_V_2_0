package com.askj.supervision.rule;

/**
 * Created by sunyifeng on 2017/9/13.
 */
public class CheckRuleDivisionImpZDXQ implements CheckRuleDivision {
    @Override
    public String getState(int impfailitems, int generalItems) {
        String state ="";
        /**
         * 根据检查情况，
         * 未发现问题选符合，发现小于8项（含）一般项存在问题选基本符合。
         * 发现大于8项一般项或1项（含）以上重点项存在问题选不符合
         * 一般项
         * if(LABEL_01_val==0&&LABEL_02_val==0){
         *     符合
         * }else{
         *     if(LABEL_02_val>0&&LABEL_02_val<=8&&LABEL_02_val==0){
         *    	 基本符合
         *    }else{
         *     	 不符合
         * 	  }
         *    关键项
         *    if(LABEL_01_val>=LABEL_01_VAL){
         *       不符合
         *    }
         * }
         *
         */
        //未发现问题选符合
        if(generalItems==0&&impfailitems==0){
            //符合
            state="1";
        }else{
            //发现小于8项（含）一般项存在问题选基本符合
            if((impfailitems>0&&impfailitems<=8)&&impfailitems==0){
                //基本符合
                state="3";
            }else{
                if(impfailitems>=1&&impfailitems>8){
                    //不符合
                    state="2";
                }
            }
        }
        return state;
    }
}
