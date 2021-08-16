package cn.stylefeng.guns.modular.timers.service;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.timers.entity.Timers;
import cn.stylefeng.guns.modular.timers.model.params.TimersParam;
import cn.stylefeng.guns.modular.timers.model.result.TimersResult;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 定时任务 服务类
 * </p>
 *
 * @author ipman
 * @since 2021-08-16
 */
public interface TimersService extends IService<Timers> {

    /**
     * 新增
     *
     * @author ipman
     * @Date 2021-08-16
     */
    void add(TimersParam param);

    /**
     * 删除
     *
     * @author ipman
     * @Date 2021-08-16
     */
    void delete(TimersParam param);

    /**
     * 更新
     *
     * @author ipman
     * @Date 2021-08-16
     */
    void update(TimersParam param);

    /**
     * 查询单条数据，Specification模式
     *
     * @author ipman
     * @Date 2021-08-16
     */
    TimersResult findBySpec(TimersParam param);

    /**
     * 查询列表，Specification模式
     *
     * @author ipman
     * @Date 2021-08-16
     */
    List<TimersResult> findListBySpec(TimersParam param);

    /**
     * 查询分页数据，Specification模式
     *
     * @author ipman
     * @Date 2021-08-16
     */
     LayuiPageInfo findPageBySpec(TimersParam param);

}
