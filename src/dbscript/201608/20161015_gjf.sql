CREATE TABLE pdbsx (
  pdbsxid VARCHAR(32) NOT NULL,
  qtbid VARCHAR(32) DEFAULT NULL COMMENT '其它相关表ID',
  fsuserid VARCHAR(32) DEFAULT NULL COMMENT '发送用户ID',
  fsusername VARCHAR(50) DEFAULT NULL COMMENT '发送用户名称',
  fssj DATETIME DEFAULT NULL COMMENT '发送时间',
  fsnr VARCHAR(500) DEFAULT NULL COMMENT '发送内容',
  fsxtbz VARCHAR(100) DEFAULT NULL COMMENT '系统备注',
  PRIMARY KEY (pdbsxid)
)
ENGINE = INNODB
COMMENT = '待办事项表';



CREATE TABLE pdbsxjsr (
  pdbsxjsrid varchar(32) NOT NULL,
  pdbsxid varchar(32) DEFAULT NULL COMMENT '待办事项表主键',
  jsuserid varchar(32) DEFAULT NULL COMMENT '接收用户id',
  jsusername varchar(32) DEFAULT NULL COMMENT '接收用户名称',
  jsclyj varchar(300) DEFAULT NULL COMMENT '接收处理意见',
  jssj datetime DEFAULT NULL COMMENT '接收时间',
  jsorgid varchar(32) DEFAULT NULL COMMENT '接收人所属机构id',
  jsorgname varchar(100) DEFAULT NULL COMMENT '接收人所属机构名称',
  jsbz varchar(2) DEFAULT '0' COMMENT '接收标志0未接收1已接收',
  PRIMARY KEY (pdbsxjsrid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '待办事项接收人表';



--驻马店已更新
ALTER TABLE zfajdj
CHANGE COLUMN comdalei comid varchar(32) DEFAULT NULL COMMENT '企业id，权限控制用';

UPDATE zfajdj aa set aa.comid=(SELECT tt.comid FROM pcompany tt WHERE tt.comdm=aa.comdm);







