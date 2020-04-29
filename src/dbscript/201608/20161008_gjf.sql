CREATE  DEFINER = 'root'@'%'
FUNCTION fun_ShiFouKeYiAnJianBanLi(prm_ywlcid varchar(32),prm_userid varchar(32))
  RETURNS varchar(10) CHARSET utf8
BEGIN
  #判断当前操作员，是否可以查看或办理案件 0不可以操作1 可以操作
  DECLARE v_yewumcpym varchar(32);
  DECLARE v_ywbh  varchar(32);
  DECLARE v_ret VARCHAR(10);
  DECLARE v_count integer;
  SET v_count=0;
  SET v_ret='0';

  SELECT MAX(b.yewumcpym)  
  INTO v_yewumcpym
  from wf_ywlc a,wf_yewu_process b
  WHERE a.psbh=b.psbh
    AND a.ywlcid=prm_ywlcid;

  IF v_yewumcpym='zfbalc' THEN
    SELECT MAX(ywbh)
    INTO v_ywbh
    FROM wf_ywlc  t
    WHERE t.ywlcid=prm_ywlcid;

    SELECT COUNT(1)
    INTO v_count 
    FROM zfajcbr t
    WHERE t.ajdjid=v_ywbh
      AND t.userid=prm_userid;
  
    IF v_count>0 THEN
      SET v_ret='1';
    end IF;
  ELSE
    SET v_ret='1'; 
  end IF;

  RETURN v_ret;

END



CREATE DEFINER = 'root'@'%'
FUNCTION fun_ShiFouKeYiChaKanAnJian(prm_ajdjid varchar(32),prm_userid varchar(32))
  RETURNS varchar(10) CHARSET utf8
BEGIN
	#改为后台函数控制  思路 ：没有设置案件经办人时都可以看，设置后，只有增加的操作员或设置的经办人中存在在人员
	#才可以操作  范围0不可以看到 1可以看到 默认可以看到
  DECLARE v_count integer;
  DECLARE v_ret VARCHAR(10);

  set v_ret=0;

  SELECT COUNT(*)
  INTO v_count
  FROM zfajcbr aa
  WHERE aa.ajdjid=prm_ajdjid
    AND aa.userid=prm_userid;

  IF v_count=0 THEN
    SET v_ret=1;
  ELSE
    SELECT COUNT(*)
    INTO v_count
    FROM zfajcbr aa,zfajdj bb
    WHERE aa.ajdjid=bb.ajdjid
      AND aa.ajdjid=prm_ajdjid
      AND (bb.userid=prm_userid OR aa.userid=prm_userid);
    IF v_count>0 THEN
      SET v_ret=1;
    else
      SET v_ret=0;
    end IF;
  end IF;

  RETURN v_ret;

END




