package cn.stylefeng.guns.modular.job.service;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.job.entity.User;
import cn.stylefeng.guns.modular.job.model.params.UserParam;
import cn.stylefeng.guns.modular.job.model.result.UserResult;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ipman
 * @since 2021-08-23
 */
public interface UserService extends IService<User> {

    /**
     * 新增
     *
     * @author ipman
     * @Date 2021-08-23
     */
    void add(UserParam param);

    /**
     * 删除
     *
     * @author ipman
     * @Date 2021-08-23
     */
    void delete(UserParam param);

    /**
     * 更新
     *
     * @author ipman
     * @Date 2021-08-23
     */
    void update(UserParam param);

    /**
     * 查询单条数据，Specification模式
     *
     * @author ipman
     * @Date 2021-08-23
     */
    UserResult findBySpec(UserParam param);

    /**
     * 查询列表，Specification模式
     *
     * @author ipman
     * @Date 2021-08-23
     */
    List<UserResult> findListBySpec(UserParam param);

    /**
     * 查询分页数据，Specification模式
     *
     * @author ipman
     * @Date 2021-08-23
     */
     LayuiPageInfo findPageBySpec(UserParam param);

}
