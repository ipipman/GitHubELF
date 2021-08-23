package cn.stylefeng.guns.modular.job.service.impl;

import cn.stylefeng.guns.base.pojo.page.LayuiPageFactory;
import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.job.entity.User;
import cn.stylefeng.guns.modular.job.mapper.GitHubUserMapper;
import cn.stylefeng.guns.modular.job.model.params.UserParam;
import cn.stylefeng.guns.modular.job.model.result.UserResult;
import  cn.stylefeng.guns.modular.job.service.UserService;
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
 * @since 2021-08-23
 */
@Service
public class UserServiceImpl extends ServiceImpl<GitHubUserMapper, User> implements UserService {

    @Override
    public void add(UserParam param){
        User entity = getEntity(param);
        this.save(entity);
    }

    @Override
    public void delete(UserParam param){
        this.removeById(getKey(param));
    }

    @Override
    public void update(UserParam param){
        User oldEntity = getOldEntity(param);
        User newEntity = getEntity(param);
        ToolUtil.copyProperties(newEntity, oldEntity);
        this.updateById(newEntity);
    }

    @Override
    public UserResult findBySpec(UserParam param){
        return null;
    }

    @Override
    public List<UserResult> findListBySpec(UserParam param){
        return null;
    }

    @Override
    public LayuiPageInfo findPageBySpec(UserParam param){
        Page pageContext = getPageContext();
        IPage page = this.baseMapper.customPageList(pageContext, param);
        return LayuiPageFactory.createPageInfo(page);
    }

    private Serializable getKey(UserParam param){
        return param.getUserId();
    }

    private Page getPageContext() {
        return LayuiPageFactory.defaultPage();
    }

    private User getOldEntity(UserParam param) {
        return this.getById(getKey(param));
    }

    private User getEntity(UserParam param) {
        User entity = new User();
        ToolUtil.copyProperties(param, entity);
        return entity;
    }

}
