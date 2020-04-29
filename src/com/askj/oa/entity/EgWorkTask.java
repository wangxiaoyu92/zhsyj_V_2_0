package com.askj.oa.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2018/4/16.
 */
@Table(value = "eg_work_task")
public class EgWorkTask {
    /** workTaskId 的中文含义是：工作台账id*/
    @Column(value="work_task_id")
    @Name
    private String workTaskId;

    /** orgid 的中文含义是：所属机构id*/
    @Column(value="orgid")
    private String orgid;

    /** workTaskNo 的中文含义是：序号*/
    @Column(value="work_task_no")
    private Integer workTaskNo;

    /** workTaskContent 的中文含义是：工作任务*/
    @Column(value="work_task_content")
    private String workTaskContent;

    /** workTaskWeight 的中文含义是：权重*/
    @Column(value="work_task_weight")
    private String workTaskWeight;

    /** workTaskStep 的中文含义是：工作措施*/
    @Column(value="work_task_step")
    private String workTaskStep;

    /** workTaskStDate 的中文含义是：工作开始时间*/
    @Column(value="work_task_st_date")
    private String workTaskStDate;

    /** workTaskEdDate 的中文含义是：工作结束时间*/
    @Column(value="work_task_ed_date")
    private String workTaskEdDate;

    /** workTaskDutyPerson 的中文含义是：责任人*/
    @Column(value="work_task_duty_person")
    private String workTaskDutyPerson;

    /** workTaskDutyLeader 的中文含义是：责任领导*/
    @Column(value="work_task_duty_leader")
    private String workTaskDutyLeader;

    @Column(value="wcsx")
    private String wcsx;

    public String getWorkTaskId() {
        return workTaskId;
    }

    public void setWorkTaskId(String workTaskId) {
        this.workTaskId = workTaskId;
    }

    public String getOrgid() {
        return orgid;
    }

    public void setOrgid(String orgid) {
        this.orgid = orgid;
    }

    public Integer getWorkTaskNo() {
        return workTaskNo;
    }

    public void setWorkTaskNo(Integer workTaskNo) {
        this.workTaskNo = workTaskNo;
    }

    public String getWorkTaskContent() {
        return workTaskContent;
    }

    public void setWorkTaskContent(String workTaskContent) {
        this.workTaskContent = workTaskContent;
    }

    public String getWorkTaskWeight() {
        return workTaskWeight;
    }

    public void setWorkTaskWeight(String workTaskWeight) {
        this.workTaskWeight = workTaskWeight;
    }

    public String getWorkTaskStep() {
        return workTaskStep;
    }

    public void setWorkTaskStep(String workTaskStep) {
        this.workTaskStep = workTaskStep;
    }

    public String getWorkTaskStDate() {
        return workTaskStDate;
    }

    public void setWorkTaskStDate(String workTaskStDate) {
        this.workTaskStDate = workTaskStDate;
    }

    public String getWorkTaskEdDate() {
        return workTaskEdDate;
    }

    public void setWorkTaskEdDate(String workTaskEdDate) {
        this.workTaskEdDate = workTaskEdDate;
    }

    public String getWorkTaskDutyPerson() {
        return workTaskDutyPerson;
    }

    public void setWorkTaskDutyPerson(String workTaskDutyPerson) {
        this.workTaskDutyPerson = workTaskDutyPerson;
    }

    public String getWorkTaskDutyLeader() {
        return workTaskDutyLeader;
    }

    public void setWorkTaskDutyLeader(String workTaskDutyLeader) {
        this.workTaskDutyLeader = workTaskDutyLeader;
    }

    public String getWcsx() {
        return wcsx;
    }

    public void setWcsx(String wcsx) {
        this.wcsx = wcsx;
    }
}
