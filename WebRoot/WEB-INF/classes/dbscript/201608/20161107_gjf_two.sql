
CREATE DEFINER = 'root'@'%'
FUNCTION fun_获取comdm()
  RETURNS varchar(40) CHARSET utf8
BEGIN
  declare v_maxcomdmh VARCHAR(20); 
  declare v_maxcomdm VARCHAR(20); 
    
    SELECT MAX(comdm) 
    FROM pcompany 
    INTO v_maxcomdm ;


    SET v_maxcomdmh=SUBSTRING(v_maxcomdm,2);
    SET v_maxcomdmh=v_maxcomdmh+1;
    set v_maxcomdmh=RIGHT(CONCAT('00000000',v_maxcomdmh),8);

    SET v_maxcomdm=CONCAT('m',v_maxcomdmh);

    RETURN v_maxcomdm;

END

update pcompany set comdm=concat('m000',substring(comdm,3)) where substring(comdm,1,2)='ty';
update sysuser set username=concat('m000',substring(username,3)) where substring(username,1,2)='ty';

----------------------------------------------------------------------------

CREATE TABLE bs_company (
  COM_ID bigint(20) NOT NULL DEFAULT 0 COMMENT '企业ID',
  COM_USER_NAME varchar(50) NOT NULL COMMENT '登录用户名',
  COM_PWD varchar(32) NOT NULL COMMENT '登录密码',
  COM_MC varchar(200) NOT NULL COMMENT '公司名称',
  COM_ZJHM varchar(100) NOT NULL COMMENT '营业执照号',
  COM_DM varchar(50) DEFAULT NULL COMMENT '企业代码：企业类型字母+6位行政区域代码+9位序列号',
  COM_LXR varchar(50) DEFAULT NULL COMMENT '联系人',
  COM_LXDH varchar(30) DEFAULT NULL COMMENT '联系固定电话',
  COM_ADDRESS varchar(200) DEFAULT NULL COMMENT '公司地址',
  COM_SHBZ varchar(1) DEFAULT 'Y' COMMENT '审核标志 Y通过 N未通过 M 等待审核',
  COM_SHRID bigint(20) DEFAULT NULL COMMENT '审核人ID(默认审核人ID=3)',
  COM_SHSJ datetime DEFAULT NULL COMMENT '审核时间',
  COM_QYLX varchar(100) DEFAULT NULL COMMENT '企业类型ID ：参照BS_QYLX',
  COM_QYXZ varchar(3) DEFAULT NULL COMMENT '1国有 2集体 3股份 4私营 5合资 6外资 7其他',
  COM_PROVINCE_DM varchar(8) DEFAULT NULL COMMENT '省份代码',
  COM_CITY_DM varchar(8) DEFAULT NULL COMMENT '市代码',
  COM_COUNTY_DM varchar(8) DEFAULT NULL COMMENT '县区代码',
  COM_WEB varchar(300) DEFAULT NULL COMMENT '网址',
  COM_EMAIL varchar(150) DEFAULT NULL COMMENT '电子邮件',
  COM_PROVINCE varchar(200) DEFAULT NULL COMMENT '省份名称',
  COM_CITY varchar(200) DEFAULT NULL COMMENT '市名称',
  COM_COUNTY varchar(200) NOT NULL COMMENT '县区名称',
  COM_WTGYY varchar(200) DEFAULT NULL COMMENT '审核未通过原因',
  COM_FAX varchar(20) DEFAULT NULL COMMENT '传真',
  COM_ZIP varchar(6) DEFAULT NULL COMMENT '邮编',
  COM_LXSJ varchar(20) DEFAULT NULL COMMENT '联系手机',
  COM_JJXZ varchar(50) DEFAULT NULL COMMENT '营业执照上的经济性质或者企业名称预核准上的的经济类型',
  COM_ZZJGDM varchar(50) DEFAULT NULL COMMENT '组织机构代码',
  COM_GSDJJG varchar(200) DEFAULT NULL COMMENT '营业执照上的登记机构全称',
  COM_CLRQ datetime DEFAULT NULL COMMENT '公司成立日期',
  COM_JYQX varchar(50) DEFAULT NULL COMMENT '营业执照上的经营期限',
  COM_ZCZJ bigint(20) DEFAULT NULL COMMENT '注册资金（万元）',
  COM_FDDBR varchar(50) DEFAULT NULL COMMENT '法定代表人',
  COM_ZCLB varchar(10) DEFAULT '1' COMMENT '1企业自行注册2 操作员添加注册',
  COM_DZCRID bigint(20) DEFAULT NULL COMMENT '代企业注册的操作人ID',
  COM_DZCSJ datetime DEFAULT NULL COMMENT '代注册时间',
  QYMC varchar(100) DEFAULT NULL COMMENT '企业名称',
  QYYWMC varchar(100) DEFAULT NULL COMMENT '企业英文名称',
  YLJGMC varchar(100) DEFAULT NULL COMMENT '医疗机构名称',
  ZZJGDM varchar(100) DEFAULT NULL COMMENT '组织机构代码',
  YYZZZCH varchar(100) DEFAULT NULL COMMENT '营业执照注册号',
  ZCZJ float(20, 2) DEFAULT NULL COMMENT '注册资金',
  tzzb float(20, 2) DEFAULT NULL COMMENT '投资资本',
  JYFS varchar(50) DEFAULT NULL COMMENT '经营方式',
  QYLX varchar(100) DEFAULT NULL COMMENT '企业类型',
  FDDBR varchar(50) DEFAULT NULL COMMENT '法定代表人',
  FRDB varchar(50) DEFAULT NULL COMMENT '法人代表',
  QYGM varchar(10) DEFAULT NULL COMMENT '企业规模',
  QYRS bigint(20) DEFAULT NULL COMMENT '企业人数',
  QYSJSJ datetime DEFAULT NULL COMMENT '企业始建时间',
  QYZJGMSJ datetime DEFAULT NULL COMMENT '企业最近更名时间',
  QYLXDHHM varchar(20) DEFAULT NULL COMMENT '企业联系电话号码',
  QYLXCZHM varchar(20) DEFAULT NULL COMMENT '企业联系传真号码',
  QYWZ varchar(200) DEFAULT NULL COMMENT '企业网址',
  QYFZRXM varchar(50) DEFAULT NULL COMMENT '企业负责人姓名',
  QYLXRXM varchar(50) DEFAULT NULL COMMENT '企业联系人姓名',
  ZCDZ varchar(200) DEFAULT NULL COMMENT '注册地址',
  ZCDZYW varchar(200) DEFAULT NULL COMMENT '注册地址(英文)',
  SCDZ varchar(200) DEFAULT NULL COMMENT '生产地址',
  SCDZYW varchar(200) DEFAULT NULL COMMENT '生产地址(英文)',
  TXDZ varchar(200) DEFAULT NULL COMMENT '通信地址',
  YZBM varchar(16) DEFAULT NULL COMMENT '邮政编码',
  DZGJHDQ varchar(70) DEFAULT '中国' COMMENT '地址-国家/或地区',
  DZSZXSZZQ varchar(70) DEFAULT '河南' COMMENT '地址-省/直辖市/自治区',
  DZSQZZZM varchar(70) DEFAULT '' COMMENT '地址-市/区/自治州/盟',
  DZXZZXXJS varchar(70) DEFAULT '' COMMENT '地址-县/自治县/县级市',
  DZXZJDBSC varchar(70) DEFAULT NULL COMMENT '地址-乡/镇/街道办事处',
  DZCJLND varchar(70) DEFAULT NULL COMMENT '地址-村/街/路/弄等',
  DZMPHM varchar(70) DEFAULT NULL COMMENT '地址-门牌号码',
  YPSCXKZBH varchar(50) DEFAULT NULL COMMENT '药品生产许可证编号',
  YPGMPZSBH varchar(50) DEFAULT NULL COMMENT '药品GMP证书编号',
  YPJYXKZH varchar(50) DEFAULT NULL COMMENT '药品经营许可证号',
  YPJYZLGLGFRZZSBH varchar(50) DEFAULT NULL COMMENT '药品经营质量管理规范认证证书编号',
  YLQXSCXKZH varchar(50) DEFAULT NULL COMMENT '医疗器械生产许可证号',
  FZJG varchar(100) DEFAULT NULL COMMENT '发证机关',
  FZRQ datetime DEFAULT NULL COMMENT '发证日期',
  ZJZSYXQQSRQ datetime DEFAULT NULL COMMENT '证件/证书有效期起始日期',
  ZJZSYXQZZRQ datetime DEFAULT NULL COMMENT '证件/证书有效期终止日期',
  CPZCDLJG varchar(200) DEFAULT NULL COMMENT '产品注册代理机构',
  CPDLR varchar(200) DEFAULT NULL COMMENT '产品代理人',
  CPSHFWJG varchar(200) DEFAULT NULL COMMENT '产品售后服务机构',
  WTYJJG varchar(200) DEFAULT NULL COMMENT '委托研究机构',
  QYZJBMMC varchar(100) DEFAULT NULL COMMENT '企业质监部门名称',
  QYZJBMGJJSZCRS bigint(20) DEFAULT NULL COMMENT '企业质监部门高级技术职称人数',
  QYZJBMZJJSZCRS bigint(20) DEFAULT NULL COMMENT '企业质监部门中级技术职称人数',
  QYZCDZYBHPZS bigint(20) DEFAULT NULL COMMENT '企业注册的中药保护品种数',
  GDZCYZ bigint(20) DEFAULT NULL COMMENT '固定资产原值',
  GDZCJZ bigint(20) DEFAULT NULL COMMENT '固定资产净值',
  SNDXSE float(20, 2) DEFAULT NULL COMMENT '上年度销售额',
  SNDLS float(20, 2) DEFAULT NULL COMMENT '上年度利税',
  SNGYZCZ bigint(20) DEFAULT NULL COMMENT '上年工业总产值',
  SNXSSR bigint(20) DEFAULT NULL COMMENT '上年销售收入',
  nxse_f float(20, 2) DEFAULT NULL COMMENT '连续三年销售额 第一年',
  nxse_s float(20, 2) DEFAULT NULL COMMENT '连续三年销售额 第二年',
  nxse_t float(20, 2) DEFAULT NULL COMMENT '连续三年销售额 第三年',
  SNLR float(20, 2) DEFAULT NULL COMMENT '上年利润',
  SNSJ bigint(20) DEFAULT NULL COMMENT '上年税金',
  SNCH bigint(20) DEFAULT NULL COMMENT '上年创汇',
  ZYJSRYBL bigint(20) DEFAULT NULL COMMENT '专业技术人员比例',
  ZLSQR varchar(50) DEFAULT NULL COMMENT '质量受权人',
  ZLFZR varchar(50) DEFAULT NULL COMMENT '质量负责人',
  ZLFZRS bigint(20) DEFAULT NULL COMMENT '质量负责人数',
  SCFZR varchar(50) DEFAULT NULL COMMENT '生产负责人',
  SCFZRS bigint(20) DEFAULT NULL COMMENT '生产负责人数',
  ZYYSRS bigint(20) DEFAULT NULL COMMENT '执业药师人数',
  ZRYSRS bigint(20) DEFAULT NULL COMMENT '主任药师人数',
  FZRYSRS bigint(20) DEFAULT NULL COMMENT '副主任药师人数',
  ZGYSRS bigint(20) DEFAULT NULL COMMENT '主管药师人数',
  YSRS01 bigint(20) DEFAULT NULL COMMENT '药师人数',
  YSRS02 bigint(20) DEFAULT NULL COMMENT '药士人数',
  CQZDMJ bigint(20) DEFAULT NULL COMMENT '厂区占地面积',
  JZMJ float(20, 2) DEFAULT NULL COMMENT '建筑面积',
  scmj float(20, 2) DEFAULT NULL COMMENT '生产面积',
  jhmj float(20, 2) DEFAULT NULL COMMENT '净化面积',
  jymj float(20, 2) DEFAULT NULL COMMENT '检验面积',
  yclccmj float(20, 2) DEFAULT NULL COMMENT '原材料仓储面积',
  cpccmj float(20, 2) DEFAULT NULL COMMENT '成品仓储面积',
  YLJGBZCWS bigint(20) DEFAULT NULL COMMENT '医疗机构编制床位数',
  QYZXBZ varchar(1) DEFAULT NULL COMMENT '企业注销标志',
  QYZXRQ datetime DEFAULT NULL COMMENT '企业注销日期',
  QYZXYY varchar(20) DEFAULT NULL COMMENT '企业注销原因',
  QYSSMGSMC varchar(100) DEFAULT NULL COMMENT '企业所属母公司名称',
  QYSSMGSDZ varchar(200) DEFAULT NULL COMMENT '企业所属母公司地址',
  WFGBHDQ varchar(50) DEFAULT NULL COMMENT '外方国别或地区',
  GYSMC varchar(100) DEFAULT NULL COMMENT '供应商名称',
  CPJXSMC varchar(100) DEFAULT NULL COMMENT '产品经销商名称',
  FDDBRSFZ varchar(50) DEFAULT NULL COMMENT '法定代表人身份证号',
  FDDBRLXDH varchar(50) DEFAULT NULL COMMENT '法定代表人联系电话',
  ZCLY varchar(10) DEFAULT '1' COMMENT '注册来源  1企业主动注册 2工商数据资料补齐生成',
  UUID varchar(40) DEFAULT NULL COMMENT 'UUID',
  LX_DL varchar(200) DEFAULT NULL COMMENT '企业类型所属的大类，对应bs_qylxl中的x_dl',
  zjlx char(2) DEFAULT NULL COMMENT '证件类型 01 社会信用代码 02 营业执照号 03身份证',
  zycp varchar(500) DEFAULT NULL COMMENT '主要产品',
  ncl varchar(100) DEFAULT NULL COMMENT '年产量',
  doflag varchar(2) DEFAULT '0' COMMENT '处理标识',
  PRIMARY KEY (COM_ID),
  INDEX idx_com_user_name (COM_USER_NAME),
  UNIQUE INDEX IDX_COMDM (COM_DM),
  INDEX IDX_COUNTRY_DM (COM_COUNTY_DM),
  INDEX IDX_SHBZ (COM_SHBZ),
  UNIQUE INDEX IDX_UUID (UUID)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 532
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '公司企业表';


---------------------------------------------------------------------------------------------------------------

CREATE TABLE bs_tyxkz (
  ID bigint(20) NOT NULL AUTO_INCREMENT,
  COM_DM varchar(50) NOT NULL COMMENT '企业代码',
  XKZBH varchar(200) NOT NULL COMMENT '许可证编号',
  SQ_SQBH varchar(20) NOT NULL COMMENT '对应申请编号',
  YYZZH varchar(30) DEFAULT NULL COMMENT '营业执照号',
  ZZJGDM varchar(50) DEFAULT NULL COMMENT '组织机构代码',
  XKZ_FZRQ date NOT NULL COMMENT '发证日期',
  XKZ_YXQ int(11) NOT NULL DEFAULT 5 COMMENT '有效期',
  XKZ_YXQZ date NOT NULL COMMENT '有效期止',
  XKZ_SFZX varchar(1) DEFAULT 'N' COMMENT '是否注销 Y是 N否',
  XKZ_ZXYY varchar(200) DEFAULT NULL COMMENT '注销原因',
  XKZ_ZXSJ datetime DEFAULT NULL COMMENT '注销时间',
  XKZ_XKLB varchar(20) DEFAULT NULL COMMENT '许可类别（对应代码表 dm_dmlb=XKZLB）',
  xkz_xkzlbbz varchar(10) DEFAULT NULL COMMENT '许可证类别标注(1,食品添加剂 2 食品 .....)',
  XKZ_BZ varchar(200) DEFAULT NULL COMMENT '备注',
  CPMC varchar(100) DEFAULT NULL COMMENT '产品名称',
  CPGG varchar(200) DEFAULT NULL COMMENT '产品规格、型号',
  YLQXXNJGJZC varchar(1000) DEFAULT NULL COMMENT '结构及组成',
  CPSYFW varchar(1000) DEFAULT NULL COMMENT '适用范围',
  CPJSYQ varchar(1000) DEFAULT NULL COMMENT '产品技术要求',
  QY_SCDZ varchar(200) DEFAULT NULL COMMENT '企业生产地址',
  qy_lxdh varchar(20) DEFAULT NULL COMMENT '企业联系电话',
  QY_SCDZ_YZBM varchar(16) DEFAULT NULL COMMENT '企业生产地址邮政编码',
  BJP_SCPZ varchar(200) DEFAULT NULL COMMENT '保健品生产品种',
  BJP_XKFW varchar(200) DEFAULT NULL COMMENT '保健品许可范围',
  CCTJ varchar(200) DEFAULT NULL COMMENT '存储条件',
  CPYQYT varchar(200) DEFAULT NULL COMMENT '产品预期用途',
  CPYXQ varchar(10) DEFAULT NULL COMMENT '产品有效期',
  SQ_HZ_SZDYBH varchar(100) DEFAULT NULL COMMENT '经核准后的申请单元编号(申请单元编号) 多个以,分隔',
  SFJYSQ varchar(1) DEFAULT '0' COMMENT '是否检验申请',
  OS_VER bigint(20) DEFAULT 0 COMMENT '操作版本号',
  OS_YXBZ varchar(1) DEFAULT '1' COMMENT '有效标志 1有  0无',
  OS_SJ date DEFAULT NULL COMMENT '操作时间',
  BG_VER varchar(5) DEFAULT NULL COMMENT '检测报告版本号',
  OS_VER_LAST bigint(20) DEFAULT 0 COMMENT '上一步操作版本号',
  xkz_fzjg varchar(50) DEFAULT '河南省食品药品监督管理局' COMMENT '许可证发证机关',
  JYXM varchar(2000) DEFAULT NULL COMMENT '认证/经营项目或经营范围',
  jyxmyw varchar(200) DEFAULT NULL COMMENT '认证/经营范围或项目-英文',
  ZTXT char(1) NOT NULL DEFAULT '9' COMMENT '主体业态',
  FZRQ date DEFAULT NULL COMMENT '发证日期',
  FZJG varchar(100) DEFAULT NULL COMMENT '发证机关',
  qfr varchar(50) DEFAULT NULL COMMENT '签发人',
  FBS int(2) DEFAULT NULL COMMENT '副本数',
  YXQXZ date DEFAULT NULL COMMENT '有效期限自',
  YXQXZ01 date DEFAULT NULL COMMENT '有效期限至',
  SFSQJTYCPS tinyint(4) DEFAULT NULL COMMENT '是否申请集体用餐配送',
  SFSQWLJY char(1) DEFAULT NULL COMMENT '是否申请网络经营',
  SFSQJLZYCF tinyint(4) DEFAULT NULL COMMENT '是否申请建立中央厨房',
  JYCS varchar(100) DEFAULT NULL COMMENT '经营场所',
  ZS varchar(100) DEFAULT NULL COMMENT '住所',
  zsyw varchar(100) DEFAULT NULL COMMENT '住所英文',
  FDDBR varchar(100) DEFAULT NULL COMMENT '法定代表人',
  fddbr_id bigint(20) DEFAULT NULL COMMENT '法定代表人id',
  fddbrsfzh varchar(30) DEFAULT NULL COMMENT '法定代表人身份证号',
  fddbrlxdh varchar(200) DEFAULT NULL COMMENT '法定代表人联系电话',
  fax varchar(20) DEFAULT NULL COMMENT '传真电话',
  zip varchar(10) DEFAULT NULL COMMENT '邮政编码',
  COM_MC varchar(50) DEFAULT NULL COMMENT '企业名称',
  COM_MCYW varchar(50) DEFAULT NULL COMMENT '企业名称英文',
  QYWZ varchar(50) DEFAULT NULL COMMENT '企业网址',
  rcjdgljg varchar(50) DEFAULT NULL COMMENT '日常监督管理机构',
  rcjdglry varchar(50) DEFAULT NULL COMMENT '日常监督管理人员',
  xkz_zxzt varchar(1) DEFAULT NULL,
  spjy_jycs varchar(200) DEFAULT NULL COMMENT '食品经营，经营场所地址',
  spjy_ckdz varchar(200) DEFAULT NULL COMMENT '食品经营，仓库地址',
  spjy_fzr_id varchar(20) DEFAULT NULL COMMENT '食品经营，负责人id',
  spjy_ztlx varchar(20) DEFAULT NULL COMMENT '食品经营,主体类型',
  spjy_jylb varchar(200) DEFAULT NULL COMMENT '食品经营，经营类别',
  spjy_jyqx varchar(20) DEFAULT NULL COMMENT '食品经营，经营期限',
  spjy_jymj varchar(20) DEFAULT NULL COMMENT '食品经营，经营面积',
  spjy_jyxm varchar(200) DEFAULT NULL COMMENT '食品经营，经营项目',
  xkz_tjdylcbz varchar(2) DEFAULT '0' COMMENT '提交打印流程标志0否1是',
  YPJY_JYFW varchar(50) DEFAULT NULL COMMENT '药品经营,经营范围',
  YPJY_FDDBR varchar(20) DEFAULT NULL COMMENT '药品经营,法定代表人',
  YPJY_QYFZR varchar(20) DEFAULT NULL COMMENT '药品经营，企业负责人',
  YPJY_ZLFZR varchar(20) DEFAULT NULL COMMENT '药品经营，质量负责人',
  YPJY_JYFS varchar(20) DEFAULT NULL COMMENT '药品经营，经营方式',
  YPJY_ZCDZ varchar(100) DEFAULT NULL COMMENT '药品经营，注册地址',
  YPJY_CKDZ varchar(100) DEFAULT NULL COMMENT '药品经营，仓库地址',
  YPJY_QYMC varchar(50) DEFAULT NULL COMMENT '药品经营，企业名称',
  qyfzr varchar(50) DEFAULT NULL COMMENT '企业负责人',
  ylqxjy_ckdz varchar(100) DEFAULT NULL COMMENT '医疗器械经营仓库地址',
  zlglr varchar(50) DEFAULT NULL COMMENT '质量管理人',
  ylqxsc_zcdz varchar(50) DEFAULT NULL COMMENT '医疗器械生产注册地址',
  xkz_qylx varchar(10) DEFAULT NULL COMMENT '企业类型',
  JYFS varchar(20) DEFAULT NULL COMMENT '经营方式',
  JYMS varchar(50) DEFAULT NULL COMMENT '经营模式',
  ZCZB int(11) DEFAULT NULL COMMENT '注册资本（万元）',
  yljgzjxk_yljgmc varchar(100) DEFAULT NULL COMMENT '医疗机构名称',
  yljgzjxk_zcdz varchar(500) DEFAULT NULL COMMENT '注册地址',
  yljgzjxk_lxr varchar(20) DEFAULT NULL COMMENT '联系人',
  yljgzjxk_lxr_dh varchar(20) DEFAULT NULL COMMENT '联系人电话',
  yljgzjxk_jglx varchar(20) DEFAULT NULL COMMENT '机构类型',
  yljgzjxk_fddbr varchar(20) DEFAULT NULL COMMENT '法定代表人',
  yljgzjxk_fgyz varchar(20) DEFAULT NULL COMMENT '分管院长',
  yljgzjxk_pzdz varchar(500) DEFAULT NULL COMMENT '配制地址',
  yljgzjxk_pzfw varchar(500) DEFAULT NULL COMMENT '配置范围',
  spjy_ybzsp char(1) DEFAULT NULL COMMENT '食品经营预包装食品详细',
  spjy_szsp char(1) DEFAULT NULL COMMENT '食品经营散装食品详细',
  spjy_tssp varchar(20) DEFAULT NULL COMMENT '食品经营特殊食品详细',
  spjy_szss varchar(20) DEFAULT NULL COMMENT '食品经营散装熟食',
  spjy_zzyp varchar(20) DEFAULT NULL COMMENT '食品经营自制饮品酿酒',
  spjy_sxryp varchar(20) DEFAULT NULL COMMENT '食品经营生鲜乳饮品',
  spjy_bhdg varchar(20) DEFAULT NULL COMMENT '食品经营裱花蛋糕',
  spjy_qtsp varchar(200) DEFAULT NULL COMMENT '食品经营其他食品销售',
  spjy_qtzs varchar(200) DEFAULT NULL COMMENT '食品经营其他食品制售',
  spjy_rslnr varchar(200) DEFAULT NULL,
  spjy_lslnr varchar(200) DEFAULT NULL,
  spjy_sslnr varchar(200) DEFAULT NULL,
  spjy_gdlnr varchar(200) DEFAULT NULL,
  spjy_zzypnr varchar(200) DEFAULT NULL,
  zjlx varchar(10) DEFAULT NULL COMMENT '证件类型 01 社会信用代码 02 营业执照号 03身份证',
  sfks char(1) DEFAULT 'N' COMMENT '是否快速申请 Y是 N否',
  xzqh varchar(10) DEFAULT NULL COMMENT '行政区划',
  sfxx varchar(10) DEFAULT NULL COMMENT '是否学校',
  yxkzbh varchar(500) DEFAULT '' COMMENT '原许可证号',
  sqtjdqx varchar(10) DEFAULT NULL COMMENT '申请提交地区县区',
  sqtjdqs varchar(10) DEFAULT NULL COMMENT '申请提交地区市区',
  yjsj varchar(10) DEFAULT '0' COMMENT '永杰数据1 非永杰数据0',
  yljgzjxk_zjsfzr varchar(50) DEFAULT NULL COMMENT '医疗机构制剂制剂室负责人',
  zzywlx char(1) DEFAULT NULL COMMENT '最终业务类型 记录业务类型 新办 1  变更 2  延续3 .。。。',
  DYZT char(1) DEFAULT '0' COMMENT '打印状态  0 默认（未打印） 1 已打印 2老数据',
  SPXKZBGRQ date DEFAULT NULL,
  bz_zb int(5) DEFAULT 0 COMMENT '正本打印状态：0、未打印；1、打印完成',
  bz_fb int(5) DEFAULT 0 COMMENT '副本打印状态：0、未打印；1、打印完成',
  bz_mx int(5) DEFAULT 0 COMMENT '明细打印状态：0、未打印；1、打印完成',
  qy_location varchar(100) DEFAULT NULL COMMENT '企业位置',
  xkzbh_xh varchar(10) DEFAULT NULL COMMENT '许可证编号的序号-取得序列号',
  spjy_sfdj char(1) DEFAULT '0' COMMENT '食品经营数据是否对接 0 未对接  1 已对接 2 变更未更新  3 延续未更新  4 注销未更新',
  PRIMARY KEY (ID),
  INDEX idx_sfzx (XKZ_SFZX),
  INDEX index_comDm (COM_DM),
  INDEX index_commc (COM_MC),
  INDEX index_sqtjs (sqtjdqs),
  INDEX index_xh (xkzbh_xh),
  INDEX index_xklb (XKZ_XKLB),
  UNIQUE INDEX un_sqbh (SQ_SQBH),
  UNIQUE INDEX un_xkzbh (XKZBH)
)
ENGINE = INNODB
AUTO_INCREMENT = 272462
AVG_ROW_LENGTH = 1879
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '通用许可证表';


---------------------------------------------------------------------------------

CREATE TABLE bs_daima (
  ID bigint(20) NOT NULL AUTO_INCREMENT,
  DM_DMLB varchar(40) DEFAULT NULL COMMENT '代码类别',
  DM_DMZ varchar(20) DEFAULT NULL COMMENT '代码值',
  DM_DMMC varchar(300) DEFAULT NULL COMMENT '代码名称',
  DM_KSRQ varchar(8) DEFAULT NULL COMMENT '开始日期',
  DM_ZZRQ varchar(8) DEFAULT NULL COMMENT '终止日期',
  DM_ID bigint(20) NOT NULL DEFAULT 0 COMMENT '代码明细表ID',
  DM_QYFLAG varchar(1) DEFAULT '1' COMMENT '启用标志1启用0未启用',
  DM_DMLBMC varchar(300) DEFAULT NULL COMMENT '代码类别名称',
  DM_DMMCJX varchar(50) DEFAULT NULL COMMENT '代码名称简写',
  DM_FJBC varchar(1) DEFAULT '0' COMMENT '附件上传类型专用0不是必须传1必须传',
  DM_PR_DMZ varchar(20) DEFAULT NULL COMMENT '父级代码值',
  duiyingzhi varchar(10) DEFAULT NULL COMMENT '对应地市项目中的代码值',
  PRIMARY KEY (ID),
  UNIQUE INDEX idx_bs_daima (DM_DMLB, DM_DMZ),
  INDEX index_dm_bc (DM_FJBC),
  INDEX index_dm_dmlb (DM_DMLB),
  INDEX index_dm_dmz (DM_DMZ),
  INDEX INDEX_DM_FJBC (DM_FJBC),
  INDEX index_dm_id (DM_ID)
)
ENGINE = INNODB
AUTO_INCREMENT = 3003
AVG_ROW_LENGTH = 165
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '代码明细表';

INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(1096, 'XKZLB', '1', '食品生产许可证', NULL, NULL, 2137, '1', '许可证类别', 'SPSC', '0', NULL, '3');
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2424, 'XKZLB', '10', '医疗器械生产许可证', NULL, NULL, 5243, '1', '许可证类别', 'YLQXSC', '0', NULL, '7');
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2819, 'XKZLB', '100', '医疗机构制剂许可证(未经验证)', NULL, NULL, 5666, '1', '许可证类别', 'YLQXSCW', '0', NULL, NULL);
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2469, 'XKZLB', '11', '二类医疗器械经营备案凭证', NULL, NULL, 5302, '1', '许可证类别', 'YLQXJY', '0', NULL, NULL);
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2482, 'XKZLB', '12', '医疗机构制剂许可证', NULL, NULL, 5316, '1', '许可证类别', 'YLJG', '0', NULL, NULL);
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2483, 'xkzlb', '13', '医疗机构制剂批准文号', NULL, NULL, 5317, '1', '许可证类别', 'YLJG', '0', NULL, NULL);
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2491, 'xkzlb', '14', 'GMP许可证号', NULL, NULL, 5325, '1', '许可证类别', NULL, '0', NULL, NULL);
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(1095, 'XKZLB', '2', '食品经营许可证', NULL, NULL, 2136, '1', '许可证类别', 'SPJY', '0', NULL, '4');
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2492, 'xkzlb', '20', 'GSP认证许可', NULL, NULL, 5326, '1', '许可证类别', NULL, '0', NULL, NULL);
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(1094, 'XKZLB', '3', '药品生产许可证', NULL, NULL, 2135, '1', '许可证类别', 'YPSC', '0', NULL, '5');
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(1093, 'XKZLB', '4', '医疗器械注册许可证', NULL, NULL, 2134, '1', '许可证类别', 'YLQXSC', '0', NULL, NULL);
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2181, 'XKZLB', '5', '保健品生产许可证', NULL, NULL, 4955, '1', '许可证类别', 'BJPSC', '0', NULL, '11');
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2270, 'XKZLB', '6', '化妆品生产许可证', NULL, NULL, 5060, '1', '许可证类别', 'HZP', '0', NULL, '9');
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2291, 'XKZLB', '7', '体外诊断试剂许可证', NULL, NULL, 5084, '1', '许可证类别', 'YLQXSC', '0', NULL, NULL);
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2338, 'XKZLB', '8', '药品经营许可证', NULL, NULL, 5139, '1', '许可证类别', NULL, '0', NULL, '6');
INSERT INTO bs_daima(ID, DM_DMLB, DM_DMZ, DM_DMMC, DM_KSRQ, DM_ZZRQ, DM_ID, DM_QYFLAG, DM_DMLBMC, DM_DMMCJX, DM_FJBC, DM_PR_DMZ, duiyingzhi) VALUES
(2339, 'XKZLB', '9', '医疗器械经营许可证', NULL, NULL, 5140, '1', '许可证类别', 'YLQXJY', '0', NULL, '8');
----------------------------------------------------------------------


CREATE TABLE bs_qylx (
  LX_ID bigint(20) NOT NULL DEFAULT 0,
  LX_MC varchar(200) DEFAULT NULL COMMENT '企业类型名称',
  LX_DM varchar(40) DEFAULT NULL COMMENT '企业类型代码',
  LX_FL varchar(20) DEFAULT NULL COMMENT '类型分类：方便登录后带出相应权限的申请菜单',
  LX_DL varchar(20) DEFAULT NULL COMMENT '类型所属的大类：如食品生产 食品经营',
  comdalei varchar(40) DEFAULT NULL COMMENT '地市项目中对应的企业大类',
  PRIMARY KEY (LX_ID)
)
ENGINE = INNODB
AVG_ROW_LENGTH = 910
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = '企业类型';


INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(1, '生产企业--食品', 'SCSP', 'SC_SP', 'SPSC', '1');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(2, '生产企业--药品', 'SCYP', 'SC_YP', 'YPSC', '2');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(3, '生产企业--医疗器械', 'SCQX', 'SC_YLQX', 'YLQXSC', '4');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(4, '生产企业--化妆品', 'SCHZ', 'SC_HZP', 'HZP', '5');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(5, '经营企业--食品批发', 'JYSP', 'SPJY_PF', 'SPJY', '6');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(6, '经营企业--食品零售', 'JYSL', 'SPJY_LS', 'SPJY', '7');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(7, '经营企业--食品批发兼零售', 'JYPL', 'SPJY_PFLS', 'SPJY', '7');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(8, '经营企业--药品批发', 'JYYP', 'YPJY_PF', 'YPJYPF', '8');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(9, '经营企业--药品零售', 'JYYL', 'YPJL_LS', 'YPJYLS', '9');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(10, '经营企业--医疗器械', 'JYQX', 'YLQXJY', 'YLQXJY', '11');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(11, '经营企业--药品零售连锁', 'JYLS', 'YLQXJY_LSLS', 'YPJYLS', '7');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(12, '医疗机构', 'YLJG', 'YLJG', 'YLJG', '18');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(13, '经营企业--餐饮服务', 'JYCY', 'SPJY_CY', 'SPJY', '13');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(14, '生产企业--食品添加剂', 'SCTJ', 'SC_SPTJJ', 'SPSC', '1');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(15, '生产企业--保健品', 'SCBJ', 'SC_BJP', 'BJPSC', '3');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(16, '生产企业--体外诊断试剂', 'SCTW', 'SC_TWZDSJ', 'YLQXSC', '2');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(17, '执业药师', 'ZYYS', 'ZYYS_PERSON', 'ZYYS', '');
INSERT INTO bs_qylx(LX_ID, LX_MC, LX_DM, LX_FL, LX_DL, comdalei) VALUES
(18, '永杰-生产企业', 'YJSC', 'YJSC', 'YJSC', NULL);

---------------------------------------------------------------------------------------


CREATE DEFINER = 'root'@'%'
PROCEDURE syjzhptzmd3.prc_转移行政审批单位表b(
  in prm_orgid varchar(32),
  out prm_AppCode  int,
  out prm_ErrorMsg VARCHAR(500)
)
begin
label_pro:begin
  DECLARE done INT DEFAULT 0;     

  DECLARE v_count INT;
  DECLARE v_newcomid varchar(32);
  DECLARE v_newcomdm varchar(32);
  DECLARE v_newcomxkzid varchar(32);   
  DECLARE v_newcomdaleiid varchar(32);          
                       
  
  DECLARE v_COM_id varchar(200);
  DECLARE v_COM_dm varchar(200);
  DECLARE v_COM_MC varchar(200);
  DECLARE v_COM_ADDRESS varchar(200);
  DECLARE v_com_qylx varchar(200);
  DECLARE v_COM_FDDBR varchar(200);
  DECLARE v_COM_LXDH varchar(200);
  DECLARE v_COM_LXSJ varchar(200);
  DECLARE v_YYZZZCH varchar(200);
  DECLARE v_COM_CLRQ varchar(200);
  DECLARE v_ZJZSYXQQSRQ varchar(200);
  DECLARE v_COM_COUNTY_DM varchar(200);  
  DECLARE v_ZJZSYXQZZRQ varchar(200);
                         
              
      
  DECLARE v_xkz_xklb varchar(200);
  DECLARE v_XKZBH varchar(200);   
  DECLARE v_XKZ_FZRQ varchar(200);
  DECLARE v_XKZ_YXQZ varchar(200);  
  DECLARE v_JYXM varchar(200);
  DECLARE v_ZTXT varchar(200);  
  DECLARE v_YLQXXNJGJZC varchar(200);                                                                      
  
  declare cur_com cursor for  
  SELECT 
    a.COM_id,
    a.COM_DM,
    a.COM_MC,#  varchar(200);# NOT NULL COMMENT '公司名称',
    a.COM_ADDRESS,#  varchar(200);# DEFAULT NULL COMMENT '公司地址',
    (SELECT t.comdalei from bs_qylx t where t.lx_id=a.com_qylx) as com_qylx,
    a.COM_FDDBR,
    a.COM_LXDH,
    a.COM_LXSJ,
    DATE_FORMAT(COM_CLRQ,'%Y-%m-%d') AS COM_CLRQ,
    CONCAT(a.COM_COUNTY_DM,'000000') AS COM_COUNTY_DM,
    a.YYZZZCH,
    DATE_FORMAT(a.ZJZSYXQQSRQ,'%Y-%m-%d') AS ZJZSYXQQSRQ,
    DATE_FORMAT(a.ZJZSYXQZZRQ,'%Y-%m-%d') AS ZJZSYXQZZRQ
  from bs_company a
  WHERE a.COM_COUNTY_DM IN ('411700','411701','411702','411703','411791') 
    AND doflag=0
    and not exists (select 1 from pcompany t where t.commc=a.com_mc);

  declare cur_tyxkz cursor for  
  SELECT 
    (SELECT t.duiyingzhi FROM bs_daima t WHERE t.dm_dmlb='XKZLB' AND t.dm_dmz=a.XKZ_XKLB) AS xkz_xklb,
    a.XKZBH,
    a.XKZ_FZRQ,
    a.XKZ_YXQZ,
    a.JYXM,
    a.ZTXT,
    a.YLQXXNJGJZC
  from bs_tyxkz  a
  WHERE a.COM_DM=v_COM_dm;


  #where bc.COM_CITY_DM LIKE '4117%';     
                                                      
  declare continue handler for not found set done=1;
  declare exit handler for sqlexception   #not found,sqlwarning,
  begin
    SELECT 'ERROR';
    set prm_AppCode=-1;
    set prm_ErrorMsg='过程出错了';
    rollback;
    #leave label_pro;
  end;
  set @@autocommit= 0;
  set prm_AppCode:=0;
  set prm_ErrorMsg:='成功';

  

  SET done=-1;
  open cur_com;
  mycomloop:loop
  fetch cur_com
  INTO
    v_COM_id,
    v_COM_dm, 
    v_COM_MC,
    v_COM_ADDRESS,
    v_com_qylx,
    v_COM_FDDBR,
    v_COM_LXDH,
    v_COM_LXSJ,
    v_COM_CLRQ,
    v_COM_COUNTY_DM,
    v_YYZZZCH,
    v_ZJZSYXQQSRQ,
    v_ZJZSYXQZZRQ;

    if done=1 then
      leave mycomloop;
    end if; 

    SELECT COUNT(1)    
    INTO v_count
    FROM pcompany 
    WHERE commc=v_COM_MC;

    IF v_count>0 THEN
      ITERATE  mycomloop;
    end IF;
    
    set v_newcomid =f_getSequenceStr();      
    set v_newcomdm= fun_获取comdm();

    insert INTO pcompany(
        comid,
        comdm,
        commc,
        comdz,
        comdalei,
        comfrhyz,
        comgddh,
        comyddh,
        comclrq,
        aaa027,
        orgid,
        comjyjcbz,
        comfwnfww 
      )VALUES(
        v_newcomid,
        v_newcomdm,
        v_COM_MC,
        v_COM_ADDRESS,
        v_com_qylx,
        v_COM_FDDBR,
        v_COM_LXDH,
        v_COM_LXSJ,
        v_COM_CLRQ,
        v_COM_COUNTY_DM,
        prm_orgid,
        '0',
        '0'
      );

      set v_newcomdaleiid=f_getSequenceStr();

      INSERT INTO pcompanycomdalei(
          comdaleiid,
          comid,
          comdalei       
        )VALUES(
          v_newcomdaleiid,
          v_newcomid,
          v_com_qylx
        );

      #如果营业执照不为空插入一条企业许可证信息
      IF  length(trim(v_YYZZZCH))>0 THEN
        set v_newcomxkzid=f_getSequenceStr();
          
        INSERT INTO pcompanyxkz(
            comxkzid,# varchar(32) NOT NULL DEFAULT '0' COMMENT '企业许可信息ID',
            comid,# varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
            comxkzbh,# varchar(50) DEFAULT NULL COMMENT '许可证编号',
            comxkyxqq,# date DEFAULT NULL COMMENT '许可有效期起',
            comxkfw,# varchar(4000) DEFAULT NULL COMMENT '许可范围',
            comxkyxqz,# date DEFAULT NULL COMMENT '许可有效期止',
            comxkzlx,# varchar(32) DEFAULT NULL COMMENT '许可证类型',
            comxkzzcxs,# varchar(50) DEFAULT NULL COMMENT '组成形式',
            comxkzztyt # varchar(200) DEFAULT NULL COMMENT '主题业态',        
          )VALUES(
            v_newcomxkzid,
            v_newcomid,
            v_YYZZZCH,
            v_ZJZSYXQQSRQ,
            '',
            v_ZJZSYXQZZRQ,
            '1',
            '',
            ''
          );
      end IF;

      #7begin
      open cur_tyxkz;
      mylooptyxkz:loop
      fetch cur_tyxkz
      into 
         v_xkz_xklb,
         v_XKZBH, 
         v_XKZ_FZRQ,
         v_XKZ_YXQZ,  
         v_JYXM,
         v_ZTXT, 
         v_YLQXXNJGJZC;    
        
        if done=1 then
          leave mylooptyxkz;
        end if; 

        set v_newcomxkzid =f_getSequenceStr(); 
                           
        INSERT INTO pcompanyxkz(
          comxkzid,# varchar(32) NOT NULL DEFAULT '0' COMMENT '企业许可信息ID',
          comid,# varchar(32) NOT NULL DEFAULT '0' COMMENT '企业ID',
          comxkzbh,# varchar(50) DEFAULT NULL COMMENT '许可证编号',
          comxkyxqq,# date DEFAULT NULL COMMENT '许可有效期起',
          comxkfw,# varchar(4000) DEFAULT NULL COMMENT '许可范围',
          comxkyxqz,# date DEFAULT NULL COMMENT '许可有效期止',
          comxkzlx,# varchar(32) DEFAULT NULL COMMENT '许可证类型',
          comxkzzcxs,# varchar(50) DEFAULT NULL COMMENT '组成形式',
          comxkzztyt # varchar(200) DEFAULT NULL COMMENT '主题业态',               
        )VALUES(
          v_newcomxkzid,
          v_newcomid,
          v_XKZBH,
          v_XKZ_FZRQ,
          v_JYXM,
          v_XKZ_YXQZ,
          v_xkz_xklb,
          v_YLQXXNJGJZC,
          v_ZTXT 
        );
   
            
      end loop mylooptyxkz;
      close cur_tyxkz;    
      #7end  
   
    SET done=0;
                  
    UPDATE bs_company set doflag=1 WHERE com_id=v_com_id;
                                      
  end loop mycomloop;
  close cur_com;

  COMMIT;
       
end;
end


-------------------------------------------------------------------------------------





































