ALTER TABLE qsymscmxb
  ADD COLUMN qrcodepath VARCHAR(200) DEFAULT NULL COMMENT '二维码图片存放路径' AFTER sym;

drop index idx_pcomsymurl on pcomsymurl;

drop table if exists pcomsymurl;

/*==============================================================*/
/* Table: pcomsymurl                                            */
/*==============================================================*/
create table pcomsymurl
(
   pcomsymurlid         varchar(32) not null comment '企业溯源码跳转地址id',
   comid                varchar(32) comment '企业id',
   tzurl                varchar(200) comment '跳转地址',
   primary key (pcomsymurlid)
);

alter table pcomsymurl comment '企业溯源码跳转地址';

/*==============================================================*/
/* Index: idx_pcomsymurl                                        */
/*==============================================================*/
create unique index idx_pcomsymurl on pcomsymurl
(
   comid
);


INSERT INTO aa10(aaa100,aaa102,aaa103,aae030,aae031,aaz093,aaz094)
VALUES('FJTYPE','14','产品视频','199405',NULL,'2017062411033612914372620',1456);