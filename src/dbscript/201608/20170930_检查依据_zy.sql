-- 检查方式
call PRC_INSERTCODE('CHECKTYPE','检查类型','1','1','现场检查','199405',null,@P_CODE,@P_MSG); 
call PRC_INSERTCODE('CHECKTYPE','检查类型','1','2','专项检查','199405',null,@P_CODE,@P_MSG);

-- 菜单
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017092614560983017418200', '/supervision/checkbasis/checkBasisManagerIndex', '检查依据管理', '2016051014372064158527339', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'checkBasisManagerIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'jgxt');
 
-- 检查依据表
CREATE TABLE syjzhpt.omcheckbasis (
  basisid varchar(32) NOT NULL COMMENT '主键',
  type varchar(1) DEFAULT NULL COMMENT '检查方式',
  typedesc varchar(500) DEFAULT NULL COMMENT '检查方式描述',
  guide varchar(1000) DEFAULT NULL COMMENT '检查指南',
  punishmeasures varchar(1000) DEFAULT NULL COMMENT '处罚措施',
  basisdesc varchar(4000) DEFAULT NULL COMMENT '检查依据描述',
  operator varchar(32) DEFAULT NULL COMMENT '经办人ID',
  operatorname varchar(32) DEFAULT NULL COMMENT '经办人名称',
  operatedate datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (basisid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查依据表';

-- 检查依据-法律条款关系表
CREATE TABLE syjzhpt.omcheckbasislegalrt (
  blid varchar(32) NOT NULL COMMENT '主键',
  basisid varchar(32) DEFAULT NULL COMMENT '检查依据表主键',
  legalitemid varchar(32) DEFAULT NULL COMMENT '法律条款表主键',
  operator varchar(32) DEFAULT NULL COMMENT '经办人ID',
  operatorname varchar(32) DEFAULT NULL COMMENT '经办人名称',
  operatedate datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (blid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查依据-法律条款关系表';

-- 检查依据-问题关系表
CREATE TABLE syjzhpt.omcheckbasisproblemrt (
  bpid varchar(32) NOT NULL COMMENT '主键',
  basisid varchar(32) DEFAULT NULL COMMENT '检查依据表主键',
  problemid varchar(32) DEFAULT NULL COMMENT '法律依据问题表主键',
  operator varchar(32) DEFAULT NULL COMMENT '经办人ID',
  operatorname varchar(32) DEFAULT NULL COMMENT '经办人名称',
  operatedate datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (bpid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查依据-问题关系表';

-- 检查内容-检查依据关系表
CREATE TABLE syjzhpt.omcheckcontentbasisrt (
  cbid varchar(32) DEFAULT NULL COMMENT '主键ID',
  contentid varchar(32) NOT NULL COMMENT '检查内容ID',
  basisid varchar(32) DEFAULT NULL COMMENT '检查依据表ID',
  operator varchar(32) DEFAULT NULL COMMENT '经办人ID',
  operatorname varchar(32) DEFAULT NULL COMMENT '经办人名称',
  operatedate datetime DEFAULT NULL COMMENT '经办时间'
)
ENGINE = INNODB
AVG_ROW_LENGTH = 277
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查内容-检查依据关系表';


-- 检查依据问题表
CREATE TABLE syjzhpt.omcheckproblem (
  problemid varchar(32) NOT NULL COMMENT '主键',
  problemdesc varchar(4000) NOT NULL COMMENT '问题描述',
  operator varchar(32) DEFAULT NULL COMMENT '经办人ID',
  operatorname varchar(32) DEFAULT NULL COMMENT '经办人名称',
  operatedate datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (problemid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查依据问题表';




