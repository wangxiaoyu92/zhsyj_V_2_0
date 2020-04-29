call PRC_INSERTCODE('XKFW','许可范围','1','A','预包装食品含冷冻','199405',null,@P_CODE,@P_MSG); 
call PRC_INSERTCODE('XKFW','许可范围','1','B','预包装食品不含冷冻','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XKFW','许可范围','1','C','散装食品含冷冻','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XKFW','许可范围','1','D','散装食品不含冷冻','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XKFW','许可范围','1','E','保健食品','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XKFW','许可范围','1','F','特殊医学用途配方食品','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XKFW','许可范围','1','G','婴幼儿配方乳粉','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XKFW','许可范围','1','H','其他婴幼儿配方食品','199405',null,@P_CODE,@P_MSG);
call PRC_INSERTCODE('XKFW','许可范围','1','I','其他类食品销售','199405',null,@P_CODE,@P_MSG);


call PRC_INSERTCODE('YWJL','有无酒类','1','1','是','199405',null,@P_CODE,@P_MSG); 
call PRC_INSERTCODE('YWJL','有无酒类','1','2','否','199405',null,@P_CODE,@P_MSG);



call PRC_INSERTCODE('ZJJL','有无酒类','1','1','专','199405',null,@P_CODE,@P_MSG); 
call PRC_INSERTCODE('ZJJL','有无酒类','1','2','兼','199405',null,@P_CODE,@P_MSG);



DROP TABLE IF EXISTS `tablbcom`;

CREATE TABLE `tablbcom` (
  `id` varchar(10) default NULL COMMENT '序号',
  `bz` varchar(100) default NULL COMMENT '备注',
  `sdmc` varchar(200) default NULL COMMENT '商品名称',
  `xkmc` varchar(200) default NULL COMMENT '许可名称',
  `fzr` varchar(30) default NULL COMMENT '负责人',
  `jydz` varchar(200) default NULL COMMENT '经营地址',
  `lxfs` varchar(200) default NULL COMMENT '联系方式',
  `mdbh` varchar(100) default NULL COMMENT '门店编号',
  `xkzh` varchar(100) default NULL COMMENT '许可证号',
  `yxqz` date DEFAULT NULL COMMENT '许可有效期起',
 `xkfw` varchar(30) default NULL COMMENT '许可范围',
  `jylb` varchar(30) default NULL COMMENT '经营类别',
 `zmj` decimal(10,0) DEFAULT NULL COMMENT '总面积',
 `yyzh` varchar(100) default NULL COMMENT '营业执照',
`xyzb` varchar(20) DEFAULT NULL COMMENT '是否校园周边1是2 否',
  `fxdj` varchar(20) DEFAULT NULL COMMENT '风险等级ABCD',
  `cfw` varchar(20) DEFAULT NULL COMMENT '是否超范围',
  `ywjl` varchar(20) DEFAULT NULL COMMENT '有无酒类',
`zjjl` varchar(20) DEFAULT NULL COMMENT '专兼酒类',
  `aaa027` varchar(12) default NULL,
  `orgid` varchar(12) default NULL,
  `errstr` varchar(500) default NULL,
  `doflag` varchar(10) default NULL,
  `mulu` varchar(50) default NULL,
  `pkid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



ALTER TABLE pcompany
  ADD COLUMN comjlzj VARCHAR(10) DEFAULT NULL COMMENT '酒类专兼' AFTER comgddh，
  ADD COLUMN comjlyw VARCHAR(50) DEFAULT NULL COMMENT '酒类有无' AFTER comjlzj， 
  ADD COLUMN comcfw VARCHAR(50) DEFAULT NULL COMMENT '是否超范围' AFTER comjlyw，
  ADD COLUMN commdbh VARCHAR(50) DEFAULT NULL COMMENT '门店编号' AFTER comdalei;


INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', 'A', '批发', '199405', NULL, '30974', '1400', '100', 'SPSC', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', 'B', '零售', '199405', NULL, '30975', '1400', '100', 'SPSC', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', 'C', '农村合作社', '199405', NULL, '30976', '1400', '100', 'SPSC', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', 'D', '网络经营', '199405', NULL, '30977', '1400', '100', 'SPSC', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', 'E', '食用农产品', '199405', NULL, '30978', '1400', '100', 'SPSC', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', 'F', '冷库', '199405', NULL, '30979', '1400', '100', 'SPSC', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', 'G', '运输业', '199405', NULL, '30980', '1400', '100', 'SPSC', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', 'H', '仓储业', '199405', NULL, '30981', '1400', '100', 'SPSC', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '1', '化妆品专营店', '199405', NULL, '30982', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '2', '大中型商场超市', '199405', NULL, '30983', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '3', '一般商店', '199405', NULL, '30984', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '4', '美容院', '199405', NULL, '30985', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '5', '美发场所', '199405', NULL, '30986', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '6', '宾馆酒店场所', '199405', NULL, '30987', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '7', '洗浴场所', '199405', NULL, '30988', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '8', '药店', '199405', NULL, '30989', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `syjzhpt`.`aa10` (`AAA100`, `AAA102`, `AAA103`, `AAE030`, `AAE031`, `AAZ093`, `AAZ094`, `AAA104`, `AAA101`, `AAA105`, `aaa106`, `aaa107`, `aae011`, `aae036`) VALUES ('COMDALEI', '9', '其他', '199405', NULL, '30990', '1400', '300', 'HZP', NULL, NULL, NULL, NULL, NULL);


