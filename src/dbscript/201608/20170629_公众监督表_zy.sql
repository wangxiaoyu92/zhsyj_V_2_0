CREATE TABLE `pgzjd` (
  `pgzjdid` varchar(32) NOT NULL COMMENT '公众监督表id',
  `pjdr` varchar(32) DEFAULT NULL COMMENT '监督人',
  `pjdsj` datetime DEFAULT NULL COMMENT '监督时间',
  `pjdbt` varchar(100) DEFAULT NULL COMMENT '监督标题',
  `pmobile` varchar(20) DEFAULT NULL COMMENT '监督人手机号',
  `pjdnr` text COMMENT '内容',
  PRIMARY KEY (`pgzjdid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公众监督表'
