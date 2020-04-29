-- 企业二维码表
CREATE TABLE syjzhpt.pcomqrcode (
  comid VARCHAR(32) NOT NULL COMMENT '企业ID',
  qrcodecontent LONGBLOB DEFAULT NULL COMMENT '二维码内容',
  PRIMARY KEY (comid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '企业二维码';

-- 添加二维码管理按钮菜单
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,TYPE,description,LOG,OWNER,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2016111115515277239988931','pcompany/qrcodeManager','二维码管理','1129',1,'2',NULL,NULL,NULL,NULL,NULL,'1','qrcodeManager',NULL,NULL,NULL,NULL,NULL,NULL,'','');

--  批量生成二维码按钮菜单
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,TYPE,description,LOG,OWNER,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2016111115543384153628412','pcompany/createQRcodes','批量生成二维码','1129',1,'2',NULL,NULL,NULL,NULL,NULL,'1','createQRcodes',NULL,NULL,NULL,NULL,NULL,NULL,'','');

-- 企业二维码生成（二维码内容前缀，ip根据相应地市进行更改）
INSERT INTO `aa01` VALUES ('QYEWMQZ', '企业二维码前缀', 'http://192.168.191.1:8080/syjzhpt/common/sjb/companyIndex?comid=', '1', NULL, '28', NULL);