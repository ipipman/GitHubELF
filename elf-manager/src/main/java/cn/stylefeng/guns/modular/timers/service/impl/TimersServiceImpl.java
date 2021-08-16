package cn.stylefeng.guns.modular.timers.service.impl;

import cn.stylefeng.guns.base.pojo.page.LayuiPageFactory;
import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.timers.entity.Timers;
import cn.stylefeng.guns.modular.timers.mapper.TimersMapper;
import cn.stylefeng.guns.modular.timers.model.params.TimersParam;
import cn.stylefeng.guns.modular.timers.model.result.TimersResult;
import  cn.stylefeng.guns.modular.timers.service.TimersService;
import cn.stylefeng.roses.core.util.ToolUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 定时任务 服务实现类
 * </p>
 *
 * @author ipman
 * @since 2021-08-16
 */
@Service
public class TimersServiceImpl extends ServiceImpl<TimersMapper, Timers> implements TimersService {

    @Override
    public void add(TimersParam param){
        Timers entity = getEntity(param);
        this.save(entity);
    }

    @Override
    public void delete(TimersParam param){
        this.removeById(getKey(param));
    }

    @Override
    public void update(TimersParam param){
        Timers oldEntity = getOldEntity(param);
        Timers newEntity = getEntity(param);
        ToolUtil.copyProperties(newEntity, oldEntity);
        this.updateById(newEntity);
    }

    @Override
    public TimersResult findBySpec(TimersParam param){
        return null;
    }

    @Override
    public List<TimersResult> findListBySpec(TimersParam param){
        return null;
    }

    @Override
    public LayuiPageInfo findPageBySpec(TimersParam param){
        Page pageContext = getPageContext();
        IPage page = this.baseMapper.customPageList(pageContext, param);
        return LayuiPageFactory.createPageInfo(page);
    }

    private Serializable getKey(TimersParam param){
        return param.getTimerId();
    }

    private Page getPageContext() {
        return LayuiPageFactory.defaultPage();
    }

    private Timers getOldEntity(TimersParam param) {
        return this.getById(getKey(param));
    }

    private Timers getEntity(TimersParam param) {
        Timers entity = new Timers();
        ToolUtil.copyProperties(param, entity);
        return entity;
    }

}
