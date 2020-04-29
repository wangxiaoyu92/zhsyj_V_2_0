CREATE DEFINER = 'root'@'%'
PROCEDURE prc_单位生成账号信息(
  IN prm_comid varchar(32),
  IN prm_recreate varchar(10),
  out prm_AppCode  int,
  out prm_ErrorMsg VARCHAR(500)
)
begin
label_pro:begin  

 DECLARE v_commc VARCHAR(200);
 DECLARE v_comdm VARCHAR(200);
 DECLARE v_aaa027 varchar(12);
 DECLARE v_comyddh varchar(50);
 DECLARE v_mobile varchar(50);
 DECLARE v_comjyjcbz varchar(10);
 DECLARE v_roleid varchar(50);
 DECLARE v_userid varchar(50);
            

 DECLARE v_count int;
 DECLARE v_insert int;
 DECLARE v_userroleid varchar(32);

  declare exit handler for sqlexception   #not found,sqlwarning,
  begin
    SELECT 'ERROR';
    set prm_AppCode=-1;
    set prm_ErrorMsg='过程出错了';
    rollback;
    #leave label_pro;
  end;
  set @@autocommit= 0;
  set prm_AppCode:=0;
  set prm_ErrorMsg:='成功';

 SELECT COUNT(*)
 INTO v_count
 FROM sysuser s
 WHERE s.USERID=prm_comid;

set v_insert=0;
 IF v_count>0 THEN
   IF prm_recreate=1 then
     DELETE FROM sysuser WHERE aaz001=prm_comid;
     DELETE FROM sysuserrole WHERE aaz001=prm_comid;
     set v_insert=1;
   end IF;
 ELSE
   set v_insert=1;
 end IF;

 IF v_insert=1 THEN
   set v_userid=f_getSequenceStr();

   SELECT commc,aaa027,comyddh,comdm,comyddh,comjyjcbz
   INTO v_commc,v_aaa027,v_comyddh,v_comdm,v_mobile,v_comjyjcbz
   FROM pcompany 
   WHERE comid=prm_comid;  

   INSERT INTO sysuser(USERID,USERNAME,PASSWD,USERKIND,DESCRIPTION,AAA027,ORGID,aaz001,MOBILE)
   VALUES(v_userid,v_comdm,'e10adc3949ba59abbe56e057f20f883e','6',v_commc,v_aaa027,'2016062217255064055994870',prm_comid,v_mobile);

   set v_roleid='2016062216563315846077196';
   IF v_comjyjcbz='1' THEN
     set v_roleid='2016102114210245464588122';
   end IF;
   SELECT f_getSequenceStr() INTO v_userroleid;

   INSERT INTO sysuserrole(USERROLEID,USERID,roleid)VALUES(v_userroleid,v_userid,v_roleid);
 end IF;
   
 COMMIT;
       
end;
end

##############################################################
CREATE DEFINER = 'root'@'%'
PROCEDURE prc_单位生成账号信息批量(
  IN prm_recreate varchar(10),
  out prm_AppCode2  int,
  out prm_ErrorMsg2 VARCHAR(500)
)
begin
label_pro2:begin
  DECLARE done INT DEFAULT 0;     

 DECLARE v_comid VARCHAR(100);
  declare cur_com cursor for  
  SELECT 
    p.comid
  from pcompany p;

  declare continue handler for not found set done=1;
  declare exit handler for sqlexception   #not found,sqlwarning,
  begin
    SELECT 'ERROR';
    set prm_AppCode2=-1;
    set prm_ErrorMsg2='过程出错了';
    rollback;
    #leave label_pro;
  end;
  #set @@autocommit= 0;
  set prm_AppCode2:=0;
  set prm_ErrorMsg2:='成功';


  SET done=-1;
  open cur_com;
  mycomloop:loop
  fetch cur_com
  INTO
    v_comid;

    if done=1 then
      leave mycomloop;
    end if; 
    CALL prc_单位生成账号信息(v_comid,prm_recreate,prm_AppCode2,prm_ErrorMsg2);
   
    SET done=0;                                                      
  end loop mycomloop;
  close cur_com;

  COMMIT;
       
       
end;
end
####################################################################

ALTER TABLE hxhb
  CHANGE COLUMN hjhbid hjhbid VARCHAR(32) DEFAULT NULL COMMENT '对应的进货表id';

call PRC_INSERTCODE('JHQRBZ','进货确认标志','1','0','未确认','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('JHQRBZ','进货确认标志','1','1','已确认','199405',null,@P_CODE,@P_MSG);

ALTER TABLE hjhb
  ADD COLUMN jhqrbz VARCHAR(10) DEFAULT NULL COMMENT '进货确认标志0未1已' AFTER jhkcl;

######################################################################
drop table if exists hjyjczb;

/*==============================================================*/
/* Table: hjyjczb                                               */
/*==============================================================*/
create table hjyjczb
(
   hjyjczbid            varchar(32) not null comment '检验检测主表id',
   hviewjgztid          varchar(32) comment '监管主体表id(仪器对接用)',
   hviewjgztmc          varchar(100) comment '监管主体名称(仪器对接用:被检单位)',
   jcztbzjid            varchar(32) not null comment '检测主体表主键id',
   jyjcbgbh             varchar(32) comment '检验检测报告编号',
   jyjcrq               datetime comment '检验检测日期(仪器对接用)',
   eptbh                varchar(32) comment 'e票通编号',
   jcypid               varchar(32) comment '商品id(仪器对接用)',
   jcypmc               varchar(50) comment '商品名称(仪器对接用-样品名称)',
   jcjylb               varchar(10) comment '检测检验类别aaa100=jcjylb',
   jcorgid              varchar(32) comment '检测机构id',
   jcorgmc              varchar(100) comment '检测机构名称(仪器对接用:检测单位)',
   jcryid               varchar(32) comment '检测人员id',
   jcrymc               varchar(50) comment '检测人员名称(仪器对接用)',
   fjjg                 varchar(20) comment '复检结果',
   jcjyshbz             varchar(10) comment '审核标志见aaa100=JCJYSHBZ',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   sjcsfs               varchar(10) comment '数据产生方式0本系统录入1仪器对接',
   sbxh                 varchar(50) comment '设备型号(仪器对接用)',
   sbxlh                varchar(50) comment '设备序列号',
   primary key (hjyjczbid)
);

alter table hjyjczb comment '检验检测主表';

##################################################
drop table if exists hjyjcmxb;

/*==============================================================*/
/* Table: hjyjcmxb                                              */
/*==============================================================*/
create table hjyjcmxb
(
   hjyjcmxbid           varchar(32) not null comment '检验检测明细表id',
   hjyjczbid            varchar(32) not null comment '检验检测主表id',
   jcxmid               varchar(32) comment '检测项目id(仪器导入用)',
   jcxmmc               varchar(50) comment '检测项目名称(仪器导入用)',
   jcz                  varchar(20) comment '检测值(仪器导入用)',
   szdw                 varchar(20) comment '数值单位(仪器导入用)',
   jyjcjl               varchar(10) comment '检验检测结论aaa100=jyjcjl(仪器导入用-结果判定)',
   xlbz                 varchar(50) comment '限量标准,执行标准号(仪器导入用)',
   bzz                  varchar(20) comment '标准值(仪器导入用-标准值，限量值)',
   primary key (hjyjcmxbid)
);

alter table hjyjcmxb comment '检验检测明细表';


################
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017040515134962784218362', '/tmcsc/scfqHsh/shMainIndex', '商户管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'shMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041414023375728737361', '/jyjc/jyjcypIndex', '商品管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'spglIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041517422776597289190', '/pub/pub/pjiBieCanShuIndex?aaa100=PJCS', '评价参数设置', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'pjiBieCanShuIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041815162652022024970', '/tmsyjhtgl/jinhuoIndex', '进货管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'jinhuoIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041817390364575796424', '/khgx/khgxMainIndex?jgztkhgx=1', '范围外供应商', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'khgxMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041916571293079333091', '/khgx/khgxMainIndex?jgztkhgx=2', '范围外生产商', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'khgxMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041916583910846359731', '/khgx/khgxMainIndex?jgztkhgx=3', '范围外经销商', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'khgxMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017042611105573937630105', '/tmsyjhtgl/xiaohuoIndex', '销货管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'xiaohuoIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
