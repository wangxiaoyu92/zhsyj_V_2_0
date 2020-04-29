CREATE
DEFINER = 'root'@'localhost'
VIEW viewcomfenlei
AS
SELECT
  `a`.`AAA100` AS `AAA100`,
  `a`.`AAA102` AS `AAA102`,
  `a`.`AAA103` AS `AAA103`,
  `a`.`AAE030` AS `AAE030`,
  `a`.`AAE031` AS `AAE031`,
  `a`.`AAZ093` AS `AAZ093`,
  `a`.`AAZ094` AS `AAZ094`,
  `a`.`AAA104` AS `AAA104`,
  `a`.`AAA101` AS `AAA101`,
  `a`.`AAA105` AS `AAA105`,
  `a`.`yxbz` AS `YXBZ`,
  (CASE
      WHEN (`a`.`AAA100` = _utf8 'COMDALEI') THEN _utf8 '1'
      WHEN (`a`.`AAA100` = _utf8 'COMXIAOLEI') THEN _utf8 '2' ELSE _utf8 '0'
    END) AS `treejibie`
FROM `aa10` `a`
WHERE ((`a`.`AAA100` = _utf8 'COMXIAOLEI') OR ((`a`.`AAA100` = _utf8 'COMDALEI') AND (`a`.`yxbz` = _utf8 '1')))
ORDER BY `a`.`AAA102`;

create view viewjycjcpfl
  as select a.parentchildid as viewjycjcpflid,
a.parentid,
      a.bh as cjcpbh,
      a.mc as cjcpmc,
      a.sfyx,
a.userid,
a.username,
a.czsj
      from parentchild a
      where a.parentchildlb='choujiancpfl'
      and a.sfyx='1';


CREATE DEFINER = 'root'@'%'
FUNCTION fun_sjComAddress(prm_sjdatacomid varchar(50))
  RETURNS varchar(100) CHARSET utf8

BEGIN
  DECLARE v_ret varchar(300);
  DECLARE v_com_address varchar(300);
  DECLARE v_xkz_jycs varchar(300);
  DECLARE v_xkz_zs varchar(300);
  DECLARE v_xkz_spjy_jycs varchar(300);

  set v_ret="";

  select com_address
    into v_com_address
    from bscompany
    where com_id=prm_sjdatacomid;

  select max(jycs),max(zs),max(spjy_jycs)
    into v_xkz_jycs,v_xkz_zs,v_xkz_spjy_jycs
    from bstyxkz a,bscompany b
    where a.com_dm=b.com_dm
    and b.com_id=prm_sjdatacomid;

  if (v_xkz_jycs is not null ) then
    set v_ret=v_xkz_jycs;
  elseif (v_xkz_zs is not null) then
        set v_ret=v_xkz_zs;
  elseif (v_xkz_jycs is not null ) then
        set v_ret=v_xkz_jycs;
  elseif (v_com_address is not null ) then
     set v_ret=v_com_address;
  end if;

  RETURN v_ret;
END;

CREATE DEFINER = 'root'@'localhost'
FUNCTION fun_getRiskLevel(prm_dengjicskind VARCHAR(10),prm_fenshu varchar(20))
  RETURNS varchar(100) CHARSET utf8
BEGIN
  DECLARE v_lhfjpddj VARCHAR(100);
  select ifnull(max(lhfjpddj),'') into v_lhfjpddj from bschecklhfjpjcs where dengjicskind=prm_dengjicskind and lhfjpdqsf<= prm_fenshu
    and lhfjpdjsf>=prm_fenshu;
  RETURN v_lhfjpddj;
END

CREATE DEFINER = 'root'@'localhost'
FUNCTION fun_getItemidFromPlanid(prm_planid VARCHAR(50))
  RETURNS varchar(100) CHARSET utf8
BEGIN
  DECLARE v_itemid VARCHAR(50);
  select max(b.itempid)
    into v_itemid
    from bscheckpicset a,omcheckgroup b
    where a.planid=prm_planid
      and a.itemid=b.itemid;

  RETURN v_itemid;
END

DROP FUNCTION IF EXISTS getResultbh;

CREATE DEFINER = 'root'@'%'
FUNCTION getResultbh(comdalei VARCHAR(32))
  RETURNS varchar(100) CHARSET utf8
BEGIN
DECLARE v_year VARCHAR(4);#获取年
  DECLARE v_seq varchar(10);#序号
DECLARE v_number varchar(5);
  declare v_ret varchar(25);#返回参数格式为2016-1-000001
  declare v_comdalei varchar(30);
  SELECT DATE_FORMAT(NOW(),'%Y')
  INTO v_year;
  SELECT lpad(nextval('SQ_RESULT_ID') ,6,'0') INTO v_seq;
  set v_comdalei=substring(comdalei,1,4);

		IF (v_comdalei ='1011') then#食品生产企业
		 set v_number ='1';
     ELSEIF ((comdalei ='1013') ) THEN#食品销售
		 set v_number ='2';
     ELSEIF ((comdalei ='1012') ) THEN#餐饮服务
		 set v_number ='3';
		 ELSEIF ((comdalei ='1041') ) THEN#保健品生产企业
		 set v_number ='4';
    end IF;
  SET v_ret=CONCAT(v_year,'-',v_number,'-',v_seq);
  RETURN v_ret;
END


CREATE FUNCTION f_getLonLatDistance(lon1 double,lat1 double,lon2 double,lat2 double,prm_scope double)
  RETURNS varchar(200) CHARSET utf8

BEGIN
-- 传入两个经纬度，算出距离

    declare vLon1,vLat1,vLon2,vLat2,distance,vShortLon,vShortLat double;

    declare vRlt double;

    set vLon1 = lon1;

    set vLat1 = lat1;



    set vlon2 = lon2;

    set vLat2 = lat2;

         set vRlt = ROUND(6378.138 * 2 * ASIN(SQRT(POW(SIN((lat1 * PI() / 180 - lat2 * PI() / 180) / 2),2) +
COS(lat1 * PI() / 180) * COS(lat2 * PI() / 180) * POW(SIN((lon1 * PI() / 180 - lon2 * PI() / 180) / 2),2))) * 1000
);


    if vRlt<=prm_scope then
      return '1';
    else
      return '0';
    end if;
  #  return vRlt;

end;




