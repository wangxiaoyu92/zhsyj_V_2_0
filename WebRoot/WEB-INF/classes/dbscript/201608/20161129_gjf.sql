ALTER TABLE jyjcjg
  ADD COLUMN jcypid VARCHAR(32) DEFAULT NULL COMMENT '检测样品id' AFTER impbatchno,
  ADD COLUMN jcxmid VARCHAR(32) DEFAULT NULL COMMENT '检测项目id' AFTER jcypid;
  ADD COLUMN comid VARCHAR(32) DEFAULT NULL COMMENT '企业id' AFTER jcxmid;
  
  ALTER TABLE sysuseraae
  ADD UNIQUE INDEX UK_sysuseraae (userid, aae140);

ALTER TABLE sysuserarea
  ADD UNIQUE INDEX UK_sysuserarea (userid, aaa027);

ALTER TABLE sysuserorg
  ADD UNIQUE INDEX UK_sysuserorg (userid, orgid);

ALTER TABLE pcompany
  ADD INDEX IDX_pcompany_orgid (orgid);

ALTER TABLE pcompanycomdalei
  ADD UNIQUE INDEX UK_pcompanycomdalei (comid, comdalei);