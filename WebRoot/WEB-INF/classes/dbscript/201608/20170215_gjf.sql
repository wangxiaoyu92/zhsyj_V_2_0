/*操作员签到功能*/
drop table if exists qddsz;

/*==============================================================*/
/* Table: qddsz                                                 */
/*==============================================================*/
create table qddsz
(
   qddszid              varchar(32) not null comment '签到点设置表ID',
   qddmc                varchar(200) comment '签到点名称',
   qddjdzb              varchar(50) comment '签到点经度坐标',
   qddwdzb              varchar(50) comment '签到点纬度坐标',
   qddyxjl              decimal(10) comment '签到点有效距离(以米为单位)',
   qdddz                varchar(200) comment '签到点地址',
   aae011               varchar(30) comment '操作员',
   aae036               datetime comment '操作时间',
   aae013               varchar(100) comment '备注',
   aae100               varchar(2) comment '是否有效0无效1有效',
   primary key (qddszid)
);

alter table qddsz comment '签到点设置表';


drop table if exists qddczybd;

/*==============================================================*/
/* Table: qddczybd                                              */
/*==============================================================*/
create table qddczybd
(
   qddczybdid           varchar(32) not null comment '操作员签到点绑定表',
   userid               varchar(32) comment '操作员ID',
   qddszid              varchar(32) comment '签到点设置表ID',
   aae011               varchar(30) comment '操作员',
   aae036               datetime comment '操作日期',
   aae013               varchar(100) comment '备注',
   primary key (qddczybdid)
);

alter table qddczybd comment '操作员签到点绑定表';

alter table qddczybd add constraint FK_Reference_13 foreign key (qddszid)
      references qddsz (qddszid) on delete restrict on update restrict;