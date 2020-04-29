-- 菜单
INSERT INTO SYSFUNCTION(functionid,location,title,parent,orderno,type,description,log,owner,active,functioncode,visible,bizid,rolbizclass,imageurl,expandedimageurl,aaa102,cae005,rolbizable,target,systemcode) 
VALUES('2017032315065520650672649','/exam/result/resultManagerIndex','成绩管理','2017020815164120256001955',1,'1','NULL','NULL','NULL','NULL','NULL','1','resultManagerIndex','NULL','NULL','NULL','NULL','NULL','NULL','','');


-- 参加考试结果信息表
CREATE TABLE syjzhpt.ots_result_info (
  result_info_id varchar(32) NOT NULL COMMENT '考试结果ID',
  result_info_name char(255) NOT NULL COMMENT '考试名称',
  result_info_points float(9, 2) NOT NULL COMMENT '考试总分',
  result_info_scores float(9, 2) NOT NULL COMMENT '考试得分',
  result_info_pass float(9, 2) NOT NULL COMMENT '及格分数',
  exam_info_id varchar(32) NOT NULL COMMENT '参加考试的ID(这个考试可能被删除)',
  paper_info_id varchar(32) NOT NULL COMMENT '考试使用的试卷ID(这个试卷可能被删除)',
  paperData mediumtext NOT NULL COMMENT '使用的卷子数据',
  resultData mediumtext NOT NULL COMMENT '用户提交的数据',
  start_time datetime NOT NULL COMMENT '开始考试时间',
  end_time datetime NOT NULL COMMENT '提交考试时间',
  remark text NOT NULL COMMENT '考试总评',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (result_info_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '参加考试结果信息表';


-- 用户考试信息表
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
AVG_ROW_LENGTH = 2048
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '用户考试信息表,开始考试便插入一条数据';











