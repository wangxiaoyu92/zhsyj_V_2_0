-- 按汤阴新需求，生产企业首页展示企业排序（汤阴需求）
UPDATE pcompany p set p.orderno = '9999' WHERE p.commc LIKE '%河南永达清真食品有限公司%';
UPDATE pcompany p set p.orderno = '9998' WHERE p.commc LIKE '%益海嘉里(安阳)食品工业有限公司%';
UPDATE pcompany p set p.orderno = '9997' WHERE p.commc LIKE '%安阳市诺金食品有限责任公司%';
UPDATE pcompany p set p.orderno = '9996' AND p.comspjkbz = '1' WHERE p.commc LIKE '%河南嘉士利食品有限公司%';
UPDATE pcompany p set p.orderno = '9995' WHERE p.commc LIKE '%安阳市健丰食品有限公司%';


-- 添加一个资质证明：为实现添加企业体系认证图片上传功能
call PRC_INSERTCODE('COMZZZM','资质证明','1','13','企业体系认证','199405',null,@P_CODE,@P_MSG); 



