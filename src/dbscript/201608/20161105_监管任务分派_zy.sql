-- 检查任务人员表
CREATE TABLE syjzhpt.bschecktaskperson (
  id varchar(32) DEFAULT NULL COMMENT '主键',
  taskid varchar(32) DEFAULT NULL COMMENT '检查任务ID',
  userid varchar(32) DEFAULT NULL COMMENT '检查人员ID',
  PRIMARY KEY (id)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查任务人员表';

-- 检查任务分派概要表
CREATE TABLE syjzhpt.bschecktask (
  taskid varchar(32) NOT NULL COMMENT '任务ID',
  planid varchar(32) DEFAULT NULL COMMENT '计划ID',
  taskname varchar(400) DEFAULT NULL COMMENT '任务名称',
  taskremark varchar(400) DEFAULT NULL COMMENT '任务描述',
  tasktimest datetime DEFAULT NULL COMMENT '任务开始时间',
  tasktimeed datetime DEFAULT NULL COMMENT '任务结束时间',
  aaa011 varchar(32) DEFAULT NULL COMMENT '经办人',
  aae036 datetime DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (taskid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查任务分派概要表';

-- 检查任务明细表
CREATE TABLE syjzhpt.bschecktaskdetail (
  taskdetailid varchar(32) DEFAULT NULL COMMENT '任务明细主键',
  taskid varchar(32) DEFAULT NULL COMMENT '任务ID',
  comid varchar(32) DEFAULT NULL COMMENT '公司ID',
  flag int(11) DEFAULT NULL COMMENT '检查进度标志',
  PRIMARY KEY (taskdetailid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '检查任务明细表';

-- 检查结果概要表增加任务明细ID
ALTER TABLE syjzhpt.bscheckdetail ADD COLUMN taskdetailid varchar(32) COMMENT '任务明细主键';