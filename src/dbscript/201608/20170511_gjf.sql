INSERT INTO sysorg(ORGID, ORGNAME, SHORTNAME, ORGDESC, PARENT, ADDRESS, PRINCIPAL, LINKMAN, TEL, ORGKIND, ORGCODE, ORDERNO, fz, aab301) VALUES
('2017050814384364214643306', '商户所属虚拟机构', '', '商户所属虚拟机构', '410000000000', '', '', '', '', '0', '410004', 1, '', NULL);

INSERT INTO sysrole(ROLEID, ROLEDESC, ROLENAME, SYSROLEFLAG, ORGID) VALUES
('2017050815244129895839170', '商户角色', '商户角色', '0', '2017050814384364214643306');

INSERT INTO sysrolefunction(ROLEFUNCTIONID, ROLEID, FUNCTIONID, CHECKTYPE) VALUES
('2017050815281399993420852', '2017050815244129895839170', '2017041414023375728737361', NULL);
INSERT INTO sysrolefunction(ROLEFUNCTIONID, ROLEID, FUNCTIONID, CHECKTYPE) VALUES
('2017050815281408255587599', '2017050815244129895839170', '2017041815162652022024970', NULL);
INSERT INTO sysrolefunction(ROLEFUNCTIONID, ROLEID, FUNCTIONID, CHECKTYPE) VALUES
('2017050815281408460213099', '2017050815244129895839170', '2017041817390364575796424', NULL);
INSERT INTO sysrolefunction(ROLEFUNCTIONID, ROLEID, FUNCTIONID, CHECKTYPE) VALUES
('2017050815281408666919340', '2017050815244129895839170', '2017041916571293079333091', NULL);
INSERT INTO sysrolefunction(ROLEFUNCTIONID, ROLEID, FUNCTIONID, CHECKTYPE) VALUES
('2017050815281408810555883', '2017050815244129895839170', '2017041916583910846359731', NULL);
INSERT INTO sysrolefunction(ROLEFUNCTIONID, ROLEID, FUNCTIONID, CHECKTYPE) VALUES
('2017050815281408928760454', '2017050815244129895839170', '2017042611105573937630105', NULL);

INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('USERKIND', '8', '商户', 199405, NULL, '2017050816265485816109819', '1320', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

#################################################### 
ALTER TABLE jyjcyp
  ADD COLUMN spsjlx VARCHAR(10) DEFAULT NULL COMMENT '商品数据类型aaa100=spsjlx0商品1生产企业产品2生产企业原材料' AFTER spfenlei,
  ADD COLUMN hviewjgztid VARCHAR(32) DEFAULT NULL COMMENT '监管主体表主键,生产企业设置自己的产品或原料时用到' AFTER spsjlx;

update jyjcyp set spsjlx='0' ;


call PRC_INSERTCODE('SPSJLX','商品数据类型','1','0','商品','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('SPSJLX','商品数据类型','1','1','生产企业产品','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('SPSJLX','商品数据类型','1','2','生产企业原材料','199405',null,@P_CODE,@P_MSG);


call PRC_INSERTCODE('CPSCJYJL','产品生产检验结论','1','0','不合格','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('CPSCJYJL','产品生产检验结论','1','1','自行检验合格','199405',null,@P_CODE,@P_MSG);


INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('SPJLDW', '101004', '箱', 199405, NULL, '2017050918115495429129335', '2017031612031565864654132', NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017050615020527956371204', '/tmsyjhtgl/jianceIndex', '检测信息管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'jianceIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017050820453522759657844', '', '生产企业基础信息', '', 1, '0', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017050820472184850934380', '/jyjc/jyjcypIndex?spsjlx=2', '生产企业原材料管理 ', '2017050820453522759657844', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017050820482339842850665', '/jyjc/jyjcypIndex?spsjlx=1', '生产企业产品管理', '2017050820453522759657844', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017050908303528517240127', '/tmsyjhtgl/cpyclIndex', '生产企业产品所用原材料管理', '2017050820453522759657844', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017050908321813658292769', '/tmsyjhtgl/jinhuoIndex?qykind=scqy', '生产企业进货管理', '2017050820453522759657844', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017050908335353385832710', '/tmsyjhtgl/scpcIndex', '生产企业产品生产管理', '2017050820453522759657844', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017050908343525948469451', '/tmsyjhtgl/scxhIndex', '生产企业销货管理', '2017050820453522759657844', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');




drop table if exists hcphycldyb;

/*==============================================================*/
/* Table: hcphycldyb                                            */
/*==============================================================*/
create table hcphycldyb
(
   hcphycldybid         varchar(32) not null comment '生产企业产品和原材料对应表id',
   cpid                 varchar(32) comment '产品id',
   yclid                varchar(32) comment '原材料id',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   hviewjgztid          varchar(32) comment '监管主体表主键',
   primary key (hcphycldybid)
);

alter table hcphycldyb comment '生产企业产品和原材料对应表';

drop table if exists hscpcb;

/*==============================================================*/
/* Table: hscpcb                                                */
/*==============================================================*/
create table hscpcb
(
   hscpcbid             varchar(32) not null comment '生产批次表id',
   hviewjgztid          varchar(32) comment '监管主体表id(仪器对接用)',
   jcypid               varchar(32) comment '产品id',
   scpch                varchar(32) comment '生产批次号',
   sptm                 varchar(50) comment '商品条码',
   scrq                 datetime comment '生产日期',
   bzrq                 datetime comment '保质日期',
   spjybgbh             varchar(40) comment '产品检验报告编号',
   jyzxbzh              varchar(40) comment '检验执行标准号',
   jyrq                 datetime comment '检验日期',
   cpscjyjl             varchar(10) comment '产品生产检验结论aaa100=cpscjyjl',
   scsl                 decimal(12,2) comment '生产数量',
   sysl                 decimal(12,2) comment '剩余数量',
   scspjldw             varchar(10) comment '计量单位',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hscpcbid)
);

alter table hscpcb comment '生产企业生产批次表';


drop table if exists hscxhb;

/*==============================================================*/
/* Table: hscxhb                                                */
/*==============================================================*/
create table hscxhb
(
   hscxhbid             varchar(32) not null comment '生产销货表id',
   hscpcbid             varchar(32) comment '生产批次表id',
   hviewjgztid          varchar(32) comment '监管主体表id(仪器对接用)',
   jcypid               varchar(32) comment '商品id',
   jxsid                varchar(32) comment '经销商id',
   xssj                 datetime comment '销售时间',
   xssl                 decimal(12,2) comment '销售数量',
   xhspjldw             varchar(10) comment '计量单位',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (hscxhbid)
);

alter table hscxhb comment '生产企业销货表';



ALTER TABLE jyjcyp
  DROP INDEX UK_jyjcyp_jcypmc,
  ADD INDEX UK_jyjcyp_jcypmc (jcypmc);


