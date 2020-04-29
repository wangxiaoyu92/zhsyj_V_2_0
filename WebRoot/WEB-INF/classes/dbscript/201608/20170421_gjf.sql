ALTER TABLE hjchz
CHANGE COLUMN 监管主体客户关系表id hjgztkhgxid varchar(32) DEFAULT NULL COMMENT '监管主体客户关系表id';

drop table if exists hjchz;
drop table if exists hjchmx;

drop table if exists hjchb;

/*==============================================================*/
/* Table: hjchb                                                 */
/*==============================================================*/
create table hjchb
(
   hjchid               varchar(32) not null comment '进出货表id',
   jcypid               varchar(32) comment '商品id',
   jchsl                decimal(12,2) comment '进出货数量，出货为负',
   spjldw               varchar(10) comment '进出货计量单位aaa100=jhjldwbh;',
   jchscd               varchar(100) comment '生产地',
   jchsjfxid            varchar(32) comment '上级分销id',
   jcfs                 varchar(10) comment '检测方式1自检2上游流转',
   jcypprice            decimal(12,2) comment '单价',
   jcyptotal            decimal(12,2) comment '合计',
   jchscrq              datetime comment '生产日期',
   jchscpcm             varchar(30) comment '生产批次码',
   jchhgzmlx            varchar(10) comment '合格证明类型aaa100=jchhgzmlx',
   jchhgzmfjid          varchar(32) comment '合格证明附件id，对应附件表主键',
   jchscjyjl            varchar(10) comment '生产检验结论aaa100=jchscjyjl',
   jchqycyjl            varchar(10) comment '企业查验结论aaa100=jchqycyjl',
   jchgysid             varchar(32) comment '供应商id，对应客户关系表主键',
   jchscsid             varchar(32) comment '生产商id，对应客户关系表主键',
   jchsptm              varchar(50) comment '商品条码',
   hviewjgztid          varchar(32) comment '监管主体表id',
   jchpc                varchar(32) comment '进出货批次',
   jchlx                varchar(10) comment '进出货类型0进货1出货',
   eptbh                varchar(32) comment 'e票通编号',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hjchid)
);

alter table hjchb comment '进出货表';

alter table hjchb add constraint FK_Reference_20 foreign key (jcypid)
      references jyjcyp (jcypid) on delete restrict on update restrict;


INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041817390364575796424', '/khgx/khgxMainIndex?jgztkhgx=1', '供应商', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'khgxMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041916571293079333091', '/khgx/khgxMainIndex?jgztkhgx=2', '生产商', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'khgxMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041916583910846359731', '/khgx/khgxMainIndex?jgztkhgx=3', '经销商', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'khgxMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');

INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('FJTYPE', '9', '检测合格证明图片', 199405, NULL, '2017041917402663973867390', '1456', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

call PRC_INSERTCODE('JCHQYCYJL','企业查验结论','1','0','查验合格','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('JCHQYCYJL','企业查验结论','1','1','查验不合格','199405',null,@P_CODE,@P_MSG);

INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('FJTYPE', '10', '执法人员照片', 199405, NULL, '2017042015060442396677604', '1456', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

###############################################################
drop table if exists pgzpjmx;

/*==============================================================*/
/* Table: pgzpjmx                                               */
/*==============================================================*/
create table pgzpjmx
(
   pgzpjmxid            varchar(32) not null comment '公众评价明细表',
   pgzpjid              varchar(32) not null comment '公众评价表id',
   pjcs                 varchar(32) not null comment '评价参数aa10=pjcs',
   pjxj                 varchar(10) comment '评价星级aaa100=pjxj',
   primary key (pgzpjmxid)
);

alter table pgzpjmx comment '公众评价明细表';


ALTER TABLE pcomrcjdglry
  ADD INDEX IDX_pcomrcjdglry_comid (comid);

#########删除pcompany多余的字段
INSERT INTO pcompanyxkz(
  comxkzid,#'企业许可信息ID',
  comid,#'企业ID',
  comxkzbh,#'许可证编号',
  comxkfw,#'许可范围',
  comxkyxqq,#'许可有效期起',
  comxkyxqz,#'许可有效期止',
  comxkzlx,#'许可证类型',
  comxkzzcxs,#'组成形式',
  comxkzztyt,#'主体业态',
  comxkzjycs #'经营场所',
  )
SELECT f_getSequenceStr(), p.comid,p.comzzzmbh,p.comxkfw,p.comxkyxqq,p.comxkyxqz,'4',
  '','','' FROM pcompany p WHERE comxkfw IS NOT NULL AND comxkyxqq IS NOT null
  AND NOT EXISTS (SELECT 1 FROM pcompanyxkz b WHERE b.comid=p.comid);

ALTER TABLE pcompany
  DROP COLUMN username,
  DROP COLUMN comxkfw,
  DROP COLUMN comxkyxqq,
  DROP COLUMN comxkyxqz,
  DROP COLUMN comshengdm,
  DROP COLUMN comshengmc,
  DROP COLUMN comshidm,
  DROP COLUMN comshimc,
  DROP COLUMN comxiandm,
  DROP COLUMN comxianmc,
  DROP COLUMN comxiangdm,
  DROP COLUMN comxiangmc,
  DROP COLUMN comcundm,
  DROP COLUMN comcunmc,
  DROP COLUMN comzzzm,
  DROP COLUMN comzzzmbh,
  DROP COLUMN comtjrq,
  DROP COLUMN comdengji,
  DROP COLUMN comjgpz,
  DROP COLUMN comywjkz,
  DROP COLUMN comyljgzlxm,
  DROP COLUMN comyljgcyry,
  DROP COLUMN comyljgxz,
  DROP COLUMN comspaqgly,
  DROP COLUMN comlhfj;

UPDATE sysfunction set LOCATION='/jk/jkgl/jkmainIndex?comdalei=101202' WHERE functionid='2016072611551564014733352';
UPDATE sysfunction set LOCATION='/jk/jkgl/jkmainIndex?comdalei=101101' WHERE functionid='2016072611562542380486518';
UPDATE sysfunction set LOCATION='/jk/jkgl/jkqyListIndex?comdalei=101201&jklx=1' WHERE functionid='2016082517282681833885658';



