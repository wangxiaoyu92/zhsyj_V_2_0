###############下面的不用了
ALTER TABLE hjchb
  CHANGE COLUMN jchsjfxid jchsjfxid VARCHAR(32) DEFAULT NULL COMMENT '上级分销id，根据这个号，能知道是有那条记录分销过来的',
  ADD COLUMN jhpch VARCHAR(32) DEFAULT NULL COMMENT '进货批次号，根据这个号拉取本次进货所有的出货记录' AFTER aae036;
ALTER TABLE hjchb
  CHANGE COLUMN eptbh eptbh VARCHAR(32) DEFAULT NULL COMMENT 'e票通编号,根据这个号能拉取所有的本次进货的分销信息';
ALTER TABLE hjchb
  ADD COLUMN jchkcl DECIMAL(12, 2) DEFAULT NULL COMMENT '进出货库存量' AFTER jhpch;
ALTER TABLE hjchb
  DROP COLUMN jchhgzmfjid;

############################

DROP TABLE hjchb;
drop table if exists hjhb;

/*==============================================================*/
/* Table: hjhb                                                  */
/*==============================================================*/
create table hjhb
(
   hjhbid               varchar(32) not null comment '进货表id',
   jcypid               varchar(32) comment '商品id',
   jhsl                 decimal(12,2) comment '进货数量',
   jhspjldw             varchar(10) comment '进货计量单位aaa100=spjldw，首次进货记录有',
   jhscd                varchar(100) comment '生产地，首次进货记录有',
   jhsjfxid             varchar(32) comment '上级分销id，根据这个号，能知道是有那条记录分销过来的',
   jcfs                 varchar(10) comment '检测方式1自检2上游流转，首次进货记录有',
   jhprice              decimal(12,2) comment '单价',
   jhtotal              decimal(12,2) comment '合计',
   jhscrq               datetime comment '生产日期，首次进货记录有',
   jhscpcm              varchar(30) comment '生产批次码，首次进货记录有',
   jhhgzmlx             varchar(10) comment '合格证明类型aaa100=jchhgzmlx，首次进货记录有',
   jhscjyjl             varchar(10) comment '生产检验结论aaa100=jchscjyjl，首次进货记录有',
   jhqycyjl             varchar(10) comment '企业查验结论aaa100=jchqycyjl，首次进货记录有',
   jhgysid              varchar(32) comment '供应商id，对应客户关系表主键，首次进货记录有',
   jhscsid              varchar(32) comment '生产商id，对应客户关系表主键，首次进货记录有',
   jhsptm               varchar(50) comment '商品条码，首次进货记录有',
   hviewjgztid          varchar(32) comment '监管主体表id',
   eptbh                varchar(32) comment 'e票通编号，根据这个号能拉取所有的本次进货的分销信息',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   jhkcl                decimal(12,2) comment '进货库存量',
   primary key (hjhbid)
);

alter table hjhb comment '进货表';


drop table if exists hxhb;

/*==============================================================*/
/* Table: hxhb                                                  */
/*==============================================================*/
create table hxhb
(
   hxhbid               varchar(32) not null comment '销货表id',
   jcypid               varchar(32) comment '商品id',
   xhsl                 decimal(12,2) comment '销货数量',
   xhspjldw             varchar(10) comment '销货计量单位aaa100=spjldw，首次进货记录有',
   xhprice              decimal(12,2) comment '单价',
   xhtotal              decimal(12,2) comment '合计',
   hviewjgztid          varchar(32) comment '监管主体表id',
   hjhbid               varchar(10) comment '对应的进货表id',
   hjhbidnew            varchar(32) comment '新生成的进货表id',
   eptbh                varchar(32) comment 'e票通编号',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hxhbid)
);

alter table hxhb comment '销货表';

UPDATE aa09 set AAA100='JHHGZMLX' WHERE AAA100='JCHHGZMLX';
UPDATE aa10 set AAA100='JHHGZMLX' WHERE AAA100='JCHHGZMLX';

UPDATE aa09 set AAA100='JHSCJYJL' WHERE AAA100='JCHSCJYJL';
UPDATE aa10 set AAA100='JHSCJYJL' WHERE AAA100='JCHSCJYJL';

UPDATE aa09 set AAA100='JHQYCYJL' WHERE AAA100='JCHQYCYJL';
UPDATE aa10 set AAA100='JHQYCYJL' WHERE AAA100='JCHQYCYJL';

#####################下面的语句汤阴，灵宝，汝州 一更新
UPDATE pcompany p set comxiaolei=(SELECT GROUP_CONCAT(t.comxiaolei) FROM pcomxiaolei t WHERE t.comid=p.comid );

UPDATE pcompany p set comxiaoleiname=(SELECT GROUP_CONCAT(t2.AAA103) FROM pcomxiaolei t,viewcomfenlei t2
                                        WHERE t.comid=p.comid AND t.comxiaolei=t2.aaa102 );

UPDATE pcompany p set comdaleiname=(SELECT GROUP_CONCAT(t2.AAA103) FROM pcompanycomdalei t,viewcomfenlei t2
                                        WHERE t.comid=p.comid AND t.comdalei=t2.aaa102 );

UPDATE pcompany p set p.comdaleiname=REPLACE(p.comdaleiname,',','|');
UPDATE pcompany p set p.comxiaoleiname=REPLACE(p.comdaleiname,',','|');

SELECT comid,comdalei,comxiaolei,comdaleiname,comxiaoleiname FROM pcompany 

UPDATE sysfunction s set title='范围外供应商' WHERE s.FUNCTIONID='2017041817390364575796424'; 
UPDATE sysfunction s set title='范围外生产商' WHERE s.FUNCTIONID='2017041916571293079333091'; 
UPDATE sysfunction s set title='范围外经销商' WHERE s.FUNCTIONID='2017041916583910846359731'; 
