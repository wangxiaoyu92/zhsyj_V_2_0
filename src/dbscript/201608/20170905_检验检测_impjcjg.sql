
#####程序中有这个字段   但是数据库没有
ALTER TABLE jyjcjg
  ADD COLUMN impjcjg VARCHAR(255) DEFAULT NULL AFTER comid;