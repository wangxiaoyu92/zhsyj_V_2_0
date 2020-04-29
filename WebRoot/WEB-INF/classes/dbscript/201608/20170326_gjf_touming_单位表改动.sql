#########################################
ALTER TABLE pcompany
  CHANGE COLUMN comjianjie comjianjie TEXT DEFAULT NULL COMMENT '企业简介',
  ADD COLUMN comcssbm VARCHAR(30) DEFAULT NULL COMMENT '厂商识别码' AFTER orgid,
  ADD COLUMN comtsdh VARCHAR(20) DEFAULT NULL COMMENT '企业投诉电话' AFTER comcssbm,
  ADD COLUMN comscdz VARCHAR(200) DEFAULT NULL COMMENT '企业生产地址' AFTER comtsdh,
  ADD COLUMN comzmfx VARCHAR(10) DEFAULT NULL COMMENT '企业正门方向' AFTER comscdz,
  ADD COLUMN comqyndgdzcxz DECIMAL(12, 2) DEFAULT NULL COMMENT '前一年度固定资产（现值' AFTER comzmfx,
  ADD COLUMN comqyndldzj DECIMAL(12, 2) DEFAULT NULL COMMENT '前一年度流动资金' AFTER comqyndgdzcxz,
  ADD COLUMN comqyndzcz DECIMAL(12, 2) DEFAULT NULL COMMENT '前一年度总产值' AFTER comqyndldzj,
  ADD COLUMN comqyndnxse DECIMAL(12, 2) DEFAULT NULL COMMENT '前一年度年销售额' AFTER comqyndzcz,
  ADD COLUMN comqyndyjse DECIMAL(12, 2) DEFAULT NULL COMMENT '前一年度缴税金额' AFTER comqyndnxse,
  ADD COLUMN comqyndnlr DECIMAL(12, 2) DEFAULT NULL COMMENT '前一年度年利润' AFTER comqyndyjse,
  ADD COLUMN comsftghaccp VARCHAR(10) DEFAULT NULL COMMENT '是否通过HACCP认证0否1是' AFTER comqyndnlr,
  ADD COLUMN comhaccpbh VARCHAR(50) DEFAULT NULL COMMENT 'HACCP认证证书编号' AFTER comsftghaccp,
  ADD COLUMN comhaccpfzdw VARCHAR(200) DEFAULT NULL COMMENT 'HACCP发证单位名' AFTER comhaccpbh,
  ADD COLUMN comiso9000bh VARCHAR(50) DEFAULT NULL COMMENT 'ISO9000证书编号' AFTER comhaccpfzdw,
  ADD COLUMN comiso9000fzdw VARCHAR(200) DEFAULT NULL COMMENT 'ISO9000发证单位名' AFTER comiso9000bh,
  ADD COLUMN comzdmj DECIMAL(10, 2) DEFAULT NULL COMMENT '占地面积' AFTER comiso9000fzdw,
  ADD COLUMN comjzmj DECIMAL(10, 2) DEFAULT NULL COMMENT '建筑面积' AFTER comzdmj,
  ADD COLUMN comyysj VARCHAR(50) DEFAULT NULL COMMENT '营业时间' AFTER comjzmj,
  ADD COLUMN comfxdj VARCHAR(10) DEFAULT NULL COMMENT '企业风险等级aaa100=comfxdj' AFTER comyysj ,
  ADD COLUMN commcjc VARCHAR(50) DEFAULT NULL COMMENT '企业名称简称' AFTER comfxdj;



################################################
ALTER TABLE pcomry
  ADD COLUMN rysflb VARCHAR(10) DEFAULT NULL COMMENT '人员身份类别aaa100=RYSFLB' ;
ALTER TABLE pcomry
  CHANGE COLUMN ryjszc ryjszc VARCHAR(10) BINARY CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '技术职称aaa100=ryjszc',
  CHANGE COLUMN ryzwgw ryzwgw VARCHAR(10) BINARY CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '职务岗位aaa100=ryzwgw';


ALTER TABLE pcomry
  ADD COLUMN ryjg VARCHAR(100) DEFAULT NULL COMMENT '籍贯' AFTER comid,
  ADD COLUMN ryzt VARCHAR(10) DEFAULT NULL COMMENT '人员状态1在职2离职' AFTER ryjg,
  ADD COLUMN rytxdz VARCHAR(100) DEFAULT NULL COMMENT '通讯地址' AFTER ryzt,
  ADD COLUMN ryqq VARCHAR(20) DEFAULT NULL COMMENT '人员qq' AFTER rytxdz,
  ADD COLUMN ryemail VARCHAR(100) DEFAULT NULL COMMENT '人员email' AFTER ryqq,
  ADD COLUMN ryzhize VARCHAR(100) DEFAULT NULL COMMENT '人员职责' AFTER ryemail;

  
  ALTER TABLE pcompany
  CHANGE COLUMN comdalei comdalei VARCHAR(500) DEFAULT NULL COMMENT '企业分类,代码表comdalei如食品生产，食品经营，药品生产，药品经营',
  CHANGE COLUMN comxiaolei comxiaolei VARCHAR(500) DEFAULT NULL COMMENT '企业小类，代码表comxiaolei如特大型餐馆',
  ADD COLUMN comdaleiname VARCHAR(1000) DEFAULT NULL COMMENT '企业大类汉字描述' AFTER commcjc,
  ADD COLUMN comxiaoleiname VARCHAR(1000) DEFAULT NULL COMMENT '企业小类汉字描述' AFTER comdaleiname;
###更改
UPDATE pcompany p set comdalei=fun_getcomdalei('0',p.comid);
UPDATE pcompany p set comdaleiname=fun_getcomdalei('1',p.comid);


ALTER TABLE hyzcp
  ADD COLUMN comid VARCHAR(32) DEFAULT NULL COMMENT 'comid' AFTER aae036;
ALTER TABLE hsply
  ADD COLUMN comid VARCHAR(32) DEFAULT NULL COMMENT '企业id' AFTER aae036;

##################################################################################
DROP FUNCTION fun_comdalei2syqylx;

CREATE DEFINER = 'root'@'localhost'
FUNCTION fun_comdalei2syqylx(prm_comdalei varchar(200))
  RETURNS varchar(40) CHARSET utf8
BEGIN
  #溯源企业类型0非溯源企业1生成2流通3餐饮aaa100=COMSYQYLX
  DECLARE v_comsyqylx varchar(100);

  IF ISNULL(prm_comdalei) THEN
    SET v_comsyqylx = '';
  ELSE
    SELECT
      aaa105 INTO v_comsyqylx
    FROM aa10
    WHERE aaa100 = 'COMDALEI'
    AND AAA102 = prm_comdalei;
  END IF;


  RETURN v_comsyqylx;
END

###################################
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


    
    CREATE VIEW viewcomdalei AS
      SELECT a.* FROM aa10 a
        WHERE a.AAA100='COMDALEI';

    CREATE VIEW viewcomxiaolei AS
      SELECT a.* FROM aa10 a
        WHERE a.aaa100='COMXIAOLEI';  


  DROP VIEW viewcomfenlei;
  
  CREATE VIEW viewcomfenlei AS
      SELECT a.*,
        (case when a.aaa100='COMDALEI' then '1' when a.aaa100='COMXIAOLEI' then '2' else '0' end) AS treejibie FROM aa10 a
        WHERE a.aaa100='COMXIAOLEI' OR a.aaa100='COMDALEI'
        ORDER BY a.aaa102;  
          
  