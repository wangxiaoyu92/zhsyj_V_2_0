drop function fun_获取comdm();

CREATE DEFINER = 'root'@'localhost'
FUNCTION fun_获取comdm()
  RETURNS varchar(40) CHARSET utf8
BEGIN
  declare v_maxcomdmh VARCHAR(20); 
  declare v_maxcomdm VARCHAR(20); 
    
    SELECT MAX(comdm) 
    INTO v_maxcomdm      
    FROM pcompany 
    WHERE SUBSTRING(comdm,1,1)='m';
        

    IF ISNULL(v_maxcomdm) THEN
      set v_maxcomdm="m00000001";
    end IF;
    


    SET v_maxcomdmh=SUBSTRING(v_maxcomdm,2);
    SET v_maxcomdmh=v_maxcomdmh+1;
    set v_maxcomdmh=RIGHT(CONCAT('00000000',v_maxcomdmh),8);

    SET v_maxcomdm=CONCAT('m',v_maxcomdmh);

    RETURN v_maxcomdm;

END;