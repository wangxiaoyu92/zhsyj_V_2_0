ALTER TABLE sysuser
  ADD COLUMN userjc VARCHAR(100) DEFAULT NULL COMMENT '用户汉字首字符简称' AFTER selfcomflag;

UPDATE sysuser set userjc=getpy(DESCRIPTION);