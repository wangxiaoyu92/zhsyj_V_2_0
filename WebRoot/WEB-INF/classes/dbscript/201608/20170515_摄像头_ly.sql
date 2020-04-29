CREATE TABLE  jkyb (
  camId varchar(32) NOT NULL DEFAULT '',
  camImg varchar(300) DEFAULT NULL,
  camOrgId varchar(32) DEFAULT NULL,
  camOrgName varchar(300) DEFAULT NULL,
  cameraTyp varchar(5) DEFAULT NULL,
  camState varchar(5) DEFAULT NULL,
  deviceIndexCode varchar(32) DEFAULT NULL,
  ocxId varchar(32) DEFAULT NULL,
  page varchar(5) DEFAULT NULL,
  pixel varchar(5) DEFAULT NULL,
  playType varchar(255) DEFAULT NULL,
  rows varchar(255) DEFAULT NULL,
  sound varchar(5) DEFAULT NULL,
  vagIP varchar(50) DEFAULT NULL,
  camName varchar(150) DEFAULT NULL,
  playVal varchar(50) DEFAULT NULL,
  ptzType varchar(5) DEFAULT NULL,
  PRIMARY KEY (camId)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 1638
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '名厨亮照原表信息';


## 名厨靓照 企业列表

CREATE TABLE  azsxtqyylb (
  address varchar(200) DEFAULT NULL,
  controlUnitId varchar(50) DEFAULT NULL,
  controlUnitName varchar(50) DEFAULT NULL,
  createTime varchar(50) DEFAULT NULL,
  createrId varchar(50) DEFAULT NULL,
  createrName varchar(50) DEFAULT NULL,
  grade varchar(20) DEFAULT NULL,
  imgUrl varchar(255) DEFAULT NULL,
  indexCode varchar(32) DEFAULT NULL,
  onlineCamera varchar(50) DEFAULT NULL,
  orgId varchar(32) NOT NULL DEFAULT '',
  orgLat varchar(20) DEFAULT NULL,
  orgLng varchar(20) DEFAULT NULL,
  orgName varchar(100) DEFAULT NULL,
  orgPid varchar(32) DEFAULT NULL,
  orgSimpleText text DEFAULT NULL,
  orgState varchar(5) DEFAULT NULL,
  page varchar(5) DEFAULT NULL,
  phone varchar(15) DEFAULT NULL,
  regionLevel varchar(5) DEFAULT NULL,
  regionPath varchar(100) DEFAULT NULL,
  rows varchar(5) DEFAULT NULL,
  synchTime varchar(50) DEFAULT NULL,
  viewLastTime varchar(50) DEFAULT NULL,
  viewLevel varchar(5) DEFAULT NULL,
  viewNum varchar(5) DEFAULT NULL,
  comid varchar(32) DEFAULT NULL,
  PRIMARY KEY (orgId)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 555
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '安装摄像头的企业原列表';