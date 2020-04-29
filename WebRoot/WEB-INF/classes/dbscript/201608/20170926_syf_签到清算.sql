CREATE TABLE syjzhptty170830.stat_signin_by_day (
  userid varchar(32) DEFAULT NULL COMMENT '用户ID',
  DESCRIPTION varchar(50) DEFAULT NULL COMMENT '用户描述',
  dwsj datetime DEFAULT NULL COMMENT '定位时间',
  signtime varchar(10) DEFAULT NULL,
  weekday int(1) DEFAULT NULL,
  yearweek int(2) DEFAULT NULL,
  status int(2) DEFAULT NULL COMMENT '迟到2,正常为1',
  statusdesc varchar(2) DEFAULT NULL,
  stattime datetime DEFAULT NULL COMMENT '统计时间'
)
ENGINE = INNODB
AVG_ROW_LENGTH = 161
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE TABLE log (
  userid_date varchar(255) DEFAULT NULL,
  logdesc varchar(255) DEFAULT NULL
)
ENGINE = INNODB
AVG_ROW_LENGTH = 79
CHARACTER SET utf8
COLLATE utf8_general_ci;




CREATE DEFINER = 'root'@'%'
PROCEDURE syjzhptty170830.prc_sign_in(IN prm_date varchar(12), OUT prm_AppCode int, OUT prm_ErrorMsg varchar(500))
BEGIN
  -- 本过程功能：按日期清算签到数据到stat_signin_by_day表
  -- 功能描述：
  --          1.清算缺卡  2.清算不缺卡但是只有一条打卡记录的  3.清算不缺卡但是有多条打卡记录的
  DECLARE done int DEFAULT 0;
  DECLARE v_stattime DATETIME DEFAULT NOW();
  DECLARE v_userid varchar(32);
  DECLARE v_user_desc varchar(500);
  DECLARE v_signin_time datetime;
  DECLARE v_temp_sign_time datetime;
  DECLARE v_signtime_str varchar(10);
  DECLARE v_weekday varchar(1);
  DECLARE v_yearweek varchar(2);
  DECLARE v_status varchar(1);
  DECLARE v_status_desc varchar(20);
  DECLARE v_is_signin int;
  DECLARE v_is_exist int;
  DECLARE cur_user CURSOR FOR
  SELECT
    s.USERID,
    s.DESCRIPTION
  FROM sysuser s
  WHERE s.AAA027 LIKE '410523%'
  AND s.ORGID IN (SELECT
      orgid
    FROM sysorg
    WHERE PARENT = '410523000000');
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION #not found,sqlwarning,
  SET done = - 1;
  SET @@autocommit = 0;
  SET prm_AppCode := - 1;
  SET prm_ErrorMsg := '失败';
  COMMIT;
  OPEN cur_user;
user_loop:
LOOP


  FETCH cur_user
  INTO
  v_userid, v_user_desc;
  IF done = 1 THEN
    LEAVE user_loop;
  END IF;
  SELECT
    COUNT(userid) INTO v_is_signin
  FROM sysuserdw t
  WHERE t.userid = v_userid and t.dwfs = '1'
  AND DATE_FORMAT(t.dwsj, '%Y-%m-%d') = prm_date;

  -- 如果没有签到记录 ，则记录却卡
  IF v_is_signin = 0
    THEN
       set v_signin_time = STR_TO_DATE(prm_date, '%Y-%m-%d');
       set v_signtime_str = prm_date;
       set v_weekday = DAYOFWEEK(STR_TO_DATE(prm_date, '%Y-%m-%d'));
       set v_yearweek = WEEKOFYEAR(STR_TO_DATE(prm_date, '%Y-%m-%d'));
       SET v_status = '3';
       SET v_status_desc = '缺卡';

  -- 签到每天签到一次的情况
  ELSEIF v_is_signin = 1 THEN

    SELECT
      q.userid,
      u.DESCRIPTION,
      q.dwsj,
      DATE_FORMAT(q.dwsj, '%Y-%m-%d'),
      DAYOFWEEK(q.dwsj),
      WEEKOFYEAR(q.dwsj),
      q.status,
      CASE q.status
          WHEN 1 THEN '正常'
          WHEN 2 THEN '迟到'
        END statusdesc INTO v_userid, v_user_desc, v_signin_time, v_signtime_str, v_weekday, v_yearweek, v_status, v_status_desc
    FROM sysuserdw q,
         sysuser u
    WHERE q.dwfs = '1' AND q.userid = u.USERID
    AND q.userid = v_userid
    AND DATE_FORMAT(q.dwsj, '%Y-%m-%d') = prm_date;

  -- 签到每天签到多次的情况
  ELSEIF v_is_signin >= 1 THEN

    SELECT DISTINCT
      q.userid,
      u.DESCRIPTION,
      q.dwsj,
      DATE_FORMAT(q.dwsj, '%Y-%m-%d'),
      DAYOFWEEK(q.dwsj),
      WEEKOFYEAR(q.dwsj),
      q.status,
      CASE q.status
          WHEN 1 THEN '正常'
          WHEN 2 THEN '迟到'
        END statusdesc INTO v_userid, v_user_desc, v_signin_time, v_signtime_str, v_weekday, v_yearweek, v_status, v_status_desc
    FROM sysuserdw q,
         sysuser u
    WHERE q.dwfs = '1' AND q.userid = u.USERID
    AND q.userid = v_userid
    AND q.dwsj = (
      SELECT
        MIN(dwsj)
      FROM sysuserdw s
      WHERE s.userid = v_userid AND s.dwfs = '1' AND DATE_FORMAT(dwsj, '%Y-%m-%d') = prm_date
    );
  END IF;

  SELECT COUNT(userid) INTO v_is_exist FROM stat_signin_by_day WHERE userid=v_userid AND signtime = v_signtime_str ;

  IF v_is_exist > 0
    THEN
    UPDATE stat_signin_by_day set STATUS =v_status , statusdesc = v_status_desc,stattime=v_stattime WHERE userid=v_userid AND signtime = v_signtime_str;

  ELSE
    INSERT INTO stat_signin_by_day
      VALUE (v_userid, v_user_desc, v_signin_time, v_signtime_str, v_weekday, v_yearweek, v_status, v_status_desc,v_stattime);
  END IF;
  COMMIT;

  INSERT INTO log VALUES(CONCAT_WS('-',v_userid,v_signtime_str),CONCAT_WS('-',v_is_signin,v_status_desc));
END LOOP user_loop;

  SET prm_AppCode := 0;
  SET prm_ErrorMsg := '成功';

  CLOSE cur_user;
END
