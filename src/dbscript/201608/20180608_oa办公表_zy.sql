DROP TABLE IF EXISTS oamatterdynamic;
CREATE TABLE oamatterdynamic (
  oamatterdynamicid VARCHAR(32) NOT NULL COMMENT 'oa任务动态id',
  othertableid VARCHAR(32) NOT NULL COMMENT '其他表id',
  replytype VARCHAR(10) DEFAULT NULL COMMENT '回复类型aaa100=replytype，0系统回复信息1相关人回复',
  replycontent VARCHAR(500) DEFAULT NULL COMMENT '动态内容',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '操作员',
  aae036 DATETIME DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (oamatterdynamicid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 780
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa事项动态';


DROP TABLE IF EXISTS oameeting;
CREATE TABLE oameeting (
  oameetingid VARCHAR(32) NOT NULL COMMENT 'oa会议表id',
  mettingcontent VARCHAR(2000) DEFAULT NULL COMMENT '会议内容',
  starttime DATETIME DEFAULT NULL COMMENT '开始时间',
  endtime DATETIME DEFAULT NULL COMMENT '结束时间',
  meetingplace VARCHAR(200) DEFAULT NULL COMMENT '会议地点',
  sendtype VARCHAR(10) DEFAULT NULL COMMENT '发送方式aaa100=sendtype',
  remindtype VARCHAR(10) DEFAULT NULL COMMENT '到期提醒方式aaa100=remindtype',
  meetingremindtime VARCHAR(10) DEFAULT NULL COMMENT '到期提前提醒时间aaa100=meetingremindtime',
  meetingstate VARCHAR(10) DEFAULT NULL COMMENT '会议状态aa100=meetingstate',
  meetingcancelreason VARCHAR(500) DEFAULT NULL COMMENT '会议取消原因',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '经办人',
  aae036 DATETIME DEFAULT NULL COMMENT '经办时间',
  sfyx VARCHAR(10) DEFAULT '1' COMMENT '是否有效aaa100=sfyx',
  PRIMARY KEY (oameetingid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 2730
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa会议表';


DROP TABLE IF EXISTS oameetingman;
CREATE TABLE oameetingman (
  oameetingmanid VARCHAR(32) NOT NULL COMMENT 'oa会议关联人表id',
  oameetingid VARCHAR(32) NOT NULL COMMENT 'oa会议表id',
  meetingmantype VARCHAR(10) DEFAULT NULL COMMENT '会议关联人类型aaa100=meetingmantype，1会议纪要记录人2参会人',
  userid VARCHAR(32) DEFAULT NULL COMMENT '人员id',
  havereadflag VARCHAR(10) DEFAULT NULL COMMENT '已读标志aaa100=shifoubz',
  receivedflag VARCHAR(10) DEFAULT NULL COMMENT '确认收到标志aaa100=shifoubz',
  meetingsignflag VARCHAR(10) DEFAULT NULL COMMENT '会议签到标志aaa100=shifoubz',
  completestate VARCHAR(10) DEFAULT NULL COMMENT '完成状态aaa100=completestate，0未1已2不能',
  cannotreason VARCHAR(500) DEFAULT NULL COMMENT '不能完成原因',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '操作员',
  aae036 DATETIME DEFAULT NULL COMMENT '操作时间',
  tasktransferflag VARCHAR(10) DEFAULT NULL COMMENT '任务转交标志aaa100=shifoubz',
  PRIMARY KEY (oameetingmanid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 1260
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa会议关联人表';


DROP TABLE IF EXISTS oameetingrman;
CREATE TABLE oameetingrman (
  oameetingrmanid VARCHAR(32) NOT NULL COMMENT 'oa会议关联人表id',
  oameetingid VARCHAR(32) NOT NULL COMMENT 'oa会议表id',
  meetingrmantype VARCHAR(10) DEFAULT NULL COMMENT '会议关联人类型aaa100=meetingrmantype，1会议纪要记录人2参会人',
  userid VARCHAR(32) DEFAULT NULL COMMENT '人员id',
  havereadflag VARCHAR(10) DEFAULT NULL COMMENT '已读标志aaa100=shifoubz',
  receivedflag VARCHAR(10) DEFAULT NULL COMMENT '确认收到标志aaa100=shifoubz',
  meetingsignflag VARCHAR(10) DEFAULT NULL COMMENT '会议签到标志aaa100=shifoubz',
  completestate VARCHAR(10) DEFAULT NULL COMMENT '完成状态aaa100=completestate，0未1已2不能',
  cannotreason VARCHAR(500) DEFAULT NULL COMMENT '不能完成原因',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '操作员',
  aae036 DATETIME DEFAULT NULL COMMENT '操作时间',
  tasktransferflag VARCHAR(10) DEFAULT NULL COMMENT '任务转交标志aaa100=shifoubz',
  PRIMARY KEY (oameetingrmanid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa会议关联人表';


DROP TABLE IF EXISTS oameetingtask;
CREATE TABLE oameetingtask (
  oameetingtaskid VARCHAR(32) NOT NULL COMMENT 'oa会议纪要任务表',
  oameetingid VARCHAR(32) NOT NULL COMMENT 'oa会议表id',
  oataskid VARCHAR(32) NOT NULL COMMENT 'oa任务表id',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '经办人',
  aae036 DATETIME DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (oameetingtaskid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa会议纪要任务表';


DROP TABLE IF EXISTS oanoticemanager;
CREATE TABLE oanoticemanager (
  oanoticemanagerid VARCHAR(32) DEFAULT NULL COMMENT 'oa通知管理id',
  noticetype VARCHAR(10) DEFAULT NULL COMMENT '通知类型aaa100=noticetype',
  othertableid VARCHAR(32) DEFAULT NULL COMMENT '其他表主键',
  receivemanid VARCHAR(32) DEFAULT NULL COMMENT '接收人id',
  noticecontent VARCHAR(500) DEFAULT NULL COMMENT '通知内容',
  havereadflag VARCHAR(10) DEFAULT NULL COMMENT '已读标志aaa100=shifoubz',
  sendflag VARCHAR(10) DEFAULT NULL COMMENT '发送标志aaa100=shifou',
  sendokflag VARCHAR(10) DEFAULT NULL COMMENT '发送成功标志aaa100=shifou',
  czyid VARCHAR(32) DEFAULT NULL COMMENT '操作员id',
  czyname VARCHAR(20) DEFAULT NULL COMMENT '操作员名称',
  aae036 DATETIME DEFAULT NULL COMMENT '操作时间',
  noticetitle VARCHAR(200) DEFAULT NULL COMMENT '通知标题'
)
ENGINE = INNODB
AVG_ROW_LENGTH = 455
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa通知管理';


DROP TABLE IF EXISTS oaschedule;
CREATE TABLE oaschedule (
  oascheduleid VARCHAR(32) NOT NULL COMMENT 'oa日程表id',
  schedulecontent VARCHAR(500) DEFAULT NULL COMMENT '日程内容',
  starttime DATETIME DEFAULT NULL COMMENT '日程开始时间',
  endtime DATETIME DEFAULT NULL COMMENT '日程结束时间',
  needremindflag VARCHAR(10) DEFAULT NULL COMMENT '到期是否提醒aaa100=shifoubz',
  remindtype VARCHAR(10) DEFAULT NULL COMMENT '到期提醒方式aaa100=remindtype',
  scheduleremindtime VARCHAR(10) DEFAULT NULL COMMENT '日程到期提前提醒时间aaa100=scheduleremindtime',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '经办人',
  aae036 DATETIME DEFAULT NULL COMMENT '经办时间',
  remarks VARCHAR(500) DEFAULT NULL COMMENT '备注',
  sfyx VARCHAR(10) DEFAULT NULL COMMENT '是否有效aaa100=sfyx',
  PRIMARY KEY (oascheduleid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa日程表';


DROP TABLE IF EXISTS oatask;
CREATE TABLE oatask (
  oataskid VARCHAR(32) NOT NULL COMMENT 'oa任务表id',
  parenttaskid VARCHAR(32) DEFAULT NULL COMMENT '父任务id',
  tasktype VARCHAR(10) DEFAULT NULL COMMENT '任务形式aaa100=tasktype，0文字，1语音',
  taskcontent VARCHAR(2000) DEFAULT NULL COMMENT '任务内容',
  sendtype VARCHAR(10) DEFAULT NULL COMMENT '发送方式aaa100=sendtype',
  endtime DATETIME DEFAULT NULL COMMENT '截止时间',
  needremindflag VARCHAR(10) DEFAULT NULL COMMENT '到期是否提醒aaa100=shifoubz',
  remindtype VARCHAR(10) DEFAULT NULL COMMENT '到期提醒方式aaa100=remindtype',
  taskremindtime VARCHAR(10) DEFAULT NULL COMMENT '到期提前提醒时间aaa100=taskremindtime',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '经办人',
  aae036 DATETIME DEFAULT NULL COMMENT '经办时间',
  sfyx VARCHAR(10) DEFAULT NULL COMMENT '是否有效aaa100=sfyx',
  PRIMARY KEY (oataskid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa任务表';


DROP TABLE IF EXISTS oataskman;
CREATE TABLE oataskman (
  oataskmanid VARCHAR(32) NOT NULL COMMENT 'oa任务关联人表id',
  oataskid VARCHAR(32) NOT NULL COMMENT 'oa任务表id',
  taskmantype VARCHAR(10) DEFAULT NULL COMMENT '事项关联人类型aaa100=taskmantype，0执行人1抄送人',
  userid VARCHAR(32) DEFAULT NULL COMMENT '人员id',
  havereadflag VARCHAR(10) DEFAULT NULL COMMENT '已读标志aaa100=shifoubz',
  receivedflag VARCHAR(10) DEFAULT NULL COMMENT '确认收到标志aaa100=shifoubz',
  completestate VARCHAR(10) DEFAULT NULL COMMENT '完成状态aaa100=completestate，0未1已2不能',
  cannotreason VARCHAR(500) DEFAULT NULL COMMENT '不能完成原因',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '操作员',
  aae036 DATETIME DEFAULT NULL COMMENT '操作时间',
  tasktransferflag VARCHAR(10) DEFAULT NULL COMMENT '任务转交标志aaa100=shifoubz',
  PRIMARY KEY (oataskmanid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 3276
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa任务关联人表';


DROP TABLE IF EXISTS oatasktransfer;
CREATE TABLE oatasktransfer (
  oatasktransferid VARCHAR(32) NOT NULL COMMENT 'oa任务转交表id',
  oataskmanid VARCHAR(32) NOT NULL COMMENT 'oa任务关联人表id',
  oataskmannewid VARCHAR(32) DEFAULT NULL COMMENT 'oa任务关联人表newid',
  aae011 VARCHAR(32) DEFAULT NULL COMMENT '经办人',
  aae036 DATETIME DEFAULT NULL COMMENT '经办时间',
  PRIMARY KEY (oatasktransferid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'oa任务转交表';
