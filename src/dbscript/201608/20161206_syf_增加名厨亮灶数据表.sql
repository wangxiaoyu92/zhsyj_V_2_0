CREATE TABLE pcompanyimport (
  outercomid varchar(32) NOT NULL COMMENT '系统外企业id',
  comid varchar(32) DEFAULT '' COMMENT '系统内企业id',
  outercomname text DEFAULT NULL COMMENT '系统外企业名称',
  state varchar(100) DEFAULT NULL COMMENT '摄像头状态',
  imgurl text DEFAULT NULL COMMENT '企业图片路径',
  createtime datetime DEFAULT NULL COMMENT '对方系统企业创建时间',
  synchtime datetime DEFAULT NULL COMMENT '对方系统企业同步时间',
  viewlasttime datetime DEFAULT NULL COMMENT '对方系统最后一次查看时间',
  orgsimpleText text DEFAULT NULL COMMENT '公司简介',
  PRIMARY KEY (outercomid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 375
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '外系统企业信息';