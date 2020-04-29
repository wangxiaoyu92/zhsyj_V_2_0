package com.askj.supervision.dto;

import java.sql.Timestamp;
import java.util.Date;


/**
 * Bscheckmaster的中文名称：检查结果摘要类
 * Written by:syf
 */
public class BsCheckMasterDTO {
    /**itemid*/
    /**
     * @Description spypxzcfwsfyid的中文含义是： 食品药品行政处罚文书副页ID
     */
    private String spypxzcfwsfyid;
    private String ajzfwsid;

    public String getAjzfwsid() {
        return ajzfwsid;
    }

    public void setAjzfwsid(String ajzfwsid) {
        this.ajzfwsid = ajzfwsid;
    }

    private String xxdjbcwptzsid;
    private String mswppzid;
    private String itemid;
    /**operatetype 操作类型 为了功能实现时 特殊处理一些事情 例如 operatetype=‘cyfwdtdjpd_biaotou’*/
    private String operatetype;
    /***餐饮服务食品安全监督动态等级评定表开始***/
    /** pcyfwdtdjpdb 的中文含义是：餐饮服务食品安全监督动态等级评定表id*/
    private String pcyfwdtdjpdb;
    /** comid 的中文含义是：企业id*/
    //private String comid;
    /** resultid 的中文含义是：检查主表id*/
    //private String resultid;
    /** commc 的中文含义是：被检查单位名称*/
   // private String commc;
    /** comdz 的中文含义是：地址*/
   // private String comdz;
    /** comfrhyz 的中文含义是：法定代表人*/
    private String comfrhyz;
    /** comyddh 的中文含义是：电话*/
    private String comyddh;
    /** xkzbh 的中文含义是：餐饮服务许可证编号*/
    private String comxkzbh;
    /** xklb 的中文含义是：许可类别*/
    private String xklb;
    /** jckssj 的中文含义是：检查开始时间*/
    private Timestamp jckssj;
    /** jcjssj 的中文含义是：检查结束时间*/
    private Timestamp jcjssj;
    /** aae011 的中文含义是：操作员*/
   // private String aae011;
    /** aae036 的中文含义是：操作时间*/
   // private Timestamp aae036;
    /** jcryqzpic 的中文含义是：检查人员签字*/
    private String jcryqzpic;
    /** spaqglrypic 的中文含义是：食品安全管理人员签字*/
    private String spaqglrypic;

    /***餐饮服务食品安全监督动态等级评定表结束***/

    /***********风险登记确定表字段扩展************/
    private String checkyear; // 检查年度
    private String checkno; // 编号
    private String comdz; // 企业地址
    private String zzzmbh; // 营业执照编号或信用代码
    private String lxrhfs; // 联系人及联系方式
    private String sndfxdj; // 上年度风险等级
    private String staticscore; // 静态风险因素量化风险分值
    private String dynamicscore; // 动态风险因素量化风险分值
    private String totalscore; // 风险等级得分
    private String fxdj; // 风险等级
    private String gywfflfg; // 故意违反法律法规
    private String ycjysbfh; // 有1次及以上国家或者省级监督抽检不符合食品安全标准的
    private String wfflfg; // 违反法律法规
    private String fsaqsg; // 发生食品安全事故的
    private String bagd; // 不按规定
    private String bpezf; // 拒绝、逃避、阻挠执法人员进行监督检查，或者拒不配合执法人员依法进行案件调查的
    private String kstdj; // 具有法律、法规、规章和省级食品药品监督管理部门规定的其他可以上调风险等级情形的
    private String suggestfxdj; // 风险等级建议
    private String xyndfxdj; // 下一年度风险等级
    private String fxdjbz; // 备注
    private String tbrqm; // 填表人签名
    private String shrqm; // 审核人签名
    /***********风险登记确定表字段扩展************/

	//扩展开始
	/**
	 * zfryqmpic 的中文名称：执法人员签名图片
	 */
	private String zfryqmpic;
	/**
	 * bjcdwqmpic 的中文名称：被检查单位签名图片
	 */
	private String bjcdwqmpic;
    /**
     * bjcdwqmpic 的中文名称：附件外id
     */
    private String fjwid;

    /**
     * whatfun功能模块，例如 levelconfirm等级确定历史
     * */
    private String whatfun;

    /**
     * canedit功能模块， 是否可以修改 0和空可以 其它 不可以
     * */
    private String canedit;

    /**
     * pjingspxsid， 食品销售企业静态风险因素量化分值表id
     * */
    private String pjingspxsid;

    /**
     * pjingcyfwlhid， 餐饮服务提供者静态风险因素量化分值表id
     * */
    private String pjingcyfwlhid;

    /**
     * pjingcyfwlhid， 食品生产经营者风险等级确定表id
     * */
    private String pcyfwnddjpdid;

    /**
     * pcomriskconfirmid， 餐饮服务食品安全监督年度等级评定表id
     * */
    private String pcomriskconfirmid;

    /**
     * planmobankind， 餐饮服务食品安全监督年度等级评定表id
     * */
    private String planmobankind;//计划模板类型aa10=PLANMOBANKIND

    /**
     * 量化分级动态评定等级汉字
     * */
    private String lhfjdtpddjaaa103;

    //扩展结束
	 
	/**
	 * checkavgscore 的中文名称：检查平均分
	 */
	private double checkavgscore;
	/**
	 * lhfjdtpddj 的中文名称：量化分级动态评定等级A优秀B良好C一般
	 */
	private String lhfjdtpddj;
	/**
	 * lhfjdtpddjstr 的中文名称：量化分级动态评定等级A优秀B良好C一般
	 */
	private String lhfjdtpddjstr;	
	
	
    /**
     * lxr 的中文名称：联系人
     */
    private String lxr;
    /**
     * lxdh 的中文名称：联系电话
     */
    private String lxdh;

    /**
     * qtbwid 的中文名称：其他表外id
     */
    private String qtbwid;
    /**
     * checkdatakind 的中文名称：检查数据类型1企业检查2农村集体聚餐3重大活动
     */
    private String checkdatakind;


    /**
     * resultid 的中文名称：结果ID
     */
    private String resultid;

    /**
     * comid 的中文名称：单位ID
     */

    private String planid;

    /**
     * comid 的中文名称：单位ID
     */

    private String comid;

    /**
     * resultdecision 的中文名称：结果判定
     */

    private String resultdecision;

    /**
     * resultng 的中文名称：结果不符合项说明
     */

    private String resultng;

    /**
     * resultremark 的中文名称：结果备注
     */

    private String resultremark;

    /**
     * resultscore 的中文名称：结果得分
     */

    private double resultscore;
    /**
     * resultstate 的中文名称：结果完成标识
     */

    private String resultstate;


    /**
     * operatedate 的中文名称：项目经办日期
     */

    private String operatedate;

    /**
     * operateperson 的中文名称：项目经办人
     */

    private String operateperson;

    /**
     * resultdate 的中文名称：结果检查日期
     */

    private Timestamp resultdate;

    /**
     * resultperson 的中文名称：结果检查人
     */

    private String resultperson;

    /**
     * @Description plantitle的中文含义是： 计划标题
     */
    private String plantitle;
    /**
     * @Description commc的中文含义是：公司名称
     */
    private String commc;
    /**
     * operatedate 的中文名称：结束日期
     */

    private String operateenddate;

    /**
     * resultinfo 的中文名称：结果明细
     */
    private String detailinfo;

    /**
     * tbodytype 的中文名称：表头大类
     */
    private String tbodytype;

    /**
     * tbodycode 的中文名称：表头小类
     */
    private String tbodycode;
    /**
     * tbodycode 的中文名称：重要性数值
     */
    private int num;
    /**
     * tbodycode 的中文名称：常亮代码值
     */
    private String aaa001;
    /**
     * tbodycode 的中文名称：按键状态
     */
    private String buttonstate;
    /**
     * resultinfo 的中文名称：核查结果信息
     */
    private String checkresultinfo;
    /**
     * detailid 的中文名称：明细ID
     */
    private String detailid;
    /**
     * contentid 的中文名称：内容ID
     */

    private String contentid;

    /**
     * detaildecide 的中文名称：明细结果判定
     */

    private String detaildecide;

    /**
     * detailscore 的中文名称：明细得分
     */

    private long detailscore;

    /**
     * detailng 的中文名称：明细不符合项说明
     */

    private String detailng;

    /**
     * detailattachment 的中文名称：明细附件
     */

    private String detailattachment;

    /**
     * detailremark 的中文名称：明细备注
     */

    private String detailremark;

    /**
     * detailoperatedate 的中文名称：明细经办日期
     */

    private String detailoperatedate;

    /**
     * detailoperateperson 的中文名称：明细经办人
     */

    private String detailoperateperson;

    /**
     * detailcheckdate 的中文名称：明细核查日期
     */

    private String detailcheckdate;

    /**
     * detailcheckperson 的中文名称：明细检查人
     */

    private String detailcheckperson;
    /**
     * checkgroupstate 的中文名称：检查项目类别标识
     */

    private String checkgroupstate;
    private String planchecktype;
    private String comdalei;
    private String jcsbjbrxm;
    private String year;
    private double checknum;
    private double checkgetnum;
    private String level;
    private String levelGrapheme;
    private double averageScore;
    private String contentcode;
    private String content;
    private int impnum;
    private String str;
    private String number;
    private String impDetail;
    private String comDetail;
    private String plancount;
    private String plantype;
    private String plantypename;
    private String aaa383;
    private String spsccount;
    private String AAA102;
    private String AAA103;
    private int pcomcount;
    private String location;
    /**
     * latitude 的中文名称：纬度信息
     */
    private String latitude;
    /**
     * longitude 的中文名称：经度信息
     */
    private String longitude;
    /**
     * aaa027 的中文名称：地区编码
     */
    private String aaa027;
    /**
     * aae140 的中文名称：四品一械大类
     */
    private String aae140;
    /**
     * userid 的中文名称：经办人id
     */
    private String userid;
    /**
     * orgid 的中文名称：机构id
     */
    private String orgid;
    /**
     * aae011 的中文名称：经办人
     */
    private String aae011;
    /**
     * aae036 的中文名称：经办时间
     */
    private Date aae036;
    /**
     * wsid 的中文名称：文书ajdjid
     */
    private String ajdjid;
    /**
     * type 的中文名称：文书类型
     */
    private String type;
    /**
     * wpqdid 的中文名称：物品清单
     */
    private String wpqdid;
    /**
     * xcjcblid 的中文名称：现场检查笔录id
     */
    private String xcjcblid;
    /**
     * cfkyjdsid 的中文名称：查封扣押决定书id
     */
    private String cfkyjdsid;
    /**
     * zfwsqtbid 的中文名称：询问调查笔录id
     */
    private String zfwsqtbid;
    /**
     * zlgztzsid 的中文名称：责令整改通知书id
     */
    private String zlgztzsid;
    /**
     * dcxzcfjdsid 的中文名称：当场行政处罚决定书id
     */
    private String dcxzcfjdsid;

    /**
     * dcxzcfjdsid 的中文名称：结果处理最终
     */
    private String resultfinal;

    public String getResultFinal() {
        return resultfinal;
    }

    public void setResultFinal(String resultfinal) {
        this.resultfinal = resultfinal;
    }

    public String getSpsccount() {
        return spsccount;
    }

    public void setSpsccount(String spsccount) {
        this.spsccount = spsccount;
    }

    public String getAAA102() {
        return AAA102;
    }

    public void setAAA102(String aAA102) {
        AAA102 = aAA102;
    }

    public String getAAA103() {
        return AAA103;
    }

    public void setAAA103(String aAA103) {
        AAA103 = aAA103;
    }

    public void setAaa383(String aaa383) {
        this.aaa383 = aaa383;
    }

    public String getPlancount() {
        return plancount;
    }

    public void setPlancount(String plancount) {
        this.plancount = plancount;
    }

    public String getPlantype() {
        return plantype;
    }

    public void setPlantype(String plantype) {
        this.plantype = plantype;
    }

    public String getPlantypename() {
        return plantypename;
    }

    public void setPlantypename(String plantypename) {
        this.plantypename = plantypename;
    }

    public String getImpDetail() {
        return impDetail;
    }

    public void setImpDetail(String impDetail) {
        this.impDetail = impDetail;
    }

    public String getComDetail() {
        return comDetail;
    }

    public void setComDetail(String comDetail) {
        this.comDetail = comDetail;
    }

    public void setChecknum(double checknum) {
        this.checknum = checknum;
    }

    public void setCheckgetnum(double checkgetnum) {
        this.checkgetnum = checkgetnum;
    }

    public String getDetailid() {
        return detailid;
    }

    public void setDetailid(String detailid) {
        this.detailid = detailid;
    }

    public String getContentid() {
        return contentid;
    }

    public void setContentid(String contentid) {
        this.contentid = contentid;
    }

    public String getDetaildecide() {
        return detaildecide;
    }

    public void setDetaildecide(String detaildecide) {
        this.detaildecide = detaildecide;
    }

    public long getDetailscore() {
        return detailscore;
    }

    public void setDetailscore(long detailscore) {
        this.detailscore = detailscore;
    }

    public String getDetailng() {
        return detailng;
    }

    public void setDetailng(String detailng) {
        this.detailng = detailng;
    }

    public String getDetailattachment() {
        return detailattachment;
    }

    public void setDetailattachment(String detailattachment) {
        this.detailattachment = detailattachment;
    }

    public String getDetailremark() {
        return detailremark;
    }

    public void setDetailremark(String detailremark) {
        this.detailremark = detailremark;
    }

    public String getDetailoperatedate() {
        return detailoperatedate;
    }

    public void setDetailoperatedate(String detailoperatedate) {
        this.detailoperatedate = detailoperatedate;
    }

    public String getDetailoperateperson() {
        return detailoperateperson;
    }

    public void setDetailoperateperson(String detailoperateperson) {
        this.detailoperateperson = detailoperateperson;
    }

    public String getDetailcheckdate() {
        return detailcheckdate;
    }

    public void setDetailcheckdate(String detailcheckdate) {
        this.detailcheckdate = detailcheckdate;
    }

    public String getDetailcheckperson() {
        return detailcheckperson;
    }

    public void setDetailcheckperson(String detailcheckperson) {
        this.detailcheckperson = detailcheckperson;
    }


    /**
     * setResultid的中文名称：设置结果ID
     *
     * @param resultid 结果ID
     *                 Written by:syf
     */
    public void setResultid(String resultid) {
        this.resultid = resultid;
    }

    /**
     * getResultid的中文名称：获取结果ID
     *
     * @return String
     * Written by:syf
     */
    public String getResultid() {
        return resultid;
    }

    /**
     * setPlanid的中文名称：设置计划ID
     *
     * @param planid 计划ID
     *               Written by:syf
     */
    public void setPlanid(String planid) {
        this.planid = planid;
    }

    /**
     * getPlanid的中文名称：获取计划ID
     *
     * @return String
     * Written by:syf
     */
    public String getPlanid() {
        return planid;
    }

    /**
     * setComid的中文名称：设置单位ID
     *
     * @param comid 单位ID
     *              Written by:syf
     */
    public void setComid(String comid) {
        this.comid = comid;
    }

    /**
     * getComid的中文名称：获取单位ID
     *
     * @return String
     * Written by:syf
     */
    public String getComid() {
        return comid;
    }

    /**
     * setResultdecision的中文名称：设置结果判定
     *
     * @param resultdecision 结果判定
     *                       Written by:syf
     */
    public void setResultdecision(String resultdecision) {
        this.resultdecision = resultdecision;
    }

    /**
     * getResultdecision的中文名称：获取结果判定
     *
     * @return String
     * Written by:syf
     */
    public String getResultdecision() {
        return resultdecision;
    }

    /**
     * setResultng的中文名称：设置结果不符合项说明
     *
     * @param resultng 结果不符合项说明
     *                 Written by:syf
     */
    public void setResultng(String resultng) {
        this.resultng = resultng;
    }

    /**
     * getResultng的中文名称：获取结果不符合项说明
     *
     * @return String
     * Written by:syf
     */
    public String getResultng() {
        return resultng;
    }

    /**
     * setResultremark的中文名称：设置结果备注
     *
     * @param resultremark 结果备注
     *                     Written by:syf
     */
    public void setResultremark(String resultremark) {
        this.resultremark = resultremark;
    }

    /**
     * getResultremark的中文名称：获取结果备注
     *
     * @return String
     * Written by:syf
     */
    public String getResultremark() {
        return resultremark;
    }

    /**
     * setResultscore的中文名称：设置结果得分
     *
     * @param resultscore 结果得分
     *                    Written by:syf
     */
    public void setResultscore(double resultscore) {
        this.resultscore = resultscore;
    }

    /**
     * getResultscore的中文名称：获取结果得分
     *
     * @return double
     * Written by:syf
     */
    public double getResultscore() {
        return resultscore;
    }

    /**
     * setOperatedate的中文名称：设置项目经办日期
     *
     * @param operatedate 项目经办日期
     *                    Written by:syf
     */
    public void setOperatedate(String operatedate) {
        this.operatedate = operatedate;
    }

    /**
     * getOperatedate的中文名称：获取项目经办日期
     *
     * @return Date
     * Written by:syf
     */
    public String getOperatedate() {
        return operatedate;
    }

    /**
     * setOperateperson的中文名称：设置项目经办人
     *
     * @param operateperson 项目经办人
     *                      Written by:syf
     */
    public void setOperateperson(String operateperson) {
        this.operateperson = operateperson;
    }

    /**
     * getOperateperson的中文名称：获取项目经办人
     *
     * @return String
     * Written by:syf
     */
    public String getOperateperson() {
        return operateperson;
    }


    /**
     * setResultperson的中文名称：设置结果检查人
     *
     * @param resultperson 结果检查人
     *                     Written by:syf
     */
    public void setResultperson(String resultperson) {
        this.resultperson = resultperson;
    }

    /**
     * getResultperson的中文名称：获取结果检查人
     *
     * @return String
     * Written by:syf
     */
    public String getResultperson() {
        return resultperson;
    }

    public String getZfryqmpic() {
        return zfryqmpic;
    }

    public void setZfryqmpic(String zfryqmpic) {
        this.zfryqmpic = zfryqmpic;
    }

    public String getBjcdwqmpic() {
        return bjcdwqmpic;
    }

    public void setBjcdwqmpic(String bjcdwqmpic) {
        this.bjcdwqmpic = bjcdwqmpic;
    }

    public double getCheckavgscore() {
        return checkavgscore;
    }

    public void setCheckavgscore(double checkavgscore) {
        this.checkavgscore = checkavgscore;
    }

    public String getLhfjdtpddj() {
        return lhfjdtpddj;
    }

    public void setLhfjdtpddj(String lhfjdtpddj) {
        this.lhfjdtpddj = lhfjdtpddj;
    }

    public String getLhfjdtpddjstr() {
        return lhfjdtpddjstr;
    }

    public void setLhfjdtpddjstr(String lhfjdtpddjstr) {
        this.lhfjdtpddjstr = lhfjdtpddjstr;
    }

    public String getLxr() {
        return lxr;
    }

    public void setLxr(String lxr) {
        this.lxr = lxr;
    }

    public String getLxdh() {
        return lxdh;
    }

    public void setLxdh(String lxdh) {
        this.lxdh = lxdh;
    }

    public String getQtbwid() {
        return qtbwid;
    }

    public void setQtbwid(String qtbwid) {
        this.qtbwid = qtbwid;
    }

    public String getCheckdatakind() {
        return checkdatakind;
    }

    public void setCheckdatakind(String checkdatakind) {
        this.checkdatakind = checkdatakind;
    }

    public String getResultstate() {
        return resultstate;
    }

    public void setResultstate(String resultstate) {
        this.resultstate = resultstate;
    }

    public String getPlantitle() {
        return plantitle;
    }

    public void setPlantitle(String plantitle) {
        this.plantitle = plantitle;
    }

    public String getCommc() {
        return commc;
    }

    public void setCommc(String commc) {
        this.commc = commc;
    }

    public String getOperateenddate() {
        return operateenddate;
    }

    public void setOperateenddate(String operateenddate) {
        this.operateenddate = operateenddate;
    }

    public String getDetailinfo() {
        return detailinfo;
    }

    public void setDetailinfo(String detailinfo) {
        this.detailinfo = detailinfo;
    }

    public String getTbodytype() {
        return tbodytype;
    }

    public void setTbodytype(String tbodytype) {
        this.tbodytype = tbodytype;
    }

    public String getTbodycode() {
        return tbodycode;
    }

    public void setTbodycode(String tbodycode) {
        this.tbodycode = tbodycode;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getAaa001() {
        return aaa001;
    }

    public void setAaa001(String aaa001) {
        this.aaa001 = aaa001;
    }

    public String getButtonstate() {
        return buttonstate;
    }

    public void setButtonstate(String buttonstate) {
        this.buttonstate = buttonstate;
    }

    public String getCheckresultinfo() {
        return checkresultinfo;
    }

    public void setCheckresultinfo(String checkresultinfo) {
        this.checkresultinfo = checkresultinfo;
    }

    public String getCheckgroupstate() {
        return checkgroupstate;
    }

    public void setCheckgroupstate(String checkgroupstate) {
        this.checkgroupstate = checkgroupstate;
    }

    public String getPlanchecktype() {
        return planchecktype;
    }

    public void setPlanchecktype(String planchecktype) {
        this.planchecktype = planchecktype;
    }

    public String getComdalei() {
        return comdalei;
    }

    public void setComdalei(String comdalei) {
        this.comdalei = comdalei;
    }

    public String getJcsbjbrxm() {
        return jcsbjbrxm;
    }

    public void setJcsbjbrxm(String jcsbjbrxm) {
        this.jcsbjbrxm = jcsbjbrxm;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public double getChecknum() {
        return checknum;
    }

    public double getCheckgetnum() {
        return checkgetnum;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getLevelGrapheme() {
        return levelGrapheme;
    }

    public void setLevelGrapheme(String levelGrapheme) {
        this.levelGrapheme = levelGrapheme;
    }

    public double getAverageScore() {
        return averageScore;
    }

    public void setAverageScore(double averageScore) {
        this.averageScore = averageScore;
    }

    public String getContentcode() {
        return contentcode;
    }

    public void setContentcode(String contentcode) {
        this.contentcode = contentcode;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getImpnum() {
        return impnum;
    }

    public void setImpnum(int impnum) {
        this.impnum = impnum;
    }

    public String getStr() {
        return str;
    }

    public void setStr(String str) {
        this.str = str;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getAaa383() {
        return aaa383;
    }

    public int getPcomcount() {
        return pcomcount;
    }

    public void setPcomcount(int pcomcount) {
        this.pcomcount = pcomcount;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getAaa027() {
        return aaa027;
    }

    public void setAaa027(String aaa027) {
        this.aaa027 = aaa027;
    }

    public String getAae140() {
        return aae140;
    }

    public void setAae140(String aae140) {
        this.aae140 = aae140;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public String getAae011() {
        return aae011;
    }

    public void setAae011(String aae011) {
        this.aae011 = aae011;
    }

    public Date getAae036() {
        return aae036;
    }

    public void setAae036(Date aae036) {
        this.aae036 = aae036;
    }

    public String getAjdjid() {
        return ajdjid;
    }

    public void setAjdjid(String ajdjid) {
        this.ajdjid = ajdjid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getWpqdid() {
        return wpqdid;
    }

    public void setWpqdid(String wpqdid) {
        this.wpqdid = wpqdid;
    }

    public String getXcjcblid() {
        return xcjcblid;
    }

    public void setXcjcblid(String xcjcblid) {
        this.xcjcblid = xcjcblid;
    }

    public String getCfkyjdsid() {
        return cfkyjdsid;
    }

    public void setCfkyjdsid(String cfkyjdsid) {
        this.cfkyjdsid = cfkyjdsid;
    }

    public String getZfwsqtbid() {
        return zfwsqtbid;
    }

    public void setZfwsqtbid(String zfwsqtbid) {
        this.zfwsqtbid = zfwsqtbid;
    }

    public String getZlgztzsid() {
        return zlgztzsid;
    }

    public void setZlgztzsid(String zlgztzsid) {
        this.zlgztzsid = zlgztzsid;
    }

    public String getDcxzcfjdsid() {
        return dcxzcfjdsid;
    }

    public void setDcxzcfjdsid(String dcxzcfjdsid) {
        this.dcxzcfjdsid = dcxzcfjdsid;
    }

    public String getResultfinal() {
        return resultfinal;
    }

    public void setResultfinal(String resultfinal) {
        this.resultfinal = resultfinal;
    }

    public String getFjwid() {
        return fjwid;
    }

    public void setFjwid(String fjwid) {
        this.fjwid = fjwid;
    }

    public String getCheckyear() {
        return checkyear;
    }

    public void setCheckyear(String checkyear) {
        this.checkyear = checkyear;
    }

    public String getCheckno() {
        return checkno;
    }

    public void setCheckno(String checkno) {
        this.checkno = checkno;
    }

    public String getComdz() {
        return comdz;
    }

    public void setComdz(String comdz) {
        this.comdz = comdz;
    }

    public String getZzzmbh() {
        return zzzmbh;
    }

    public void setZzzmbh(String zzzmbh) {
        this.zzzmbh = zzzmbh;
    }

    public String getLxrhfs() {
        return lxrhfs;
    }

    public void setLxrhfs(String lxrhfs) {
        this.lxrhfs = lxrhfs;
    }

    public String getSndfxdj() {
        return sndfxdj;
    }

    public void setSndfxdj(String sndfxdj) {
        this.sndfxdj = sndfxdj;
    }

    public String getStaticscore() {
        return staticscore;
    }

    public void setStaticscore(String staticscore) {
        this.staticscore = staticscore;
    }

    public String getDynamicscore() {
        return dynamicscore;
    }

    public void setDynamicscore(String dynamicscore) {
        this.dynamicscore = dynamicscore;
    }

    public String getTotalscore() {
        return totalscore;
    }

    public void setTotalscore(String totalscore) {
        this.totalscore = totalscore;
    }

    public String getFxdj() {
        return fxdj;
    }

    public void setFxdj(String fxdj) {
        this.fxdj = fxdj;
    }

    public String getGywfflfg() {
        return gywfflfg;
    }

    public void setGywfflfg(String gywfflfg) {
        this.gywfflfg = gywfflfg;
    }

    public String getYcjysbfh() {
        return ycjysbfh;
    }

    public void setYcjysbfh(String ycjysbfh) {
        this.ycjysbfh = ycjysbfh;
    }

    public String getWfflfg() {
        return wfflfg;
    }

    public void setWfflfg(String wfflfg) {
        this.wfflfg = wfflfg;
    }

    public String getFsaqsg() {
        return fsaqsg;
    }

    public void setFsaqsg(String fsaqsg) {
        this.fsaqsg = fsaqsg;
    }

    public String getBagd() {
        return bagd;
    }

    public void setBagd(String bagd) {
        this.bagd = bagd;
    }

    public String getBpezf() {
        return bpezf;
    }

    public void setBpezf(String bpezf) {
        this.bpezf = bpezf;
    }

    public String getKstdj() {
        return kstdj;
    }

    public void setKstdj(String kstdj) {
        this.kstdj = kstdj;
    }

    public String getSuggestfxdj() {
        return suggestfxdj;
    }

    public void setSuggestfxdj(String suggestfxdj) {
        this.suggestfxdj = suggestfxdj;
    }

    public String getXyndfxdj() {
        return xyndfxdj;
    }

    public void setXyndfxdj(String xyndfxdj) {
        this.xyndfxdj = xyndfxdj;
    }

    public String getFxdjbz() {
        return fxdjbz;
    }

    public void setFxdjbz(String fxdjbz) {
        this.fxdjbz = fxdjbz;
    }

    public String getTbrqm() {
        return tbrqm;
    }

    public void setTbrqm(String tbrqm) {
        this.tbrqm = tbrqm;
    }

    public String getShrqm() {
        return shrqm;
    }

    public void setShrqm(String shrqm) {
        this.shrqm = shrqm;
    }

    public String getWhatfun() {
        return whatfun;
    }

    public void setWhatfun(String whatfun) {
        this.whatfun = whatfun;
    }

    public String getCanedit() {
        return canedit;
    }

    public void setCanedit(String canedit) {
        this.canedit = canedit;
    }

    public String getPjingspxsid() {
        return pjingspxsid;
    }

    public void setPjingspxsid(String pjingspxsid) {
        this.pjingspxsid = pjingspxsid;
    }

    public String getPjingcyfwlhid() {
        return pjingcyfwlhid;
    }

    public void setPjingcyfwlhid(String pjingcyfwlhid) {
        this.pjingcyfwlhid = pjingcyfwlhid;
    }

    public String getPcyfwnddjpdid() {
        return pcyfwnddjpdid;
    }

    public void setPcyfwnddjpdid(String pcyfwnddjpdid) {
        this.pcyfwnddjpdid = pcyfwnddjpdid;
    }

    public String getPcomriskconfirmid() {
        return pcomriskconfirmid;
    }

    public void setPcomriskconfirmid(String pcomriskconfirmid) {
        this.pcomriskconfirmid = pcomriskconfirmid;
    }

    public Timestamp getResultdate() {
        return resultdate;
    }

    public void setResultdate(Timestamp resultdate) {
        this.resultdate = resultdate;
    }

    public String getPlanmobankind() {
        return planmobankind;
    }

    public void setPlanmobankind(String planmobankind) {
        this.planmobankind = planmobankind;
    }

    public String getLhfjdtpddjaaa103() {
        return lhfjdtpddjaaa103;
    }

    public void setLhfjdtpddjaaa103(String lhfjdtpddjaaa103) {
        this.lhfjdtpddjaaa103 = lhfjdtpddjaaa103;
    }

    public String getOperatetype() {
        return operatetype;
    }

    public void setOperatetype(String operatetype) {
        this.operatetype = operatetype;
    }

    public String getPcyfwdtdjpdb() {
        return pcyfwdtdjpdb;
    }

    public void setPcyfwdtdjpdb(String pcyfwdtdjpdb) {
        this.pcyfwdtdjpdb = pcyfwdtdjpdb;
    }

    public String getComfrhyz() {
        return comfrhyz;
    }

    public void setComfrhyz(String comfrhyz) {
        this.comfrhyz = comfrhyz;
    }

    public String getComyddh() {
        return comyddh;
    }

    public void setComyddh(String comyddh) {
        this.comyddh = comyddh;
    }

    public String getComxkzbh() {
        return comxkzbh;
    }

    public void setComxkzbh(String comxkzbh) {
        this.comxkzbh = comxkzbh;
    }

    public String getXklb() {
        return xklb;
    }

    public void setXklb(String xklb) {
        this.xklb = xklb;
    }

    public Timestamp getJckssj() {
        return jckssj;
    }

    public void setJckssj(Timestamp jckssj) {
        this.jckssj = jckssj;
    }

    public Timestamp getJcjssj() {
        return jcjssj;
    }

    public void setJcjssj(Timestamp jcjssj) {
        this.jcjssj = jcjssj;
    }

    public String getJcryqzpic() {
        return jcryqzpic;
    }

    public void setJcryqzpic(String jcryqzpic) {
        this.jcryqzpic = jcryqzpic;
    }

    public String getSpaqglrypic() {
        return spaqglrypic;
    }

    public void setSpaqglrypic(String spaqglrypic) {
        this.spaqglrypic = spaqglrypic;
    }

    public String getItemid() {
        return itemid;
    }

    public void setItemid(String itemid) {
        this.itemid = itemid;
    }

    public String getSpypxzcfwsfyid() {
        return spypxzcfwsfyid;
    }

    public void setSpypxzcfwsfyid(String spypxzcfwsfyid) {
        this.spypxzcfwsfyid = spypxzcfwsfyid;
    }

    public String getXxdjbcwptzsid() {
        return xxdjbcwptzsid;
    }

    public void setXxdjbcwptzsid(String xxdjbcwptzsid) {
        this.xxdjbcwptzsid = xxdjbcwptzsid;
    }

    public String getMswppzid() {
        return mswppzid;
    }

    public void setMswppzid(String mswppzid) {
        this.mswppzid = mswppzid;
    }
}
