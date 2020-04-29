
#######################################################
drop table if exists hjgztkhgx;

/*==============================================================*/
/* Table: hjgztkhgx                                             */
/*==============================================================*/
create table hjgztkhgx
(
   hjgztkhgxid          varchar(32) not null comment '监管主体客户关系表id',
   jgztkhgx             varchar(10) comment '客户关系',
   hviewjgztid          varchar(32) comment '监管主体ID',
   jgztkhbh             varchar(30) comment '客户编号',
   jgztkhmc             varchar(200) comment '客户名称',
   jgztkhmcjc           varchar(30) comment '客户名称简称',
   jgztkhlxr            varchar(30) comment '联系人',
   jgztkhyddh           varchar(20) comment '移动电话',
   jgztkhgddh           varchar(20) comment '固定电话',
   jgztkhlxdz           varchar(100) comment '联系地址',
   jgztkhzzzmmc         varchar(50) comment '资质证明名称',
   jgztkhzzzmbh         varchar(50) comment '资质证明编号',
   jgztfwnfww           varchar(10) comment '客户范围内范围外',
   jgztfwnztid          varchar(32) comment '范围内客户主体id，对应主体表id',
   primary key (hjgztkhgxid)
);

alter table hjgztkhgx comment '监管主体客户关系表';

##############################################

drop table if exists hjchz;

/*==============================================================*/
/* Table: hjchz                                                 */
/*==============================================================*/
create table hjchz
(
   hjchzid              varchar(32) not null comment '进出货主表id',
   hviewjgztid          varchar(32) comment '监管主体表id',
   jchpc                varchar(32) comment '进出货批次',
   jchlx                varchar(10) comment '进出货类型0进货1出货',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   监管主体客户关系表id          varchar(32) comment '监管主体客户关系表id',
   eptbh                varchar(32) comment 'e票通编号',
   primary key (hjchzid)
);

alter table hjchz comment '进出货主表';

######################################
drop table if exists jyjcyp;
create table jyjcyp
(
   jcypid               varchar(32) not null comment '商品ID',
   jcyplb               varchar(50) comment '商品类别,如果是商品见bs_spsc_sq_xkml.ml_id',
   jcypbh               varchar(100) comment '商品编号',
   jcypmc               varchar(100) comment '商品名称',
   jcypjc               varchar(30) comment '商品简称',
   jcypczy varchar(20) DEFAULT NULL COMMENT '操作员',
   jcypczsj datetime DEFAULT NULL COMMENT '操作时间',
   jcypgl               varchar(10) comment '商品归类aaa100=jcypgl',
   jcypsspp             varchar(100) comment '所属品牌',
   impcpgg              varchar(20) comment '规格',
   spsb                 varchar(50) comment '商品商标',
   spggxh               varchar(30) comment '商品规格型号',
   spjldw               varchar(20) comment '商品计量单位',
   spzxbzh              varchar(30) comment '商品执行标准号',
   spbzq                varchar(20) comment '商品保质期',
   jcyptp longblob DEFAULT NULL COMMENT '检查样品图片',
   jcyptpwjm varchar(200) DEFAULT NULL COMMENT '检查样品图片文件名',
   primary key (jcypid)
);

alter table jyjcyp comment '商品表';

#############################################
drop table if exists jyjcjg;

/*==============================================================*/
/* Table: jyjcjg                                                */
/*==============================================================*/
create table jyjcjg
(
   jcjgid               varchar(32) not null comment '检测结果id',
   eptbh                varchar(32) comment 'e票通编号',
   jcztbzjid            varchar(32) not null comment '检测主体表主键id',
   jcypid               varchar(32) comment '商品id',
   jcjylb               varchar(10) comment '检测检验类别aaa100=jcjylb',
   jcxmid               varchar(32) comment '检测项目id',
   jcorgid              varchar(32) comment '检测机构id',
   jcryid               varchar(32) comment '检测人员id',
   imphl                decimal(12,2) comment '检测值',
   jcxmbzz              varchar(20) comment '标准值',
   jcjycljg             decimal(12,2) comment '检测结果',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
  jcczsj datetime DEFAULT NULL COMMENT '检查操作时间',
  fjjg varchar(20) DEFAULT NULL COMMENT '复检结果',
  jcjyshbz varchar(10) DEFAULT NULL COMMENT '审核标志见aaa100=JCJYSHBZ',
  impyqlb varchar(50) DEFAULT NULL COMMENT '仪器类别（导入）',
  impbh varchar(20) DEFAULT NULL COMMENT '编号（导入）',
  impypzl varchar(50) DEFAULT NULL COMMENT '样品种类（导入）',
  impypmc varchar(50) DEFAULT NULL COMMENT '样品名称（导入）',
  impjcxm varchar(50) DEFAULT NULL COMMENT '检查项目（导入）',
  impssqy varchar(30) DEFAULT NULL COMMENT '所属区域（导入）',
  impyhmc varchar(50) DEFAULT NULL COMMENT '用户名称（导入）',
  impbjqy varchar(100) DEFAULT NULL COMMENT '被检企业（导入）',
  impcpsb varchar(50) DEFAULT NULL COMMENT '产品商标（导入）',
  impcppc varchar(50) DEFAULT NULL COMMENT '产品批次（导入）',
  impcpgg varchar(20) DEFAULT NULL COMMENT '产品规格（导入）',
  impsccj varchar(100) DEFAULT NULL COMMENT '生产厂家（导入）',
  impcysj varchar(20) DEFAULT NULL COMMENT '抽样时间（导入）',
  impjcsj varchar(20) DEFAULT NULL COMMENT '检测时间（导入）',
  impjcry varchar(20) DEFAULT NULL COMMENT '检查人员（导入）',
  impbz varchar(50) DEFAULT NULL COMMENT '备注（导入）',
  impbc1 varchar(50) DEFAULT NULL COMMENT '补充1（导入）',
  impbc2 varchar(50) DEFAULT NULL COMMENT '补充2（导入）',
  imprkrq varchar(20) DEFAULT NULL COMMENT '入库日期（导入）',
  impbatchno varchar(32) NOT NULL COMMENT '导入批次号',
  comid varchar(32) DEFAULT NULL COMMENT '企业id',
   primary key (jcjgid),
  INDEX IDX_jyjcjg_impbatchno (impbatchno)
);

alter table jyjcjg comment '检验检测表';

########################################################
drop table if exists hzthspdygx;

/*==============================================================*/
/* Table: hzthspdygx                                            */
/*==============================================================*/
create table hzthspdygx
(
   hzthspdygxid         varchar(32) not null comment '主体和商品对应关系表id',
   hviewjgztid          varchar(32) not null comment '监管主体表主键',
   jcypid               varchar(32) not null comment '商品ID',
   spsjlb               varchar(10) comment '商品数据类别0商品1原料2产品',
   primary key (hzthspdygxid)
);

alter table hzthspdygx comment '主体和商品对应关系表';

#####################################################
drop table if exists hztcphyldygx;

/*==============================================================*/
/* Table: hztcphyldygx                                          */
/*==============================================================*/
create table hztcphyldygx
(
   hztcphyldygxid       varchar(32) not null comment '主体产品和原料对应关系id',
   cpid                 varchar(32) comment '产品id',
   ylid                 varchar(32) comment '原料id',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hztcphyldygxid)
);

alter table hztcphyldygx comment '主体产品和原料对应关系';



##############################################################
drop table if exists hjchmx;

/*==============================================================*/
/* Table: hjchmx                                                */
/*==============================================================*/
create table hjchmx
(
   hjchmxid             varchar(32) not null comment '进出货明细表id',
   hjchzid              varchar(32) comment '进出货主表id',
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
   jchpc                varchar(32) comment '进出货批次',
   primary key (hjchmxid)
);

alter table hjchmx comment '进出货明细表';

#########################################################

drop table if exists hjyjczs;

/*==============================================================*/
/* Table: hjyjczs                                               */
/*==============================================================*/
create table hjyjczs
(
   jcztbzjid            varchar(32) not null comment '检测主体表主键id',
   hjyjczsid            varchar(32) not null comment '检验检测综述表id',
   jyjcbgbh             varchar(32) comment '检验检测报告编号',
   jyjczxbzh            varchar(30) comment '执行标准号',
   jyjcrq               date comment '检验检测日期',
   jyjcjl               varchar(10) comment '检验检测结论aaa100=JCHSCJYJL',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hjyjczsid)
);

alter table hjyjczs comment '检验检测综述表';
##############################################



##########################################################
drop table if exists pscfq;

/*==============================================================*/
/* Table: pscfq                                                 */
/*==============================================================*/
create table pscfq
(
   pscfqid              varchar(32) not null comment '市场分区id',
   comid                varchar(32) comment '市场id',
   scfqbh               varchar(32) comment '市场分区编号',
   scfqmc               varchar(100) comment '市场分区名称',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   aae013               varchar(100) comment '备注',
   primary key (pscfqid)
);

alter table pscfq comment '市场分区表';

##############################################################
drop table if exists psh;

/*==============================================================*/
/* Table: psh                                                   */
/*==============================================================*/
create table psh
(
   pshid                varchar(32) not null comment '商户id',
   comid                varchar(32) comment '市场id',
   pscfqid              varchar(32) comment '市场分区id',
   shtwh                varchar(50) comment '商户摊位号',
   shmc                 varchar(32) comment '商户名称',
   shjc                 varchar(32) comment '商户简称',
   shlxr                varchar(32) comment '商户联系人',
   shtxdz               varchar(100) comment '商户通讯地址',
   shyddh               varchar(20) comment '移动电话',
   shgddh               varchar(20) comment '固定电话',
   shsfzh               varchar(20) comment '身份证号',
   shzzzmmc             varchar(50) comment '资质证明名称',
   shzzzmbh             varchar(50) comment '资质证明编号',
   primary key (pshid)
);

alter table psh comment '商户表';

##################################################
drop table if exists pcomspaqjdy;

/*==============================================================*/
/* Table: pcomspaqjdy                                           */
/*==============================================================*/
create table pcomspaqjdy
(
   pcomspaqjdyid        varchar(32) not null comment '企业食品安全监督员id',
   comid                varchar(32) comment '企业id',
   userid               varchar(32) comment '用户id',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (pcomspaqjdyid)
);

alter table pcomspaqjdy comment '企业食品安全监督员';


##############################################################
drop table if exists pcomspaqzjgl;

/*==============================================================*/
/* Table: pcomspaqzjgl                                          */
/*==============================================================*/
create table pcomspaqzjgl
(
   pcomspaqzjglid       varchar(32) not null comment '企业食品安全组织管理id',
   spaqzzlb             varchar(10) comment '食品安全组织类别aaa100=spaqzzlb（领导小组，管理员）',
   spaqzysf             varchar(10) comment '食品安全组员身份aaa100=spaqzysf',
   comid                varchar(32) comment '企业id',
   ryid                 varchar(32) comment '企业人员id',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (pcomspaqzjglid)
);

alter table pcomspaqzjgl comment '企业食品安全组织管理';

#######################################################################
drop table if exists pcomzyjcjg;

/*==============================================================*/
/* Table: pcomzyjcjg                                            */
/*==============================================================*/
create table pcomzyjcjg
(
   pcomzyjcjg           varchar(32) not null comment '市场自有检测机构表id',
   marketid             varchar(32) comment '市场id',
   checkorgid           varchar(32) comment '检测机构id',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (pcomzyjcjg)
);

alter table pcomzyjcjg comment '市场自有检测机构表';

################################################

drop table if exists hcycd;

/*==============================================================*/
/* Table: hcycd                                                 */
/*==============================================================*/
create table hcycd
(
   hcycdid              varchar(32) not null comment '餐饮菜单表id',
   comid                varchar(32) comment '企业id',
   cpmc                 varchar(100) comment '菜品名称',
   cpjc                 varchar(50) comment '菜品简称',
   cpjj                 varchar(200) comment '菜品简介',
   cpsssj               datetime comment '菜品上市时间',
   sjbz                 varchar(10) comment '上架标志',
   caixi                varchar(10) comment '菜系aaa100=caixi',
   caipingl             varchar(10) comment '菜品归类aaa100=caipingl',
   cpjg                 decimal(10,2) comment '菜品价格',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hcycdid)
);

alter table hcycd comment '餐饮菜单表';

########################################################
drop table if exists hcyjxxjl;

/*==============================================================*/
/* Table: hcyjxxjl                                              */
/*==============================================================*/
create table hcyjxxjl
(
   hcyjxxjlid           varchar(32) not null comment '餐饮具洗消记录id',
   cjmc                 varchar(50) comment '餐具名称',
   xdfs                 varchar(10) comment '消毒方式aaa100=xdfs',
   wnd                  varchar(20) comment '温/浓度',
   xdkssj               datetime comment '消毒开始时间',
   xdjssj               datetime comment '消毒结束时间',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   comid                varchar(32) comment '企业id',
   primary key (hcyjxxjlid)
);

alter table hcyjxxjl comment '餐饮具洗消记录';

###################################################################
drop table if exists hyzcp;

/*==============================================================*/
/* Table: hyzcp                                                 */
/*==============================================================*/
create table hyzcp
(
   hyzcpid              varchar(32) not null comment '一周菜谱表id',
   cprq                 date comment '菜谱日期',
   cpxq                 varchar(10) comment '菜谱星期',
   jccc                 varchar(10) comment '就餐餐次aaa100=jccc',
   cpmc                 varchar(200) comment '菜谱名称',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hyzcpid)
);

alter table hyzcp comment '一周菜谱表';

################################################
drop table if exists hsply;

/*==============================================================*/
/* Table: hsply                                                 */
/*==============================================================*/
create table hsply
(
   hsplyid              varchar(32) not null comment '企业食品留样表id',
   jccc                 varchar(10) comment '留样餐次aaa100=jccc',
   splysj               datetime comment '留样时间',
   splypz               varchar(200) comment '留样品种',
   splyry               varchar(32) comment '留样人',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hsplyid)
);

alter table hsply comment '食品留样表';

#######################################################
drop table if exists pgzpj;

/*==============================================================*/
/* Table: pgzpj                                                 */
/*==============================================================*/
create table pgzpj
(
   pgzpjid              varchar(32) not null comment '公众评价表id',
   pjztid               varchar(32) comment '评价主体id',
   pjztmc               varchar(100) comment '评价主体名称',
   pjr                  varchar(32) comment '评价人',
   pjsj                 datetime comment '评价时间',
   pjbt                 varchar(100) comment '评价标题',
   pjnr                 text comment '评价内容',
   pjdj                 varchar(10) comment '评价等级aaa100=pjdj',
   pjrmobile            varchar(20) comment '评价人手机号',
   hfdpjid              varchar(32) comment '回复的评价id',
   primary key (pgzpjid)
);

alter table pgzpj comment '公众评价表';


#################################################################

drop table if exists pjcs;

/*==============================================================*/
/* Table: pjcs                                                  */
/*==============================================================*/
create table pjcs
(
   pjcsid               varchar(32) not null comment '评价参数表id',
   pjcslbbm             varchar(50) comment '评价参数类别编码',
   pjcslbmc             varchar(100) comment '评价参数类别名称',
   pjcsbm               varchar(50) comment '评价参数编码',
   pjcsmc               varchar(100) comment '评价参数名称',
   pjcsqybz             varchar(10) comment '评价参数启用标志0未启用1启用',
   primary key (pjcsid)
);

alter table pjcs comment '评价参数表';

###############################################################
drop table if exists pgzpjmx;

/*==============================================================*/
/* Table: pgzpjmx                                               */
/*==============================================================*/
create table pgzpjmx
(
   pgzpjmxid            varchar(32) not null comment '公众评价明细表',
   pgzpjid              varchar(32) not null comment '公众评价表id',
   pjcsid               varchar(32) not null comment '评价参数表id',
   pjxj                 varchar(10) comment '评价星级aaa100=pjxj',
   primary key (pgzpjmxid)
);

alter table pgzpjmx comment '公众评价明细表';


#############################################################################
drop view viewComxkz if exists viewComxkz;

CREATE VIEW viewComxkz AS
SELECT t1.comid,GROUP_CONCAT(t2.aaa103) AS jgztzzzmmc,GROUP_CONCAT(t1.comxkzbh) AS jgztzzzmbh 
  FROM pcompanyxkz t1,aa10 t2
  WHERE t1.comxkzlx=t2.aaa102
    AND t2.aaa100='COMZZZM'
  GROUP BY t1.comid;


drop view hviewjgzt if exists hviewjgzt;
  DROP VIEW hviewjgzt;

CREATE view hviewjgzt
as
select a.comid AS hviewjgztid,a.comdm AS jgztbh,a.commc AS jgztmc,a.commcjc AS jgztmcjc,a.comfzr AS jgztlxr,a.comgddh AS jgztlxrgddh,
  a.comyddh AS jgztlxryddh,a.comdz AS jgzttxdz,a.aaa027,b.jgztzzzmmc,b.jgztzzzmbh,'1' AS jgztlx,'' AS jgztgsztid,'1' AS jgztfwnfww
  from pcompany a,viewComxkz b
  WHERE a.comid=b.comid
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

############################################################################

#20170321BEGIN

drop table if exists pcomxiaolei;

/*==============================================================*/
/* Table: pcomxiaolei                                           */
/*==============================================================*/
create table pcomxiaolei
(
   pcomxiaoleiid        varchar(32) not null comment '企业小类表id',
   comid                varchar(32) comment '企业id',
   comdalei             varchar(30) comment '企业大类编号',
   comxiaolei           varchar(30) comment '企业小类编号',
   primary key (pcomxiaoleiid)
);

alter table pcomxiaolei comment '企业小类表';



INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('SYSTEMCODE', 'tmsyjxt', '透明食药监系统', 199405, NULL, '2016062017322399074167292', '1443', NULL, NULL, NULL);

INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017032214445093628409569', '', '基础信息', '', 1, '0', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017032214512203630129263', '/tmcy/cdgl/CdMainIndex', '菜品管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'CdMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017032214530501870996230', '/tmcy/cdgl/SplyMainIndex', '食品留样', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'SplyMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017032214543540379928190', '/tmcy/cdgl/YzcpMainIndex', '一周菜谱', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'YzcpMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017032214561267029231430', '/tmcy/cdgl/XxjlMainIndex', '餐具洗消记录', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'XxjlMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');

call PRC_INSERTCODE('XDFS','消毒方式','1','1','热力消毒','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XDFS','消毒方式','1','2','药物消毒','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XDFS','消毒方式','1','3','紫外线消毒','199405',null,@P_CODE,@P_MSG);

INSERT INTO sysrole(ROLEID, ROLEDESC, ROLENAME, SYSROLEFLAG, ORGID) VALUES
('2017032318004929759887711', '企业用户角色', '企业用户角色', '0', '410000000000');

ALTER TABLE hyzcp
  ADD COLUMN comid VARCHAR(32) DEFAULT NULL COMMENT 'comid' AFTER aae036;
ALTER TABLE hsply
  ADD COLUMN comid VARCHAR(32) DEFAULT NULL COMMENT '企业id' AFTER aae036;
  
































































  


