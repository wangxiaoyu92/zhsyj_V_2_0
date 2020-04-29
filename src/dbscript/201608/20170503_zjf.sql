
ALTER TABLE pcompany add orderno VARCHAR(10) DEFAULT NULL COMMENT '显示序号';

ALTER TABLE pcomqrcode ADD qrcodepath VARCHAR(100) DEFAULT NULL COMMENT '二维码图片存放路径';