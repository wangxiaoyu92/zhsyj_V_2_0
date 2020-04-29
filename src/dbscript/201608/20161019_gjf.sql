ALTER TABLE pcompanyxkz
  ADD COLUMN comxkzzcxs VARCHAR(50) DEFAULT NULL COMMENT '组成形式' AFTER comxkzlx,
  ADD COLUMN comxkzztyt VARCHAR(200) DEFAULT NULL COMMENT '主题业态' AFTER comxkzzcxs;