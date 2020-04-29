package com.zzhdsoft;

/**
 * Created by Administrator on 2017/9/13.
 */
public interface Sys {

    enum Province{


        HeNan           ("410000000000");



        private final String value;
        private Province(String value) {
            this.value = value;
        }

        public boolean equals(String sysaaa027) {
            return this.value.equals(sysaaa027);
        }

    }

    enum City{

        ShangQiu        ("411400000000"),
        ZhuMaDian       ("411700000000"),
        SanMenXia       ("411200000000"),
        PingDingShan    ("410400000000"),
        AnYang          ("410500000000");


        private final String value;
        private City(String value) {
            this.value = value;
        }

        public boolean equals(String sysaaa027) {
            return this.value.equals(sysaaa027);
        }
    }

    enum District{

        LingBao         ("411282000000"),
        RuZhou          ("410482000000"),
        TangYin         ("410523000000"),
        ZhengDongXinQu ("410109000000"); //没有金水区行政区划自编符合国家行政区划编码



        private final String value;
        private District(String value) {
            this.value = value;
        }

        public boolean equals(String sysaaa027) {
            return this.value.equals(sysaaa027);
        }
    }
}
