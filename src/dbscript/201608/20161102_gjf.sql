Update zxpdjg a set a.comdm =(SELECT t.comid FROM pcompany t WHERE t.comdm=a.comdm);

ALTER TABLE zxpdjg
CHANGE COLUMN comdm comid varchar(32) DEFAULT NULL COMMENT '企业id';

ALTER TABLE zxpdjg
ADD PRIMARY KEY (pdjgid);


ALTER TABLE aa10
  CHANGE COLUMN AAA103 AAA103 VARCHAR(200) DEFAULT NULL COMMENT '代码名称';

---------------------
CREATE DEFINER = 'root'@'localhost'
PROCEDURE PRC_INSERTCODE(IN  AAA100_代码类别       VARCHAR(20),
                                           IN AAA101_代码类别名称   VARCHAR(50),
                                           IN AAA104_代码可维护标志 VARCHAR(20),
                                            IN AAA102_代码值        VARCHAR(20),
                                            IN AAA103_代码名称      VARCHAR(300),
                                            IN AAE030_开始年月      int,
                                           IN AAE031_终止年月       int,
                                           OUT P_CODE       int,
                                           OUT P_MSG       VARCHAR(20)
                                           )
BEGIN
 declare  N_AAZ094  varchar(32) default null;
 declare  N_AAZ093  VARCHAR(32) default null;
 
start transaction; 
 
  SELECT MAX(AAZ094)
    INTO N_AAZ094
    FROM AA09
   WHERE upper(AAA100) = upper(AAA100_代码类别);
  IF N_AAZ094 IS NULL THEN
    #SELECT nextval('SQ_AAZ094') INTO N_AAZ094;
    SELECT f_getSequenceStr() INTO N_AAZ094;
    INSERT INTO AA09
      (AAA100, AAA101, AAA104, AAZ094)
    VALUES
      (upper(AAA100_代码类别),
       AAA101_代码类别名称,
       AAA104_代码可维护标志,
       N_AAZ094);
  END IF;
  SELECT MAX(AAZ093)
    INTO N_AAZ093
    FROM AA10
   WHERE upper(AAA100) = upper(AAA100_代码类别)
     AND AAA102 = AAA102_代码值;
  IF N_AAZ093 IS NULL THEN
    #SELECT nextval('SQ_AAZ093') INTO N_AAZ093;
    SELECT f_getSequenceStr() INTO N_AAZ093;
    INSERT INTO AA10
      (AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094)
    VALUES
    (upper(AAA100_代码类别),
             AAA102_代码值,
             AAA103_代码名称,
             AAE030_开始年月,
             AAE031_终止年月,
             N_AAZ093,
             N_AAZ094);
  END IF;
  
  -- 运行没有异常，提交事务 
  commit;
   
  -- 设置返回值为1 
  set P_CODE = 1;
  set P_MSG = '执行成功!'; 
  SELECT P_CODE;
  SELECT P_MSG; 
END



call PRC_INSERTCODE('COMDRTXSM','单位导入填写说明','1','1','企业大类，填写代码值，多个大类用逗号分隔；如既是食品生产企业，又是食品批发企业填写1,6','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('COMDRTXSM','单位导入填写说明','1','2','日期格式yyyy-mm-dd，如企业成立日期填写类似2012-3-8','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('COMDRTXSM','单位导入填写说明','1','3','资质证明类型填写代码值，如食品生产许可证填3','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('COMDRTXSM','单位导入填写说明','1','4','统筹区编码填写代码值','199405',null,@P_CODE,@P_MSG);


