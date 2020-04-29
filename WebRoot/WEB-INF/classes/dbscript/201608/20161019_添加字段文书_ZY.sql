--询问调查笔录字段添加
ALTER TABLE zfwsxwdcbl7
  ADD COLUMN dcbljlrqz VARCHAR(30) DEFAULT NULL COMMENT '记录人签字' AFTER dcbldcrqzrq,
  ADD COLUMN dcbljlrqzrq DATETIME DEFAULT NULL COMMENT '记录人签字日期' AFTER dcbljlrqz;