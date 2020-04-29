-- 极光推送菜单
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2016113017170954356423755','','极光推送','',1,'0',NULL,NULL,NULL,NULL,NULL,'1','',NULL,NULL,NULL,NULL,NULL,NULL,'',''); 

-- 极光推送页面
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2016113017193780782959236', '/jpush/jpushMainIndex', '极光推送页面', '2016113017170954356423755', 1,'1', NULL, NULL, NULL, NULL, NULL, '1', 'jpushMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', ''); 

-- 极光推送日志页面
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2016120109323172993590596', '/jpush/jpushLogIndex', '极光推送日志', '2016113017170954356423755', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'jpushLogIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');



-- 极光推送日志
CREATE TABLE syjzhpt.jpushlog (
  logid varchar(32) NOT NULL COMMENT '日志ID',
  accertuserid varchar(32) DEFAULT NULL COMMENT '接收人ID',
  message varchar(600) DEFAULT NULL COMMENT '推送信息内容',
  title varchar(100) DEFAULT NULL COMMENT '标题',
  senduserid varchar(32) DEFAULT NULL COMMENT '推送人id',
  sendtime date DEFAULT NULL COMMENT '推送时间',
  type char(2) DEFAULT NULL COMMENT '信息类型：0：系统消息；1：个人消息',
  PRIMARY KEY (logid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '处理事件协作日志表';

