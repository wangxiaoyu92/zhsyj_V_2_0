INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2017031316485311846521738','/exam/user/userExamIndex','用户考试','2017020815164120256001955',1,'1',NULL,NULL,NULL,NULL,NULL,'1','userExamIndex',NULL,NULL,NULL,NULL,NULL,NULL,'','')

-- 用户考试信息表,开始考试便插入一条数据
CREATE TABLE syjzhpt.ots_result_mate (
  result_mate_id varchar(32) NOT NULL COMMENT '用户考试信息ID',
  result_info_id varchar(32) NOT NULL COMMENT '考试结果信息ID(空=还没有考试结束)',
  exam_info_id varchar(32) NOT NULL COMMENT '关联的考试ID',
  user_id varchar(32) NOT NULL COMMENT '用户ID',
  exams_papers_id varchar(32) NOT NULL COMMENT '关联考试所使用的试卷`ots_exams_papers`.exams_papers_id',
  course_id varchar(32) NOT NULL COMMENT '关联课程ID,表示课程中的考试,`course_id`<>""表示计划课程中的考试',
  plan_id varchar(32) NOT NULL COMMENT '关联计划ID,表示计划中考试,`plan_id`<>""表示计划课程中的考试',
  show_time datetime NOT NULL COMMENT '进入考试时间',
  times int(10) UNSIGNED NOT NULL COMMENT '当前考试次数,0=表示培训考试,`courseId`和`planId`同时为""则是预先申请数据',
  ip_address char(128) NOT NULL COMMENT 'IP地址',
  judge varchar(32) NOT NULL COMMENT '评分人ID(空=未评卷)',
  PRIMARY KEY (result_mate_id),
  INDEX FK_Reference_10 (exams_papers_id),
  INDEX FK_Reference_8 (result_info_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '用户考试信息表,开始考试便插入一条数据';

-- 考试缓存试卷表
CREATE TABLE syjzhpt.ots_exams_papers (
  exams_papers_id varchar(32) NOT NULL COMMENT '数据ID',
  exams_info_id varchar(32) NOT NULL COMMENT '关联考试信息ID',
  paper_info_id varchar(32) NOT NULL COMMENT '所使用的试卷ID',
  points float NOT NULL COMMENT '试卷总分',
  data mediumtext NOT NULL COMMENT '缓存的试卷数据',
  modified date NOT NULL COMMENT '修改时间',
  PRIMARY KEY (exams_papers_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '考试缓存试卷表';


