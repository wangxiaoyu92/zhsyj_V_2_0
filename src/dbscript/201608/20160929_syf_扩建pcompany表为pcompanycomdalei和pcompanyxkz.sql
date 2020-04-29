/**
1. 背景
a)在灵宝项目中遇到一个企业存在多种经营业态（大类），并且有得多许可证信息，这些信息在现有系统中无法进行维护；
b)现有的数据结构方案满足不了现有的数据关系。


2. 处理方法
a)新建 pcompanyxkz 企业许可信息表
 pcompanycomdalei  企业分类对照表
修改 pcompany表，去掉分散后的字段
b)将原有pcompany表中原有数据分散到新建的几张表和修改后的pcompany表里
 */

-- 企业许可信息表
CREATE TABLE syjzhpt.pcompanyxkz (
  comxkzid varchar(32)  NOT NULL DEFAULT '0' COMMENT '企业许可信息ID',
  comid varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
  comxkzbh varchar(50) DEFAULT NULL COMMENT '许可证编号',
  comxkfw varchar(4000) DEFAULT NULL COMMENT '许可范围',
  comxkyxqq date DEFAULT NULL COMMENT '许可有效期起',
  comxkyxqz date DEFAULT NULL COMMENT '许可有效期止',
  comxkzlx varchar(32) DEFAULT NULL COMMENT '许可证类型',
  PRIMARY KEY (comxkzid),
  INDEX IDX_pcompanyxkz_comxkzbh (comxkzbh )
)
ENGINE = INNODB
AVG_ROW_LENGTH = 332
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '企业许可信息表';

-- 企业分类对照表
CREATE TABLE syjzhpt.pcompanycomdalei (
  comdaleiid varchar(32)  NOT NULL DEFAULT '0' COMMENT '企业大类信息ID',
  comid varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
  comdalei varchar(30) DEFAULT NULL COMMENT '企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营',
  PRIMARY KEY (comdaleiid )
)
ENGINE = INNODB
AVG_ROW_LENGTH = 332
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '企业分类对照表';