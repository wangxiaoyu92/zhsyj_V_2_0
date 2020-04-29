--法制机构审核意见书
CREATE TABLE syjzhpt.zfwsfzjgshyjs47 (
  fzjgshyjsid varchar(32) NOT NULL COMMENT 'id',
  ajdjid varchar(32) DEFAULT NULL COMMENT '案件登记id',
  shyjsay varchar(255) DEFAULT NULL COMMENT '案由',
  shyjslah varchar(100) DEFAULT NULL COMMENT '审核意见书立案号',
  shyjsdsr varchar(100) DEFAULT NULL COMMENT '审核意见书当事人',
  shyjscbr varchar(100) DEFAULT NULL COMMENT '审核意见书承办人',
  shyjsssjg varchar(100) DEFAULT NULL COMMENT '审核意见书送审机构',
  shyjssssj datetime DEFAULT NULL COMMENT '审核意见书送审时间',
  shyjshyyj varchar(1000) DEFAULT NULL COMMENT '审核意见书和议意见',
  shyjsshss varchar(500) DEFAULT NULL COMMENT '审核意见书审核事实',
  shyjsshzj varchar(500) DEFAULT NULL COMMENT '审核意见书审核证据',
  shyjsshyj varchar(500) DEFAULT NULL COMMENT '审核意见书审核依据',
  shyjsshcx varchar(500) DEFAULT NULL COMMENT '审核意见书审核程序',
  shyjsshcl varchar(500) DEFAULT NULL COMMENT '审核意见书审核处理',
  shyjsfzjgyj varchar(1000) DEFAULT NULL COMMENT '审核意见书法制机构意见',
  shyjsldspyj varchar(1000) DEFAULT NULL COMMENT '审核意见书领导审批意见',
  PRIMARY KEY (fzjgshyjsid)
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '法制机构审核意见书47';


INSERT INTO syjzhpt.pfjcs(FJCSID, FJCSDMLB, FJCSDMLBMC, FJCSDMZ, FJCSDMMC, 
FJCSKSRQ, FJCSZZRQ, FJCSQYFLAG, FJCSFJBC, ZFWSURL, FJCSZFWSTITLE, fjcsdlbh, 
fjcsdlmc, fjcssfdx, zfwstabname, zfwstabid) 
VALUES
('95', 'ZFAJZFWS', '执法案件文书', 'ZFAJZFWS47', '47法制机构审核意见书', 
'199405', NULL, '1', '1', 'pub/wsgldy/zfwsfzjgshyjsIndex', NULL, NULL, NULL, NULL, 'zfwsfzjgshyjs47', 'fzjgshyjsid');

