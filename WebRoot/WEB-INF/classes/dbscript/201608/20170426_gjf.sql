
  DROP VIEW hviewjgzt;

CREATE view hviewjgztnouse
as
select a.comid AS hviewjgztid,a.comdm AS jgztbh,a.commc AS jgztmc,a.commcjc AS jgztmcjc,a.comfzr AS jgztlxr,a.comgddh AS jgztlxrgddh,
  a.comyddh AS jgztlxryddh,a.comdz AS jgzttxdz,a.aaa027,b.jgztzzzmmc,b.jgztzzzmbh,'1' AS jgztlx,'' AS jgztgsztid,'1' AS jgztfwnfww
  from pcompany a LEFT join viewComxkz b
  on a.comid=b.comid
UNION ALL
SELECT a.pshid AS hviewjgztid,a.shtwh AS jgztbh,a.shmc AS jgztmc,a.shjc AS jgztmcjc,a.shlxr AS jgztlxr,a.shgddh AS jgztlxrgddh,a.shyddh AS jgztlxryddh,
  a.shtxdz AS jgzttxdz,
  c.aaa027 AS aaa027,a.shzzzmmc AS jgztzzzmmc,a.shzzzmbh AS jgztzzzmbh,'2' AS jgztlx,a.comid AS jgztgsztid,
  '1' AS jgztfwnfww FROM psh a,pscfq b,pcompany c
  WHERE a.pscfqid=b.pscfqid
    AND b.comid=c.comid
UNION ALL
SELECT a.hjgztkhgxid AS hviewjgztid,a.jgztkhbh AS jgztbh,jgztkhmc AS jgztmc,a.jgztkhmcjc AS jgztmcjc,jgztkhlxr AS jgztlxr,
  a.jgztkhgddh AS jgztlxrgddh,a.jgztkhyddh as jgztlxryddh,a.jgztkhlxdz AS jgzttxdz,a.aaa027,
  a.jgztkhzzzmmc AS jgztzzzmmc,a.jgztkhzzzmbh AS jgztzzzmbh,
  (case when a.jgztkhgx='1' then '3' when a.jgztkhgx='2' then '4' when a.jgztkhgx='3' then '5' else '' end) AS jgztlx,
  a.jgztfwnztid AS jgztgsztid,a.jgztfwnfww AS jgztfwnfww FROM hjgztkhgx a;

########################################################################

ALTER TABLE hjchb
  DROP COLUMN jchpc;


drop table if exists hviewjgzt;

/*==============================================================*/
/* Table: hviewjgzt                                             */
/*==============================================================*/
create table hviewjgzt
(
   hviewjgztid          varchar(32) not null comment '监管主体表主键',
   jgztbh               varchar(30) comment '监管主体编号',
   jgztmc               varchar(200) comment '监管主体名称',
   jgztmcjc             varchar(50) comment '监管主体名称简称',
   jgztlxr              varchar(30) comment '监管主体联系人',
   jgztlxrgddh          varchar(20) comment '监管主体联系人固定电话',
   jgztlxryddh          varchar(20) comment '监管主体联系人移动电话',
   jgzttxdz             varchar(100) comment '监管主体通讯地址',
   aaa027               varchar(12) comment '监管主体归属统筹区',
   jgztzzzmmc           varchar(200) comment '监管主体资质证明名称',
   jgztzzzmbh           varchar(200) comment '监管主体资质证明编号',
   jgztlx               varchar(10) comment '监管主体类型aaa100=jgztlx1企业2商户',
   jgztgsztid           varchar(32) comment '监管主体归属主体',
   jgztfwnfww           varchar(10) comment '客户范围内范围外',
   primary key (hviewjgztid)
);

alter table hviewjgzt comment '监管主体表';

//初始化表数据
INSERT INTO hviewjgzt SELECT * FROM hviewjgztnouse;

INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041815162652022024970', '/tmsyjhtgl/jinhuoIndex', '进货管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'jinhuoIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');



