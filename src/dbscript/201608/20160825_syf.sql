/**
监管情况统计增加
 */
CREATE TABLE syjzhpt.bscheckstatbyday (
  id varchar(20) NOT NULL COMMENT '主键',
  statdate varchar(10) DEFAULT NULL COMMENT '统计日期',
  statnum numeric(10) DEFAULT 0 COMMENT '统计数量',
  aaa027 varchar(40) DEFAULT NULL COMMENT '统筹区',
  aae014 varchar(20) DEFAULT NULL COMMENT '四品一械大类',
  orgid varchar(255) DEFAULT NULL COMMENT '组织机构id',
  PRIMARY KEY (id)
)
ENGINE = INNODB
COMMENT = '检查结果日统计数量表'
AVG_ROW_LENGTH = 512
CHARACTER SET utf8
COLLATE utf8_general_ci;