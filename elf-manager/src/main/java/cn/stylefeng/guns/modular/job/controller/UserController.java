package cn.stylefeng.guns.modular.job.controller;

import cn.stylefeng.guns.base.pojo.page.LayuiPageInfo;
import cn.stylefeng.guns.modular.job.entity.User;
import cn.stylefeng.guns.modular.job.model.params.UserParam;
import cn.stylefeng.guns.modular.job.service.UserService;
import cn.stylefeng.roses.core.base.controller.BaseController;
import cn.stylefeng.roses.core.reqres.response.ResponseData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 控制器
 *
 * @author ipman
 * @Date 2021-08-23 15:05:00
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    private String PREFIX = "/user";

    @Autowired
    private UserService userService;

    /**
     * 跳转到主页面
     *
     * @author ipman
     * @Date 2021-08-23
     */
    @RequestMapping("")
    public String index() {
        return PREFIX + "/user.html";
    }

    /**
     * 新增页面
     *
     * @author ipman
     * @Date 2021-08-23
     */
    @RequestMapping("/add")
    public String add() {
        return PREFIX + "/user_add.html";
    }

    /**
     * 编辑页面
     *
     * @author ipman
     * @Date 2021-08-23
     */
    @RequestMapping("/edit")
    public String edit() {
        return PREFIX + "/user_edit.html";
    }

    /**
     * 新增接口
     *
     * @author ipman
     * @Date 2021-08-23
     */
    @RequestMapping("/addItem")
    @ResponseBody
    public ResponseData addItem(UserParam userParam) {
        this.userService.add(userParam);
        return ResponseData.success();
    }

    /**
     * 编辑接口
     *
     * @author ipman
     * @Date 2021-08-23
     */
    @RequestMapping("/editItem")
    @ResponseBody
    public ResponseData editItem(UserParam userParam) {
        this.userService.update(userParam);
        return ResponseData.success();
    }

    /**
     * 删除接口
     *
     * @author ipman
     * @Date 2021-08-23
     */
    @RequestMapping("/delete")
    @ResponseBody
    public ResponseData delete(UserParam userParam) {
        this.userService.delete(userParam);
        return ResponseData.success();
    }

    /**
     * 查看详情接口
     *
     * @author ipman
     * @Date 2021-08-23
     */
    @RequestMapping("/detail")
    @ResponseBody
    public ResponseData detail(UserParam userParam) {
        User detail = this.userService.getById(userParam.getUserId());
        return ResponseData.success(detail);
    }

    /**
     * 查询列表
     *
     * @author ipman
     * @Date 2021-08-23
     */
    @ResponseBody
    @RequestMapping("/list")
    public LayuiPageInfo list(UserParam userParam) {
        return this.userService.findPageBySpec(userParam);
    }

}


