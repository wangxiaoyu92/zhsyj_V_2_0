-- 培训系统菜单
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041015310304348359860', '', '培训系统', '', 1, '0', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
-- 课程管理菜单
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041015321093582233609', '/train/course/courseManagerIndex', '课程管理', '2017041015310304348359860', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'courseManagerIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
-- 添加课程按钮菜单
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041214374562425770267', '/train/course/addCourse', '添加课程', '2017041015321093582233609', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'addCourse', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
-- 编辑课程按钮菜单
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041214383250172559713', '/train/course/editCourse', '编辑课程', '2017041015321093582233609', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'editCourse', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
-- 删除课程按钮菜单
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041214391082870000946', '/train/course/delCourse', '删除课程', '2017041015321093582233609', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'delCourse', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
-- 课件管理按钮菜单
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041416243553872611028', '/train/course/wareManager', '课程管理', '2017041015321093582233609', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'wareManager', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
-- 讲师管理按钮菜单
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017041416250797137406190', '/train/course/teacherManager', '讲师管理', '2017041015321093582233609', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'teacherManager', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
-- 课程人员管理
INSERT INTO syjzhpt.sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017042211170264210605576', '/train/course/userManager', '课程人员管理', '2017041015321093582233609', 1, '2',NULL, NULL, NULL, NULL, NULL, '1', 'userManager', NULL, NULL, NULL, NULL, NULL, NULL, '', '');


-- 课程信息表
CREATE TABLE syjzhpt.ots_course (
  course_id varchar(32) NOT NULL COMMENT '课程ID',
  course_name varchar(1000) NOT NULL COMMENT '课程名称',
  course_category varchar(20) DEFAULT NULL COMMENT '课程分类',
  course_status tinyint(1) UNSIGNED NOT NULL COMMENT '课程状态,1=启用,2=禁用',
  course_des text DEFAULT NULL COMMENT '课程描述',
  course_click int(10) UNSIGNED DEFAULT 0,
  course_elective tinyint(1) UNSIGNED DEFAULT 0,
  course_approve tinyint(1) UNSIGNED DEFAULT 0,
  course_pass_condition varchar(20) DEFAULT NULL COMMENT '通过条件',
  course_start_time timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '开始学习时间',
  course_end_time timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '结束学习时间',
  class_start_time timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '线下上课开始时间',
  class_end_time timestamp DEFAULT '0000-00-00 00:00:00' COMMENT '线下上课结束时间',
  course_allow_ip text DEFAULT NULL COMMENT 'IP段',
  course_frontCoverImg varchar(200) DEFAULT NULL COMMENT '封面图片',
  course_isModifyProgress tinyint(1) NOT NULL DEFAULT 1 COMMENT '播放限制：0限制 1不限制',
  course_train_type varchar(20) DEFAULT NULL COMMENT '培训类型：0线上培训 1线下培训',
  course_offline_length float DEFAULT NULL COMMENT '线下课程时长',
  course_offline_credit float DEFAULT NULL COMMENT '线下课程学分',
  course_point_way int(1) UNSIGNED DEFAULT 0 COMMENT '学分计算方式(1-课件学分单算，0-整体通过计算)',
  course_isListShow tinyint(1) DEFAULT 1 COMMENT '学习计划中的课程是否前台课程列表中显示=1显示=0不显示默认是1',
  course_proportion tinyint(1) DEFAULT 100 COMMENT '课程要看到的百分比',
  course_see_single tinyint(1) DEFAULT 0 COMMENT '1=每个课件都看到上面比例，0=所有课件累计比例达到',
  course_auto_adopt tinyint(1) DEFAULT 1 COMMENT '报名自动审核（0-不，1-是）',
  course_person_amount int(255) DEFAULT 0 COMMENT '报名人数限制（0-不限制）',
  course_courseLocation varchar(100) DEFAULT NULL COMMENT '线下上课地点',
  registration tinyint(1) DEFAULT 0 COMMENT '代报名(0-不允许,1-允许)',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (course_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '课程信息表';

-- 课程教师中间表
CREATE TABLE syjzhpt.ots_course_teacher (
  teacher_id varchar(32) NOT NULL COMMENT '课程教师ID',
  course_id varchar(32) NOT NULL COMMENT '课程ID',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (teacher_id, course_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '课程教师中间表';

-- 课程课件对应表
CREATE TABLE syjzhpt.ots_course_warelist (
  course_ware_id varchar(32) NOT NULL,
  course_id varchar(32) NOT NULL COMMENT '课程ID',
  ware_id varchar(32) NOT NULL COMMENT '课件ID',
  ware_sequence int(10) UNSIGNED DEFAULT NULL COMMENT '顺序号',
  elective_num varchar(10) DEFAULT '0',
  aae011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (course_ware_id)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '课程课件对应表';



