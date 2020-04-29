
/**1.检查结果增加（权限统筹区，权限大类、权限经办人、权限机构）*/
ALTER TABLE bscheckmaster ADD COLUMN aaa027 varchar(12) DEFAULT NULL COMMENT '地区编码';
ALTER TABLE bscheckmaster ADD COLUMN aae140 varchar(5) DEFAULT NULL COMMENT '四品一械大类';
ALTER TABLE bscheckmaster ADD COLUMN userid varchar(32) DEFAULT NULL COMMENT '经办人id';
ALTER TABLE bscheckmaster ADD COLUMN orgid varchar(32) DEFAULT NULL COMMENT '机构id';
ALTER TABLE bscheckmaster ADD COLUMN aae011 varchar(20) DEFAULT NULL COMMENT '经办人';
ALTER TABLE bscheckmaster ADD COLUMN aae036 datetime DEFAULT NULL COMMENT '经办时间';
/**1.检查结果增加（地理位置，经纬度信息）*/
ALTER TABLE bscheckmaster ADD COLUMN location varchar(100) DEFAULT NULL COMMENT '地理位置信息';
ALTER TABLE bscheckmaster ADD COLUMN latitude varchar(50) DEFAULT NULL COMMENT '纬度信息';
ALTER TABLE bscheckmaster ADD COLUMN longitude varchar(50) DEFAULT NULL COMMENT '经度信息';
