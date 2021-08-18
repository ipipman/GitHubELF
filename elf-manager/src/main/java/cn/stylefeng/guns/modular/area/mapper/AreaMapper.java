package cn.stylefeng.guns.modular.area.mapper;

import cn.stylefeng.guns.modular.area.entity.Area;
import cn.stylefeng.guns.modular.area.model.params.AreaParam;
import cn.stylefeng.guns.modular.area.model.result.AreaResult;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author ipman
 * @since 2021-08-15
 */
public interface AreaMapper extends BaseMapper<Area> {

    /**
     * 获取列表
     *
     * @author ipman
     * @Date 2021-08-15
     */
    List<AreaResult> customList(@Param("paramCondition") AreaParam paramCondition);

    /**
     * 获取map列表
     *
     * @author ipman
     * @Date 2021-08-15
     */
    List<Map<String, Object>> customMapList(@Param("paramCondition") AreaParam paramCondition);

    /**
     * 获取分页实体列表
     *
     * @author ipman
     * @Date 2021-08-15
     */
    Page<AreaResult> customPageList(@Param("page") Page page, @Param("paramCondition") AreaParam paramCondition);

    /**
     * 获取分页map列表
     *
     * @author ipman
     * @Date 2021-08-15
     */
    Page<Map<String, Object>> customPageMapList(@Param("page") Page page, @Param("paramCondition") AreaParam paramCondition);

    List<Area> selectAreaListByLevel(@Param("level") Integer level);

}
