package cn.stylefeng.guns.modular.job.mapper;

import cn.stylefeng.guns.modular.job.entity.User;
import cn.stylefeng.guns.modular.job.model.params.UserParam;
import cn.stylefeng.guns.modular.job.model.result.UserResult;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ipman
 * @since 2021-08-23
 */
public interface GitHubUserMapper extends BaseMapper<User> {

    /**
     * 获取列表
     *
     * @author ipman
     * @Date 2021-08-23
     */
    List<UserResult> customList(@Param("paramCondition") UserParam paramCondition);

    /**
     * 获取map列表
     *
     * @author ipman
     * @Date 2021-08-23
     */
    List<Map<String, Object>> customMapList(@Param("paramCondition") UserParam paramCondition);

    /**
     * 获取分页实体列表
     *
     * @author ipman
     * @Date 2021-08-23
     */
    Page<UserResult> customPageList(@Param("page") Page page, @Param("paramCondition") UserParam paramCondition);

    /**
     * 获取分页map列表
     *
     * @author ipman
     * @Date 2021-08-23
     */
    Page<Map<String, Object>> customPageMapList(@Param("page") Page page, @Param("paramCondition") UserParam paramCondition);


    void insertUsers(@Param("userList") List<User> userList);
}
