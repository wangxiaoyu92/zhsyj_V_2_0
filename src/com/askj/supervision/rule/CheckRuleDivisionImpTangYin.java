package com.askj.supervision.rule;

/**
 * Created by sunyifeng on 2017/9/13.
 */
public class CheckRuleDivisionImpTangYin implements CheckRuleDivision {
    @Override
    public String getState(int impfailitems, int generalItems) {
        String state ="";
        //判断结果是否符合：
        //		state(1代表符合；2.代表不符合)
        //没有不合格的或是发现检查的重点项存在1项及以下不合格且70%≤一般项合格率＜100%
        //		if((impfailitems==0 && generalItems==0) || (impfailitems<=1 && good<100 && good>=70)){
        //			state="1";
        //		}else if(impfailitems>=2 || good<70){
        //              state="2"	;
        //		}
        //符合不符合（生产经营）
        if(generalItems<=8){//一般项《=8 符合
            state="1";
        }else if(generalItems>8 ||impfailitems>=1 ){//不符合
            state="2";
        }
        return state;
    }
}
