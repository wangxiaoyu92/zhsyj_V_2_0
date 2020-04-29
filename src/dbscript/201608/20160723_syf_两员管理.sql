/**
功能描述：
  该文件为升级两员管理相关所用到的语句
文件说明：
  1.创建两员信息表
  2.创建两员照片表
  3.初始化基本参数
  4.获取序列编号函数
  */
/**1.创建两员信息表*/
-- 两员表
CREATE TABLE syjzhpt.ly (
  lyid varchar(32) NOT NULL COMMENT '两员ID',
  lybh varchar(50) NOT NULL COMMENT '两员编号',
  lyxm varchar(50) NOT NULL COMMENT '两员姓名',
  lypym varchar(30) DEFAULT NULL COMMENT '两员姓名拼音码',
  lyxb varchar(10) DEFAULT NULL COMMENT '两员性别',
  lylyrq varchar(10) DEFAULT NULL COMMENT '两员出生日期',
  lysfzjlx varchar(30) DEFAULT NULL COMMENT '两员身份证件类型',
  lysfzjhm varchar(30) NOT NULL COMMENT '两员身份证号',
  lysjh varchar(30) DEFAULT NULL COMMENT '两员手机号',
  lywhcd varchar(30) DEFAULT NULL COMMENT '两员文化程度',
  lycynx varchar(30) DEFAULT NULL COMMENT '两员从业年限',
  lyjkzm varchar(30) DEFAULT NULL COMMENT '两员健康证明',
  lyjkzyxq date DEFAULT NULL COMMENT '两员健康证有效期',
  lyjktjdd varchar(100) DEFAULT NULL COMMENT '两员健康体检地点',
  lypxqk varchar(30) DEFAULT NULL COMMENT '两员培训情况',
  lypxhgzyxq date DEFAULT NULL COMMENT '两员培训合格证有效期',
  lyjtzz varchar(100) DEFAULT NULL COMMENT '两员家庭住址',
  lyhkszd varchar(100) DEFAULT NULL COMMENT '两员户口所在地',
  lyyx varchar(30) DEFAULT NULL COMMENT '两员邮箱',
  lyqq varchar(30) DEFAULT NULL COMMENT '两员QQ',
  lywx varchar(30) DEFAULT NULL COMMENT '两员微信',
  lysflx varchar(30) DEFAULT NULL COMMENT '两员身份类型',
  lyfwdbh varchar(50) DEFAULT NULL COMMENT '两员服务队编号',
  lyfwqy varchar(100) DEFAULT NULL COMMENT '两员服务区域',
  comshengdm varchar(20) DEFAULT NULL COMMENT '省份代码',
  comshengmc varchar(20) DEFAULT NULL COMMENT '省份名称',
  comshidm varchar(20) DEFAULT NULL COMMENT '市代码',
  comshimc varchar(20) DEFAULT NULL COMMENT '市名称',
  comxiandm varchar(20) DEFAULT NULL COMMENT '县代码',
  comxianmc varchar(20) DEFAULT NULL COMMENT '县名称',
  comxiangdm varchar(20) DEFAULT NULL COMMENT '街道办/乡镇代码',
  comxiangmc varchar(20) DEFAULT NULL COMMENT '街道办/乡镇名称',
  comcundm varchar(20) DEFAULT NULL COMMENT '社区/行政村代码',
  comcunmc varchar(20) DEFAULT NULL COMMENT '社区/行政村名称',
  aab301 varchar(100) DEFAULT NULL COMMENT '行政区划',
  aaa027 varchar(20) DEFAULT NULL COMMENT '统筹区编码',
  orgid varchar(32) DEFAULT NULL COMMENT '所属机构ID',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办日期',
  aae013 varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (lyid),
  INDEX idx_ly_lybh (lybh),
  UNIQUE INDEX pk_ly (lyid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '两员信息表';
/**2.创建两员照片表*/
-- 两员照片表
CREATE TABLE syjzhpt.lyzp (
  lyzpid varchar(32) NOT NULL COMMENT '两员照片ID',
  lyid varchar(32) NOT NULL COMMENT '两员ID',
  lyzp longblob DEFAULT NULL COMMENT '两员照片',
  PRIMARY KEY (lyzpid),
  INDEX idx_lyzp_lyid (lyid),
  UNIQUE INDEX pk_lyzp (lyzpid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '两员照片表';

/**3.初始化基本参数*/
  -- 初始化AA09
insert into `aa09` (`AAA100`, `AAA101`, `AAA104`, `AAZ094`) values('ZZMM','政治面貌','1','703');
insert into `aa09` (`AAA100`, `AAA101`, `AAA104`, `AAZ094`) values('LYLX','两员类型','1','704');
  -- 初始化AA10
insert into `aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`) values('ZZMM','1','党员','199405',NULL,'201607282154480000001','703',NULL,NULL,NULL);
insert into `aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`) values('ZZMM','0','群众','199405',NULL,'2016072821554600000002','703',NULL,NULL,NULL);
insert into `aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`) values('LYLX','1','协管员','199405',NULL,'2016072821554600000003','704',NULL,NULL,NULL);
insert into `aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`) values('LYLX','0','信息员','199405',NULL,'2016072821554600000004','704',NULL,NULL,NULL);
/**4.获取序列编号函数*/
CREATE DEFINER = 'root'@'localhost'
FUNCTION syjzhpt.f_getZfryzfly(prm_zfryid varchar(50),prm_kind varchar(10))
  RETURNS varchar(1000) CHARSET utf8
BEGIN
  DECLARE done INT DEFAULT 0;     
    declare v_zfrylybm VARCHAR(500) DEFAULT ''; -- 14位时间串
    DECLARE v_zfrylymc  VARCHAR(1000) DEFAULT ''; -- 系统循环序列号
  DECLARE v_ret  VARCHAR(1000) DEFAULT ''; -- 系统循环序列号

    declare v_aaa102 VARCHAR(50); -- 14位时间串
    DECLARE v_aaa103  VARCHAR(50); -- 系统循环序列号

  declare cur_a cursor for  
  SELECT b.AAA102,b.AAA103
  from pzfryzfly a,(SELECT aaa102,aaa103 FROM aa10 a WHERE a.AAA100='ZFRYLYBM') b
  where a.zfrylybm=b.aaa102
    AND a.zfryid=prm_zfryid;

  declare continue handler for not found set done=1;
  declare exit handler for sqlexception   #not found,sqlwarning,

  SET done=-1;
  open cur_a;
  mytableloop:loop
  fetch cur_a
  into 
    v_aaa102,
    v_aaa103;

    if done=1 then
      leave mytableloop;
    end if; 
   
    IF v_zfrylybm='' then
        set v_zfrylybm=v_aaa102;
        SET v_zfrylymc=v_aaa103;
      ELSE 
        set v_zfrylybm=CONCAT(v_zfrylybm,',',v_aaa102);
        set v_zfrylymc=CONCAT(v_zfrylymc,',',v_aaa103);
      end IF;
                                     
  end loop mytableloop;
  close cur_a;

     IF prm_kind='1' THEN
      SET v_ret=v_zfrylybm;
     ELSE
       SET v_ret=v_zfrylymc;
     end IF; 
   

    RETURN v_ret;

  END

