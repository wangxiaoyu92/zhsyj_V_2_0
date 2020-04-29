call PRC_INSERTCODE('LHFJDTPDDJ','量化分级动态评定等级','1','A','优秀','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJDTPDDJ','量化分级动态评定等级','1','B','良好','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJDTPDDJ','量化分级动态评定等级','1','C','一般','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJDTPDDJ','量化分级动态评定等级','1','0','整改中','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJDTPDDJ','量化分级动态评定等级','1','9','未知','199405',null,@P_CODE,@P_MSG);


call PRC_INSERTCODE('LHFJNDPDDJ','量化分级年度评定等级','1','A','优秀','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJNDPDDJ','量化分级年度评定等级','1','B','良好','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJNDPDDJ','量化分级年度评定等级','1','C','一般','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJNDPDDJ','量化分级年度评定等级','1','0','整改中','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJNDPDDJ','量化分级年度评定等级','1','9','未知','199405',null,@P_CODE,@P_MSG);

call PRC_INSERTCODE('LHFJPDLX','量化分级评定类型','1','0','动态评定','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('LHFJPDLX','量化分级评定类型','1','1','年度评定','199405',null,@P_CODE,@P_MSG);



ALTER TABLE bscheckmaster
  ADD COLUMN checkavgscore decimal(8,2) DEFAULT 0 COMMENT '检查平均分',
  ADD COLUMN lhfjdtpddj VARCHAR(10) DEFAULT NULL COMMENT '量化分级动态评定等级A优秀B良好C一般' AFTER checkavgscore;
  ADD COLUMN checkyear VARCHAR(4) DEFAULT NULL COMMENT '检查年度' AFTER lhfjdtpddj;

UPDATE bscheckmaster SET checkyear=DATE_FORMAT(operatedate,'%Y');



create table bschecklhfjpjcs
(
   bschecklhfjpjcsid    varchar(32) not null comment '量化分级评级参数表ID',
   lhfjpdlx             char(10) comment '量化分级评定类型0动态评定1年度评定',
   lhfjpddj             varchar(10) comment '量化分级评定等级',
   lhfjpdqsf            decimal(8,2) comment '量化分级评定起始分',
   lhfjpdjsf            decimal(8,2) comment '量化分级评定结束分',
   lhfjpdksrq           datetime comment '量化分级评定开始日期',
   lhfjpdjsrq           datetime comment '量化分级评定结束日期',
   aae011               varchar(30) comment '操作员',
   aae036               datetime comment '操作时间',
   aae013               varchar(100) comment '备注',
   lhfjpdndyjccs       smallint comment '量化分级评定年度应检查次数',
   primary key (bschecklhfjpjcsid)
);

alter table bschecklhfjpjcs comment '量化分级评级参数表';


INSERT INTO bschecklhfjpjcs(bschecklhfjpjcsid, lhfjpdlx, lhfjpddj, lhfjpdqsf, lhfjpdjsf, lhfjpdksrq, lhfjpdjsrq, aae011, aae036, aae013, lhfjpdndyjccs) VALUES
('2017022009550272133720919', '0', '0', 0.00, 5.90, '2009-02-01 10:17:03', '2099-02-20 10:17:23', 'sys', '2017-02-20 10:17:40', NULL, 4);
INSERT INTO bschecklhfjpjcs(bschecklhfjpjcsid, lhfjpdlx, lhfjpddj, lhfjpdqsf, lhfjpdjsf, lhfjpdksrq, lhfjpdjsrq, aae011, aae036, aae013, lhfjpdndyjccs) VALUES
('2017022009550272133720920', '0', 'C', 6.00, 7.40, '2009-02-01 10:17:03', '2099-02-20 10:17:23', 'sys', '2017-02-20 10:19:24', NULL, 3);
INSERT INTO bschecklhfjpjcs(bschecklhfjpjcsid, lhfjpdlx, lhfjpddj, lhfjpdqsf, lhfjpdjsf, lhfjpdksrq, lhfjpdjsrq, aae011, aae036, aae013, lhfjpdndyjccs) VALUES
('2017022009550272133720921', '0', 'B', 7.50, 8.90, '2009-02-01 10:17:03', '2099-02-20 10:17:23', 'sys', '2017-02-20 10:21:24', NULL, 2);
INSERT INTO bschecklhfjpjcs(bschecklhfjpjcsid, lhfjpdlx, lhfjpddj, lhfjpdqsf, lhfjpdjsf, lhfjpdksrq, lhfjpdjsrq, aae011, aae036, aae013, lhfjpdndyjccs) VALUES
('2017022009550272133720922', '0', 'A', 9.00, 100.00, '2009-02-01 10:17:03', '2099-02-20 10:17:23', 'sys', '2017-02-20 10:21:24', NULL, 1);
INSERT INTO bschecklhfjpjcs(bschecklhfjpjcsid, lhfjpdlx, lhfjpddj, lhfjpdqsf, lhfjpdjsf, lhfjpdksrq, lhfjpdjsrq, aae011, aae036, aae013, lhfjpdndyjccs) VALUES
('2017022009550272133720923', '1', '0', 0.00, 5.90, '2009-02-01 10:17:03', '2099-02-20 10:17:23', 'sys', '2017-02-20 10:38:53', NULL, 4);
INSERT INTO bschecklhfjpjcs(bschecklhfjpjcsid, lhfjpdlx, lhfjpddj, lhfjpdqsf, lhfjpdjsf, lhfjpdksrq, lhfjpdjsrq, aae011, aae036, aae013, lhfjpdndyjccs) VALUES
('2017022009550272133720924', '1', 'C', 6.00, 7.40, '2009-02-01 10:17:03', '2099-02-20 10:17:23', 'sys', '2017-02-20 10:38:53', NULL, 3);
INSERT INTO bschecklhfjpjcs(bschecklhfjpjcsid, lhfjpdlx, lhfjpddj, lhfjpdqsf, lhfjpdjsf, lhfjpdksrq, lhfjpdjsrq, aae011, aae036, aae013, lhfjpdndyjccs) VALUES
('2017022009550272133720925', '1', 'B', 7.50, 8.90, '2009-02-01 10:17:03', '2099-02-20 10:17:23', 'sys', '2017-02-20 10:41:50', NULL, 2);
INSERT INTO bschecklhfjpjcs(bschecklhfjpjcsid, lhfjpdlx, lhfjpddj, lhfjpdqsf, lhfjpdjsf, lhfjpdksrq, lhfjpdjsrq, aae011, aae036, aae013, lhfjpdndyjccs) VALUES
('2017022009550272133720926', '1', 'A', 9.00, 100.00, '2009-02-01 10:17:03', '2099-02-20 10:17:23', 'sys', '2017-02-20 10:43:16', NULL, 1);



########################################################################
CREATE DEFINER = 'root'@'%'
FUNCTION f_getLhfjdj(prm_resultid varchar(32),prm_lhfjpdlx varchar(10),prm_checkavgscore decimal(8,2),prm_checkdate datetime)
  RETURNS varchar(10) CHARSET utf8
BEGIN
  declare v_lhfjpddj varchar(10);#量化分级评定等级
  declare v_gjxcount int;
  
  declare v_checkdate datetime;

  set v_gjxcount=0;
  set v_checkdate=now();

  if not isnull(prm_checkdate)then
     set v_checkdate=prm_checkdate;
  end if;

  
  #关键项不合格个数 大于2 不评定动态等级  
  if prm_lhfjpdlx='0' then 
    select count(a.contentid)
    into v_gjxcount
    from bscheckdetail a, omcheckcontent b 
    where a.contentid=b.contentid
      and a.resultid=prm_resultid
      and a.detaildecide='2'
      and b.contentimpt<>1;
  end if;

  if v_gjxcount>=2 then
    set v_lhfjpddj=0;
  else
    select ifnull(max(a.lhfjpddj),'0')
    into v_lhfjpddj
    from bschecklhfjpjcs a
    where a.lhfjpdlx=prm_lhfjpdlx
      and a.lhfjpdqsf<=prm_checkavgscore
      and a.lhfjpdjsf>=prm_checkavgscore
      and a.lhfjpdksrq<=v_checkdate
      and a.lhfjpdjsrq>=v_checkdate;
  end if;

  RETURN v_lhfjpddj;

END;



############################################
CREATE DEFINER = 'root'@'localhost'
FUNCTION getAa10_aaa102aaa103(p_aaa100 VARCHAR(20),p_aaa102 varchar(16),p_fgf varchar(10))
  RETURNS varchar(100) CHARSET utf8
BEGIN 
  #p_fjf分隔符
  DECLARE v_aaa103 VARCHAR(100);
  select concat(aaa102,p_fgf,aaa103) into v_aaa103 from aa10 where aaa100=p_aaa100 and aaa102 = p_aaa102;
  RETURN v_aaa103;    
END

#######################################
drop table if exists pcompanynddtpj;
create table pcompanynddtpj
(
   pcompanynddtpjid     varchar(32) not null comment '企业年度动态评级表ID',
   comid                varchar(32) comment '企业ID',
   pdyear               varchar(4) comment '评定年度',
   lhfjndpddj           varchar(10) comment '量化分级年度评定等级',
   aae011               varchar(30) comment '操作员',
   aae036               datetime comment '操作时间',
   aae013               varchar(100) comment '备注',
   pdjgscfs             varchar(10) comment '评定结果生产方式0自动1手动',
   primary key (pcompanynddtpjid)
);

alter table pcompanynddtpj comment '企业年度动态评级表';



call PRC_INSERTCODE('RESULTDECISION','日常检查结果判定','1','101','符合','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('RESULTDECISION','日常检查结果判定','1','102','不符合','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('RESULTDECISION','日常检查结果判定','1','103','限时整改','199405',null,@P_CODE,@P_MSG);

call PRC_INSERTCODE('RESULTSTATE','检查状态','1','0','新增未检查','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('RESULTSTATE','检查状态','1','1','未完成','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('RESULTSTATE','检查状态','1','2','检查明细已保存未提交','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('RESULTSTATE','检查状态','1','3','检查明细已保存已提交','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('RESULTSTATE','检查状态','1','4','检查意见已保存已提交','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('RESULTSTATE','检查状态','1','5','检查意见已保存未提交','199405',null,@P_CODE,@P_MSG);




CREATE DEFINER = 'root'@'localhost'
FUNCTION fun_getcomdalei(prm_kind int, prm_comid varchar(32))
  RETURNS varchar(40) CHARSET utf8
BEGIN
  #获取企业大类 prm_kind=0 获取代码 1获取名称
  declare v_comdalei VARCHAR(100); 
  declare v_comdaleistr VARCHAR(100);
  declare v_ret VARCHAR(100);

  SELECT GROUP_CONCAT(a.comdalei),GROUP_CONCAT(b.aaa103)
  INTO v_comdalei,v_comdaleistr
  FROM pcompanycomdalei a,
    (SELECT t.*  FROM aa10 t WHERE t.aaa100='COMDALEI') b 
  WHERE a.comdalei=b.aaa102
    AND a.comid=prm_comid
    ORDER BY a.comdalei;

  IF prm_kind='0' THEN
    set v_ret=v_comdalei;
  else
    set v_ret=v_comdaleistr;
  end IF;

  RETURN v_ret;

END






















