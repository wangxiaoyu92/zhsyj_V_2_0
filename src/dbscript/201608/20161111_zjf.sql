-- 在线用户统计
INSERT INTO `syjzhpt`.`sysfunction` (`FUNCTIONID`, `LOCATION`, `TITLE`, `PARENT`, `ORDERNO`, `TYPE`, `DESCRIPTION`, `LOG`, `OWNER`, `ACTIVE`, `FUNCTIONCODE`, `VISIBLE`, `BIZID`, `ROLBIZCLASS`, `IMAGEURL`, `EXPANDEDIMAGEURL`, `AAA102`, `CAE005`, `ROLBIZABLE`, `TARGET`, `SYSTEMCODE`) VALUES ('2016111123583894665098484', '/sysmanager/sysuser/sysuserOnlineIndex', '在线用户统计', '4', '1', '1', NULL, NULL, NULL, NULL, NULL, '1', 'sysuserOnlineIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');

ALTER TABLE syslogonlog add  `LOGONAPPVISION` varchar(32)  DEFAULT NULL COMMENT '登录APP版本号';