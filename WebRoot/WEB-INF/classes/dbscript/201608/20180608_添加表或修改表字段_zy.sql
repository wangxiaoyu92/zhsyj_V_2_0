-- 企业表 汤阴用
ALTER TABLE pcompany
  CHANGE COLUMN comzczj comzczj VARCHAR(30) DEFAULT NULL COMMENT '注册资金（万元）',
  ADD COLUMN sjdatatime date DEFAULT NULL COMMENT '省局数据同步时间' AFTER orderno,
  ADD COLUMN outercomid varchar(32) DEFAULT NULL COMMENT '外部系统主键' AFTER sjdatatime,
  ADD COLUMN sjdatacomid varchar(32) DEFAULT NULL COMMENT '省局数据主键' AFTER outercomid,
  ADD COLUMN sjdatacomdm varchar(32) DEFAULT NULL COMMENT '省局数据企业代码' AFTER sjdatacomid,
  ADD COLUMN comjlzj varchar(10) DEFAULT NULL COMMENT '酒类专兼' AFTER sjdatacomdm,
  ADD COLUMN comjlyw varchar(50) DEFAULT NULL COMMENT '酒类有无' AFTER comjlzj,
  ADD COLUMN commdbh varchar(50) DEFAULT NULL COMMENT '门店编号' AFTER comjlyw;

-- 许可证表 汤阴用
ALTER TABLE pcompanyxkz
  ADD COLUMN sjdatatime date  DEFAULT NULL COMMENT '省局数据同步时间' AFTER comxkzjycs,
  ADD COLUMN sjdataid VARCHAR(32) DEFAULT NULL COMMENT '省局数据主键' AFTER sjdatatime,
  ADD COLUMN sjdatacomdm VARCHAR(32) DEFAULT NULL COMMENT '省局数据企业代码' AFTER sjdataid;

-- aa10表
ALTER TABLE aa10
  ADD COLUMN yxbz varchar(10)  DEFAULT '1' COMMENT '有效标志0无效1有效' AFTER aae036,
  ADD COLUMN paixu int(11) DEFAULT 0 COMMENT '排序用' AFTER yxbz;

update aa10 set yxbz='1';

-- bs_daima表
ALTER TABLE bs_daima
  ADD COLUMN comdalei VARCHAR(50) DEFAULT NULL COMMENT '对应的企业大类' AFTER duiyingzhi;

-- 溯源码查询日志表
CREATE TABLE qsymqrylog (
  qsymqrylogid VARCHAR(32) NOT NULL COMMENT '溯源码查询日志ID',
  qrysym VARCHAR(50) DEFAULT NULL COMMENT '溯源码',
  qrytime DATETIME DEFAULT NULL COMMENT '查询时间',
  qryposition VARCHAR(200) DEFAULT NULL COMMENT '查询地点',
  PRIMARY KEY (qsymqrylogid)
)
ENGINE = INNODB
COMMENT = '溯源码查询日志';

-- fj表
ALTER TABLE fj
  ADD COLUMN FJCSDMZ VARCHAR(20) DEFAULT NULL COMMENT '对应PFJCS表字段' AFTER FJNAME,
  ADD COLUMN fjuserid VARCHAR(32) DEFAULT NULL COMMENT '附件userid' AFTER FJCSDMZ,
  ADD COLUMN fjczyxm VARCHAR(30) DEFAULT NULL COMMENT '操作员姓名' AFTER fjuserid,
  ADD COLUMN fjczsj DATETIME DEFAULT NULL COMMENT '操作时间' AFTER fjczyxm;

-- 进货表
ALTER TABLE hjhb
  ADD INDEX IDX_hjhb_jhsjfxid (jhsjfxid);

drop table if exists pcheckfreg;
create table pcheckfreg
(
   pcheckfregid         varchar(32) not null comment '检查频次表id',
   orgprop              varchar(10) comment '科室属性',
   orgpropdesc          varchar(50) comment '科室属性描述',
   itemtype             varchar(10) comment '检查类型',
   itemtypedesc         varchar(50) comment '检查类型描述',
   lhfjndpddj           varchar(10) comment '评定等级',
   lhfjndpddjdesc       varchar(50) comment '评定等级描述',
   checkpc              smallint comment '检查频次',
   plancodebz           varchar(10) comment '生成计划编码标志',
   plannamebz           varchar(50) comment '生成计划名称标志',
   czy                  varchar(20) comment '操作员',
   czsj                 datetime comment '操作时间',
   primary key (pcheckfregid)
);

alter table pcheckfreg comment '检查频次表';


ALTER TABLE bscheckplan
  ADD COLUMN lhfjndpddj VARCHAR(10) DEFAULT NULL COMMENT '量化或风险评定等级' AFTER planoperator,
  ADD COLUMN plancontrol VARCHAR(10) DEFAULT 0 COMMENT '计划控制0可以运行用户修改1系统内置计划,不允许用户修改删除' AFTER lhfjndpddj;
ALTER TABLE bscheckplan
  ADD COLUMN planmobankind VARCHAR(10) DEFAULT NULL COMMENT '计划模板类型aa10=PLANMOBANKIND' AFTER plancontrol;

update bscheckplan set plancontrol='0' where plancontrol is null or length(plancontrol)=0;

ALTER TABLE omcheckgroup
  ADD COLUMN planmobankind VARCHAR(10) DEFAULT NULL COMMENT '计划模板类型aa10=PLANMOBANKIND' AFTER itemsortid;


ALTER TABLE pcompanycomdalei
  ADD COLUMN aaz093 VARCHAR(32) DEFAULT NULL COMMENT '对应aa10主键' AFTER comdalei;

update pcompanycomdalei a set a.aaz093=(select t.aaz093 from viewcomfenlei t where t.aaa102=a.comdalei);

drop table if exists omprint;
create table omprint
(
   omprintid            varchar(32) not null comment '手机打印和检查模板对应表id',
   itemid               varchar(32) comment '检查模板id',
   itemname             varchar(200) comment '检查模板名称',
   tbodytype            varchar(50) comment '报表编码',
   miaoshu              varchar(200) comment '报表描述',
   primary key (omprintid)
);
alter table omprint comment '手机打印和检查模板对应表';

ALTER TABLE bstbodyinfo
  ADD COLUMN kuozhan1 TEXT DEFAULT NULL COMMENT '扩展1' AFTER miaoshu,
  ADD COLUMN kuozhan2 TEXT DEFAULT NULL COMMENT '扩展1' AFTER kuozhan1,
  ADD COLUMN kuozhan3 TEXT DEFAULT NULL COMMENT '扩展1' AFTER kuozhan2,
  ADD COLUMN kuozhan4 TEXT DEFAULT NULL COMMENT '扩展1' AFTER kuozhan3,
  ADD COLUMN kuozhan5 TEXT DEFAULT NULL COMMENT '扩展1' AFTER kuozhan4,
  ADD COLUMN kuozhan6 TEXT DEFAULT NULL COMMENT '扩展1' AFTER kuozhan5;
ALTER TABLE bstbodyinfo
  CHANGE COLUMN tbbodyid tbbodyid VARCHAR(100) DEFAULT NULL COMMENT '页面元素id';

ALTER TABLE pcompanynddtpj
  ADD COLUMN jingtaifen varchar(10) DEFAULT NULL COMMENT '静态分' AFTER pdjgscfs,
  ADD COLUMN dongtaifen varchar(10) DEFAULT NULL COMMENT '动态分' AFTER jingtaifen,
  ADD COLUMN defen varchar(10) DEFAULT NULL COMMENT '得分分' AFTER dongtaifen ;



drop table if exists pjingspxs;
create table pjingspxs
(
   pjingspxsid          varchar(32) not null comment '食品销售企业静态风险因素量化分值表',
   comid                varchar(32) comment '企业id',
   checkyear            varchar(4) comment '年度',
   spjycsmj             varchar(10) comment '食品经营场所面积',
   ybzcw                varchar(10) comment '预包装食品单品数常温',
   ybzlc                varchar(10) comment '预包装食品单品数冷藏',
   ybzld                varchar(10) comment '预包装食品单品数冷冻',
   szcw                 varchar(10) comment '散装食品单品数常温',
   szlc                 varchar(10) comment '散装食品单品数冷藏',
   szld                 varchar(10) comment '散装食品单品数冷冻',
   ghzsl                varchar(10) comment '供货者数量',
   dfzh                 varchar(10) comment '得分总和',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   resultid             varchar(32) comment '检查结果id',
   primary key (pjingspxsid)
);
alter table pjingspxs comment '食品销售企业静态风险因素量化分值表';

drop table if exists pjingcyfwlh;
create table pjingcyfwlh
(
   pjingcyfwlhid        varchar(32) not null comment '餐饮服务提供者静态风险因素量化分值表id',
   comid                varchar(32) comment '企业id',
   checkyear            varchar(4) comment '年度',
   ythgm                varchar(10) comment '业态和规模',
   lengshidp            varchar(10) comment '类别和数量冷食类单品数',
   lengshiyf            varchar(10) comment '类别和数量冷食类含易腐原料',
   shengshidp           varchar(10) comment '类别和数量生食类单品数',
   gaodiandp            varchar(10) comment '类别和数量糕点类单品数',
   gaodianyf            varchar(10) comment '类别和数量糕点类易腐原料',
   reshidp              varchar(10) comment '类别和数量热食类单品数',
   reshiyf              varchar(10) comment '类别和数量热食类易腐原料',
   zizhiyinpindp        varchar(10) comment '类别和数量自制饮品单品数',
   qitadp               varchar(10) comment '类别和数量其他类食品制售单品数',
   dfzh                 varchar(10) comment '得分总和',
   aae011               varchar(32) comment '经办人',
   aae036               datetime comment '经办时间',
   primary key (pjingcyfwlhid)
);
alter table pjingcyfwlh comment '餐饮服务提供者静态风险因素量化分值表';
create index Index_pjingcyfwlh on pjingcyfwlh
(
   comid,
   checkyear
);


drop index Index_pcyfwnddjpd2 on pcyfwnddjpd;

drop index Index_pcyfwnddjpd on pcyfwnddjpd;

drop table if exists pcyfwnddjpd;
create table pcyfwnddjpd
(
   pcyfwnddjpdid        varchar(32) not null comment '餐饮服务食品安全监督年度等级评定表id',
   comid                varchar(32) comment '单位id',
   checkyear            varchar(4) comment '年度',
   dwmc                 varchar(200) comment '单位名称',
   comdz                varchar(200) comment '地址',
   comfrhyz             varchar(20) comment '法定代表人（负责人或业主）',
   comyddh              varchar(20) comment '电话',
   cyfwxkzh             varchar(50) comment '餐饮服务许可证证号',
   xklb                 varchar(500) comment '许可类别',
   ndpjdf               decimal(6,2) comment '年度平均得分',
   lhfjndpddj           varchar(10) comment '评定等级',
   cpyj                 varchar(200) comment '初评意见',
   cprq                 date comment '初评日期',
   cpdj                 varchar(10) comment '初评等级',
   fpyj                 varchar(200) comment '复评意见',
   fprq                 date comment '复评日期',
   fpdj                 varchar(10) comment '复评等级',
   spyj                 varchar(200) comment '审评意见',
   sprq                 date comment '审评日期',
   spdj                 varchar(10) comment '审评等级',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   resultid             varchar(32) comment 'resultid',
   年度评定等级               varchar(10) comment '年度评定等级',
   primary key (pcyfwnddjpdid)
);
alter table pcyfwnddjpd comment '餐饮服务食品安全监督年度等级评定表';
create index Index_pcyfwnddjpd on pcyfwnddjpd
(
   comid,
   checkyear
);
create index Index_pcyfwnddjpd2 on pcyfwnddjpd
(
   resultid
);


create table pcyfwnddjpdmx
(
   pcyfwnddjpdmxid      varchar(32) not null comment '餐饮服务食品安全监督年度等级评定表明细id',
   pcyfwnddjpdid        varchar(32) comment '餐饮服务食品安全监督年度等级评定表id',
   jcrq                 date comment '检查日期',
   defen                decimal(6,2) comment '得分',
   lhfjndpddj           varchar(10) comment '评定等级',
   primary key (pcyfwnddjpdmxid)
);
alter table pcyfwnddjpdmx comment '餐饮服务食品安全监督年度等级评定表明细';


drop table if exists pcomriskconfirm;
create table pcomriskconfirm
(
   pcomriskconfirmid    varchar(32) not null comment '食品生产经营者风险等级确定表id',
   comid                varchar(32) comment '企业id',
   checkyear            varchar(4) comment '年度',
   checkno              varchar(50) comment '编号',
   commc                varchar(200) comment '企业名称',
   comdz                varchar(200) comment '企业地址',
   zzzmbh               varchar(50) comment '营业执照编号或信用代码',
   lxrhfs               varchar(50) comment '联系人及联系方式',
   sndfxdj              varchar(10) comment '上年度风险等级',
   staticscore          decimal(6,2) comment '静态风险因素量化风险分值',
   dynamicscore         decimal(6,2) comment '动态风险因素量化风险分值',
   totalscore           decimal(6,2) comment '风险等级得分',
   fxdj                 varchar(10) comment '风险等级',
   gywfflfg             varchar(2) comment '故意违反食品安全法律法规0否1是',
   ycjysbfh             varchar(2) comment '有1次及以上国家或者省级监督抽检不符合食品安全标准的0否1是',
   wfflfg               varchar(2) comment '违反食品安全法律法规规定0否1是',
   fsaqsg               varchar(2) comment '发生食品安全事故的0否1是',
   bagd                 varchar(2) comment '不按规定进行产品召回或者停止生产经营的',
   bpezf                varchar(2) comment '拒绝、逃避、阻挠执法人员进行监督检查',
   kstdj                varchar(2) comment '可以上调风险等级情形的',
   suggestfxdj          varchar(2) comment '是否上调个风险等级1上调2不调3下调',
   xyndfxdj             varchar(10) comment '下一年度风险等级',
   fxdjbz               varchar(500) comment '备注',
   tbrqm                varchar(200) comment '填表人签名，存放对于附件表id',
   tbrqmrq              datetime comment '填表人签名日期',
   shrqm                varchar(200) comment '审核人签名，存放对于附件表id',
   shrqmrq              datetime comment '审核人签名日期',
   aae011               varchar(32) comment '经办人',
   aae036               datetime comment '经办时间',
   resultid             varchar(32) comment 'resultid',
   primary key (pcomriskconfirmid)
);
alter table pcomriskconfirm comment '食品生产经营者风险等级确定表';
create index Index_pcomriskconfirm on pcomriskconfirm
(
   comid,
   checkyear
);
create index Index_pcomriskconfirm2 on pcomriskconfirm
(
   resultid
);
ALTER TABLE pcomriskconfirm
  CHANGE COLUMN tbrqmrq tbrqmrq DATE DEFAULT NULL COMMENT '填表人签名日期',
  CHANGE COLUMN shrqmrq shrqmrq DATE DEFAULT NULL COMMENT '审核人签名日期';


drop table if exists pjingcyfwlh;
create table pjingcyfwlh
(
   pjingcyfwlhid        varchar(32) not null comment '餐饮服务提供者静态风险因素量化分值表id',
   comid                varchar(32) comment '企业id',
   checkyear            varchar(4) comment '年度',
   ythgm                varchar(10) comment '业态和规模',
   lengshidp            varchar(10) comment '类别和数量冷食类单品数',
   lengshiyf            varchar(10) comment '类别和数量冷食类含易腐原料',
   shengshidp           varchar(10) comment '类别和数量生食类单品数',
   gaodiandp            varchar(10) comment '类别和数量糕点类单品数',
   gaodianyf            varchar(10) comment '类别和数量糕点类易腐原料',
   reshidp              varchar(10) comment '类别和数量热食类单品数',
   reshiyf              varchar(10) comment '类别和数量热食类易腐原料',
   zizhiyinpindp        varchar(10) comment '类别和数量自制饮品单品数',
   qitadp               varchar(10) comment '类别和数量其他类食品制售单品数',
   dfzh                 varchar(10) comment '得分总和',
   aae011               varchar(32) comment '经办人',
   aae036               datetime comment '经办时间',
   resultid             varchar(32) comment 'resultid',
   primary key (pjingcyfwlhid)
);
alter table pjingcyfwlh comment '餐饮服务提供者静态风险因素量化分值表';
create index Index_pjingcyfwlh on pjingcyfwlh
(
   comid,
   checkyear
);
create index Index_pjingcyfwlh2 on pjingcyfwlh
(
   resultid
);

drop table if exists pcyfwnddjpd;
create table pcyfwnddjpd
(
   pcyfwnddjpdid        varchar(32) not null comment '餐饮服务食品安全监督年度等级评定表id',
   comid                varchar(32) comment '单位id',
   checkyear            varchar(4) comment '年度',
   dwmc                 varchar(200) comment '单位名称',
   comdz                varchar(200) comment '地址',
   comfrhyz             varchar(20) comment '法定代表人（负责人或业主）',
   comyddh              varchar(20) comment '电话',
   cyfwxkzh             varchar(50) comment '餐饮服务许可证证号',
   xklb                 varchar(500) comment '许可类别',
   ndpjdf               decimal(6,2) comment '年度平均得分',
   lhfjndpddj           varchar(10) comment '评定等级',
   cpyj                 varchar(200) comment '初评意见',
   cprq                 date comment '初评日期',
   fpyj                 varchar(200) comment '复评意见',
   fprq                 date comment '复评日期',
   spyj                 varchar(200) comment '审评意见',
   sprq                 date comment '审评日期',
   aae011               varchar(20) comment '操作员',
   aae036               datetime comment '操作时间',
   resultid             varchar(32) comment 'resultid',
   primary key (pcyfwnddjpdid)
);
alter table pcyfwnddjpd comment '餐饮服务食品安全监督年度等级评定表';
create index Index_pcyfwnddjpd on pcyfwnddjpd
(
   comid,
   checkyear
);
create index Index_pcyfwnddjpd2 on pcyfwnddjpd
(
   resultid
);
ALTER TABLE pcyfwnddjpd
  CHANGE COLUMN aae011 aae011 VARCHAR(32) DEFAULT NULL COMMENT '操作员';


ALTER TABLE bschecklhfjpjcs
  ADD COLUMN dengjicskind VARCHAR(10) DEFAULT NULL COMMENT '参数类型11动态餐饮21年度餐饮22年度生产经营' AFTER lhfjpdndyjccs;

CREATE TABLE omcheckbasis (
  basisid varchar(32) NOT NULL COMMENT '主键',
  type varchar(1) DEFAULT NULL COMMENT '检查方式',
  typedesc varchar(500) DEFAULT NULL COMMENT '检查方式描述',
  guide varchar(1000) DEFAULT NULL COMMENT '检查指南',
  punishmeasures varchar(1000) DEFAULT NULL COMMENT '处罚措施',
  basisdesc varchar(4000) DEFAULT NULL COMMENT '检查依据描述',
  operator varchar(32) DEFAULT NULL COMMENT '经办人ID',
  operatorname varchar(32) DEFAULT NULL COMMENT '经办人名称',
  operatedate datetime DEFAULT NULL COMMENT '经办时间',
  sort int(20) DEFAULT NULL COMMENT '排序',
  basiscode varchar(20) DEFAULT NULL COMMENT '对应Omcheckbasis表字段',
  PRIMARY KEY (basisid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查依据表';

ALTER TABLE pcomqrcode
  ADD UNIQUE INDEX UK_pcomqrcode_comid (comid);

ALTER TABLE pcomrcjdglry
  ADD INDEX IDX_pcomrcjdglry_userid (userid);

drop table if exists pcyfwdtdjpdb;
create table pcyfwdtdjpdb
(
   pcyfwdtdjpdbid       varchar(32) not null comment '餐饮服务食品安全监督动态等级评定表id',
   comid                varchar(32) comment '企业id',
   resultid             varchar(32) comment '检查主表id',
   commc                varchar(200) comment '被检查单位名称',
   comdz                varchar(200) comment '地址',
   comfrhyz             varchar(20) comment '法定代表人',
   comyddh              varchar(20) comment '电话',
   comxkzbh             varchar(50) comment '餐饮服务许可证编号',
   xklb                 varchar(100) comment '许可类别',
   jcryqzpic            varchar(100) comment '检查人员签字',
   spaqglrypic          varchar(100) comment '食品安全管理人员签字',
   jckssj               datetime comment '检查开始时间',
   jcjssj               datetime comment '检查结束时间',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (pcyfwdtdjpdbid)
);
alter table pcyfwdtdjpdb comment '餐饮服务食品安全监督动态等级评定表';


drop table if exists jyjcxm;
create table jyjcxm
(
   jyjcxmid             varchar(32) not null comment '检验检测项目表id',
   jcxmparentid         varchar(32) comment '父id',
   jcxmbh               varchar(10) comment '检查项目编号',
   jcxmmc               varchar(100) comment '检查项目名称',
   jcxmbzz              varchar(20) comment '标准值',
   jcxmczy              varchar(32) comment '操作员',
   jcxmczsj             datetime comment '操作时间',
   sfyx                 varchar(10) comment '是否有效',
   primary key (jyjcxmid)
);
alter table jyjcxm comment '检验检测项目表';

drop table if exists parentchild;
create table parentchild
(
   parentchildid        varchar(32) not null comment '通用父子关系表id',
   parentchildlb        varchar(20) not null comment '类别',
   parentchildlbmc      varchar(100) comment '类别名称',
   parentid             varchar(32) not null comment '父id',
   bh                   varchar(20) comment '编号',
   mc                   varchar(100) not null comment '名称',
   sfyx                 varchar(10) comment '有效标志',
   userid               varchar(32) comment '操作员id',
   username             varchar(50) comment '操作员姓名',
   czsj                 datetime comment '操作时间',
   sx1                  varchar(100) comment '属性1',
   sx2                  varchar(100) comment '属性2',
   sx3                  varchar(100) comment '属性3',
   sx4                  varchar(100) comment '属性4',
   sx5                  varchar(100) comment '属性5',
   sx6                  varchar(100) comment '属性6',
   sx7                  varchar(100) comment '属性7',
   sx8                  varchar(100) comment '属性8',
   sx9                  varchar(100) comment '属性9',
   sx10                 varchar(100) comment '属性10',
   primary key (parentchildid)
);
alter table parentchild comment '通用父子关系表';
create index Index_parentchild on parentchild
(
   parentchildlb
);

ALTER TABLE bscheckdetail
  CHANGE COLUMN detailscore detailscore DECIMAL(5, 2) DEFAULT NULL COMMENT '明细得分';


ALTER TABLE jyjccydj
  ADD COLUMN jcypid VARCHAR(32) DEFAULT NULL COMMENT '检测样品id' AFTER aae036;
ALTER TABLE jyjccydj
  ADD COLUMN ypgg VARCHAR(30) DEFAULT NULL AFTER jcypid;


ALTER TABLE sysuser
  ADD COLUMN userdwmc VARCHAR(100) DEFAULT NULL COMMENT '用户单位名称' AFTER userjc,
  ADD COLUMN userlxdz VARCHAR(255) DEFAULT NULL COMMENT '用户联系地址' AFTER userdwmc,
  ADD COLUMN useremail VARCHAR(50) DEFAULT NULL COMMENT '用户电子邮箱' AFTER userlxdz,
  ADD COLUMN findpwsn VARCHAR(255) DEFAULT NULL COMMENT '找回密码时生成的随机数' AFTER useremail,
  ADD COLUMN usercomid VARCHAR(32) DEFAULT NULL COMMENT '企业下用户归属的企业id' AFTER findpwsn,
  ADD COLUMN userposition VARCHAR(32) DEFAULT NULL COMMENT '用户职位' AFTER usercomid,
  ADD COLUMN easemobflag VARCHAR(10) DEFAULT NULL COMMENT '环信用户标志0否1是' AFTER userposition;


update sysuser set usercomid=aaz001 where aaz001 is not null and usercomid is null;


ALTER TABLE pfjcs
  DROP INDEX index_dm_dmz,
  CHANGE COLUMN FJCSDMLB FJCSDMLB VARCHAR(40) NOT NULL COMMENT '代码类别';

ALTER TABLE pfjcs
  DROP INDEX index_dm_dmlb,
  ADD UNIQUE INDEX index_dm_dmlb (FJCSDMLB, FJCSDMZ);


ALTER TABLE pcyfwnddjpd
  DROP COLUMN 年度评定等级;


ALTER TABLE sysorg
  ADD COLUMN usercomid VARCHAR(32) DEFAULT NULL COMMENT '企业用户归属的comid' AFTER aab301;


ALTER TABLE pcompanyimport
  ADD COLUMN doflag INT DEFAULT 0 COMMENT '处理标志' AFTER orgsimpleText;


ALTER TABLE jyjcxm
  CHANGE COLUMN jyjcxmid jcxmid VARCHAR(32) NOT NULL COMMENT '检验检测项目表id',
  ADD COLUMN jyjcxmlx VARCHAR(10) DEFAULT NULL COMMENT '检验检测项目类型' AFTER jcxmmcjc,
  ADD COLUMN sfmulu VARCHAR(10) DEFAULT NULL COMMENT '是否目录aaa100=shifoubz' AFTER jyjcxmlx;

---------产品生长环境信息关联
ALTER TABLE envairinfo
  ADD COLUMN proid VARCHAR(32) DEFAULT NULL COMMENT '产品id' AFTER airdustfall,
  ADD COLUMN cppcpch VARCHAR(50) DEFAULT NULL COMMENT '产品批次号' AFTER proid,
  ADD COLUMN operatoruserid VARCHAR(32) DEFAULT NULL COMMENT '操作用户ID' AFTER cppcpch,
  ADD COLUMN operatorusername VARCHAR(255) DEFAULT NULL COMMENT '操作用户名' AFTER operatoruserid,
  ADD COLUMN operatordate datetime DEFAULT NULL COMMENT '操作日期' AFTER operatorusername;

ALTER TABLE envsoilinfo
  ADD COLUMN proid VARCHAR(32) DEFAULT NULL COMMENT '产品id' AFTER operatoreditdate,
  ADD COLUMN cppcpch VARCHAR(50) DEFAULT NULL COMMENT '产品批次号' AFTER proid;

ALTER TABLE envwalterinfo
  ADD COLUMN proid VARCHAR(32) DEFAULT NULL COMMENT '产品id' AFTER walterturbidity,
  ADD COLUMN cppcpch VARCHAR(50) DEFAULT NULL COMMENT '产品批次号' AFTER proid,
  ADD COLUMN operatoruserid VARCHAR(32) DEFAULT NULL COMMENT '操作用户ID' AFTER cppcpch,
  ADD COLUMN operatorusername VARCHAR(255) DEFAULT NULL COMMENT '操作用户名' AFTER operatoruserid,
  ADD COLUMN operatordate datetime DEFAULT NULL COMMENT '操作日期' AFTER operatorusername;

CREATE TABLE hkjbgd (
  hkjbgdid varchar(32) NOT NULL COMMENT '快检报告单id',
  kjbgdpch varchar(32) DEFAULT NULL COMMENT '快检报告单批次号',
  jcdwfzrqzpic varchar(100) DEFAULT NULL COMMENT '快检报告单检测单位负责人签字',
  jcdwfzrqzrq datetime DEFAULT NULL COMMENT '快检报告单检测单位负责人签字日期',
  kjbgdjcr varchar(32) DEFAULT NULL COMMENT '快检报告单检测人',
  bjcdwfzrqzpic varchar(100) DEFAULT NULL COMMENT '快检报告单被检测单位负责人签字',
  bjcdwfzrqzrq datetime DEFAULT NULL COMMENT '快检报告单被检测单位负责人签字日期',
  kjbgdprint text DEFAULT NULL COMMENT '快检报告单printhtml，bstbodyinfo=kjbgd',
  czyxm varchar(32) DEFAULT NULL COMMENT '操作员姓名',
  czyid varchar(32) DEFAULT NULL COMMENT '操作员id',
  aae036 datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (hkjbgdid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 49152
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '快检报告单';

ALTER TABLE hjyjczb
  ADD COLUMN kjbgdxh int(11) DEFAULT NULL COMMENT '快检报告单内容序号' AFTER detectiondatatype,
  ADD COLUMN comdz VARCHAR(200) DEFAULT NULL COMMENT '快检报告单被检查单位地址' AFTER kjbgdxh,
  ADD COLUMN kjbgdjcjg VARCHAR(200) DEFAULT NULL COMMENT '快检报告单检验结果' AFTER comdz,
  ADD COLUMN kjbgdpch VARCHAR(32) DEFAULT NULL COMMENT '快检报告单批次号' AFTER kjbgdjcjg,
  ADD COLUMN aaa027 varchar(12) DEFAULT NULL COMMENT '地区编码' AFTER kjbgdpch;

CREATE TABLE qpesticide (
  pesticideid varchar(32) NOT NULL COMMENT 'ID',
  pesticidecomid varchar(32) NOT NULL COMMENT '所属公司ID',
  pesticidename varchar(200) NOT NULL COMMENT '名称',
  pesticidesb varchar(50) DEFAULT NULL COMMENT '商标',
  pesticidesptm varchar(13) DEFAULT NULL COMMENT '条码',
  pesticidegg varchar(50) DEFAULT NULL COMMENT '规格型号',
  pesticidesccj varchar(200) DEFAULT NULL COMMENT '生产厂家',
  pesticidepm varchar(100) DEFAULT NULL COMMENT '品名',
  pesticidebzq varchar(10) DEFAULT NULL COMMENT '保质期',
  pesticidecdjd varchar(200) DEFAULT NULL COMMENT '产地/基地名称',
  pesticideplxx varchar(500) DEFAULT NULL COMMENT '配料信息',
  pesticidecpbzh varchar(20) DEFAULT NULL COMMENT '产品标准号',
  pesticidezl char(1) DEFAULT NULL COMMENT '产品种类 1药物  2肥料 3针剂aaa100=PESTICIDEZL',
  pesticidebzqdwcode varchar(32) DEFAULT NULL COMMENT '保质期单位代码aaa100=BZQDWMC ',
  pesticidebzqdwmc varchar(6) DEFAULT NULL COMMENT '保质期单位名称',
  pesticidebzgg varchar(50) DEFAULT NULL COMMENT '包装规格',
  pesticidecjdh varchar(20) DEFAULT NULL COMMENT '厂家电话',
  pesticidecjdz varchar(200) DEFAULT NULL COMMENT '厂家地址',
  pesticidejysl decimal(10, 2) DEFAULT NULL COMMENT '结余数量',
  pesticidejj varchar(2000) DEFAULT NULL COMMENT '简介',
  pesticidesyfw varchar(2000) DEFAULT NULL COMMENT '适用范围',
  pesticidedyzz varchar(2000) DEFAULT NULL COMMENT '对应症状',
  PRIMARY KEY (pesticideid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 264
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '农药信息表';

ALTER TABLE hjcjgjcyqb
  ADD COLUMN aaa027 VARCHAR(12) DEFAULT NULL COMMENT '操作员统筹区' AFTER aae036;