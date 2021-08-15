package cn.stylefeng.guns.modular.area.service.impl;

import cn.stylefeng.guns.base.pojo.page.LayuiPageFactory;
import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.area.entity.Area;
import cn.stylefeng.guns.modular.area.mapper.AreaMapper;
import cn.stylefeng.guns.modular.area.model.params.AreaParam;
import cn.stylefeng.guns.modular.area.model.result.AreaResult;
import  cn.stylefeng.guns.modular.area.service.AreaService;
import cn.stylefeng.roses.core.util.ToolUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ipman
 * @since 2021-08-15
 */
@Service
public class AreaServiceImpl extends ServiceImpl<AreaMapper, Area> implements AreaService {

    @Override
    public void add(AreaParam param){
        Area entity = getEntity(param);
        this.save(entity);
    }

    @Override
    public void delete(AreaParam param){
        this.removeById(getKey(param));
    }

    @Override
    public void update(AreaParam param){
        Area oldEntity = getOldEntity(param);
        Area newEntity = getEntity(param);
        ToolUtil.copyProperties(newEntity, oldEntity);
        this.updateById(newEntity);
    }

    @Override
    public AreaResult findBySpec(AreaParam param){
        return null;
    }

    @Override
    public List<AreaResult> findListBySpec(AreaParam param){
        return null;
    }

    @Override
    public LayuiPageInfo findPageBySpec(AreaParam param){
        Page pageContext = getPageContext();
        IPage page = this.baseMapper.customPageList(pageContext, param);
        return LayuiPageFactory.createPageInfo(page);
    }

    private Serializable getKey(AreaParam param){
        return param.getId();
    }

    private Page getPageContext() {
        return LayuiPageFactory.defaultPage();
    }

    private Area getOldEntity(AreaParam param) {
        return this.getById(getKey(param));
    }

    private Area getEntity(AreaParam param) {
        Area entity = new Area();
        ToolUtil.copyProperties(param, entity);
        return entity;
    }

}
