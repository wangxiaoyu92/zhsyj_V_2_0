ALTER TABLE pcompany
ADD COLUMN sjdatatime date DEFAULT NULL COMMENT '省局数据同步时间',
ADD COLUMN sjdatacomid varchar(32) DEFAULT NULL COMMENT '省局数据主键' AFTER outercomid,
ADD COLUMN sjdatacomdm varchar(32) DEFAULT NULL COMMENT '省局数据企业代码' AFTER sjdatacomid;

ALTER TABLE pcompanyxkz
  ADD COLUMN sjdatatime date  DEFAULT NULL COMMENT '省局数据同步时间' AFTER comxkzjycs,
  ADD COLUMN sjdataid VARCHAR(32) DEFAULT NULL COMMENT '省局数据主键' AFTER sjdatatime,
  ADD COLUMN sjdatacomdm VARCHAR(32) DEFAULT NULL COMMENT '省局数据企业代码' AFTER sjdatacomid;

INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMDALEI', '107001', '食品添加剂生产企业', 199405, NULL, '2017120711011758259548766', '1400', '700', '1', '1', NULL, NULL, NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMDALEI', '108001', '体外诊断试剂生产企业', 199405, NULL, '2017120711011758259548767', '1400', '800', '1', '1', NULL, NULL, NULL, NULL);

INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMZZZM', '13', '医疗机构制剂许可证(未经验证)', 199405, NULL, '2017120714480625582871001', '1428', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMZZZM', '14', '医疗机构制剂许可证', 199405, NULL, '2017120714480625582871002', '1428', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMZZZM', '15', '医疗机构制剂批准文号', 199405, NULL, '2017120714480625582871003', '1428', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMZZZM', '16', '医疗器械注册许可证', 199405, NULL, '2017120714480625582871004', '1428', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMZZZM', '17', '体外诊断试剂许可证', 199405, NULL, '2017120714480625582871005', '1428', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMZZZM', '18', '二类医疗器械经营备案凭证', 199405, NULL, '2017120714480625582871006', '1428', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMZZZM', '19', 'GSP认证许可', 199405, NULL, '2017120714480625582871007', '1428', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('COMZZZM', '20', 'GMP许可证号', 199405, NULL, '2017120714480625582871008', '1428', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('KJLX', '4', '图文', 199405, NULL, '2017121410542034860683089', '2017060611031725228262809', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

ALTER TABLE bs_daima
  ADD COLUMN comdalei VARCHAR(50) DEFAULT NULL COMMENT '对应的企业大类' AFTER duiyingzhi;

