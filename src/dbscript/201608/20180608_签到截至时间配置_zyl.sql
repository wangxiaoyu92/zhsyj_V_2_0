
-- 用户表扩展签到时间
ALTER TABLE sysuser
  ADD COLUMN signintime TIME DEFAULT NULL COMMENT '签到时间' AFTER userjc;

ALTER TABLE sysuser
  ADD COLUMN allowsignintime TIME DEFAULT NULL COMMENT '允许开始签到时间' AFTER signintime;