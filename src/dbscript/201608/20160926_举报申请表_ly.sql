
SET NAMES 'utf8';

CREATE TABLE syjzhpt.zfwsjbdjb45 (
  jbdjbid VARCHAR(32) NOT NULL COMMENT '登记表id',
  ajdjid VARCHAR(32) DEFAULT NULL COMMENT '案件登记id',
  jbdjbh VARCHAR(50) DEFAULT NULL COMMENT '举报登记编号',
  jbdjjbr VARCHAR(20) DEFAULT NULL COMMENT '举报人',
  jbdjlxfs VARCHAR(30) DEFAULT NULL COMMENT '联系方式',
  jbdjjbxs VARCHAR(30) DEFAULT NULL COMMENT '举报形式',
  jbdjjbsj DATETIME DEFAULT NULL COMMENT '举报时间',
  jbdjjbnr LONGTEXT DEFAULT NULL COMMENT '举报内容',
  jbdjjlrqz VARCHAR(20) DEFAULT NULL COMMENT '记录人签字',
  jbdjjlrqzrq DATETIME DEFAULT NULL COMMENT '记录人签字日期',
  jbdjclyj LONGTEXT DEFAULT NULL COMMENT '处理意见',
  jbdjfzrqz VARCHAR(20) DEFAULT NULL COMMENT '负责人签字',
  jbdjfzrqzrq DATETIME DEFAULT NULL COMMENT '负责人签字日期'
)
ENGINE = INNODB
COMMENT = '举报登记表';

INSERT INTO zhpt.pfjcs(FJCSID, FJCSDMLB, FJCSDMLBMC, FJCSDMZ, FJCSDMMC, FJCSKSRQ, FJCSZZRQ, FJCSQYFLAG, FJCSFJBC, ZFWSURL, FJCSZFWSTITLE, fjcsdlbh, fjcsdlmc, fjcssfdx, zfwstabname, zfwstabid) VALUES
('93', 'ZFAJZFWS', '执法案件文书', 'ZFAJZFWS45', '45举报登记表', '199405', NULL, '1', '1', 'pub/wsgldy/zfwsjbdjbIndex', NULL, NULL, NULL, NULL, NULL, NULL);
