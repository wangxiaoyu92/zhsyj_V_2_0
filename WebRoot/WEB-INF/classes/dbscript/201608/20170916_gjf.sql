CREATE DEFINER = 'root'@'localhost'
FUNCTION fun_getcomxiaolei(prm_kind int, prm_comid varchar(32))
  RETURNS varchar(40) CHARSET utf8
BEGIN
  #获取企业大类 prm_kind=0 获取代码 1获取名称
  declare v_comxiaolei VARCHAR(100); 
  declare v_comxiaoleistr VARCHAR(100);
  declare v_ret VARCHAR(100);

  SELECT GROUP_CONCAT(a.comxiaolei),GROUP_CONCAT(b.aaa103)
  INTO v_comxiaolei,v_comxiaoleistr
  FROM pcomxiaolei a,
    (SELECT t.*  FROM aa10 t WHERE t.aaa100='COMXIAOLEI') b 
  WHERE a.comxiaolei=b.aaa102
    AND a.comid=prm_comid
    ORDER BY a.comxiaolei;

  IF prm_kind='0' THEN
    set v_ret=v_comxiaolei;
  else
    set v_ret=v_comxiaoleistr;
  end IF;

  RETURN v_ret;

END;




UPDATE pcompany p set p.comdaleiname=fun_getcomdalei('1',p.comid)  WHERE p.comdaleiname IS NULL OR comdaleiname='';

UPDATE pcompany p set p.comxiaoleiname=fun_getcomxiaolei('1',p.comid)  WHERE p.comxiaoleiname IS NULL OR comxiaoleiname='';


