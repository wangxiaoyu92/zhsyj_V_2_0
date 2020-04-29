-----------------------------------------------------------------------------------------------------------------
CREATE TABLE zdhddj (
  zdhddjid varchar(32) NOT NULL DEFAULT '' COMMENT '重大活动登记表ID',
  comid varchar(32) DEFAULT NULL COMMENT '企业id',
  zdhdlxr varchar(30) DEFAULT NULL COMMENT '企业联系人',
  zdhdlxdh varchar(20) DEFAULT NULL COMMENT '企业联系电话',
  zdhdmc varchar(100) DEFAULT NULL COMMENT '重大活动名称',
  zdhdkssj datetime DEFAULT NULL COMMENT '承接重大活动开始时间',
  zdhdjssj datetime DEFAULT NULL COMMENT '承接重大活动结束时间',
  zdhdjckssj datetime DEFAULT NULL COMMENT '重大活动检查开始时间',
  zdhdjcryid varchar(32) DEFAULT NULL COMMENT '重大活动检查人员表id',
  zdhddd varchar(200) DEFAULT NULL COMMENT '重大活动地点',
  zdhdjdzb varchar(30) DEFAULT NULL COMMENT '重大活动经度坐标',
  zdhdwdzb varchar(30) DEFAULT NULL COMMENT '重大活动纬度坐标',
  zdhdbeizhu varchar(200) DEFAULT NULL COMMENT '重大活动备注',
  aae011 varchar(20) DEFAULT NULL COMMENT '操作员',
  aae036 datetime DEFAULT NULL COMMENT '操作时间',
  aaa027 varchar(12) DEFAULT NULL COMMENT '统筹区',
  orgid varchar(32) DEFAULT NULL COMMENT '操作员所属机构id',
  planid varchar(32) DEFAULT NULL COMMENT '检查计划id',
  PRIMARY KEY (zdhddjid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '重大活动登记表';

-----------------------------------------------------------------------------------------------------------------

CREATE TABLE zdhdjcry (
  zdhdjcryid varchar(32) NOT NULL COMMENT '重大活动检查人员表id',
  zdhddjid varchar(32) DEFAULT NULL COMMENT '重大活动登记表ID',
  userid varchar(32) DEFAULT NULL COMMENT '人员id',
  PRIMARY KEY (zdhdjcryid),
  INDEX IDX_zdhdjcry_userid (userid),
  INDEX IDX_zdhdjcry_zdhddjid (zdhddjid)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '重大活动检查人员';

-----------------------------------------------------------------------------------------------------------------
CREATE DEFINER = 'root'@'%'
FUNCTION fun_getZdhdjcry(prm_zdhddjid varchar(32),prm_kind varchar(10))
  RETURNS varchar(500) CHARSET utf8
BEGIN
  DECLARE done INT DEFAULT 0; 
 

  DECLARE v_useridlist VARCHAR(500);#获取年月日时分秒
  DECLARE v_usernamelist varchar(500);
  DECLARE v_ret varchar(500);

  DECLARE v_userid varchar(32);
  DECLARE v_username varchar(30);
  DECLARE v_count int default 0;
  
  
  declare cur_zdhdjcry cursor for  
  SELECT 
    a.userid,
    b.DESCRIPTION
  from zdhdjcry a,sysuser b
  WHERE a.userid=b.userid 
    and a.zdhddjid=prm_zdhddjid;

  DECLARE continue handler for not found set done=1;


  open cur_zdhdjcry;
  mycomloop:loop
  fetch cur_zdhdjcry
  INTO v_userid,
       v_username;
    if done=1 then
      leave mycomloop;
    end if; 
    if v_count=0 then
      set v_useridlist=v_userid;
      set v_usernamelist=v_username;
    else
      set v_useridlist=concat(v_useridlist,',',v_userid);
      set v_usernamelist=concat(v_usernamelist,',',v_username);
    end if;

    set v_count=v_count+1;
  end loop mycomloop;
  close cur_zdhdjcry;

  if prm_kind='1' then
    set v_ret=v_useridlist;
  else
    set v_ret=v_usernamelist;
  end if;

  RETURN v_ret;

END


-----------------------------------------------------------------------------------------------------------------

INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016110911175025084979275', '', '重大活动保障管理', '', 1, '0', NULL, NULL, NULL, NULL, NULL, '1', '', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016110911202664022537362', '/zdhd/zdhddjMainIndex', '重大活动登记', '2016110911175025084979275', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'zdhddjMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016110911212718758527060', '/zdhd/zdhdjgjcMainIndex', '重大活动监管监察', '2016110911175025084979275', 1, '1', NULL, NULL, NULL, NULL, NULL, '1', 'zdhdjgjcMainIndex', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016111210522723887013564', '/zdhd/queryZdhddj', '重大活动登记查询', '2016110911202664022537362', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'queryZdhddj', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016111210545663839198972', '/zdhd/zdhddjFormIndex', '重大活动登记新增', '2016110911202664022537362', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'addZdhddj', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016111210555994375519245', '/zdhd/delZdhddj', '重大活动登记删除', '2016110911202664022537362', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'delZdhddj', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016111210565075163271756', '/zdhd/saveZdhddj', '重大活动登记保存', '2016110911202664022537362', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'saveZdhddj', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016111211014454373436740', '/zdhd/zdhddjFormIndex', '重大活动登记查看', '2016110911202664022537362', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'viewZdhddj', NULL, NULL, NULL, NULL, NULL, NULL, '', '');
INSERT INTO sysfunction(FUNCTIONID, LOCATION, TITLE, PARENT, ORDERNO, TYPE, DESCRIPTION, LOG, OWNER, ACTIVE, FUNCTIONCODE, VISIBLE, BIZID, ROLBIZCLASS, IMAGEURL, EXPANDEDIMAGEURL, AAA102, CAE005, ROLBIZABLE, TARGET, SYSTEMCODE) VALUES
('2016111211024819634153606', '/zdhd/zdhddjFormIndex', '重大活动登记修改', '2016110911202664022537362', 1, '2', NULL, NULL, NULL, NULL, NULL, '1', 'updateZdhddj', NULL, NULL, NULL, NULL, NULL, NULL, '', '');



ALTER TABLE bscheckmaster
  ADD COLUMN qtbwid VARCHAR(32) DEFAULT NULL COMMENT '其他表外ID' AFTER longitude,
  ADD COLUMN checkdatakind VARCHAR(10) DEFAULT NULL COMMENT '检查数据类型1企业检查2农村集体聚餐3重大活动' AFTER qtbwid;



INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411140298931798046', '2016051018315285615607502', 1, '食品重大活动检查', '食品重大活动检查', NULL, NULL, NULL, '', '2016-11-14 11:14:02', '2016052614593290514627369', 10);
INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411160904530369615', '2016111411140298931798046', 1, '食谱审查', '食谱审查', NULL, NULL, NULL, '', '2016-11-14 11:16:09', '2016052614593290514627369', 1);
INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411172011384473040', '2016111411140298931798046', 1, '餐饮具消毒情况检查', '餐饮具消毒情况检查', NULL, NULL, NULL, '', '2016-11-14 11:17:20', '2016052614593290514627369', 2);
INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411180944228817254', '2016111411140298931798046', 1, '凉菜加工检查', '凉菜加工检查', NULL, NULL, NULL, '', '2016-11-14 11:18:09', '2016052614593290514627369', 3);
INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411221254699971340', '2016111411140298931798046', 1, '食品烹调加工检查', '食品烹调加工检查', NULL, NULL, NULL, '', '2016-11-14 11:22:12', '2016052614593290514627369', 4);
INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411250367562029349', '2016111411140298931798046', 1, '备餐、供餐检查', '备餐、供餐检查', NULL, NULL, NULL, '', '2016-11-14 11:25:03', '2016052614593290514627369', 5);
INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411255465934700154', '2016111411140298931798046', 1, '从业人员个人卫生检查', '从业人员个人卫生检查', NULL, NULL, NULL, '', '2016-11-14 11:25:54', '2016052614593290514627369', 6);
INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411271109744504360', '2016111411140298931798046', 1, '食品存储检查', '食品存储检查', NULL, NULL, NULL, '', '2016-11-14 11:27:11', '2016052614593290514627369', 7);
INSERT INTO omcheckgroup(itemid, itempid, itemtype, itemname, itemdesc, itemext1, itemext2, itemext3, itemremark, operatedate, operateperson, itemsortid) VALUES
('2016111411413897111392006', '2016111411140298931798046', 1, '食品原材料粗加工检查', '食品原材料粗加工检查', NULL, NULL, NULL, '', '2016-11-14 11:41:38', '2016052614593290514627369', 8);



INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111509473465460212662', '2016111411180944228817254', '专用消毒设施：应设有供工具 、容器、手、水果和蔬菜等消毒的设施，并正常使用', '5', 0, 1, '2016-11-15 09:47:34', '2016052614593290514627369', 5);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512304801496788815', '2016111411180944228817254', '专用冷藏设施：凉菜间内应使用专用冷藏设施，以盛放凉菜和所用的食品原料', '6', 0, 1, '2016-11-15 12:30:48', '2016052614593290514627369', 6);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512323979732803282', '2016111411180944228817254', '操作人员进入专间前应更换洁净的工作衣帽，并将手洗净、消毒，工作时戴口罩', '7', 0, 1, '2016-11-15 12:32:39', '2016052614593290514627369', 7);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512344636136371008', '2016111411180944228817254', '每餐（或每次）使用前应进行空气和操作台的消毒。使用紫外线灯消毒的，应在无人工作时开启30分钟以上', '8', 0, 1, '2016-11-15 12:34:46', '2016052614593290514627369', 8);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512363898169301360', '2016111411180944228817254', '供加工凉菜用的蔬菜、水果等食品原料，未经清洗处理的，不得带入凉菜间', '9', 0, 1, '2016-11-15 12:36:38', '2016052614593290514627369', 9);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512390736357595975', '2016111411180944228817254', '制作好的凉菜应尽量当餐用完。剩余尚需使用的应存放于专用冰箱内冷藏或冷冻，食用前应充分加热后方可食用', '10', 0, 1, '2016-11-15 12:39:07', '2016052614593290514627369', 10);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512401588994392371', '2016111411180944228817254', '不得外购冷荤等凉菜', '11', 0, 1, '2016-11-15 12:40:15', '2016052614593290514627369', 11);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512410666151051108', '2016111411180944228817254', '室内温度应不高于25℃（检测）', '12', 0, 1, '2016-11-15 12:41:06', '2016052614593290514627369', 12);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512420206147991705', '2016111411180944228817254', '专用工具消毒液浓度（检测）', '13', 0, 1, '2016-11-15 12:42:02', '2016052614593290514627369', 13);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512422806944053492', '2016111411180944228817254', '冷藏设施内部温度（检测）', '14', 0, 1, '2016-11-15 12:42:28', '2016052614593290514627369', 14);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512430866581182565', '2016111411180944228817254', '操作人员手部消毒效果（检测）', '15', 0, 1, '2016-11-15 12:43:08', '2016052614593290514627369', 15);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512444441016937376', '2016111411221254699971340', '烹调场所内消毒后的餐用具应密闭保洁', '6', 0, 1, '2016-11-15 12:44:44', '2016052614593290514627369', 6);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512463822691328660', '2016111411221254699971340', '已盛装食品的容器不得直接置于地上，以防止食品污染', '7', 0, 1, '2016-11-15 12:46:38', '2016052614593290514627369', 7);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512494554129370970', '2016111411250367562029349', '无适当保存条件（温度低于60℃、高于10℃条件下），烹饪后至食用前存放时间不得超过2小时', '5', 0, 1, '2016-11-15 12:49:45', '2016052614593290514627369', 5);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512531125463935533', '2016111411250367562029349', '超过时间限制的食品应撤换。在烹饪后至食用前需要较长存放时间（超过2小时）存放的食品，应当在高于60℃或低于10℃的条件下存放（记录时间、检测温度）', '6', 0, 1, '2016-11-15 12:53:11', '2016052614593290514627369', 6);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512560108568338495', '2016111411250367562029349', '无适当保存条件存放时间超过2小时的熟食品，需再次利用的，应确认食品未变质后充分加热。加热时中心温度应高于70℃（检测）', '7', 0, 1, '2016-11-15 12:56:01', '2016052614593290514627369', 7);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512581947965749794', '2016111411250367562029349', '制作的现榨果蔬汁和水果拼盘，不得预先切配后放冰箱贮存，现榨果蔬汁和水果拼盘应当餐用完，不得隔餐供应', '8', 0, 1, '2016-11-15 12:58:19', '2016052614593290514627369', 8);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111512592219873605414', '2016111411250367562029349', '餐厅内桌、椅、台等应保持清洁', '9', 0, 1, '2016-11-15 12:59:22', '2016052614593290514627369', 9);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513042169539881751', '2016111411255465934700154', '应保持良好个人卫生，操作时应穿戴清洁的工作服、工作帽（专间操作人员还需戴口罩），头发不得外漏，不得留长指甲，涂指甲油，佩戴饰物；工作服应有清洗保洁制度，定期进行更换，保持清洁。接触直接入口食品人员的工作服应每天更换', '1 ', 0, 1, '2016-11-15 13:04:21', '2016052614593290514627369', 1);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513052719187657627', '2016111411255465934700154', '员工专用洗手消毒设施附近应有洗手消毒方法标示', '2', 0, 1, '2016-11-15 13:05:27', '2016052614593290514627369', 2);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513071255827143380', '2016111411255465934700154', '操作时手部应保持清洁，操作前手部应洗净。接触直接入口食品时，手部还应进行消毒', '3', 0, 1, '2016-11-15 13:07:12', '2016052614593290514627369', 3);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513154246691828564', '2016111411255465934700154', '接触直接入口食品的操作人员在有以下情形时应洗手：①开始工作前；②处理食物前；③上厕所后；④处理生食物后；⑤处理弄污的设备或饮食用具后；⑥咳嗽、打喷嚏、或擤鼻涕后；⑦处理动物或废物后；⑧触摸耳朵、鼻子、头发、口腔或身体其他部位后；⑨从事任何会污染双手活动（如处理货项，执行清洁任务）后。', '4', 0, 1, '2016-11-15 13:15:42', '2016052614593290514627369', 4);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513193221070396013', '2016111411255465934700154', '专间操作人员进入专间时应再次更换专间内专用工作衣帽并配戴口罩，操作前双手进行严格清洗消毒，操作中应适时地消毒双手。不得穿戴专间工作衣帽从事与专间内操作无关的工作', '5', 0, 1, '2016-11-15 13:19:32', '2016052614593290514627369', 5);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513205053890488350', '2016111411255465934700154', '个人衣物及私人物品不得带入食品处理区', '6', 0, 1, '2016-11-15 13:20:50', '2016052614593290514627369', 6);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513215062248554697', '2016111411255465934700154', '食品处理区内不得有抽烟、饮食及其他可能污染食品的行为', '7', 0, 1, '2016-11-15 13:21:50', '2016052614593290514627369', 7);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513230100011863608', '2016111411255465934700154', '进入食品处理区的非加工操作人员，应符合现场操作人员卫生要求', '8', 0, 1, '2016-11-15 13:23:01', '2016052614593290514627369', 8);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513261292982986200', '2016111411271109744504360', '贮存食品的场所、设备应当保持清洁，无霉斑、鼠迹、苍蝇、蟑螂，不得存放有毒、有害物品（如杀鼠剂、杀虫剂、洗涤剂、消毒剂等）及个人生活用品', '1', 0, 1, '2016-11-15 13:26:12', '2016052614593290514627369', 1);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513280706427750930', '2016111411271109744504360', '食品应当分类、分架存放，距离墙壁、地面均在10cm以上，并定期检查，及时清除变质和过期食品', '2', 0, 1, '2016-11-15 13:28:07', '2016052614593290514627369', 2);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513302222478483923', '2016111411271109744504360', '对库存食品使用应遵循先入先出、易腐先出的原则，新鲜的原辅料应尽快使用，缩短储存时间，以保持食品的鲜度和卫生质量', '3', 0, 1, '2016-11-15 13:30:22', '2016052614593290514627369', 3);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513364287974543731', '2016111411413897111392006', '加工前应认真检查待加工食品，对食品的色泽、形态、气味、滋味、组织状态等进行辨别，判断食品是否有异常的地方。定型包装食品包装完整，标签标识符和卫生要求，外观无异常，在保质期内；散装食品感官检查无异常。发现有腐败变质迹象，超过保质期或者其他感官性状异常，如生虫、发霉、有异味、色泽发生变化等均不得进行加工和使用', '1', 0, 1, '2016-11-15 13:36:42', '2016052614593290514627369', 1);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513385481285831669', '2016111411413897111392006', '动物性食品和植物性食品应分房间（或区域）加工，加工动物性食品和植物性食品的操作台、用具和容器宜分开，并有明显标志', '2', 0, 1, '2016-11-15 13:38:54', '2016052614593290514627369', 2);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513400960066077965', '2016111411413897111392006', '各种食品原料在使用前应洗净，肉类、水产品、蔬菜应分池清洗', '3', 0, 1, '2016-11-15 13:40:09', '2016052614593290514627369', 3);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513511080043936325', '2016111411413897111392006', '各种食品原料在清洗处理时要做到:蔬菜要择洗干净，无虫、无杂物异物、无泥沙，应先洗后切，已发芽的土豆要挖去芽眼并削去青绿色的皮肉；禽蛋在使用前应对外壳进行清洗，必要时进行消毒处理（如不需加热或加热温度及时间不足以让禽蛋熟化就食用时），加工时应逐个磕打在小容器内，感官检查无异常后方可放入大容器；禽类原料粗加工时要去净血污、气管、肺、嘴壳、爪皮、硬壳、舌尖、摘除尾脂腺和颈淋巴结；水产类粗加工时应防止鱼胆污染肉质', '4', 0, 1, '2016-11-15 13:51:10', '2016052614593290514627369', 4);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513533667026655752', '2016111411413897111392006', '用于原料、半成品、成品的工具和容器，应分开并有明显的区分标志；原料加工时切配的动物性和植物性食品的工具和容器，应分开并有明显的区分标志', '5', 0, 1, '2016-11-15 13:53:36', '2016052614593290514627369', 5);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513553280786994100', '2016111411413897111392006', '易腐食品应尽量缩短在常温下的存放时间，加工后应及时使用或冷藏', '6', 0, 1, '2016-11-15 13:55:32', '2016052614593290514627369', 6);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513574254476755570', '2016111411413897111392006', '切配好的半成品应避免污染，与原料分开存放，并应根据性质分类存放，在规定时间内使用', '7', 0, 1, '2016-11-15 13:57:42', '2016052614593290514627369', 7);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111513594761643656967', '2016111411413897111392006', '已盛装食品的容器不得直接置于地上，以防止食品污染', '8', 0, 1, '2016-11-15 13:59:47', '2016052614593290514627369', 8);
INSERT INTO omcheckcontent(contentid, itemid, content, contentcode, contentimpt, contentscore, contentoperatedate, contentoperateperson, contentsortid) VALUES
('2016111514023596262985530', '2016111411413897111392006', '加工用容器、工具使用后应及时洗净，定位存放，保持清洁，接触直接入口食品的容器、工具使用前应洗净并消毒，生熟食品的加工工具及容器应分开使用并有明显标志', '9', 0, 1, '2016-11-15 14:02:35', '2016052614593290514627369', 9);











