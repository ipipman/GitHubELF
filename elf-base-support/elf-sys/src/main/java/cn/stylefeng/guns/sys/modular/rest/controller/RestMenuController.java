/**
 * Copyright 2018-2020 stylefeng & fengshuonan (https://gitee.com/stylefeng)
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package cn.stylefeng.guns.sys.modular.rest.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.stylefeng.guns.base.log.BussinessLog;
import cn.stylefeng.guns.base.pojo.node.ZTreeNode;
import cn.stylefeng.guns.base.pojo.page.LayuiPageFactory;
import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.sys.core.constant.dictmap.DeleteDict;
import cn.stylefeng.guns.sys.core.constant.dictmap.MenuDict;
import cn.stylefeng.guns.sys.core.constant.factory.ConstantFactory;
import cn.stylefeng.guns.sys.core.exception.enums.BizExceptionEnum;
import cn.stylefeng.guns.sys.core.log.LogObjectHolder;
import cn.stylefeng.guns.sys.modular.rest.entity.RestMenu;
import cn.stylefeng.guns.sys.modular.rest.factory.MenuFactory;
import cn.stylefeng.guns.sys.modular.rest.model.MenuTreeNode;
import cn.stylefeng.guns.sys.modular.rest.service.RestMenuService;
import cn.stylefeng.guns.sys.modular.rest.service.RestUserService;
import cn.stylefeng.guns.sys.modular.system.model.MenuDto;
import cn.stylefeng.guns.sys.modular.system.warpper.MenuWrapper;
import cn.stylefeng.roses.core.base.controller.BaseController;
import cn.stylefeng.roses.core.reqres.response.ResponseData;
import cn.stylefeng.roses.core.util.ToolUtil;
import cn.stylefeng.roses.kernel.model.exception.ServiceException;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * ???????????????
 *
 * @author fengshuonan
 * @Date 2017???2???12???21:59:14
 */
@RestController
@RequestMapping("/rest/menu")
public class RestMenuController extends BaseController {

    @Autowired
    private RestMenuService restMenuService;

    @Autowired
    private RestUserService restUserService;

    /**
     * ????????????
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:53 PM
     */
    @RequestMapping(value = "/edit")
    @BussinessLog(value = "????????????", key = "name", dict = MenuDict.class)
    public ResponseData edit(MenuDto menu) {

        //????????????????????????????????????????????????????????????????????????
        this.restMenuService.updateMenu(menu);

        //????????????????????????
        this.restUserService.refreshCurrentUser();

        return SUCCESS_TIP;
    }

    /**
     * ??????????????????
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:53 PM
     */
    @RequestMapping(value = "/list")
    public LayuiPageInfo list(@RequestParam(required = false) String menuName,
                              @RequestParam(required = false) String level,
                              @RequestParam(required = false) Long menuId) {
        Page<Map<String, Object>> menus = this.restMenuService.selectMenus(menuName, level, menuId);
        Page<Map<String, Object>> wrap = new MenuWrapper(menus).wrap();
        return LayuiPageFactory.createPageInfo(wrap);
    }

    /**
     * ??????????????????????????????
     *
     * @author fengshuonan
     * @Date 2019???2???23???22:01:47
     */
    @RequestMapping(value = "/listTree")
    public LayuiPageInfo listTree(@RequestParam(required = false) String menuName,
                                  @RequestParam(required = false) String level) {
        List<Map<String, Object>> menus = this.restMenuService.selectMenuTree(menuName, level);
        List<Map<String, Object>> menusWrap = new MenuWrapper(menus).wrap();

        //?????????
        List<MenuTreeNode> menuTreeNodes = MenuFactory.buildTreeNodes(menusWrap);

        LayuiPageInfo result = new LayuiPageInfo();
        result.setData(menuTreeNodes);
        return result;
    }

    /**
     * ????????????
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:53 PM
     */
    @RequestMapping(value = "/add")
    @BussinessLog(value = "????????????", key = "name", dict = MenuDict.class)
    public ResponseData add(MenuDto menu) {
        this.restMenuService.addMenu(menu);
        return SUCCESS_TIP;
    }

    /**
     * ????????????
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:53 PM
     */
    @RequestMapping(value = "/remove")
    @BussinessLog(value = "????????????", key = "menuId", dict = DeleteDict.class)
    public ResponseData remove(@RequestParam Long menuId) {
        if (ToolUtil.isEmpty(menuId)) {
            throw new ServiceException(BizExceptionEnum.REQUEST_NULL);
        }

        //?????????????????????
        LogObjectHolder.me().set(ConstantFactory.me().getMenuName(menuId));

        this.restMenuService.delMenuContainSubMenus(menuId);

        return SUCCESS_TIP;
    }

    /**
     * ????????????
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:53 PM
     */
    @RequestMapping(value = "/view/{menuId}")
    public ResponseData view(@PathVariable Long menuId) {
        if (ToolUtil.isEmpty(menuId)) {
            throw new ServiceException(BizExceptionEnum.REQUEST_NULL);
        }
        RestMenu menu = this.restMenuService.getById(menuId);
        return ResponseData.success(menu);
    }

    /**
     * ??????????????????
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:53 PM
     */
    @RequestMapping(value = "/getMenuInfo")
    public ResponseData getMenuInfo(@RequestParam Long menuId) {
        if (ToolUtil.isEmpty(menuId)) {
            throw new ServiceException(BizExceptionEnum.REQUEST_NULL);
        }

        RestMenu menu = this.restMenuService.getById(menuId);

        MenuDto menuDto = new MenuDto();
        BeanUtil.copyProperties(menu, menuDto);

        //??????pid???????????????
        menuDto.setPid(ConstantFactory.me().getMenuIdByCode(menuDto.getPcode()));
        menuDto.setPcodeName(ConstantFactory.me().getMenuNameByCode(menuDto.getPcode()));

        return ResponseData.success(menuDto);
    }

    /**
     * ??????????????????(?????????)
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:54 PM
     */
    @RequestMapping(value = "/menuTreeList")
    public List<ZTreeNode> menuTreeList() {
        return this.restMenuService.menuTreeList();
    }

    /**
     * ??????????????????(?????????????????????)
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:54 PM
     */
    @RequestMapping(value = "/selectMenuTreeList")
    public List<ZTreeNode> selectMenuTreeList() {
        List<ZTreeNode> roleTreeList = this.restMenuService.menuTreeList();
        roleTreeList.add(ZTreeNode.createParent());
        return roleTreeList;
    }

    /**
     * ???????????????????????????
     *
     * @author fengshuonan
     * @Date 2018/12/23 5:54 PM
     */
    @RequestMapping(value = "/menuTreeListByRoleId/{roleId}")
    public List<ZTreeNode> menuTreeListByRoleId(@PathVariable Long roleId) {
        List<Long> menuIds = this.restMenuService.getMenuIdsByRoleId(roleId);
        if (ToolUtil.isEmpty(menuIds)) {
            return this.restMenuService.menuTreeList();
        } else {
            return this.restMenuService.menuTreeListByMenuIds(menuIds);
        }
    }

}
