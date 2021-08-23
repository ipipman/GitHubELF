package cn.stylefeng.guns.modular.timers.mapper;

import cn.stylefeng.guns.modular.job.entity.User;
import cn.stylefeng.guns.modular.timers.entity.Timers;
import cn.stylefeng.guns.modular.timers.model.params.TimersParam;
import cn.stylefeng.guns.modular.timers.model.result.TimersResult;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 定时任务 Mapper 接口
 * </p>
 *
 * @author ipman
 * @since 2021-08-16
 */
public interface TimersMapper extends BaseMapper<Timers> {

    /**
     * 获取列表
     *
     * @author ipman
     * @Date 2021-08-16
     */
    List<TimersResult> customList(@Param("paramCondition") TimersParam paramCondition);

    /**
     * 获取map列表
     *
     * @author ipman
     * @Date 2021-08-16
     */
    List<Map<String, Object>> customMapList(@Param("paramCondition") TimersParam paramCondition);

    /**
     * 获取分页实体列表
     *
     * @author ipman
     * @Date 2021-08-16
     */
    Page<TimersResult> customPageList(@Param("page") Page page, @Param("paramCondition") TimersParam paramCondition);

    /**
     * 获取分页map列表
     *
     * @author ipman
     * @Date 2021-08-16
     */
    Page<Map<String, Object>> customPageMapList(@Param("page") Page page, @Param("paramCondition") TimersParam paramCondition);

}
