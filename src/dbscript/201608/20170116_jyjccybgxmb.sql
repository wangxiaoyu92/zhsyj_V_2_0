CREATE TABLE syjzhpt.jyjccybgxmb (
  jyjcbgxmid varchar(32) NOT NULL COMMENT '报告项目ID',
  bgid varchar(32) DEFAULT NULL COMMENT '报告ID',
  cydjid varchar(32) DEFAULT NULL COMMENT '抽样登记ID',
  jcxmid varchar(32) DEFAULT NULL COMMENT '检测项目ID',
  jxjcxmmc text DEFAULT NULL COMMENT '检测项目名称',
  bzz varchar(20) DEFAULT NULL COMMENT '标准值',
  jyjcjg varchar(255) DEFAULT NULL COMMENT '检验检测结果',
  dw text DEFAULT NULL COMMENT '单位',
  sfhg varchar(255) DEFAULT NULL COMMENT '是否合格',
  yjqk text DEFAULT NULL COMMENT '移交情况',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (jyjcbgxmid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 1260
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检验检测抽样报告项目表';