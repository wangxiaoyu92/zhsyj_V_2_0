CREATE TABLE syjzhpt.dzqm (
  dzqmid varchar(32) NOT NULL COMMENT 'id',
  dzqmuser varchar(32) DEFAULT NULL COMMENT '用户id',
  dzqmpwd varchar(32) DEFAULT NULL COMMENT '电子签名密码',
  dzqmtp longblob DEFAULT NULL COMMENT '电子签名照',
  dzqmpath varchar(255) DEFAULT NULL COMMENT '路片路径',
  tpname varchar(255) DEFAULT NULL COMMENT '照片名字'
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '电子签名';


INSERT INTO syjzhpt.dzqm(dzqmid, dzqmuser, dzqmpwd, dzqmtp, dzqmpath, tpname) VALUES
('2017010608593205778123586', '2016052614593290514627369', '123456', NULL, '/upload/dzqm/ldh.png', NULL);