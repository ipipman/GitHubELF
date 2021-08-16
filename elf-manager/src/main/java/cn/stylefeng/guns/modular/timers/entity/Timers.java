package cn.stylefeng.guns.modular.timers.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 定时任务
 * </p>
 *
 * @author ipman
 * @since 2021-08-16
 */
@TableName("sys_timers")
public class Timers implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 定时器id
     */
    @TableId(value = "timer_id", type = IdType.ID_WORKER)
    private Long timerId;

    /**
     * 任务名称
     */
    @TableField("timer_name")
    private String timerName;

    /**
     * 执行任务的class的类名（实现了TimerAction接口的类的全称）
     */
    @TableField("action_class")
    private String actionClass;

    /**
     * 定时任务表达式
     */
    @TableField("cron")
    private String cron;

    /**
     * 参数
     */
    @TableField("params")
    private String params;

    /**
     * 状态：1-运行，2-停止
     */
    @TableField("job_status")
    private Integer jobStatus;

    /**
     * 备注信息
     */
    @TableField("remark")
    private String remark;

    /**
     * 是否删除：Y-被删除，N-未删除
     */
    @TableField("del_flag")
    private String delFlag;

    /**
     * 创建时间
     */
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 创建人
     */
    @TableField(value = "create_user", fill = FieldFill.INSERT)
    private Long createUser;

    /**
     * 修改时间
     */
    @TableField(value = "update_time", fill = FieldFill.UPDATE)
    private Date updateTime;

    /**
     * 修改人
     */
    @TableField(value = "update_user", fill = FieldFill.UPDATE)
    private Long updateUser;


    public Long getTimerId() {
        return timerId;
    }

    public void setTimerId(Long timerId) {
        this.timerId = timerId;
    }

    public String getTimerName() {
        return timerName;
    }

    public void setTimerName(String timerName) {
        this.timerName = timerName;
    }

    public String getActionClass() {
        return actionClass;
    }

    public void setActionClass(String actionClass) {
        this.actionClass = actionClass;
    }

    public String getCron() {
        return cron;
    }

    public void setCron(String cron) {
        this.cron = cron;
    }

    public String getParams() {
        return params;
    }

    public void setParams(String params) {
        this.params = params;
    }

    public Integer getJobStatus() {
        return jobStatus;
    }

    public void setJobStatus(Integer jobStatus) {
        this.jobStatus = jobStatus;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Long createUser) {
        this.createUser = createUser;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Long getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(Long updateUser) {
        this.updateUser = updateUser;
    }

    @Override
    public String toString() {
        return "Timers{" +
        "timerId=" + timerId +
        ", timerName=" + timerName +
        ", actionClass=" + actionClass +
        ", cron=" + cron +
        ", params=" + params +
        ", jobStatus=" + jobStatus +
        ", remark=" + remark +
        ", delFlag=" + delFlag +
        ", createTime=" + createTime +
        ", createUser=" + createUser +
        ", updateTime=" + updateTime +
        ", updateUser=" + updateUser +
        "}";
    }
}
