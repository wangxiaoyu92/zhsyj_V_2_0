-- 指派负责人按钮权限
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) 
VALUES('2016120614255340168692790', '/jk/jkgl/fzrJky', '指派负责人', '2016041318565190637042980', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'fzrJky', NULL, NULL, NULL, NULL, NULL, NULL, '', '');



-- 监控企业负责人表
CREATE TABLE syjzhpt.jkqyfzr (
  jkqyfzrid varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  comid varchar(32) DEFAULT NULL COMMENT '监控企业ID',
  userid varchar(32) DEFAULT NULL COMMENT '负责人ID',
  PRIMARY KEY (jkqyfzrid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 1820
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '监控企业负责人表';