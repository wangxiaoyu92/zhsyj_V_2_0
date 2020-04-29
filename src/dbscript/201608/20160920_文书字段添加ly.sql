-- Script was generated by Devart dbForge Studio for MySQL, Version 6.0.315.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 2016/9/20 19:19:29
-- Server version: 5.6.26-log
-- Client version: 4.1

SET NAMES 'utf8';

USE syjzhpt;


--
-- Alter table "zfwsjyjcjyjdgzs14"
--
ALTER TABLE zfwsjyjcjyjdgzs14
  ADD COLUMN jygzqzcsjdsmcjbh VARCHAR(200) DEFAULT NULL COMMENT '强制措施决定书名称及编号' AFTER jygzdsrqzrq,
 ADD COLUMN jygzqzcsqxsyrq DATETIME DEFAULT NULL COMMENT '强制措施期限顺延日期' AFTER jygzqzcsjdsmcjbh;


--
-- Alter table "zfwsxxdjbcwptzs10"
--
ALTER TABLE zfwsxxdjbcwptzs10 
  ADD COLUMN xztzwfxw VARCHAR(200) DEFAULT NULL COMMENT '违法行为' AFTER xztzbcqxjsrq,
  ADD COLUMN xztzwfflfg VARCHAR(200) DEFAULT NULL COMMENT '违反的法律法规' AFTER xztzwfxw;
  
--
-- Alter table "zfwsjccfkyjds17"
--
ALTER TABLE zfwsjccfkyjds17
  ADD COLUMN jckyxzjglxr VARCHAR(20) DEFAULT NULL COMMENT '行政机关联系人' AFTER jckydsrqzrq,
  ADD COLUMN jckylxdh VARCHAR(20) DEFAULT NULL COMMENT '联系电话' AFTER jckyxzjglxr;
  
  --
-- Alter table "zfwszlgztzs20"
--
ALTER TABLE zfwszlgztzs20
  ADD COLUMN zlgzwfxwjzrq DATETIME DEFAULT NULL COMMENT '改正违法行为截止日期' AFTER zlgzdsrqzrq;

--
-- Alter table "zfwscfkyyqtzs15"
--
ALTER TABLE zfwscfkyyqtzs15
  ADD COLUMN cfyqqx VARCHAR(5) DEFAULT NULL COMMENT '查封延期期限' AFTER cfyqdsrqzrq;  
 
 
 --
-- Alter table "zfwsxzcfjds28"
--
ALTER TABLE zfwsxzcfjds28
  CHANGE COLUMN syzmnr syzmnr LONGTEXT DEFAULT NULL COMMENT '所要证明内容'; 
  