-- 考试管理菜单
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2017030815162072381798170','/exam/exam/examsManagerIndex','考试管理','2017020815164120256001955',1,'1',NULL,NULL,NULL,NULL,NULL,'1','examsManagerIndex',NULL,NULL,NULL,NULL,NULL,NULL,'',''); 
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2017030815185556326378390','/exam/exam/addExam','添加考试','2017030815162072381798170',1,'2',NULL,NULL,NULL,NULL,NULL,'1','addExam',NULL,NULL,NULL,NULL,NULL,NULL,'','');
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2017030815201565940122482','/exam/exam/editExamInfo','编辑考试信息','2017030815162072381798170',1,'2',NULL,NULL,NULL,NULL,NULL,'1','editExamInfo',NULL,NULL,NULL,NULL,NULL,NULL,'','');
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2017030815213874097314634','/exam/exam/delExamInfos','删除考试信息','2017030815162072381798170',1,'2',NULL,NULL,NULL,NULL,NULL,'1','delExamInfos',NULL,NULL,NULL,NULL,NULL,NULL,'','');
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2017031316372297548639854','/exam/exam/examUsersIndex','考试人员管理','2017030815162072381798170',1,'2',NULL,NULL,NULL,NULL,NULL,'1','examUsersIndex',NULL,NULL,NULL,NULL,NULL,NULL,'','') 

-- 考试信息表
CREATE TABLE syjzhpt.ots_exams_info (
  exams_info_id varchar(32) NOT NULL COMMENT '考试ID',
  exams_info_state tinyint(3) UNSIGNED NOT NULL COMMENT '考试状态,0=禁用,1=启用（可用）',
  exams_info_name char(255) NOT NULL COMMENT '考试名称',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (exams_info_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '考试信息表';

-- 考试数据表
CREATE TABLE syjzhpt.ots_exams_data (
  exams_data_id varchar(32) NOT NULL COMMENT '考试数据ID',
  exams_info_id varchar(32) NOT NULL COMMENT '关联考试信息ID',
  paper_info_id varchar(32) NOT NULL COMMENT '关联试卷ID',
  exams_data_sort int(10) UNSIGNED NOT NULL COMMENT '当前结构在整体的位置',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (exams_data_id),
  INDEX FK_Reference_5 (paper_info_id),
  INDEX FK_Reference_6 (exams_info_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '考试数据表';

-- 考试功能信息表
CREATE TABLE syjzhpt.ots_exams_mate (
  exams_info_id varchar(32) NOT NULL COMMENT '关联考试信息ID',
  exams_name varchar(255) NOT NULL COMMENT '考试名称',
  exams_type tinyint(4) NOT NULL COMMENT '考试类型,0=练习,1=考试',
  exams_notice text NOT NULL COMMENT '考试须知',
  exams_category varchar(32) NOT NULL COMMENT '考试分类(与基本信息表关联)',
  duration int(10) UNSIGNED NOT NULL COMMENT '考试限时，0等于不限时',
  startTime datetime NOT NULL COMMENT '开始时间',
  endTime datetime NOT NULL COMMENT '结束时间',
  examMode tinyint(4) NOT NULL COMMENT '考试方式,1=整卷,2=逐题',
  maxTimes int(10) UNSIGNED NOT NULL COMMENT '最大参考次数，默认=0不限次数',
  unityPoint int(11) NOT NULL COMMENT '统一总分,0=使用卷面总分',
  resultPublishTime datetime NOT NULL COMMENT '考试结果发布时间,"1970-01-01 00:00:00"为永不发布“1970-01-01 01:01:01”=交卷后立即发布',
  allowIp text NOT NULL COMMENT '限制学习IP段,''ip1-ip2,ip3-ip4''',
  unityDuration tinyint(4) NOT NULL COMMENT '统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时',
  isResultRank tinyint(4) NOT NULL COMMENT '是否显示排行榜,0=不显示,1=显示',
  isAntiCheat tinyint(4) NOT NULL COMMENT '是否防作弊,0=开卷考试,1=防作弊考试',
  isListShow tinyint(4) NOT NULL COMMENT '是否在考试列表中显示,0=不显示,1=显示',
  isQuestionsRandom tinyint(4) NOT NULL COMMENT '是否随机显示试题,0=正常显示,1=随机显示',
  isSurveillance tinyint(4) NOT NULL COMMENT '是否启用考试监控,0=不开起,1=启用',
  signUpStartTime datetime NOT NULL COMMENT '报名起始时间',
  signUpEndTime datetime NOT NULL COMMENT '报名结束时间,"1970-01-01 00:00:00"=考试无需报名,"1970-01-01 00:00:01"=以考试结束时间为报名截止时间',
  disableExam int(10) UNSIGNED NOT NULL COMMENT '禁止进入考场时间(m),0=不限制',
  disablesubmit int(10) UNSIGNED NOT NULL COMMENT '禁止提前交卷时间',
  cover_img varchar(200) NOT NULL COMMENT '考试封面',
  credit int(10) UNSIGNED NOT NULL COMMENT '考试所需金额',
  unPass tinyint(4) NOT NULL DEFAULT 0 COMMENT '及格后不能再考，0=不限制，1及格后不能再考',
  publishAnswerFlg tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否允许考生查看答案(1:是;0:否;)',
  examModePrev tinyint(4) NOT NULL DEFAULT 0 COMMENT '逐题模式，是否允许查看上一题0=不允许，1=允许',
  examManual tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否需要人工评卷',
  isDisableUserInfo tinyint(4) DEFAULT 0 COMMENT '评卷时是否屏蔽考生信息',
  examWay tinyint(4) NOT NULL DEFAULT 1 COMMENT '线上/线下',
  offlineScore float DEFAULT 0 COMMENT '线下总分',
  offlinePass float DEFAULT 0 COMMENT '线下及格分',
  examModeAnswer tinyint(4) NOT NULL DEFAULT 0 COMMENT '逐题查看答案（0-不允许，1-允许）',
  noAll tinyint(3) NOT NULL DEFAULT 0 COMMENT '禁止右键、剪切、复制、粘贴',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (exams_info_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '考试功能信息表';

-- 考试用户中间表
CREATE TABLE syjzhpt.ots_exam_user (
  exam_user_id varchar(32) NOT NULL COMMENT '考试用户ID',
  exams_info_id varchar(32) NOT NULL COMMENT '考试ID',
  user_id varchar(32) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (exam_user_id)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '考试用户中间表';







 