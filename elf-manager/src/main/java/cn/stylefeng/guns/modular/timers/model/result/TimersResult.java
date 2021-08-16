package cn.stylefeng.guns.modular.timers.model.result;

import lombok.Data;
import java.util.Date;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * <p>
 * 定时任务
 * </p>
 *
 * @author ipman
 * @since 2021-08-16
 */
@Data
public class TimersResult implements Serializable {

    private static final long serialVersionUID = 1L;


    /**
     * 定时器id
     */
    private Long timerId;

    /**
     * 任务名称
     */
    private String timerName;

    /**
     * 执行任务的class的类名（实现了TimerAction接口的类的全称）
     */
    private String actionClass;

    /**
     * 定时任务表达式
     */
    private String cron;

    /**
     * 参数
     */
    private String params;

    /**
     * 状态：1-运行，2-停止
     */
    private Integer jobStatus;

    /**
     * 备注信息
     */
    private String remark;

    /**
     * 是否删除：Y-被删除，N-未删除
     */
    private String delFlag;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 创建人
     */
    private Long createUser;

    /**
     * 修改时间
     */
    private Date updateTime;

    /**
     * 修改人
     */
    private Long updateUser;

}
