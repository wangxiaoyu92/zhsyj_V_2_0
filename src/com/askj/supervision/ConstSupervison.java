package com.askj.supervision;

/**
 * Created by Administrator on 2017/9/13.
 */
public interface ConstSupervison {

    enum CheckType {
        //量化：0 日常：1
        LiangHua("0"),
        RiChang("1"),
        SPSXDTLH("5"),  //食品销售环节动态风险因素量化分值表
        SPSXJTLH("6"),  //食品销售企业静态风险因素量化分值表
        SPTJJJTLH("7"), //食品、食品添加剂生产者静态风险因素量化分值表
        SPSPTJJ_SPQYDTFXYSPJB("12");  //食品食品添加剂生产企业动态风险因素评价表

        private final String value;

        private CheckType(String value) {
            this.value = value;
        }

        public boolean equals(String sysaaa027) {
            return this.value.equals(sysaaa027);
        }

        @Override
        public String toString() {
            return this.value;
        }
    }
    enum CheckMasterState {
        //结果完成表示（0:初始化,1：保存，2：提交，3：固化,4:结果判定固化,5:结果判定保存,6:预览）
        Saved            ("1"),
        Committed       ("2"),
        Freezed         ("3"),
        ResultDecideFreezed   ("4"),
        ResultDecideSaved("5"),
        Preview("6");


        private final String value;

        private CheckMasterState(String value) {
            this.value = value;
        }

        public boolean equals(String sysaaa027) {
            return this.value.equals(sysaaa027);
        }

        @Override
        public String toString() {
            return this.value;
        }
    }

    enum Detaildecide{

        NotQualified         ("2"),
        Qualified            ("1"),
        MissedQualified        ("3");



        private final String value;
        private Detaildecide(String value) {
            this.value = value;
        }

        public boolean equals(String sysaaa027) {
            return this.value.equals(sysaaa027);
        }

        @Override
        public String toString() {
            return this.value;
        }
    }
}
