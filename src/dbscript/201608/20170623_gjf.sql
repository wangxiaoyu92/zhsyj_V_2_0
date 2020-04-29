INSERT INTO pfjcs(FJCSID, FJCSDMLB, FJCSDMLBMC, FJCSDMZ, FJCSDMMC, FJCSKSRQ, FJCSZZRQ, FJCSQYFLAG, FJCSFJBC, ZFWSURL, FJCSZFWSTITLE, fjcsdlbh, fjcsdlmc, fjcssfdx, zfwstabname, zfwstabid, fjcsorder) VALUES
('2017060517315771200767318', 'RCJCQZPIC', '日常检查签字图片', 'RCJCQZPIC01', '执法人员签字', '199405', NULL, '1', '0', NULL, NULL, 'RCJCQZPIC', '日常检查签字图片', '0', NULL, NULL, NULL);
INSERT INTO pfjcs(FJCSID, FJCSDMLB, FJCSDMLBMC, FJCSDMZ, FJCSDMMC, FJCSKSRQ, FJCSZZRQ, FJCSQYFLAG, FJCSFJBC, ZFWSURL, FJCSZFWSTITLE, fjcsdlbh, fjcsdlmc, fjcssfdx, zfwstabname, zfwstabid, fjcsorder) VALUES
('2017060517315771200767319', 'RCJCQZPIC', '日常检查签字图片', 'RCJCQZPIC02', '被检查单位签字', '199405', NULL, '1', '0', NULL, NULL, 'RCJCQZPIC', '日常检查签字图片', '0', NULL, NULL, NULL);

ALTER TABLE hjyjcmxb
CHANGE COLUMN jcxmid jcxmbh varchar(32) DEFAULT NULL COMMENT '检测项目id(仪器导入用)';

delete from bstbodyinfo where tbodyid='5555';
INSERT INTO bstbodyinfo(tbodyid, aaa027, tbodytype, tbodycode, tbbodyid, tbodyinfo, tbody, tfootinfo, miaoshu) VALUES
('5555', '410523000000', 'resultInfo', '1', NULL, '<p style="text-align:center">&nbsp;</p>\r\n\r\n<p style="text-align:center">&nbsp;</p>\r\n\r\n<p style="text-align:center"><span style="font-size:26px"><strong>汤阴县食品药品监督管理局</strong></span></p>\r\n\r\n<p style="text-align:center"><span style="font-size:26px"><strong>食品生产经营日常监督检查结果记录表</strong></span></p>\r\n\r\n<p style="text-align:center">编号：jgbh</p>\r\n\r\n<div style="height:1200px">\r\n<table align="center" border="1" cellpadding="0" cellspacing="0" style="height:90%; width:90%">\r\n\t<tbody>\r\n\t\t<tr>\r\n\t\t\t<td style="width:98px">\r\n\t\t\t<p style="text-align:center">名称</p>\r\n\t\t\t</td>\r\n\t\t\t<td colspan="2" style="width:225px">\r\n\t\t\t<p style="text-align:center">commc</p>\r\n\t\t\t</td>\r\n\t\t\t<td style="width:79px">\r\n\t\t\t<p style="text-align:center">地址</p>\r\n\t\t\t</td>\r\n\t\t\t<td style="width:240px">\r\n\t\t\t<p>commdz</p>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td style="width:98px">\r\n\t\t\t<p style="text-align:center">联系人</p>\r\n\t\t\t</td>\r\n\t\t\t<td colspan="2" style="width:225px">\r\n\t\t\t<p style="text-align:center">comlxr</p>\r\n\t\t\t</td>\r\n\t\t\t<td style="width:79px">\r\n\t\t\t<p style="text-align:center">联系方式</p>\r\n\t\t\t</td>\r\n\t\t\t<td style="width:240px">\r\n\t\t\t<p>comlxfs</p>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td style="width:98px">\r\n\t\t\t<p style="text-align:center">许可证编号</p>\r\n\t\t\t</td>\r\n\t\t\t<td colspan="2" style="width:225px">\r\n\t\t\t<p>comxkz</p>\r\n\t\t\t</td>\r\n\t\t\t<td style="width:79px">\r\n\t\t\t<p style="text-align:center">检查次数</p>\r\n\t\t\t</td>\r\n\t\t\t<td style="width:240px">\r\n\t\t\t<p>本年度第 num&nbsp;次检查</p>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td colspan="5" style="width:643px">\r\n\t\t\t<p><strong>检查内容：</strong></p>\r\n\r\n\t\t\t<p>&nbsp; &nbsp; <u>汤阴县食品药品监督管理局 &nbsp;</u>检查人员 根据《中华人民共和国食品安全法》及其实施条例、《食品生产经营日常监督检查管理办法》的规定，于 year 年 month 月 date&nbsp;日对你单位进行了监督检查。本次监督检查按照<u>&nbsp;Itemname&nbsp;</u>表开展，共检查了（ &nbsp;count &nbsp;）项内容；其中：</p>\r\n\r\n\t\t\t<p style="margin-left:21.0000pt">重点项（impcount）项，项目序号分别是（impnum），发现问题（problemcount）项，项目序号分别是（problemnum）；</p>\r\n\r\n\t\t\t<p>&nbsp; &nbsp; 一般项（commocount）项，项目序号分别是（commnum），发现问题（comproblemcount）项，项目序号分别是（comproblemnum）。</p>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td colspan="5" style="width:643px">\r\n\t\t\t<p><strong>检查结果：</strong></p>\r\n\r\n\t\t\t<p>fuhe符合 &nbsp;&nbsp;bufh不符合&nbsp;zhenggai限期整改</p>\r\n\r\n\t\t\t<p>checkResult</p>\r\n\r\n\t\t\t<p><strong>检查意见</strong>（可附页）<strong>：</strong></p>\r\n\r\n\t\t\t<p>resultdisc</p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t\t<tr>\r\n\t\t\t<td colspan="2" style="width:312px">\r\n\t\t\t<p>执法人员（签名）：</p>\r\n\r\n\t\t\t<p style="margin-left:262.5000pt">&nbsp;</p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\r\n\t\t\t<p>&nbsp;&nbsp;&nbsp;&nbsp;<img src=zfryqmpic style="width:120px;height:60px"/></p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\r\n\t\t\t<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;&nbsp;月 &nbsp; &nbsp; 日</p>\r\n\t\t\t</td>\r\n\t\t\t<td colspan="3" style="width:331px">\r\n\t\t\t<p>被检查单位意见：</p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\r\n\t\t\t<p>&nbsp;</p>\r\n\r\n\t\t\t<p>法人或负责人：<img src=bjcdwqmpic style="width:120px;height:60px"/></p>\r\n\r\n\t\t\t<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月 &nbsp;&nbsp;&nbsp;&nbsp;日（章）</p>\r\n\t\t\t</td>\r\n\t\t</tr>\r\n\t</tbody>\r\n</table>\r\n</div>\r\n', NULL, NULL, '食品生产经营日常监督检查结果记录表');




