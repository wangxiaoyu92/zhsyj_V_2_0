ALTER TABLE sysuserdw
  ADD COLUMN qddszid VARCHAR(32) DEFAULT NULL COMMENT '签到点id' AFTER userid,
  ADD COLUMN status int(2)  DEFAULT NULL COMMENT '迟到2,正常为1' AFTER dwfs;