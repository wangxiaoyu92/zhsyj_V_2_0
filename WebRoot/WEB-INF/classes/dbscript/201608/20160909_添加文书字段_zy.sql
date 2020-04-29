-- Alter table "zfwstzgzs22"
ALTER TABLE zfwstzgzs22
  ADD COLUMN tzgzslasj DATETIME DEFAULT NULL COMMENT '立案时间' AFTER tzgzcfyjyzgd,
  ADD COLUMN tzgzsay VARCHAR(255) DEFAULT NULL COMMENT '案由' AFTER tzgzslasj,
  ADD COLUMN tzgzszmnr VARCHAR(500) DEFAULT NULL COMMENT '证据所要证明内容' AFTER tzgzsay,
  ADD COLUMN xzjgmc VARCHAR(255) DEFAULT NULL COMMENT '行政机关名称' AFTER tzgzszmnr,
  ADD COLUMN czxzcfclbz VARCHAR(255) DEFAULT NULL COMMENT '参照行政处罚裁量标准' AFTER xzjgmc;

-- Alter table "zfwstztzs23"
ALTER TABLE zfwstztzs23
  ADD COLUMN tztzsay VARCHAR(255) DEFAULT NULL COMMENT '案由' AFTER tztzlxr,
  ADD COLUMN tztzsyqrq DATETIME DEFAULT NULL COMMENT '申请听证延期日期' AFTER tztzsay,
  ADD COLUMN tztzstzsqr VARCHAR(255) DEFAULT NULL COMMENT '听证申请人签字' AFTER tztzsyqrq,
  ADD COLUMN tztzstzsqrrq DATETIME DEFAULT NULL COMMENT '听证申请人签字或盖章日期' AFTER tztzstzsqr,
  ADD COLUMN xzjgmc VARCHAR(255) DEFAULT NULL COMMENT '行政机关名称' AFTER tztzstzsqrrq;

-- Alter table "zfwstzbl24"
ALTER TABLE zfwstzbl24
  ADD COLUMN tzbljlrqz VARCHAR(20) DEFAULT NULL COMMENT '记录人签字' AFTER tzblfddbr,
  ADD COLUMN tzbljlrqzrq DATETIME DEFAULT NULL COMMENT '记录人签字日期' AFTER tzbljlrqz;


-- Alter table "zfwsxzcfsxgzs26"
ALTER TABLE zfwsxzcfsxgzs26
  ADD COLUMN sxgzlasj DATETIME DEFAULT NULL COMMENT '立案时间' AFTER wfxwdc,
  ADD COLUMN sxgzay VARCHAR(255) DEFAULT NULL COMMENT '案由' AFTER sxgzlasj,
  ADD COLUMN sxgzzmnr VARCHAR(255) DEFAULT NULL COMMENT '证据所要证明内容' AFTER sxgzay,
  ADD COLUMN sxgzxzcfclbz VARCHAR(255) DEFAULT NULL COMMENT '行政处罚才俩裁量标准' AFTER sxgzzmnr,
  ADD COLUMN sxgzxzjgdz VARCHAR(255) DEFAULT NULL COMMENT '行政机关地址' AFTER sxgzxzcfclbz,
  ADD COLUMN sxgzyzbm VARCHAR(6) DEFAULT NULL COMMENT '邮政编码' AFTER sxgzxzjgdz,
  ADD COLUMN sxgzxzjglxr VARCHAR(20) DEFAULT NULL COMMENT '行政机关联系人' AFTER sxgzyzbm,
  ADD COLUMN sxgzlxdh VARCHAR(20) DEFAULT NULL COMMENT '联系电话' AFTER sxgzxzjglxr,
  ADD COLUMN xzjgmc VARCHAR(20) DEFAULT NULL COMMENT '行政机关名称' AFTER sxgzlxdh;

-- Alter table "zfwsxzcfjdspb27"
ALTER TABLE zfwsxzcfjdspb27
  ADD COLUMN cssbjtzqk VARCHAR(500) DEFAULT NULL COMMENT '陈述申辩及听证情况' AFTER cfspcbrqz2,
  ADD COLUMN dsrcssbqk VARCHAR(500) DEFAULT NULL COMMENT '事人陈述申辩或听证意见复核及采纳情况' AFTER cssbjtzqk,
  ADD COLUMN cbbmscyj VARCHAR(255) DEFAULT NULL COMMENT '承办部门审查意见' AFTER dsrcssbqk;


-- Alter table "zfwsxzcfjds28"
ALTER TABLE zfwsxzcfjds28
  ADD COLUMN zxjgmc VARCHAR(20) DEFAULT NULL COMMENT '行政机关名称' AFTER wfxwdc,
  ADD COLUMN gmsfhm VARCHAR(20) DEFAULT NULL COMMENT '公民身份号码' AFTER zxjgmc,
  ADD COLUMN syzmnr VARCHAR(500) DEFAULT NULL COMMENT '所要证明内容' AFTER gmsfhm,
  ADD COLUMN xzcfclbz VARCHAR(20) DEFAULT NULL COMMENT '行政处罚裁量标准' AFTER syzmnr,
  ADD COLUMN yhzh VARCHAR(20) DEFAULT NULL COMMENT '银行账号' AFTER xzcfclbz;


-- Alter table "zfwsdcxzcfjds29"
ALTER TABLE zfwsdcxzcfjds29
  ADD COLUMN xzjgmc VARCHAR(20) DEFAULT NULL COMMENT '行政机关名称' AFTER dccfyyzzbh,
  ADD COLUMN gmsfhm VARCHAR(20) DEFAULT NULL COMMENT '公民身份号码' AFTER xzjgmc,
  ADD COLUMN fkrmbdxqian VARCHAR(5) DEFAULT NULL COMMENT '罚款人民币大写千' AFTER gmsfhm,
  ADD COLUMN fkrmbdxbai VARCHAR(5) DEFAULT NULL COMMENT '罚款人民币大写百' AFTER fkrmbdxqian,
  ADD COLUMN fkrmbdxshi VARCHAR(5) DEFAULT NULL COMMENT '罚款人民币大写拾' AFTER fkrmbdxbai,
  ADD COLUMN fkrmbdxyuan VARCHAR(5) DEFAULT NULL COMMENT '罚款人民币大写元' AFTER fkrmbdxshi,
  ADD COLUMN fkrmbxx VARCHAR(10) DEFAULT NULL COMMENT '罚款人民币小写' AFTER fkrmbdxyuan,
  ADD COLUMN yhzh VARCHAR(20) DEFAULT NULL COMMENT '银行账号' AFTER fkrmbxx,
  ADD COLUMN yhhm VARCHAR(10) DEFAULT NULL COMMENT '银行户名' AFTER yhzh;

-- Alter table "zfwsmswppz30"
ALTER TABLE zfwsmswppz30
  ADD COLUMN xzjgmc VARCHAR(20) DEFAULT NULL COMMENT '行政机关名称' AFTER QZZZRMFY;


-- Alter table "zfwsmswpclqd31"
ALTER TABLE zfwsmswpclqd31
  ADD COLUMN xzjgmc VARCHAR(30) DEFAULT NULL COMMENT '行政机关名称' AFTER msclcbr2;

-- Alter table "zfwslxxzcfjdcgs32"
ALTER TABLE zfwslxxzcfjdcgs32
  ADD COLUMN xzjgmc VARCHAR(30) DEFAULT NULL COMMENT '行政机关名称' AFTER lxcgxjfkyh,
  ADD COLUMN dsrqz VARCHAR(20) DEFAULT NULL COMMENT '当事人签字' AFTER xzjgmc,
  ADD COLUMN dsrqzrq DATETIME DEFAULT NULL COMMENT '当事人签字日期' AFTER dsrqz,
  ADD COLUMN QZZZRMFY VARCHAR(30) DEFAULT NULL COMMENT '强制执行人民法院' AFTER dsrqzrq;

-- Alter table "zfwsxzcfqzzxsqs33"
ALTER TABLE zfwsxzcfqzzxsqs33
  ADD COLUMN xzjgmc VARCHAR(30) DEFAULT NULL COMMENT '行政机关名称' AFTER qzsqqzzznr;

-- Alter table "zfwswpqd37"
ALTER TABLE zfwswpqd37
  ADD COLUMN xzjgmc VARCHAR(30) DEFAULT NULL COMMENT '行政机关名称' AFTER wppddz;


-- Alter table "zfwsdshz38"
ALTER TABLE zfwsdshz38
  ADD COLUMN xzjgmc VARCHAR(30) DEFAULT NULL COMMENT '行政机关名称' AFTER sdhzgzrq;

