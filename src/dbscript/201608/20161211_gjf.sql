ALTER TABLE jyjcjg
  ADD COLUMN `comid` VARCHAR(32) DEFAULT NULL COMMENT '企业id';

ALTER TABLE pdbsx
  ADD COLUMN hfid VARCHAR(32) DEFAULT NULL COMMENT '回复id' AFTER fsxtbz;