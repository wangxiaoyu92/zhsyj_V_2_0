ALTER TABLE qproduct
  ADD COLUMN projj VARCHAR(2000) DEFAULT NULL COMMENT '产品简介' AFTER yclproid;

INSERT INTO aa10(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, aaa106, aaa107, aae011, aae036) VALUES
('CPPCSCDWDM', '10', '瓶', 199405, NULL, '2017062918171780518444050', '2016062717313998062921406', NULL, NULL, NULL, NULL, NULL, NULL, NULL);


ALTER TABLE jyjccydj
CHANGE COLUMN id cydjid varchar(32) NOT NULL COMMENT '主键';

INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017072910001518491838886', '/spsy/spproduct/deletesym', '删除溯源码', '2016062715390497768610470', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'deletesym', NULL, NULL, NULL, NULL, NULL, NULL, '', 'zsxt');

ALTER TABLE qproduct
  CHANGE COLUMN probzq probzq VARCHAR(10) DEFAULT NULL COMMENT '保质期',
  ADD COLUMN proprice VARCHAR(50) DEFAULT NULL COMMENT '产品价格' AFTER projj;
  
  
ALTER TABLE bscheckdetail
  CHANGE COLUMN detaildecide detaildecide VARCHAR(200) DEFAULT NULL COMMENT '明细结果判定0未选择1符合2不符合3合理缺项';

ALTER TABLE pcompanyxkz
  ADD INDEX IDX_pcompanyxkz_comid (comid);



DROP FUNCTION IF EXISTS `getPY`;

CREATE DEFINER = 'root'@'localhost' 
FUNCTION `getPY`(in_string VARCHAR(21845)) RETURNS VARCHAR(21845) CHARSET utf8
BEGIN
#截取字符串，每次做截取后的字符串存放在该变量中，初始为函数参数in_string值
DECLARE tmp_str VARCHAR(21845) CHARSET gbk DEFAULT '' ; 
#tmp_str的长度
DECLARE tmp_len SMALLINT DEFAULT 0;
#tmp_str的长度
DECLARE tmp_loc SMALLINT DEFAULT 0;
#截取字符，每次 left(tmp_str,1) 返回值存放在该变量中
DECLARE tmp_char VARCHAR(2) CHARSET gbk DEFAULT '';
#结果字符串
DECLARE tmp_rs VARCHAR(21845)CHARSET gbk DEFAULT '';
#拼音字符，存放单个汉字对应的拼音首字符
DECLARE tmp_cc VARCHAR(2) CHARSET gbk DEFAULT '';
#初始化，将in_string赋给tmp_str
SET tmp_str = in_string;
#初始化长度
SET tmp_len = LENGTH(tmp_str);
#如果被计算的tmp_str长度大于0则进入该while
WHILE tmp_len > 0 DO 
#获取tmp_str最左端的首个字符，注意这里是获取首个字符，该字符可能是汉字，也可能不是。
SET tmp_char = LEFT(tmp_str,1);
#左端首个字符赋值给拼音字符
SET tmp_cc = tmp_char;
#获取字符的编码范围的位置，为了确认汉字拼音首字母是那一个
SET tmp_loc=INTERVAL(CONV(HEX(tmp_char),16,10),0xB0A1,0xB0C5,0xB2C1,0xB4EE,0xB6EA,0xB7A2,0xB8C1,0xB9FE,0xBBF7,0xBFA6,0xC0AC
,0xC2E8,0xC4C3,0xC5B6,0xC5BE,0xC6DA,0xC8BB,0xC8F6,0xCBFA,0xCDDA ,0xCEF4,0xD1B9,0xD4D1);
#判断左端首个字符是多字节还是单字节字符，要是多字节则认为是汉字且作以下拼音获取，要是单字节则不处理。如果是多字节字符但是不在对应的编码范围之内，即对应的不是大写字母则也不做处理，这样数字或者特殊字符就保持原样了
IF (LENGTH(tmp_char)>1 AND tmp_loc>0 AND tmp_loc<24) THEN
#获得汉字拼音首字符
SELECT ELT(tmp_loc,'A','B','C','D','E','F','G','H','J','K','L','M','N','O','P','Q','R','S','T','W','X','Y','Z') INTO tmp_cc; 
END IF;
#将当前tmp_str左端首个字符拼音首字符与返回字符串拼接
SET tmp_rs = CONCAT(tmp_rs,tmp_cc);
#将tmp_str左端首字符去除
SET tmp_str = SUBSTRING(tmp_str,2);
#计算当前字符串长度
SET tmp_len = LENGTH(tmp_str);
END WHILE;
#返回结果字符串
RETURN tmp_rs;
END;


UPDATE jyjcyp set jcypjc=getPY(jcypmc);

ALTER TABLE hjhb
  ADD COLUMN jhplh VARCHAR(32) DEFAULT NULL COMMENT '进货批量号' AFTER jhqrbz;

INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2017090815330596956640532', '/tmsyjhtgl/jinhuobatchIndex', '批量进货管理', '2017032214445093628409569', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'jinhuobatchIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');

  