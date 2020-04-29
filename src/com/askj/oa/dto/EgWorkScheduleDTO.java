package com.askj.oa.dto;


import java.util.Date;

/**
 * Created by Administrator on 2018/4/16.
 */
public class EgWorkScheduleDTO {
    /** workScheduleId 的中文含义是：工作进度id*/
    private String workScheduleId;
    /** work_task_id 的中文含义是：工作任务id*/
    private String workTaskId;
    /** work_schedule_month 的中文含义是：工作进度月份*/
    private Date workScheduleMonth;
    /** work_schedule_describe 的中文含义是：工作进度描述*/
    private String workScheduleDescribe;
    /** work_schedule_percent 的中文含义是：工作进度百分比*/
    private Integer workSchedulePercent;
    /** work_schedule_confirm 的中文含义是： /** course_name 的中文含义是：办公室是否确认(''0''代表未确认,''1''代表已确认*/
    private String workScheduleConfirm;
    private String op;

    public String getWorkScheduleConfirm() {
        return workScheduleConfirm;
    }

    public void setWorkScheduleConfirm(String workScheduleConfirm) {
        this.workScheduleConfirm = workScheduleConfirm;
    }

    public String getWorkScheduleId() {
        return workScheduleId;
    }

    public void setWorkScheduleId(String workScheduleId) {
        this.workScheduleId = workScheduleId;
    }

    public String getWorkTaskId() {
        return workTaskId;
    }

    public void setWorkTaskId(String workTaskId) {
        this.workTaskId = workTaskId;
    }

    public Date getWorkScheduleMonth() {
        return workScheduleMonth;
    }

    public void setWorkScheduleMonth(Date workScheduleMonth) {
        this.workScheduleMonth = workScheduleMonth;
    }

    public String getWorkScheduleDescribe() {
        return workScheduleDescribe;
    }

    public void setWorkScheduleDescribe(String workScheduleDescribe) {
        this.workScheduleDescribe = workScheduleDescribe;
    }

    public Integer getWorkSchedulePercent() {
        return workSchedulePercent;
    }

    public void setWorkSchedulePercent(Integer workSchedulePercent) {
        this.workSchedulePercent = workSchedulePercent;
    }

    public String getOp() {
        return op;
    }

    public void setOp(String op) {
        this.op = op;
    }
}
