package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * Created by ce on 2018/5/21.
 */
@Table(value = "jcgzhb")
public class Jcgzhb {
    /** jcgzhbid 的中文含义是：稽查工作汇报ID*/
    @Column(value="jcgzhbid")
    @Name
    private String jcgzhbid;

    /** orgid 的中文含义是：所属机构id*/
    @Column(value="orgid")
    private String orgid;

    /** laby的中文含义是：立案本月*/
    @Column(value="laby")
    private String laby;

    /** lalj的中文含义是：立案累计*/
    @Column(value="lalj")
    private String lalj;

    /** jaby的中文含义是：结案本月*/
    @Column(value="jaby")
    private String jaby;

    /** jalj的中文含义是：结案累计*/
    @Column(value="jalj")
    private String jalj;

    /** yssfby的中文含义是：移送司法本月*/
    @Column(value="yssfby")
    private String yssfby;

    /** yssflj的中文含义是：移送司法累计*/
    @Column(value="yssflj")
    private String yssflj;

    /** zxfkby的中文含义是：执行罚款本月*/
    @Column(value="zxfkby")
    private String zxfkby;

    /** zxfklj的中文含义是：执行罚款累计*/
    @Column(value="zxfklj")
    private String zxfklj;

    /** ajxxgsrw的中文含义是：案件信息公示任务*/
    @Column(value="ajxxgsrw")
    private String ajxxgsrw;

    /** ajxxgsby的中文含义是：案件信息公示本月*/
    @Column(value="ajxxgsby")
    private String ajxxgsby;

    /** ajxxgslj的中文含义是：案件信息公示累计*/
    @Column(value="ajxxgslj")
    private String ajxxgslj;

    /** cyjjrw的中文含义是：抽样检验任务*/
    @Column(value="cyjjrw")
    private String cyjjrw;

    /** cyjjby的中文含义是：抽样检验本月*/
    @Column(value="cyjjby")
    private String cyjjby;

    /** cyjjlj的中文含义是：抽样检验累计*/
    @Column(value="cyjjlj")
    private String cyjjlj;

    /** cjxxgsrw的中文含义是：抽检信息公示任务*/
    @Column(value="cjxxgsrw")
    private String cjxxgsrw;

    /** cjxxgsby的中文含义是：抽检信息公示本月*/
    @Column(value="cjxxgsby")
    private String cjxxgsby;

    /** cjxxgslj的中文含义是：抽检信息公示累计*/
    @Column(value="cjxxgslj")
    private String cjxxgslj;

    /** bdwsltsjbby的中文含义是：本单位受理投诉举报本月*/
    @Column(value="bdwsltsjbby")
    private String bdwsltsjbby;

    /** bdwsltsjblj的中文含义是：本单位受理投诉举报累计*/
    @Column(value="bdwsltsjblj")
    private String bdwsltsjblj;

    /** sjjbtsjbby的中文含义是：省局交办投诉举报本月*/
    @Column(value="sjjbtsjbby")
    private String sjjbtsjbby;

    /** sjjbtsjblj的中文含义是：省局交办投诉举报累计*/
    @Column(value="sjjbtsjblj")
    private String sjjbtsjblj;

    /** sjjbwthcczby的中文含义是：省局交办问题核查处置本月*/
    @Column(value="sjjbwthcczby")
    private String sjjbwthcczby;

    /** sjjbwthcczlj的中文含义是：省局交办问题核查处置累计*/
    @Column(value="sjjbwthcczlj")
    private String sjjbwthcczlj;

    /** sjjbwthcczrw的中文含义是：省局交办问题核查处置任务*/
    @Column(value="sjjbwthcczrw")
    private String sjjbwthcczrw;

    /** xcblrw的中文含义是：协查办理任务*/
    @Column(value="xcblrw")
    private String xcblrw;

    /** xcblby的中文含义是：协查办理本月*/
    @Column(value="xcblby")
    private String xcblby;

    /** xcbllj的中文含义是：协查办理累计*/
    @Column(value="xcbllj")
    private String xcbllj;

    /** aaa011的中文含义是：操作人id*/
    @Column(value="aaa011")
    private String aaa011;

    /** aaa036的中文含义是：操作时间*/
    @Column(value="aaa036")
    private String aaa036;

    public String getJcgzhbid() {
        return jcgzhbid;
    }

    public void setJcgzhbid(String jcgzhbid) {
        this.jcgzhbid = jcgzhbid;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public String getLaby() {
        return laby;
    }

    public void setLaby(String laby) {
        this.laby = laby;
    }

    public String getLalj() {
        return lalj;
    }

    public void setLalj(String lalj) {
        this.lalj = lalj;
    }

    public String getJaby() {
        return jaby;
    }

    public void setJaby(String jaby) {
        this.jaby = jaby;
    }

    public String getJalj() {
        return jalj;
    }

    public void setJalj(String jalj) {
        this.jalj = jalj;
    }

    public String getYssfby() {
        return yssfby;
    }

    public void setYssfby(String yssfby) {
        this.yssfby = yssfby;
    }

    public String getYssflj() {
        return yssflj;
    }

    public void setYssflj(String yssflj) {
        this.yssflj = yssflj;
    }

    public String getZxfkby() {
        return zxfkby;
    }

    public void setZxfkby(String zxfkby) {
        this.zxfkby = zxfkby;
    }

    public String getZxfklj() {
        return zxfklj;
    }

    public void setZxfklj(String zxfklj) {
        this.zxfklj = zxfklj;
    }

    public String getAjxxgsrw() {
        return ajxxgsrw;
    }

    public void setAjxxgsrw(String ajxxgsrw) {
        this.ajxxgsrw = ajxxgsrw;
    }

    public String getAjxxgsby() {
        return ajxxgsby;
    }

    public void setAjxxgsby(String ajxxgsby) {
        this.ajxxgsby = ajxxgsby;
    }

    public String getAjxxgslj() {
        return ajxxgslj;
    }

    public void setAjxxgslj(String ajxxgslj) {
        this.ajxxgslj = ajxxgslj;
    }

    public String getCyjjrw() {
        return cyjjrw;
    }

    public void setCyjjrw(String cyjjrw) {
        this.cyjjrw = cyjjrw;
    }

    public String getCyjjby() {
        return cyjjby;
    }

    public void setCyjjby(String cyjjby) {
        this.cyjjby = cyjjby;
    }

    public String getCjxxgsrw() {
        return cjxxgsrw;
    }

    public void setCjxxgsrw(String cjxxgsrw) {
        this.cjxxgsrw = cjxxgsrw;
    }

    public String getCjxxgsby() {
        return cjxxgsby;
    }

    public void setCjxxgsby(String cjxxgsby) {
        this.cjxxgsby = cjxxgsby;
    }

    public String getCyjjlj() {
        return cyjjlj;
    }

    public void setCyjjlj(String cyjjlj) {
        this.cyjjlj = cyjjlj;
    }

    public String getCjxxgslj() {
        return cjxxgslj;
    }

    public void setCjxxgslj(String cjxxgslj) {
        this.cjxxgslj = cjxxgslj;
    }

    public String getBdwsltsjbby() {
        return bdwsltsjbby;
    }

    public void setBdwsltsjbby(String bdwsltsjbby) {
        this.bdwsltsjbby = bdwsltsjbby;
    }

    public String getSjjbtsjbby() {
        return sjjbtsjbby;
    }

    public void setSjjbtsjbby(String sjjbtsjbby) {
        this.sjjbtsjbby = sjjbtsjbby;
    }

    public String getBdwsltsjblj() {
        return bdwsltsjblj;
    }

    public void setBdwsltsjblj(String bdwsltsjblj) {
        this.bdwsltsjblj = bdwsltsjblj;
    }

    public String getSjjbtsjblj() {
        return sjjbtsjblj;
    }

    public void setSjjbtsjblj(String sjjbtsjblj) {
        this.sjjbtsjblj = sjjbtsjblj;
    }

    public String getSjjbwthcczby() {
        return sjjbwthcczby;
    }

    public void setSjjbwthcczby(String sjjbwthcczby) {
        this.sjjbwthcczby = sjjbwthcczby;
    }

    public String getSjjbwthcczlj() {
        return sjjbwthcczlj;
    }

    public void setSjjbwthcczlj(String sjjbwthcczlj) {
        this.sjjbwthcczlj = sjjbwthcczlj;
    }

    public String getSjjbwthcczrw() {
        return sjjbwthcczrw;
    }

    public void setSjjbwthcczrw(String sjjbwthcczrw) {
        this.sjjbwthcczrw = sjjbwthcczrw;
    }

    public String getXcblrw() {
        return xcblrw;
    }

    public void setXcblrw(String xcblrw) {
        this.xcblrw = xcblrw;
    }

    public String getXcblby() {
        return xcblby;
    }

    public void setXcblby(String xcblby) {
        this.xcblby = xcblby;
    }

    public String getXcbllj() {
        return xcbllj;
    }

    public void setXcbllj(String xcbllj) {
        this.xcbllj = xcbllj;
    }

    public String getAaa011() {
        return aaa011;
    }

    public void setAaa011(String aaa011) {
        this.aaa011 = aaa011;
    }

    public String getAaa036() {
        return aaa036;
    }

    public void setAaa036(String aaa036) {
        this.aaa036 = aaa036;
    }
}
