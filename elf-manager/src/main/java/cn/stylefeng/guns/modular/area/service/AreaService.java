package cn.stylefeng.guns.modular.area.service;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.area.entity.Area;
import cn.stylefeng.guns.modular.area.model.params.AreaParam;
import cn.stylefeng.guns.modular.area.model.result.AreaResult;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ipman
 * @since 2021-08-15
 */
public interface AreaService extends IService<Area> {

    /**
     * 新增
     *
     * @author ipman
     * @Date 2021-08-15
     */
    void add(AreaParam param);

    /**
     * 删除
     *
     * @author ipman
     * @Date 2021-08-15
     */
    void delete(AreaParam param);

    /**
     * 更新
     *
     * @author ipman
     * @Date 2021-08-15
     */
    void update(AreaParam param);

    /**
     * 查询单条数据，Specification模式
     *
     * @author ipman
     * @Date 2021-08-15
     */
    AreaResult findBySpec(AreaParam param);

    /**
     * 查询列表，Specification模式
     *
     * @author ipman
     * @Date 2021-08-15
     */
    List<AreaResult> findListBySpec(AreaParam param);

    /**
     * 查询分页数据，Specification模式
     *
     * @author ipman
     * @Date 2021-08-15
     */
     LayuiPageInfo findPageBySpec(AreaParam param);

}
