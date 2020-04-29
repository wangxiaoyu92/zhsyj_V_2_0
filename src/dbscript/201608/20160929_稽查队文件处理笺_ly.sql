
SET NAMES 'utf8';

CREATE TABLE syjzhpt.zfwsjcdwjclj46 (
  jcwjclid Varchar(32) NOT NULL DEFAULT '' COMMENT '稽查队文件处理笺id',
  ajdjid Varchar(32) DEFAULT NULL COMMENT '案件登记id',
  jcwjclwjbh VARCHAR(50) DEFAULT NULL COMMENT '稽查队文件处理笺文件编号',
  jcwjclwjsxh VARCHAR(32) DEFAULT NULL COMMENT '稽查队文件处理笺文件顺序号',
  jcwjclwjsdrq DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺文件收到日期',
  jcwjclwjbt VARCHAR(30) DEFAULT NULL COMMENT '稽查队文件处理笺文件标题',
  jcwjclldps VARCHAR(100) DEFAULT NULL COMMENT '稽查队文件处理笺领导批示',
  jcwjclyzqm1 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名1',
  jcwjclyzqm2 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名2',
  jcwjclyzqm3 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名3',
  jcwjclyzqm4 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名4',
  jcwjclyzqm5 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名5',
  jcwjclyzqm6 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名6',
  jcwjclyzqm7 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名7',
  jcwjclyzqm8 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名8',
  jcwjclyzqm9 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名9',
  jcwjclyzqm10 VARCHAR(20) DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名10',
  jcwjclyzqmrq1 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期1',
  jcwjclyzqmrq2 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期2',
  jcwjclyzqmrq3 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期3',
  jcwjclyzqmrq4 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期4',
  jcwjclyzqmrq5 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期5',
  jcwjclyzqmrq6 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期6',
  jcwjclyzqmrq7 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期7',
  jcwjclyzqmrq8 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期8',
  jcwjclyzqmrq9 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期9',
  jcwjclyzqmrq10 DATETIME DEFAULT NULL COMMENT '稽查队文件处理笺阅者签名日期10',
  jcwjclbz VARCHAR(1000) DEFAULT NULL COMMENT '稽查队文件处理笺备注',
    PRIMARY KEY (jcwjclid)
)
ENGINE = INNODB
COMMENT = '稽查队文件处理笺（jian）';  

INSERT INTO syjzhpt.pfjcs(FJCSID, FJCSDMLB, FJCSDMLBMC, FJCSDMZ, FJCSDMMC, FJCSKSRQ, FJCSZZRQ, FJCSQYFLAG, FJCSFJBC, ZFWSURL, FJCSZFWSTITLE, fjcsdlbh, fjcsdlmc, fjcssfdx, zfwstabname, zfwstabid) VALUES
('94', 'ZFAJZFWS', '执法案件文书', 'ZFAJZFWS46', '46稽查队文件处理笺', '199405', NULL, '1', '1', 'pub/wsgldy/Zfwsjcdwjclj46Index', NULL, NULL, NULL, NULL, 'zfwsjcdwjclj46', 'jcwjclid');