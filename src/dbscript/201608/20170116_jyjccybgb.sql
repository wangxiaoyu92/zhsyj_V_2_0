CREATE TABLE syjzhpt.jyjccybgb (
  bgid varchar(32) NOT NULL COMMENT '报告ID',
  cydjid varchar(32) DEFAULT NULL COMMENT '抽样登记ID',
  bgbh varchar(32) DEFAULT NULL COMMENT '报告编号',
  jsbgrq datetime DEFAULT NULL COMMENT '收到报告日期',
  bgsdrq datetime DEFAULT NULL COMMENT '报告送达日期',
  jcrqks datetime DEFAULT NULL COMMENT '检测日期开始',
  jcrqjs datetime DEFAULT NULL COMMENT '检测日期结束',
  jcdwid varchar(32) DEFAULT NULL COMMENT '检测单位ID',
  jcdwmc text DEFAULT NULL COMMENT '检测单位名称',
  lah text DEFAULT NULL COMMENT '立案号',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (bgid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 1638
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检验检测抽样报告表';