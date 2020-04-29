
CREATE TABLE syjzhpt.zfwsxzcfsxtzgzspb41 (
  sxtzgzspbid varchar(32) NOT NULL COMMENT 'id',
  ajdjid varchar(32) DEFAULT NULL COMMENT '案件登记id',
  sxtzgzay varchar(255) DEFAULT NULL COMMENT '案由',
  sxtzgzdsr varchar(100) DEFAULT NULL COMMENT '当事人',
  zywfss varchar(1000) DEFAULT NULL COMMENT '主要违法事实',
  cbrycfyj varchar(1000) DEFAULT NULL COMMENT '承办人员处罚意见',
  cbrqz1 varchar(50) DEFAULT NULL COMMENT '承办人签字1',
  cbrqz2 varchar(50) DEFAULT NULL COMMENT '承办人签字2',
  cbrqzrq datetime DEFAULT NULL COMMENT '承办人签字日期',
  cbbmscyj varchar(500) DEFAULT NULL COMMENT '承办部门审查意见',
  cbbmfzrqz varchar(50) DEFAULT NULL COMMENT '承办部门负责人签字',
  cbbmfzrqzrq datetime DEFAULT NULL COMMENT '承办部门负责人签字日期',
  fzjgshyj varchar(500) DEFAULT NULL COMMENT '法制机构审核意见',
  fzjgfzrqz varchar(50) DEFAULT NULL COMMENT '法制机构负责人签字',
  fzjgfzrqzrq datetime DEFAULT NULL COMMENT '法制机构负责人签字日期',
  spyj varchar(50) DEFAULT NULL COMMENT '审批意见',
  spbmfzrqz varchar(50) DEFAULT NULL COMMENT '审批部门负责人签字',
  spbmfzrqzrq datetime DEFAULT NULL COMMENT '审批部门负责人签字日期',
  PRIMARY KEY (sxtzgzspbid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '行政处罚事先（听证）告知审批表41';


INSERT INTO syjzhpt.pfjcs(FJCSID, FJCSDMLB, FJCSDMLBMC, FJCSDMZ, FJCSDMMC, FJCSKSRQ, FJCSZZRQ, FJCSQYFLAG, FJCSFJBC, ZFWSURL, FJCSZFWSTITLE, fjcsdlbh, fjcsdlmc, fjcssfdx, zfwstabname, zfwstabid) VALUES
('90', 'ZFAJZFWS', '执法案件文书', 'ZFAJZFWS41', '41行政处罚事先（听证）告知审批表', '199405', NULL, '1', '1', 'pub/wsgldy/zfwsxzcfsxtzgzspbIndex', NULL, NULL, NULL, NULL, 'zfwsxzcfsxtzgzspb41', 'sxtzgzspbid');



CREATE TABLE syjzhpt.zfwszdgxtzs43 (
  zdgxtzsid varchar(32) NOT NULL COMMENT 'id',
  ajdjid varchar(32) DEFAULT NULL COMMENT '案件登记id',
  zfwsbh varchar(255) DEFAULT NULL COMMENT '执法文书编号',
  tzdwmc varchar(100) DEFAULT NULL COMMENT '通知单位名称',
  gyaj varchar(255) DEFAULT NULL COMMENT '关于案件',
  zdgxdw varchar(100) DEFAULT NULL COMMENT '指定管辖单位',
  xzjgmc varchar(100) DEFAULT NULL COMMENT '行政机关名称',
  gzrq datetime DEFAULT NULL COMMENT '盖章日期',
  PRIMARY KEY (zdgxtzsid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '指定管辖通知书43';


INSERT INTO syjzhpt.pfjcs(FJCSID, FJCSDMLB, FJCSDMLBMC, FJCSDMZ, FJCSDMMC, FJCSKSRQ, FJCSZZRQ, FJCSQYFLAG, FJCSFJBC, ZFWSURL, FJCSZFWSTITLE, fjcsdlbh, fjcsdlmc, fjcssfdx, zfwstabname, zfwstabid) VALUES
('91', 'ZFAJZFWS', '执法案件文书', 'ZFAJZFWS43', '43指定管辖通知书', '199405', NULL, '1', '1', 'pub/wsgldy/zfwszdgxtzsIndex', NULL, NULL, NULL, NULL, 'zfwszdgxtzs43', 'zdgxtzsid');




CREATE TABLE syjzhpt.zfwsxzcfwts42 (
  xzcfwtsid varchar(32) NOT NULL COMMENT 'id',
  ajdjid varchar(32) DEFAULT NULL COMMENT '案件登记id',
  zfwsbh varchar(255) DEFAULT NULL COMMENT '执法文书编号',
  wtjg varchar(100) DEFAULT NULL COMMENT '委托机关',
  wtjgfrdb varchar(100) DEFAULT NULL COMMENT '委托机关法人代表',
  wtjgfrdbzw varchar(100) DEFAULT NULL COMMENT '委托机关法人代表职务',
  wtjgfrdbdwdz varchar(100) DEFAULT NULL COMMENT '委托机关法人代表单位地址',
  swtjg varchar(100) DEFAULT NULL COMMENT '受委托机关',
  swtjgfrdb varchar(100) DEFAULT NULL COMMENT '受委托机关法人代表',
  swtjgfrdbzw varchar(100) DEFAULT NULL COMMENT '受委托机关法人代表职务',
  swtjgfrdbdwdz varchar(100) DEFAULT NULL COMMENT '受委托机关法人代表单位地址',
  gjflfggd varchar(100) DEFAULT NULL COMMENT '根据法律法规规定',
  jjmc varchar(100) DEFAULT NULL COMMENT '经局名称',
  jdwmc varchar(100) DEFAULT NULL COMMENT '经单位名称',
  yjmc varchar(100) DEFAULT NULL COMMENT '由局名称',
  wtdwmc varchar(100) DEFAULT NULL COMMENT '委托单位名称',
  cfsxssfw varchar(1000) DEFAULT NULL COMMENT '处罚事项实施范围',
  wtksrq datetime DEFAULT NULL COMMENT '委托开始日期',
  wtjsrq datetime DEFAULT NULL COMMENT '委托结束日期',
  wtqjdwmc varchar(100) DEFAULT NULL COMMENT '委托期间单位名称',
  wtqjyjmc varchar(100) DEFAULT NULL COMMENT '委托期间以局名称',
  jsjjdmc varchar(100) DEFAULT NULL COMMENT '接受局监督名称',
  yjcdmc varchar(100) DEFAULT NULL COMMENT '由局承担名称',
  wtdw varchar(100) DEFAULT NULL COMMENT '委托单位',
  wtjgdbrqz varchar(100) DEFAULT NULL COMMENT '委托机关代表人签字',
  wtjgdbrqzrq datetime DEFAULT NULL COMMENT '委托机关代表人签字日期',
  swtjgdbrqz varchar(100) DEFAULT NULL COMMENT '受委托机关代表人签字',
  swtjgdbrqzrq datetime DEFAULT NULL COMMENT '受委托机关代表人签字日期',
  PRIMARY KEY (xzcfwtsid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '行政处罚委托书42';


INSERT INTO syjzhpt.pfjcs(FJCSID, FJCSDMLB, FJCSDMLBMC, FJCSDMZ, FJCSDMMC, FJCSKSRQ, FJCSZZRQ, FJCSQYFLAG, FJCSFJBC, ZFWSURL, FJCSZFWSTITLE, fjcsdlbh, fjcsdlmc, fjcssfdx, zfwstabname, zfwstabid) VALUES
('92', 'ZFAJZFWS', '执法案件文书', 'ZFAJZFWS42', '42行政处罚委托书', '199405', NULL, '1', '1', 'pub/wsgldy/zfwsxzcfwtsIndex', NULL, NULL, NULL, NULL, 'zfwsxzcfwts42', 'xzcfwtsid');






