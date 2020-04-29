-- 动物信息
CREATE TABLE animalinfo (
  animalinfoid varchar(32) NOT NULL COMMENT '动物信息id',
  fenceid varchar(32) DEFAULT NULL COMMENT '栅栏id',
  animalno varchar(32) DEFAULT NULL COMMENT '动物编号',
  birthday datetime DEFAULT NULL COMMENT '出生日期',
  sex varchar(10) DEFAULT NULL COMMENT '动物性别[1:公 0:母]',
  haircolor varchar(10) DEFAULT NULL COMMENT '毛发颜色(对应aa10表haircolor)',
  culturestyle varchar(10) DEFAULT NULL COMMENT '养殖类型(对应aa10表culturestyle)',
  weaningdate datetime DEFAULT NULL COMMENT '断奶日期',
  weaningweight decimal(10, 2) DEFAULT NULL COMMENT '断奶体重',
  deathdate datetime DEFAULT NULL COMMENT '死亡日期',
  deathweight decimal(10, 2) DEFAULT NULL COMMENT '死亡体重',
  fatherid varchar(32) DEFAULT NULL COMMENT '父id',
  fatherno varchar(32) DEFAULT NULL COMMENT '父编号',
  motherid varchar(32) DEFAULT NULL COMMENT '母id',
  motherno varchar(32) DEFAULT NULL COMMENT '母编号',
  inputtype varchar(10) DEFAULT NULL COMMENT '录入方式[1:自动 0:手动]',
  identificationcode varchar(32) DEFAULT NULL COMMENT '识别码',
  equipmenttype varchar(10) DEFAULT NULL COMMENT '设备类型(对应aa10表equipmenttype)',
  aae011 varchar(30) DEFAULT NULL COMMENT '操作员',
  aae036 datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (animalinfoid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 287
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '动物信息';

-- 动物舍所信息
CREATE TABLE animalhouse (
  animalhouseid varchar(32) NOT NULL COMMENT '舍所id',
  houseno varchar(32) DEFAULT NULL COMMENT '舍所编号',
  housename varchar(200) DEFAULT NULL COMMENT '舍所名称',
  houseremarks varchar(200) DEFAULT NULL COMMENT '舍所备注',
  parenthouseid varchar(32) DEFAULT NULL COMMENT '舍所上级id',
  orgid varchar(32) DEFAULT NULL COMMENT '组织机构id',
  aae011 varchar(30) DEFAULT NULL COMMENT '操作员',
  aae036 datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (animalhouseid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 287
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '动物舍所信息';

-- 动物栅栏信息
CREATE TABLE animalfence (
  animalfenceid varchar(32) NOT NULL COMMENT '主键id',
  fenceno varchar(32) DEFAULT NULL COMMENT '栅栏编号',
  fencename varchar(200) DEFAULT NULL COMMENT '栅栏名称',
  fenceremarks varchar(200) DEFAULT NULL COMMENT '栅栏备注',
  houseid varchar(32) DEFAULT NULL COMMENT '动物舍所id',
  houseno varchar(32) DEFAULT NULL COMMENT '动物舍所编号',
  aae011 varchar(30) DEFAULT NULL COMMENT '操作员',
  aae036 datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (animalfenceid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 287
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '动物栅栏信息';

-- 动物死亡信息
CREATE TABLE animaldeath (
  animaldeathid varchar(32) NOT NULL COMMENT '死亡信息主键id',
  animalinfoid varchar(32) DEFAULT NULL COMMENT '动物信息id',
  deathdate datetime DEFAULT NULL COMMENT '死亡时间',
  deathweight decimal(10, 2) DEFAULT NULL COMMENT '死亡体重',
  deathreason varchar(10) DEFAULT NULL COMMENT '死亡原因(对应aa10表deathreason)',
  treatmentmode varchar(10) DEFAULT NULL COMMENT '处理方法(对应aa10表treatmentmode)',
  symptom varchar(500) DEFAULT NULL COMMENT '症状及用药描述',
  PRIMARY KEY (animaldeathid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 287
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '动物死亡信息';

call PRC_INSERTCODE('deathreason','动物死亡原因','1','1','自然死亡','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('deathreason','动物死亡原因','1','2','生病死亡','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('deathreason','动物死亡原因','1','3','意外死亡','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('deathreason','动物死亡原因','1','4','宰杀死亡','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('treatmentmode','处理方法','1','1','食用','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('treatmentmode','处理方法','1','2','埋葬','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('treatmentmode','处理方法','1','3','火葬','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('haircolor','毛发颜色','1','1','白','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('haircolor','毛发颜色','1','2','黑','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('haircolor','毛发颜色','1','3','黄','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('haircolor','毛发颜色','1','4','棕','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('culturestyle','养殖类型','1','1','圈养','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('culturestyle','养殖类型','1','2','散养','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('culturestyle','养殖类型','1','3','混养','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('equipmenttype','设备类型','1','0','自动','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('equipmenttype','设备类型','1','1','半自动','199405',null,@P_CODE,@P_MSG);

