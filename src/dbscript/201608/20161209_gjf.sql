ALTER TABLE pwfxwcs
  CHANGE COLUMN wfxwms wfxwms VARCHAR(2000) DEFAULT NULL COMMENT '违法行为描述';


CREATE TABLE tabcomdaleitoxkzlx (
  AAA100 varchar(20) DEFAULT NULL COMMENT '代码类别',
  AAA102 varchar(30) DEFAULT NULL COMMENT '代码值',
  AAA103 varchar(200) DEFAULT NULL COMMENT '代码名称',
  AAE030 decimal(8, 0) DEFAULT NULL COMMENT '开始日期',
  AAE031 decimal(8, 0) UNSIGNED DEFAULT NULL COMMENT '终止日期',
  AAZ093 varchar(32) NOT NULL COMMENT '代码ID',
  AAZ094 varchar(32) DEFAULT NULL COMMENT '代码类别ID',
  AAA104 varchar(100) DEFAULT NULL COMMENT '附件：代表是否必传附件0不是1是；文书代表是否可编辑0不可编辑1可以编辑',
  AAA101 varchar(100) DEFAULT NULL COMMENT '暂时为了查询数据方便添加的,日后删除!',
  AAA105 varchar(50) DEFAULT NULL COMMENT '扩充用',
  xkzlx varchar(20) DEFAULT NULL COMMENT '企业大类对应的许可证类型'
)
ENGINE = INNODB
AVG_ROW_LENGTH = 910
CHARACTER SET utf8
COLLATE utf8_general_ci;




INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '15', '小摊贩', 199405, NULL, '2016060712523063730291709', '1400', '100', 'SPSC', '3', '4');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '16', '食品销售', 199405, NULL, '2016061416133465337209184', '1400', '100', 'SPSC', '2', '4');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '18', '医疗机构', 199405, NULL, '2016072017254313000995025', '1400', '200', 'YPSC', '0', '2');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '17', '学校食堂', 199405, NULL, '2016072017254360024964865', '1400', '100', '3', '3', '4');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '19', '保健品经营企业', 199405, NULL, '2016072017254484930083607', '1400', '400', '0', '0', '12');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '1', '食品生产企业', 20010101, NULL, '30636', '1400', '100', 'SPSC', '1', '3');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '2', '药品生产企业', 20010101, NULL, '30637', '1400', '200', 'YPSC', '0', '5');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '3', '保健品生产企业', 199405, NULL, '30962', '1400', '400', '0', '0', '11');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '4', '医疗器械生产企业', 199405, NULL, '30963', '1400', '500', '0', '0', '7');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '5', '化妆品生产企业', 199405, NULL, '30964', '1400', '300', '0', '0', '9');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '6', '食品批发企业', 199405, NULL, '30965', '1400', '100', '2', '2', '4');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '7', '食品零售企业', 199405, NULL, '30966', '1400', '100', '2', '2', '4');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '8', '药品批发企业', 199405, NULL, '30967', '1400', '200', 'YPSC', '0', '6');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '9', '药品零售企业', 199405, NULL, '30968', '1400', '200', 'YPSC', '0', '6');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '11', '医疗器械经营企业', 199405, NULL, '30970', '1400', '500', '0', '0', '8');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '12', '化妆品经营企业', 199405, NULL, '30971', '1400', '300', '0', '0', '10');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '13', '餐饮服务', 199405, NULL, '30972', '1400', '100', 'SPSC', '3', '4');
INSERT INTO tabcomdaleitoxkzlx(AAA100, AAA102, AAA103, AAE030, AAE031, AAZ093, AAZ094, AAA104, AAA101, AAA105, xkzlx) VALUES
('COMDALEI', '14', '食品小作坊', 199405, NULL, '30973', '1400', '100', 'SPSC', '1', '3');




CREATE DEFINER = 'root'@'%'
PROCEDURE prc_处理许可证信息(
  out prm_AppCode  int,
  out prm_ErrorMsg VARCHAR(500),
  out prm_comid varchar(50)
)
begin
label_pro:begin
  DECLARE done INT DEFAULT 0;     
  
  declare v_comid varchar(50);# 企业id
  declare v_comxkzbh varchar(50);# 许可证编号 
  declare v_comxkfw  varchar(500);# 许可范围  
  declare v_comxkyxqq date;# 许可有效期起 
  declare v_comxkyxqz date;# 许可有效期止
  declare v_comdalei varchar(50);#大类
  declare v_comxkzlx varchar(20);#许可证类型
  declare v_comxkzid varchar(50);
  declare v_count int;
                                                                         
  declare cur_com cursor for  
  SELECT 
    comid,
    comxkzbh,
    comxkfw,
    comxkyxqq,
    comxkyxqz
  from pcompany bc
  WHERE comxkzbh is not null 
    and comxkzbh<>''
    and not exists (select 1 from pcompanyxkz t where t.comxkzbh=bc.comxkzbh)
    and instr(bc.comxkzbh,'无')=0
    and instr(bc.comxkzbh,'有证')=0
    and instr(bc.comxkzbh,'未见')=0
    and instr(bc.comxkzbh,'正在办理')=0
    and instr(bc.comxkzbh,'办理中')=0
    and instr(bc.comxkzbh,'已办')=0
    and instr(bc.comxkzbh,'暂')=0
    and instr(bc.comxkzbh,'有')=0
    and instr(bc.comxkzbh,'过期')=0
    and instr(bc.comxkzbh,'停业')=0
    order by comxkzbh;
                                                      
  declare continue handler for not found set done=1;
  declare exit handler for sqlexception   #not found,sqlwarning,
  begin
    SELECT 'ERROR';
    set prm_AppCode=-1;
    set prm_ErrorMsg='过程出错了';
    rollback;
  end;
  set @@autocommit= 0;
  set prm_AppCode:=0;
  set prm_ErrorMsg:='成功';
  
  SET done=-1;
  open cur_com;
  mytableloop:loop
  fetch cur_com
  into 
   v_comid,
   v_comxkzbh,# 许可证编号 
   v_comxkfw,# 许可范围  
   v_comxkyxqq,# 许可有效期起 
   v_comxkyxqz; # 许可有效期止

    if done=1 then
      leave mytableloop;
    end if; 
    #许可证存在不在执行
    select count(*)
    into v_count
    from pcompanyxkz
    where comxkzbh=v_comxkzbh;

    if v_count=0 then
      select max(a.comdalei)
      into v_comdalei   
      from pcompanycomdalei a
      where a.comid=v_comid;
      
      select max(xkzlx)
      into v_comxkzlx
      from tabcomdaleitoxkzlx
      where aaa102=v_comdalei;   
               
      set v_comxkzid=f_getSequenceStr();   
                          
      set prm_comid=v_comid;

      INSERT INTO pcompanyxkz 
        (
          comxkzid,# varchar(32) NOT NULL DEFAULT '0' COMMENT '企业许可信息ID',
          comid,# varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
          comxkzbh,# varchar(50) DEFAULT NULL COMMENT '许可证编号',
          comxkfw,# varchar(4000) DEFAULT NULL COMMENT '许可范围',
          comxkyxqq,# date DEFAULT NULL COMMENT '许可有效期起',
          comxkyxqz,# date DEFAULT NULL COMMENT '许可有效期止',
          comxkzlx,# varchar(32) DEFAULT NULL COMMENT '许可证类型',
          comxkzzcxs,# varchar(50) DEFAULT NULL COMMENT '组成形式',
          comxkzztyt # varchar(200) DEFAULT NULL COMMENT '主题业态',                     
        )VALUES(
          v_comxkzid,# varchar(32) NOT NULL DEFAULT '0' COMMENT '企业许可信息ID',
          v_comid,# varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
          v_comxkzbh,# varchar(50) DEFAULT NULL COMMENT '许可证编号',
          v_comxkfw,# varchar(4000) DEFAULT NULL COMMENT '许可范围',
          v_comxkyxqq,# date DEFAULT NULL COMMENT '许可有效期起',
          v_comxkyxqz,# date DEFAULT NULL COMMENT '许可有效期止',
          v_comxkzlx,# varchar(32) DEFAULT NULL COMMENT '许可证类型',
          '',# varchar(50) DEFAULT NULL COMMENT '组成形式',
          '' # varchar(200) DEFAULT NULL COMMENT '主题业态',          
        );
      end if;
                                      
  end loop mytableloop;
  close cur_com;

  COMMIT;
       
end;
end


#调用过程
call prc_处理许可证信息(@a, @b,@comid);






