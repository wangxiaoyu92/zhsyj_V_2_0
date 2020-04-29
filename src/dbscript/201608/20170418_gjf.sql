INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, 
  FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, 
  TARGET, SYSTEMCODE) VALUES
('2017033116545732075345187', '/tmcsc/scfqHsh/scfqMainIndex', '市场分区', '2017032214445093628409569', 1, 
  '1', NULL, NULL, NULL, NULL, NULL, '1', 'scfqMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, 
  FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017040515134962784218362', '/tmcsc/scfqHsh/shMainIndex', '商户管理', '2017032214445093628409569', 1, 
  '1', NULL, NULL, NULL, NULL, NULL, '1', 'shMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', 'tmsyjxt');


INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('COMDALEI', '101401', '菜市场', 199405, NULL, '2017030917355914194400249', '1400', '100', 'SPSC', '1');
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('COMXIAOLEI', '10140101', '批发市场', 199405, NULL, '2017030909105117458991536', '1406', '101401', NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('COMXIAOLEI', '10140102', '零售市场', 199405, NULL, '2017030909105159716166332', '1406', '101401', NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('COMXIAOLEI', '10140103', '超市', 199405, NULL, '2017030909105146203860124', '1406', '101401', NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('COMXIAOLEI', '10140104', '网货中心', 199405, NULL, '2017030909105151870804700', '1406', '101401', NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('COMXIAOLEI', '10140105', '冷链仓储', 199405, NULL, '2017030909105120742446203', '1406', '101401', NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('COMXIAOLEI', '10140106', '产地直供', 199405, NULL, '2017030909105148099819988', '1406', '101401', NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105) VALUES
('COMXIAOLEI', '10140107', '农产品平价店', 199405, NULL, '2017030909105178271764403', '1406', '101401', NULL, NULL);


insert INTO aa01(aaa001,aaa002,aaa005,aaa104,aaa105,aaz499,aaa027)
VALUES('ADDCOMCREATEUSER','添加企业时是否生成用户信息0不生成1生成','0','1','0不生成1生成',f_getSequenceStr(),null);
#################################################
drop table if exists pcomrcjdglry;

/*==============================================================*/
/* Table: pcomrcjdglry                                          */
/*==============================================================*/
create table pcomrcjdglry
(
   pcomrcjdglryid       varchar(32) not null comment '日常监督管理人员id',
   comid                varchar(32) comment '企业id',
   userid               varchar(32) comment '用户id',
   aae011               varchar(32) comment '操作员',
   aae036               datetime comment '操作时间',
   primary key (pcomrcjdglryid)
);

alter table pcomrcjdglry comment '日常监督管理人员';

###################
CREATE DEFINER = 'root'@'localhost'
PROCEDURE prc_处理日常监督管理人员(
  out prm_AppCode  int,
  out prm_ErrorMsg VARCHAR(500)
)
begin
label_pro:begin
  DECLARE done INT DEFAULT 0;     

 DECLARE v_comid VARCHAR(50);
 DECLARE v_comrcjdglry VARCHAR(50);
 DECLARE v_onename VARCHAR(50);
 DECLARE v_userid VARCHAR(50);
 DECLARE v_pcomrcjdglryid VARCHAR(50);
 DECLARE v_k int;

 declare cur_table cursor for  
 SELECT a.comid,a.comrcjdglry
  FROM pcompany a
  WHERE comrcjdglry IS NOT NULL;
  # AND comid='2016062816095110529624680';
     
                           
  declare continue handler for not found set done=1;
  declare exit handler for sqlexception   #not found,sqlwarning,
  begin
    SELECT 'ERROR';
    set prm_AppCode=-1;
    set prm_ErrorMsg='过程出错了';
    rollback;
    #leave label_pro;
  end;
  set @@autocommit= 0;
  set prm_AppCode=0;
  set prm_ErrorMsg='成功';
              

  SET done=-1;
  open cur_table;
  mytableloop:loop
  fetch cur_table
  into 
    v_comid,
    v_comrcjdglry;

    if done=1 then
      leave mytableloop;
    end if; 
    
    set v_k=1;
    WHILE v_k<=2 DO 
      
      IF v_k=1 then
        select SUBSTRING_INDEX(v_comrcjdglry,',',1) INTO v_onename FROM dual; 
      else
        select SUBSTRING_INDEX(v_comrcjdglry,',',-1) INTO v_onename FROM dual; 
      end IF;

      SELECT userid INTO v_userid FROM sysuser WHERE DESCRIPTION=v_onename;

      IF (NOT ISNULL(v_userid)) THEN
          SELECT f_getSequenceStr() INTO v_pcomrcjdglryid FROM dual;
              DELETE FROM pcomrcjdglry WHERE comid=v_comid AND userid=v_userid;
              INSERT INTO pcomrcjdglry (
                  comid,
                  userid,
                  aae011,
                  pcomrcjdglryid,
                  aae036
                )VALUES(
                  v_comid,
                  v_userid,
                  'sys',
                  v_pcomrcjdglryid,
                  NOW()
                );
          end IF;
      set v_k=v_k+1;
    END WHILE;
                       
  end loop mytableloop;
  close cur_table;

  COMMIT;
       
end;
end
##########################
CALL prc_处理日常监督管理人员(@A,@B);

ALTER TABLE pcompany
  DROP COLUMN comrcjdglry;
##############

call PRC_INSERTCODE('FJTYPE','附件类型','1','8','商品图片','199405',null,@P_CODE,@P_MSG);


ALTER TABLE jyjcyp
  CHANGE COLUMN jcypmc jcypmc VARCHAR(100) DEFAULT NULL COMMENT '商品名称';

ALTER TABLE jyjcyp
  ADD UNIQUE INDEX UK_jyjcyp_jcypmc (jcypmc);


INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041414023375728737361', '/jyjc/jyjcypIndex', '商品管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'spglIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');







#############################################
drop table if exists pgzpjmx;

/*==============================================================*/
/* Table: pgzpjmx                                               */
/*==============================================================*/
create table pgzpjmx
(
   pgzpjmxid            varchar(32) not null comment '公众评价明细表',
   pgzpjid              varchar(32) not null comment '公众评价表id',
   pjcs                 varchar(32) not null comment 'aa10表aaa100=pjcs',
   pjxj                 varchar(10) comment '评价星级aaa100=pjxj',
   primary key (pgzpjmxid)
);


alter table pgzpjmx comment '公众评价明细表';
alter table pgzpjmx add index idx_pgzpjmx_pgzpjid(pgzpjid);
 
##########################################
drop table if exists pjcs;

################################################
ALTER TABLE aa10
  ADD COLUMN aaa106 VARCHAR(50) DEFAULT NULL COMMENT '代码名称简称' AFTER AAA105,
  ADD COLUMN aaa107 VARCHAR(255) DEFAULT NULL COMMENT '参数代码级别' AFTER aaa106,
  ADD COLUMN aae011 VARCHAR(32) DEFAULT NULL COMMENT '操作员' AFTER aaa107,
  ADD COLUMN aae036 DATETIME DEFAULT NULL COMMENT '操作时间' AFTER aae011;

INSERT INTO aa09(aaa100,aaa101,aaa104,aaz094)VALUES('PJCS','评价参数','1','2017041717561792289801027');

INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429215', 'PJCS', '评价参数', '1', '评价参数列表', 'PJCSlb', '0', '1', 1, 'sys', '2017-04-15 17:54:46');


INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429216', 'PJCS', '评价参数', '10001', '食品安全', 'spaq', '1', '1', 2, 'sys', '2017-04-15 17:55:58');
INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429217', 'PJCS', '评价参数', '10001001', '场所卫生', 'csws', '10001', '1', 3, 'sys', '2017-04-15 17:57:09');
INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429218', 'PJCS', '评价参数', '10001002', '人员卫生', 'ryws', '10001', '1', 3, 'sys', '2017-04-15 17:58:03');
INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429219', 'PJCS', '评价参数', '10001003', '菜品卫生', 'cpws', '10001', '1', 3, 'sys', '2017-04-15 17:58:52');
INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429220', 'PJCS', '评价参数', '10002', '服务评价', 'fwpj', '1', '1', 2, 'sys', '2017-04-15 17:59:53');
INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429221', 'PJCS', '评价参数', '10002001', '口味服务', 'kwfw', '10002', '1', 3, 'sys', '2017-04-15 18:00:49');
INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429222', 'PJCS', '评价参数', '10002002', '服务态度', 'fwtd', '10002', '1', 3, 'sys', '2017-04-15 18:01:41');
INSERT INTO aa10(aaz094,aaz093, aaa100, aaa101, aaa102, aaa103, aaa106, aaa104, aaa105, aaa107, aae011, aae036) VALUES
('2017041717561792289801027','2017041517495719086429223', 'PJCS', '评价参数', '10002003', '价格服务', 'jgfw', '10002', '1', 3, 'sys', '2017-04-15 18:02:25');

INSERT INTO `aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) 
VALUES ('PJCS', '10003', '信息公示', NULL, NULL, '2017042016160528681199279', '2017041717561792289801027', '1', '评价参数', '1', 'xxgs', '2', 'sys', '2017-04-15 17:55:58');
INSERT INTO `aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) 
VALUES ('PJCS', '10004', '整体满意度', NULL, NULL, '2017042016160583504724766', '2017041717561792289801027', '1', '评价参数', '1', 'ztmyd', '2', 'sys', '2017-04-15 17:55:58');


INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, 
ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041517422776597289190', '/pub/pub/pjiBieCanShuIndex?aaa100=PJCS', '评价参数设置', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'pjiBieCanShuIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
























